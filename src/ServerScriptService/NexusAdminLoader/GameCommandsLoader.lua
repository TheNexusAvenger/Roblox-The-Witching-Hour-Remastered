--[[
TheNexusAvenger

Loads the game commands and types.
--]]

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NexusAdminAPI = require(ServerScriptService:WaitForChild("NexusAdmin"))
local NexusAdminTypes = ReplicatedStorage:WaitForChild("NexusAdminTypes")
local ClientTypesLoader = script.Parent:WaitForChild("ClientTypesLoader")
local Commands = script.Parent:WaitForChild("Commands")



--Load the types.
for _,Module in pairs(NexusAdminTypes:GetChildren()) do
    if Module:IsA("ModuleScript") then
        require(Module)(NexusAdminAPI)
    end
end

--Loads the commands.
for _,Module in pairs(Commands:GetChildren()) do
    if Module:IsA("ModuleScript") then
        local CommandData = require(Module)
        CommandData.Prefix = NexusAdminAPI.Configuration.CommandPrefix
        CommandData.Category = "GameCommands"
        CommandData.AdminLevel = 2
        NexusAdminAPI.Registry:LoadCommand(CommandData)
    end
end



--Load the types on the client.
NexusAdminAPI.Replicator:GiveStarterScript(ClientTypesLoader)

--Return true so that it doesn't error.
return true