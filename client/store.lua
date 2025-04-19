local locale = Locale[Config.Locale]


    CreateThread(function()
        for k, v in pairs(Config.Stores) do
            if Config.FrameWork == 'rsg' and not Config.Target then
                exports['rsg-core']:createPrompt("wagonStore" .. k, v.coords, GetHashKey(Config.Keys.OpenStore),
                    Config.Blip.blipName, {
                        type = 'client',
                        event = 'btc-wagons:client:openStore',
                        args = { k },
                    })
                end
            if Config.Blip.showBlip then
                local blip = BlipAddForCoords(1664425300, v.coords)
                SetBlipSprite(blip, -1747775003, true)
                SetBlipScale(blip, 0.2)
                SetBlipName(blip, Config.Blip.blipName)
            end
        end
    end)

------------------------ Show Room

local showroomWagon = nil
local showroomCam = nil

local rotationSpeed = 1.0 -- Velocidade de rotação

-- Função para criar a carroça fantasma no showroom
local isSpawningWagon = false

function SpawnShowroomWagon(model, store)
    if isSpawningWagon then
        if Config.Debug then print("⏳ Já está spawnando uma carroça, aguarde...") end
        return
    end

    isSpawningWagon = true -- trava

    local showroomCoords = Config.Stores[store].previewWagon
    local showroomCameraCoords = Config.Stores[store].cameraPreviewWagon

    -- Remove a carroça anterior se existir
    if showroomWagon and DoesEntityExist(showroomWagon) then
        DeleteEntity(showroomWagon)

        -- Aguarda a remoção completa
        local timeWaited = 0
        while DoesEntityExist(showroomWagon) and timeWaited < 2000 do
            Wait(10)
            timeWaited = timeWaited + 10
        end
    end

    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    showroomWagon = CreateVehicle(model, showroomCoords.x, showroomCoords.y, showroomCoords.z, showroomCoords.w, false,
        false)

    Citizen.InvokeNative(0x75F90E4051CC084C, showroomWagon, 0)  -- _REMOVE_ALL_VEHICLE_PROPSETS
    Citizen.InvokeNative(0x8268B098F6FCA4E2, showroomWagon, 0)  -- _SET_VEHICLE_TINT
    Citizen.InvokeNative(0xF89D82A0582E46ED, showroomWagon, -1) -- _SET_VEHICLE_LIVERY

    for i = 0, 10 do
        if DoesExtraExist(showroomWagon, i) then
            Citizen.InvokeNative(0xBB6F89150BC9D16B, showroomWagon, i, true) -- Desativa todos os extras
        end
    end

    -- Impede que a carroça se mova
    SetEntityInvincible(showroomWagon, true)
    FreezeEntityPosition(showroomWagon, true)

    -- Ativa a câmera para visualização
    SetUpShowroomCamera(showroomCameraCoords, showroomWagon)

    -- Libera para novos spawns
    Wait(250) -- leve delay pra garantir segurança
    isSpawningWagon = false
end

-- Função para configurar a câmera fixa no showroom
function SetUpShowroomCamera(cameraPosition, targetEntity)
    local playerPed = PlayerPedId()

    -- Congelar o jogador no local
    FreezeEntityPosition(playerPed, true)
    SetEntityInvincible(playerPed, true) -- Garantir que o jogador não possa ser derrubado

    -- Criando a câmera
    showroomCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(showroomCam, cameraPosition.x, cameraPosition.y, cameraPosition.z) -- Distância fixa da carroça
    PointCamAtEntity(showroomCam, targetEntity, 0, 0, 0, true)                     -- Aponta a câmera para a carroça

    SetCamActive(showroomCam, true)
    RenderScriptCams(true, false, 0, true, true)

    -- Configuração do zoom (ajustar a distância da câmera)
    SetCamFov(showroomCam, 50.0) -- Ajuste o FOV para zoom

    -- Impede a movimentação da câmera
    SetEntityInvincible(showroomCam, true) -- A câmera não pode ser derrubada
end

local inputLeft = GetHashKey("INPUT_DIVE")
local inputRight = GetHashKey("INPUT_LOOT_VEHICLE")

function ShowRotatePrompt()
    Citizen.CreateThread(function()
        -- Criar um novo grupo de prompts
        rotatePromptGroup = PromptGetGroupIdForTargetEntity(PlayerPedId()) -- Garante que o grupo será válido

        -- Criar o prompt para girar para a esquerda (A)
        rotateLeftPrompt = PromptRegisterBegin()
        PromptSetControlAction(rotateLeftPrompt, inputLeft) -- INPUT_MOVE_LEFT_ONLY (A)
        PromptSetText(rotateLeftPrompt, CreateVarString(10, "LITERAL_STRING", locale["left"]))
        PromptSetEnabled(rotateLeftPrompt, true)
        PromptSetVisible(rotateLeftPrompt, true)
        PromptSetStandardMode(rotateLeftPrompt, true)       -- Modo padrão de clique
        PromptSetGroup(rotateLeftPrompt, rotatePromptGroup) -- Adicionar ao grupo
        PromptRegisterEnd(rotateLeftPrompt)

        -- Criar o prompt para girar para a direita (D)
        rotateRightPrompt = PromptRegisterBegin()
        PromptSetControlAction(rotateRightPrompt, inputRight) -- INPUT_MOVE_RIGHT_ONLY (D)
        PromptSetText(rotateRightPrompt, CreateVarString(10, "LITERAL_STRING", locale["right"]))
        PromptSetEnabled(rotateRightPrompt, true)
        PromptSetVisible(rotateRightPrompt, true)
        PromptSetStandardMode(rotateRightPrompt, true)       -- Modo padrão de clique
        PromptSetGroup(rotateRightPrompt, rotatePromptGroup) -- Adicionar ao grupo
        PromptRegisterEnd(rotateRightPrompt)

        -- Criar um loop para manter o grupo ativo
        Citizen.CreateThread(function()
            while rotatePromptGroup do
                Citizen.Wait(0)
                PromptSetActiveGroupThisFrame(rotatePromptGroup, CreateVarString(10, "LITERAL_STRING", "Girar Carroça"))
            end
        end)
        ---- Cria o loop de rotação
        Citizen.CreateThread(function()
            while rotatePromptGroup do
                Citizen.Wait(0)
                RotateShowroomWagon()
            end
        end)
    end)
end

-- Função para remover os prompts quando fechar o menu
function HideRotatePrompt()
    if rotateLeftPrompt then
        PromptDelete(rotateLeftPrompt)
        rotateLeftPrompt = nil
    end
    if rotateRightPrompt then
        PromptDelete(rotateRightPrompt)
        rotateRightPrompt = nil
    end
    rotatePromptGroup = nil
end

-- Função para rotacionar a carroça com A e D
function RotateShowroomWagon()
    if showroomWagon then
        -- Verificar se a tecla A foi pressionada
        if IsControlPressed(0, inputLeft) then                              -- A (esquerda)
            local currentHeading = GetEntityHeading(showroomWagon)
            SetEntityHeading(showroomWagon, currentHeading - rotationSpeed) -- Gira para a esquerda
            -- Verificar se a tecla D foi pressionada
        elseif IsControlPressed(0, inputRight) then                         -- D (direita)
            local currentHeading = GetEntityHeading(showroomWagon)
            SetEntityHeading(showroomWagon, currentHeading + rotationSpeed) -- Gira para a direita
        end
    end
end

-- Função para remover a carroça e restaurar a câmera
function CloseShowroom()
    if showroomWagon then
        DeleteEntity(showroomWagon)
        showroomWagon = nil
    end

    if showroomCam then
        DestroyCam(showroomCam, false)
        RenderScriptCams(false, false, 0, true, true)
        showroomCam = nil
    end

    local playerPed = PlayerPedId()

    -- Liberar o controle do jogador e a câmera
    FreezeEntityPosition(playerPed, false)
    SetEntityInvincible(playerPed, false) -- Liberar a invencibilidade

    -- Desligar a câmera
    RenderScriptCams(false, false, 0, true, true)
end

-------------------------------------- Show your wagon

-- Função para criar a carroça fantasma no showroom
function SpawnShowroomMyWagon(model, store, custom)
    local showroomCoords = Config.Stores[store].previewWagon
    local showroomCameraCoords = Config.Stores[store].cameraPreviewWagon

    -- Se a carroça já existe, apenas atualizamos suas propriedades
    if showroomWagon and DoesEntityExist(showroomWagon) then
        UpdateShowroomWagonVisuals(showroomWagon, custom)
        return -- Evita recriação do veículo
    end

    -- Caso não exista, cria uma nova
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end

    showroomWagon = CreateVehicle(model, showroomCoords.x, showroomCoords.y, showroomCoords.z, showroomCoords.w, false,
        false)

    -- Chama a função para aplicar as propriedades
    UpdateShowroomWagonVisuals(showroomWagon, custom)

    -- Impede que a carroça se mova
    SetEntityInvincible(showroomWagon, true)
    FreezeEntityPosition(showroomWagon, true)

    -- Ativa a câmera para visualização
    SetUpShowroomCamera(showroomCameraCoords, showroomWagon)
end

-- Função separada para atualizar apenas as propriedades visuais
function UpdateShowroomWagonVisuals(wagon, custom)
    if not DoesEntityExist(wagon) then return end

    Citizen.InvokeNative(0x75F90E4051CC084C, wagon, 0) -- _REMOVE_ALL_VEHICLE_PROPSETS

    -- Aplicando propriedades específicas
    if custom.props then
        Citizen.InvokeNative(0x75F90E4051CC084C, wagon, GetHashKey(custom.props)) -- _ADD_VEHICLE_PROPSETS
        Citizen.InvokeNative(0x31F343383F19C987, wagon, 0.5, 1)                   -- _SET_VEHICLE_TARP_HEIGHT
    end

    -- Remove as lanternas antigas corretamente
    Citizen.InvokeNative(0xE31C0CB1C3186D40, wagon) -- _REMOVE_ALL_VEHICLE_LANTERN_PROPSETS
    Wait(50)                                        -- Aguarde um tempo para garantir que foram removidas

    -- Adiciona a nova lanterna
    if custom.lantern then
        Citizen.InvokeNative(0xC0F0417A90402742, wagon, GetHashKey(custom.lantern)) -- _ADD_VEHICLE_LANTERN_PROPSETS
    end

    -- Pequeno delay para garantir atualização visual
    Wait(50)

    -- Força a atualização do veículo para evitar bugs visuais
    Citizen.InvokeNative(0xAD738C3085FE7E11, wagon, true, true) -- Set entity as mission entity
    Citizen.InvokeNative(0x9617B6E5F65329A5, wagon)             -- Force vehicle update

    -- Aplicação de outros visuais
    Citizen.InvokeNative(0x8268B098F6FCA4E2, wagon, custom.tint or 0)   -- _SET_VEHICLE_TINT
    Citizen.InvokeNative(0xF89D82A0582E46ED, wagon, custom.livery or 0) -- _SET_VEHICLE_LIVERY

    -- Desativando extras aleatórios
    for i = 0, 10 do
        if DoesExtraExist(wagon, i) then
            Citizen.InvokeNative(0xBB6F89150BC9D16B, wagon, i, true) -- Desativa todos os extras
        end
    end
    if custom.extra then
        Citizen.InvokeNative(0xBB6F89150BC9D16B, wagon, custom.extra, false) -- Ativa o extra desejado
    end
end

-- Função para configurar a câmera fixa no showroom
function SetUpShowroomCamera(cameraPosition, targetEntity)
    local playerPed = PlayerPedId()

    -- Congelar o jogador no local
    FreezeEntityPosition(playerPed, true)
    SetEntityInvincible(playerPed, true) -- Garantir que o jogador não possa ser derrubado

    -- Criando a câmera
    showroomCam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamCoord(showroomCam, cameraPosition.x, cameraPosition.y, cameraPosition.z) -- Distância fixa da carroça
    PointCamAtEntity(showroomCam, targetEntity, 0, 0, 0, true)                     -- Aponta a câmera para a carroça

    SetCamActive(showroomCam, true)
    RenderScriptCams(true, false, 0, true, true)

    -- Configuração do zoom (ajustar a distância da câmera)
    SetCamFov(showroomCam, 50.0) -- Ajuste o FOV para zoom

    -- Impede a movimentação da câmera
    SetEntityInvincible(showroomCam, true) -- A câmera não pode ser derrubada
end

if Config.Debug then
    RegisterCommand("closeshowroom", function()
        CloseShowroom()
        MenuData.CloseAll()
    end, false)
end
