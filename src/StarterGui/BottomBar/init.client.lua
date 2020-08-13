--[[
TheNexusAvenger

Initialies the bottom bar.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local Background = require(script:WaitForChild("Background"))
local CornerMenuButtons = require(script:WaitForChild("CornerMenuButtons"))
local CenterStats = require(script:WaitForChild("CenterStats"))
local CornerMap = require(script:WaitForChild("CornerMap"))
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BottomBarGui"
ScreenGui.Parent = script.Parent

local BottomFrame = Instance.new("Frame")
BottomFrame.BackgroundTransparency = 1
BottomFrame.AnchorPoint = Vector2.new(0,1)
BottomFrame.Size = UDim2.new(1,0,0.15,0)
BottomFrame.Position = UDim2.new(0,0,1,0)
BottomFrame.Parent = ScreenGui

AspectRatioSwitcher.new(ScreenGui,0.95,function()
    BottomFrame.SizeConstraint = Enum.SizeConstraint.RelativeXY
end,function()
    BottomFrame.SizeConstraint = Enum.SizeConstraint.RelativeXX
end)

--Initialize the bottom bar.
Background.new(BottomFrame)
CornerMenuButtons.new(BottomFrame)
CenterStats.new(BottomFrame)
CornerMap.new(BottomFrame)