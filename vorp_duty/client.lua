Citizen.CreateThread(function()
    local playerPed
    local coords
    local checkMarkerDistance = 10.0
    local interactionDistance = 2.0 
    local blips = {}

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
        end
        
        if isNearMarker then
            Wait(0)
        else
            Wait(500) 
        end
    end
end)