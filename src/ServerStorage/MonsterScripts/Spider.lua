--[[
TheNexusAvenger

Sets up a spider monster.
--]]

local LUNGE_ANIMATION_MIN_COOLDOWN = 6
local LUNGE_ANIMATION_MAX_COOLDOWN = 10

local BaseMonsterSetupFunction = require(script.Parent:WaitForChild("BaseMonster"))



return function(MonsterModel,DungeonPlayers)
    --Set up the base monster.
    BaseMonsterSetupFunction(MonsterModel,DungeonPlayers,{
        Health = 1300,
        MinDamage = 5,
        MaxDamage = 10,
        DamageCooldown = 5,
        DamageParts = {MonsterModel:WaitForChild("Torso")},
    })

    --Set up the lunge attack.
    local Humanoid,HumanoidRootPart = MonsterModel:WaitForChild("Humanoid"),MonsterModel:WaitForChild("HumanoidRootPart")
    coroutine.wrap(function()
        while MonsterModel.Parent and Humanoid.Health > 0 do
            wait(math.random(LUNGE_ANIMATION_MIN_COOLDOWN,LUNGE_ANIMATION_MAX_COOLDOWN))

            --Change the color of the eyes.
            for _,Part in pairs(MonsterModel:GetChildren()) do
                if Part:IsA("BasePart") and Part.Name == "Eye" then
                    Part.BrickColor = BrickColor.new("Bright red")
                    delay(0.5,function()
                        Part.BrickColor = BrickColor.new("Bright yellow")
                    end)
                end
            end

            --Run the lunge attack.
            HumanoidRootPart.Velocity = (HumanoidRootPart.CFrame.lookVector * 200) + Vector3.new(0,50,0)
        end
    end)()
end