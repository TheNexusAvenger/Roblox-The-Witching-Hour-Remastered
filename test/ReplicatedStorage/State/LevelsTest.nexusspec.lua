--[[
TheNexusAvenger

Tests the Levels class.
--]]

local XP_MULTIPLIER = 80



local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local Levels = ReplicatedStorageProject:GetResource("State.Levels")



--[[
Setups up the test.
--]]
local InventoryTest = NexusUnitTesting.UnitTest:Extend()
function InventoryTest:Setup()
    --Create the mock player.
    local MockPlayer = Instance.new("Folder")
    local PlayerData = Instance.new("Folder")
    PlayerData.Name = "PlayerData"
    PlayerData.Parent = MockPlayer
    local XPValue = Instance.new("IntValue")
    XPValue.Name = "XP"
    XPValue.Value = 0
    XPValue.Parent = PlayerData
    self.XPValue = XPValue

    --Create the components under testing.
    self.CuT = Levels.new(MockPlayer)
end

--[[
Tests setting the level.
--]]
NexusUnitTesting:RegisterUnitTest(InventoryTest.new("TestSettingXP"):SetRun(function(self)
    --Assert the intial level is valid.
    self:AssertEquals(self.CuT.Level,1,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,0,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,XP_MULTIPLIER,"Next level XP is invalid.")

    --Asset high levels are valid.
    self.XPValue.Value = 0.5 * XP_MULTIPLIER
    self:AssertEquals(self.CuT.Level,1,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,0,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,1 * XP_MULTIPLIER,"Next level XP is invalid.")
    self.XPValue.Value = 1 * XP_MULTIPLIER
    self:AssertEquals(self.CuT.Level,2,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,1 * XP_MULTIPLIER,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,3 * XP_MULTIPLIER,"Next level XP is invalid.")
    self.XPValue.Value = 2 * XP_MULTIPLIER
    self:AssertEquals(self.CuT.Level,2,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,1 * XP_MULTIPLIER,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,3 * XP_MULTIPLIER,"Next level XP is invalid.")
    self.XPValue.Value = 3 * XP_MULTIPLIER
    self:AssertEquals(self.CuT.Level,3,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,3 * XP_MULTIPLIER,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,6 * XP_MULTIPLIER,"Next level XP is invalid.")
    self.XPValue.Value = 6 * XP_MULTIPLIER
    self:AssertEquals(self.CuT.Level,4,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,6 * XP_MULTIPLIER,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,10 * XP_MULTIPLIER,"Next level XP is invalid.")
    self.XPValue.Value = 10 * XP_MULTIPLIER
    self:AssertEquals(self.CuT.Level,5,"Level is invalid.")
    self:AssertEquals(self.CuT.PreviousLevelExperience,10 * XP_MULTIPLIER,"Current level XP is invalid.")
    self:AssertEquals(self.CuT.NextLevelExperience,15 * XP_MULTIPLIER,"Next level XP is invalid.")
end))



return true