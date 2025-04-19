local wagonBlip = nil
local vehicle = nil
local mywagon = nil
local wagon = nil
local isNearWagon = false -- Flag para saber se o jogador está perto da carroça
local isOwner = false
local wagonID = nil
local wagonNetId = nil
local wagonModel = nil
local StashPrompt
local DeletePrompt
local CarcassPrompt
local StockCarcassPrompt
local WagonGroup = GetRandomIntInRange(0, 0xffffff)
local locale = Locale[Config.Locale]
local openMenu = false
local cargo = false

-- If you wish to trigger the action from another script, use:
RegisterNetEvent('btc-wagons:client:dellwagon')
AddEventHandler('btc-wagons:client:dellwagon', function()
    DeleteWagon()
end)

RegisterNetEvent('btc-wagons:client:callwagon')
AddEventHandler('btc-wagons:client:callwagon', function()
    CallWagon()
end)
---- Thanks daryldixon4074 for idea :)
----


if Config.Debug then
    RegisterCommand('delete', function()
        DeleteWagon()
    end)

    RegisterCommand('cart', function()
        CallWagon()
    end)
end


local function FindSafeSpawnCoords(baseCoords, attempts, radius, minDistance)
    attempts = attempts or 10
    radius = radius or Config.SpawnRadius or 10.0
    minDistance = minDistance or 5.0

    local players = GetActivePlayers()

    for i = 1, attempts do
        local angle = math.rad((360 / attempts) * i)
        local offsetX = math.cos(angle) * radius
        local offsetY = math.sin(angle) * radius
        local tryCoords = vector3(baseCoords.x + offsetX, baseCoords.y + offsetY, baseCoords.z)

        local isFar = true
        for _, playerId in ipairs(players) do
            local ped = PlayerPedId()
            local pedCoords = GetEntityCoords(ped)
            if #(pedCoords - tryCoords) < minDistance then
                isFar = false
                break
            end
        end

        if isFar then
            local ped = PlayerPedId()
            local location = GetEntityCoords(ped)
            local x, y, z = table.unpack(location)
            local found, roadCoords = GetClosestVehicleNode(x - 15, y, z, 0, 3.0, 0.0)
            local _, _, nodeHeading = GetNthClosestVehicleNodeWithHeading(x - 15, y, z, 1, 1, 0, 0)
            if found then
                return found, roadCoords, nodeHeading
            end
        end
    end

    return nil -- Nenhum local seguro encontrado
end


local function SpawnWagon(model, tint, livery, props, extra, lantern, myWagonID)
    local ped = PlayerPedId()
    local hash = joaat(model)
    local veh = GetVehiclePedIsUsing(ped)
    local location = GetEntityCoords(ped)
    local x, y, z = table.unpack(location)
    local _, nodePosition = GetClosestVehicleNode(x - 15, y, z, 0, 3.0, 0.0)
    local distance = math.floor(#(nodePosition - location))
    local radius = Config.SpawnRadius or 10.0
    local onRoad = distance < radius

    -- Buscar um nó de estrada próximo para garantir que o spawn seja na estrada
    local playerCoords = GetEntityCoords(PlayerPedId())
    local found, safeCoords, nodeHeading = FindSafeSpawnCoords(playerCoords)


    if not safeCoords then
        Notify(locale["cl_no_road"], 6000, 'error')
        return
    end

    if not found then
        Notify(locale["cl_no_road"], 6000, 'error')
        return
    end

    if not onRoad then
        Notify(locale["cl_no_road"], 6000, 'error')
        return
    end

    if not IsModelInCdimage(hash) then return end
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(0)
    end

    if IsPedInAnyVehicle(ped) then
        SetEntityAsMissionEntity(veh, true, true)
        DeleteVehicle(veh)
    end

    mywagon = CreateVehicle(hash, safeCoords.x, safeCoords.y, safeCoords.z, nodeHeading, true, false)
    SetVehicleDirtLevel(mywagon, 0.0)

    Wait(100)

    -- Removendo todas as propriedades aleatórias
    Citizen.InvokeNative(0x75F90E4051CC084C, mywagon, 0) -- _REMOVE_ALL_VEHICLE_PROPSETS
    Citizen.InvokeNative(0xE31C0CB1C3186D40, mywagon)    -- _REMOVE_ALL_VEHICLE_LANTERN_PROPSETS


    -- Aplicando propriedades específicas
    if props then
        Citizen.InvokeNative(0x75F90E4051CC084C, mywagon, GetHashKey(props)) -- _ADD_VEHICLE_PROPSETS
        Citizen.InvokeNative(0x31F343383F19C987, mywagon, 0.5, 1)            -- _SET_VEHICLE_TARP_HEIGHT
    end


    if lantern then
        Citizen.InvokeNative(0xC0F0417A90402742, mywagon, GetHashKey(lantern)) -- _ADD_VEHICLE_LANTERN_PROPSETS
    end

    Citizen.InvokeNative(0x8268B098F6FCA4E2, mywagon, tint)        -- _SET_VEHICLE_TINT
    Citizen.InvokeNative(0xF89D82A0582E46ED, mywagon, livery or 0) -- _SET_VEHICLE_LIVERY

    -- Força uma atualização do veículo para corrigir possíveis erros gráficos
    Citizen.InvokeNative(0xAD738C3085FE7E11, mywagon, true, true) -- Set entity as mission entity
    Citizen.InvokeNative(0x9617B6E5F65329A5, mywagon)             -- Force vehicle update

    Wait(50)                                                      -- Tempo extra para garantir a atualização visual

    -- Desativando extras aleatórios
    for i = 0, 10 do
        if DoesExtraExist(mywagon, i) then
            Citizen.InvokeNative(0xBB6F89150BC9D16B, mywagon, i, true) -- Desativa todos os extras
        end
    end
    if extra then
        Citizen.InvokeNative(0xBB6F89150BC9D16B, mywagon, extra, false) -- Ativa o extra desejado
    end

    -- Registrar o veículo na rede **após** todas as modificações
    NetworkRegisterEntityAsNetworked(mywagon)               -- Garante que a carroça seja visível para outros jogadores
    SetVehicleIsConsideredByPlayer(mywagon, true)
    Citizen.InvokeNative(0xBB5A3FA8ED3979C5, mywagon, true) -- _SET_VEHICLE_IS_CONSIDERED_BY_PLAYER

    -- Verificar se a carroça foi registrada corretamente na rede
    local networkId = NetworkGetNetworkIdFromEntity(mywagon)

    while not NetworkDoesEntityExistWithNetworkId(networkId) do
        Wait(50) -- Aguarda até que a carroça esteja completamente registrada na rede
    end

    getControlOfEntity(mywagon)

    if Config.Target then
        CreateWagonTarget(mywagon)
    end

    TriggerServerEvent("btc-wagons:registerWagon", networkId, myWagonID, model) -- Envia o evento para o servidor com o ID da rede


    -- Criando blip
    local blipModel = GetHashKey("blip_player_coach")
    wagonBlip = Citizen.InvokeNative(0x23F74C2FDA6E7C61, -1230993421, mywagon)
    SetBlipSprite(wagonBlip, blipModel, true)
    Citizen.InvokeNative(0x9CB1A1623062F402, wagonBlip, locale['cl_your_wagon'])
end

function CreateWagonTarget()

        local networkId = NetworkGetNetworkIdFromEntity(mywagon)

        while not NetworkDoesEntityExistWithNetworkId(networkId) do
            Wait(50) -- Aguarda até que a carroça esteja completamente registrada na rede
        end
        if networkId then
        exports.ox_target:addEntity(networkId, {
            {
                name = 'npc_wagonStash',
                icon = 'fa-solid fa-box-open',
                label = locale['cl_wagon_stash'],
                onSelect = function()
                    StashWagon()
                end,
                distance = 1.5
            }
        })
        Wait(100)
        exports.ox_target:addEntity(networkId, {
            {
                name = 'npc_wagonShowCarcass',
                icon = 'fa-solid fa-boxes-stacked',
                label = locale['cl_see_carcass'],
                onSelect = function()
                    ShowCarcass()
                end,
                distance = 1.5
            }
        })
        Wait(100)
        exports.ox_target:addEntity(networkId, {
            {
                name = 'npc_wagonStockCarcass',
                icon = 'fa-solid fa-paw',
                label = locale['cl_stock_carcass'],
                onSelect = function()
                    StockCarcass()
                end,
                distance = 1.5
            }
        })
        Wait(100)
        exports.ox_target:addEntity(networkId, {
            {
                name = 'npc_wagonDelete',
                icon = 'fa-solid fa-warehouse',
                label = locale['cl_flee_wagon'],
                onSelect = function()
                    DeleteThisWagon()
                end,
                distance = 1.5
            }
        })
    else
        CreateWagonTarget()
    end
end

--- Controlar a Entidade

function getControlOfEntity(entity)
    NetworkRequestControlOfEntity(entity)
    SetEntityAsMissionEntity(entity, true, true)
    local timeout = 2000

    while timeout > 0 and NetworkHasControlOfEntity(entity) == nil do
        Wait(100)
        timeout = timeout - 100
    end
    return NetworkHasControlOfEntity(entity)
end

--- Não usar, só se precisar!
-- CreateThread(function()
--     while true do
--         if (timeout) then
--             if (timeoutTimer == 0) then
--                 timeout = false
--             end
--             timeoutTimer = timeoutTimer - 1
--             Wait(1000)
--         end
--         Wait(0)
--     end
-- end)

-- Função para verificar a proximidade do jogador com uma carroça

local function EnumerateVehicles(callback)
    local handle, vehicle = FindFirstVehicle()
    local success
    repeat
        if DoesEntityExist(vehicle) then
            callback(vehicle)
        end
        success, vehicle = FindNextVehicle(handle)
    until not success
    EndFindVehicle(handle)
end

-- Função auxiliar para verificar se um modelo é uma carroça
local function IsThisModelAWagon(model)
    for _, wagonType in pairs(Config.Wagons) do
        for wagonModel, _ in pairs(wagonType) do
            local hash = GetHashKey(wagonModel)
            if hash == model then
                return true
            end
        end
    end
    return false
end

local wagonVerificationCache = {}

local function GetClosestWagon(callback)
    local ped = PlayerPedId()
    local pedCoords = GetEntityCoords(ped)
    local closestWagon = nil
    local closestDist = 2
    local networkId = nil

    EnumerateVehicles(function(vehicle)
        local model = GetEntityModel(vehicle)
        if IsThisModelAWagon(model) then
            local wagonCoords = GetEntityCoords(vehicle)
            local dist = #(pedCoords - wagonCoords)

            if dist <= closestDist then
                closestWagon = vehicle
                closestDist = dist
                networkId = NetworkGetNetworkIdFromEntity(vehicle)
            end
        end
    end)

    if not closestWagon or not networkId then
        callback(nil, nil, nil, nil)
        return
    end

    -- ⚡ Verificação via cache
    if wagonVerificationCache[networkId] then
        local data = wagonVerificationCache[networkId]
        callback(closestWagon, closestDist, data.owner, data.id, data.model, networkId)
        return
    end

    -- 🧠 Não está em cache, faz verificação com o servidor
    TriggerServerCallback("btc-wagons:isWagonRegistered", function(isRegistered, owner, wagonID, model, netId)
        -- Salva no cache para próximas chamadas

        if isRegistered then
            callback(closestWagon, closestDist, owner, wagonID, model, netId)
            wagonVerificationCache[netId] = {
                owner = owner,
                id = wagonID,
                model = model
            }
        else
            callback(closestWagon, closestDist, nil, nil, nil)
        end
    end, networkId)
end

local animalStorageCache = {}

if Config.Target then
    ------------------------- Olhar o Baú
    function StashWagon()
        GetClosestWagon(function(wagon, dist, owner, id, model, netId)
            if wagon then
                if id then
                    isOwner = owner
                    wagonID = id
                    wagonModel = model
                    wagonNetId = netId

                    -- Verifica e armazena o máximo de animais permitido
                    if animalStorageCache[netId] == nil then
                        local maxAnimal = 0
                        for tipo, modelos in pairs(Config.Wagons) do
                            for model, data in pairs(modelos) do
                                if model == wagonModel then
                                    maxAnimal = data.maxAnimals or 0
                                    break
                                end
                            end
                        end
                        animalStorageCache[netId] = maxAnimal
                    end
                    TriggerServerEvent("btc-wagons:openWagonStash", 'Wagon_Stash_' .. wagonID, wagonModel, wagonID,
                        wagonNetId)
                end
            end
        end)
    end

    function ShowCarcass()
        GetClosestWagon(function(wagon, dist, owner, id, model, netId)
            if wagon then
                if id then
                    isOwner = owner
                    wagonID = id
                    wagonModel = model
                    wagonNetId = netId

                    -- Verifica e armazena o máximo de animais permitido
                    if animalStorageCache[netId] == nil then
                        local maxAnimal = 0
                        for tipo, modelos in pairs(Config.Wagons) do
                            for model, data in pairs(modelos) do
                                if model == wagonModel then
                                    maxAnimal = data.maxAnimals or 0
                                    break
                                end
                            end
                        end
                        animalStorageCache[netId] = maxAnimal
                    end
                end
                if isOwner then
                    local maxAnimal = animalStorageCache[wagonNetId] or 0
                    if maxAnimal > 0 then
                        CarcassInWagon(wagonID)
                    else
                        Notify(locale['no_animals_in_wagon'], 6000, 'error')
                    end
                else
                    Notify(locale['no_permission'], 6000, 'error')
                end
            end
        end)
    end

    function StockCarcass()
        GetClosestWagon(function(wagon, dist, owner, id, model, netId)
            if wagon then
                if id then
                    isOwner = owner
                    wagonID = id
                    wagonModel = model
                    wagonNetId = netId

                    -- Verifica e armazena o máximo de animais permitido
                    if animalStorageCache[netId] == nil then
                        local maxAnimal = 0
                        for tipo, modelos in pairs(Config.Wagons) do
                            for model, data in pairs(modelos) do
                                if model == wagonModel then
                                    maxAnimal = data.maxAnimals or 0
                                    break
                                end
                            end
                        end
                        animalStorageCache[netId] = maxAnimal
                    end
                end
                local maxAnimal = animalStorageCache[wagonNetId] or 0
                if maxAnimal > 0 then
                    StoreCarriedEntityInWagon()
                else
                    Notify(locale['no_animals_in_wagon'], 6000, 'error')
                end
            end
        end)
    end

    function DeleteThisWagon()
        GetClosestWagon(function(wagon, dist, owner, id, model, netId)
            if wagon then
                if id then
                    isOwner = owner
                    wagonID = id
                    wagonModel = model
                    wagonNetId = netId

                    -- Verifica e armazena o máximo de animais permitido
                    if animalStorageCache[netId] == nil then
                        local maxAnimal = 0
                        for tipo, modelos in pairs(Config.Wagons) do
                            for model, data in pairs(modelos) do
                                if model == wagonModel then
                                    maxAnimal = data.maxAnimals or 0
                                    break
                                end
                            end
                        end
                        animalStorageCache[netId] = maxAnimal
                    end
                end
                if isOwner then
                    DeleteWagon()
                else
                    Notify(locale['no_permission'], 6000, 'error')
                end
            end
        end)
    end
else
    Citizen.CreateThread(function()
        while true do
            GetClosestWagon(function(wagon, dist, owner, id, model, netId)
                if wagon then
                    if id then
                        isNearWagon = true
                        isOwner = owner
                        wagonID = id
                        wagonModel = model
                        wagonNetId = netId

                        -- Verifica e armazena o máximo de animais permitido
                        if animalStorageCache[netId] == nil then
                            local maxAnimal = 0
                            for tipo, modelos in pairs(Config.Wagons) do
                                for model, data in pairs(modelos) do
                                    if model == wagonModel then
                                        maxAnimal = data.maxAnimals or 0
                                        break
                                    end
                                end
                            end
                            animalStorageCache[netId] = maxAnimal

                            if Config.Debug then
                                print("🐎 Máximo de animais para o modelo", model, ">", maxAnimal)
                            end
                        end

                        -- if Config.Debug then
                        --     print("🚂 Carroça encontrada a " .. dist .. " metros! | WagonID: " .. wagonID)
                        -- end
                    else
                        isNearWagon = false
                        -- if Config.Debug then
                        --     print("🚂 Carroça encontrada a " .. dist .. " metros! (Sem dono registrado)")
                        -- end
                    end
                else
                    isNearWagon = false
                end
            end)

            Wait(500)
        end
    end)

    -- set Stash prompt
    function StashPrompt() -- Abrir o inventário da carroça
        Citizen.CreateThread(function()
            local str = locale['cl_wagon_stash']
            StashPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
            PromptSetControlAction(StashPrompt, GetHashKey(Config.Keys.OpenWagonStash))
            local str = CreateVarString(10, 'LITERAL_STRING', str)
            PromptSetText(StashPrompt, str)
            PromptSetEnabled(StashPrompt, true)
            PromptSetVisible(StashPrompt, true)
            PromptSetHoldMode(StashPrompt, true)
            PromptSetGroup(StashPrompt, WagonGroup)
            PromptRegisterEnd(StashPrompt)
        end)
    end

    function DeletePrompt() -- Mandar a carroça embora
        Citizen.CreateThread(function()
            local str = locale['cl_flee_wagon']
            DeletePrompt = Citizen.InvokeNative(0x04F97DE45A519419)
            PromptSetControlAction(DeletePrompt, GetHashKey('INPUT_FRONTEND_CANCEL'))
            local str = CreateVarString(10, 'LITERAL_STRING', str)
            PromptSetText(DeletePrompt, str)
            PromptSetEnabled(DeletePrompt, true)
            PromptSetVisible(DeletePrompt, true)
            PromptSetHoldMode(DeletePrompt, true)
            PromptSetGroup(DeletePrompt, WagonGroup)
            PromptRegisterEnd(DeletePrompt)
        end)
    end

    function CarcassPrompt() -- Olhar os animais/pele na carroça
        Citizen.CreateThread(function()
            local str = locale['cl_see_carcass']
            CarcassPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
            PromptSetControlAction(CarcassPrompt, GetHashKey('INPUT_INTERACT_LOCKON_ANIMAL'))
            local str = CreateVarString(10, 'LITERAL_STRING', str)
            PromptSetText(CarcassPrompt, str)
            PromptSetEnabled(CarcassPrompt, true)
            PromptSetVisible(CarcassPrompt, true)
            PromptSetHoldMode(CarcassPrompt, true)
            PromptSetGroup(CarcassPrompt, WagonGroup)
            PromptRegisterEnd(CarcassPrompt)
        end)
    end

    local StoredWagonAnimals = {} -- Armazenar os animais/pele na carroça
    function StockCarcassPrompt() --- Armazenar os animais/pele na carroça
        Citizen.CreateThread(function()
            local str = locale['cl_stock_carcass']
            StockCarcassPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
            PromptSetControlAction(StockCarcassPrompt, GetHashKey('INPUT_DOCUMENT_PAGE_PREV'))
            local str = CreateVarString(10, 'LITERAL_STRING', str)
            PromptSetText(StockCarcassPrompt, str)
            PromptSetEnabled(StockCarcassPrompt, true)
            PromptSetVisible(StockCarcassPrompt, true)
            PromptSetHoldMode(StockCarcassPrompt, true)
            PromptSetGroup(StockCarcassPrompt, WagonGroup)
            PromptRegisterEnd(StockCarcassPrompt)
        end)
    end

    -- Função para detectar a interação de mouse (botão direito)
    Citizen.CreateThread(function()
        StashPrompt()
        DeletePrompt()
        CarcassPrompt()
        StockCarcassPrompt()
        local ped = PlayerPedId()
        while true do
            local waitTime = 2000 -- Tempo padrão de espera
            local PedInVehicle = IsPedInAnyVehicle(ped)
            local maxAnimal = animalStorageCache[wagonNetId] or 0

            if isNearWagon and not PedInVehicle and isOwner and not openMenu then
                waitTime = 2 -- Atualiza para checagem rápida quando perto
                local Stash = CreateVarString(10, 'LITERAL_STRING', locale['cl_your_wagon'])
                PromptSetActiveGroupThisFrame(WagonGroup, Stash)

                ----------------- Deixar os Prompts invisíveis para não aparecerem na tela até a verificação correta
                PromptSetEnabled(CarcassPrompt, false)
                PromptSetVisible(CarcassPrompt, false)
                PromptSetEnabled(StockCarcassPrompt, false)
                PromptSetVisible(StockCarcassPrompt, false)

                if PromptHasHoldModeCompleted(StashPrompt) then
                    -- Desativa temporariamente o prompt para evitar múltiplos acionamentos
                    PromptSetEnabled(StashPrompt, false)
                    PromptSetVisible(StashPrompt, false)
                    TriggerServerEvent("btc-wagons:openWagonStash", 'Wagon_Stash_' .. wagonID, wagonModel, wagonID,
                        wagonNetId)
                    -- Pequeno delay para evitar reativação instantânea
                    Wait(500)

                    -- Reativa o prompt para futuras interações
                    PromptSetEnabled(StashPrompt, true)
                    PromptSetVisible(StashPrompt, true)
                elseif PromptHasHoldModeCompleted(DeletePrompt) then
                    -- Desativa temporariamente o prompt para evitar múltiplos acionamentos
                    PromptSetEnabled(DeletePrompt, false)
                    PromptSetVisible(DeletePrompt, false)
                    if isOwner then
                        -- Se o jogador for o dono da carroça, abre o inventário
                        DeleteWagon()
                    else
                        -- Se não for o dono, notifica que não pode acessar
                        Notify(locale['cl_not_owner'], 6000, 'error')
                    end

                    -- Pequeno delay para evitar reativação instantânea
                    Wait(500)

                    -- Reativa o prompt para futuras interações
                    PromptSetEnabled(DeletePrompt, true)
                    PromptSetVisible(DeletePrompt, true)
                elseif maxAnimal > 0 then
                    PromptSetEnabled(CarcassPrompt, true)
                    PromptSetVisible(CarcassPrompt, true)
                    PromptSetEnabled(StockCarcassPrompt, true)
                    PromptSetVisible(StockCarcassPrompt, true)
                    if PromptHasHoldModeCompleted(CarcassPrompt) then
                        PromptSetEnabled(CarcassPrompt, false)
                        PromptSetVisible(CarcassPrompt, false)

                        CarcassInWagon(wagonID)
                        openMenu = true
                        Wait(1000)
                        PromptSetEnabled(CarcassPrompt, true)
                        PromptSetVisible(CarcassPrompt, true)
                    elseif PromptHasHoldModeCompleted(StockCarcassPrompt) then
                        PromptSetEnabled(StockCarcassPrompt, false)
                        PromptSetVisible(StockCarcassPrompt, false)

                        StoreCarriedEntityInWagon()
                        Wait(1000)

                        PromptSetEnabled(StockCarcassPrompt, true)
                        PromptSetVisible(StockCarcassPrompt, true)
                    end
                end
            elseif isNearWagon and not PedInVehicle and not isOwner and not openMenu then --- Aqui é a lógica de prompts para quem não é dono
                waitTime = 2                                                              -- Atualiza para checagem rápida quando perto
                local Stash = CreateVarString(10, 'LITERAL_STRING', locale['cl_your_wagon'])
                PromptSetActiveGroupThisFrame(WagonGroup, Stash)
                PromptSetEnabled(DeletePrompt, false)
                PromptSetVisible(DeletePrompt, false)


                if PromptHasHoldModeCompleted(StashPrompt) then
                    -- Desativa temporariamente o prompt para evitar múltiplos acionamentos
                    PromptSetEnabled(StashPrompt, false)
                    PromptSetVisible(StashPrompt, false)
                    -- Se o jogador for o dono da carroça, abre o inventário
                    TriggerServerEvent("btc-wagons:openWagonStash", 'Wagon_Stash_' .. wagonID, wagonModel, wagonID,
                        wagonNetId)

                    -- Pequeno delay para evitar reativação instantânea
                    Wait(500)

                    -- Reativa o prompt para futuras interações
                    PromptSetEnabled(StashPrompt, true)
                    PromptSetVisible(StashPrompt, true)
                end
                if maxAnimal > 0 then
                    PromptSetEnabled(StockCarcassPrompt, true)
                    PromptSetVisible(StockCarcassPrompt, true)
                    if PromptHasHoldModeCompleted(StockCarcassPrompt) then
                        PromptSetEnabled(StockCarcassPrompt, false)
                        PromptSetVisible(StockCarcassPrompt, false)

                        StoreCarriedEntityInWagon()
                        Wait(1000)

                        PromptSetEnabled(StockCarcassPrompt, true)
                        PromptSetVisible(StockCarcassPrompt, true)
                    end
                end
            end
            Wait(waitTime)
        end
    end)
end
---------- Dar permissão para abri inventário
RegisterNetEvent('btc-wagon:askOwnerPermission')
AddEventHandler('btc-wagon:askOwnerPermission', function(data)
    local alert = lib.alertDialog({
        header = locale['alert'],
        content = locale['player_stash'] .. data.firstname .. ' ' .. data.lastname .. locale['player_stash_02'],
        centered = true,
        cancel = true
    })
    local permission = alert
    TriggerServerEvent('btc-wagons:giveOwnerPermission', permission, data)
end)

RegisterNetEvent('btc-wagons:receiveWagonData')
AddEventHandler('btc-wagons:receiveWagonData', function(wagonModel, customData, animalsData, myWagonID)
    if mywagon and DoesEntityExist(mywagon) then
        DeleteWagon()
        Wait(500)
    end

    if wagonBlip and DoesBlipExist(wagonBlip) then
        RemoveBlip(wagonBlip)
    end

    if wagonModel then
        local model = wagonModel
        local tint = customData.tint
        local livery = customData.livery
        local props = customData.props
        local extra = customData.extra
        local lantern = customData.lantern

        SpawnWagon(model, tint, livery, props, extra, lantern, myWagonID)
    else
        Notify(locale['cl_no_wagon'], 6000, 'error')
    end
end)

RegisterNetEvent('btc-wagons:saveWagonToDatabase')
AddEventHandler('btc-wagons:saveWagonToDatabase', function(wagonModel, name, moneyType)
    local customData = {
        name = name,
        tint = 0,
        livery = -1,
        props = false,
        extra = 0,
        buyMoneyType = moneyType,
    }

    TriggerServerEvent("btc-wagons:saveWagonToDatabase", wagonModel, customData, moneyType)
end)

function DeleteWagon()
    if mywagon and DoesEntityExist(mywagon) then
        local netId = NetworkGetNetworkIdFromEntity(mywagon)

        -- Remover do servidor
        TriggerServerEvent("btc-wagons:removeWagon", netId, mywagon)
        -- DeleteVehicle(mywagon)
        mywagon = false
        RemoveBlip(wagonBlip)
        if animalStorageCache[wagonNetId] then
            animalStorageCache[wagonNetId] = nil
        end
        wagonVerificationCache[netId] = nil

        if Config.Target then
            exports.ox_target:removeEntity(netId, 'npc_wagonStash')
            exports.ox_target:removeEntity(netId, 'npc_wagonShowCarcass')
            exports.ox_target:removeEntity(netId, 'npc_wagonStockCarcass')
            exports.ox_target:removeEntity(netId, 'npc_wagonDelete')
        end

    end
end

if Config.SpawnKey then
    Citizen.CreateThread(function()
        while true do
            local sleep = 10
            if IsControlJustReleased(0, GetHashKey(Config.SpawnKey)) then
                CallWagon()
            end
            if mywagon and DoesEntityExist(mywagon) then
                sleep = 1000
            end
            Wait(sleep)
        end
    end)
end

function CallWagon()
    if mywagon and DoesEntityExist(mywagon) then
        Notify(locale['cl_have_wagon'], 6000, 'error')
        return
    end

    if wagonBlip and DoesBlipExist(wagonBlip) then
        RemoveBlip(wagonBlip)
    end

    TriggerServerEvent('btc-wagons:getWagonDataByCitizenID')
end

------------------------- Função para carcaças
if Config.Debug then
    RegisterCommand("guardar", function()
        StoreCarriedEntityInWagon()
    end)
end

----- Thanks to masmana - mas_huntingwagon
local function GetFirstEntityPedIsCarrying(ped)
    return Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
end
local function GetMetaPedAssetTint(ped, index)
    return Citizen.InvokeNative(0xE7998FEC53A33BBE, ped, index, Citizen.PointerValueInt(), Citizen.PointerValueInt(),
        Citizen.PointerValueInt(), Citizen.PointerValueInt())
end

local function GetMetaPedAssetGuids(ped, index)
    return Citizen.InvokeNative(0xA9C28516A6DC9D56, ped, index, Citizen.PointerValueInt(), Citizen.PointerValueInt(),
        Citizen.PointerValueInt(), Citizen.PointerValueInt())
end

local function GetNumComponentsInPed(ped)
    return Citizen.InvokeNative(0x90403E8107B60E81, ped, Citizen.ResultAsInteger())
end

local function GetIsCarriablePelt(entity)
    return Citizen.InvokeNative(0x255B6DB4E3AD3C3E, entity)
end

local function GetCarriableFromEntity(entity)
    return Citizen.InvokeNative(0x31FEF6A20F00B963, entity)
end

local function GetCarcassMetaTag(entity)
    local metatag = {}
    local numComponents = GetNumComponentsInPed(entity)
    for i = 0, numComponents - 1, 1 do
        local drawable, albedo, normal, material = GetMetaPedAssetGuids(entity, i)
        local palette, tint0, tint1, tint2 = GetMetaPedAssetTint(entity, i)
        metatag[i] = {
            drawable = drawable,
            albedo = albedo,
            normal = normal,
            material = material,
            palette = palette,
            tint0 = tint0,
            tint1 = tint1,
            tint2 = tint2
        }
        if Config.Debug then
            print(i, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
        end
    end
    return metatag
end

local function UpdatePedVariation(ped)
    Citizen.InvokeNative(0xAAB86462966168CE, ped, true)                           -- UNKNOWN "Fixes outfit"- always paired with _UPDATE_PED_VARIATION
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false) -- _UPDATE_PED_VARIATION
end

local function SetMetaPedTag(ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
    return Citizen.InvokeNative(0xBC6DF00D7A4A6819, ped, drawable, albedo, normal, material, palette, tint0, tint1, tint2)
end

local function GetPedMetaOutfitHash(ped)
    return Citizen.InvokeNative(0x30569F348D126A5A, ped, Citizen.ResultAsInteger())
end

local function IsEntityFullyLooted(entity)
    return Citizen.InvokeNative(0x8DE41E9902E85756, entity)
end

local function GetPedDamageCleanliness(ped)
    return Citizen.InvokeNative(0x88EFFED5FE8B0B4A, ped, Citizen.ResultAsInteger())
end


local function EquipMetaPedOutfit(ped, hash)
    return Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, hash)
end

local function ApplyCarcasMetaTag(entity, metatag)
    if not metatag or type(metatag) ~= "table" then return end

    for _, data in pairs(metatag) do
        if data then
            SetMetaPedTag(entity, data.drawable, data.albedo, data.normal, data.material, data.palette,
                data.tint0, data.tint1, data.tint2)
        end
    end

    UpdatePedVariation(entity)
end

local function SetPedDamageCleanliness(ped, damageCleanliness)
    return Citizen.InvokeNative(0x7528720101A807A5, ped, damageCleanliness)
end

local function GetPedQuality(ped)
    return Citizen.InvokeNative(0x7BCC6087D130312A, ped)
end

local function SetPedQuality(ped, quality)
    return Citizen.InvokeNative(0xCE6B874286D640BB, ped, quality)
end

local function TaskStatus(task)
    local ped = PlayerPedId()
    local count = 0
    repeat
        count = count + 1
        Wait(0)
    until (GetScriptTaskStatus(ped, task, true) == 8) or count > 100
end

function StoreCarriedEntityInWagon()
    TriggerServerCallback("btc-wagons:getAnimalStorage", function(menuData)
        local ped = PlayerPedId()
        local carriedEntity = GetFirstEntityPedIsCarrying(ped)
        local carriedModel = GetEntityModel(carriedEntity)
        local animalCheck = false

        if not carriedEntity or not DoesEntityExist(carriedEntity) then
            Notify(locale["carry_nothing"], 5000, "error")
            return
        end

        -- if not isNearWagon or not isOwner or not wagonID or not wagonNetId then
        --     Notify(locale["closest_to_wagon"], 5000, "error")
        --     return
        -- end

        -- Verifica capacidade da carroça
        local totalStored = 0
        for k, v in pairs(menuData) do
            totalStored = totalStored + (v.infos.quantity or 1)
        end

        local maxAnimal = animalStorageCache[wagonNetId] or 0 -- fallback para 10 caso não exista
        if totalStored >= maxAnimal then
            Notify(locale["wagon_full"], 5000, "error")
            return
        end

        -- Identifica tipo
        local data = {
            model = carriedModel,
        }

        if GetIsCarriablePelt(carriedEntity) then
            data.type = 'pelt'
            data.peltquality = GetCarriableFromEntity(carriedEntity)
        else
            for k, v in pairs(Config.AnimalsStorage) do
                if k == carriedModel then
                    animalCheck = true
                    break
                end
            end

            if animalCheck then
                data.type = 'animal'
                data.metatag = GetCarcassMetaTag(carriedEntity)
                data.outfit = GetPedMetaOutfitHash(carriedEntity)
                data.skinned = IsEntityFullyLooted(carriedEntity) or false
                data.damage = GetPedDamageCleanliness(carriedEntity) or 0
                data.quality = GetPedQuality(carriedEntity) or 0
            else
                Notify(locale["carry_nothing"], 5000, "error")
                return
            end
        end

        -- Armazena
        TriggerServerEvent("btc-wagons:storeAnimalInWagon", wagonID, data)
        DeleteEntity(carriedEntity)
    end, wagonID)
end

-------------- Para ver as carcaças dentro da carroça
function CarcassInWagon(wagonID)
    local carcassInWagon = {}
    TriggerServerCallback("btc-wagons:getAnimalStorage", function(menuData)
        if not menuData or #menuData == 0 then
            Notify(locale["wagon_no_animals"], 5000, "error")
            openMenu = false
            return
        end

        -- Salva no cache para próximas chamadas
        for k, v in pairs(menuData) do
            table.insert(carcassInWagon, {
                label = v.label,
                value = v.infos.type,
                infos = v.infos,
                desc = locale["animal_desc"] .. v.infos.quantity .. ' ' .. v.label .. locale["animal_desc2"],
            })
        end
        local nuifocus = false
        MenuData.Open(
            'default', GetCurrentResourceName(), 'carcass_menu',
            {
                title = locale["animals_in_wagon"],
                subtext = locale["animals_in_wagon_desc"],
                align = 'top-left',
                elements = carcassInWagon
            },
            function(data, menu)
                menu.close()
                local infos = data.current.infos
                local label = data.current.label

                TriggerServerEvent("btc-wagons:removeAnimalFromWagon", wagonID, infos, label)
                openMenu = false
            end,
            function(data, menu)
                menu.close()
                openMenu = false
            end,
            function(data, menu)
            end, nuifocus
        )
    end, wagonID)
end

RegisterNetEvent("btc-wagons:spawnAnimal")
AddEventHandler("btc-wagons:spawnAnimal", function(data)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    RequestModel(data.model)
    while not HasModelLoaded(data.model) do
        Wait(10)
    end
    if IsModelAPed(data.model) then
        cargo = CreatePed(data.model, coords.x, coords.y, coords.z, 0, true, true)
        SetEntityHealth(cargo, 0, ped)
        SetPedQuality(cargo, data.quality)
        SetPedDamageCleanliness(cargo, data.damage)
        if data.skinned then
            Wait(1000)
            Citizen.InvokeNative(0x6BCF5F3D8FFE988D, cargo, true) -- FullyLooted
            ApplyCarcasMetaTag(cargo, data.metatag)
        else
            EquipMetaPedOutfit(cargo, data.outfit)
            UpdatePedVariation(cargo)
        end
    else
        cargo = CreateObject(data.model, coords.x, coords.y, coords.z, true, true, true, 0, 0)
        Citizen.InvokeNative(0x78B4567E18B54480, cargo)                                                                  -- MakeObjectCarriable
        Citizen.InvokeNative(0xF0B4F759F35CC7F5, cargo, Citizen.InvokeNative(0x34F008A7E48C496B, cargo, 0), ped, 7, 512) -- TaskCarriable
        Citizen.InvokeNative(0x399657ED871B3A6C, cargo, data.peltquality)                                                -- SetEntityCarcassType https://pastebin.com/C1WvQjCy
    end
    Citizen.InvokeNative(0x18FF3110CF47115D, cargo, 21, true)                                                            --SetEntityCarryingFlag
    TaskPickupCarriableEntity(ped, cargo)
    SetEntityVisible(cargo, false)
    FreezeEntityPosition(cargo, true)

    TaskStatus(`SCRIPT_TASK_PICKUP_CARRIABLE_ENTITY`)

    FreezeEntityPosition(cargo, false)
    SetEntityVisible(cargo, true)
    Citizen.InvokeNative(0x18FF3110CF47115D, cargo, 21, false) --SetEntityCarryingFlag
end)

--------------- OX-TARGET


AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end

    if mywagon and DoesEntityExist(mywagon) then
        local netId = NetworkGetNetworkIdFromEntity(mywagon)

        if Config.Debug then
            print('Removendo Carroça')
        end

        -- Remover do servidor
        TriggerServerEvent("btc-wagons:removeWagon", netId, mywagon)
        -- DeleteVehicle(mywagon)
        mywagon = false
        RemoveBlip(wagonBlip)
        if animalStorageCache[wagonNetId] then
            animalStorageCache[wagonNetId] = nil
        end
        wagonVerificationCache[netId] = nil

        if Config.Target then
            exports.ox_target:removeEntity(netId, 'npc_wagonStash')
            exports.ox_target:removeEntity(netId, 'npc_wagonShowCarcass')
            exports.ox_target:removeEntity(netId, 'npc_wagonStockCarcass')
            exports.ox_target:removeEntity(netId, 'npc_wagonDelete')
        end
    end
end)
