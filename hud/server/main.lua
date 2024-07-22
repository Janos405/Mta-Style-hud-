ESX = exports['es_extended']:getSharedObject()



ESX.RegisterServerCallback('getdata', function(src, cb)
local xPlayer = ESX.GetPlayerFromId(src)
while not xPlayer do 
    Wait(100)
end
local money = xPlayer.getMoney()
cb(money)
end)

