--[[
TheNexusAvenger

Sets up a wolf monster.
--]]

local BaseMonsterSetupFunction = require(script.Parent:WaitForChild("BaseMonster"))



return function(MonsterModel,DungeonPlayers)
    BaseMonsterSetupFunction(MonsterModel,DungeonPlayers,{
        Health = 320,
        MinDamage = 10,
        MaxDamage = 25,
        DamageCooldown = 6,
        DamageParts = {MonsterModel:WaitForChild("Head"),MonsterModel:WaitForChild("Torso")},
    })
end