--[[
TheNexusAvenger

Attack for a death ball.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local DeathBallAttack = NexusObject:Extend()
DeathBallAttack:SetClassName("DeathBallAttack")



--[[
Performs the attack on the server.
--]]
function DeathBallAttack.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if Humanoid and Humanoid.Health > 0 then
            --Create the projectile.
            local DeathBallProjectile = Instance.new("Part")
            DeathBallProjectile.Transparency = 0.5
            DeathBallProjectile.BrickColor = BrickColor.new("Instutional white")
            DeathBallProjectile.Size = Vector3.new(1.6,1.6,1.6)
            DeathBallProjectile.Shape = Enum.PartType.Ball
            DeathBallProjectile.CFrame = HumanoidRootPart.CFrame
            DeathBallProjectile.CanCollide = false
            DeathBallProjectile.Parent = DungeonModel

            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            BodyVelocity.Velocity = CFrame.new(HumanoidRootPart.CFrame.Position,Target).LookVector * 200
            BodyVelocity.Parent = DeathBallProjectile

            --Set up killing the monster.
            local TouchEvent
            TouchEvent = DeathBallProjectile.Touched:Connect(function(TouchPart)
                local MonsterCharacter = TouchPart.Parent
                if MonsterCharacter and MonsterCharacter:IsDescendantOf(DungeonModel) then
                    local MonsterHumanoid = MonsterCharacter:FindFirstChild("Humanoid")
                    if MonsterHumanoid then
                        if MonsterCharacter.Name == "Bloxhilda" then
                            --Reflect the attack to make Bloxhilda not easy.
                            TouchEvent:Disconnect()
                            DeathBallProjectile.CFrame = TouchPart.CFrame
                            BodyVelocity.Velocity = CFrame.new(TouchPart.Position,HumanoidRootPart.CFrame.Position).LookVector * 200

                            --Connect killing the player.
                            DeathBallProjectile.Touched:Connect(function(NewTouchPart)
                                if NewTouchPart.Parent == Character then
                                    Humanoid:TakeDamage(Humanoid.Health)
                                    DeathBallProjectile:Destroy()
                                end
                            end)
                        else
                            --Kill the monster.
                            MonsterHumanoid:TakeDamage(MonsterHumanoid.Health)
                            DeathBallProjectile:Destroy()
                        end
                    end
                end
            end)

            --Clear the projectile.
            delay(3,function()
                DeathBallProjectile:Destroy()
            end)
        end
    end
end



return DeathBallAttack