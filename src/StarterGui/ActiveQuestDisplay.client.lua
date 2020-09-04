--[[
TheNexusAvenger

Displays the active quest for the player.
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local GuiService = game:GetService("GuiService")
local TweenService = game:GetService("TweenService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local QuestsData = ReplicatedStorageProject:GetResource("GameData.Quest.Quests")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local Quests = ReplicatedStorageProject:GetResource("State.Quests").GetQuests(Players.LocalPlayer)
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory").GetInventory(Players.LocalPlayer)



--Disable the player list.
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.PlayerList,false)

--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ActiveQuestTopDisplay"
ScreenGui.Parent = script.Parent

--Create the container.
local Background = Instance.new("ImageLabel")
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(1,0,0,-GuiService:GetGuiInset().Y)
Background.AnchorPoint = Vector2.new(0,0)
Background.Image = "rbxassetid://132725463"
Background.Parent = ScreenGui

AspectRatioSwitcher.new(ScreenGui,1,function()
    Background.Size = UDim2.new(0.3,0,0.3,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
end,function()
    Background.Size = UDim2.new(0.3,0,0.3,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
end)

local PumpkinIcon = Instance.new("ImageLabel")
PumpkinIcon.BackgroundTransparency = 1
PumpkinIcon.Position = UDim2.new(40/256,0,18/256,0)
PumpkinIcon.Size = UDim2.new(0.09,0,0.09,0)
PumpkinIcon.Parent = Background

local QuestName = Instance.new("TextLabel")
QuestName.BackgroundTransparency = 1
QuestName.Position = UDim2.new(0.27,0,13/256,0)
QuestName.Size = UDim2.new(0.54,0,30/256,0)
QuestName.Font = Enum.Font.Antique
QuestName.TextScaled = true
QuestName.TextColor3 = Color3.new(254/255,196/255,9/255)
QuestName.Parent = Background

local QuestDescription = Instance.new("TextLabel")
QuestDescription.BackgroundTransparency = 1
QuestDescription.Position = UDim2.new(0.12,0,0.18,0)
QuestDescription.Size = UDim2.new(0.7,0,0.18,0)
QuestDescription.Font = Enum.Font.Antique
QuestDescription.TextScaled = true
QuestDescription.TextColor3 = Color3.new(254/255,255/255,223/255)
QuestDescription.Parent = Background

local QuestStatus = Instance.new("TextLabel")
QuestStatus.BackgroundTransparency = 1
QuestStatus.Position = UDim2.new(0.12,0,0.35,0)
QuestStatus.Size = UDim2.new(0.68,0,0.1,0)
QuestStatus.Font = Enum.Font.Antique
QuestStatus.TextScaled = true
QuestStatus.TextColor3 = Color3.new(255/255,255/255,162/255)
QuestStatus.Parent = Background



--[[
Updates the display depending on
the selected quest.
--]]
local function UpdateDisplay()
    --Hide or show the display depending on if a quest is selected.
    local SelectedQuestName = Quests.QuestData.SelectedQuest
    if SelectedQuestName then
        TweenService:Create(Background,TweenInfo.new(0.5),{
            AnchorPoint = Vector2.new(0.905,0),
        }):Play()
    else
        TweenService:Create(Background,TweenInfo.new(0.5),{
            AnchorPoint = Vector2.new(0,0),
        }):Play()
        return
    end

    --Return if a quest doesn't exist.
    local QuestData = QuestsData[SelectedQuestName]
    if not QuestData then
        return
    end

    --Update the display.
    PumpkinIcon.Image = Quests:GetStatusIcon(SelectedQuestName)
    QuestName.Text = SelectedQuestName
    QuestDescription.Text = QuestData.Description
    QuestStatus.Text = Quests:GetStatusText(SelectedQuestName)
end



--Connect updating the display.
UpdateDisplay()
Quests.QuestsChanged:Connect(UpdateDisplay)
Inventory.InventoryChanged:Connect(UpdateDisplay)