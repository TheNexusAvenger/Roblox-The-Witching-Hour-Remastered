--[[
TheNexusAvenger

Initialies the bottom bar.
--]]

local Background = require(script:WaitForChild("Background"))
local CornerMenuButtons = require(script:WaitForChild("CornerMenuButtons"))
local CornerMap = require(script:WaitForChild("CornerMap"))



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BottomBarGui"
ScreenGui.Parent = script.Parent

local BottomFrame = Instance.new("Frame")
BottomFrame.BackgroundTransparency = 1
BottomFrame.Size = UDim2.new(1,0,0.15,0)
BottomFrame.Position = UDim2.new(0,0,0.85,0)
BottomFrame.Parent = ScreenGui

--Initialize the bottom bar.
Background.new(BottomFrame)
CornerMenuButtons.new(BottomFrame)
CornerMap.new(BottomFrame)