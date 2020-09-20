--[[
TheNexusAvenger

Sets up Bloxhilda.
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")



return function(BloxhildaModel,DungeonPlayers)
    --Set up the health.
    local Dungeon = BloxhildaModel.Parent
    local DungeonGround = Dungeon:WaitForChild("Ground")
    local Humanoid,HumanoidRootPart = BloxhildaModel:WaitForChild("Humanoid"),BloxhildaModel:WaitForChild("HumanoidRootPart")
    Humanoid.MaxHealth = 2000
    Humanoid.Health = 2000

    --Play the idle animation.
    local IdleAnimation = Instance.new("Animation")
    IdleAnimation.AnimationId = "rbxassetid://507766388"
    local IdleTrack = Humanoid:LoadAnimation(IdleAnimation)
    IdleTrack:Play()

    IdleTrack.Stopped:Connect(function()
        IdleTrack:Play()
    end)

    --Set up the attacks.
    coroutine.wrap(function()
        while Humanoid.Health > 0 and Dungeon.Parent do
            --Wait to perform a new attack.
            wait(3)

            --Determine the distance to the closest player.
            local ClosestPlayerDistance,ClosestHumnaoidRootPart = math.huge,nil
            for _,Player in pairs(DungeonPlayers) do
                local Character = Player.Character
                if Character then
                    local CharacterHumanoid = Character:FindFirstChild("Humanoid")
                    local CharacterHumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if CharacterHumanoid and CharacterHumanoid.Health > 0 and CharacterHumanoidRootPart then
                        local Distance = (Vector2.new(HumanoidRootPart.Position.X,HumanoidRootPart.Position.Z) - Vector2.new(CharacterHumanoidRootPart.Position.X,CharacterHumanoidRootPart.Position.Z)).Magnitude
                        if Distance < ClosestPlayerDistance then
                            ClosestPlayerDistance = Distance
                            ClosestHumnaoidRootPart = CharacterHumanoidRootPart
                        end
                    end
                end
            end

            if ClosestHumnaoidRootPart and ClosestPlayerDistance < 300 then
                --Perform an attack.
                if ClosestPlayerDistance > 50 then
                    --Performs a ranged attack.
                    local PumpkinProjectile = Instance.new("Part")
                    PumpkinProjectile.Size = Vector3.new(1,1,1)
                    PumpkinProjectile.CFrame = HumanoidRootPart.CFrame
                    PumpkinProjectile.CanCollide = false
                    PumpkinProjectile.Parent = BloxhildaModel
                    
                    local Mesh = Instance.new("SpecialMesh")
                    Mesh.MeshType = Enum.MeshType.FileMesh
                    Mesh.Scale = Vector3.new(2,2,2)
                    Mesh.TextureId = "rbxassetid://37606814"
                    Mesh.MeshId = "rbxassetid://37223787"
                    Mesh.Parent = PumpkinProjectile

                    local BodyVelocity = Instance.new("BodyVelocity")
                    BodyVelocity.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
                    BodyVelocity.Velocity = CFrame.new(HumanoidRootPart.CFrame.Position,ClosestHumnaoidRootPart.Position).LookVector * 200
                    BodyVelocity.Parent = PumpkinProjectile

                    --Set up setting damaging players.
                    PumpkinProjectile.Touched:Connect(function(TouchPart)
                        local Character = TouchPart.Parent
                        if Character and Players:GetPlayerFromCharacter(Character) then
                            local CharacterHumanoid = Character:FindFirstChild("Humanoid")
                            if CharacterHumanoid then
                                CharacterHumanoid:TakeDamage(10)
                                PumpkinProjectile:Destroy()
                            end
                        end
                    end)

                    --Destroy the projectile.
                    delay(3,function()
                        PumpkinProjectile:Destroy()
                    end)
                elseif ClosestPlayerDistance < 10 then
                    --Display the animation.
                    local KnockbackPart = Instance.new("Part")
                    KnockbackPart.Transparency = 0.25
                    KnockbackPart.Material = Enum.Material.Neon
                    KnockbackPart.BrickColor = BrickColor.new("Bright blue")
                    KnockbackPart.Anchored = true
                    KnockbackPart.CanCollide = false
                    KnockbackPart.Size = Vector3.new(1,1,1)
                    KnockbackPart.CFrame = HumanoidRootPart.CFrame
                    KnockbackPart.Shape = Enum.PartType.Ball
                    KnockbackPart.Parent = BloxhildaModel
                    
                    TweenService:Create(KnockbackPart,TweenInfo.new(1),{
                        Size = Vector3.new(20,20,20),
                        Transparency = 1,
                    }):Play()
                    delay(1,function()
                        KnockbackPart:Destroy()
                    end)

                    --Knock back the players.
                    for _,Player in pairs(DungeonPlayers) do
                        local Character = Player.Character
                        if Character then
                            local CharacterHumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                            if CharacterHumanoidRootPart then
                                local BodyVelocity = Instance.new("BodyVelocity")
                                BodyVelocity.MaxForce = Vector3.new(math.huge,0,math.huge)
                                BodyVelocity.Velocity = CFrame.new(HumanoidRootPart.Position,CharacterHumanoidRootPart.Position).LookVector * 100
                                BodyVelocity.Parent = CharacterHumanoidRootPart
                                delay(0.5,function()
                                    BodyVelocity:Destroy()
                                end)
                            end
                        end
                    end
                else
                    --Determine the spike locations.
                    local SpikeLocations = {}
                    local SpikeCenter = CFrame.new(HumanoidRootPart.CFrame.Position,ClosestHumnaoidRootPart.Position)
                    if math.random() > 0.5 then
                        --Create a ring of spikes.
                        for Angle = math.rad(20),math.pi * 2,math.rad(20) do
                            table.insert(SpikeLocations,(SpikeCenter * CFrame.Angles(0,Angle,0) * CFrame.new(0,0,ClosestPlayerDistance)).Position)
                        end
                    else
                        --Create 6 lines of spikes.
                        for Angle = math.pi * (1/3),math.pi * 2,math.pi * (1/3) do
                            for i = 1,10 do
                                table.insert(SpikeLocations,(SpikeCenter * CFrame.Angles(0,Angle,0) * CFrame.new(0,0,i * 11)).Position)
                            end
                        end
                    end

                    --Create the spikes.
                    local YPosition = DungeonGround.Position.Y + (DungeonGround.Size.Y/2)
                    for _,Position in pairs(SpikeLocations) do
                        --Create the warning part.
                        local WarningPart = Instance.new("Part")
                        WarningPart.Transparency = 0.25
                        WarningPart.Material = Enum.Material.Neon
                        WarningPart.BrickColor = BrickColor.new("Bright red")
                        WarningPart.Anchored = true
                        WarningPart.CanCollide = false
                        WarningPart.Size = Vector3.new(0.2,10,10)
                        WarningPart.CFrame = CFrame.new(Position.X,YPosition,Position.Z) * CFrame.Angles(0,0,math.pi/2)
                        WarningPart.Shape = Enum.PartType.Cylinder
                        WarningPart.Parent = BloxhildaModel

                        delay(1,function()
                            --Create the spike.
                            local Spike = Instance.new("Part")
                            Spike.Anchored = true
                            Spike.Size = Vector3.new(4,6,4)
                            Spike.CFrame = CFrame.new(Position.X,YPosition - 3,Position.Z)
                            Spike.Parent = BloxhildaModel

                            local SpikeMesh = Instance.new("SpecialMesh")
                            SpikeMesh.MeshId    = "rbxassetid://1033714"
                            SpikeMesh.TextureId = "rbxassetid://39251676"
                            SpikeMesh.Scale = Vector3.new(2,8,2)
                            SpikeMesh.Parent = Spike

                            local CharactersHit = {}
                            Spike.Touched:Connect(function(TouchPart)
                                local Character = TouchPart.Parent
                                if Character and Players:GetPlayerFromCharacter(Character) then
                                    local CharacterHumanoid = Character:FindFirstChild("Humanoid")
                                    local CharacterHumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                                    if CharacterHumanoid and CharacterHumanoidRootPart and not CharactersHit[CharacterHumanoid] then
                                        CharactersHit[CharacterHumanoid] = true

                                        --Damage the player.
                                        CharacterHumanoid:TakeDamage(10)

                                        --Launch the player into the air.
                                        local BodyVelocity = Instance.new("BodyVelocity")
                                        BodyVelocity.MaxForce = Vector3.new(0,math.huge,0)
                                        BodyVelocity.Velocity = Vector3.new(0,200,0)
                                        BodyVelocity.Parent = CharacterHumanoidRootPart
                                        delay(0.25,function()
                                            BodyVelocity:Destroy()
                                        end)
                                    end
                                end
                            end)

                            --Move the spike.
                            TweenService:Create(Spike,TweenInfo.new(0.2),{
                                CFrame = CFrame.new(Position.X,YPosition + 3,Position.Z)
                            }):Play()

                            --Clear the spike.
                            delay(0.25,function()
                                WarningPart:Destroy()
                                Spike:Destroy()
                            end)
                        end)
                    end
                end
            end
        end
    end)()
end