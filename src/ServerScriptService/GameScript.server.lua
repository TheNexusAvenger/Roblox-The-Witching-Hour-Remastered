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

--Initialize the resources before loading players.
--These resources are required by the players on join.
local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")
InventoryService:LoadCharacterAssets()

--Load the NPC models. Can't be saved directly
--to a model file and imported with Rojo.
local NPCService = ServerScriptServiceProject:GetResource("Service.NPCService")
NPCService:LoadNPCModels()

--Get the services.
local CharacterService = ServerScriptServiceProject:GetResource("Service.CharacterService")
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")
local QuestService = ServerScriptServiceProject:GetResource("Service.QuestService")
local MapDiscoveryService = ServerScriptServiceProject:GetResource("Service.MapDiscoveryService")
local EnergyService = ServerScriptServiceProject:GetResource("Service.EnergyService")



--[[
Handles a player being added.
--]]
local function PlayerAdded(Player)
    PlayerDataService:LoadPlayer(Player)
    QuestService:LoadPlayer(Player)
    InventoryService:LoadPlayer(Player)
    CharacterService:SpawnCharacter(Player)
    MapDiscoveryService:LoadPlayer(Player)
    EnergyService:LoadPlayer(Player)
end

--[[
Handles a player being removed.
--]]
local function PlayerRemoved(Player)
    MapDiscoveryService:ClearPlayer(Player)
    QuestService:ClearPlayer(Player)
    InventoryService:ClearPlayer(Player)
    PlayerDataService:ClearPlayer(Player)
end



--Set up players joining.
Players.PlayerAdded:Connect(PlayerAdded)
Players.PlayerRemoving:Connect(PlayerRemoved)
for _,Player in pairs(Players:GetPlayers()) do
    coroutine.wrap(function()
        PlayerAdded(Player)
    end)()
end