QBCore = exports['qb-core']:GetCoreObject()

local isDisplayingSentence = false -- Variable to track if the sentence is being displayed
local sentence = "" -- Variable to store the sentence

-- Register a chat command handler for /state
RegisterCommand("state", function(source, args, rawCommand)
    if args[1] then
        -- If arguments are provided, set the sentence to display
        sentence = table.concat(args, " ")
        isDisplayingSentence = true
    else
        -- If no arguments are provided, clear the sentence
        sentence = ""
        isDisplayingSentence = false
    end
end, false)

-- Create a loop to display the sentence above the player's ped
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isDisplayingSentence then
            local ped = PlayerPedId()
            local x, y, z = table.unpack(GetEntityCoords(ped))
            local text = sentence
            DrawText3D(x, y, z + 1.0, text)
        end
    end
end)

-- Function to draw text in 3D space
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = 0.3
    local font = 4

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextCentre(1)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end
