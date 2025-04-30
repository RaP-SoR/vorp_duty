Citizen.CreateThread(function()
    local playerPed
    local coords
    local checkMarkerDistance = 10.0
    local interactionDistance = 2.0 
    local blips = {}
    local createdBlips = {}
    local blipDistance = 15.0

       for k, v in pairs(Config.Zones) do
        if v.Blip then
            blips[k] = v.Blip
            createdBlips[k] = nil 
        end
    end

    while true do
        playerPed = PlayerPedId()
        coords = GetEntityCoords(playerPed)
        local isNearMarker = false
        
        for k, v in pairs(Config.Zones) do
            local dist = #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z))
            
            if dist < checkMarkerDistance then
                isNearMarker = true
                
                if dist < interactionDistance then

                    local promptText = CreateVarString(10, "LITERAL_STRING", Config.text)
                    PromptSetActiveGroupThisFrame(0, promptText)
                    
                    if IsControlJustPressed(0, 0x760A9C6F) then -- G Taste
                        TriggerServerEvent('duty:setjob')
                    end
                end
            end

            if blips[k] then
                if dist < blipDistance then
                    if not createdBlips[k] then
                        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.Pos.x, v.Pos.y, v.Pos.z)
                        SetBlipSprite(blip, blips[k].sprite)
                        SetBlipScale(blip, blips[k].scale)
                        Citizen.InvokeNative(0x9CB1A1623062F402, blip, blips[k].name)
                        createdBlips[k] = blip
                    end
                else
                    if createdBlips[k] then
                        RemoveBlip(createdBlips[k])
                        createdBlips[k] = nil
                    end
                end
            end
        end

        
        if isNearMarker then
            Wait(0)
        else
            Wait(500) 
        end
    end
end)



AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, blip in pairs(createdBlips) do
            RemoveBlip(blip)
        end
    end
end)