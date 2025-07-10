RegisterNetEvent('killnotify:showNotification')
AddEventHandler('killnotify:showNotification', function(data)
    local actionText = data.type == 'success' and 'You Killed' or 'You were killed by'
    local message = ('%s %s (ID: %d) - %.1f meters'):format(
        actionText,
        data.name,
        data.id,
        data.distance
    )

    lib.notify({
        description = message,
        type = data.type or 'inform',
        position = 'bottom', --'top' or 'top-right' or 'top-left' or 'bottom' or 'bottom-right' or 'bottom-left' or 'center-right' or 'center-left'
        duration = 3000,
        icon = 'gun'
    })
end)

-- Monitor player deaths
CreateThread(function()
    while true do
        Wait(0)
        local playerPed = PlayerPedId()

        if IsEntityDead(playerPed) then
            local killer = GetPedSourceOfDeath(playerPed)
            if killer and IsPedAPlayer(killer) then
                local killerId = NetworkGetPlayerIndexFromPed(killer)
                if killerId ~= -1 then
                    local killerServerId = GetPlayerServerId(killerId)
                    local myCoords = GetEntityCoords(playerPed)
                    local killerCoords = GetEntityCoords(killer)
                    local dist = #(myCoords - killerCoords)

                    TriggerServerEvent('killnotify:playerDied', killerServerId, dist)
                end
            end

            while IsEntityDead(PlayerPedId()) do Wait(500) end
        end
    end
end)