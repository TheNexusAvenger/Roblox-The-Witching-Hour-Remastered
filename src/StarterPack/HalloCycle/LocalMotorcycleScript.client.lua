--[[
TheNexusAvenger

Runs the motorcycle on the client.
--]]

local MOTORCYCLE_MAX_SPEED = 70
local MOTORCYCLE_MIN_SPEED = 20
local MOTORCYCLE_ACCELERATION = 20
local MOTORCYCLE_DECELLERATION = 20
local MOTORCYCLE_MAX_TURN_SPEED = 5
local MOTORCYCLE_TURN_ALPHA = 0.3
local MOTORCYCLE_TURN_ALPHA_DAMPENING = 0.2



local UserInputService = game:GetService("UserInputService")

local Tool = script.Parent
local AnimateMotorcycle = require(Tool:WaitForChild("AnimateMotorcycle"))

local KeysDown = {
    [Enum.KeyCode.W] = false,
    [Enum.KeyCode.A] = false,
    [Enum.KeyCode.S] = false,
    [Enum.KeyCode.D] = false,
}



--[[
Invoked when the tool is equipped.
--]]
local function OnEquip()
    --Wait for the motorcycle.
    local Character = Tool.Parent
    if not Character then return end
    local Motorcycle = Character:WaitForChild("Motorcycle")
    local RotationForce,ThrustForce,TurnGyro = Motorcycle:WaitForChild("BodyAngularVelocity"),Motorcycle:WaitForChild("BodyVelocity"),Motorcycle:WaitForChild("BodyGyro")
    local AnimateMotorcycleStep = AnimateMotorcycle(Motorcycle)

    --Set up updating the movement.
    local CurrentSpeed = 0
    local CurrentTurnSpeed = 0
    while Motorcycle.Parent do
    local DeltaTime = wait()

    --Update the speed of the motorcycle.
    local Direction = Motorcycle.CFrame.LookVector
    Direction = Vector3.new(Direction.X,0,Direction.Z).unit
    local ActualSpeed = Vector3.new(Motorcycle.Velocity.X,0,Motorcycle.Velocity.Z).magnitude
    local VelocityDifference = math.abs(ActualSpeed - ThrustForce.Velocity.magnitude)
    if not KeysDown[Enum.KeyCode.W] and not KeysDown[Enum.KeyCode.S] then
        CurrentSpeed = CurrentSpeed * 0.99
    end
    if ActualSpeed > 3 and ThrustForce.Velocity.magnitude > 3 and VelocityDifference > 0.7 * ThrustForce.Velocity.magnitude then
        CurrentSpeed = CurrentSpeed * 0.9
    end
    if KeysDown[Enum.KeyCode.W] then
        CurrentSpeed = math.min(MOTORCYCLE_MAX_SPEED,CurrentSpeed + (MOTORCYCLE_ACCELERATION * DeltaTime))
    end
    if KeysDown[Enum.KeyCode.S] then
        CurrentSpeed = math.max(-MOTORCYCLE_MIN_SPEED,CurrentSpeed - (MOTORCYCLE_DECELLERATION * (CurrentSpeed > 0 and 2.8 or 1) * DeltaTime))
    end
    ThrustForce.Velocity = Vector3.new(Direction.X * CurrentSpeed,0,Direction.Z * CurrentSpeed)

    --Update the turn speed of the motorcycle.
    if math.abs(CurrentTurnSpeed) > MOTORCYCLE_TURN_ALPHA_DAMPENING then
        CurrentTurnSpeed = (CurrentTurnSpeed - (MOTORCYCLE_TURN_ALPHA_DAMPENING * (math.abs(CurrentTurnSpeed)/CurrentTurnSpeed)))
    else 
        CurrentTurnSpeed = 0
    end
    if KeysDown[Enum.KeyCode.A] then 
        CurrentTurnSpeed = math.min(MOTORCYCLE_MAX_TURN_SPEED,CurrentTurnSpeed + MOTORCYCLE_TURN_ALPHA)
    end
    if KeysDown[Enum.KeyCode.D] then
        CurrentTurnSpeed = math.max(-MOTORCYCLE_MAX_TURN_SPEED,CurrentTurnSpeed - MOTORCYCLE_TURN_ALPHA)
    end
    local ActualTurnSpeed = CurrentTurnSpeed * (CurrentSpeed/MOTORCYCLE_MAX_SPEED)
    RotationForce.AngularVelocity = Vector3.new(0,ActualTurnSpeed,0)

    --Update leaning the motorcycle.
    local LeanAmount = (-ActualTurnSpeed * (math.pi/6)/4)
    TurnGyro.CFrame = CFrame.new(Vector3.new(0,0,0),Direction) * CFrame.Angles(0,0,-LeanAmount)

    --Update the visible motorcycle.
    AnimateMotorcycleStep()
    end
end



--Connect keys being pressed and realsed.
UserInputService.InputBegan:Connect(function(Input,Processed)
    if Processed then return end
    if KeysDown[Input.KeyCode] ~= nil then
        KeysDown[Input.KeyCode] = true
    end
end)

UserInputService.InputEnded:Connect(function(Input)
    if KeysDown[Input.KeyCode] ~= nil then
        KeysDown[Input.KeyCode] = false
    end
end)

--Connect the events.
Tool.Equipped:Connect(OnEquip)