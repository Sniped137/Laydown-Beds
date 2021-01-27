ESX = nil 


beds = -1091386327, -1182962909, 2117668672, 1631638868 
local anim = "anim@gangops@morgue@table@"



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)



Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0) 
        local ped = GetPlayerPed(-1) 
        local plycoords = GetEntityCoords(ped) 

        
            
           
        local bedloc = GetClosestObjectOfType(plycoords.x, plycoords.y, plycoords.z, 1.0, beds[i], false, false, false)
        local bedPos = GetEntityCoords(bedloc)
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, bedPos.x, bedPos.y, bedPos.z, true)
            
           
        if dist > 1.55 then
            ESX.ShowHelpNotfication('Press ~INPUT_CONTEXT~ to lay down') 
            if IsControlJustPressed(0, 51) then
                mainbed(bedPos.x, bedPos.y, bedPos.z, 1.0) 
            end
        end
    end
end)


function mainbed(x, y, z, heading)
    inBed = true
    
    SetEntityCoords(GetPlayerPed(-1), x, y, z, heading)
    RequestAnimDict(anim)   
    
    Citizen.Wait(0)

    while not HasAnimDictLoaded(anim) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(GetPlayerPed(-1), 'anim@gangops@morgue@table@', 'ko_front', 8.0, -8.0, -1, 1, 0, false, false, false) --anim@gangops@morgue@table@ 
    SetEntityHeading(GetPlayerPed(-1), heading + 180.0)

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
            if inBed == true then
                ESX.ShowHelpNotfication('Press ~INPUT_CONTEXT~ to stand back up')
                if IsControlJustPressed(0, 51) then
                    ClearPedTasks(GetPlayerPed(-1))
                    inBed = false
                
                end
            end
        end
    end)
end