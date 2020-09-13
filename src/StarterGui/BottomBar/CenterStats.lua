--[[
TheNexusAvenger

Center stats the bottom bar.
--]]

local Players = game:GetService("Players")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local Levels = ReplicatedStorageProject:GetResource("State.Levels")

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
    local EnergyBarBackground = Instance.new("ImageLabel")
    EnergyBarBackground.BackgroundTransparency = 1
    EnergyBarBackground.Size = UDim2.new(512/1024,0,16/256)
    EnergyBarBackground.Position = UDim2.new(0.141,0,0.225,0)
    EnergyBarBackground.Image = "rbxassetid://132725297"
    EnergyBarBackground.Parent = StatsBarBackground

    local EnergyBarFill = Instance.new("ImageLabel")
    EnergyBarFill.BackgroundTransparency = 1
    EnergyBarFill.Size = UDim2.new(0,0,1,0)
    EnergyBarFill.Image = "rbxassetid://132725076"
    EnergyBarFill.Parent = EnergyBarBackground

    local EnergyText = Instance.new("TextLabel")
    EnergyText.BackgroundTransparency = 1
    EnergyText.Size = UDim2.new(1,0,1.5,0)
    EnergyText.Position = UDim2.new(0.08,0,-0.4,0)
    EnergyText.Text = "100/100"
    EnergyText.Font = Enum.Font.Antique
    EnergyText.TextColor3 = Color3.new(238/255,205/255,255/255)
    EnergyText.TextScaled = true
    EnergyText.Parent = EnergyBarBackground

    --TODO: Connect energy

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
    --TODO: Implement attacks
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



return CenterStats