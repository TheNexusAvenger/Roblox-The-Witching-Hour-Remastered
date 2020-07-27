--[[
TheNexusAvenger

Generates the map around the player.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local MapGenerator = ReplicatedStorageProject:GetResource("Generation.MapGenerator").new()



--[[
Handles a character being added.
--]]
local function CharacterAdded(Character)
    if Character then
        local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
        while HumanoidRootPart.Parent do
            local Center = HumanoidRootPart.Position
            MapGenerator:GenerateCells(math.floor((Center.X/100) + 0.5),math.floor((Center.Z/100) + 0.5))
            wait()
        end
    end
end



--Set up the local player.
local Player = Players.LocalPlayer
Player.CharacterAdded:Connect(CharacterAdded)
CharacterAdded(Player.Character)