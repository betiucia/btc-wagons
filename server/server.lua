local locale = Locale[Config.Locale]

if Config.FrameWork == 'rsg' then
    RSGCore = exports['rsg-core']:GetCoreObject() -- Puxando o core do RSG
end

local wagons = {} -- Tabela para armazenar as carroças e seus donos

--- Função que cria Callbacks
local Callbacks = {}

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

------------------ save wagon -------------------

RegisterServerEvent("btc-wagons:saveWagonToDatabase")
AddEventHandler("btc-wagons:saveWagonToDatabase", function(wagon, custom, moneyType)
    local src = source
    local maxWagonsPerPlayer = Config.maxWagonsPerPlayer -- ✅ Defina aqui o limite desejado

    local wagonName, wagonPrice = nil, nil

    -- Buscar os detalhes da carroça no Config
    for type, info in pairs(Config.Wagons) do
        for k, v in pairs(info) do
            if wagon == k and moneyType == 'cash' then
                wagonName = v.name
                wagonPrice = v.price
                break
            elseif wagon == k and moneyType == 'gold' then
                wagonName = v.name
                wagonPrice = v.priceGold
                break
            elseif wagon == k then
                wagonName = v.name
                wagonPrice = v.price
                break
            end
        end
    end

    if not wagonName or not custom then
        if Config.Debug then print("Erro: Dados incompletos para salvar a carroça.") end
        return
    end

    local citizenid, success = GetPlayerDataAndRemoveMoney(src, wagonPrice, moneyType)

    if not success then
        Notify(locale["cl_dont_have_money"], 5000, "error", src)
        return
    end

    -- Verifica se já atingiu o limite de carroças
    MySQL.Async.fetchScalar(
        'SELECT COUNT(*) FROM btc_wagons WHERE citizenid = @citizenid',
        { ['@citizenid'] = citizenid },
        function(totalCount)
            if totalCount >= maxWagonsPerPlayer then
                Notify(locale["cl_max_wagons_reached"] or "Você já possui o número máximo de carroças!", 5000, "error", src)
                -- Estorna o dinheiro
                GetPlayerDataAndAddMoney(source, wagonPrice, moneyType)
                return
            end

            -- Verifica se já tem uma carroça com o mesmo nome
            MySQL.Async.fetchScalar(
                'SELECT COUNT(*) FROM btc_wagons WHERE citizenid = @citizenid AND JSON_EXTRACT(custom, "$.name") = @wagonName',
                {
                    ['@citizenid'] = citizenid,
                    ['@wagonName'] = custom.name
                },
                function(count)
                    if count > 0 then
                        Notify(locale["cl_wagon_name_exists"], 5000, "error", src)
                        GetPlayerDataAndAddMoney(source, wagonPrice, moneyType)
                        if Config.Debug then
                            print("Erro: Jogador já tem uma carroça com o nome " .. custom.name)
                        end
                        return
                    end

                    -- Salva no banco
                    MySQL.Async.execute(
                        'INSERT INTO btc_wagons (citizenid, wagon, custom, animals) VALUES (@citizenid, @wagon, @custom, @animals)',
                        {
                            ['@citizenid'] = citizenid,
                            ['@wagon'] = wagon,
                            ['@custom'] = json.encode(custom),
                            ['@animals'] = json.encode({})
                        },
                        function(rowsChanged)
                            if rowsChanged > 0 then
                                Notify(locale["cl_you_buy"], 5000, "success", src)
                                if Config.Debug then print("Carroça salva com sucesso!") end
                            else
                                print("Erro ao salvar a carroça no banco de dados!")
                            end
                        end
                    )
                end
            )
        end
    )
end)

---- Carregar carroça do banco de dados ---

RegisterServerEvent("btc-wagons:getWagonDataByCitizenID")
AddEventHandler("btc-wagons:getWagonDataByCitizenID", function(serverSource)
    local src = nil
    if serverSource then
        src = serverSource -- ID do jogador que está salvando a carroça
    else
        src = source       -- ID do jogador que está salvando a carroça
    end

    local citizenid = GetCitizenID(src)

    -- Consulta os dados da carroça pelo citizenid e verifica se o campo active = 1
    MySQL.Async.fetchAll('SELECT * FROM btc_wagons WHERE citizenid = @citizenid AND active = 1', {
        ['@citizenid'] = citizenid
    }, function(result)
        -- Se a carroça for encontrada
        if result[1] then
            local wagonData = result[1]
            local customData = json.decode(wagonData.custom)   -- Decodifica o JSON armazenado
            local animalsData = json.decode(wagonData.animals) -- Decodifica o JSON armazenado

            -- Envia os dados da carroça de volta ao cliente
            TriggerClientEvent("btc-wagons:receiveWagonData", src, wagonData.wagon, customData, animalsData, wagonData
                .id)
            if Config.Debug then
                print("Carroça recuperada com sucesso: CitizenID - " .. citizenid)
            end
        else
            -- Caso a carroça não seja encontrada ou não esteja ativa
            if Config.Debug then
                print("Carroça não encontrada ou não ativa no banco de dados: CitizenID - " .. citizenid)
            end
        end
    end)
end)



------------------- Registrar Carroça -----------------
RegisterNetEvent("btc-wagons:registerWagon")
AddEventHandler("btc-wagons:registerWagon", function(netId, wagonID, model)
    local source = source -- ID do jogador que spawnou a carroça

    -- Armazena os dados da carroça
    wagons[netId] = {
        owner = source,
        wagonID = wagonID,
        wagonModel = model

    }
    if Config.Debug then
        print(("🚂 Carroça registrada! NetworkID: %s | WagonID: %s | Dono: %s"):format(netId, wagonID, source))
    end
end)

RegisterNetEvent("btc-wagons:updateWagonAuth")
AddEventHandler("btc-wagons:updateWagonAuth", function(netId, citizenID, action)
    local source = source -- ID do jogador que está atualizando a carroça

    -- Verifica se a carroça existe
    if wagons[netId] then
        -- Garante que a lista de autorizados exista
        if not wagons[netId].authorized then
            wagons[netId].authorized = {}
        end

        if action == "add" then
            -- Adiciona um novo CitizenID à lista de autorizados
            wagons[netId].authorized[citizenID] = true
            if Config.Debug then
                print(("🔑 %s agora pode abrir a carroça %s"):format(citizenID, netId))
            end
        elseif action == "remove" then
            -- Remove o CitizenID da lista de autorizados
            wagons[netId].authorized[citizenID] = nil
            if Config.Debug then
                print(("🚫 %s não pode mais abrir a carroça %s"):format(citizenID, netId))
            end
        end
    else
        if Config.Debug then
            print(("⚠️ Tentativa de atualizar uma carroça inexistente! NetID: %s"):format(netId))
        end
    end
end)


-- Função para obter informações de uma carroça pelo Network ID
function GetWagonInfoByNetId(netId)
    return wagons[netId] or nil
end

-- Função para obter informações de uma carroça pelo WagonID
function GetWagonInfoByWagonId(wagonID)
    for netId, data in pairs(wagons) do
        if data.wagonID == wagonID then
            return netId, data
        end
    end
    return nil
end

RegisterServerCallback("btc-wagons:isWagonRegistered", function(source, cb, netId)
    local source = source
    if wagons[netId] then
        if source == wagons[netId].owner then
            -- Se o jogador for o dono da carroça, informa que está registrada
            cb(true, true, wagons[netId].wagonID, wagons[netId].wagonModel, netId)
        else
            -- Envia a resposta confirmando que a carroça está registrada
            cb(true, false, wagons[netId].wagonID, wagons[netId].wagonModel, netId)
        end
    end
    -- Se não estiver registrada, informa ao client
    cb(false)
end)

RegisterServerEvent('btc-wagons:openWagonStash')
AddEventHandler('btc-wagons:openWagonStash', function(stash, wagonModel, wagonID, netId)
    local source = source                         -- ID do jogador tentando acessar o baú
    local playerIdentifier = GetCitizenID(source) -- Obtém o CitizenID

    -- Verifica se a carroça está registrada
    if wagons[netId] then
        local owner = wagons[netId].owner
        local authorized = wagons[netId].authorized or {}

        local isAuthorized = false
        for _, id in ipairs(authorized) do
            if id == playerIdentifier then
                isAuthorized = true
                break
            end
        end

        -- Se o jogador for o dono OU estiver na lista de autorizados
        if source == owner or isAuthorized then
            for type, infos in pairs(Config.Wagons) do
                for k, v in pairs(infos) do
                    if wagonModel == k then
                        local weight = v.maxWeight
                        local slots = v.slots
                        OpenStash(source, weight, slots, stash)
                        return
                    end
                end
            end
        else
            local firstname, lastname = GetName(source)
            for type, infos in pairs(Config.Wagons) do
                for k, v in pairs(infos) do
                    if wagonModel == k then
                        local data = {
                            citizenId = playerIdentifier,
                            netId = netId,
                            firstname = firstname,
                            lastname = lastname,
                            owner = owner,
                            targetID = source,
                            stash = stash,
                            weight = v.maxWeight,
                            slots = v.slots
                        }
                        TriggerClientEvent('btc-wagons:stashPermission', source, data)
                        return
                    end
                end
            end
        end
    end
end)

RegisterServerEvent('btc-wagons:robWagonStash')
AddEventHandler('btc-wagons:robWagonStash', function(data)
    local src = source
    local weight = data.weight
    local slots = data.slots
    local stash = data.stash
    local removeItem = RemoveItem(src, Config.Robbery.lockpick)
    if removeItem then
    OpenStash(src, weight, slots, stash)
    else
        Notify(locale["no_have_item"].. Config.Robbery.lockpickLabel, 5000, "error", src)
    end
end)

RegisterServerEvent('btc-wagons:removeItem')
AddEventHandler('btc-wagons:removeItem', function(data)
    local src = source
    RemoveItem(src, Config.Robbery.lockpick)
end)

RegisterServerEvent('btc-wagons:getOwnerPermission')
AddEventHandler('btc-wagons:getOwnerPermission', function(data)
    local owner = data.owner
    TriggerClientEvent('btc-wagon:askOwnerPermission', owner, data)
end)

RegisterServerEvent('btc-wagons:giveOwnerPermission')
AddEventHandler('btc-wagons:giveOwnerPermission', function(permission, data)
    local targetID = data.targetID
    local citizenId = data.citizenId
    local netId = data.netId

    if permission == 'confirm' then
        if not wagons[netId] then return end

        if not wagons[netId].authorized then
            wagons[netId].authorized = {}
        end

        -- Evita duplicação
        for _, id in ipairs(wagons[netId].authorized) do
            if id == citizenId then return end
        end

        table.insert(wagons[netId].authorized, citizenId)

        Notify(locale["have_permission"], 5000, "success", targetID)
    else
        Notify(locale["no_permission"], 5000, "error", targetID)
    end
end)

--------------- checagem das carroças

RegisterServerCallback("btc-wagons:checkMyWagons", function(source, cb)
    local src = source
    local citizenid = GetCitizenID(src)

    MySQL.Async.fetchAll("SELECT wagon, custom FROM btc_wagons WHERE citizenid = @citizenid", {
        ["@citizenid"] = citizenid
    }, function(result)
        if result and #result > 0 then
            local wagons = {}
            local customData = {}

            for _, data in ipairs(result) do
                table.insert(wagons, data.wagon)

                -- Agora cada carroça tem sua customização corretamente armazenada
                table.insert(customData, json.decode(data.custom) or {})
            end

            cb(wagons, customData) -- Retorna tabelas separadas para modelos e customizações
        else
            if Config.Debug then
                print("⚠️ Nenhuma carroça encontrada para " .. citizenid)
            end
            cb({}, {}) -- Retorna listas vazias caso o jogador não tenha carroças
        end
    end)
end)

RegisterNetEvent("btc-wagons:saveCustomization")
AddEventHandler("btc-wagons:saveCustomization", function(wagonModel, custom, customType)
    local src = source
    local customPrice = Config.CustomPrice[customType]

    local citizenid, success = GetPlayerDataAndRemoveMoney(src, customPrice)

    if success then
        -- Converte a tabela custom para JSON
        local customJSON = json.encode(custom)

        -- Encontra o nome da carroça dentro da customização (no campo 'name')
        local wagonName = custom.name

        -- Atualiza a DB com a nova customização, utilizando o modelo (wagonModel) e o nome (custom.name)
        MySQL.Async.execute(
            "UPDATE btc_wagons SET custom = @custom WHERE citizenid = @citizenid AND wagon = @wagonModel AND JSON_EXTRACT(custom, '$.name') = @wagonName",
            {
                ["@custom"] = customJSON,
                ["@citizenid"] = citizenid,
                ["@wagonModel"] = wagonModel, -- Adicionando o modelo (wagonModel) como condição na query
                ["@wagonName"] = wagonName    -- Buscando também pelo nome (custom.name)
            }, function(affectedRows)
                if affectedRows > 0 then
                    Notify(locale["cl_custom_success"], 5000, "success", src)
                    if Config.Debug then
                        print("Carroça " ..
                            wagonName .. " (modelo " .. wagonModel .. ") atualizada com sucesso para " .. citizenid)
                    end
                else
                    if Config.Debug then
                        print("Erro ao atualizar a carroça para " .. citizenid)
                    end
                end
            end)
    else
        Notify(locale["cl_dont_have_money"], 5000, "error", src) -- Notifica o jogador que não tem dinheiro suficiente
        return
    end
end)


----- Ativar uma nova carroça

RegisterServerEvent('btc-wagons:toggleWagonActive', function(wagon, currentWagonCustom)
    local source = source
    local citizenID = GetCitizenID(source)     -- Obtém o CitizenID corretamente
    local customName = currentWagonCustom.name -- Obtém o nome da customização

    if not customName or customName == "" then
        Notify(source, "Erro: Nome da customização inválido!", 5000, "error")
        return
    end

    -- Verificar se o jogador já tem uma carroça ativa
    MySQL.Async.fetchAll("SELECT id FROM btc_wagons WHERE citizenid = @citizenid AND active = 1", {
        ["@citizenid"] = citizenID
    }, function(activeWagons)
        if activeWagons and #activeWagons > 0 then
            -- Se houver uma carroça ativa, desativá-la
            local currentActiveWagonID = activeWagons[1].id
            MySQL.Async.execute("UPDATE btc_wagons SET active = 0 WHERE id = @id", {
                ["@id"] = currentActiveWagonID
            })
        end

        -- Agora ativamos a nova carroça, verificando se o JSON `custom` contém o mesmo nome
        MySQL.Async.execute([[
            UPDATE btc_wagons
            SET active = 1
            WHERE wagon = @wagon
            AND JSON_UNQUOTE(JSON_EXTRACT(custom, '$.name')) = @customName
            AND citizenid = @citizenid
        ]], {
            ["@wagon"] = wagon,
            ["@customName"] = customName,
            ["@citizenid"] = citizenID
        }, function(rowsChanged)
            if rowsChanged > 0 then
                Notify("Carroça ativada com sucesso!", 5000, "success", source)
                Wait(500)
                TriggerEvent("btc-wagons:getWagonDataByCitizenID", source) -- Atualiza os dados da carroça no cliente
            else
                Notify("Nenhuma carroça encontrada com esse modelo e customização!", 5000, "error", source)
            end
        end)
    end)
end)


--------------- Vender Carroça ------------------
RegisterNetEvent("btc-wagons:sellWagon", function(wagonModel, custom)
    local src = source
    local citizenid = GetCitizenID(src) -- Obtém o citizenid do jogador

    if not custom or not custom.name then
        Notify(locale["no_wagon_found"], 5000, "error", src)
        return
    end

    local wagonName = custom.name -- Obtém o nome da carroça dentro do custom

    -- Busca a carroça no banco de dados usando o nome salvo
    MySQL.query("SELECT * FROM btc_wagons WHERE citizenid = ? AND JSON_EXTRACT(custom, '$.name') = ?",
        { citizenid, wagonName }, function(result)
            if result and #result > 0 then
                local wagonData = result[1]
                local customDB = json.decode(wagonData.custom or "{}") -- Converte JSON para tabela
                local buyMoneyType = customDB.buyMoneyType or "cash"   -- Obtém o tipo de pagamento original

                -- Encontrar o preço original no Config.Wagons
                local originalPrice = nil
                local altPrice = nil

                for type, wagons in pairs(Config.Wagons) do
                    if wagons[wagonModel] then
                        -- Primeiro tenta pegar o valor baseado no dinheiro original usado
                        originalPrice = (buyMoneyType == "gold" and wagons[wagonModel].priceGold) or
                            wagons[wagonModel].price
                        -- Salva o preço alternativo (se o primeiro não existir)
                        altPrice = (buyMoneyType == "gold" and wagons[wagonModel].price) or wagons[wagonModel].priceGold
                        break
                    end
                end

                -- Se não encontrou o preço original, tenta usar o preço alternativo
                if not originalPrice then
                    originalPrice = altPrice
                    buyMoneyType = (buyMoneyType == "gold") and "cash" or "gold" -- Troca para o outro tipo de dinheiro
                end

                -- Se ainda assim não encontrou um preço válido, cancela a venda
                if not originalPrice then
                    Notify(locale["no_price"], 5000, "error", src)
                    return
                end

                -- Calcular o preço de venda
                local sellPrice = originalPrice * Config.Sell

                -- Remover carroça da DB
                MySQL.execute("DELETE FROM btc_wagons WHERE citizenid = ? AND JSON_EXTRACT(custom, '$.name') = ?",
                    { citizenid, wagonName })

                -- Adicionar o dinheiro ao jogador
                GetPlayerDataAndAddMoney(src, sellPrice, buyMoneyType)

                -- Notificação para o jogador
                Notify(locale["you_sell_wagon"] .. (buyMoneyType == "gold" and "🪙 " or "💰 ") .. sellPrice .. "!", 5000,
                    "success", src)
            end
        end)
end)


local wagonAnimalsData = {}

function GetLabelFromModel(item)
    if item.type == "animal" then
        local entry = Config.AnimalsStorage[item.model]
        return entry and entry.label
    elseif item.type == "pelt" then
        local entry = Config.AnimalsStorage[item.peltquality]
        return entry and entry.label
    end
end

local function getWagonMenuData(wagonId, cb)
    if not wagonId then
        print("⚠️ ID da carroça inválido.")
        cb({})
        return
    end

    -- Se já estiver em memória, usamos direto
    if wagonAnimalsData[wagonId] then
        local menuData = {}

        for _, item in ipairs(wagonAnimalsData[wagonId]) do
            local label = GetLabelFromModel(item) or "Item Desconhecido"
            table.insert(menuData, {
                label = label,
                infos = item
            })
        end

        cb(menuData)
        return
    end

    -- Se não estiver em memória, busca no banco
    MySQL.query("SELECT animals FROM btc_wagons WHERE id = ?", { wagonId }, function(result)
        local menuData = {}

        if result and result[1] and result[1].animals then
            local decoded = json.decode(result[1].animals) or {}
            -- Salva em memória
            wagonAnimalsData[wagonId] = decoded

            for _, item in ipairs(decoded) do
                local label = GetLabelFromModel(item) or "Item Desconhecido"
                table.insert(menuData, {
                    label = label,
                    infos = item
                })
            end
        else
            print("⚠️ Nenhum dado encontrado na DB para a carroça:", wagonId)
        end

        cb(menuData)
    end)
end


local function updateAndSave(wagonId, newAnimal, remove) ---- ser remove = true para remover o animal da DB
    if not wagonId or not newAnimal then
        print("⚠️ Dados inválidos para updateAndSave")
        return
    end

    -- Garante que a tabela do wagon esteja inicializada
    if not wagonAnimalsData[wagonId] then
        wagonAnimalsData[wagonId] = {}
    end

    local animalsTable = wagonAnimalsData[wagonId]
    local foundIndex = nil

    -- Verifica se o item já existe
    for i, animal in ipairs(animalsTable) do
        local isSame =
            animal.model == newAnimal.model and
            animal.type == newAnimal.type and
            (
                (newAnimal.type == "animal" and
                    animal.outfit == newAnimal.outfit and
                    animal.skinned == newAnimal.skinned and
                    animal.quality == newAnimal.quality) or
                (newAnimal.type == "pelt" and animal.peltquality == newAnimal.peltquality)
            )

        if isSame then
            foundIndex = i
            break
        end
    end

    if remove then
        if foundIndex then
            local currentQty = animalsTable[foundIndex].quantity or 1
            if currentQty > 1 then
                animalsTable[foundIndex].quantity = currentQty - 1
            else
                table.remove(animalsTable, foundIndex)
            end
        else
            print("⚠️ Tentando remover item que não existe na carroça")
            return
        end
    else
        if foundIndex then
            animalsTable[foundIndex].quantity = (animalsTable[foundIndex].quantity or 1) + 1
        else
            local entry = {}
            if newAnimal.type == "pelt" then
                entry = newAnimal
                entry.peltquality = newAnimal.peltquality
                entry.quantity = 1
            elseif newAnimal.type == "animal" then
                entry = newAnimal
                entry.quantity = 1
                entry.metatag = newAnimal.metatag
            end

            table.insert(animalsTable, entry)
        end
    end

    -- Atualiza em memória
    wagonAnimalsData[wagonId] = animalsTable

    -- Salva na DB
    local animalsJSON = json.encode(animalsTable)
    MySQL.update("UPDATE btc_wagons SET animals = ? WHERE id = ?", {
        animalsJSON,
        wagonId
    }, function(rowsChanged)
        if Config.Debug then
            if rowsChanged and rowsChanged > 0 then
                print(("✅ Carroça %s atualizada com %d item(ns)."):format(wagonId, #animalsTable))
            else
                print(("⚠️ Nenhuma carroça atualizada com ID %s."):format(wagonId))
            end
        end
    end)
end

RegisterNetEvent("btc-wagons:storeAnimalInWagon", function(wagonId, newAnimal)
    local src = source

    if not wagonId or not newAnimal or type(newAnimal) ~= "table" then
        if Config.Debug then
            print("⚠️ Dados inválidos para salvar animais na carroça")
        end
        return
    end

    -- Se já temos os dados na cache, usamos direto
    local animalsTable = wagonAnimalsData[wagonId]

    if not animalsTable then
        -- Se ainda não temos a cache, carrega da DB e atualiza
        MySQL.query("SELECT animals FROM btc_wagons WHERE id = ?", { wagonId }, function(result)
            local loadedAnimals = {}

            if result and result[1] and result[1].animals then
                loadedAnimals = json.decode(result[1].animals) or {}
            end

            wagonAnimalsData[wagonId] = loadedAnimals
            animalsTable = loadedAnimals

            updateAndSave(wagonId, newAnimal)
        end)
    else
        updateAndSave(wagonId, newAnimal)
    end
end)

RegisterServerCallback("btc-wagons:getAnimalStorage", function(source, cb, wagonId)
    local source = source
    getWagonMenuData(wagonId, function(menuData)
        cb(menuData) -- Só chama o cb aqui, depois que getWagonMenuData tiver os dados
    end)
end)

------------ Remover um animal da carroça

RegisterNetEvent("btc-wagons:removeAnimalFromWagon", function(wagonID, infos, label)
    local src = source
    TriggerClientEvent("btc-wagons:spawnAnimal", src, infos)
    ------ Continuar daqui, antes da função de remover o animal (updateandsave), verificar se o animal existe na carroça e fazer o jogador spawnar o animal
    updateAndSave(wagonID, infos, true)
end)

------ Remove a Carroça do server
RegisterNetEvent("btc-wagons:removeWagon")
AddEventHandler("btc-wagons:removeWagon", function(netId, wagon)
    if wagons[netId] then
        local wagon = NetworkGetEntityFromNetworkId(netId)
        if wagon and DoesEntityExist(wagon) then
            DeleteEntity(wagon)
            if Config.Debug then
                print("Carroça removida! NetworkID: " ..
                    netId .. " | WagonID: " .. wagons[netId].wagonID .. " | Dono: " .. wagons[netId].owner)
            end
        end

        wagons[netId] = nil -- Remove da tabela
    else --- caso seja o resource stop
        local wagon = NetworkGetEntityFromNetworkId(netId)
        if wagon and DoesEntityExist(wagon) then
            DeleteEntity(wagon)
            wagons[netId] = nil -- Remove da tabela
            if Config.Debug then
                print("Carroça removida!")
            end
        end
    end
end)
