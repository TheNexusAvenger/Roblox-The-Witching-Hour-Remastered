--[[
TheNexusAvenger

Allows players to buy items.
--]]

local STORE_CATEGORIES = {
    "Featured",
    "Companions",
    "Customize",
    "Unlockables",
}



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local StoreItems = ReplicatedStorageProject:GetResource("GameData.Item.Store")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local WideTextButtonDecorator = ReplicatedStorageProject:GetResource("UI.Button.WideTextButtonDecorator")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData").GetPlayerData(Players.LocalPlayer)
local StoreItem = require(script:WaitForChild("StoreItem"))

local DB = true
local CurrentCategory = "Featured"
local StoreFrames = {}
local Background,StoreGridLayout



--[[
Updates the visible store frames.
--]]
local function UpdateVisibleStoreFrames()
    for _,Button in pairs(StoreFrames) do
        Button:UpdateVisibility(CurrentCategory)
    end
end

--[[
Updates the store grid constraint.
--]]
local function UpdateStoreGridLayout()
    local BackgroundSize = Background.AbsoluteSize
    local Padding = (882 - (4 * 202))/8
    StoreGridLayout.CellPadding = UDim2.new(0,BackgroundSize.X * (Padding/882),0,BackgroundSize.X * (Padding/882))
    StoreGridLayout.CellSize = UDim2.new(0,BackgroundSize.X * (202/882),0,BackgroundSize.X * (116/882))
end



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "StoreView"
ScreenGui.DisplayOrder = 2
ScreenGui.Parent = script.Parent

--Create the container.
Background = Instance.new("ImageLabel")
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0.5,0,1.5,0)
Background.AnchorPoint = Vector2.new(0.5,0.5)
Background.Image = "rbxassetid://132891351"
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

local StoreScrollingFrame = Instance.new("ScrollingFrame")
StoreScrollingFrame.BackgroundTransparency = 1
StoreScrollingFrame.BorderSizePixel = 0
StoreScrollingFrame.Size = UDim2.new(1 - (20/903),0,1 - (245/640),0)
StoreScrollingFrame.Position = UDim2.new(10/903,0,221/640,0)
StoreScrollingFrame.Parent = Background

StoreGridLayout = Instance.new("UIGridLayout")
StoreGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
StoreGridLayout.Parent = StoreScrollingFrame
Background:GetPropertyChangedSignal("AbsoluteSize"):Connect(UpdateStoreGridLayout)
UpdateStoreGridLayout()
StoreGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    StoreScrollingFrame.CanvasSize = UDim2.new(0,0,0,StoreGridLayout.AbsoluteContentSize.Y)
end)
StoreScrollingFrame.CanvasSize = UDim2.new(0,0,0,StoreGridLayout.AbsoluteContentSize.Y)

--Create the category buttons.
local CandyCategoryImage = Instance.new("ImageLabel")
CandyCategoryImage.BackgroundTransparency = 1
CandyCategoryImage.Size = UDim2.new(0.17,0,0.1,0)
CandyCategoryImage.Position = UDim2.new(0.69,0,0.1,0)
CandyCategoryImage.Parent = Background
local CandyCategoryButton = ImageEventBinder.new(CandyCategoryImage,UDim2.new(1,0,1,0),"rbxassetid://132625772","rbxassetid://132625751","rbxassetid://132625763")

CandyCategoryButton.Button.MouseButton1Down:Connect(function()
    if DB then
        DB = false
        CurrentCategory = "Candy"
        UpdateVisibleStoreFrames()
        wait()
        DB = true
    end
end)

local CandyText = Instance.new("TextLabel")
CandyText.BackgroundTransparency = 1
CandyText.Size = UDim2.new(0.09,0,0.06,0)
CandyText.Position = UDim2.new(0.7,0,0.18,0)
CandyText.Font = Enum.Font.Antique
CandyText.TextScaled = true
CandyText.Text = tostring(PlayerData:GetValue("Currency"))
CandyText.TextColor3 = Color3.new(238/255,205/255,255/255)
CandyText.TextStrokeColor3 = Color3.new(0,0,0)
CandyText.TextStrokeTransparency = 0
CandyText.TextXAlignment = Enum.TextXAlignment.Right
CandyText.Parent = Background

PlayerData:GetValueChangedSignal("Currency"):Connect(function()
    CandyText.Text = tostring(PlayerData:GetValue("Currency"))
end)

local CategoriesFrame = Instance.new("Frame")
CategoriesFrame.BackgroundTransparency = 1
CategoriesFrame.Position = UDim2.new(0.02,0,0.25,0)
CategoriesFrame.Size = UDim2.new(0.96,0,0.06,0)
CategoriesFrame.Parent = Background

for _,Category in pairs(STORE_CATEGORIES) do
    local CategoryImage = Instance.new("ImageLabel")
    CategoryImage.BackgroundTransparency = 1
    CategoryImage.Size = UDim2.new(188/52,0,1,0)
    CategoryImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    CategoryImage.Parent = CategoriesFrame
    local CategoryButton = WideTextButtonDecorator.new(CategoryImage,Category)

    CategoryButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            CurrentCategory = Category
            UpdateVisibleStoreFrames()
            wait()
            DB = true
        end
    end)
end

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0.025,0)
ListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
ListLayout.FillDirection = Enum.FillDirection.Horizontal
ListLayout.Parent = CategoriesFrame

--Create the store items.
for TransactionId,_ in pairs(StoreItems) do
    table.insert(StoreFrames,StoreItem.new(TransactionId,StoreScrollingFrame))
end
UpdateVisibleStoreFrames()

--Connect opening and closing.
local OpenValue = script.Parent:WaitForChild("GuiOpenStates"):WaitForChild("Store")
OpenValue.Changed:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,OpenValue.Value and 0.5 or 1.5,0),"Out","Quad",0.5,true)
end)
CloseButton.Button.MouseButton1Down:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,1.5,0),"Out","Quad",0.5,true)
    OpenValue.Value = false
end)