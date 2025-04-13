--- Função que cria Callbacks
local Callbacks = {}
if Config.FrameWork == 'rsg' then
    RSGCore = exports['rsg-core']:GetCoreObject() -- Puxando o core do RSG
end


RegisterNetEvent("btc-wagons:triggerCallback")
AddEventHandler("btc-wagons:triggerCallback", function(name, requestId, ...)
    local source = source
    if Callbacks[name] then
        Callbacks[name](source, function(...)
            TriggerClientEvent("btc-wagons:callbackResponse", source, requestId, ...)
        end, ...)
    end
end)

function RegisterServerCallback(name, cb)
    Callbacks[name] = cb
end

---------------- Pega dados e remove Dinheiro
function GetPlayerDataAndRemoveMoney(source, amount, moneyType)
    local citizenid = nil
    local removed = false
    local cashType = nil

    if moneyType == 'cash' or moneyType == 'gold' then
        if moneyType == 'cash' then
            cashType = Config.MoneyType.money
        elseif moneyType == 'gold' then
            cashType = Config.MoneyType.gold
        end
    else
        cashType = Config.MoneyType.money
    end

    if Config.FrameWork == 'rsg' then
        local Player = RSGCore.Functions.GetPlayer(source)
        if Player then
            citizenid = Player.PlayerData.citizenid
            local money = Player.PlayerData.money[cashType]

            -- Verifica se o jogador tem dinheiro suficiente antes de remover
            if money >= amount then
                if Player.Functions.RemoveMoney(cashType, amount) then
                    removed = true
                end
            end
        end
    end

    return citizenid, removed
end

function GetPlayerDataAndAddMoney(source, amount, moneyType)
    local citizenid = nil
    local add = false
    local cashType = nil

    if moneyType == 'cash' or moneyType == 'gold' then
        if moneyType == 'cash' then
            cashType = Config.MoneyType.money
        elseif moneyType == 'gold' then
            cashType = Config.MoneyType.gold
        end
    else
        cashType = Config.MoneyType.money
    end

    if Config.FrameWork == 'rsg' then
        local Player = RSGCore.Functions.GetPlayer(source)
        if Player then
            citizenid = Player.PlayerData.citizenid
            if Player.Functions.AddMoney(cashType, amount) then
                add = true
            end
        end
    end

    return citizenid, add
end

function GetCitizenID(source)
    local citizenid = nil

    if Config.FrameWork == 'rsg' then
        local Player = RSGCore.Functions.GetPlayer(source)
        if Player then
            citizenid = Player.PlayerData.citizenid
        end
    end

    return citizenid
end

function OpenStash(source, weight, slots, stash)
    if Config.FrameWork == 'rsg' then
        local data = { label = "Baú", maxweight = weight * 1000, slots = slots }
        local stashName = stash
        exports['rsg-inventory']:OpenInventory(source, stashName, data)
    end
end

function GetName(source)
    local firstname = nil
    local lastname = nil


    if Config.FrameWork == 'rsg' then
        local Player = RSGCore.Functions.GetPlayer(source)
        if Player then
            firstname = Player.PlayerData.charinfo.firstname -- primeiro nome
            lastname = Player.PlayerData.charinfo.lastname -- segundo nome
        end
    end

    return firstname, lastname
end

function RemoveItem(source, item, qnt)
    if qnt then
        qnt = qnt
    else
        qnt = 1
    end

    if Config.FrameWork == 'rsg' then
        local Player = RSGCore.Functions.GetPlayer(source)
        if Player then
            if Player.Functions.RemoveItem(item, qnt) then
                return true
            else
                return false
            end
        end
    end
end
