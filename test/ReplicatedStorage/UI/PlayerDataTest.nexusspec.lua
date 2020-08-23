--[[
TheNexusAvenger

Tests the PlayerData class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local PlayerData = ReplicatedStorageProject:GetResource("UI.PlayerData")



--[[
Setups up the test.
--]]
local PlayerDataTest = NexusUnitTesting.UnitTest:Extend()
function PlayerDataTest:Setup()
    --Create the component under testing.
    self.MockPlayer = Instance.new("Folder")
    self.Folder = Instance.new("Folder")
    self.Folder.Name = "PlayerData"
    self.Folder.Parent = self.MockPlayer
    self.CuT = PlayerData.GetPlayerData(self.MockPlayer)
end

--[[
Tests initializing from data.
--]]
NexusUnitTesting:RegisterUnitTest(PlayerDataTest.new("TestInitializeFromSerializedData"):SetRun(function(self)
    --Test loading with no data.
    self.CuT:InitializeFromSerializedData()
    self:AssertEquals(#self.Folder:GetChildren(),5,"Wrong amount of values created.")
    self:AssertEquals(self.CuT:GetValue("DiscoveredMapCells"),"[]","Default is incorrect.")
    self:AssertEquals(self.Folder.DiscoveredMapCells.Value,"[]","Default value is incorrect.")
    self:AssertEquals(self.CuT:GetValue("Currency"),0,"Default is incorrect.")
    self:AssertEquals(self.Folder.Currency.Value,0,"Default value is incorrect.")

    --Test loading with some data.
    self.CuT:InitializeFromSerializedData({Currency=10})
    self:AssertEquals(#self.Folder:GetChildren(),5,"Wrong amount of values created.")
    self:AssertEquals(self.CuT:GetValue("DiscoveredMapCells"),"[]","Default is incorrect.")
    self:AssertEquals(self.Folder.DiscoveredMapCells.Value,"[]","Default value is incorrect.")
    self:AssertEquals(self.CuT:GetValue("Currency"),10,"Set value is incorrect.")
    self:AssertEquals(self.Folder.Currency.Value,10,"Set value is incorrect.")

    --Test loading with extra data.
    self.CuT:InitializeFromSerializedData({Currency=10,UnknownValue="Fail"})
    self:AssertEquals(#self.Folder:GetChildren(),5,"Wrong amount of values created.")
    self:AssertEquals(self.CuT:GetValue("DiscoveredMapCells"),"[]","Default is incorrect.")
    self:AssertEquals(self.Folder.DiscoveredMapCells.Value,"[]","Default value is incorrect.")
    self:AssertEquals(self.CuT:GetValue("Currency"),10,"Set value is incorrect.")
    self:AssertEquals(self.Folder.Currency.Value,10,"Set value is incorrect.")
end))

--[[
Tests setting values and changed events.
--]]
NexusUnitTesting:RegisterUnitTest(PlayerDataTest.new("TestSetValueAndEvents"):SetRun(function(self)
    --Initialize the data and connect the events.
    self.CuT:InitializeFromSerializedData({Currency=10})
    local ChangedEventCalls,ValueChangedEventCalls = {},0
    self.CuT.ValueChanged:Connect(function(ValueName)
        table.insert(ChangedEventCalls,ValueName)
    end)
    self.CuT:GetValueChangedSignal("Currency"):Connect(function()
        ValueChangedEventCalls = ValueChangedEventCalls + 1
    end)

    --Set values and assert the changes were sent.
    self.CuT:SetValue("Currency",12)
    self:AssertEquals(self.CuT:GetValue("Currency"),12,"Set value is incorrect.")
    self:AssertEquals(self.Folder.Currency.Value,12,"Set value is incorrect.")
    self:AssertEquals(ChangedEventCalls,{"Currency"},"Called events was incorrect.")
    self:AssertEquals(ValueChangedEventCalls,1,"Total called events was incorrect.")
    self.CuT:SetValue("Currency",15)
    self:AssertEquals(self.CuT:GetValue("Currency"),15,"Set value is incorrect.")
    self:AssertEquals(self.Folder.Currency.Value,15,"Set value is incorrect.")
    self:AssertEquals(ChangedEventCalls,{"Currency","Currency"},"Called events was incorrect.")
    self:AssertEquals(ValueChangedEventCalls,2,"Total called events was incorrect.")
    self.CuT:SetValue("Currency",15)
    self:AssertEquals(self.CuT:GetValue("Currency"),15,"Set value is incorrect.")
    self:AssertEquals(self.Folder.Currency.Value,15,"Set value is incorrect.")
    self:AssertEquals(ChangedEventCalls,{"Currency","Currency"},"Called events was incorrect.")
    self:AssertEquals(ValueChangedEventCalls,2,"Total called events was incorrect.")
    self.CuT:SetValue("DiscoveredMapCells","[1,2,3]")
    self:AssertEquals(self.CuT:GetValue("DiscoveredMapCells"),"[1,2,3]","Set value is incorrect.")
    self:AssertEquals(self.Folder.DiscoveredMapCells.Value,"[1,2,3]","Set value is incorrect.")
    self:AssertEquals(ChangedEventCalls,{"Currency","Currency","DiscoveredMapCells"},"Called events was incorrect.")
    self:AssertEquals(ValueChangedEventCalls,2,"Total called events was incorrect.")
end))



return true