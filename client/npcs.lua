local spawnedPeds = {}
local locale = Locale[Config.Locale]

Citizen.CreateThread(function()
    while true do
        Wait(500)
        for k, v in pairs(Config.Stores) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - v.npccoords.xyz)

            if distance < 50 and not spawnedPeds[k] then
                local spawnedPed = NearPed(v.npcmodel, v.npccoords, k)
                spawnedPeds[k] = { spawnedPed = spawnedPed }
            end

            if distance >= 50 and spawnedPeds[k] then
                for i = 255, 0, -51 do
                    Wait(50)
                    SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
                end
                DeletePed(spawnedPeds[k].spawnedPed)
                if Config.Target and Config.FrameWork == 'rsg' then
                    exports.ox_target:removeEntity(spawnedPeds[k].spawnedPed, 'npc_wagonStore')
                end
                spawnedPeds[k] = nil
            end
        end
    end
end)

function NearPed(npcmodel, npccoords, stableid)
    RequestModel(npcmodel)
    while not HasModelLoaded(npcmodel) do
        Wait(50)
    end
    local spawnedPed = CreatePed(npcmodel, npccoords.x, npccoords.y, npccoords.z - 1.0, npccoords.w, false, false, 0, 0)
    SetEntityAlpha(spawnedPed, 0, false)
    SetRandomOutfitVariation(spawnedPed, true)
    SetEntityCanBeDamaged(spawnedPed, false)
    SetEntityInvincible(spawnedPed, true)
    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    SetPedCanBeTargetted(spawnedPed, false)
    for i = 0, 255, 51 do
        Wait(50)
        SetEntityAlpha(spawnedPed, i, false)
    end
    if Config.Target and Config.FrameWork == 'rsg' then
        exports.ox_target:addLocalEntity(spawnedPed, {
            {
                name = 'npc_wagonStore',
                icon = 'far fa-eye',
                label = locale['cl_wagon_store'],
                onSelect = function()
                    TriggerEvent('btc-wagons:client:openStore', stableid)
                end,
                distance = 2.0
            }
        })
    end
    return spawnedPed
end

-- cleanup
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k, v in pairs(spawnedPeds) do
        DeletePed(spawnedPeds[k].spawnedPed)
        exports.ox_target:removeEntity(spawnedPeds[k].spawnedPed, 'npc_wagonStore')
        spawnedPeds[k] = nil
    end
end)
