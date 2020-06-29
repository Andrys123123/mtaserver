local MINIMUM_PASSWORD_LENGTH = 6


local function isPasswordValid(password)
    return string.len(password) >= MINIMUM_PASSWORD_LENGTH
end


-- create account
addCommandHandler('accregister', function (player, command, username, password) 
    if not username or not password then
        return outputChatBox('SYNTAX: /' .. command .. ' [username] [password]', player, 255, 255, 255)
    end
    
    --cehck if an account with that username is already exist
    if getAccount(username) then
        return outputChatBox('An account already exists with that name', player, 255, 100, 100)
    end



    -- is this password valid
    if not isPasswordValid('password') then 
        return outputChatBox('The passoword not valid', player, 255, 100, 100)
    end 


    -- create a hash of the password
    passwordHash(password, 'bcrypt', {}, function (hashedPassword) 
        -- create account
        local account = addAccount(username, hashedPassword)
        setAccountData(account, 'hashed_password', hashedPassword)
        
        -- let the user know of  our succes
        outputChatBox('Your account has been succesfully created! You may now login with /acclogin', player, 100, 255, 100)
    
    end)
end, false, false)



--login to their account
addCommandHandler('acclogin', function (player, command, username, password)
    if not username or not password then
        return outputChatBox('SYNTAX: /' .. command .. ' [username] [password]', player, 255, 255, 255)
    end

    local account = getAccount(username)

    if not account then
        return outputChatBox('No such account could be found with that username or password.', player, 255, 100, 100)
    end 


    local hashedPassword = getAccountData(account, 'hashed_password')
    passwordVerify(password, hashedPassword, function(isValid) 
        if not isValid then 
            return outputChatBox('No such account could be found with that username or password.', player, 255, 100, 100)
        end

        if logIn(player, account, hashedPassword) then 
            return outputChatBox('Yuo have succesfully logged in!', player, 100, 255, 100)
        end
        
        return outputChatBox('An unknown error occuered while attempting to authenticate', player, 255, 100, 100)

    end)

end, false, false)

--logout

addCommandHandler('acclogout', function (player, command) 
    logOut(player)
    outputChatBox('Succesfully logged out.', player, 100, 255, 100)
end)

