--[[
TheNexusAvenger

"Attack" for a heal effect.
Particle effect by gkku (https://www.roblox.com/library/1086049283/Particle-a-Day-Effects).
Class is static (should not be created).
--]]

local PARTICLE_SCALE = 1.5



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local HealEffect = NexusObject:Extend()
HealEffect:SetClassName("HealEffect")



--[[
Performs the attack on the server.
--]]
function HealEffect.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if Humanoid and Humanoid.Health > 0 and HumanoidRootPart then
            --Create the effect.
            local Attachment = Instance.new("Attachment")
            Attachment.Parent = HumanoidRootPart

            local BitsEffect = Instance.new("ParticleEmitter")
            BitsEffect.Color = ColorSequence.new(Color3.new(50/255,255/255,50/255))
            BitsEffect.LightEmission = 1
            BitsEffect.LightInfluence = 0
            BitsEffect.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0,2 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.0555,1.78 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.111,1.58 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.167,1.39 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.222,1.21 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.278,1.04 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.333,0.89 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.389,0.748 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.444,0.618 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.5,0.501 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.555,0.396 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.61,0.303 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.666,0.223 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.721,0.155 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.777,0.0995 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.832,0.0561 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.888,0.0251 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.943,0.00638 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(1,0),
            })
            BitsEffect.Texture = "rbxassetid://1084996976"
            BitsEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0,1),
                NumberSequenceKeypoint.new(0.5,0.25),
                NumberSequenceKeypoint.new(1,1),
            })
            BitsEffect.ZOffset = 0
            BitsEffect.LockedToPart = true
            BitsEffect.Lifetime = NumberRange.new(0.5,1)
            BitsEffect.Rate = 4
            BitsEffect.Rotation = NumberRange.new(-180,180)
            BitsEffect.Speed = NumberRange.new(0,0)
            BitsEffect.Parent = Attachment

            local SmallBitsEffect = Instance.new("ParticleEmitter")
            SmallBitsEffect.Color = ColorSequence.new(Color3.new(50/255,255/255,50/255))
            SmallBitsEffect.LightEmission = 1
            SmallBitsEffect.LightInfluence = 0
            SmallBitsEffect.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0,2 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.0555,1.78 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.111,1.58 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.167,1.39 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.222,1.21 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.278,1.04 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.333,0.89 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.389,0.748 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.444,0.618 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.5,0.501 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.555,0.396 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.61,0.303 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.666,0.223 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.721,0.155 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.777,0.0995 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.832,0.0561 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.888,0.0251 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(0.943,0.00638 * PARTICLE_SCALE),
                NumberSequenceKeypoint.new(1,0),
            })
            SmallBitsEffect.Texture = "rbxassetid://1084997326"
            SmallBitsEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0,1),
                NumberSequenceKeypoint.new(0.5,0.25),
                NumberSequenceKeypoint.new(1,1),
            })
            SmallBitsEffect.ZOffset = 0
            SmallBitsEffect.LockedToPart = true
            SmallBitsEffect.Lifetime = NumberRange.new(0.5,1)
            SmallBitsEffect.Rate = 4
            SmallBitsEffect.Rotation = NumberRange.new(-180,180)
            SmallBitsEffect.Speed = NumberRange.new(0,0)
            SmallBitsEffect.Parent = Attachment

            local SolidWaveEffect = Instance.new("ParticleEmitter")
            SolidWaveEffect.Color = ColorSequence.new(Color3.new(200/255,255/255,200/255))
            SolidWaveEffect.LightEmission = 1
            SolidWaveEffect.LightInfluence = 0
            SolidWaveEffect.Size = NumberSequence.new(1.75 * PARTICLE_SCALE,1 * PARTICLE_SCALE)
            SolidWaveEffect.Texture = "rbxassetid://1084996536"
            SolidWaveEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0,1),
                NumberSequenceKeypoint.new(0.5,0.4),
                NumberSequenceKeypoint.new(1,1),
            })
            SolidWaveEffect.ZOffset = 0
            SolidWaveEffect.LockedToPart = true
            SolidWaveEffect.Lifetime = NumberRange.new(1,1.5)
            SolidWaveEffect.Rate = 3
            SolidWaveEffect.Rotation = NumberRange.new(-180,180)
            SolidWaveEffect.Speed = NumberRange.new(0,0)
            SolidWaveEffect.RotSpeed = NumberRange.new(250,500)
            SolidWaveEffect.Parent = Attachment

            local TransparentWaveEffect = Instance.new("ParticleEmitter")
            TransparentWaveEffect.Color = ColorSequence.new(Color3.new(50/255,255/255,50/255))
            TransparentWaveEffect.LightEmission = 1
            TransparentWaveEffect.LightInfluence = 0
            TransparentWaveEffect.Size = NumberSequence.new(2 * PARTICLE_SCALE,1 * PARTICLE_SCALE)
            TransparentWaveEffect.Texture = "rbxassetid://1084965356"
            TransparentWaveEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0,1),
                NumberSequenceKeypoint.new(0.5,0.75),
                NumberSequenceKeypoint.new(1,1),
            })
            TransparentWaveEffect.ZOffset = 0
            TransparentWaveEffect.LockedToPart = true
            TransparentWaveEffect.Lifetime = NumberRange.new(1,2)
            TransparentWaveEffect.Rate = 1
            TransparentWaveEffect.Rotation = NumberRange.new(-180,180)
            TransparentWaveEffect.Speed = NumberRange.new(0,0)
            TransparentWaveEffect.RotSpeed = NumberRange.new(100,200)
            TransparentWaveEffect.Parent = Attachment

            --Heal the player.
            for i = 1,25 do
                wait(0.25)
                if Humanoid.Health > 0 then
                    Humanoid.Health = Humanoid.Health + 1
                end
            end

            --Clear the effect.
            Attachment:Destroy()
        end
    end
end



return HealEffect