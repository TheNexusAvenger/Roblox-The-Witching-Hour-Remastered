--[[
TheNexusAvenger

Attack for a spider web.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local SpiderWebAttack = NexusObject:Extend()
SpiderWebAttack:SetClassName("SpiderWebAttack")



--[[
Performs the attack on the server.
--]]
function SpiderWebAttack.PerformServerAttack(Player,DungeonModel,Target)
    local Character = Player.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if Humanoid and Humanoid.Health > 0 and HumanoidRootPart then
            --Create the web.
            local Ground = DungeonModel:WaitForChild("Ground")
            local SpiderWebPart = Instance.new("Part")
            SpiderWebPart.BrickColor = BrickColor.new("Institutional white")
            SpiderWebPart.Anchored = true
            SpiderWebPart.Size = Vector3.new(8,0.2,8)
            SpiderWebPart.CFrame = CFrame.new(HumanoidRootPart.CFrame.X,Ground.CFrame.Y + (Ground.Size.Y/2) + 0.1,HumanoidRootPart.CFrame.Z)
            SpiderWebPart.Parent = DungeonModel
            
            local SpiderWebMesh = Instance.new("SpecialMesh")
            SpiderWebMesh.MeshType = Enum.MeshType.FileMesh
            SpiderWebMesh.Scale = Vector3.new(0.00125,0.00125,0.00125)
            SpiderWebMesh.MeshId = "rbxassetid://519097994"
            SpiderWebMesh.Parent = SpiderWebPart

            --Connect exploding the bomb.
            local HitMonsters = {}
            local DestroyWebStarted = false
            SpiderWebPart.Touched:Connect(function(TouchPart)
                local MonsterCharacter = TouchPart.Parent
                if MonsterCharacter and MonsterCharacter:IsDescendantOf(DungeonModel) then
                    local MonsterHumanoid = MonsterCharacter:FindFirstChild("Humanoid")
                    if MonsterHumanoid and MonsterHumanoid.Health > 0 and not HitMonsters[MonsterHumanoid] then
                        --Stop the monster.
                        HitMonsters[MonsterHumanoid] = true
                        MonsterHumanoid.WalkSpeed = 0

                        --Destroy the web if it wasn't started already.
                        if not DestroyWebStarted then
                            DestroyWebStarted = true
                            wait(5)
                            for HitMonsterHumanoid,_ in pairs(HitMonsters) do
                                HitMonsterHumanoid.WalkSpeed = 16
                            end
                            SpiderWebPart:Destroy()
                        end
                    end
                end
            end)
        end
    end
end



return SpiderWebAttack