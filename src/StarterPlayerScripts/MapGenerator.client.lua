--[[
TheNexusAvenger

Generates the map around the player.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local TeleportLocations = ReplicatedStorageProject:GetResource("GameData.Generation.TeleportLocations")
local MapGenerator = ReplicatedStorageProject:GetResource("Generation.MapGenerator").new()
MapGenerator:GenerateCustomCells()



--Create plates under the teleport locations in case the map doesn't generate in time.
for LocationName,Location in pairs(TeleportLocations) do
    local Plate = Instance.new("Part")
    Plate.Transparency = 1
    Plate.Anchored = true
    Plate.Size = Vector3.new(100,1,100)
    Plate.CFrame = CFrame.new(Location[1] * 100,-0.5,Location[2] * 100) * CFrame.Angles(0,(-math.pi/2) + Location[3],0)
    Plate.Name = LocationName.."TeleportLocation"
    Plate.Parent = Workspace
end

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