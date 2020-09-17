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



local Workspace = game:GetService("Workspace")

local Tool = script.Parent
local AnimateMotorcycle = require(Tool:WaitForChild("AnimateMotorcycle"))



--[[
Invoked when the tool is equipped.
--]]
local function OnEquip()
    --Wait for the motorcycle.
    local Character = Tool.Parent
    if not Character then return end
    local Humanoid = Character:FindFirstChild("Humanoid")
    if not Humanoid then return end
    local Motorcycle = Character:WaitForChild("Motorcycle")
    local RotationForce,ThrustForce,TurnGyro = Motorcycle:WaitForChild("BodyAngularVelocity"),Motorcycle:WaitForChild("BodyVelocity"),Motorcycle:WaitForChild("BodyGyro")
    local AnimateMotorcycleStep = AnimateMotorcycle(Motorcycle)

    --Set up updating the movement.
    local CurrentSpeed = 0
    local CurrentTurnSpeed = 0
    while Motorcycle.Parent do
        local DeltaTime = wait()

        --Get the positions of the Humanoid.
        local DirectionX,DirectionZ = 0,0
        local CameraDirection = Workspace.CurrentCamera.CFrame.LookVector
        if Humanoid.MoveDirection ~= Vector3.new(0,0,0) then
            local WalkDirection = (CFrame.new(Vector3.new(0,0,0),Vector3.new(CameraDirection.X,0,CameraDirection.Z)):inverse() * CFrame.new(Vector3.new(0,0,0),Humanoid.MoveDirection)).LookVector
            local WalkAngle,WalkMultiplier = math.atan2(WalkDirection.Z,WalkDirection.X),WalkDirection.Magnitude
            if math.abs(math.sin(WalkAngle)) > math.abs(math.cos(WalkAngle)) then
                DirectionX = 2 * (math.cos(WalkAngle) / math.sqrt(2))
                if math.sin(WalkAngle) > 0 then
                    DirectionZ = -WalkMultiplier
                else
                    DirectionZ = WalkMultiplier
                end
            else
                DirectionZ = -2 * (math.sin(WalkAngle) / math.sqrt(2))
                if math.cos(WalkAngle) > 0 then
                    DirectionX = WalkMultiplier
                else
                    DirectionX = -WalkMultiplier
                end
            end
        end

        --Update the speed of the motorcycle.
        local Direction = Motorcycle.CFrame.LookVector
        Direction = Vector3.new(Direction.X,0,Direction.Z).unit
        local ActualSpeed = Vector3.new(Motorcycle.Velocity.X,0,Motorcycle.Velocity.Z).Magnitude
        local VelocityDifference = math.abs(ActualSpeed - ThrustForce.Velocity.Magnitude)
        if DirectionX == 0 and DirectionZ == 0 then
            CurrentSpeed = CurrentSpeed * 0.99
        end
        if ActualSpeed > 3 and ThrustForce.Velocity.Magnitude > 3 and VelocityDifference > 0.7 * ThrustForce.Velocity.Magnitude then
            CurrentSpeed = CurrentSpeed * 0.9
        end
        if DirectionZ > 0 then
            CurrentSpeed = math.min(MOTORCYCLE_MAX_SPEED,CurrentSpeed + (MOTORCYCLE_ACCELERATION * DeltaTime * DirectionZ))
        end
        if DirectionZ < 0 then
            CurrentSpeed = math.max(-MOTORCYCLE_MIN_SPEED,CurrentSpeed - (MOTORCYCLE_DECELLERATION * (CurrentSpeed > 0 and 2.8 or 1) * DeltaTime * -DirectionZ))
        end
        ThrustForce.Velocity = Vector3.new(Direction.X * CurrentSpeed,0,Direction.Z * CurrentSpeed)

        --Update the turn speed of the motorcycle.
        if math.abs(CurrentTurnSpeed) > MOTORCYCLE_TURN_ALPHA_DAMPENING then
            CurrentTurnSpeed = (CurrentTurnSpeed - (MOTORCYCLE_TURN_ALPHA_DAMPENING * (math.abs(CurrentTurnSpeed)/CurrentTurnSpeed)))
        else 
            CurrentTurnSpeed = 0
        end
        if DirectionX ~= 0 then 
            CurrentTurnSpeed = math.clamp(CurrentTurnSpeed - (MOTORCYCLE_TURN_ALPHA * DirectionX),-MOTORCYCLE_MAX_TURN_SPEED,MOTORCYCLE_MAX_TURN_SPEED)
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



--Connect the events.
Tool.Equipped:Connect(OnEquip)