--[[
TheNexusAvenger

Runs the game.
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService"))



--Create the folders.
local GameState = Instance.new("Folder")
GameState.Name = "GameState"
GameState.Parent = ReplicatedStorage

local GameReplication = Instance.new("Folder")
GameReplication.Name = "GameReplication"
GameReplication.Parent = ReplicatedStorage

--Initialize the services.
for _,ServiceModule in pairs(ServerScriptServiceProject:GetResource("Service"):GetChildren()) do
    ServerScriptServiceProject:GetResource("Service."..ServiceModule.Name)
end

--Set up players joining.
local CharacterService = ServerScriptServiceProject:GetResource("Service.CharacterService")
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")
local MapDiscoveryService = ServerScriptServiceProject:GetResource("Service.MapDiscoveryService")
Players.PlayerAdded:Connect(function(Player)
    PlayerDataService:LoadPlayer(Player)
    CharacterService:SpawnCharacter(Player)
    MapDiscoveryService:LoadPlayer(Player)
end)
Players.PlayerRemoving:Connect(function(Player)
    MapDiscoveryService:ClearPlayer(Player)
    PlayerDataService:ClearPlayer(Player)
end)

--Load the NPC models. Can't be saved directly
--to a model file and imported with Rojo.
local NPCService = ServerScriptServiceProject:GetResource("Service.NPCService")
NPCService:LoadNPCModels()