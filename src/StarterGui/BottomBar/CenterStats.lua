--[[
TheNexusAvenger

Center stats the bottom bar.
--]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local Attacks = ReplicatedStorageProject:GetResource("GameData.Item.Attacks")
local Levels = ReplicatedStorageProject:GetResource("State.Levels")
local StartDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.StartDungeon")
local EndDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.EndDungeon")
local PerformAttack = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.PerformAttack")

local CenterStats = NexusObject:Extend()
CenterStats:SetClassName("CenterStats")



--[[
Creates the center stats.
--]]
function CenterStats:__new(BottomFrame)
    self:InitializeSuper()
    
    --Create the stats containers.
    local StatsBarBackground = Instance.new("ImageLabel")
    StatsBarBackground.AnchorPoint = Vector2.new(0.27,1)
    StatsBarBackground.Size = UDim2.new(6,0,1.5,0)
    StatsBarBackground.SizeConstraint = "RelativeYY"
    StatsBarBackground.Position = UDim2.new(0.5,0,1.65,0)
    StatsBarBackground.BackgroundTransparency = 1
    StatsBarBackground.Image = "rbxassetid://132724931"
    StatsBarBackground.Parent = BottomFrame

    --Create the health bar.
    local HealthBarBackground = Instance.new("ImageLabel")
    HealthBarBackground.BackgroundTransparency = 1
    HealthBarBackground.Size = UDim2.new(512/1024,0,16/256)
    HealthBarBackground.Position = UDim2.new(0.141,0,0.145,0)
    HealthBarBackground.Image = "rbxassetid://132725297"
    HealthBarBackground.Parent = StatsBarBackground

    local HealthBarFill = Instance.new("ImageLabel")
    HealthBarFill.BackgroundTransparency = 1
    HealthBarFill.Size = UDim2.new(1,0,1,0)
    HealthBarFill.Image = "rbxassetid://132725332"
    HealthBarFill.Parent = HealthBarBackground
    self.HealthBarFill = HealthBarFill

    local HealthText = Instance.new("TextLabel")
    HealthText.BackgroundTransparency = 1
    HealthText.Size = UDim2.new(1,0,1.5,0)
    HealthText.Position = UDim2.new(0.08,0,-0.4,0)
    HealthText.Text = "100/100"
    HealthText.Font = Enum.Font.Antique
    HealthText.TextColor3 = Color3.new(238/255,205/255,255/255)
    HealthText.TextScaled = true
    HealthText.Parent = HealthBarBackground
    self.HealthText = HealthText

    Players.LocalPlayer.CharacterAdded:Connect(function()
        self:ConnectHealthBar()
    end)
    coroutine.wrap(function()
        self:ConnectHealthBar()
    end)()

    --Create the energy bar.
    local EnergyValue = Players.LocalPlayer:WaitForChild("Energy")
    self.EnergyValue = EnergyValue
    local EnergyBarBackground = Instance.new("ImageLabel")
    EnergyBarBackground.BackgroundTransparency = 1
    EnergyBarBackground.Size = UDim2.new(512/1024,0,16/256)
    EnergyBarBackground.Position = UDim2.new(0.141,0,0.225,0)
    EnergyBarBackground.Image = "rbxassetid://132725297"
    EnergyBarBackground.Parent = StatsBarBackground

    local EnergyBarFill = Instance.new("ImageLabel")
    EnergyBarFill.BackgroundTransparency = 1
    EnergyBarFill.Size = UDim2.new(EnergyValue.Value/100,0,1,0)
    EnergyBarFill.Image = "rbxassetid://132725076"
    EnergyBarFill.Parent = EnergyBarBackground

    local EnergyText = Instance.new("TextLabel")
    EnergyText.BackgroundTransparency = 1
    EnergyText.Size = UDim2.new(1,0,1.5,0)
    EnergyText.Position = UDim2.new(0.08,0,-0.4,0)
    EnergyText.Text = tostring(EnergyValue.Value).."/100"
    EnergyText.Font = Enum.Font.Antique
    EnergyText.TextColor3 = Color3.new(238/255,205/255,255/255)
    EnergyText.TextScaled = true
    EnergyText.Parent = EnergyBarBackground

    EnergyValue.Changed:Connect(function()
        EnergyBarFill:TweenSize(UDim2.new(EnergyValue.Value/100,0,1,0),"InOut","Quad",0.1,true)
        EnergyText.Text = tostring(EnergyValue.Value).."/100"
    end)

    --Create the experience bar.
    local PlayerLevels = Levels.GetLevels(Players.LocalPlayer)
    local ExperienceBarBackground = Instance.new("ImageLabel")
    ExperienceBarBackground.BackgroundTransparency = 1
    ExperienceBarBackground.Size = UDim2.new(512/1024,0,16/256)
    ExperienceBarBackground.Position = UDim2.new(0.062,0,0.5 + (3/256),0)
    ExperienceBarBackground.Image = "rbxassetid://132725125"
    ExperienceBarBackground.Parent = StatsBarBackground

    local ExperienceBarFill = Instance.new("ImageLabel")
    ExperienceBarFill.BackgroundTransparency = 1
    ExperienceBarFill.Size = UDim2.new((PlayerLevels.TotalExperience - PlayerLevels.PreviousLevelExperience)/(PlayerLevels.NextLevelExperience - PlayerLevels.PreviousLevelExperience),0,1,0)
    ExperienceBarFill.Image = "rbxassetid://132725249"
    ExperienceBarFill.Parent = ExperienceBarBackground

    local ExperienceBarMarkings = Instance.new("ImageLabel")
    ExperienceBarMarkings.BackgroundTransparency = 1
    ExperienceBarMarkings.Size = UDim2.new(1,0,1,0)
    ExperienceBarMarkings.Image = "rbxassetid://132725193"
    ExperienceBarMarkings.Parent = ExperienceBarBackground

    local ExperienceBarText = Instance.new("ImageLabel")
    ExperienceBarText.BackgroundTransparency = 1
    ExperienceBarText.Position = UDim2.new(0.01,0,0.25,0)
    ExperienceBarText.Size = UDim2.new(32/512,0,8/16,0)
    ExperienceBarText.Image = "rbxassetid://132725160"
    ExperienceBarText.Parent = ExperienceBarBackground

    PlayerLevels.Changed:Connect(function()
        ExperienceBarFill:TweenSize(UDim2.new((PlayerLevels.TotalExperience - PlayerLevels.PreviousLevelExperience)/(PlayerLevels.NextLevelExperience - PlayerLevels.PreviousLevelExperience),0,1,0),"InOut","Quad",0.5,true)
    end)

    --Create the attacks bar.
    self.SelectedAttack = 1
    local AttackButtonsContainer = Instance.new("Frame")
    AttackButtonsContainer.BackgroundTransparency = 1
    AttackButtonsContainer.Size = UDim2.new(390/1024,0,42/256,0)
    AttackButtonsContainer.Position = UDim2.new(82/1024,0,78/256,0)
    AttackButtonsContainer.Visible = false
    AttackButtonsContainer.Parent = StatsBarBackground
    self.AttackButtonsContainer = AttackButtonsContainer

    local AttackSelector = Instance.new("ImageLabel")
    AttackSelector.BackgroundTransparency = 1
    AttackSelector.Size = UDim2.new(46/390,0,46/42,0)
    AttackSelector.Position = UDim2.new(-2/390,0,-2/42,0)
    AttackSelector.ZIndex = 3
    AttackSelector.Image = "rbxassetid://133251112"
    AttackSelector.Parent = AttackButtonsContainer
    self.AttackSelector = AttackSelector
    
    local LastX,LastY = 0,0
    self.AttackButtons = {}
    self.AttackDB = true
    for i,AttackData in pairs(Attacks) do
        --Create the attack button.
        local AttackButton = Instance.new("ImageButton")
        AttackButton.BackgroundTransparency = 1
        AttackButton.Size = UDim2.new(42/390,0,42/42,0)
        AttackButton.Position = UDim2.new((i - 1) * (50/390),0,0,0)
        AttackButton.Visible = (PlayerLevels.Level >= (AttackData.RequiredLevel or 0))
        AttackButton.Image = "rbxassetid://"..tostring(AttackData.Icon)
        AttackButton.Parent = AttackButtonsContainer
        self.AttackButtons[i] = AttackButton

        PlayerLevels:GetPropertyChangedSignal("Level"):Connect(function()
            AttackButton.Visible = (PlayerLevels.Level >= (AttackData.RequiredLevel or 0))
        end)

        EnergyValue.Changed:Connect(function()
            if EnergyValue.Value >= (AttackData.EnergyPerUse or 0) then
                AttackButton.ImageColor3 = Color3.new(1,1,1)
            else
                AttackButton.ImageColor3 = Color3.new(0.5,0.5,0.5)
            end
        end)

        --Connect the button.
        local DB = true
        AttackButton.MouseButton1Down:Connect(function()
            if DB and AttackButtonsContainer.Visible and AttackButton.Visible then
                DB = false
                self:SelectWeapon(i)
                wait()
                DB = true
            end
        end)

        UserInputService.InputBegan:Connect(function(Input,Processed)
            if Processed then return end
            if not AttackButtonsContainer.Visible or not AttackButton.Visible then return end
            for _,KeyCode in pairs(AttackData.ActivationKeys or {}) do
                if KeyCode == Input.KeyCode then
                    self:SelectWeapon(i)
                    self:ActivateWeapon(LastX,LastY)
                    break
                end
            end
        end)
    end

    --Connect invoking attacks.
    UserInputService.InputBegan:Connect(function(Input,Processed)
        if Processed then return end
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            self:ActivateWeapon(Input.Position.X,Input.Position.Y)
        end
    end)
    UserInputService.InputChanged:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
            LastX,LastY = Input.Position.X,Input.Position.Y
        end
    end)

    --Connect showing and hiding the attacks.
    StartDungeon.OnClientEvent:Connect(function(_,_,_,Type)
        if Type == "Monster" or Type == "Bloxhilda" then
            AttackButtonsContainer.Visible = true
        end
    end)
    
    EndDungeon.OnClientEvent:Connect(function()
        AttackButtonsContainer.Visible = false
    end)
end

--[[
Connects the health bar for a new character.
--]]
function CenterStats:ConnectHealthBar()
    local Character = Players.LocalPlayer.Character
    if Character then
        local Humanoid = Character:WaitForChild("Humanoid")

        --Connect changes to the health.
        Humanoid:GetPropertyChangedSignal("Health"):Connect(function()
            self.HealthBarFill.Size = UDim2.new(Humanoid.Health / Humanoid.MaxHealth,0,1,0)
            self.HealthText.Text = tostring(math.floor(Humanoid.Health + 0.5)).."/"..tostring(math.floor(Humanoid.MaxHealth + 0.5))
        end)
        Humanoid:GetPropertyChangedSignal("MaxHealth"):Connect(function()
            self.HealthBarFill.Size = UDim2.new(Humanoid.Health / Humanoid.MaxHealth,0,1,0)
            self.HealthText.Text = tostring(math.floor(Humanoid.Health + 0.5)).."/"..tostring(math.floor(Humanoid.MaxHealth + 0.5))
        end)

        --Set up the current bar.
        self.HealthBarFill.Size = UDim2.new(Humanoid.Health / Humanoid.MaxHealth,0,1,0)
        self.HealthText.Text = tostring(math.floor(Humanoid.Health + 0.5)).."/"..tostring(math.floor(Humanoid.MaxHealth + 0.5))
    end
end

--[[
Selects a weapon to use.
--]]
function CenterStats:SelectWeapon(Id)
    self.SelectedAttack = Id
    self.AttackSelector.Position = UDim2.new(((50 * (Id - 1))-2)/390,0,-2/42,0)
end

--[[
Activates the selected weapon.
--]]
function CenterStats:ActivateWeapon(X,Y)
    --Return if the attack if unusable.
    if not self.AttackButtonsContainer.Visible then return end
    if not self.AttackButtons[self.SelectedAttack].Visible then return end
    if self.AttackButtons[self.SelectedAttack].ImageColor3 ~= Color3.new(1,1,1) then return end

    --Return if the attack is in progress.
    if not self.AttackDB then return end
    self.AttackDB = false

    --Remove the energy for the attack.
    local AttackData = Attacks[self.SelectedAttack]
    self.EnergyValue.Value = self.EnergyValue.Value - (AttackData.EnergyPerUse or 0)

    --Determine the target.
    local Camera = Workspace.CurrentCamera
    local CameraMouseRay = Camera:ScreenPointToRay(X,Y,10000)
    local TargetEndPos = CameraMouseRay.Origin + CameraMouseRay.Direction
    local CharacterIgnoreList = RaycastParams.new()
    CharacterIgnoreList.FilterType = Enum.RaycastFilterType.Blacklist
    CharacterIgnoreList.FilterDescendantsInstances = {Players.LocalPlayer.Character}
    local RaycastResults = Workspace:Raycast(Camera.CFrame.Position,TargetEndPos - Camera.CFrame.Position,CharacterIgnoreList)

    --Activate the attack.
    local AttackClass = ReplicatedStorageProject:GetResource("State.Tool.Attack."..AttackData.Name)
    if RaycastResults then
        if AttackClass.PerformClientAttack then
            AttackClass.PerformClientAttack(RaycastResults.Position)
        end
        PerformAttack:FireServer(self.SelectedAttack,RaycastResults.Position)
    else
        if AttackClass.PerformClientAttack then
            AttackClass.PerformClientAttack(TargetEndPos)
        end
        PerformAttack:FireServer(self.SelectedAttack,TargetEndPos)
    end

    --End attack.
    wait(AttackData.AttackCooldown or 0)
    self.AttackDB = true
end



return CenterStats