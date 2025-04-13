local locale = Locale[Config.Locale]

MenuData = {}
TriggerEvent("redemrp_menu_base:getData", function(call)
    MenuData = call
end)

RegisterNetEvent('btc-wagons:client:openStore')
AddEventHandler('btc-wagons:client:openStore', function(store)
    MenuData.CloseAll()
    local menuData = {
        {
            label = locale["cl_your_wagons"],
            value = "mywagons",
            description = locale["cl_see_your_wagons"],
        },
        {
            label = locale["cl_wagon_buy"],
            value = "buywagontype",
            desc = locale["cl_wagon_buy_desc"],
        }
    }
    local nuifocus = false
    -- Criando o menu
    Wait(300)
    MenuData.Open(
        'default', GetCurrentResourceName(), 'store_menu',
        {
            title = locale["cl_wagon_store"],
            subtext = locale["cl_wagon_store_desc"],
            align = 'top-left',
            elements = menuData
        },
        function(data, menu)
            if data.current.value == "buywagontype" then
                menu.close()
                BuyTypeWagonMenu(store)
            end
            if data.current.value == "mywagons" then
                menu.close()
                MyWagons(store)
            end
        end,
        function(data, menu)
            -- Função de fechamento do menu
            menu.close()
        end,
        function(data, menu)
            -- Função de fechamento do menu
        end, nuifocus
    )
end)

local wagonsTypeData = {}

for type, wagons in pairs(Config.Wagons) do
    table.insert(wagonsTypeData, {
        label = locale[type],
        value = type,
        desc = "Escolha o modelo de carroça",
    })
end

-- Ordena a lista alfabeticamente pelo label
table.sort(wagonsTypeData, function(a, b)
    return a.label:lower() < b.label:lower()
end)

function BuyTypeWagonMenu(store)
    MenuData.CloseAll()
    local nuifocus = false

    -- Criando o menu com a lista ordenada
    MenuData.Open(
        'default', GetCurrentResourceName(), 'store_menu_type',
        {
            title = locale["cl_wagon_store"],
            subtext = locale["cl_wagon_store_desc"],
            align = 'top-left',
            elements = wagonsTypeData
        },
        function(data, menu)
            menu.close()
            BuyWagonMenu(store, data.current.value)
        end,
        function(data, menu)
            CloseShowroom()
            menu.close()
        end,
        function(data, menu)
            -- Função de escolha no menu
        end, nuifocus
    )
end

function BuyWagonMenu(store, wagonType)
    local menuCooldown = false
    ShowRotatePrompt()
    local wagonsData = {}
    local sortedWagons = {}

    for type, wagons in pairs(Config.Wagons) do
        if type == wagonType then
            for k, v in pairs(wagons) do
                table.insert(sortedWagons, {
                    name = v.name,
                    price = v.price,
                    priceGold = v.priceGold, -- Adiciona preço em ouro
                    model = k
                })
            end
        end
    end

    -- Ordenar pelo preço (do menor para o maior, considerando price como prioridade)
    table.sort(sortedWagons, function(a, b)
        return (a.price or math.huge) < (b.price or math.huge)
    end)

    for _, v in ipairs(sortedWagons) do
        local priceText = ""
        local useCash = false
        local useGold = false

        -- Construindo a string do preço com base no que está disponível
        if v.price then
            priceText = "💰" .. v.price .. " "
            useCash = true
        end
        if v.priceGold then
            if priceText ~= "" then
                priceText = priceText .. " ou " -- Adiciona separador se ambos existirem
            end
            priceText = priceText .. ' 🪙' .. v.priceGold --
            useGold = true
        end

        table.insert(wagonsData, {
            label = v.name,
            value = "",
            wagonModel = v.model,
            desc = locale["buy_a_wagon"] .. priceText,
            useCash = useCash,
            useGold = useGold
        })
    end

    SpawnShowroomWagon(wagonsData[1].wagonModel, store) -- Carregar a carroça do primeiro item da lista

    -- Criando o menu
    MenuData.Open(
        'default', GetCurrentResourceName(), 'store_menu_type',
        {
            title = locale["cl_wagon_store"],
            subtext = locale["cl_wagon_store_desc"],
            align = 'top-left',
            elements = wagonsData
        },
        function(data, menu)
            local moneyType

            if data.current.useCash and data.current.useGold then
                local input = lib.inputDialog(locale["payment"], {
                    {
                        type = 'select',
                        label = locale['choose'],
                        options = {
                            { value = 'cash', label = locale['cashtype'] },
                            { value = 'gold', label = locale['goldtype'] }
                        }
                    }
                })

                if input and input[1] then
                    moneyType = input[1]
                else
                    print("DEBUG: Nenhuma opção de pagamento foi selecionada. Fechando o menu.")
                    CloseShowroom()
                    HideRotatePrompt()
                    menu.close()
                    return
                end
            else
                if data.current.useCash then
                    moneyType = 'cash'
                else
                    moneyType = 'gold'
                end
            end

            local nameInput = lib.inputDialog(locale['cl_wagon_name'], {
                { type = 'input', label = locale['cl_wagon_name_label'], description = locale['cl_wagon_name_desc'], required = true, min = 1, max = 16 },
            })

            if not nameInput or not nameInput[1] then
                print("DEBUG: Nome da carroça não foi inserido. Cancelando.")
                CloseShowroom()
                HideRotatePrompt()
                menu.close()
                return
            end

            CloseShowroom()
            HideRotatePrompt()
            menu.close()

            TriggerEvent("btc-wagons:saveWagonToDatabase", data.current.wagonModel, nameInput[1], moneyType)
        end,
        function(data, menu)
            CloseShowroom()
            HideRotatePrompt()
            menu.close()
        end,
        function(data, menu)
            if menuCooldown then return end
            menuCooldown = true

            SpawnShowroomWagon(data.current.wagonModel, store)
            Wait(100)
            menuCooldown = false
        end
    )
end

------------------- Minhas Carroças


function MyWagons(store)
    TriggerServerCallback("btc-wagons:checkMyWagons", function(wagons, custom)
        local myWagonsData = {}
        if wagons and #wagons > 0 then
            myWagonsData = {} -- Resetar a tabela para evitar duplicação de entradas

            for i, wagon in ipairs(wagons) do
                local wagonCustom = custom[i] or {} -- Garante que não seja nil

                table.insert(myWagonsData, {
                    label = wagonCustom.name or locale["cl_no_name"],
                    value = wagon,
                    custom = wagonCustom,
                    desc = "Sua carroça modelo " .. wagon,
                })
            end

            -- Ordenar a tabela alfabeticamente pelo nome
            table.sort(myWagonsData, function(a, b)
                return a.label:lower() < b.label:lower()
            end)

            MenuData.CloseAll()
            local nuifocus = false
            MenuData.Open(
                'default', GetCurrentResourceName(), 'mywagons_menu',
                {
                    title = locale["cl_your_wagons"],
                    subtext = locale["cl_your_wagons_desc"],
                    align = 'top-left',
                    elements = myWagonsData
                },
                function(data, menu)
                    SpawnShowroomMyWagon(data.current.value, store, data.current.custom) -- Carregar a carroça do primeiro item na lista)
                    SelectMyWagon(store, data.current.custom, data.current.value)        -- Carregar a carroça do primeiro item na lista)
                end,
                function(data, menu)
                    CloseShowroom()
                    menu.close()
                end,
                function(data, menu)
                end, nuifocus
            )
        else
            Notify(locale["cl_no_have_wagon"], 5000, "error")
        end
    end)
end

function SelectMyWagon(store, custom, wagonModel)
    ShowRotatePrompt()
    local myWagonCustomData = {}
    currentWagonCustom = custom or {}

    -- Adiciona a opção "Ativar Carroça" no topo
    table.insert(myWagonCustomData, {
        label = (locale["activate_wagon"] or "Ativar Carroça"),
        value = "activate",
        desc = locale["activate_wagon_desc"] or "Ative sua carroça e a leve para o mapa.",
    })

    -- Adiciona as opções normais
    for type, _ in pairs(Custom) do
        for wagon, item in pairs(Custom[type]) do
            if wagonModel == wagon then
                table.insert(myWagonCustomData, {
                    label = locale[type] .. " - $" .. Config.CustomPrice[type],
                    value = type,
                    custom = currentWagonCustom[type] or {},
                    desc = locale[type .. "_desc"] or "Sem descrição",
                })
            end
        end
    end

    -- Ordena mantendo "Ativar Carroça" no topo
    table.sort(myWagonCustomData, function(a, b)
        if a.value == "activate" then return true end
        if b.value == "activate" then return false end
        return a.label:lower() < b.label:lower()
    end)

    -- Adiciona "Vender Carroça" no final da lista
    table.insert(myWagonCustomData, {
        label = "🛑 " .. (locale["sell_wagon"] or "Vender Carroça"),
        value = "sell",
        desc = locale["sell_wagon_desc"] or "Venda essa carroça e recupere parte do valor pago.",
    })

    local nuifocus = false
    MenuData.Open(
        'default', GetCurrentResourceName(), 'editmywagon_menu',
        {
            title = locale["cl_your_wagons"] or "Suas Carroças",
            subtext = locale["cl_your_wagons_desc"] or "Edite sua carroça",
            align = 'top-left',
            elements = myWagonCustomData
        },
        function(data, menu)
            local value = data.current.value
            if value == "activate" then
                TriggerServerEvent("btc-wagons:toggleWagonActive", wagonModel, currentWagonCustom)
                CloseShowroom()
                HideRotatePrompt()
                menu.close()
            elseif value == "sell" then
                -- Trigger para vender carroça
                local confirm = lib.inputDialog(locale["want_sell"], {
                    {
                        type = 'select',
                        label = locale['choose'],
                        options = {
                            { value = 'yes', label = locale['yes'] },
                            { value = 'no',  label = locale['no'] }
                        }
                    }
                })

                if confirm[1] == 'yes' then
                    TriggerServerEvent("btc-wagons:sellWagon", wagonModel, currentWagonCustom)
                end
                CloseShowroom()
                HideRotatePrompt()
                menu.close()
            elseif value == "livery" then
                EditLivery(store, currentWagonCustom, wagonModel, value)
            elseif value == "extra" then
                EditExtra(store, currentWagonCustom, wagonModel, value)
            elseif value == "tint" then
                EditWagonTint(store, currentWagonCustom, wagonModel, value)
            elseif value == "props" then
                EditWagonProps(store, currentWagonCustom, wagonModel, value)
            elseif value == "lantern" then
                EditLantern(store, currentWagonCustom, wagonModel, value)
            end
        end,
        function(data, menu)
            CloseShowroom()
            HideRotatePrompt()
            menu.close()
        end,
        function(data, menu)
            -- Callback de seleção (opcional)
        end, nuifocus
    )
end

function EditLivery(store, custom, wagonModel, type)
    local currentWagonShowCustom = {}
    for k, v in pairs(currentWagonCustom) do
        currentWagonShowCustom[k] = v
    end
    local myLiveryCustom = {}
    -- Adiciona a opção de remover no topo
    table.insert(myLiveryCustom, {
        label = "❌ " .. locale["remove"],
        value = -1,
        desc = "Remova o livery atual",
    })


    local firstLivery = nil

    -- Adiciona os liveries disponíveis
    for k, v in pairs(Custom[type][wagonModel]) do
        table.insert(myLiveryCustom, {
            label = v[2], -- Nome do livery
            value = v[1], -- ID do livery
            desc = locale[type .. "_desc"] or "Sem descrição",
        })
        if not firstLivery then
            firstLivery = v[1]
        end
    end

    if firstLivery then
        currentWagonCustom[type] = firstLivery
        SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
    end

    -- Ordena os liveries (mantendo "Remover" no topo)
    table.sort(myLiveryCustom, function(a, b)
        return a.value ~= false and (b.value == false or a.label:lower() < b.label:lower())
    end)

    local nuifocus = false
    MenuData.Open(
        'default', GetCurrentResourceName(), 'editlivery_menu',
        {
            title = locale["cl_your_wagons"] or "Suas Carroças",
            subtext = locale["cl_your_wagons_desc"] or "Edite sua carroça",
            align = 'top-left',
            elements = myLiveryCustom
        },
        function(data, menu)
            -- Se "Remover" for selecionado, define o livery como falso
            currentWagonCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            TriggerServerEvent("btc-wagons:saveCustomization", wagonModel, currentWagonCustom, type)
        end,
        function(data, menu)
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            menu.close()
        end,
        function(data, menu)
            currentWagonShowCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonShowCustom)

            if Config.Debug then
                print(data.current.value)
            end
        end, nuifocus
    )
end

function EditExtra(store, custom, wagonModel, type)
    local myExtraCustom = {}
    local currentWagonShowCustom = {}
    for k, v in pairs(currentWagonCustom) do
        currentWagonShowCustom[k] = v
    end

    -- Adiciona a opção de remover no topo
    table.insert(myExtraCustom, {
        label = "❌ " .. locale["remove"],
        value = 0,
        desc = "Romova a opção atual",
    })


    local firstExtra = nil

    -- Adiciona os liveries disponíveis
    for k, v in pairs(Custom[type][wagonModel]) do
        table.insert(myExtraCustom, {
            label = tostring(v), -- Nome do extra
            value = k,           -- ID do extra
            desc = locale[type .. "_desc"] or "Sem descrição",
        })
        if not firstExtra then
            firstExtra = k
        end
    end

    if firstExtra then
        currentWagonCustom[type] = firstExtra
        SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
    end

    -- Ordena os liveries (mantendo "Remover" no topo)
    table.sort(myExtraCustom, function(a, b)
        return a.value ~= false and (b.value == false or a.label:lower() < b.label:lower())
    end)

    local nuifocus = false
    MenuData.Open(
        'default', GetCurrentResourceName(), 'editlivery_menu',
        {
            title = locale["cl_your_wagons"] or "Suas Carroças",
            subtext = locale["cl_your_wagons_desc"] or "Edite sua carroça",
            align = 'top-left',
            elements = myExtraCustom
        },
        function(data, menu)
            -- Se "Remover" for selecionado, define o livery como falso
            currentWagonCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            TriggerServerEvent("btc-wagons:saveCustomization", wagonModel, currentWagonCustom, type)
        end,
        function(data, menu)
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            menu.close()
        end,
        function(data, menu)
            currentWagonShowCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonShowCustom)

            if Config.Debug then
                print(data.current.value)
            end
        end, nuifocus
    )
end

function EditLantern(store, custom, wagonModel, type)
    local myLanternCustom = {}
    local currentWagonShowCustom = {}
    for k, v in pairs(currentWagonCustom) do
        currentWagonShowCustom[k] = v
    end

    -- Adiciona a opção de remover no topo
    table.insert(myLanternCustom, {
        label = "❌ " .. locale["remove"],
        value = false,
        desc = "Romova a opção atual",
    })


    local firstLantern = nil

    -- Adiciona os liveries disponíveis
    for k, v in pairs(Custom[type][wagonModel]) do
        table.insert(myLanternCustom, {
            label = tostring(k), -- Nome do extra
            value = v,           -- ID do extra
            desc = locale[type .. "_desc"] or "Sem descrição",
        })
        if not firstLantern then
            firstLantern = v
        end
    end

    if firstLantern then
        currentWagonCustom[type] = firstLantern
        SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
    end

    -- Ordena os liveries (mantendo "Remover" no topo)
    table.sort(myLanternCustom, function(a, b)
        return a.value ~= false and (b.value == false or a.label:lower() < b.label:lower())
    end)

    local nuifocus = false
    MenuData.Open(
        'default', GetCurrentResourceName(), 'editlivery_menu',
        {
            title = locale["cl_your_wagons"] or "Suas Carroças",
            subtext = locale["cl_your_wagons_desc"] or "Edite sua carroça",
            align = 'top-left',
            elements = myLanternCustom
        },
        function(data, menu)
            -- Se "Remover" for selecionado, define o livery como falso
            currentWagonCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            TriggerServerEvent("btc-wagons:saveCustomization", wagonModel, currentWagonCustom, type)
        end,
        function(data, menu)
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            menu.close()
        end,
        function(data, menu)
            currentWagonShowCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonShowCustom)

            if Config.Debug then
                print(data.current.value)
            end
        end, nuifocus
    )
end

function EditWagonProps(store, custom, wagonModel, type)
    local myPropsCustom = {}
    local currentWagonShowCustom = {}
    for k, v in pairs(currentWagonCustom) do
        currentWagonShowCustom[k] = v
    end

    -- Adiciona a opção de remover no topo
    table.insert(myPropsCustom, {
        label = "❌ " .. locale["remove"],
        value = false,
        desc = "Remova a opção atual",
    })

    local firstProp = nil
    local orderedProps = {}

    -- Coleta os elementos para manter a ordem das chaves
    for k, v in pairs(Custom[type][wagonModel]) do
        table.insert(orderedProps, { key = k, value = v })
    end

    -- Ordena pelos índices (k)
    table.sort(orderedProps, function(a, b)
        return tonumber(a.key) < tonumber(b.key) -- Garante a ordem numérica
    end)

    -- Adiciona os elementos ordenados ao menu
    for _, prop in ipairs(orderedProps) do
        table.insert(myPropsCustom, {
            label = tostring(prop.key), -- Nome do extra
            value = prop.value,         -- ID do extra
            desc = locale[type .. "_desc"] or "Sem descrição",
        })
        if not firstProp then
            firstProp = prop.value
        end
    end

    -- Aplica a primeira opção ao veículo, se disponível
    if firstProp then
        currentWagonCustom[type] = firstProp
        SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
    end

    currentWagonShowCustom = {}
    currentWagonShowCustom = currentWagonCustom

    local nuifocus = false
    MenuData.Open(
        'default', GetCurrentResourceName(), 'editlivery_menu',
        {
            title = locale["cl_your_wagons"] or "Suas Carroças",
            subtext = locale["cl_your_wagons_desc"] or "Edite sua carroça",
            align = 'top-left',
            elements = myPropsCustom
        },
        function(data, menu)
            -- Se "Remover" for selecionado, define o livery como falso
            currentWagonShowCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            TriggerServerEvent("btc-wagons:saveCustomization", wagonModel, currentWagonCustom, type)
        end,
        function(data, menu)
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            menu.close()
        end,
        function(data, menu)
            currentWagonShowCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonShowCustom)
            if Config.Debug then
                print(data.current.value)
            end
        end, nuifocus
    )
end

function EditWagonTint(store, custom, wagonModel, type)
    local myTintCustom = {}
    local currentWagonShowCustom = {}
    for k, v in pairs(currentWagonCustom) do
        currentWagonShowCustom[k] = v
    end

    -- Adiciona a opção de remover no topo
    table.insert(myTintCustom, {
        label = "❌ " .. locale["remove"],
        value = 0,
        desc = "Remova a opção atual",
    })

    local maxTints = Custom[type][wagonModel] -- Pegamos diretamente o valor máximo
    local firstTints = nil

    -- Adiciona os valores de 1 até maxTints
    for i = 1, maxTints do
        table.insert(myTintCustom, {
            label = tostring(i),
            value = i,
            desc = locale[type .. "_desc"] or "Sem descrição",
        })
        if not firstTints then
            firstTints = i
        end
    end

    -- Aplica a primeira opção ao veículo, se disponível
    if firstTints then
        currentWagonCustom[type] = firstTints
        SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
    end

    currentWagonShowCustom = {}
    currentWagonShowCustom = currentWagonCustom

    local nuifocus = false
    MenuData.Open(
        'default', GetCurrentResourceName(), 'editlivery_menu',
        {
            title = locale["cl_your_wagons"] or "Suas Carroças",
            subtext = locale["cl_your_wagons_desc"] or "Edite sua carroça",
            align = 'top-left',
            elements = myTintCustom
        },
        function(data, menu)
            currentWagonCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            TriggerServerEvent("btc-wagons:saveCustomization", wagonModel, currentWagonCustom, type)
        end,
        function(data, menu)
            SpawnShowroomMyWagon(wagonModel, store, currentWagonCustom)
            menu.close()
        end,
        function(data, menu)
            currentWagonShowCustom[type] = data.current.value
            SpawnShowroomMyWagon(wagonModel, store, currentWagonShowCustom)
            if Config.Debug then
                print(data.current.value)
            end
        end, nuifocus
    )
end

---- Menu que rouba ou pede permissão
RegisterNetEvent('btc-wagons:stashPermission')
AddEventHandler('btc-wagons:stashPermission', function(info)
    MenuData.CloseAll()
    local menuData = {}
    if Config.Robbery.isRobbery then
        menuData = {
            {
                label = locale["get_permission"],
                value = "getpermission",
                description = locale["get_permission_desc"],
            },
            {
                label = locale["rob_stash"],
                value = "rob",
                desc = locale["rob_stash_desc"],
            }
        }
    else
        menuData = {
            {
                label = locale["get_permission"],
                value = "getpermission",
                description = locale["get_permission_desc"],
            },
        }
    end
    local nuifocus = false
    -- Criando o menu
    Wait(300)
    MenuData.Open(
        'default', GetCurrentResourceName(), 'stash_menu',
        {
            title = locale["stash_menu"],
            subtext = locale["stash_menu_desc"],
            align = 'top-left',
            elements = menuData
        },
        function(data, menu)
            if data.current.value == "getpermission" then
                menu.close()
                TriggerServerEvent('btc-wagons:getOwnerPermission', info)
            end
            if data.current.value == "rob" then
                menu.close()
                if Config.Robbery.lockpick then
                    local hasItem = HasItem(Config.Robbery.lockpick)
                    if hasItem then
                        local lockpick = exports['lockpick']:lockpick()
                        if lockpick then
                            TriggerServerEvent('btc-wagons:robWagonStash', info)
                        else
                            Notify(locale["fail_lockpick"], 5000, "error")
                            TriggerServerEvent('btc-wagons:removeItem')
                        end
                    else
                        Notify(locale["no_have_item"] .. Config.Robbery.lockpickLabel, 5000, "error")
                    end
                end
            end
        end,
        function(data, menu)
            -- Função de fechamento do menu
            menu.close()
        end,
        function(data, menu)
            -- Função de fechamento do menu
        end, nuifocus
    )
end)
