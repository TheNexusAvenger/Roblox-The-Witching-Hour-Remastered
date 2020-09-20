--[[
TheNexusAvenger

Awards badges for completing achievements.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BadgeService = game:GetService("BadgeService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local EnvironmentConfiguration = ReplicatedStorageProject:GetResource("EnvironmentConfiguration")

local AchievementService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject"):Extend()
AchievementService:SetClassName("AchievementService")
AchievementService.CachedAwardedAchievements = {}
ServerScriptServiceProject:SetContextResource(AchievementService)



--[[
Returns if the player owns a badge.
--]]
function AchievementService:PlayerOwnsBadge(Player,BadgeId)
    local BadgeOwned = false
    xpcall(function()
        BadgeOwned = BadgeService:UserHasBadgeAsync(Player.UserId,BadgeId)
    end,function(ErrorMessage)
        warn("Failed to determine badge ownership of "..tostring(Player.Name).." for "..tostring(BadgeId).." because "..tostring(ErrorMessage))
    end)
    return BadgeOwned
end
--[[
Awards an achievement for a player.
--]]
function AchievementService:AwardAchievement(Player,AchievementName)
    --Return if the achievement was given.
    if not self.CachedAwardedAchievements[Player.UserId] then
        self.CachedAwardedAchievements[Player.UserId] = {}
    end
    if self.CachedAwardedAchievements[Player.UserId][AchievementName] then
        return
    end
    self.CachedAwardedAchievements[Player.UserId][AchievementName] = true

    coroutine.wrap(function()
        --Award the badge if it hasn't been awarded before.
        local BadgeId = EnvironmentConfiguration.Badges[AchievementName]
        if not self:PlayerOwnsBadge(Player,BadgeId) then
            xpcall(function()
                BadgeService:AwardBadge(Player.UserId,BadgeId)
            end,function(ErrorMessage)
                warn("Failed to award badge "..tostring(AchievementName).." ("..tostring(BadgeId)..")  for"..tostring(Player.Name).." because "..tostring(ErrorMessage))
            end)
        end

        --Award the Bloxhilda's Revenge achievement.
        if AchievementName == "ThePortal" and self:PlayerOwnsBadge(Player,134237042) then
            self:AwardAchievement(Player,"BloxhildasRevenge")
        end
    end)()
end



return AchievementService