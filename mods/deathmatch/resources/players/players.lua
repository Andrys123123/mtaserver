

setTime(12,0)
setMinuteDuration(10000000000)

addCommandHandler('clearchat', function(player) 
    for i = 1, 30 do 
        outputChatBox(' ', player)
    end 
end, false, false)

addEventHandler('onPlayerJoin', root, function() 
    triggerClientEvent(source, 'login-menu:open', source)
end)