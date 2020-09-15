--[[
TheNexusAvenger

Attack for a pumpkin.
Class is static (should not be created).
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local PumpkinAttack = NexusObject:Extend()
PumpkinAttack:SetClassName("PumpkinAttack")



--[[
Performs the attack on the server.
--]]
function PumpkinAttack.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if Humanoid and Humanoid.Health > 0 then
            --Create the projectile.
            local PumpkinProjectile = Instance.new("Part")
            PumpkinProjectile.Size = Vector3.new(1,1,1)
            PumpkinProjectile.CFrame = HumanoidRootPart.CFrame
            PumpkinProjectile.CanCollide = false
            PumpkinProjectile.Parent = DungeonModel
            
            local Mesh = Instance.new("SpecialMesh")
            Mesh.MeshType = Enum.MeshType.FileMesh
            Mesh.Scale = Vector3.new(2,2,2)
            Mesh.TextureId = "rbxassetid://37606814"
            Mesh.MeshId = "rbxassetid://37223787"
            Mesh.Parent = PumpkinProjectile

            local Fire = Instance.new("Fire")
            Fire.Parent = PumpkinProjectile

            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            BodyVelocity.Velocity = CFrame.new(HumanoidRootPart.CFrame.Position,Target).LookVector * 500
            BodyVelocity.Parent = PumpkinProjectile

            --Set up setting enemies on fire.
            PumpkinProjectile.Touched:Connect(function(TouchPart)
                local MonsterCharacter = TouchPart.Parent
                if MonsterCharacter and MonsterCharacter:IsDescendantOf(DungeonModel) then
                    local MonsterHumanoid = MonsterCharacter:FindFirstChild("Humanoid")
                    local Head = MonsterCharacter:FindFirstChild("Head")
                    if MonsterHumanoid then
                        --Destroy the projectile.
                        Fire.Parent = Head
                        PumpkinProjectile:Destroy()

                        --Start damaging the monster.
                        MonsterHumanoid:TakeDamage(20)
                        for i = 1,24 do
                            MonsterHumanoid:TakeDamage(3)
                            wait(0.125)
                        end
                        Fire:Destroy()
                    end
                end
            end)


            --Clear the projectile.
            delay(3,function()
                PumpkinProjectile:Destroy()
            end)
        end
    end
end



return PumpkinAttack