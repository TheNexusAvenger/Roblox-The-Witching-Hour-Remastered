--[[
TheNexusAvenger

Sets up animated the motorcycle.
Done on the client for latency and server for replication.
--]]

local MOTORCYCLE_MAX_SPEED = 70



return function(Motorcycle)
    --Get the components.
    local RunningSound = Motorcycle:WaitForChild("RunningSound")
    local BackWheelMotor,FrontWheelMotor = Motorcycle:WaitForChild("BackWheel"):WaitForChild("Motor"),Motorcycle:WaitForChild("FrontWheel"):WaitForChild("Motor")
    local ExhaustSmoke = Motorcycle:WaitForChild("SmokePart"):WaitForChild("ExhaustSmoke")

    --Return the update callback.
    return function()
        local Speed = Vector3.new(Motorcycle.Velocity.X,0,Motorcycle.Velocity.Z).magnitude
        local MotorDesiredAngle = 999999999 * (-Speed/math.abs(Speed))
        local MotorMaxVelocity = Speed/250
        RunningSound.Pitch = 1 + (math.abs(Speed / MOTORCYCLE_MAX_SPEED))
        ExhaustSmoke.Opacity = (math.min(math.abs(Speed),10)/10) * 0.5
        BackWheelMotor.DesiredAngle = MotorDesiredAngle
        BackWheelMotor.MaxVelocity = MotorMaxVelocity
        FrontWheelMotor.DesiredAngle = MotorDesiredAngle
        FrontWheelMotor.MaxVelocity = MotorMaxVelocity
    end
end