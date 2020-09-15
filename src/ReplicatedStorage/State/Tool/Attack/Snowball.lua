--[[
TheNexusAvenger

Attack for a snowball.
The details of this attack are not known because
of the lack of reference material.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local SnowballAttack = NexusObject:Extend()
SnowballAttack:SetClassName("SnowballAttack")



--[[
Performs the attack on the server.
--]]
function SnowballAttack.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if Humanoid and Humanoid.Health > 0 then
            --Create the projectile.
            local SnowballProjectile = Instance.new("Part")
            SnowballProjectile.BrickColor = BrickColor.new("Institutational white")
            SnowballProjectile.Material = Enum.Material.Sand
            SnowballProjectile.Size = Vector3.new(1,1,1)
            SnowballProjectile.CFrame = HumanoidRootPart.CFrame
            SnowballProjectile.CanCollide = false
            SnowballProjectile.Shape = Enum.PartType.Ball
            SnowballProjectile.Parent = DungeonModel
            
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            BodyVelocity.Velocity = CFrame.new(HumanoidRootPart.CFrame.Position,Target).LookVector * 500
            BodyVelocity.Parent = SnowballProjectile

            --Set up setting freezing enemies.
            SnowballProjectile.Touched:Connect(function(TouchPart)
                local MonsterCharacter = TouchPart.Parent
                if MonsterCharacter and MonsterCharacter:IsDescendantOf(DungeonModel) then
                    local Head = MonsterCharacter:FindFirstChild("Head")
                    if Head and not Head.Anchored then
                        --Anchor the monster.
                        for _,Part in pairs(MonsterCharacter:GetDescendants()) do
                            if Part:IsA("BasePart") then
                                Part.Reflectance = Part.Reflectance + 0.5
                                Part.Anchored = true
                            end
                        end

                        --Unanchor the monster.
                        wait(5)
                        for _,Part in pairs(MonsterCharacter:GetDescendants()) do
                            if Part:IsA("BasePart") then
                                Part.Reflectance = Part.Reflectance - 0.5
                                Part.Anchored = false
                            end
                        end
                    end
                end
            end)

            --Clear the projectile.
            delay(3,function()
                SnowballProjectile:Destroy()
            end)
        end
    end
end



return SnowballAttack