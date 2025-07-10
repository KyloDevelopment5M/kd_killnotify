RegisterServerEvent('killnotify:playerDied')
AddEventHandler('killnotify:playerDied', function(killerId, distance)
    local victimId = source

    if not killerId or not victimId then return end
    if killerId == victimId then return end

    local killerName = GetPlayerName(killerId)
    local victimName = GetPlayerName(victimId)

-- Notify killer
TriggerClientEvent('killnotify:showNotification', killerId, {
    name = victimName,
    id = victimId,
    distance = distance,
    type = 'success'
})

-- Notify victim
TriggerClientEvent('killnotify:showNotification', victimId, {
    name = killerName,
    id = killerId,
    distance = distance,
    type = 'error'
})

end)
