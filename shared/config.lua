Config = {}
Config.FrameWork = 'rsg' -- Qual framework está utilizando, no caso o rsg
Config.Locale = 'pt-br'  -- Idioma que está utilizando, no caso o português
Config.Debug = false     -- Ativar debug para ver os logs no console do servidor
Config.Target = false    -- Para usar eye Target -- ox_target necessário
Config.PositionMenu = 'top-right'


------
Config.SpawnKey = "INPUT_OPEN_JOURNAL" -- Tecla para chamar a carroça, para desativar utilize false
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
Config.Sell = 0.1 -- Porcentagem do valor que será devolvido ao vender a carroça, no caso 0.1 = 10% do valor total

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
        npcmodel = `s_m_m_cghworker_01`,                      -- Modelo do NPC que abrirá o menu
        npccoords = vector4(-355.11, 775.18, 116.22, 321.41), -- Coordenadas do NPC que abrirá o menu
        previewWagon = vec4(-371.76, 786.87, 115.16, 272.08), -- Local Para visualizar a carroça
        cameraPreviewWagon = vec4(-371.76 + 8, 786.87, 115.16 + 2, 272.08),
    },
    SaintDenis = {
        coords = vector3(2506.02, -1459.52, 46.37),                -- Coordenadas do local onde o menu será aberto
        npcmodel = `s_m_m_cghworker_01`,                           -- Modelo do NPC que abrirá o menu
        npccoords = vector4(2506.02, -1459.52, 46.37, 66.78),      -- Coordenadas do NPC que abrirá o menu
        previewWagon = vec4(2502.689, -1441.257, 45.313, 177.895), -- Local Para visualizar a carroça
        cameraPreviewWagon = vec4(2502.689, -1441.257 - 8, 45.313 + 3, 177.895),
    },
    Strawberry = {
        coords = vector3(-1811.18, -555.63, 155.98),                -- Coordenadas do local onde o menu será aberto
        npcmodel = `s_m_m_cghworker_01`,                            -- Modelo do NPC que abrirá o menu
        npccoords = vec4(-1811.18, -555.63, 155.98, 265.87),        -- Coordenadas do NPC que abrirá o menu
        previewWagon = vec4(-1821.550, -561.547, 155.060, 253.239), -- Local Para visualizar a carroça
        cameraPreviewWagon = vec4(-1821.550 + 6, -561.547, 155.060 + 2, 253.239),
    },
    BlackWater = {
        coords = vector3(-870.62, -1370.70, 43.62),             -- Coordenadas do local onde o menu será aberto
        npcmodel = `s_m_m_cghworker_01`,                           -- Modelo do NPC que abrirá o menu
        npccoords = vector4(-870.62, -1370.70, 43.62, 40.36), -- Coordenadas do NPC que abrirá o menu
        previewWagon = vec4(-865.77, -1366.23, 43.49, 88.50),      -- Local Para visualizar a carroça
        cameraPreviewWagon = vec4(-865.77 - 8, -1366.23, 43.49 + 2, 88.50),
    },
    Tumbleweed = {
        coords = vector3(-5515.295, -3039.497, -2.388),             -- Coordenadas do local onde o menu será aberto
        npcmodel = `s_m_m_cghworker_01`,                            -- Modelo do NPC que abrirá o menu
        npccoords = vector4(-5515.295, -3039.497, -2.388, 182.161), -- Coordenadas do NPC que abrirá o menu
        previewWagon = vec4(-5522.063, -3044.438, -3.388, 265.561), -- Local Para visualizar a carroça
        cameraPreviewWagon = vec4(-5522.063 + 8, -3044.438, -3.388 + 2, 265.561),
    },

}

Config.Wagons = {
    work = {
        wagon02x = {
            name = "Carroça de Acampamento Padrão", -- Anterior: Carroça de Acampamento 02
            maxWeight = 560,                        -- Peso máximo (ex: ~1250 lbs / 560 kg)
            slots = 50,                             -- Número de slots disponíveis
            price = 40,                             -- Preço em dólares da época
            priceGold = 2,                          -- Preço em gold (premium)
            maxAnimals = 5,                         -- Pequenos animais/peles
        },
        wagon03x = {
            name = "Carroça de Acampamento Reforçada", -- Anterior: Carroça de Acampamento 03
            maxWeight = 600,                           -- (ex: ~1500 lbs / 680 kg)
            slots = 60,
            price = 50,
            priceGold = 2,
            maxAnimals = 6, -- Pequenos animais/peles
        },
        wagon04x = {
            name = "Carroça de Fazenda Leve", -- Anterior: Carroça de Acampamento 04
            maxWeight = 500,                  -- (ex: ~1100 lbs / 500 kg)
            slots = 45,
            price = 35,
            priceGold = 2,
            maxAnimals = 4, -- Pequenos animais/peles
        },
        wagon05x = {
            name = "Carroça Utilitária Aberta", -- Anterior: Carroça de Acampamento 05
            maxWeight = 635,                    -- (ex: ~1400 lbs / 635 kg)
            slots = 55,
            price = 45,
            priceGold = 2,
            maxAnimals = 5, -- Pequenos animais/peles
        },
        wagon06x = {
            name = "Carroça de Suprimentos Coberta", -- Anterior: Carroça de Acampamento 06
            maxWeight = 725,                         -- (ex: ~1600 lbs / 725 kg)
            slots = 65,
            price = 55,
            priceGold = 3,
            maxAnimals = 2, -- Aves em gaiolas ou itens pequenos
        },
        cart01 = {
            name = "Carroça de Camponês Leve", -- Anterior: Carroça de Camponês 01
            maxWeight = 400,                   -- (ex: ~900 lbs / 400 kg)
            slots = 35,
            price = 25,
            priceGold = 1, -- Ajustado de 18
            maxAnimals = false,
        },
        cart02 = {
            name = "Carroça de Camponês com Laterais", -- Anterior: Carroça de Camponês 02
            maxWeight = 450,                           -- (ex: ~1000 lbs / 450 kg)
            slots = 40,
            price = 30,
            priceGold = 1, -- Ajustado de 18
            maxAnimals = false,
        },
        cart03 = {
            name = "Carroça de Mercado Pequena", -- Anterior: Carroça de Camponês 03
            maxWeight = 360,                     -- (ex: ~800 lbs / 360 kg)
            slots = 30,
            price = 22,
            priceGold = 1, -- Ajustado de 18
            maxAnimals = false,
        },
        cart04 = {
            name = "Carroça de Fazenda Compacta", -- Anterior: Carroça de Camponês 04
            maxWeight = 430,                      -- (ex: ~950 lbs / 430 kg)
            slots = 38,
            price = 28,
            priceGold = 6, -- Ajustado de 18
            maxAnimals = false,
        },
        cart05 = {
            name = "Carroça-Tanque de Água/Líquidos", -- Anterior: Transporte de Liquidos
            maxWeight = 900,                          -- (ex: ~2000 lbs / 900 kg - líquidos são pesados)
            slots = 10,                               -- Representa grandes recipientes/tanque
            price = 70,                               -- Especializada
            priceGold = 3,                            -- Ajustado de 18
            maxAnimals = false,
        },
        cart06 = {
            name = "Carroça de Carga Geral", -- Anterior: Carroça de Carga 01
            maxWeight = 790,                 -- (ex: ~1750 lbs / 790 kg)
            slots = 70,
            price = 60,
            priceGold = 3, -- Ajustado de 18
            maxAnimals = false,
        },
        cart07 = {
            name = "Carroça de Agricultor", -- Anterior: Carroça de Camponês 05
            maxWeight = 475,                -- (ex: ~1050 lbs / 475 kg)
            slots = 42,
            price = 32,
            priceGold = 2, -- Ajustado de 18
            maxAnimals = false,
        },
        cart08 = {
            name = "Carroça Utilitária Rural", -- Anterior: Carroça de Camponês 06
            maxWeight = 520,                   -- (ex: ~1150 lbs / 520 kg)
            slots = 46,
            price = 38,
            priceGold = 2, -- Ajustado de 18
            maxAnimals = false,
        },
        chuckwagon000x = {
            name = "Carroça de Cozinha (Chuckwagon)", -- Anterior: Carroça de Acampamento 01
            maxWeight = 860,                          -- (ex: ~1900 lbs / 860 kg) Chuckwagons carregavam muito
            slots = 75,                               -- Para comida, utensílios, etc.
            price = 80,                               -- Chuckwagons eram substanciais
            priceGold = 3,                            -- Ajustado de 18
            maxAnimals = false,                       -- Primariamente para suprimentos
        },
        chuckwagon002x = {
            name = "Carroça de Carga de Ferramentas", -- Anterior: Carroça de Carga 02
            maxWeight = 815,                          -- (ex: ~1800 lbs / 815 kg)
            slots = 70,
            price = 65,
            priceGold = 3, -- Ajustado de 18
            maxAnimals = false,
        },
        coal_wagon = {
            name = "Vagão de Carvão/Minério", -- Anterior: Transporte de Carvão
            maxWeight = 1360,                 -- (ex: ~3000 lbs / 1360 kg) Para carga pesada e a granel
            slots = 30,                       -- Menos slots, para itens a granel
            price = 100,
            priceGold = 4,                    -- Ajustado de 18
            maxAnimals = false,
        },
        gatchuck = {                                     -- Hash pode sugerir algo militar (Gatling) ou apenas carga pesada
            name = "Carroça de Carga Pesada Articulada", -- Anterior: Carroça de Carga 03
            maxWeight = 1580,                            -- (ex: ~3500 lbs / 1580 kg) Uma grande carroça de frete
            slots = 80,
            price = 120,
            priceGold = 5, -- Ajustado de 18
            maxAnimals = false,
        },
        huntercart01 = {
            name = "Carroça de Caçador",
            maxWeight = 250, -- Para carcaças e peles
            slots = 50,      -- Espaço para peles e caça variada
            price = 75,      -- Equipamento especializado
            priceGold = 3,   -- Ajustado de 18. Original era 30 animais.
            maxAnimals = 20, -- Unidades de caça média (cervos) ou muitas pequenas
        },
        oilwagon01x = {
            name = "Carroça-Tanque de Óleo Pequena", -- Anterior: Transporte de Óleo 01
            maxWeight = 860,                         -- (ex: ~1900 lbs / 860 kg)
            slots = 8,                               -- Menos slots para barris/tanque
            price = 85,
            priceGold = 3,                           -- Ajustado de 18
            maxAnimals = false,
        },
        oilwagon02x = {
            name = "Carroça-Tanque de Óleo Grande", -- Anterior: Transporte de Óleo 02
            maxWeight = 1250,                       -- (ex: ~2750 lbs / 1250 kg)
            slots = 12,                             -- Mais barris/tanque maior
            price = 110,
            priceGold = 4,                          -- Ajustado de 18
            maxAnimals = false,
        },
        supplywagon = {
            name = "Vagão de Suprimentos Grande", -- Anterior: Carroça de Carga Grande
            maxWeight = 1700,                     -- (ex: ~3750 lbs / 1700 kg) Verdadeira carroça de frete
            slots = 100,
            price = 130,
            priceGold = 5,      -- Ajustado de 18
            maxAnimals = false, -- Para mercadorias em geral
        },
        utilliwag = {
            name = "Carroça Utilitária Baixa (Buckboard)", -- Anterior: Carroça de Carga Baixa
            maxWeight = 450,                               -- (ex: ~1000 lbs / 450 kg) Buckboards eram mais leves
            slots = 40,
            price = 30,
            priceGold = 1,  -- Ajustado de 18
            maxAnimals = 2, -- Poderia levar cães de caça ou alguma caça pequena
        },
    },

    special = {
        gatchuck_2 = {       -- Hash modelo da carroça
            name = "Carroça de Combate com Metralhadora",
            maxWeight = 450, -- Capacidade de carga útil em KG (munição, água, suprimentos para tripulação)
            slots = 10,      -- Espaços para munição, suprimentos essenciais
            price = 350,     -- Veículo militar especializado seria caro
            priceGold = 14,  -- 350 / 25 = 14
            maxAnimals = false,
        },
        policewagon01x = {   -- Hash modelo da carroça
            name = "Carroção Policial de Patrulha",
            maxWeight = 700, -- Capacidade em KG (para 8-10 pessoas + equipamento policial)
            slots = 15,      -- Assentos e espaço para equipamento
            price = 180,     -- Carroça reforçada e de finalidade específica
            priceGold = 7,   -- 180 / 25 = 7 (resultado de 7.2 truncado para int)
            maxAnimals = false,
        },
        policewagongatling01x = { -- Hash modelo da carroça
            name = "Carroção Policial Armado",
            maxWeight = 550,      -- Capacidade de carga útil em KG (munição extra, equipamento tático)
            slots = 12,           -- Espaços para munição e equipamento tático
            price = 400,          -- Mais cara devido ao armamento pesado
            priceGold = 16,       -- 400 / 25 = 16
            maxAnimals = false,
        },
        stagecoach004_2x = { -- Hash modelo da carroça
            name = "Diligência Blindada Pesada",
            maxWeight = 800, -- Capacidade em KG (passageiros, bagagem, valores; já considerando o peso da blindagem)
            slots = 25,      -- Assentos internos, bagageiro, cofre
            price = 600,     -- Diligências eram caras, blindadas ainda mais
            priceGold = 24,  -- 600 / 25 = 24
            maxAnimals = false,
        },
        stagecoach004x = {   -- Hash modelo da carroça
            name = "Diligência Reforçada",
            maxWeight = 900, -- Capacidade em KG (passageiros e carga; menos blindagem pode significar maior capacidade de carga útil)
            slots = 22,      -- Assentos e espaço para carga
            price = 500,     -- Ainda muito cara
            priceGold = 20,  -- 500 / 25 = 20
            maxAnimals = false,
        },
        wagonarmoured01x = { -- Hash modelo da carroça
            name = "Vagão Blindado de Valores",
            maxWeight = 500, -- Capacidade de carga em KG para os valores (ex: ouro, documentos); a estrutura já é muito pesada pela blindagem.
            slots = 10,      -- Espaço interno seguro e limitado
            price = 700,     -- Extremamente caro devido à blindagem e segurança
            priceGold = 28,  -- 700 / 25 = 28
            maxAnimals = false,
        },
        wagoncircus01x = {   -- Hash modelo da carroça
            name = "Carroça de Circo - Alegorias",
            maxWeight = 800, -- Capacidade em KG para equipamentos de circo, adereços volumosos
            slots = 40,      -- Espaço para itens de formatos diversos
            price = 120,     -- Carroças grandes e decoradas
            priceGold = 4,   -- 120 / 25 = 4 (resultado de 4.8 truncado para int)
            maxAnimals = false,
        },
        wagoncircus02x = {   -- Hash modelo da carroça
            name = "Carroça de Circo - Artistas",
            maxWeight = 600, -- Capacidade em KG para pessoal do circo e seus pertences/figurinos
            slots = 30,      -- Espaço para pessoas e seus itens
            price = 100,
            priceGold = 4,   -- 100 / 25 = 4
            maxAnimals = false,
        },
        wagondairy01x = {    -- Hash modelo da carroça
            name = "Carroça do Leiteiro",
            maxWeight = 400, -- Capacidade em KG (ex: 400 litros de leite em latões, aprox. 400kg + peso dos latões)
            slots = 50,      -- Espaço para muitos recipientes pequenos
            price = 70,      -- Custo de uma carroça de entrega especializada
            priceGold = 2,   -- 70 / 25 = 2 (resultado de 2.8 truncado para int)
            maxAnimals = false,
        },
        wagondoc01x = {      -- Hash modelo da carroça
            name = "Carroça de Boticário Itinerante",
            maxWeight = 300, -- Capacidade em KG (medicamentos, elixires, equipamentos de demonstração)
            slots = 45,      -- Muitos frascos e caixas pequenas
            price = 90,      -- Carroça especializada
            priceGold = 3,   -- 90 / 25 = 3 (resultado de 3.6 truncado para int)
            maxAnimals = false,
        },
        wagonprison01x = {   -- Hash modelo da carroça
            name = "Carroça de Transporte de Prisioneiros",
            maxWeight = 750, -- Capacidade em KG (para 8-10 prisioneiros + guardas)
            slots = 10,      -- Foco em segurança, celas, não carga diversa
            price = 200,     -- Carroça reforçada e com celas
            priceGold = 8,   -- 200 / 25 = 8
            maxAnimals = false,
        },
        wagontraveller01x = { -- Hash modelo da carroça
            name = "Carroça de Viajante/Comerciante",
            maxWeight = 500,  -- Capacidade em KG (bagagem pessoal, mercadorias para comércio itinerante)
            slots = 60,       -- Bom espaço interno e talvez externo
            price = 110,
            priceGold = 4,    -- 110 / 25 = 4 (resultado de 4.4 truncado para int)
            maxAnimals = false,
        },
        wagonwork01x = {     -- Hash modelo da carroça
            name = "Carroça de Entregas Diversas (Ex: Padeiro)",
            maxWeight = 450, -- Capacidade em KG (pães, sacos de farinha, outras mercadorias de entrega)
            slots = 55,      -- Adaptável para diferentes tipos de mercadorias
            price = 75,
            priceGold = 3,   -- 75 / 25 = 3
            maxAnimals = false,
        },
        warwagon2 = {        -- Hash modelo da carroça
            name = "Carro de Guerra Blindado com Torreta",
            maxWeight = 600, -- Capacidade de carga útil em KG (munição pesada, suprimentos para operação prolongada)
            slots = 8,       -- Espaço interno muito limitado devido à blindagem e mecanismos
            price = 1000,    -- Um dos veículos mais caros
            priceGold = 40,  -- 1000 / 25 = 40
            maxAnimals = false,
        },
    },
    coach = {
        coach2 = {
            name = "Carruagem Fechada Leve (Brougham)", -- Ex: para 2-4 passageiros distintos
            maxWeight = 350,                        -- Capacidade em KG (2-3 passageiros + bagagem leve ~75kg/pessoa + 50-125kg bagagem)
            slots = 8,                              -- Assentos e pequeno espaço para bagagem (ex: 2-3 pessoas + bagagem)
            price = 250,                            -- Preço de uma carruagem particular elegante, mas não a mais opulenta
            priceGold = 10,                         -- 250 / 25 = 10
            maxAnimals = false,
        },
        coach3 = {
            name = "Carruagem de Aluguel (Fiacre)", -- Para uso urbano, transporte de passageiros
            maxWeight = 400,                    -- Capacidade em KG (tipicamente 4 passageiros + bagagem leve)
            slots = 10,                         -- Assentos para 4 e espaço para bagagens de mão
            price = 220,                        -- Custo para um veículo de serviço robusto
            priceGold = 8,                      -- 220 / 25 = 8 (8.8 truncado)
            maxAnimals = false,
        },
        coach4 = {
            name = "Landau de Passeio", -- Carruagem conversível de luxo
            maxWeight = 450,        -- Capacidade em KG (4 passageiros confortavelmente + bagagem de dia)
            slots = 12,             -- Assentos espaçosos e área para cestas de piquenique, etc.
            price = 350,            -- Veículo de prestígio
            priceGold = 14,         -- 350 / 25 = 14
            maxAnimals = false,
        },
        coach5 = {
            name = "Vitória Elegante", -- Carruagem aberta para 2 passageiros, cocheiro elevado, para passeios
            maxWeight = 300,       -- Capacidade em KG (2 passageiros + cocheiro + pequena bagagem pessoal)
            slots = 6,             -- Assentos para 2 + espaço para o cocheiro e itens mínimos
            price = 300,           -- Carruagem de status, focada na elegância
            priceGold = 12,        -- 300 / 25 = 12
            maxAnimals = false,
        },
        stagecoach001x = {
            name = "Diligência Comum (Concord)", -- Diligência padrão para rotas intermunicipais
            maxWeight = 700,                 -- Capacidade em KG (6-9 passageiros + bagagem considerável/correio)
            slots = 20,                      -- Assentos internos, externos no teto, bagageiro traseiro e frontal
            price = 450,                     -- Custo de uma diligência de linha, robusta e funcional
            priceGold = 18,                  -- 450 / 25 = 18
            maxAnimals = false,
        },
        stagecoach002x = {
            name = "Diligência Rural Leve", -- Menor, para rotas secundárias ou menos passageiros
            maxWeight = 500,            -- Capacidade em KG (4-6 passageiros + bagagem/correio)
            slots = 15,                 -- Configuração similar à maior, mas em menor escala
            price = 380,                -- Mais barata, porém ainda um veículo de serviço essencial
            priceGold = 15,             -- 380 / 25 = 15 (15.2 truncado)
            maxAnimals = false,
        },
        stagecoach005x = {
            name = "Diligência de Viagem Longa (Overland)", -- Para rotas extensas, necessitando maior capacidade e robustez
            maxWeight = 750,                            -- Capacidade em KG (mais passageiros, carga e suprimentos para a jornada)
            slots = 22,                                 -- Otimizada para maximizar transporte em longas distâncias
            price = 500,                                -- Um investimento considerável para operadores de linha
            priceGold = 20,                             -- 500 / 25 = 20
            maxAnimals = false,
        },
        stagecoach006x = {
            name = "Diligência Omnibus Urbana", -- Para transporte em massa dentro de cidades e arredores
            maxWeight = 1000,               -- Capacidade em KG (projetada para muitos passageiros, pouca bagagem individual)
            slots = 25,                     -- Foco em número de assentos, tipo "bonde sobre rodas"
            price = 400,                    -- Veículo de transporte público, construção funcional
            priceGold = 16,                 -- 400 / 25 = 16
            maxAnimals = false,
        },
        stagecoach003x = {
            name = "Carruagem de Passageiros Simples (Town Coach)", -- Modelo básico fechado para uso urbano ou viagens curtas
            maxWeight = 400,                                    -- Capacidade em KG (4 passageiros + bagagem leve)
            slots = 10,                                         -- Similar ao Fiacre, talvez menos ornamentada
            price = 200,                                        -- Um modelo de entrada para carruagens fechadas
            priceGold = 8,                                      -- 200 / 25 = 8
            maxAnimals = false,
        },
        coach6 = {
            name = "Carruagem Aberta de Excursão (Charabanc Leve)", -- Para passeios turísticos ou transporte de grupos
            maxWeight = 600,                                    -- Capacidade em KG (vários passageiros sentados em fileiras)
            slots = 18,                                         -- Múltiplos assentos, geralmente abertos
            price = 320,                                        -- Para transporte de grupos em lazer ou eventos
            priceGold = 12,                                     -- 320 / 25 = 12 (12.8 truncado)
            maxAnimals = false,
        },
        buggy01 = {
            name = "Buggy de Luxo (Capota de Couro)", -- Charrete elegante para uso pessoal
            maxWeight = 250,                      -- Capacidade em KG (2 passageiros + pequena bagagem de mão ou compras)
            slots = 5,                            -- Assentos para 2 e espaço mínimo para pertences
            price = 150,                          -- Buggy de alta qualidade, com acabamentos superiores
            priceGold = 6,                        -- 150 / 25 = 6
            maxAnimals = false,
        },
        buggy02 = {
            name = "Buggy Padrão (Runabout)", -- Charrete comum, leve e ágil para 2 pessoas
            maxWeight = 200,              -- Capacidade em KG (2 passageiros, sem muita bagagem)
            slots = 4,                    -- Essencialmente os assentos
            price = 80,                   -- Um dos veículos de tração animal mais acessíveis e populares
            priceGold = 3,                -- 80 / 25 = 3 (3.2 truncado)
            maxAnimals = false,
        },
        buggy03 = {
            name = "Buggy Familiar (Surrey Leve)", -- Charrete para 4 pessoas, muitas vezes com uma capota leve
            maxWeight = 350,                   -- Capacidade em KG (4 passageiros, pouca bagagem)
            slots = 8,                         -- Assentos para quatro, geralmente 2 bancos
            price = 120,                       -- Opção popular para famílias ou pequenos grupos
            priceGold = 4,                     -- 120 / 25 = 4 (4.8 truncado)
            maxAnimals = false,
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
