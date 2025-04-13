---- Função que cria Callbacks
local Callbacks = {}
local requestId = 0

if Config.FrameWork == 'rsg' then
    RSGCore = exports['rsg-core']:GetCoreObject() -- Puxando o core do RSG
end

RegisterNetEvent("btc-wagons:callbackResponse")
AddEventHandler("btc-wagons:callbackResponse", function(requestId, ...)
    if Callbacks[requestId] then
        Callbacks[requestId](...)
        Callbacks[requestId] = nil
    end
end)

function TriggerServerCallback(name, cb, ...)
    requestId = requestId + 1
    Callbacks[requestId] = cb
    TriggerServerEvent("btc-wagons:triggerCallback", name, requestId, ...)
end

----

function HasItem (itemName, itemQnt)
    if itemQnt then
        itemQnt = itemQnt
    else
        itemQnt = 1
    end

    if Config.FrameWork == 'rsg' then
       local hasItem = RSGCore.Functions.HasItem(itemName, itemQnt)
       if hasItem then
        return true
       else
        return false
       end
    end

end