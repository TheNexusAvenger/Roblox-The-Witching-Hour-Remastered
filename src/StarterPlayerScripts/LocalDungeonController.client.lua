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
Updates the visible dungeon.
--]]
local function UpdateVisibleDungeons()
    for Id,DungeonModel in pairs(StoredDungeons) do
        DungeonModel.Parent = (Id == CurrentDungeon and DungeonsContainer or nil)
    end
end

--[[
Registers a new dungeon model.
--]]
local function DungeonAdded(Model)
    StoredDungeons[Model.Name] = Model
    if Model.Name ~= CurrentDungeon then
        coroutine.wrap(function()
            wait()
            if Model.Name ~= CurrentDungeon then
                Model.Parent = nil
            end
        end)()
    else
        TeleportPlayerToDungeon()
    end
end



--Add the dungeons.
for _,Model in pairs(DungeonsContainer:GetChildren()) do
    DungeonAdded(Model)
end
DungeonsContainer.ChildAdded:Connect(DungeonAdded)

--Connect the remote events.
--TODO: Connect the 3rd argument (type) in another script to display the chest message.
StartDungeon.OnClientEvent:Connect(function(X,Y)
    --Set the current dungeon.
    local Id = tostring(X).."_"..tostring(Y)
    CurrentDungeon = Id
    UpdateVisibleDungeons()

    --Teleport the player.
    TeleportPlayerToDungeon()
end)

ClearDungeon.OnClientEvent:Connect(function(X,Y)
    local Id = tostring(X).."_"..tostring(Y)
    StoredDungeons[Id] = nil
    if CurrentDungeon == Id then
        CurrentDungeon = nil
    end
end)