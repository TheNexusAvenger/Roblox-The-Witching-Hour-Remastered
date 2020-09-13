--[[
TheNexusAvenger

Setup script for a base monster.
--]]

local Players = game:GetService("Players")



return function(MonsterModel,DungeonPlayers,Parameters)
    --Create a map of the players for simpler checking.
    local DungeonPlayersMap = {}
    for _,Player in pairs(DungeonPlayers) do
        DungeonPlayersMap[Player] = true
    end

    --Set up the health.
    local Humanoid,HumanoidRootPart = MonsterModel:WaitForChild("Humanoid"),MonsterModel:WaitForChild("HumanoidRootPart")
    Humanoid.MaxHealth = Parameters.Health or 100
    Humanoid.Health = Parameters.Health or 100

    --Set up following.
    coroutine.wrap(function()
        while MonsterModel.Parent and Humanoid.Health > 0 do
            --Determine the closest character.
            local ClosestDistance,ClosestPosition = math.huge,nil
            for _,Player in pairs(DungeonPlayers) do
                local Character = Player.Character
                if Character then
                    local CharacterHumanoid,CharacterHumanoidRootPart = Character:FindFirstChild("Humanoid"),Character:FindFirstChild("HumanoidRootPart")
                    if CharacterHumanoid and CharacterHumanoid.Health > 0 and CharacterHumanoidRootPart then
                        local DistanceTo = (CharacterHumanoidRootPart.Position - HumanoidRootPart.Position).magnitude
                        if DistanceTo < ClosestDistance  then
                            ClosestDistance = DistanceTo
                            ClosestPosition = CharacterHumanoidRootPart.Position
                        end
                    end
                end
            end

            --Move to the closest character.
            if ClosestPosition then
                Humanoid:MoveTo(ClosestPosition)
            end

            wait()
        end
    end)()

    --Set up the animations.
    local WalkAnimation = Instance.new("Animation")
    WalkAnimation.AnimationId = "rbxassetid://161210451"
    local WalkTrack = Humanoid:LoadAnimation(WalkAnimation)
    
    local IdleAnimation = Instance.new("Animation")
    IdleAnimation.AnimationId = "rbxassetid://180435571"
    local IdleTrack = Humanoid:LoadAnimation(IdleAnimation)
    IdleTrack:Play()

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
    Humanoid.Running:Connect(function(Ratio)
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

    --Set up damaging.
    local LastTouch = 0
    for _,DamagePart in pairs(Parameters.DamageParts or {}) do
        DamagePart.Touched:Connect(function(TouchPart)
            if tick() - LastTouch >= (Parameters.DamageCooldown or 2) then
                local Character = TouchPart.Parent
                if Character then
                    local Player = Players:GetPlayerFromCharacter(Character)
                    if Player and DungeonPlayersMap[Player] then
                        local CharacterHumanoid = Character:FindFirstChild("Humanoid")
                        if CharacterHumanoid and CharacterHumanoid.Health > 0 then
                            LastTouch = tick()
                            CharacterHumanoid:TakeDamage(math.random(Parameters.MinDamage or 1,Parameters.MaxDamage or 10))
                        end
                    end
                end
            end
        end)
    end
end