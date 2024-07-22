ESX = exports['es_extended']:getSharedObject()



RegisterNetEvent("zsepy:ui:show", (function()
    SendNUIMessage({
        type = "togglehud",
        value = false
    })
end))

RegisterNetEvent("zsepy:ui:hide", (function()
    SendNUIMessage({
        type = "togglehud",
        value = true
    })
end))

Citizen.CreateThread(function()
    local sleep = 1500
    while not ESX.PlayerData do
        Wait(10)
    end
    while true do
        local myped = PlayerPedId()
        local health = GetEntityHealth(myped)
        local armor = GetPedArmour(myped)
        local hunger = 0
        local thirst = 0
        local energy = 0
        local money = ESX.PlayerData.money
        local job = GetPlayerPing
        if ESX.PlayerData.dead then
            sleep = 150
        else
            sleep = 150
        end
        TriggerEvent('esx_status:getStatus', 'hunger', function(data)
            hunger = data.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'thirst', function(data)
            thirst = data.getPercent()
        end)
        TriggerEvent('esx_status:getStatus', 'energy', function(data)
            energy = data.getPercent()
        end)
        ESX.TriggerServerCallback('getdata', function(data)
            SendNUIMessage({ 
                type = 'updateHUD',
                health = health -100,
                armor = armor,
                hunger = hunger,
                thirst = thirst,
                energy = math.ceil(100 - GetPlayerSprintStaminaRemaining(PlayerId())) or 100,
                money = data,
                job = job
            })
        end)

        Citizen.Wait(sleep)
    end
end)
