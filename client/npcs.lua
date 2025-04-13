local spawnedPeds = {}

Citizen.CreateThread(function()
    local sleep = 500
    while true do      
        for k,v in pairs(Config.Stores) do
            local playerCoords = GetEntityCoords(PlayerPedId())
            local distance = #(playerCoords - v.npccoords.xyz)

            if distance < 50 and not spawnedPeds[k] then
                local spawnedPed = NearPed(v.npcmodel, v.npccoords)
                spawnedPeds[k] = { spawnedPed = spawnedPed }
            end
            
            if distance >= 50 and spawnedPeds[k] then
                    for i = 255, 0, -51 do
                        Citizen.Wait(50)
                        SetEntityAlpha(spawnedPeds[k].spawnedPed, i, false)
                    end
                DeletePed(spawnedPeds[k].spawnedPed)
                spawnedPeds[k] = nil
            end

        end
        Wait(sleep)
    end
end)

function NearPed(npcmodel, npccoords)
    RequestModel(npcmodel)
    while not HasModelLoaded(npcmodel) do
        Citizen.Wait(50)
    end
    spawnedPed = CreatePed(npcmodel, npccoords.x, npccoords.y, npccoords.z - 1.0, npccoords.w, false, false, 0, 0)
    SetEntityAlpha(spawnedPed, 0, false)
    Citizen.InvokeNative(0x283978A15512B2FE, spawnedPed, true)
    SetEntityCanBeDamaged(spawnedPed, false)
    SetEntityInvincible(spawnedPed, true)
    FreezeEntityPosition(spawnedPed, true)
    SetBlockingOfNonTemporaryEvents(spawnedPed, true)
    -- set relationship group between npc and player
    Citizen.InvokeNative(0xC80A74AC829DDD92, spawnedPed, GetPedRelationshipGroupHash(spawnedPed)) -- SetPedRelationshipGroupHash
    Citizen.InvokeNative(0xBF25EB89375A37AD, 1, GetPedRelationshipGroupHash(spawnedPed), `PLAYER`) -- SetRelationshipBetweenGroups
    if Config.Debug then
        local relationship = Citizen.InvokeNative(0x9E6B70061662AE5C, GetPedRelationshipGroupHash(spawnedPed), `PLAYER`) -- GetRelationshipBetweenGroups
        print(relationship)
    end
    -- end of relationship group
        for i = 0, 255, 51 do
            Citizen.Wait(50)
            SetEntityAlpha(spawnedPed, i, false)
        end
    return spawnedPed
end

-- cleanup
AddEventHandler("onResourceStop", function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    for k,v in pairs(spawnedPeds) do
        DeletePed(spawnedPeds[k].spawnedPed)
        spawnedPeds[k] = nil
    end
end)
