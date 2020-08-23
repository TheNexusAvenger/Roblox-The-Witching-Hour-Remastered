--[[
TheNexusAvenger

Main window for the inventory.
--]]

local Players = game:GetService("Players")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local ItemIcon = require(script.Parent:WaitForChild("ItemIcon"))

local InventoryWindow = NexusObject:Extend()
InventoryWindow:SetClassName("InventoryWindow")



--[[
Creates an inventory window.
--]]
function InventoryWindow:__new()
    self:InitializeSuper()

    --Create the window.
    local InventoryScreenGui = Instance.new("ScreenGui")
    InventoryScreenGui.Name = "Inventory"
    InventoryScreenGui.DisplayOrder = 2
    InventoryScreenGui.Parent = script.Parent.Parent

    local Background = Instance.new("ImageLabel")
    Background.BackgroundTransparency = 1
    Background.Position = UDim2.new(0.5,0,1.5,0)
    Background.AnchorPoint = Vector2.new(0.5,0.5)
    Background.Image = "rbxassetid://131461868"
    Background.Parent = InventoryScreenGui

    local PlayerMenu = Instance.new("Frame")
    PlayerMenu.BackgroundTransparency = 1
    PlayerMenu.Size = UDim2.new(1,0,1,0)
    PlayerMenu.Parent = Background

    local PetMenu = Instance.new("Frame")
    PetMenu.BackgroundTransparency = 1
    PetMenu.Size = UDim2.new(1,0,1,0)
    PetMenu.Visible = false
    PetMenu.Parent = Background
    
    AspectRatioSwitcher.new(InventoryScreenGui,1.4,function()
        Background.Size = UDim2.new(0.9 * 1.4,0,0.9,0)
        Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
    end,function()
        Background.Size = UDim2.new(0.9,0,0.9/1.4,0)
        Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
    end)

    local InventoryCloseImage = Instance.new("ImageLabel")
    InventoryCloseImage.BackgroundTransparency = 1
    InventoryCloseImage.AnchorPoint = Vector2.new(1,0)
    InventoryCloseImage.Size = UDim2.new(0.065,0,0.065,0)
    InventoryCloseImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    InventoryCloseImage.Position = UDim2.new(1,0,0,0)
    InventoryCloseImage.Parent = Background
    local InventoryCloseButton = ImageEventBinder.new(InventoryCloseImage,UDim2.new(1,0,1,0),"rbxassetid://131302488","rbxassetid://131302438","rbxassetid://131302465")

    --Create the level indicator.
    local LevelBackground = Instance.new("ImageLabel")
    LevelBackground.BackgroundTransparency = 1
    LevelBackground.Size = UDim2.new(208/902,0,62/644,0)
    LevelBackground.Position = UDim2.new(45/902,0,30/644,0)
    LevelBackground.Image = "rbxassetid://5558262263"
    LevelBackground.Parent = PlayerMenu

    local LevelText = Instance.new("TextLabel")
    LevelText.BackgroundTransparency = 1
    LevelText.Size = UDim2.new(0.8,0,0.8,0)
    LevelText.Position = UDim2.new(0.1,0,0.025,0)
    LevelText.Font = Enum.Font.Antique
    LevelText.Text = "Level 1"
    LevelText.TextColor3 = Color3.new(40/255,40/255,40/255)
    LevelText.TextScaled = true
    LevelText.Parent = LevelBackground

    --Create the username display.
    local UsernameBackground = Instance.new("ImageLabel")
    UsernameBackground.BackgroundTransparency = 1
    UsernameBackground.Size = UDim2.new(387/902,0,52/644,0)
    UsernameBackground.Position = UDim2.new(44/902,0,536/644,0)
    UsernameBackground.Image = "rbxassetid://131462032"
    UsernameBackground.Parent = Background

    local UsernameText = Instance.new("TextLabel")
    UsernameText.BackgroundTransparency = 1
    UsernameText.Size = UDim2.new(0.8,0,0.8,0)
    UsernameText.Position = UDim2.new(0.1,0,0.025,0)
    UsernameText.Font = Enum.Font.Antique
    UsernameText.Text = Players.LocalPlayer.Name
    UsernameText.TextColor3 = Color3.new(40/255,40/255,40/255)
    UsernameText.TextScaled = true
    UsernameText.Parent = UsernameBackground

    --Create the player inventory slots.
    local PlayerHeadSlot = Instance.new("ImageLabel")
    PlayerHeadSlot.BackgroundTransparency = 1
    PlayerHeadSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerHeadSlot.Position = UDim2.new(44/902,0,164/644,0)
    PlayerHeadSlot.Image = "rbxassetid://131490682"
    PlayerHeadSlot.Parent = Background
    
    local PlayerTorsoSlot = Instance.new("ImageLabel")
    PlayerTorsoSlot.BackgroundTransparency = 1
    PlayerTorsoSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerTorsoSlot.Position = UDim2.new(369/902,0,258/644,0)
    PlayerTorsoSlot.Image = "rbxassetid://131462130"
    PlayerTorsoSlot.Parent = Background
    
    local PlayerRightArmSlot = Instance.new("ImageLabel")
    PlayerRightArmSlot.BackgroundTransparency = 1
    PlayerRightArmSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerRightArmSlot.Position = UDim2.new(44/902,0,358/644,0)
    PlayerRightArmSlot.Image = "rbxassetid://131489625"
    PlayerRightArmSlot.Parent = Background
    
    local PlayerRightLegSlot = Instance.new("ImageLabel")
    PlayerRightLegSlot.BackgroundTransparency = 1
    PlayerRightLegSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerRightLegSlot.Position = UDim2.new(44/902,0,434/644,0)
    PlayerRightLegSlot.Image = "rbxassetid://131490729"
    PlayerRightLegSlot.Parent = Background
    
    local PlayerLeftArmSlot = Instance.new("ImageLabel")
    PlayerLeftArmSlot.BackgroundTransparency = 1
    PlayerLeftArmSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerLeftArmSlot.Position = UDim2.new(369/902,0,358/644,0)
    PlayerLeftArmSlot.Image = "rbxassetid://131490698"
    PlayerLeftArmSlot.Parent = Background
    
    local PlayerLeftLegSlot = Instance.new("ImageLabel")
    PlayerLeftLegSlot.BackgroundTransparency = 1
    PlayerLeftLegSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerLeftLegSlot.Position = UDim2.new(369/902,0,434/644,0)
    PlayerLeftLegSlot.Image = "rbxassetid://131490717"
    PlayerLeftLegSlot.Parent = Background

    --Create the pet inventory slots.
    local PetTypeContainer = Instance.new("ImageLabel")
    PetTypeContainer.BackgroundTransparency = 1
    PetTypeContainer.Size = UDim2.new(387/902,0,72/644,0)
    PetTypeContainer.Position = UDim2.new(40/902,0,28/644,0)
    PetTypeContainer.Image = "rbxassetid://132073816"
    PetTypeContainer.Visible = false
    PetTypeContainer.Parent = Background

    local DogToggleButton = Instance.new("ImageButton")
    DogToggleButton.BackgroundTransparency = 1
    DogToggleButton.AnchorPoint = Vector2.new(0.5,0.5)
    DogToggleButton.Size = UDim2.new(54/387,0,55/72,0)
    DogToggleButton.Position = UDim2.new(54/387,0,36/72,0)
    DogToggleButton.Image = "rbxassetid://132064980"
    DogToggleButton.Parent = PetTypeContainer

    local CatToggleButton = Instance.new("ImageButton")
    CatToggleButton.BackgroundTransparency = 1
    CatToggleButton.AnchorPoint = Vector2.new(0.5,0.5)
    CatToggleButton.Size = UDim2.new(54/387,0,55/72,0)
    CatToggleButton.Position = UDim2.new(111/387,0,36/72,0)
    CatToggleButton.Image = "rbxassetid://132064800"
    CatToggleButton.Parent = PetTypeContainer

    local PandaToggleButton = Instance.new("ImageButton")
    PandaToggleButton.BackgroundTransparency = 1
    PandaToggleButton.AnchorPoint = Vector2.new(0.5,0.5)
    PandaToggleButton.Size = UDim2.new(54/387,0,55/72,0)
    PandaToggleButton.Position = UDim2.new(279/387,0,36/72,0)
    PandaToggleButton.Image = "rbxassetid://132065130"
    PandaToggleButton.Parent = PetTypeContainer

    --TODO: Implement hovering and selecting

    local PetHatSlot = Instance.new("ImageLabel")
    PetHatSlot.BackgroundTransparency = 1
    PetHatSlot.Size = UDim2.new(64/902,0,64/644,0)
    PetHatSlot.Position = UDim2.new(369/902,0,206/644,0)
    PetHatSlot.Image = "rbxassetid://131490682"
    PetHatSlot.Visible = false
    PetHatSlot.Parent = Background

    local PetCollarSlot = Instance.new("ImageLabel")
    PetCollarSlot.BackgroundTransparency = 1
    PetCollarSlot.Size = UDim2.new(64/902,0,64/644,0)
    PetCollarSlot.Position = UDim2.new(369/902,0,282/644,0)
    PetCollarSlot.Image = "rbxassetid://131528533"
    PetCollarSlot.Visible = false
    PetCollarSlot.Parent = Background

    local PetCapeSlot = Instance.new("ImageLabel")
    PetCapeSlot.BackgroundTransparency = 1
    PetCapeSlot.Size = UDim2.new(64/902,0,64/644,0)
    PetCapeSlot.Position = UDim2.new(369/902,0,358/644,0)
    PetCapeSlot.Image = "rbxassetid://131528494"
    PetCapeSlot.Visible = false
    PetCapeSlot.Parent = Background
    
    local PetAnkleSlot = Instance.new("ImageLabel")
    PetAnkleSlot.BackgroundTransparency = 1
    PetAnkleSlot.Size = UDim2.new(64/902,0,64/644,0)
    PetAnkleSlot.Position = UDim2.new(369/902,0,434/644,0)
    PetAnkleSlot.Image = "rbxassetid://131528543"
    PetAnkleSlot.Visible = false
    PetAnkleSlot.Parent = Background

    --Create the toggle buttons.
    local PetModeToggleImage = Instance.new("ImageLabel")
    PetModeToggleImage.BackgroundTransparency = 1
    PetModeToggleImage.Size = UDim2.new(108/902,0,111/644,0)
    PetModeToggleImage.Position = UDim2.new(342/902,0,104/644,0)
    PetModeToggleImage.Parent = Background
    local PetModeToggleButton = ImageEventBinder.new(PetModeToggleImage,UDim2.new(1,0,1,0),"rbxassetid://132064980","rbxassetid://132064940","rbxassetid://132064966")

    local CharacterModeToggleImage = Instance.new("ImageLabel")
    CharacterModeToggleImage.BackgroundTransparency = 1
    CharacterModeToggleImage.Size = UDim2.new(240/902,0,60/644,0)
    CharacterModeToggleImage.Position = UDim2.new(230/902,0,102/644,0)
    CharacterModeToggleImage.Visible = false
    CharacterModeToggleImage.Parent = Background
    local CharacterModeToggleButton = ImageEventBinder.new(CharacterModeToggleImage,UDim2.new(0.8,0,0.8,0),"rbxassetid://131528431","rbxassetid://131528431","rbxassetid://131528420")

    local DB = true
    PetModeToggleButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            PetModeToggleImage.Visible = false
            LevelBackground.Visible = false
            PlayerHeadSlot.Visible = false
            PlayerTorsoSlot.Visible = false
            PlayerRightArmSlot.Visible = false
            PlayerRightLegSlot.Visible = false
            PlayerLeftArmSlot.Visible = false
            PlayerLeftLegSlot.Visible = false

            CharacterModeToggleImage.Visible = true
            PetTypeContainer.Visible = true
            PetHatSlot.Visible = true
            PetCollarSlot.Visible = true
            PetCapeSlot.Visible = true
            PetAnkleSlot.Visible = true
            wait()
            DB = true
        end
    end)
    CharacterModeToggleButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            PetModeToggleImage.Visible = true
            LevelBackground.Visible = true
            PlayerHeadSlot.Visible = true
            PlayerTorsoSlot.Visible = true
            PlayerRightArmSlot.Visible = true
            PlayerRightLegSlot.Visible = true
            PlayerLeftArmSlot.Visible = true
            PlayerLeftLegSlot.Visible = true

            CharacterModeToggleImage.Visible = false
            PetTypeContainer.Visible = false
            PetHatSlot.Visible = false
            PetCollarSlot.Visible = false
            PetCapeSlot.Visible = false
            PetAnkleSlot.Visible = false
            wait()
            DB = true
        end
    end)

    --Create the inventory display.
    local InventoryBack = Instance.new("ImageLabel")
    InventoryBack.BackgroundTransparency = 1
    InventoryBack.Size = UDim2.new(329/902,0,558/644,0)
    InventoryBack.Position = UDim2.new(495/902,0,30/644,0)
    InventoryBack.Image = "rbxassetid://131503240"
    InventoryBack.Parent = Background

    local InventoryBorder = Instance.new("ImageLabel")
    InventoryBorder.BackgroundTransparency = 1
    InventoryBorder.AnchorPoint = Vector2.new(0.5,0)
    InventoryBorder.Size = UDim2.new(343/329,0,471/558,0)
    InventoryBorder.Position = UDim2.new(163/329,0,35/558,0)
    InventoryBorder.Image = "rbxassetid://131502836"
    InventoryBorder.ZIndex = 5
    InventoryBorder.Parent = InventoryBack

    local InventoryLeftImage = Instance.new("ImageLabel")
    InventoryLeftImage.BackgroundTransparency = 1
    InventoryLeftImage.AnchorPoint = Vector2.new(0.5,0.5)
    InventoryLeftImage.Size = UDim2.new(39/329,0,28/558,0)
    InventoryLeftImage.Position = UDim2.new(63/329,0,1 + (-31/558),0)
    InventoryLeftImage.Parent = InventoryBack
    local InventoryLeftButton = ImageEventBinder.new(InventoryLeftImage,UDim2.new(1,0,1,0),"rbxassetid://131462464","rbxassetid://131462433","rbxassetid://131462447")

    local InventoryRightImage = Instance.new("ImageButton")
    InventoryRightImage.BackgroundTransparency = 1
    InventoryRightImage.AnchorPoint = Vector2.new(0.5,0.5)
    InventoryRightImage.Size = UDim2.new(39/329,0,28/558,0)
    InventoryRightImage.Position = UDim2.new(263/329,0,1 + (-31/558),0)
    InventoryRightImage.Parent = InventoryBack
    local InventoryRightButton = ImageEventBinder.new(InventoryRightImage,UDim2.new(1,0,1,0),"rbxassetid://131462518","rbxassetid://131462503","rbxassetid://131462515")

    local PageText = Instance.new("TextLabel")
    PageText.BackgroundTransparency = 1
    PageText.Size = UDim2.new(33/329,0,50/558,0)
    PageText.Position = UDim2.new(186/329,0,1 + (-64/558),0)
    PageText.Font = Enum.Font.Antique
    PageText.Text = "1"
    PageText.TextColor3 = Color3.new(238/255,205/255,255/255)
    PageText.TextScaled = true
    PageText.Parent = InventoryBack

    --Connect opening and closing.
    local OpenValue = script.Parent.Parent:WaitForChild("GuiOpenStates"):WaitForChild("Inventory")
    OpenValue.Changed:Connect(function()
        Background:TweenPosition(UDim2.new(0.5,0,OpenValue.Value and 0.5 or 1.5,0),"Out","Quad",0.5,true)
    end)
    InventoryCloseButton.Button.MouseButton1Down:Connect(function()
        Background:TweenPosition(UDim2.new(0.5,0,1.5,0),"Out","Quad",0.5,true)
        OpenValue.Value = false
    end)
end



return InventoryWindow