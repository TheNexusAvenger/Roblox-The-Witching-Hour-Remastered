--[[
TheNexusAvenger

Main window for the inventory.
--]]

local SLOTS_PER_PAGE = 35



local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local Inventory = ReplicatedStorageProject:GetResource("UI.Inventory")
local ItemIcon = require(script.Parent:WaitForChild("ItemIcon"))
local PlayerDisplay = require(script.Parent:WaitForChild("PlayerDisplay"))
local SwapSlots = ReplicatedStorageProject:GetResource("GameReplication.InventoryReplication.SwapSlots")

local InventoryWindow = NexusObject:Extend()
InventoryWindow:SetClassName("InventoryWindow")



--[[
Creates an inventory window.
--]]
function InventoryWindow:__new()
    self:InitializeSuper()

    --Create the window.
    self.Inventory = Inventory.new(Players.LocalPlayer)
    local InventoryScreenGui = Instance.new("ScreenGui")
    InventoryScreenGui.Name = "Inventory"
    InventoryScreenGui.DisplayOrder = 2
    InventoryScreenGui.Parent = script.Parent.Parent
    self.InventoryScreenGui = InventoryScreenGui

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
    PlayerHeadSlot.ZIndex = 4
    PlayerHeadSlot.Parent = Background
    
    local PlayerTorsoSlot = Instance.new("ImageLabel")
    PlayerTorsoSlot.BackgroundTransparency = 1
    PlayerTorsoSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerTorsoSlot.Position = UDim2.new(369/902,0,258/644,0)
    PlayerTorsoSlot.Image = "rbxassetid://131462130"
    PlayerTorsoSlot.ZIndex = 4
    PlayerTorsoSlot.Parent = Background
    
    local PlayerRightArmSlot = Instance.new("ImageLabel")
    PlayerRightArmSlot.BackgroundTransparency = 1
    PlayerRightArmSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerRightArmSlot.Position = UDim2.new(44/902,0,358/644,0)
    PlayerRightArmSlot.Image = "rbxassetid://131489625"
    PlayerRightArmSlot.ZIndex = 4
    PlayerRightArmSlot.Parent = Background
    
    local PlayerRightLegSlot = Instance.new("ImageLabel")
    PlayerRightLegSlot.BackgroundTransparency = 1
    PlayerRightLegSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerRightLegSlot.Position = UDim2.new(44/902,0,434/644,0)
    PlayerRightLegSlot.Image = "rbxassetid://131490729"
    PlayerRightLegSlot.ZIndex = 4
    PlayerRightLegSlot.Parent = Background
    
    local PlayerLeftArmSlot = Instance.new("ImageLabel")
    PlayerLeftArmSlot.BackgroundTransparency = 1
    PlayerLeftArmSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerLeftArmSlot.Position = UDim2.new(369/902,0,358/644,0)
    PlayerLeftArmSlot.Image = "rbxassetid://131490698"
    PlayerLeftArmSlot.ZIndex = 4
    PlayerLeftArmSlot.Parent = Background
    
    local PlayerLeftLegSlot = Instance.new("ImageLabel")
    PlayerLeftLegSlot.BackgroundTransparency = 1
    PlayerLeftLegSlot.Size = UDim2.new(64/902,0,64/644,0)
    PlayerLeftLegSlot.Position = UDim2.new(369/902,0,434/644,0)
    PlayerLeftLegSlot.Image = "rbxassetid://131490717"
    PlayerLeftLegSlot.ZIndex = 4
    PlayerLeftLegSlot.Parent = Background

    local PlayerDisplayFrame = Instance.new("Frame")
    PlayerDisplayFrame.BackgroundTransparency = 1
    PlayerDisplayFrame.Size = UDim2.new(0.6,0,0.6,0)
    PlayerDisplayFrame.Position = UDim2.new(0.05,0,0.2,0)
    PlayerDisplayFrame.SizeConstraint = "RelativeYY"
    PlayerDisplayFrame.Parent = Background
    self.PlayerDisplay = PlayerDisplay.new(PlayerDisplayFrame)

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

    local PetBackSlot = Instance.new("ImageLabel")
    PetBackSlot.BackgroundTransparency = 1
    PetBackSlot.Size = UDim2.new(64/902,0,64/644,0)
    PetBackSlot.Position = UDim2.new(369/902,0,358/644,0)
    PetBackSlot.Image = "rbxassetid://131528494"
    PetBackSlot.Visible = false
    PetBackSlot.Parent = Background
    
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
    PetModeToggleImage.ZIndex = 4
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
            PlayerDisplayFrame.Visible = false

            CharacterModeToggleImage.Visible = true
            PetTypeContainer.Visible = true
            PetHatSlot.Visible = true
            PetCollarSlot.Visible = true
            PetBackSlot.Visible = true
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
            PlayerDisplayFrame.Visible = true

            CharacterModeToggleImage.Visible = false
            PetTypeContainer.Visible = false
            PetHatSlot.Visible = false
            PetCollarSlot.Visible = false
            PetBackSlot.Visible = false
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
    self.InventoryLeftImage = InventoryLeftImage
    local InventoryLeftButton = ImageEventBinder.new(InventoryLeftImage,UDim2.new(1,0,1,0),"rbxassetid://131462464","rbxassetid://131462433","rbxassetid://131462447")

    local InventoryRightImage = Instance.new("ImageButton")
    InventoryRightImage.BackgroundTransparency = 1
    InventoryRightImage.AnchorPoint = Vector2.new(0.5,0.5)
    InventoryRightImage.Size = UDim2.new(39/329,0,28/558,0)
    InventoryRightImage.Position = UDim2.new(263/329,0,1 + (-31/558),0)
    InventoryRightImage.Parent = InventoryBack
    self.InventoryRightImage = InventoryRightImage
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
    self.PageText = PageText

    self.InventorySlotFrames = {}
    self.InventorySlotIcons = {}
    for i = 1,SLOTS_PER_PAGE do
        local SlotFrame = Instance.new("Frame")
        SlotFrame.BackgroundTransparency = 1
        SlotFrame.Size = UDim2.new(64/329,0,64/558,0)
        SlotFrame.Position = UDim2.new((2 + (65 * ((i - 1) % 5)))/329,0,(43 + (65 * math.floor((i - 1)/5)))/558,0)
        SlotFrame.Parent = InventoryBack
        table.insert(self.InventorySlotFrames,SlotFrame)

        local ItemFrame = ItemIcon.new()
        ItemFrame:SetParent(SlotFrame)
        table.insert(self.InventorySlotIcons,ItemFrame)
    end
    self.SpecialInventorySlots = {
        PlayerHat = PlayerHeadSlot,
        PlayerTorso = PlayerTorsoSlot,
        PlayerLeftArm = PlayerLeftArmSlot,
        PlayerRightArm = PlayerRightArmSlot,
        PlayerLeftLeg = PlayerLeftLegSlot,
        PlayerRightLeg = PlayerRightLegSlot,
        PetHat = PetHatSlot,
        PetCollar = PetCollarSlot,
        PetBack = PetBackSlot,
        PetAnkle = PetAnkleSlot,
    }
    self.SpecialInventoryIcons = {}
    for SlotName,SlotFrame in pairs(self.SpecialInventorySlots) do
        local ItemFrame = ItemIcon.new()
        ItemFrame:SetParent(SlotFrame)
        self.SpecialInventoryIcons[SlotName] = ItemFrame
    end

    --Connect updating the inventory.
    self.CurrentPage = 1
    self.MaxPages = 3
    InventoryLeftButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            self.CurrentPage = math.max(1,self.CurrentPage - 1)
            self:UpdateInventory()
            wait()
            DB = true
        end
    end)
    InventoryRightButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            self.CurrentPage = math.min(self.MaxPages,self.CurrentPage + 1)
            self:UpdateInventory()
            wait()
            DB = true
        end
    end)
    self.Inventory.InventoryChanged:Connect(function()
        self:UpdateInventory()
    end)
    self:UpdateInventory()

    --Connect opening and closing.
    local OpenValue = script.Parent.Parent:WaitForChild("GuiOpenStates"):WaitForChild("Inventory")
    self.OpenValue = OpenValue
    OpenValue.Changed:Connect(function()
        Background:TweenPosition(UDim2.new(0.5,0,OpenValue.Value and 0.5 or 1.5,0),"Out","Quad",0.5,true)
    end)
    InventoryCloseButton.Button.MouseButton1Down:Connect(function()
        Background:TweenPosition(UDim2.new(0.5,0,1.5,0),"Out","Quad",0.5,true)
        OpenValue.Value = false
    end)

    --Set up dragging.
    self:SetUpDraggning()
end

--[[
Returns if a point is in a frame.
--]]
function InventoryWindow:PointInFrame(X,Y,Frame)
    local Size,Position = Frame.AbsoluteSize,Frame.AbsolutePosition
    return Frame.Visible and X >= Position.X and X <= Position.X + Size.X and Y >= Position.Y and Y <= Position.Y + Size.Y
end

--[[
Sets up dragging of items.
--]]
function InventoryWindow:SetUpDraggning()
    local CurrentSlot,CurrentDraggingFrame,CurrentIcon
    local DraggingOffsetX,DraggingOffsetY

    --Connect items being pressed.
    UserInputService.InputBegan:Connect(function(Input,Processed)
        --Return if the input was already processed or it wasn't a click.
        if Processed or (Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch) then
            return
        end

        --Return if the inventory isn't open.
        if not self.OpenValue.Value then
            return
        end

        --Determine the slot to start from.
        local Slot,StartSlotFrame
        for SlotName,SlotFrame in pairs(self.SpecialInventorySlots) do
            if self:PointInFrame(Input.Position.X,Input.Position.Y,SlotFrame) then
                Slot = SlotName
                StartSlotFrame = SlotFrame
                break
            end
        end
        if not Slot then
            for i,SlotFrame in pairs(self.InventorySlotFrames) do
                if self:PointInFrame(Input.Position.X,Input.Position.Y,SlotFrame) then
                    Slot = i + ((self.CurrentPage - 1)* SLOTS_PER_PAGE)
                    StartSlotFrame = SlotFrame
                    break
                end
            end
        end
        
        --Return if the slot or item doesn't exist.
        if not Slot then return end
        local Item = self.Inventory:GetItem(Slot)
        if not Item then return end

        --Create the dragging frame.
        CurrentSlot = Slot
        DraggingOffsetX = StartSlotFrame.AbsolutePosition.X - Input.Position.X
        DraggingOffsetY = StartSlotFrame.AbsolutePosition.Y - Input.Position.Y

        CurrentDraggingFrame = Instance.new("Frame")
        CurrentDraggingFrame.BackgroundTransparency = 1
        CurrentDraggingFrame.Size = UDim2.new(0,StartSlotFrame.AbsoluteSize.X,0,StartSlotFrame.AbsoluteSize.Y)
        CurrentDraggingFrame.Position = UDim2.new(0,StartSlotFrame.AbsolutePosition.X,0,StartSlotFrame.AbsolutePosition.Y)
        CurrentDraggingFrame.ZIndex = 20
        CurrentDraggingFrame.Parent = self.InventoryScreenGui

        CurrentIcon = ItemIcon.new()
        CurrentIcon:SetParent(CurrentDraggingFrame)
        CurrentIcon:SetItem(Item.Name)
        
        --Hide the starting icon.
        for SlotName,SlotIcon in pairs(self.SpecialInventoryIcons) do
            if SlotName == Slot then
                SlotIcon.ViewportFrame.Visible = false
                break
            end
        end
        for SlotName,SlotIcon in pairs(self.InventorySlotIcons) do
            if SlotName == Slot then
                SlotIcon.ViewportFrame.Visible = false
                break
            end
        end
    end)

    --Connect dragging.
    UserInputService.InputChanged:Connect(function(Input)
        --Return if the input it wasn't a click.
        if Input.UserInputType ~= Enum.UserInputType.MouseMovement and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        --Move the frame.
        if CurrentDraggingFrame then
            CurrentDraggingFrame.Position = UDim2.new(0,Input.Position.X + DraggingOffsetX,0,Input.Position.Y + DraggingOffsetY)
        end
    end)

    --Connect ending the dragging.
    UserInputService.InputEnded:Connect(function(Input)
        --Return if the input it wasn't a click.
        if Input.UserInputType ~= Enum.UserInputType.MouseButton1 and Input.UserInputType ~= Enum.UserInputType.Touch then
            return
        end

        --Return if dragging wasn't started.
        if not CurrentDraggingFrame then
            return
        end

        --Determine the ending slot.
        local Slot
        for SlotName,SlotFrame in pairs(self.SpecialInventorySlots) do
            if self:PointInFrame(Input.Position.X,Input.Position.Y,SlotFrame) then
                Slot = SlotName
                break
            end
        end
        if not Slot then
            for i,SlotFrame in pairs(self.InventorySlotFrames) do
                if self:PointInFrame(Input.Position.X,Input.Position.Y,SlotFrame) then
                    Slot = i + ((self.CurrentPage - 1)* SLOTS_PER_PAGE)
                    break
                end
            end
        end

        --Swap the slots if they can be swapped.
        if Slot and self.Inventory:CanSwap(CurrentSlot,Slot) then
            self.Inventory:SwapSlots(CurrentSlot,Slot)
            SwapSlots:FireServer(CurrentSlot,Slot)
        end
        CurrentDraggingFrame:Destroy()
        CurrentIcon:Destroy()

        --Show the original icon.
        for _,SlotIcon in pairs(self.SpecialInventoryIcons) do
            SlotIcon.ViewportFrame.Visible = true
        end
        for _,SlotIcon in pairs(self.InventorySlotIcons) do
            SlotIcon.ViewportFrame.Visible = true
        end
    end)
end

--[[
Updates the inventory.
--]]
function InventoryWindow:UpdateInventory()
    --Update the page display.
    self.MaxPages = self.Inventory:GetMaxItems() / SLOTS_PER_PAGE
    self.InventoryLeftImage.Visible = (self.CurrentPage ~= 1)
    self.InventoryRightImage.Visible = (self.CurrentPage ~= self.MaxPages)
    self.PageText.Text = tostring(self.CurrentPage)

    --Update the main slots.
    local SlotsIdOffset = SLOTS_PER_PAGE * (self.CurrentPage - 1)
    for i = 1,SLOTS_PER_PAGE do
        local Item = self.Inventory:GetItem(i + SlotsIdOffset)
        local Icon = self.InventorySlotIcons[i]
        if Item then
            Icon:SetItem(Item.Name)
        else
            Icon:SetItem()
        end
    end

    --Update the equipped slots.
    for SlotName,Icon in pairs(self.SpecialInventoryIcons) do
        local Item = self.Inventory:GetItem(SlotName)
        if Item then
            Icon:SetItem(Item.Name)
        else
            Icon:SetItem()
        end
    end

    --Update the player model.
    self.PlayerDisplay:SetHat(self.Inventory:GetItem("PlayerHat"))
    self.PlayerDisplay:SetItem("Torso",self.Inventory:GetItem("PlayerTorso"))
    self.PlayerDisplay:SetItem("LeftArm",self.Inventory:GetItem("PlayerLeftArm"))
    self.PlayerDisplay:SetItem("RightArm",self.Inventory:GetItem("PlayerRightArm"))
    self.PlayerDisplay:SetItem("LeftLeg",self.Inventory:GetItem("PlayerLeftLeg"))
    self.PlayerDisplay:SetItem("RightLeg",self.Inventory:GetItem("PlayerRightLeg"))
end



return InventoryWindow