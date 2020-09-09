--[[
TheNexusAvenger

Tests the DungeonAllocation class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local DungeonAllocation = ReplicatedStorageProject:GetResource("State.DungeonAllocation")



--[[
Setups up the test.
--]]
local DungeonAllocationTest = NexusUnitTesting.UnitTest:Extend()
function DungeonAllocationTest:Setup()
    --Create the component under testing.
    self.CuT = DungeonAllocation.new()
end

--[[
Tests allocating and deallocating.
--]]
NexusUnitTesting:RegisterUnitTest(DungeonAllocationTest.new("TestAllocate"):SetRun(function(self)
    self:AssertEquals({self.CuT:Allocate(5,5)},{1,"5_5_1"},"Allocation is incorrect.")
    self:AssertEquals({self.CuT:Allocate(5,5)},{2,"5_5_2"},"Allocation is incorrect.")
    self:AssertEquals({self.CuT:Allocate(4,4)},{3,"4_4_3"},"Allocation is incorrect.")
    self:AssertEquals({self.CuT:Allocate(6,5)},{3,"6_5_3"},"Allocation is incorrect.")
    self:AssertEquals({self.CuT:Allocate(5,5)},{4,"5_5_4"},"Allocation is incorrect.")
    self.CuT:Deallocate("5_5_2")
    self:AssertEquals({self.CuT:Allocate(5,5)},{2,"5_5_2"},"Allocation is incorrect.")
    self.CuT:Deallocate("6_5_3")
    self:AssertEquals({self.CuT:Allocate(5,5)},{5,"5_5_5"},"Allocation is incorrect.")
    self.CuT:Deallocate("4_4_3")
    self:AssertEquals({self.CuT:Allocate(5,5)},{3,"5_5_3"},"Allocation is incorrect.")
end))



return true