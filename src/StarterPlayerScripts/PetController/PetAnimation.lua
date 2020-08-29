--[[
TheNexusAvenger

Manages the animations of pets.
--]]




return function (PetModel)
    --Get the pet components.
    local PetHumanoid = PetModel:WaitForChild("Humanoid")

    --Load the animations.
    local WalkAnimation = Instance.new("Animation")
    WalkAnimation.AnimationId = "rbxassetid://161210451"
    local WalkTrack = PetHumanoid:LoadAnimation(WalkAnimation)
    
    local IdleAnimation = Instance.new("Animation")
    IdleAnimation.AnimationId = "rbxassetid://180435571"
    local IdleTrack = PetHumanoid:LoadAnimation(IdleAnimation)
    
    --Set up playing animations.
    local State = "Idle"
    WalkTrack.Stopped:Connect(function()
        if State == "Walk" then
            WalkTrack:Play()
        end
    end)
    IdleTrack.Stopped:Connect(function()
        if State == "Idle" then
            IdleTrack:Play()
        end
    end)
    PetHumanoid.Running:Connect(function(Ratio)
        if Ratio > 0.5 then
            if State ~= "Walk" then
                State = "Walk"
                WalkTrack:Play()
            end
        else
            if State ~= "Idle" then
                State = "Idle"
                IdleTrack:Play()
            end
        end
    end)

    --Start the idle animation.
    IdleTrack:Play()
end