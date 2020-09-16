--[[
TheNexusAvenger

Runs the motorcycle on the server.
--]]

local Tool = script.Parent
local CreateMotorcycle = require(Tool:WaitForChild("CreateMotorcycle"))
local AnimateMotorcycle = require(Tool:WaitForChild("AnimateMotorcycle"))

local CurrentHumanoid,CurrentMotorcycle



--[[
Invoked when the tool is equipped.
--]]
local function OnEquip()
    --Return if the character is invalid.
    local Character = Tool.Parent
    if not Character then return end
    local Humanoid = Character:FindFirstChild("Humanoid")
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not Humanoid or not HumanoidRootPart or Humanoid.Health < 0 then return end
    CurrentHumanoid = Humanoid

    --Create the motorcycle.
    Humanoid.PlatformStand = true
    CurrentMotorcycle = CreateMotorcycle()
    CurrentMotorcycle.Name = "Motorcycle"
    CurrentMotorcycle.CFrame = HumanoidRootPart.CFrame * CFrame.new(0,-1.1,-0.9)
    CurrentMotorcycle.Parent = Character
    CurrentMotorcycle:WaitForChild("RunningSound"):Play()

    local TorsoWeld = Instance.new("Weld")
    TorsoWeld.C0 = CFrame.new(0,-1.1,-0.9)
    TorsoWeld.Part0 = HumanoidRootPart
    TorsoWeld.Part1 = CurrentMotorcycle
    TorsoWeld.Parent = CurrentMotorcycle

    local RotationForce = Instance.new("BodyAngularVelocity")
    RotationForce.MaxTorque = Vector3.new(0,math.huge,0)
    RotationForce.AngularVelocity = Vector3.new(0,0,0)
    RotationForce.Parent = CurrentMotorcycle

    local ThrustForce = Instance.new("BodyVelocity")
    ThrustForce.MaxForce = Vector3.new(math.huge,0,math.huge)
    ThrustForce.Velocity = Vector3.new(0,0,0)
    ThrustForce.P = 100
    ThrustForce.Parent = CurrentMotorcycle

    local TurnGyro = Instance.new("BodyGyro")
    TurnGyro.MaxTorque = Vector3.new(5000,0,5000)
    TurnGyro.P = 300
    TurnGyro.D = 100
    TurnGyro.Parent = CurrentMotorcycle

    --Start animating the motorcycle.
    local AnimateMotorcycleStep = AnimateMotorcycle(CurrentMotorcycle)
    while true do
        AnimateMotorcycleStep()
        wait()
    end
end

--[[
Invoked when the tool is unequipped.
--]]
local function OnUnequip()
    --Clear the motorcycle.
    if CurrentHumanoid then
        CurrentHumanoid.PlatformStand = false
    end
    if CurrentMotorcycle then
        CurrentMotorcycle:Destroy()
    end
end



--Connect the events.
Tool.Equipped:Connect(OnEquip)
Tool.Unequipped:Connect(OnUnequip)