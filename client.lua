local reviveCoords = vector3(-1831.6582, -379.8422, 49.4039) -- Coordonnées du point
local reviveDistance = 2.0
local isInMarker = false
local shownInteract = false

Citizen.CreateThread(function()
    while true do
        Wait(30000)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local distance = #(playerCoords - reviveCoords)

        if distance < 10.0 then
            DrawMarker(1, reviveCoords.x, reviveCoords.y, reviveCoords.z - 1.0, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 0, 102, 255, 150, false, true, 2, false, nil, nil, false)
            Draw3DText(reviveCoords.x, reviveCoords.y, reviveCoords.z + 1.0, "~b~Menu Soins")
        end

        if distance < reviveDistance then
            if not isInMarker then
                isInMarker = true
                if not shownInteract then
                    shownInteract = true
                    TriggerEvent('okokNotify:Alert', "Interaction", "Appuyez sur [E] pour ouvrir le menu", 5000, 'info')
                end
            end

            if IsControlJustReleased(0, 38) then -- E
                OpenReviveMenu()
            end
        else
            if isInMarker then
                isInMarker = false
            end
            shownInteract = false
        end
    end
end)

function OpenReviveMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'revive_menu', {
        title = 'Menu de Réanimation',
        align = 'top-left',
        elements = {
            {label = 'Se réanimer', value = 'revive'}
        }
    }, function(data, menu)
        if data.current.value == 'revive' then
            TriggerServerEvent('custom_revive:checkEMS')
            menu.close()
        end
    end, function(data, menu)
        menu.close()
    end)
end

RegisterNetEvent('custom_revive:revivePlayer')
AddEventHandler('custom_revive:revivePlayer', function()
    local playerPed = PlayerPedId()
    ESX.TriggerServerCallback('esx_ambulancejob:revive', function() end, GetPlayerServerId(PlayerId()))
    SetEntityHealth(playerPed, 200)
    TriggerEvent('okokNotify:Alert', "Réanimation", "Vous avez été réanimé", 5000, 'success')
end)

RegisterNetEvent('custom_revive:noEMS')
AddEventHandler('custom_revive:noEMS', function()
    TriggerEvent('okokNotify:Alert', "Réanimation", "Il y a des secours en ville, impossible de vous soigner", 5000, 'error')
end)

-- Fonction 3D Text
function Draw3DText(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoords())
    local scale = 0.35

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x, _y)
        local factor = (string.len(text)) / 370
        DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 0, 0, 0, 75)
    end
end
