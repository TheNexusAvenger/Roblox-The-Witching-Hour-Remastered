--[[
TheNexusAvenger

Sets up a humanoid monster.
--]]

local BaseMonsterSetupFunction = require(script.Parent:WaitForChild("BaseMonster"))



return function(MonsterModel,DungeonPlayers)
    BaseMonsterSetupFunction(MonsterModel,DungeonPlayers,{
        Health = 200,
        MinDamage = 7,
        MaxDamage = 12,
        DamageCooldown = 4,
        DamageParts = {MonsterModel:WaitForChild("Left Arm"),MonsterModel:WaitForChild("Right Arm")},
    })
end