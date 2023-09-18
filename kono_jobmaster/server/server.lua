VORPcore = {}
local VORPInv = {}

VORPInv = exports.vorp_inventory:vorp_inventoryApi()


TriggerEvent("getCore", function(core)
    VORPcore = core
end)

RegisterNetEvent("kono_jobmaster:GetJobs")
AddEventHandler("kono_jobmaster:GetJobs", function()
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local job = Character.job
    TriggerClientEvent("kono_jobmaster:UpdateJob", _source, job)
end)

RegisterNetEvent("kono_jobmaster:GetInventory")
AddEventHandler("kono_jobmaster:GetInventory", function(id)
    local _source = source
    VORPInv.OpenInv(_source, id)
end)

Citizen.CreateThread(function ()
    for k, loc in pairs(Config.Locations) do
        VORPInv.registerInventory(loc.Job, loc.Name, 5000, false, true, true)
    end
end)

RegisterNetEvent("kono_jobmaster:harvest")
AddEventHandler("kono_jobmaster:harvest", function(itemToAdd, amount)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local canCarry = VORPInv.canCarryItem(_source, itemToAdd, 1)
    local canCarry2 = VORPInv.canCarryItems(_source, 1)
    

    if not canCarry then
        return VORPcore.NotifyRightTip(_source," you cant carry this item" , 3000)
    end

    if not canCarry2 then
        return VORPcore.NotifyRightTip(_source, "you cant carry this item", 3000)
    end

    VORPInv.addItem(_source, itemToAdd, 1)

    for k, v in pairs(Config.Locations) do
        local notificationToPlay = Config.Locations[k].harvestNotification
        VORPcore.NotifyRightTip(_source, notificationToPlay, 3000)
    end


end)


RegisterNetEvent("kono_jobmaster:treatment")
AddEventHandler("kono_jobmaster:treatment", function(harvestedItem, treatedItem, amount)
    local _source = source
    local Character = VORPcore.getUser(_source).getUsedCharacter
    local canCarry = VORPInv.canCarryItem(_source, treatedItem, 1)
    local canCarry2 = VORPInv.canCarryItems(_source, 1)
    local itemCount = VORPInv.getItemCount(_source, harvestedItem)
    

    if not canCarry then
        return VORPcore.NotifyRightTip(_source," you cant carry this item" , 3000)
    end

    if not canCarry2 then
        return VORPcore.NotifyRightTip(_source, "you cant carry this item", 3000)
    end

    if itemCount < 1 then
        return VORPcore.NotifyRightTip(_source, "you dont have the item required", 3000)
    else
        VORPInv.subItem(_source, harvestedItem, 1)
        VORPInv.addItem(_source, treatedItem, 1)
    end


    for k, v in pairs(Config.Locations) do
        local notificationToPlay = Config.Locations[k].treatmentNotification
        VORPcore.NotifyRightTip(_source, notificationToPlay, 3000)
    end

    
end)

