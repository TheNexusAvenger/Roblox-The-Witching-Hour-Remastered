--[[
TheNexusAvenger

Displays the credits for the game.
--]]

local CREDITS_TEXT = "This game was created to be the first feature-complete "..
"recreation of Halloween 2013: The Witching Hour by the Roblox Games "..
"Team since the original game was never released.\n\n"..
"Building: Roblox Games Team, TheNexusAvenger\n"..
"Coding: TheNexusAvenger\n"..
"Story: Roblox Games Team, konlon15\n"..
"Map: Roblox Games Team, TheNexusAvenger, konlon15\n"..
"Assets: Roblox Games Team\n"..
"Asset discovery: CaptainJadeFlames, konlon15, TheNexusAvenger\n\n"..
"Also thanks to the following for video references:\n"..
"JamiyJamie, Alexrocks911, Arxenious, gerben13, darkchaos321, Justinlol,\n"..
"endryin, Thepdotgamers, Exeplex, PolyMoose\n\n"..
"This game is maintained on GitHub under\n"..
"TheNexusAvenger/roblox-the-witching-hour-remastered\n"..
"Contributions are welcome!"


local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local DisplayOrderController = ReplicatedStorageProject:GetResource("State.DisplayOrderController")



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CreditsView"
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

local BackgroundCover = Instance.new("Frame")
BackgroundCover.BackgroundTransparency = 0.25
BackgroundCover.BackgroundColor3 = Color3.new(0,0,0)
BackgroundCover.BorderSizePixel = 0
BackgroundCover.Position = UDim2.new(0.026,0,0.036,0)
BackgroundCover.Size = UDim2.new(1 - (0.026 * 2),0,1 - (0.036 * 2),0)
BackgroundCover.Parent = Background

local CreditsText = Instance.new("TextLabel")
CreditsText.BackgroundTransparency = 1
CreditsText.BorderSizePixel = 0
CreditsText.Position = UDim2.new(0.03,0,0.05,0)
CreditsText.Size = UDim2.new(0.95,0,0.9,0)
CreditsText.Font = Enum.Font.Antique
CreditsText.TextScaled = true
CreditsText.Text = CREDITS_TEXT
CreditsText.TextColor3 = Color3.new(238/255,205/255,255/255)
CreditsText.TextStrokeColor3 = Color3.new(0,0,0)
CreditsText.TextStrokeTransparency = 0
CreditsText.ZIndex = 3
CreditsText.Parent = Background

local NexusDevelopmentLogo = Instance.new("ImageLabel")
NexusDevelopmentLogo.BackgroundTransparency = 1
NexusDevelopmentLogo.AnchorPoint = Vector2.new(0,1)
NexusDevelopmentLogo.Size = UDim2.new(0.15,0,0.15,0)
NexusDevelopmentLogo.SizeConstraint = Enum.SizeConstraint.RelativeYY
NexusDevelopmentLogo.Position = UDim2.new(0.035,0,0.9725,0)
NexusDevelopmentLogo.Image = "rbxassetid://5221022956"
NexusDevelopmentLogo.Parent = Background

--Connect opening and closing the window.
local OpenValue = script.Parent:WaitForChild("GuiOpenStates"):WaitForChild("Credits")
DisplayOrderController:Register(ScreenGui,OpenValue)
OpenValue.Changed:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,OpenValue.Value and 0.5 or 1.5,0),"Out","Quad",0.5,true)
end)
CloseButton.Button.MouseButton1Down:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,1.5,0),"Out","Quad",0.5,true)
    OpenValue.Value = false
end)