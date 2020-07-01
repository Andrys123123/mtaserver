
addCommandHandler('setrank', function(player, command, account, group) 
    if not account or not group then 
        return outputChatBox('SYNTAX/'..command..' [account] [group]', player, 255, 255, 255)
    end 

    local accountObj = getAccount(account)
    if not accountObj then 
        return outputChatBox('The specified account does not exist.', player, 255, 100, 100)
    end 

    local groupObj = aclGetGroup(group)
    if not groupObj then 
        return outputChatBox('The specified group does not exist.', player, 255, 100, 100)
    end 

    local objectStr = 'user.' .. account 

    local groups = aclGroupList()
    for _, removalGroup in pairs(groups) do 
        aclGroupRemoveObject(removalGroup, objectStr)
    end 

    if group == 'Everyone' then 
        return outputChatBox('Successfully removed account ' .. account .. ' from all groups.', player, 100, 255, 100)
    end 

    aclGroupAddObject(groupObj, objectStr)

    outputChatBox('Successfully added account '..account..' to the group.',player, 100, 255, 100)

end)

addCommandHandler('setaclright', function(player, account, acl, right, access) 
    if not acl or not right or not access then 
        return outputChatBox('SINTAX: /' .. command .. '[acl] [right] [access]', player, 255, 255, 255)
    end 

    local aclObj = aclGet(acl)
    if not aclObj then 
        return outputChatBox('The specified ACL does not exist.', player, 255, 100, 100)
    end 

    local accessTypes = {['true'] = true, ['false'] = false}
    local accessBoolean = accessTypes[string.lower(access)]
    if accessBoolean == nil then 
        return outputChatBox('ACL Access must be either TRUE or FALSE.', player, 255, 100, 100)
    end 

    aclSetRight(aclObj, right, accessBoolean)
    aclSave()


    outputChatBox('Successfully updated the ACL right.', player, 100, 255, 100)



end, true, false)