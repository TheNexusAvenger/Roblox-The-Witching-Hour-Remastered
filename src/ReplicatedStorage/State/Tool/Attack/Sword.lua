--[[
TheNexusAvenger

Attack for a sword.
Class is static (should not be created).
--]]

--The animations only work in Nexus Development's place because animations only work for the owner.
--If animations become free, this will solve this problem.
--https://devforum.roblox.com/t/public-animations/43299
local SWORD_ANIMATIONS = {
    {
        AnimationId = "rbxassetid://2016260994",
        SoundId = "rbxasset://sounds//swordslash.wav",
        Damage = 50,
    },
    {
        AnimationId = "rbxassetid://2016262978",
        SoundId = "rbxasset://sounds//swordslash.wav",
        Damage = 50,
    },
    {
        AnimationId = "rbxassetid://2016256809",
        SoundId = "rbxasset://sounds//swordlunge.wav",
        Damage = 100,
    },
}



local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local SwordAttack = NexusObject:Extend()
SwordAttack:SetClassName("SwordAttack")



--[[
Performs the attack on the client.
--]]
function SwordAttack.PerformClientAttack(Target)
    --Play a "random" animation.
    local Character = Players.LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid and Humanoid.Health > 0 then
            local RandomAnimation = SWORD_ANIMATIONS[math.ceil((Target.X + Target.Z) % #SWORD_ANIMATIONS)]
            local Animation = Instance.new("Animation")
            Animation.AnimationId = RandomAnimation.AnimationId
            local AnimationTrack = Humanoid:LoadAnimation(Animation)
            AnimationTrack:Play()
        end
    end
end

--[[
Performs the attack on the server.
--]]
function SwordAttack.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid and Humanoid.Health > 0 then
            local Sword = Character:WaitForChild("Sword")

            --Connect damaging the sword.
            local MonsterDBs = {}
            local RandomAnimation = SWORD_ANIMATIONS[math.ceil((Target.X + Target.Z) % #SWORD_ANIMATIONS)]
            local TouchEvent = Sword.Touched:Connect(function(TouchPart)
                local MonsterCharacter = TouchPart.Parent
                if MonsterCharacter and MonsterCharacter:IsDescendantOf(DungeonModel) and not MonsterDBs[MonsterCharacter] then
                    local MonsterHumanoid = MonsterCharacter:FindFirstChild("Humanoid")
                    if MonsterHumanoid then
                        MonsterDBs[MonsterCharacter] = true
                        MonsterHumanoid:TakeDamage(RandomAnimation.Damage)
                    end
                end
            end)

            --Play a "random" sound.
            local Sound = Instance.new("Sound")
            Sound.SoundId = RandomAnimation.SoundId
            Sound.Parent = Sword
            Sound:Play()
            delay(2,function()
                Sound:Destroy()
            end)

            --Clear the touch event.
            wait(0.7)
            TouchEvent:Disconnect()
        end
    end
end



return SwordAttack