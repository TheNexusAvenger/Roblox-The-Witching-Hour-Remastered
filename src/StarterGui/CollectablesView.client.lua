--[[
TheNexusAvenger

Displays the collectables owned by the player.
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local Bloxkins = ReplicatedStorageProject:GetResource("GameData.Item.Bloxkins")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local DisplayOrderController = ReplicatedStorageProject:GetResource("State.DisplayOrderController")
local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData").GetPlayerData(Players.LocalPlayer)



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CollectablesView"
ScreenGui.DisplayOrder = 2
ScreenGui.Parent = script.Parent

--Create the container.
local Background = Instance.new("ImageLabel")
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0.5,0,1.5,0)
Background.AnchorPoint = Vector2.new(0.5,0.5)
Background.Image = "rbxassetid://131274595"
Background.Parent = ScreenGui

AspectRatioSwitcher.new(ScreenGui,1.4,function()
    Background.Size = UDim2.new(0.9 * 1.4,0,0.9,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
end,function()
    Background.Size = UDim2.new(0.9,0,0.9/1.4,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
end)

local CloseImage = Instance.new("ImageLabel")
CloseImage.BackgroundTransparency = 1
CloseImage.AnchorPoint = Vector2.new(1,0)
CloseImage.Size = UDim2.new(0.065,0,0.065,0)
CloseImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
CloseImage.Position = UDim2.new(1,0,0,0)
CloseImage.ZIndex = 4
CloseImage.Parent = Background
local CloseButton = ImageEventBinder.new(CloseImage,UDim2.new(1,0,1,0),"rbxassetid://131302488","rbxassetid://131302438","rbxassetid://131302465")

local CollectablesScrollFrame = Instance.new("ScrollingFrame")
CollectablesScrollFrame.BackgroundTransparency = 1
CollectablesScrollFrame.BorderSizePixel = 0
CollectablesScrollFrame.Position = UDim2.new(0.026,0,0.036,0)
CollectablesScrollFrame.Size = UDim2.new(1 - (0.026 * 2),0,1 - (0.036 * 2),0)
CollectablesScrollFrame.CanvasSize = UDim2.new(2 * (1 - (0.026 * 2)),0,0,0)
CollectablesScrollFrame.ScrollBarThickness = 10
CollectablesScrollFrame.TopImage = "rbxassetid://5706837205"
CollectablesScrollFrame.MidImage = "rbxassetid://5706836960"
CollectablesScrollFrame.BottomImage = "rbxassetid://5706836746"
CollectablesScrollFrame.Parent = Background

local BackgroundTexture1 = Instance.new("ImageLabel")
BackgroundTexture1.BackgroundColor3 = Color3.new(0,0,0)
BackgroundTexture1.BorderSizePixel = 0
BackgroundTexture1.Size = UDim2.new(0.5,0,1,0)
BackgroundTexture1.Position = UDim2.new(0,0,0,0)
BackgroundTexture1.Image = "rbxassetid://132834923"
BackgroundTexture1.Parent = CollectablesScrollFrame

local BackgroundTexture2 = Instance.new("ImageLabel")
BackgroundTexture2.BackgroundColor3 = Color3.new(0,0,0)
BackgroundTexture2.BorderSizePixel = 0
BackgroundTexture2.Size = UDim2.new(0.5,0,1,0)
BackgroundTexture2.Position = UDim2.new(0.5,0,0,0)
BackgroundTexture2.Image = "rbxassetid://132202849"
BackgroundTexture2.Parent = CollectablesScrollFrame

--Create the bloxkins.
local BloxkinImages = {}
for BloxkinName,BloxkinData in pairs(Bloxkins) do
    local BloxkinImage = Instance.new("ImageLabel")
    BloxkinImage.BackgroundTransparency = 1
    BloxkinImage.Size = UDim2.new((BloxkinData.SizeY / 2)/600,0,BloxkinData.SizeY/600,0)
    BloxkinImage.SizeConstraint = "RelativeYY"
    BloxkinImage.Position = UDim2.new(BloxkinData.PosX/(1082 * 2),0,BloxkinData.PosY/600,0)
    BloxkinImage.Image = BloxkinData.LockedImage
    BloxkinImage.Parent = CollectablesScrollFrame
    BloxkinImage.ZIndex = BloxkinData.PosY + BloxkinData.SizeY
    BloxkinImages[BloxkinName] = BloxkinImage
end



--[[
Updates the images of the bloxkins.
--]]
local function UpdateBloxkinImages()
    local CollectedBloxkins = PlayerData:GetValue("CollectedBloxkins")
    for BloxkinName,BloxkinImage in pairs(BloxkinImages) do
        local BloxkinData = Bloxkins[BloxkinName]
        BloxkinImage.Image = (CollectedBloxkins[BloxkinName] and BloxkinData.UnlockedImage or BloxkinData.LockedImage)
    end
end



--Connect updating the bloxkins.
UpdateBloxkinImages()
PlayerData:GetValueChangedSignal("CollectedBloxkins"):Connect(function()
    UpdateBloxkinImages()
end)

--Connect opening and closing the window.
local OpenValue = script.Parent:WaitForChild("GuiOpenStates"):WaitForChild("Collectables")
DisplayOrderController:Register(ScreenGui,OpenValue)
OpenValue.Changed:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,OpenValue.Value and 0.5 or 1.5,0),"Out","Quad",0.5,true)
end)
CloseButton.Button.MouseButton1Down:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,1.5,0),"Out","Quad",0.5,true)
    OpenValue.Value = false
end)