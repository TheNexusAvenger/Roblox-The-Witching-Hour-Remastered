--[[
TheNexusAvenger

Calculates levels fo rplayers.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusInstance = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance")
local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData")

local Levels = NexusInstance:Extend()
Levels.CachedLevels = {}
setmetatable(Levels.CachedLevels,{__mode="k"})
Levels:SetClassName("Levels")



--[[
Creates a levels object.
--]]
function Levels:__new(Player)
    self:InitializeSuper()

    --Store the state.
    self.PlayerData = PlayerData.GetPlayerData(Player)
    self.TotalExperience = self.PlayerData:GetValue("XP")
    self:UpdateLevel()

    --Connect the inventory changing.
    self.PlayerData:GetValueChangedSignal("XP"):Connect(function()
        self.TotalExperience = self.PlayerData:GetValue("XP")
        self:UpdateLevel()
    end)
end

--[[
Returns an levels object for a
given player.
--]]
function Levels.GetLevels(Player)
    --Create the cached object if it doesn't exist.
    if not Levels.CachedLevels[Player] then
        Levels.CachedLevels[Player] = Levels.new(Player)
    end

    --Return the cached object.
    return Levels.CachedLevels[Player]
end

--[[
Updates the level for the total XP.
--]]
function Levels:UpdateLevel()
    --Update the level and current level expereince.
    --Current implementation requires level * 100 experience per level.
    self.Level = math.floor(((-1 + math.sqrt((8 * (self.TotalExperience / 100) + 1)))/2) + 1)
    if self.Level == 1 then
        self.PreviousLevelExperience = 0
        self.NextLevelExperience = 100
    elseif self.Level == 2 then
        self.PreviousLevelExperience = 100
        self.NextLevelExperience = 300
    else
        self.PreviousLevelExperience = (0.5 * (self.Level - 1) * self.Level) * 100
        self.NextLevelExperience = (0.5 * self.Level * (self.Level + 1)) * 100
    end
end



return Levels