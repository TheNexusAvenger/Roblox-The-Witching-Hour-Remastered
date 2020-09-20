--[[
TheNexusAvenger

Displays informations about the dungeon.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local Items = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local StartDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.StartDungeon")
local EndDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.EndDungeon")
local DisplayReward = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.DisplayReward")
local DisplayMessage = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.DisplayMessage")
local ItemAwardAnimation = ReplicatedStorageProject:GetResource("UI.ItemAwardAnimation")
local ItemIcon = ReplicatedStorageProject:GetResource("UI.ItemIcon")



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DungeonView"
ScreenGui.DisplayOrder = 2
ScreenGui.Parent = script.Parent

--Create the chest selection messages.
local TreasureTopText = Instance.new("TextLabel")
TreasureTopText.BackgroundTransparency = 1
TreasureTopText.Size = UDim2.new(1,0,0.075,0)
TreasureTopText.Font = Enum.Font.Antique
TreasureTopText.Text = "Trick of Treat!"
TreasureTopText.TextColor3 = Color3.new(254/255,196/255,9/255)
TreasureTopText.TextScaled = true
TreasureTopText.Visible = false
TreasureTopText.Parent = ScreenGui

local TreasureBottomText = Instance.new("TextLabel")
TreasureBottomText.BackgroundTransparency = 1
TreasureBottomText.Size = UDim2.new(1,0,0.06,0)
TreasureBottomText.Position = UDim2.new(0,0,0.075,0)
TreasureBottomText.Font = Enum.Font.Antique
TreasureBottomText.Text = "Pick a chest... Be careful!"
TreasureBottomText.TextColor3 = Color3.new(17/255,108/255,1/255)
TreasureBottomText.TextScaled = true
TreasureBottomText.Visible = false
TreasureBottomText.Parent = ScreenGui

--Create the item awarding messages.
local MessageText = Instance.new("TextLabel")
MessageText.Visible = false
MessageText.BackgroundTransparency = 1
MessageText.Size = UDim2.new(0.8,0,0.6,0)
MessageText.Position = UDim2.new(0.1,0,0.2,0)
MessageText.Font = Enum.Font.Antique
MessageText.TextWrapped = true
MessageText.TextColor3 = Color3.new(1,1,1)
MessageText.TextSize = ScreenGui.AbsoluteSize.Y * 0.05
MessageText.Parent = ScreenGui
ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
    MessageText.TextSize = ScreenGui.AbsoluteSize.Y * 0.05
end)

local Background = Instance.new("ImageLabel")
Background.AnchorPoint = Vector2.new(0.5,0.5)
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0.5,0,-0.5,0)
Background.Size = UDim2.new(0.3 * (464/310),0,0.3,0)
Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
Background.Image = "rbxassetid://133394044"
Background.Parent = ScreenGui

local ItemIconAdorn = Instance.new("Frame")
ItemIconAdorn.BackgroundTransparency = 1
ItemIconAdorn.AnchorPoint = Vector2.new(0.5,0.5)
ItemIconAdorn.Position = UDim2.new(0.5 + (2/464),0,0.5 + (4/310),0)
ItemIconAdorn.Size = UDim2.new(100/310,0,100/310,0)
ItemIconAdorn.SizeConstraint = Enum.SizeConstraint.RelativeYY
ItemIconAdorn.Parent = Background

local AwardIcon = ItemIcon.new()
AwardIcon:SetParent(ItemIconAdorn)

local ItemAwardText = Instance.new("TextLabel")
ItemAwardText.BackgroundTransparency = 1
ItemAwardText.Size = UDim2.new(0.7,0,32/310,0)
ItemAwardText.Position = UDim2.new(0.15,0,0.81,0)
ItemAwardText.Font = Enum.Font.Antique
ItemAwardText.Text = "Item"
ItemAwardText.TextColor3 = Color3.new(254/255,196/255,9/255)
ItemAwardText.TextScaled = true
ItemAwardText.Parent = Background



--Connect the events.
StartDungeon.OnClientEvent:Connect(function(_,_,_,Type)
    if Type == "Treasure" then
        TreasureTopText.Visible = true
        TreasureBottomText.Visible = true
    end
end)

EndDungeon.OnClientEvent:Connect(function()
    TreasureTopText.Visible = false
    TreasureBottomText.Visible = false
end)

DisplayReward.OnClientEvent:Connect(function(ItemName)
    local ItemData = Items[ItemName]
    if ItemData then
        --Set the display.
        AwardIcon:SetItem(ItemName)
        ItemAwardText.Text = ItemData.DisplayName

        --Show and hide the display.
        Background:TweenPosition(UDim2.new(0.5,0,0.5,0),"InOut","Quad",0.5,true,function()
            wait(4.5)
            ItemAwardAnimation.DisplayItemAwardFromFrame(ItemName,ItemIconAdorn)
            Background:TweenPosition(UDim2.new(0.5,0,-0.5,0),"InOut","Quad",0.5)
        end)
    end
end)

DisplayMessage.OnClientEvent:Connect(function(Message)
    MessageText.Text = Message
    MessageText.Visible = true
    wait(5)
    MessageText.Visible = false
end)