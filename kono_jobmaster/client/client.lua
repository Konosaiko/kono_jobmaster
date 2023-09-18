local job = nil
local Animations = exports.vorp_animations.initiate()
-----------------------------------------------------------------------------------------
---------------------------------UI------------------------------------------------
UIPrompt = {}

local promptGroup = GetRandomIntInRange(0, 0xffffff)

UIPrompt.activate = function(title)
    local label = CreateVarString(10, 'LITERAL_STRING', title)
    PromptSetActiveGroupThisFrame(promptGroup, label)
end

UIPrompt.initialize = function()
    local str = _U('Press')
    JobPrompt = PromptRegisterBegin()
    PromptSetControlAction(JobPrompt, Config.Key)
    str = CreateVarString(10, 'LITERAL_STRING', str)
    PromptSetText(JobPrompt, str)
    PromptSetEnabled(JobPrompt, 1)
    PromptSetVisible(JobPrompt, 1)
    PromptSetStandardMode(JobPrompt, 1)
    PromptSetGroup(JobPrompt, promptGroup)
    Citizen.InvokeNative(0xC5F428EE08FA7F2C, JobPrompt, true)
    PromptRegisterEnd(JobPrompt)
end


-----------------------------------------------------------------------------------------
---------------------------------GET JOBS---------------------------------------------
RegisterNetEvent("vorp:SelectedCharacter")
AddEventHandler("vorp:SelectedCharacter", function()
    TriggerServerEvent("kono_jobmaster:GetJobs")
end)

-----------------------------------------------------------------------------------------
---------------------------------BLIPS---------------------------------------------------
function AddBlips()
    if Config.BlipsActive then
        for k, v in pairs(Config.Locations) do
            Config.Locations[k].BlipHandler = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.Blipcoords.x,
                v.Blipcoords.y, v.Blipcoords.z)
            if (Config.Locations[k].Blipsprite) then
                SetBlipSprite(Config.Locations[k].BlipHandler, Config.Locations[k].Blipsprite, 1)
            else
                SetBlipSprite(Config.Locations[k].BlipHandler, Config.Blipsprite, 1)
            end
            SetBlipScale(Config.Locations[k].BlipHandler, 0.2)

            local blipName = CreateVarString(10, 'LITERAL_STRING', Config.Locations[k].Name);
            Citizen.InvokeNative(0x9CB1A1623062F402, Config.Locations[k].BlipHandler, blipName)
        end
    end
end

function RemoveBlips()
    for k, v in pairs(Config.Locations) do
        RemoveBlip(v.BlipHandler)
    end
end

-----------------------------------------------------------------------------------------
---------------------------------JOB UPDATE---------------------------------------------
RegisterNetEvent("kono_jobmaster:UpdateJob")
AddEventHandler("kono_jobmaster:UpdateJob", function(rjob)
    job = rjob
end)

-----------------------------------------------------------------------------------------
---------------------------------STORAGE BLIP---------------------------------------------
Citizen.CreateThread(function()
    AddBlips()
    UIPrompt.initialize()

    while job == nil do
        Wait(100)
    end

    while true do
        Wait(1)
        
        for index, location in pairs(Config.Locations) do
            if job == location.Job then
                local playerPosition = GetEntityCoords(GetPlayerPed(PlayerId()))
                local InventoryPosition = vector3(location.StoragePosition.x, location.StoragePosition.y,
                    location.StoragePosition.z)
                local dist = #(playerPosition - InventoryPosition)

                if dist < 1.0 then
                    UIPrompt.activate(_U("OpenInventory") .. location.Name)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE, JobPrompt) then
                        TriggerServerEvent("kono_jobmaster:GetInventory", location.Job)
                    end
                end
            end
        end
    end
end)


-----------------------------------------------------------------------------------------
---------------------------------HARVEST BLIP--------------------------------------------


Citizen.CreateThread(function()
    while true do
        Wait(1)

        for _, harvest in pairs(Config.Locations) do
            if job == harvest.Job then
                local playerPosition = GetEntityCoords(GetPlayerPed(PlayerId()))
                local HarvestPosition = vector3(harvest.HarvestPosition.x, harvest.HarvestPosition.y,
                    harvest.HarvestPosition.z)
                local distToHarvest = #(playerPosition - HarvestPosition)
                

                if distToHarvest < 1.0 then
                    UIPrompt.activate(_U("Harvest") .. harvest.Name)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE, JobPrompt) then
                        local itemToAdd = harvest.itemName
                        local animationToPlay = harvest.harvestAnimation
                        local animationDuration = harvest.harvestAnimationDuration
                        
                        Animations.playAnimation(animationToPlay, animationDuration)  
                        Citizen.Wait(1000)  -- Attendre que l'animation soit terminée
                        TriggerServerEvent("kono_jobmaster:harvest", itemToAdd, 1)
                    
                    end
                end
            end
        end
    end
end)



-----------------------------------------------------------------------------------------
---------------------------------TREATMENT BLIP------------------------------------------

Citizen.CreateThread(function()
    while true do
        Wait(1)

        for _, treatment in pairs(Config.Locations) do
            if job == treatment.Job then
                local playerPosition = GetEntityCoords(GetPlayerPed(PlayerId()))
                local TreatmentPosition = vector3(treatment.TreatmentPosition.x, treatment.TreatmentPosition.y,
                    treatment.TreatmentPosition.z)
                local distToTreatment = #(playerPosition - TreatmentPosition)
                

                if distToTreatment < 1.0 then
                    UIPrompt.activate(_U("Treatment") .. treatment.Name)
                    if Citizen.InvokeNative(0xC92AC953F0A982AE, JobPrompt) then
                        local treatedItem = treatment.itemTreated
                        local harvestedItem = treatment.itemName
                        local animationToPlay = treatment.treatmentAnimation
                        local animationDuration = treatment.treatmentAnimationDuration
                        
                        Animations.playAnimation(animationToPlay, animationDuration)  
                        Citizen.Wait(100)  -- Attendre que l'animation soit terminée
                        TriggerServerEvent("kono_jobmaster:treatment", harvestedItem, treatedItem, 1)
                    
                    end
                end
            end
        end
    end
end)
