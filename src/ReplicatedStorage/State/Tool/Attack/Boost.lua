--[[
TheNexusAvenger

"Boost" for a heal effect.
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

            local BoltsEffect = Instance.new("ParticleEmitter")
            BoltsEffect.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,Color3.new(255/255,255/255,150/255)),
                ColorSequenceKeypoint.new(0.5,Color3.new(255/255,230/255,101/255)),
                ColorSequenceKeypoint.new(1,Color3.new(255/255,255/255,150/255)),
            })
            BoltsEffect.LightEmission = 1
            BoltsEffect.LightInfluence = 0
            BoltsEffect.Size = NumberSequence.new({
                NumberSequenceKeypoint.new(0,4.8,0.4),
                NumberSequenceKeypoint.new(1,4.8,0.4),
            })
            BoltsEffect.Texture = "rbxassetid://1084955012"
            BoltsEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0,0.883),
                NumberSequenceKeypoint.new(0.0555,0.983),
                NumberSequenceKeypoint.new(0.111,0.171),
                NumberSequenceKeypoint.new(0.167,0.393),
                NumberSequenceKeypoint.new(0.222,0.129),
                NumberSequenceKeypoint.new(0.278,0.921),
                NumberSequenceKeypoint.new(0.333,0.416),
                NumberSequenceKeypoint.new(0.389,0.215),
                NumberSequenceKeypoint.new(0.444,0.782),
                NumberSequenceKeypoint.new(0.5,0.232),
                NumberSequenceKeypoint.new(0.555,0.79),
                NumberSequenceKeypoint.new(0.61,0.811),
                NumberSequenceKeypoint.new(0.666,0.912),
                NumberSequenceKeypoint.new(0.721,0.875),
                NumberSequenceKeypoint.new(0.777,0.419),
                NumberSequenceKeypoint.new(0.832,0.3),
                NumberSequenceKeypoint.new(0.888,0.164),
                NumberSequenceKeypoint.new(0.943,0.396),
                NumberSequenceKeypoint.new(0.999,0.7),
                NumberSequenceKeypoint.new(1,1),
            })
            BoltsEffect.ZOffset = 0
            BoltsEffect.LockedToPart = true
            BoltsEffect.Lifetime = NumberRange.new(0.333,0.333)
            BoltsEffect.Rate = 12
            BoltsEffect.Rotation = NumberRange.new(-180,180)
            BoltsEffect.Speed = NumberRange.new(0,0)
            BoltsEffect.Parent = Attachment

            local BubbleEffect = Instance.new("ParticleEmitter")
            BubbleEffect.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0,Color3.new(255/255,255/255,255/255)),
                ColorSequenceKeypoint.new(0.5,Color3.new(255/255,208/255,65/255)),
                ColorSequenceKeypoint.new(1,Color3.new(255/255,255/255,255/255)),
            })
            BubbleEffect.LightEmission = 1
            BubbleEffect.LightInfluence = 0
            BubbleEffect.Size = NumberSequence.new(4,4)
            BubbleEffect.Texture = "rbxassetid://1084955488"
            BubbleEffect.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0,1),
                NumberSequenceKeypoint.new(0.5,0.7),
                NumberSequenceKeypoint.new(1,1),
            })
            BubbleEffect.ZOffset = 3
            BubbleEffect.LockedToPart = true
            BubbleEffect.Lifetime = NumberRange.new(1,1)
            BubbleEffect.Rate = 6
            BubbleEffect.Rotation = NumberRange.new(-180,180)
            BubbleEffect.Speed = NumberRange.new(0,0)
            BubbleEffect.Parent = Attachment

            --Start the boost.
            local BoostValue = Instance.new("BoolValue")
            BoostValue.Name = "BoostEffect"
            BoostValue.Value = true
            BoostValue.Parent = Character

            --Clear the effect.
            delay(5,function()
                Attachment:Destroy()
                BoostValue:Destroy()
            end)
        end
    end
end



return HealEffect