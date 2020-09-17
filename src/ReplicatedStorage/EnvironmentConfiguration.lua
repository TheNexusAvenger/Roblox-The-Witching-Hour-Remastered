--[[
TheNexusAvenger

Environment-specific variables depending on
where it is uploaded.

The animations only work in Nexus Development's place because animations only work for the owner.
If animations become free, this will solve this problem.
https://devforum.roblox.com/t/public-animations/43299
--]]

if game.PlaceId == 5674151342 then
    --Nexus Development Quality Assurance test
    return {
        --Custom animations used in the game.
        Animations = {
            SwordAttack = "rbxassetid://2960989171",
            SwordLunge = "rbxassetid://2960989618",
            SwordOverhead = "rbxassetid://2960990006",
        },
    }
else
    --Nexus Development release (default)
    return {
        --Custom animations used in the game.
        Animations = {
            SwordAttack = "rbxassetid://2016260994",
            SwordLunge = "rbxassetid://2016262978",
            SwordOverhead = "rbxassetid://2016256809",
        },
    }
end