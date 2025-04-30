ocal VorpCore = exports.vorp_core:GetCore()

local dutyPairs = {
    ["police"] = "offpolice",
    ["offpolice"] = "police",
    ["doctor"] = "offdoctor",
    ["offdoctor"] = "doctor"
}

RegisterServerEvent('duty:setjob')
AddEventHandler('duty:setjob', function()
    local _source = source
    
    if not _source then
        return
    end
    
    local User = VorpCore.getUser(_source)
    if not User then
        return
    end
    
    local Character = User.getUsedCharacter
    if not Character then
        return
    end
    
    local currentJob = Character.job
    local newJob = dutyPairs[currentJob]
    
    if newJob then
        Character.setJob(newJob)
        TriggerClientEvent("vorp:TipRight", _source, "Dienststatus geändert: " .. newJob, 3000)
        
       -- print("Spieler " .. Character.firstname .. " " .. Character.lastname .. " (" .. _source .. ") hat Job gewechselt: " .. currentJob .. " -> " .. newJob)
    else
        TriggerClientEvent("vorp:TipRight", _source, "Du hast keinen Job mit Dienstwechsel-Option", 3000)
    end
end)