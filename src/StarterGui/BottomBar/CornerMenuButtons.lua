--[[
TheNexusAvenger

Menu buttons for the bottom bar.
--]]

local Players = game:GetService("Players")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local WideTextButtonDecorator = ReplicatedStorageProject:GetResource("UI.Button.WideTextButtonDecorator")
local PlayerData = ReplicatedStorageProject:GetResource("UI.PlayerData")

local CornerMenuButtons = NexusObject:Extend()
CornerMenuButtons:SetClassName("CornerMenuButtons")



--[[
Creates corner menu buttons.
--]]
function CornerMenuButtons:__new(BottomFrame)
    self:InitializeSuper()

    --Create the bottom bar container.
    local MenuBottomBarBackground = Instance.new("ImageLabel")
    MenuBottomBarBackground.Size = UDim2.new(1.8,0,1.8,0)
    MenuBottomBarBackground.SizeConstraint = "RelativeYY"
    MenuBottomBarBackground.AnchorPoint = Vector2.new(0.025,0.325)
    MenuBottomBarBackground.BackgroundTransparency = 1
    MenuBottomBarBackground.Image = "rbxassetid://132724720"
    MenuBottomBarBackground.Parent = BottomFrame

    --Create the currency display.
    local StatsPlayerData = PlayerData.GetPlayerData(Players.LocalPlayer)
    local CandyIcon = Instance.new("ImageLabel")
    CandyIcon.BackgroundTransparency = 1
    CandyIcon.Size = UDim2.new(0.14,0,0.14,0)
    CandyIcon.Position = UDim2.new(0.22,0,0.13,0)
    CandyIcon.Image = "rbxassetid://133023249"
    CandyIcon.Parent = MenuBottomBarBackground

    local CandyText = Instance.new("TextLabel")
    CandyText.BackgroundTransparency = 1
    CandyText.Size = UDim2.new(3,0,0.85,0)
    CandyText.Position = UDim2.new(1.05,0,-0.25,0)
    CandyText.Font = Enum.Font.Antique
    CandyText.TextScaled = true
    CandyText.Text = tostring(StatsPlayerData:GetValue("Currency"))
    CandyText.TextColor3 = Color3.new(238/255,205/255,255/255)
    CandyText.TextStrokeColor3 = Color3.new(0,0,0)
    CandyText.TextStrokeTransparency = 0
    CandyText.TextXAlignment = Enum.TextXAlignment.Left
    CandyText.Parent = CandyIcon

    StatsPlayerData:GetValueChangedSignal("Currency"):Connect(function()
        CandyText.Text = tostring(StatsPlayerData:GetValue("Currency"))
    end)
    
    --Create the buttons.
    local InventoryImage = Instance.new("ImageLabel")
    InventoryImage.BackgroundTransparency = 1
    InventoryImage.Size = UDim2.new(128/256,0,64/256,0)
    InventoryImage.Position = UDim2.new(38/256,0,60/256,0)
    InventoryImage.Parent = MenuBottomBarBackground
    local InventoryButton = ImageEventBinder.new(InventoryImage,UDim2.new(62/128,0,45/64,0),"rbxassetid://132718207","rbxassetid://132717837","rbxassetid://132717848")

    local StoreImage = Instance.new("ImageLabel")
    StoreImage.BackgroundTransparency = 1
    StoreImage.Size = UDim2.new(128/256,0,64/256,0)
    StoreImage.Position = UDim2.new(118/256,0,60/256,0)
    StoreImage.Parent = MenuBottomBarBackground
    local StoreButton = ImageEventBinder.new(StoreImage,UDim2.new(62/128,0,45/64,0),"rbxassetid://132718288","rbxassetid://132717962","rbxassetid://132717976")

    local CollectablesImage = Instance.new("ImageLabel")
    CollectablesImage.BackgroundTransparency = 1
    CollectablesImage.Size = UDim2.new(128/256,0,64/256,0)
    CollectablesImage.Position = UDim2.new(38/256,0,112/256,0)
    CollectablesImage.Parent = MenuBottomBarBackground
    local CollectablesButton = ImageEventBinder.new(CollectablesImage,UDim2.new(62/128,0,45/64,0),"rbxassetid://132718167","rbxassetid://132717791","rbxassetid://132717809")

    local QuestsImage = Instance.new("ImageLabel")
    QuestsImage.BackgroundTransparency = 1
    QuestsImage.Size = UDim2.new(128/256,0,64/256,0)
    QuestsImage.Position = UDim2.new(118/256,0,112/256,0)
    QuestsImage.Parent = MenuBottomBarBackground
    local QuestsButton = ImageEventBinder.new(QuestsImage,UDim2.new(62/128,0,45/64,0),"rbxassetid://132718256","rbxassetid://132717904","rbxassetid://132717928")

    local CreditsImage = Instance.new("ImageLabel")
    CreditsImage.BackgroundTransparency = 1
    CreditsImage.Size = UDim2.new(0.15 * (188/52),0,0.15,0)
    CreditsImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    CreditsImage.Position = UDim2.new(0.16,0,0.65,0)
    CreditsImage.Parent = MenuBottomBarBackground
    local CreditsButton = WideTextButtonDecorator.new(CreditsImage,"CREDITS")

    --Set up the buttons.
    local GuiOpenStatesFolder = Instance.new("Folder")
    GuiOpenStatesFolder.Name = "GuiOpenStates"
    GuiOpenStatesFolder.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    self.GuiOpenStatesFolder = GuiOpenStatesFolder

    self:ConnectButton(InventoryButton.Button,"Inventory")
    self:ConnectButton(StoreButton.Button,"Store")
    self:ConnectButton(CollectablesButton.Button,"Collectables")
    self:ConnectButton(QuestsButton.Button,"Quests")
    self:ConnectButton(CreditsButton.Button,"Credits")
end

--[[
Connects a button for a given open state.
--]]
function CornerMenuButtons:ConnectButton(Button,OpenStateName)
    --Set up the open state value.
    local ValueObject = Instance.new("BoolValue")
    ValueObject.Name = OpenStateName
    ValueObject.Value = false
    ValueObject.Parent = self.GuiOpenStatesFolder
    
    --Connect the button.
    local DB = true
    Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            ValueObject.Value = not ValueObject.Value
            wait()
            DB = true
        end
    end)
end



return CornerMenuButtons