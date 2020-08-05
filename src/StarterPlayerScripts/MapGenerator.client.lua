--[[
TheNexusAvenger

Generates the map around the player.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local MapGenerator = ReplicatedStorageProject:GetResource("Generation.MapGenerator").new()
MapGenerator:GenerateCustomCells()



--Set up changing the center to generate.
local Camera = Workspace.CurrentCamera
Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
    local CameraCenter = Camera.CFrame
    MapGenerator:GenerateCells(math.floor((CameraCenter.X/100) + 0.5),math.floor((CameraCenter.Z/100) + 0.5))
end)

--Set up updating the generator.
RunService.Stepped:Connect(function()
    MapGenerator:UpdateQueuedCells()
end)