--[[
TheNexusAvenger

Controls hiding dungeons and teleporting the local player.
--]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local StartDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.StartDungeon")
local ClearDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.ClearDungeon")
local DungeonsContainer = Workspace:WaitForChild("Dungeons")

local StoredDungeons = {}
local CurrentDungeon



--[[
Teleports the player to the dungeon.
--]]
local function TeleportPlayerToDungeon()
    local Dungeon = StoredDungeons[CurrentDungeon]
    if Dungeon then
        local Character = Players.LocalPlayer.Character
        if Character then
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart then
                local Spawn = Dungeon:WaitForChild("Spawn")
                local Rotation = CFrame.new(HumanoidRootPart.Position):inverse() * HumanoidRootPart.CFrame
                HumanoidRootPart.CFrame = Spawn.CFrame * CFrame.new(math.random() * (Spawn.Size.X/2),0,math.random() * (Spawn.Size.Z/2)) * Rotation
            end
        end
    end
end

--[[
Registers a new dungeon model.
--]]
local function DungeonAdded(Model)
    StoredDungeons[Model.Name] = Model
    if Model.Name == CurrentDungeon then
        TeleportPlayerToDungeon()
    end
end



--Add the dungeons.
for _,Model in pairs(DungeonsContainer:GetChildren()) do
    DungeonAdded(Model)
end
DungeonsContainer.ChildAdded:Connect(DungeonAdded)

--Connect the remote events.
StartDungeon.OnClientEvent:Connect(function(X,Y,Id)
    --Set the current dungeon.
    CurrentDungeon = Id

    --Teleport the player.
    TeleportPlayerToDungeon()
end)

ClearDungeon.OnClientEvent:Connect(function(X,Y,Id)
    StoredDungeons[Id] = nil
    if CurrentDungeon == Id then
        CurrentDungeon = nil
    end
end)