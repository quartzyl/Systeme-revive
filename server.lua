ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('custom_revive:checkEMS')
AddEventHandler('custom_revive:checkEMS', function()
    local emsConnected = 0
    local samuPlayers = ESX.GetExtendedPlayers('job', 'samu')
    local pompierPlayers = ESX.GetExtendedPlayers('job', 'pompier')

    emsConnected = #samuPlayers + #pompierPlayers

    if emsConnected == 0 then
        TriggerClientEvent('custom_revive:revivePlayer', source)
    else
        TriggerClientEvent('custom_revive:noEMS', source)
    end
end)
