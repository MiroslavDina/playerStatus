-- Define a table to store player text
local playerText = {}

-- Register a chat command handler for /state
QBCore.Commands.Add("state", "Set or remove your text above your ped", function(source, args)
    local playerId = source
    local text = table.concat(args, " ")

    if text ~= "" then
        playerText[playerId] = text
        TriggerClientEvent("updatePlayerText", -1, playerText)
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Your text above your ped has been updated to: " .. text)
    else
        playerText[playerId] = nil
        TriggerClientEvent("updatePlayerText", -1, playerText)
        TriggerClientEvent("chatMessage", source, "SYSTEM", {255, 0, 0}, "Your text above your ped has been removed.")
    end
end, {})

-- Register a client event handler to update player text
RegisterServerEvent("updatePlayerText")
AddEventHandler("updatePlayerText", function(textTable)
    playerText = textTable
    TriggerClientEvent("updatePlayerText", -1, playerText)
end)

-- Create a loop to periodically update player text
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10000) -- Adjust the delay as needed (in milliseconds)
        TriggerClientEvent("updatePlayerText", -1, playerText)
    end
end)
