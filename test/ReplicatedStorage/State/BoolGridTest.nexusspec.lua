--[[
TheNexusAvenger

Tests the BoolGrid class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local BoolGrid = ReplicatedStorageProject:GetResource("State.BoolGrid")



--[[
Setups up the test.
--]]
local BoolGridTest = NexusUnitTesting.UnitTest:Extend()
function BoolGridTest:Setup()
    --Create the component under testing.
    self.CuT = BoolGrid.new(5,5)
end

--[[
Tests loading a grid from a string.
--]]
NexusUnitTesting:RegisterUnitTest(BoolGridTest.new("TestLoadingGrid"):SetRun(function(self)
    --Load the grid data.
    self.CuT:LoadFromString(HttpService:JSONEncode({
        {true,5},
        {false,5},
        {true,3,2},
        {true,1,1,1,1,1},
        {false,2,1,2}
    }))

    --Assert the grid is connect.
    self:AssertEquals(HttpService:JSONEncode({{true,true,true,true,true},{false,false,false,false,false},{true,true,true,false,false},{true,false,true,false,true},{false,false,true,false,false}}),HttpService:JSONEncode(self.CuT.Grid),"Grid is incorrect.")
end))

--[[
Tests serializing the grid.
--]]
NexusUnitTesting:RegisterUnitTest(BoolGridTest.new("TestSerialize"):SetRun(function(self)
    --Load the grid data.
    self.CuT:LoadFromString(HttpService:JSONEncode({
        {true,5},
        {false,5},
        {true,3,2},
        {true,1,1,1,1,1},
        {false,2,1,2}
    }))

    --Assert the data is correct.
    self:AssertEquals(HttpService:JSONEncode({
        {true,5},
        {false,5},
        {true,3,2},
        {true,1,1,1,1,1},
        {false,2,1,2}
    }),self.CuT:Serialize(),"Data is incorrect.")

    --Assert multiple values are valid and set values.
    self:AssertEquals(self.CuT:GetValue(-1,1),false,"Out of range value is invalid.")
    self:AssertEquals(self.CuT:GetValue(1,-1),false,"Out of range value is invalid.")
    self:AssertEquals(self.CuT:GetValue(1,6),false,"Out of range value is invalid.")
    self:AssertEquals(self.CuT:GetValue(1,6),false,"Out of range value is invalid.")
    self:AssertEquals(self.CuT:GetValue(1,1),true,"Value is invalid.")
    self:AssertEquals(self.CuT:GetValue(2,3),false,"Value is invalid.")
    self:AssertEquals(self.CuT:GetValue(3,2),true,"Value is invalid.")
    self.CuT:SetValue(1,3,false)
    self.CuT:SetValue(5,3,false)

    --Assert the new data is correct.
    self:AssertEquals(HttpService:JSONEncode({
        {true,2,1,2},
        {false,5},
        {true,3,2},
        {true,1,1,1,1,1},
        {false,5}
    }),self.CuT:Serialize(),"Data is incorrect.")
end))



return true