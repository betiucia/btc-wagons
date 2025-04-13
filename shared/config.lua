Config = {}
Config.FrameWork = 'rsg'               -- Qual framework está utilizando, no caso o rsg
Config.Locale = 'pt-br'                -- Idioma que está utilizando, no caso o português
Config.Debug = false                    -- Ativar debug para ver os logs no console do servidor



------
Config.SpawnKey = "INPUT_OPEN_JOURNAL" -- Tecla para abrir chamar a carroça, para desativar utilize false
-- Caso queira utilizar uma chamda externa (Por exemplo rsg-radialmenu) utilize:
-- Call: TriggerEvent('btc-wagons:client:callwagon')
-- Delete: TriggerEvent('btc-wagons:client:dellwagon')

Config.SpawnRadius = 100

Config.MoneyType = {
    money = "cash",
    gold = "bloodmoney",
}

Config.Robbery = {
    isRobbery = true,           -- se tem roubo ou não
    lockpickLabel = 'Lockpick', -- Nome do item aparecer nas notificações
    lockpick = 'water',         -- Item que é a lockpick
}

Config.maxWagonsPerPlayer = 5
Config.Sell = 0.1               -- Porcentagem do valor que será devolvido ao vender a carroça, no caso 0.1 = 10% do valor total

Config.Keys = {
    OpenWagonStash = "INPUT_CREATOR_ACCEPT",      -- Tecla para abrir o inventário da carroça
    OpenStore = "INPUT_CREATOR_ACCEPT",           -- Tecla para abrir o menu da loja
    FleeWagon = 'INPUT_FRONTEND_CANCEL',          -- Tecla para mandar a carroça embora
    CarcassMenu = 'INPUT_INTERACT_LOCKON_ANIMAL', -- Tecla para abrir o menu de carcaça
    SeeCarcass = 'INPUT_DOCUMENT_PAGE_PREV',      -- Tecla para abrir o menu de carcaça guardada
}

Config.Blip = {
    showBlip = true,               -- Mostrar o blip no mapa
    blipModel = "caravan",         -- Modelo do blip que será exibido no mapa
    blipName = "Loja de Carroças", -- Nome do blip que será exibido no mapa
}

Config.Stores = {
    Valentine = {
        coords = vector3(-355.11, 775.18, 116.22),            -- Coordenadas do local onde o menu será aberto
        npcmodel = `a_m_m_nbxlaborers_01`,                    -- Modelo do NPC que abrirá o menu
        npccoords = vector4(-355.11, 775.18, 116.22, 321.41), -- Coordenadas do NPC que abrirá o menu
        previewWagon = vec4(-371.76, 786.87, 115.16, 272.08), -- Local Para visualizar a carroça
    }
}

Config.Wagons = {
    work = {
        wagon02x = {                            -- Hash modelo da carroça
            name = "Carroça de Acampamento 02", -- Nome que será exibido no menu de compra
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 1,                      -- Preço da carroça em gold
            maxAnimals = 10,                    -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagon03x = {                            -- Hash modelo da carroça
            name = "Carroça de Acampamento 03", -- Nome que será exibido no menu de compra
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 1,                      -- Preço da carroça em gold
            maxAnimals = 10,                    -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagon04x = {                            -- Hash modelo da carroça
            name = "Carroça de Acampamento 04", -- Nome que será exibido no menu de compra
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 1,                      -- Preço da carroça em gold
            maxAnimals = 10,                    -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagon05x = {                            -- Hash modelo da carroça
            name = "Carroça de Acampamento 05", -- Nome que será exibido no menu de compra
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 1,                      -- Preço da carroça em gold
            maxAnimals = 10,                    -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagon06x = {                            -- Hash modelo da carroça
            name = "Carroça de Acampamento 06", -- Nome que será exibido no menu de compra
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 1,                      -- Preço da carroça em gold
            maxAnimals = 10,                    -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart01 = {                              -- Hash modelo da carroça
            name = "Carroça de Camponês 01",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart02 = {                              -- Hash modelo da carroça
            name = "Carroça de Camponês 02",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart03 = {                              -- Hash modelo da carroça
            name = "Carroça de Camponês 03",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart04 = {                              -- Hash modelo da carroça
            name = "Carroça de Camponês 04",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart05 = {                              -- Hash modelo da carroça
            name = "Transporte de Liquidos",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart06 = {                              -- Hash modelo da carroça
            name = "Carroça de Carga 01",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart07 = {                              -- Hash modelo da carroça
            name = "Carroça de Camponês 05",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        cart08 = {                              -- Hash modelo da carroça
            name = "Carroça de Camponês 06",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        chuckwagon000x = {                      -- Hash modelo da carroça
            name = "Carroça de Acampamento 01",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        chuckwagon002x = {                      -- Hash modelo da carroça
            name = "Carroça de Carga 02",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        coal_wagon = {                          -- Hash modelo da carroça
            name = "Transporte de Carvão",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        gatchuck = {                            -- Hash modelo da carroça
            name = "Carroça de Carga 03",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        huntercart01 = {                        -- Hash modelo da carroça
            name = "Carroça de Caça",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = 30,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        oilwagon01x = {                         -- Hash modelo da carroça
            name = "Transporte de Óleo 01",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        oilwagon02x = {                         -- Hash modelo da carroça
            name = "Transporte de Óleo 02",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        supplywagon = {                         -- Hash modelo da carroça
            name = "Carroça de Carga Grande",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        utilliwag = {                           -- Hash modelo da carroça
            name = "Carroça de Carga Baixa",
            maxWeight = 100,                    -- Peso máximo que a carroça pode carregar
            slots = 20,                         -- Número de slots disponíveis na carroça
            price = 25,                         -- Preço da carroça
            priceGold = 18,                     -- Preço da carroça em gold
            maxAnimals = false,                 -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },

    },
    special = {
        gatchuck_2 = {            -- Hash modelo da carroça
            name = "Carroça Armada",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        policewagon01x = {        -- Hash modelo da carroça
            name = "Carroça da Cavalaria",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        policewagongatling01x = { -- Hash modelo da carroça
            name = "Carroça da Cavalaria Armada",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach004_2x = {      -- Hash modelo da carroça
            name = "Carruagem Blindada 02",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach004x = {         -- Hash modelo da carroça
            name = "Carruagem Blindada 01",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagonarmoured01x = {      -- Hash modelo da carroça
            name = "Armoured01x",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagoncircus01x = {        -- Hash modelo da carroça
            name = "Carroça do Circo 01",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagoncircus02x = {        -- Hash modelo da carroça
            name = "Carroça do Circo 02",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagondairy01x = {         -- Hash modelo da carroça
            name = "Carroça do Leiteiro",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagondoc01x = {           -- Hash modelo da carroça
            name = "Carroça da Farmácia",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagonprison01x = {        -- Hash modelo da carroça
            name = "Carroça de Prisioneiros",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagontraveller01x = {     -- Hash modelo da carroça
            name = "Carroça de Viagem",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        wagonwork01x = {          -- Hash modelo da carroça
            name = "Carroça do Padeiro",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        warwagon2 = {             -- Hash modelo da carroça
            name = "Torreta Blindada",
            maxWeight = 100,      -- Peso máximo que a carroça pode carregar
            slots = 20,           -- Número de slots disponíveis na carroça
            price = 25,           -- Preço da carroça
            priceGold = 18,       -- Preço da carroça em gold
            maxAnimals = false,   -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
    },
    coach = {
        coach2 = {                            -- Hash modelo da carroça
            name = "Carruagem 01",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        coach3 = {                            -- Hash modelo da carroça
            name = "Carruagem 02",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        coach4 = {                            -- Hash modelo da carroça
            name = "Carruagem 03",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        coach5 = {                            -- Hash modelo da carroça
            name = "Carruagem 04",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach001x = {                    -- Hash modelo da carroça
            name = "Carruagem 05",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach002x = {                    -- Hash modelo da carroça
            name = "Carruagem 06",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach005x = {                    -- Hash modelo da carroça
            name = "Carruagem 07",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach006x = {                    -- Hash modelo da carroça
            name = "Carruagem 08",            -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        stagecoach003x = {                    -- Hash modelo da carroça
            name = "Carruagem Simples",       -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        coach6 = {                            -- Hash modelo da carroça
            name = "Carruagem Sem Cobertura", -- Nome que será exibido no menu de compra
            maxWeight = 50,                   -- Peso máximo que a carroça pode carregar
            slots = 20,                       -- Número de slots disponíveis na carroça
            price = 38,                       -- Preço da carroça
            priceGold = 18,                   -- Preço da carroça em gold
            maxAnimals = false,               -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        buggy01 = {
            name = "Charrete de Luxo 01",
            maxWeight = 50,     -- Peso máximo que a carroça pode carregar
            slots = 20,         -- Número de slots disponíveis na carroça
            price = 38,         -- Preço da carroça
            priceGold = 18,     -- Preço da carroça em gold
            maxAnimals = false, -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        buggy02 = {
            name = "Charrete de Luxo 02",
            maxWeight = 50,     -- Peso máximo que a carroça pode carregar
            slots = 20,         -- Número de slots disponíveis na carroça
            price = 38,         -- Preço da carroça
            priceGold = 18,     -- Preço da carroça em gold
            maxAnimals = false, -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
        buggy03 = {
            name = "Charrete de Luxo 03",
            maxWeight = 50,     -- Peso máximo que a carroça pode carregar
            slots = 20,         -- Número de slots disponíveis na carroça
            price = 38,         -- Preço da carroça
            priceGold = 18,     -- Preço da carroça em gold
            maxAnimals = false, -- Se a carroça pode carregar animais, colocar maximo ou false/0
        },
    }
}

Config.CustomPrice = {
    livery = 15,  -- Preço das listras laterais
    extra = 25,   -- Preço do extra
    tint = 38,    -- Preço da pintura
    props = 15,   -- Preço dos acessórios
    lantern = 15, -- Preço dos acessórios lanternas
}

---- Notificações

local isServerSide = IsDuplicityVersion()
function Notify(message, timer, type, source) -- translateNumber é o número da tradução conforme o Config.Translate
    if timer then
        timer = timer
    else
        timer = 5000
    end

    if isServerSide then
        TriggerClientEvent('ox_lib:notify', source, { title = message, type = type, duration = timer })
    else
        lib.notify({ title = message, type = type, duration = timer })
    end
end

-- Animais aceitos na carroça

Config.AnimalsStorage = {
    [`a_c_alligator_01`] = { label = "Jacaré" },
    [`a_c_alligator_02`] = { label = "Jacaré" },
    [`a_c_alligator_03`] = { label = "Jacaré" },
    [`a_c_armadillo_01`] = { label = "Tatu" },
    [`a_c_badger_01`] = { label = "Texugo" },
    [`a_c_bat_01`] = { label = "Morcego" },
    [`a_c_bearblack_01`] = { label = "Urso Negro" },
    [`a_c_bear_01`] = { label = "Urso" },
    [`a_c_beaver_01`] = { label = "Castor" },
    [`a_c_bighornram_01`] = { label = "Carneiro" },
    [`a_c_bluejay_01`] = { label = "Gaio Azul" },
    [`a_c_boarlegendary_01`] = { label = "Javali Lendário" },
    [`a_c_boar_01`] = { label = "Javali" },
    [`a_c_buck_01`] = { label = "Cervo" },
    [`a_c_buffalo_01`] = { label = "Búfalo" },
    [`a_c_buffalo_tatanka_01`] = { label = "Búfalo Tatanka" },
    [`a_c_bull_01`] = { label = "Touro" },
    [`a_c_californiacondor_01`] = { label = "Condor" },
    [`a_c_cardinal_01`] = { label = "Cardeal" },
    [`a_c_carolinaparakeet_01`] = { label = "Periquito" },
    [`a_c_cedarwaxwing_01`] = { label = "Pássaro-Cera" },
    [`a_c_chicken_01`] = { label = "Galinha" },
    [`mp_a_c_chicken_01`] = { label = "Galinha" },
    [`a_c_chipmunk_01`] = { label = "Esquilo Listrado" },
    [`a_c_cormorant_01`] = { label = "Corvo-Marinho" },
    [`a_c_cougar_01`] = { label = "Puma" },
    [`a_c_cow`] = { label = "Vaca" },
    [`a_c_coyote_01`] = { label = "Coiote" },
    [`a_c_crab_01`] = { label = "Caranguejo" },
    [`a_c_cranewhooping_01`] = { label = "Grou" },
    [`a_c_crawfish_01`] = { label = "Lagostim" },
    [`a_c_crow_01`] = { label = "Corvo" },
    [`a_c_deer_01`] = { label = "Veado" },
    [`a_c_donkey_01`] = { label = "Burro" },
    [`a_c_duck_01`] = { label = "Pato" },
    [`a_c_eagle_01`] = { label = "Águia" },
    [`a_c_egret_01`] = { label = "Garça" },
    [`a_c_elk_01`] = { label = "Alce" },
    [`a_c_fishbluegil_01_ms`] = { label = "Bluegill" },
    [`a_c_fishbluegil_01_sm`] = { label = "Bluegill" },
    [`a_c_fishbullheadcat_01_ms`] = { label = "Peixe-Cabeça-Chata" },
    [`a_c_fishbullheadcat_01_sm`] = { label = "Peixe-Cabeça-Chata" },
    [`a_c_fishchainpickerel_01_ms`] = { label = "Pickerel" },
    [`a_c_fishchainpickerel_01_sm`] = { label = "Pickerel" },
    [`a_c_fishchannelcatfish_01_lg`] = { label = "Bagre" },
    [`a_c_fishchannelcatfish_01_xl`] = { label = "Bagre Gigante" },
    [`a_c_fishlakesturgeon_01_lg`] = { label = "Esturjão" },
    [`a_c_fishlargemouthbass_01_lg`] = { label = "Black Bass" },
    [`a_c_fishlargemouthbass_01_ms`] = { label = "Black Bass" },
    [`a_c_fishlongnosegar_01_lg`] = { label = "Peixe-Bico" },
    [`a_c_fishmuskie_01_lg`] = { label = "Muskie" },
    [`a_c_fishnorthernpike_01_lg`] = { label = "Pike" },
    [`a_c_fishperch_01_ms`] = { label = "Perch" },
    [`a_c_fishperch_01_sm`] = { label = "Perch" },
    [`a_c_fishrainbowtrout_01_lg`] = { label = "Truta Arco-Íris" },
    [`a_c_fishrainbowtrout_01_ms`] = { label = "Truta Arco-Íris" },
    [`a_c_fishredfinpickerel_01_ms`] = { label = "Pickerel Redfin" },
    [`a_c_fishredfinpickerel_01_sm`] = { label = "Pickerel Redfin" },
    [`a_c_fishrockbass_01_ms`] = { label = "Rock Bass" },
    [`a_c_fishrockbass_01_sm`] = { label = "Rock Bass" },
    [`a_c_fishsalmonsockeye_01_lg`] = { label = "Salmão" },
    [`a_c_fishsalmonsockeye_01_ml`] = { label = "Salmão" },
    [`a_c_fishsalmonsockeye_01_ms`] = { label = "Salmão" },
    [`a_c_fishsmallmouthbass_01_lg`] = { label = "Smallmouth Bass" },
    [`a_c_fishsmallmouthbass_01_ms`] = { label = "Smallmouth Bass" },
    [`a_c_fox_01`] = { label = "Raposa" },
    [`a_c_frogbull_01`] = { label = "Sapo" },
    [`a_c_gilamonster_01`] = { label = "Monstro de Gila" },
    [`a_c_goat_01`] = { label = "Cabra" },
    [`a_c_goosecanada_01`] = { label = "Ganso" },
    [`a_c_hawk_01`] = { label = "Falcão" },
    [`a_c_heron_01`] = { label = "Socó" },
    [`a_c_iguanadesert_01`] = { label = "Iguana do Deserto" },
    [`a_c_iguana_01`] = { label = "Iguana" },
    [`a_c_javelina_01`] = { label = "Queixada" },
    [`a_c_lionmangy_01`] = { label = "Leão Doente" },
    [`a_c_loon_01`] = { label = "Mergulhão" },
    [`a_c_moose_01`] = { label = "Alce" },
    [`a_c_muskrat_01`] = { label = "Rato-Almiscarado" },
    [`a_c_oriole_01`] = { label = "Papa-Figos" },
    [`a_c_owl_01`] = { label = "Coruja" },
    [`a_c_ox_01`] = { label = "Boi" },
    [`a_c_panther_01`] = { label = "Pantera" },
    [`a_c_parrot_01`] = { label = "Papagaio" },
    [`a_c_pelican_01`] = { label = "Pelicano" },
    [`a_c_pheasant_01`] = { label = "Faisão" },
    [`a_c_pigeon`] = { label = "Pombo" },
    [`a_c_pig_01`] = { label = "Porco" },
    [`a_c_possum_01`] = { label = "Gambá" },
    [`a_c_prairiechicken_01`] = { label = "Galinha da Campina" },
    [`a_c_pronghorn_01`] = { label = "Antílope" },
    [`a_c_quail_01`] = { label = "Codorna" },
    [`a_c_rabbit_01`] = { label = "Coelho" },
    [`a_c_raccoon_01`] = { label = "Guaxinim" },
    [`a_c_rat_01`] = { label = "Rato" },
    [`a_c_raven_01`] = { label = "Corvo" },
    [`a_c_robin_01`] = { label = "Tordo" },
    [`a_c_rooster_01`] = { label = "Galo" },
    [`a_c_roseatespoonbill_01`] = { label = "Colhereiro Rosa" },
    [`a_c_seagull_01`] = { label = "Gaivota" },
    [`a_c_sharkhammerhead_01`] = { label = "Tubarão Martelo" },
    [`a_c_sharktiger`] = { label = "Tubarão Tigre" },
    [`a_c_sheep_01`] = { label = "Ovelha" },
    [`a_c_skunk_01`] = { label = "Gambá" },
    [`a_c_snakeblacktailrattle_01`] = { label = "Cascavel" },
    [`a_c_snakeblacktailrattle_pelt_01`] = { label = "Pele de Cascavel" },
    [`a_c_snakeferdelance_01`] = { label = "Surucucu" },
    [`a_c_snakeferdelance_pelt_01`] = { label = "Pele de Surucucu" },
    [`a_c_snakeredboa10ft_01`] = { label = "Jiboia Vermelha Gigante" },
    [`a_c_snakeredboa_01`] = { label = "Jiboia Vermelha" },
    [`a_c_snakeredboa_pelt_01`] = { label = "Pele de Jiboia" },
    [`a_c_snakewater_01`] = { label = "Cobra d'Água" },
    [`a_c_snakewater_pelt_01`] = { label = "Pele Cobra d'Água" },
    [`a_c_snake_01`] = { label = "Cobra" },
    [`a_c_snake_pelt_01`] = { label = "Pele de Cobra" },
    [`a_c_songbird_01`] = { label = "Pássaro Canoro" },
    [`a_c_sparrow_01`] = { label = "Pardal" },
    [`a_c_squirrel_01`] = { label = "Esquilo" },
    [`a_c_toad_01`] = { label = "Sapo" },
    [`a_c_turkeywild_01`] = { label = "Peru Selvagem" },
    [`a_c_turkey_01`] = { label = "Peru" },
    [`a_c_turkey_02`] = { label = "Peru" },
    [`a_c_turtlesea_01`] = { label = "Tartaruga Marinha" },
    [`a_c_turtlesnapping_01`] = { label = "Tartaruga Mordedora" },
    [`a_c_vulture_01`] = { label = "Abutre" },
    [`A_C_Wolf`] = { label = "Lobo" },
    [`a_c_wolf_medium`] = { label = "Lobo Médio" },
    [`a_c_wolf_small`] = { label = "Lobo Pequeno" },
    [`a_c_woodpecker_01`] = { label = "Pica-Pau" },
    [`a_c_woodpecker_02`] = { label = "Pica-Pau" },

    -- Peles Grandes
    [`mp001_p_mp_pelt_xlarge_acbear01`] = { label = "Pele de Urso" },
    [`p_cs_bearskin_xlarge_roll`] = { label = "Pele de Urso" },
    [`p_cs_bfloskin_xlarge_roll`] = { label = "Pele de Búfalo" },
    [`p_cs_bullgator_xlarge_roll`] = { label = "Pele de Jacaré Lendário" },
    [`p_cs_cowpelt2_xlarge`] = { label = "Pele de Vaca" },
    [`p_cs_pelt_xlarge`] = { label = "Pele Sem Nome" },
    [`p_cs_pelt_xlarge_alligator`] = { label = "Pele de Jacaré" },
    [`p_cs_pelt_xlarge_bear`] = { label = "Pele de Urso" },
    [`p_cs_pelt_xlarge_bearlegendary`] = { label = "Pele de Urso Lendário" },
    [`p_cs_pelt_xlarge_buffalo`] = { label = "Pele de Búfalo" },
    [`p_cs_pelt_xlarge_elk`] = { label = "Pele de Alce" },
    [`p_cs_pelt_xlarge_tbuffalo`] = { label = "Pele de Búfalo Tatanka" },
    [`p_cs_pelt_xlarge_wbuffalo`] = { label = "Pele de Búfalo Branco" },

    ----- Peles

    [-1544126829] = { label = "Pele de Antilocapra Perfeita" },
    [554578289] = { label = "Pele de Antilocapra Boa" },
    [-983605026] = { label = "Pele de Antilocapra Ruim" },
    [653400939] = { label = "Pele de Lobo Perfeita" },
    [1145777975] = { label = "Pele de Lobo Boa" },
    [85441452] = { label = "Pele de Lobo Ruim" },
    [-1858513856] = { label = "Pele de Javali Perfeita" },
    [1248540072] = { label = "Pele de Javali Ruim" },
    [-702790226] = { label = "Pele de Veado Perfeita" },
    [-868657362] = { label = "Pele de Veado Boa" },
    [1603936352] = { label = "Pele de Veado Ruim" },
    [-1791452194] = { label = "Pele de Puma Perfeita" },
    [459744337] = { label = "Pele de Puma Boa" },
    [1914602340] = { label = "Pele de Puma Ruim" },
    [1466150167] = { label = "Pele de Ovelha Perfeita" },
    [-1317365569] = { label = "Pele de Ovelha Boa" },
    [1729948479] = { label = "Pele de Ovelha Ruim" },
    [-1035515486] = { label = "Pele de Veado Perfeita" },
    [-1827027577] = { label = "Pele de Veado Boa" },
    [-662178186] = { label = "Pele de Veado Ruim" },
    [-1102272634] = { label = "Pele de Porco Perfeita" },
    [-57190831] = { label = "Pele de Porco Boa" },
    [-30896554] = { label = "Pele de Porco Ruim" },
    [1963510418] = { label = "Pele de Porco-Peccary Perfeita" },
    [-1379330323] = { label = "Pele de Porco-Peccary Boa" },
    [-99092070] = { label = "Pele de Porco-Peccary Ruim" },
    [1969175294] = { label = "Pele de Pantera Perfeita" },
    [-395646254] = { label = "Pele de Pantera Boa" },
    [1584468323] = { label = "Pele de Pantera Ruim" },
    [1795984405] = { label = "Pele de Carneiro Perfeita" },
    [-476045512] = { label = "Pele de Carneiro Boa" },
    [1796037447] = { label = "Pele de Carneiro Ruim" },
    [2088901891] = { label = "Pele de Pantera Noturna Lendária" },
    [-675142890] = { label = "Pele de Carneiro Babbro Horn Lendária" },
    [832214437] = { label = "Pele de Puma Iguga Lendária" },
    [-1946740647] = { label = "Pele de Lobo Esmeralda Lendária" },
    [-1572330336] = { label = "Pele de Javali Cogi Lendária" },
    [2116849039] = { label = "Pele Padrão" },
    [-1924159110] = { label = "Pele de Jacaré Teca" },
    [-845037222] = { label = "Pele de Vaca Perfeita" },
    [1150594075] = { label = "Pele de Vaca Boa" },
    [334093551] = { label = "Pele de Vaca Ruim" },
    [-1332163079] = { label = "Pele de Wapiti Perfeita" },
    [1181652728] = { label = "Pele de Wapiti Boa" },
    [2053771712] = { label = "Pele de Wapiti Ruim" },
    [-217731719] = { label = "Pele de Alce-do-Canadá Perfeita" },
    [1636891382] = { label = "Pele de Alce-do-Canadá Boa" },
    [1868576868] = { label = "Pele de Alce-do-Canadá Ruim" },
    [659601266] = { label = "Pele de Boi Perfeita" },
    [1208128650] = { label = "Pele de Boi Boa" },
    [462348928] = { label = "Pele de Boi Ruim" },
    [-53270317] = { label = "Pele de Touro Perfeita" },
    [-336086818] = { label = "Pele de Touro Boa" },
    [9293261] = { label = "Pele de Touro Ruim" },
    [-1475338121] = { label = "Pele de Jacaré Grande Perfeita" },
    [-1625078531] = { label = "Pele de Jacaré Perfeita" },
    [-802026654] = { label = "Pele de Jacaré Boa" },
    [-1243878166] = { label = "Pele de Jacaré Ruim" },
    [1292673537] = { label = "Pele de Urso Pardo Perfeita" },
    [143941906] = { label = "Pele de Urso Pardo Boa" },
    [957520252] = { label = "Pele de Urso Pardo Ruim" },
    [-237756948] = { label = "Pele de Búfalo Perfeita" },
    [-591117838] = { label = "Pele de Búfalo Boa" },
    [-1730060063] = { label = "Pele de Búfalo Ruim" },
    [663376218] = { label = "Pele de Urso Perfeita" },
    [1490032862] = { label = "Pele de Urso Boa" },
    [1083865179] = { label = "Pele de Urso Ruim" },
    [854596618] = { label = "Pele de Castor Perfeita" },
    [-2059726619] = { label = "Pele de Castor Boa" },
    [-1569450319] = { label = "Pele de Castor Ruim" },
    [121494806] = { label = "Pele de Castor Lendária" },
    [-794277189] = { label = "Pele de Coiote Perfeita" },
    [1150939141] = { label = "Pele de Coiote Boa" },
    [-1558096473] = { label = "Pele de Coiote Ruim" },
    [-1061362634] = { label = "Pele de Coiote Lendária" },
    [500722008] = { label = "Pele de Raposa Perfeita" },
    [238733925] = { label = "Pele de Raposa Boa" },
    [1647012424] = { label = "Pele de Raposa Ruim" },
    [-1648383828] = { label = "Pele de Cabra Perfeita" },
    [1710714415] = { label = "Pele de Cabra Boa" },
    [699990316] = { label = "Pele de Cabra Ruim" },
    [1806153689] = { label = "Pele de Jacaré Ruim" },
    [1276143905] = { label = "Pele de Raposa Ota Lendária" },
    [`mp007_p_nat_pelt_bearlegend01x`] = { label = "Pele de Urso Lendário 1" },
    [`mp007_p_nat_pelt_bearlegend02x`] = { label = "Pele de Urso Lendário 2" },
    [`mp007_p_nat_pelt_bearlegend03x`] = { label = "Pele de Urso Lendário 3" },
    [`mp007_p_nat_pelt_beaverlegend01x`] = { label = "Pele de Castor Lendário 1" },
    [`mp007_p_nat_pelt_beaverlegend02x`] = { label = "Pele de Castor Lendário 2" },
    [`mp007_p_nat_pelt_beaverlegend03x`] = { label = "Pele de Castor Lendário 3" },
    [`mp007_p_nat_pelt_bighornlegend01x`] = { label = "Pele de Carneiro Lendário 1" },
    [`mp007_p_nat_pelt_bighornlegend02x`] = { label = "Pele de Carneiro Lendário 2" },
    [`mp007_p_nat_pelt_bighornlegend03x`] = { label = "Pele de Carneiro Lendário 3" },
    [`mp007_p_nat_pelt_boarlegend01x`] = { label = "Pele de Javali Lendário 1" },
    [`mp007_p_nat_pelt_boarlegend02x`] = { label = "Pele de Javali Lendário 2" },
    [`mp007_p_nat_pelt_boarlegend03x`] = { label = "Pele de Javali Lendário 3" },
    [`mp007_p_nat_pelt_bucklegend01x`] = { label = "Pele de Cervo Lendário 1" },
    [`mp007_p_nat_pelt_bucklegend02x`] = { label = "Pele de Cervo Lendário 2" },
    [`mp007_p_nat_pelt_bucklegend03x`] = { label = "Pele de Cervo Lendário 3" },
    [`mp007_p_nat_pelt_cougarlegend01x`] = { label = "Pele de Onça Lendária 1" },
    [`mp007_p_nat_pelt_cougarlegend02x`] = { label = "Pele de Onça Lendária 2" },
    [`mp007_p_nat_pelt_cougarlegend03x`] = { label = "Pele de Onça Lendária 3" },
    [`mp007_p_nat_pelt_coyotelegend01x`] = { label = "Pele de Coiote Lendário 1" },
    [`mp007_p_nat_pelt_coyotelegend02x`] = { label = "Pele de Coiote Lendário 2" },
    [`mp007_p_nat_pelt_coyotelegend03x`] = { label = "Pele de Coiote Lendário 3" },
    [`mp007_p_nat_pelt_elklegend01x`] = { label = "Pele de Alce Lendário 1" },
    [`mp007_p_nat_pelt_elklegend02x`] = { label = "Pele de Alce Lendário 2" },
    [`mp007_p_nat_pelt_elklegend03x`] = { label = "Pele de Alce Lendário 3" },
    [`mp007_p_nat_pelt_foxlegend01x`] = { label = "Pele de Raposa Lendária 1" },
    [`mp007_p_nat_pelt_foxlegend02x`] = { label = "Pele de Raposa Lendária 2" },
    [`mp007_p_nat_pelt_foxlegend03x`] = { label = "Pele de Raposa Lendária 3" },
    [`mp007_p_nat_pelt_gatorlegend02x`] = { label = "Pele de Jacaré Lendário 2" },
    [`mp007_p_nat_pelt_gatorlegend03x`] = { label = "Pele de Jacaré Lendário 3" },
    [`mp007_p_nat_pelt_mooselegend01x`] = { label = "Pele de Alce Canadense Lendário 1" },
    [`mp007_p_nat_pelt_mooselegend02x`] = { label = "Pele de Alce Canadense Lendário 2" },
    [`mp007_p_nat_pelt_mooselegend03x`] = { label = "Pele de Alce Canadense Lendário 3" },
    [`mp007_p_nat_pelt_wolflegend01x`] = { label = "Pele de Lobo Lendário 1" },
    [`mp007_p_nat_pelt_wolflegend02x`] = { label = "Pele de Lobo Lendário 2" },
    [`mp007_p_nat_pelt_wolflegend03x`] = { label = "Pele de Lobo Lendário 3" },
    [`mp007_p_nat_pelt_pantherlegend01x`] = { label = "Pele de Pantera Lendária 1" },
    [`mp007_p_nat_pelt_pantherlegend02x`] = { label = "Pele de Pantera Lendária 2" },
    [`mp007_p_nat_pelt_pantherlegend03x`] = { label = "Pele de Pantera Lendária 3" },
    [`mp001_p_mp_pelt_xlarge_acbear01`] = { label = "Pele de Urso Grande" },
    [`mp005_s_posse_raccoonpelt01x`] = { label = "Pele de Guaxinim" },
    [`p_cs_pelt_wolf`] = { label = "Pele de Lobo" },
    [`p_cs_pelt_wolf_roll`] = { label = "Pele de Lobo Enrolada" },
    [`p_cs_wolfpelt_large`] = { label = "Pele Grande de Lobo" },
    [`p_cs_pelt_ws_alligator`] = { label = "Pele Grande de Jacaré" },
    [`p_cs_gilamonsterpelt01x`] = { label = "Pele de Monstro de Gila" },
    [`p_cs_iguanapelt`] = { label = "Pele de Iguana" },
    [`p_cs_iguanapelt02x`] = { label = "Pele de Iguana" },
    [`p_cs_pelt_med_armadillo`] = { label = "Pele de Tatu" },
    [`p_cs_pelt_med_badger`] = { label = "Pele de Texugo" },
    [`p_cs_pelt_med_muskrat`] = { label = "Pele de Ratazana almiscarada" },
    [`p_cs_pelt_med_possum`] = { label = "Pele de Gambá" },
    [`p_cs_pelt_med_raccoon`] = { label = "Pele de Guaxinim" },
    [`p_cs_pelt_med_skunk`] = { label = "Pele de Cangambá" },
    [`p_cs_pelt_medium`] = { label = "Pele Média" },
    [`p_cs_pelt_medium_og`] = { label = "Pele Média OG" },
    [`p_cs_pelt_medlarge_roll`] = { label = "Pele Média-Grande Enrolada" },


}
