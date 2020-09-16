--[[
TheNexusAvenger

Attack for a bomb.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local BombAttack = NexusObject:Extend()
BombAttack:SetClassName("BombAttack")



--[[
Performs the attack on the server.
--]]
function BombAttack.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if Humanoid and Humanoid.Health > 0 and HumanoidRootPart then
            --Create the bomb.
            local PumpkinBomb = Instance.new("Part")
            PumpkinBomb.Size = Vector3.new(1,1,1)
            PumpkinBomb.CFrame = HumanoidRootPart.CFrame * CFrame.new(0,0,-2)
            PumpkinBomb.Parent = DungeonModel
            
            local Mesh = Instance.new("SpecialMesh")
            Mesh.MeshType = Enum.MeshType.FileMesh
            Mesh.Scale = Vector3.new(2,2,2)
            Mesh.TextureId = "rbxassetid://37606814"
            Mesh.MeshId = "rbxassetid://37223787"
            Mesh.Parent = PumpkinBomb

            local Fire = Instance.new("Fire")
            Fire.Parent = PumpkinBomb

            --Connect exploding the bomb.
            local DB = true
            PumpkinBomb.Touched:Connect(function(TouchPart)
                local MonsterCharacter = TouchPart.Parent
                if DB and MonsterCharacter and MonsterCharacter:IsDescendantOf(DungeonModel) then
                    local MonsterHumanoid = MonsterCharacter:FindFirstChild("Humanoid")
                    if MonsterHumanoid and MonsterHumanoid.Health > 0 then
                        DB = false

                        --Explode the bomb.
                        PumpkinBomb:Destroy()
                        local Explosion = Instance.new("Explosion")
                        Explosion.BlastRadius = 5
                        Explosion.BlastPressure = 0
                        Explosion.DestroyJointRadiusPercent = 0
                        Explosion.Position = PumpkinBomb.Position
                        local HitMonsters = {}
                        Explosion.Hit:Connect(function(HitPart,Radius)
                            local HitMonsterCharacter = HitPart.Parent
                            if HitMonsterCharacter and HitMonsterCharacter:IsDescendantOf(DungeonModel) then
                                local HitMonsterHumanoid = HitMonsterCharacter:FindFirstChild("Humanoid")
                                if HitMonsterHumanoid and not HitMonsters[HitMonsterHumanoid] then
                                    HitMonsters[HitMonsterHumanoid] = true
                                    HitMonsterHumanoid:TakeDamage((Radius/5) * 100)
                                end
                            end
                        end)
                        Explosion.Parent = DungeonModel
                    end
                end
            end)
        end
    end
end



return BombAttack