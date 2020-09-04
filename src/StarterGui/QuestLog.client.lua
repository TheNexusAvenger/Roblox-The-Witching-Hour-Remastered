--[[
TheNexusAvenger

Displays the active and completed quests.
--]]

local BADGE_NAMES = {
	["Builderman"]           = "BLOXikin #01 Skeleton Builderman",
	["Shedletsky"]           = "BLOXikin #02 Vampire Shedletsky",
	["BrightEyes"]           = "BLOXikin #03 Bella Vampire BrightEyes",
	["ReeseMcBlox"]          = "BLOXikin #04 Witch ReeseMcBlox",
	["OstrichSized"]         = "BLOXikin #05 Mummy OstrichSized",
	["JediTkacheff"]         = "BLOXikin #06 Swamp Monster Jeditkacheff",
	["Sorcus"]               = "BLOXikin #07 Grim Reaper Sorcus",
	["Tarabyte"]             = "BLOXikin #08 Black Cat Tarabyte",
	["StickMasterLuke"]      = "BLOXikin #09 Zombie StickmasterLuke",
	["fusroblox"]            = "BLOXikin #10 Frankenstein Fusroblox",
	["OnlyTwentyCharacters"] = "BLOXikin #11 Werewolf OnlyTwentyCharacters",
	["SolarCrane"]           = "BLOXikin #12 Ghost SolarCrane",
	["ChiefJustus"]          = "BLOXikin #13 Devil ChiefJustus",
	["Jack-o-lantern"]       = "BLOXikin #14 Jack-o-Lantern ROBLOXian",
	["Miss Pumpkin"]         = "BLOXikin #15 Pumpkin Girl ROBLOXian",
	["Batboy"]               = "BLOXikin #16 Bat ROBLOXian",
	["Batgirl"]              = "BLOXikin #17 Bat Girl ROBLOXian",
	["Spiderboy"]            = "BLOXikin #18 Spider ROBLOXian",
	["Spidergirl"]           = "BLOXikin #19 Spider Girl ROBLOXian",
	["Raven"]                = "BLOXikin #20 Raven ROBLOXian",
	["Spooky Owl"]           = "BLOXikin #21 Owl Girl ROBLOXian",
	["Cthulhu"]              = "BLOXikin #22 Cthulhu",
	["Kaiju"]                = "BLOXikin #23 Kaiju",
	["Ooze Monster"]         = "BLOXikin #24 Ooze Monster",
	["Scarecrow"]            = "BLOXikin #25 Scarecrow",
	["Frankenstein's Bride"] = "BLOXikin #26 Bride of Frankenstein",
	["Gargoyle"]             = "BLOXikin #27 Gargoyle",
	["Yodalien"]             = "BLOXikin #28 Yodalien",
	["Hallo-bot"]            = "BLOXikin #29 Hallo-bot",
	["Invisible Man"]        = "BLOXikin #30 InvisibleMan",
	["Headless Horseman"]    = "BLOXikin #31 Headless Horseman"
}



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local QuestsData = ReplicatedStorageProject:GetResource("GameData.Quest.Quests")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local Quests = ReplicatedStorageProject:GetResource("State.Quests").GetQuests(Players.LocalPlayer)
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory").GetInventory(Players.LocalPlayer)
local SelectQuestEvent = ReplicatedStorageProject:GetResource("GameReplication.QuestReplication.SelectQuest")

local DB = true
local CurrentQuestNames = {}
local SelectedQuest
local ListButtons = {}



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QuestLogView"
ScreenGui.Parent = script.Parent

--Create the container.
local Background = Instance.new("ImageLabel")
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0.5,0,1.5,0)
Background.AnchorPoint = Vector2.new(0.5,0.5)
Background.Image = "rbxassetid://132880888"
Background.Parent = ScreenGui

AspectRatioSwitcher.new(ScreenGui,787/634,function()
    Background.Size = UDim2.new(0.9 * (787/634),0,0.9,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
end,function()
    Background.Size = UDim2.new(0.9,0,0.9/(787/634),0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
end)

local QuestsScroll = Instance.new("ScrollingFrame")
QuestsScroll.BackgroundTransparency = 1
QuestsScroll.BorderSizePixel = 0
QuestsScroll.Size = UDim2.new(0.33,0,0.72,0)
QuestsScroll.Position = UDim2.new(0.0325,0,0.25,0)
QuestsScroll.Parent = Background

local MakeActiveImage = Instance.new("ImageLabel")
MakeActiveImage.BackgroundTransparency = 1
MakeActiveImage.AnchorPoint = Vector2.new(0.5,0.5)
MakeActiveImage.Size = UDim2.new(150/787,0,47/634)
MakeActiveImage.Position = UDim2.new(0.688,0,0.9,0)
MakeActiveImage.Parent = Background
local MakeActiveButton = ImageEventBinder.new(MakeActiveImage,UDim2.new(1,0,1,0),"rbxassetid://132882115","rbxassetid://132882144","rbxassetid://132882131")

local SelectedQuestNameText = Instance.new("TextLabel")
SelectedQuestNameText.BackgroundTransparency = 1
SelectedQuestNameText.AnchorPoint = Vector2.new(0.5,0.5)
SelectedQuestNameText.Size = UDim2.new(0.45,0,0.051,0)
SelectedQuestNameText.Position = UDim2.new(0.688,0,0.334,0)
SelectedQuestNameText.Text = ""
SelectedQuestNameText.Font = Enum.Font.Antique
SelectedQuestNameText.TextColor3 = Color3.new(254/255,196/255,9/255)
SelectedQuestNameText.TextScaled = true
SelectedQuestNameText.Parent = Background

local SelectedQuestDescriptionText = Instance.new("TextLabel")
SelectedQuestDescriptionText.BackgroundTransparency = 1
SelectedQuestDescriptionText.AnchorPoint = Vector2.new(0.5,0)
SelectedQuestDescriptionText.Size = UDim2.new(0.45,0,0.06,0)
SelectedQuestDescriptionText.Position = UDim2.new(0.688,0,0.375,0)
SelectedQuestDescriptionText.Text = ""
SelectedQuestDescriptionText.Font = Enum.Font.Antique
SelectedQuestDescriptionText.TextColor3 = Color3.new(255/255,255/255,255/255)
SelectedQuestDescriptionText.TextScaled = true
SelectedQuestDescriptionText.Parent = Background

local SelectedQuestStatusText = Instance.new("TextLabel")
SelectedQuestStatusText.BackgroundTransparency = 1
SelectedQuestStatusText.AnchorPoint = Vector2.new(0.5,0.5)
SelectedQuestStatusText.Size = UDim2.new(0.45,0,0.044,0)
SelectedQuestStatusText.Position = UDim2.new(0.688,0,0.45,0)
SelectedQuestStatusText.Text = ""
SelectedQuestStatusText.Font = Enum.Font.Antique
SelectedQuestStatusText.TextColor3 = Color3.new(254/255,196/255,9/255)
SelectedQuestStatusText.TextScaled = true
SelectedQuestStatusText.Parent = Background

local SelectedQuestRewardsHeaderText = Instance.new("TextLabel")
SelectedQuestRewardsHeaderText.BackgroundTransparency = 1
SelectedQuestRewardsHeaderText.AnchorPoint = Vector2.new(0.5,0.5)
SelectedQuestRewardsHeaderText.Size = UDim2.new(0.45,0,0.04,0)
SelectedQuestRewardsHeaderText.Position = UDim2.new(0.678,0,0.585,0)
SelectedQuestRewardsHeaderText.Text = "Quest Rewards"
SelectedQuestRewardsHeaderText.Font = Enum.Font.Antique
SelectedQuestRewardsHeaderText.TextColor3 = Color3.new(254/255,196/255,9/255)
SelectedQuestRewardsHeaderText.TextScaled = true
SelectedQuestRewardsHeaderText.Parent = Background

local SelectedQuestRewards1Text = Instance.new("TextLabel")
SelectedQuestRewards1Text.BackgroundTransparency = 1
SelectedQuestRewards1Text.AnchorPoint = Vector2.new(0.5,0.5)
SelectedQuestRewards1Text.Size = UDim2.new(0.45,0,0.06,0)
SelectedQuestRewards1Text.Position = UDim2.new(0.678,0,0.66,0)
SelectedQuestRewards1Text.Text = ""
SelectedQuestRewards1Text.Font = Enum.Font.Antique
SelectedQuestRewards1Text.TextColor3 = Color3.new(255/255,255/255,255/255)
SelectedQuestRewards1Text.TextScaled = true
SelectedQuestRewards1Text.Parent = Background

local SelectedQuestRewards2Text = Instance.new("TextLabel")
SelectedQuestRewards2Text.BackgroundTransparency = 1
SelectedQuestRewards2Text.AnchorPoint = Vector2.new(0.5,0.5)
SelectedQuestRewards2Text.Size = UDim2.new(0.45,0,0.06,0)
SelectedQuestRewards2Text.Position = UDim2.new(0.678,0,0.735,0)
SelectedQuestRewards2Text.Text = ""
SelectedQuestRewards2Text.Font = Enum.Font.Antique
SelectedQuestRewards2Text.TextColor3 = Color3.new(255/255,255/255,255/255)
SelectedQuestRewards2Text.TextScaled = true
SelectedQuestRewards2Text.Parent = Background



--[[
Updates the quests display.
--]]
local function UpdateDisplay()
    --Get the quests to display.
    CurrentQuestNames = {}
    for QuestName,_ in pairs(Quests.QuestData.ActiveQuests) do
        table.insert(CurrentQuestNames,QuestName)
    end
    for QuestName,_ in pairs(Quests.QuestData.CompletedQuests) do
        table.insert(CurrentQuestNames,QuestName)
    end

    --Select a quest if none is selected.
    if SelectedQuest == nil then
        SelectedQuest = CurrentQuestNames[1]
    end

    --Create list buttons if needed.
    --Buttons aren't removed since completed quests are not removed.
    for i = 1,#CurrentQuestNames do
       if not ListButtons[i] then
           local ListButton = Instance.new("ImageButton")
           ListButton.BackgroundTransparency = 1
           ListButton.Parent = QuestsScroll
           ListButton.MouseButton1Down:Connect(function()
               if DB then
                   DB = false
                   SelectedQuest = CurrentQuestNames[i]
                   UpdateDisplay()
                   wait()
                   DB = true
               end
           end)

           local PumpkinIcon = Instance.new("ImageLabel")
           PumpkinIcon.BackgroundTransparency = 1
           PumpkinIcon.Size = UDim2.new(27/31,0,27/31,0)
           PumpkinIcon.SizeConstraint = Enum.SizeConstraint.RelativeYY
           PumpkinIcon.Position = UDim2.new(2/268,0,2/31,0)
           PumpkinIcon.Parent = ListButton

           local QuestName = Instance.new("TextLabel")
           QuestName.BackgroundTransparency = 1
           QuestName.AnchorPoint = Vector2.new(1,0)
           QuestName.Size = UDim2.new(1 - (42/268),0,0.9,0)
           QuestName.Position = UDim2.new(1,0,0.05,0)
           QuestName.Font = Enum.Font.Antique
           QuestName.TextColor3 = Color3.new(1,1,1)
           QuestName.TextScaled = true
           QuestName.TextXAlignment = Enum.TextXAlignment.Left
           QuestName.Parent = ListButton

           ListButtons[i] = {ListButton,PumpkinIcon,QuestName}           
       end 
    end

    --Update the list.
    local ListLength = math.max(#CurrentQuestNames,456/31)
    for i,QuestName in pairs(CurrentQuestNames) do
        local ButtonData = ListButtons[i]
        ButtonData[1].Size = UDim2.new(1,0,1/ListLength,0)
        ButtonData[1].Position = UDim2.new(0,0,(i - 1)/ListLength,0)
        ButtonData[2].Image = Quests:GetStatusIcon(QuestName)
        ButtonData[3].Text = QuestName

        if SelectedQuest == QuestName then
            ButtonData[1].Image = "rbxassetid://133086498"
        elseif Quests:QuestConditonValid(QuestName,"TurnedIn") then
            ButtonData[1].Image = "rbxassetid://132881695"
        else
            ButtonData[1].Image = "rbxassetid://132881723"
        end
    end
    QuestsScroll.CanvasSize = UDim2.new(0,0,ListLength * (31/456) * 0.72,0)

    --Update the selected quest display.
    if SelectedQuest then
        --Set the base text.
        local QuestData = QuestsData[SelectedQuest]
        MakeActiveImage.Visible = (not Quests:QuestConditonValid(SelectedQuest,"TurnedIn")) and (Quests.QuestData.SelectedQuest ~= SelectedQuest)
        SelectedQuestNameText.Text = SelectedQuest
        SelectedQuestDescriptionText.Text = QuestData.Description
        SelectedQuestStatusText.Text = Quests:GetStatusText(SelectedQuest)

        --Set the rewards.
        local Rewards = {}
        for RewardType,Reward in pairs(QuestData.Rewards or {}) do
            if RewardType == "Badge" then
                table.insert(Rewards,BADGE_NAMES[Reward])
            elseif RewardType == "XP" then
                table.insert(Rewards,tostring(Reward).." XP")
            elseif RewardType == "Items" then
                for _,Item in pairs(Reward) do
                    table.insert(Rewards,tostring(Item.Amount).." "..tostring(Item.Name))
                end
            end
        end
        SelectedQuestRewards1Text.Text = Rewards[1] or ""
        SelectedQuestRewards2Text.Text = Rewards[2] or ""
    end
end



--Connect setting the active quest.
MakeActiveButton.Button.MouseButton1Down:Connect(function()
    if DB then
        DB = false
        Quests:SelectQuest(SelectedQuest)
        SelectQuestEvent:FireServer(SelectedQuest)
        wait()
        DB = true
    end
end)

--Connect updating the display.
UpdateDisplay()
Quests.QuestsChanged:Connect(UpdateDisplay)
Inventory.InventoryChanged:Connect(UpdateDisplay)

--Connect opening and closing the window.
local OpenValue = script.Parent:WaitForChild("GuiOpenStates"):WaitForChild("Quests")
OpenValue.Changed:Connect(function()
    Background:TweenPosition(UDim2.new(0.5,0,OpenValue.Value and 0.5 or 1.5,0),"Out","Quad",0.5,true)
end)