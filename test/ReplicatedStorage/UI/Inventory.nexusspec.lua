--[[
TheNexusAvenger

Tests the Inventory class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local Inventory = ReplicatedStorageProject:GetResource("UI.Inventory")



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
    local InventoryValue = Instance.new("StringValue")
    InventoryValue.Name = "Inventory"
    InventoryValue.Value = "[]"
    InventoryValue.Parent = PlayerData

    --Create the components under testing.
    self.CuT1 = Inventory.new(MockPlayer)
    self.CuT2 = Inventory.new(MockPlayer)
end

--[[
Tests adding items and reading the inventory.
--]]
NexusUnitTesting:RegisterUnitTest(InventoryTest.new("TestAddItem"):SetRun(function(self)
    --Assert the initial state is correct.
    self:AssertEquals(self.CuT1:GetItem(1),nil,"Item exists.")
    self:AssertEquals(self.CuT2:GetItem(1),nil,"Item exists.")
    self:AssertEquals(self.CuT1:GetNextOpenSlot(),1,"First open slot is invalid.")
    self:AssertEquals(self.CuT2:GetNextOpenSlot(),1,"First open slot is invalid.")

    --Add 104 items.
    for i = 1,104 do
        self.CuT1:AddItem({Name="MockItem"..tostring(i)})
        self:AssertEquals(self.CuT1:GetItem(i),{Name="MockItem"..tostring(i)},"Item in slot is invalid.")
        self:AssertEquals(self.CuT2:GetItem(i),{Name="MockItem"..tostring(i)},"Item in slot is invalid.")
        self:AssertEquals(self.CuT1:GetNextOpenSlot(),i + 1,"Next open slot is invalid.")
        self:AssertEquals(self.CuT2:GetNextOpenSlot(),i + 1,"Next open slot is invalid.")
    end

    --Add a 105th item and assert there is no open slot.
    self.CuT1:AddItem({Name="MockItem105"})
    self:AssertEquals(self.CuT1:GetItem(105),{Name="MockItem105"},"Item in slot is invalid.")
    self:AssertEquals(self.CuT2:GetItem(105),{Name="MockItem105"},"Item in slot is invalid.")
    self:AssertEquals(self.CuT1:GetNextOpenSlot(),nil,"Next open slot exists.")
    self:AssertEquals(self.CuT2:GetNextOpenSlot(),nil,"Next open slot exists.")

    --Assert an error is thrown if there is no empty slot.
    self:AssertErrors(function()
        self.CuT1:AddItem({Name="MockItem106"})
    end)
end))

--[[
Tests swapping slots.
--]]
NexusUnitTesting:RegisterUnitTest(InventoryTest.new("TestSwapSlots"):SetRun(function(self)
    --Add 5 items.
    self.CuT1:AddItem({Name="MockItem1"})
    self.CuT1:AddItem({Name="MockItem1"})
    self.CuT1:AddItem({Name="MockItem2"})
    self.CuT1:AddItem({Name="MockItem2"})
    self.CuT1:AddItem({Name="MockItem1"})

    --Swap slots and assert they change.
    self.CuT1:SwapSlots(1,3)
    self:AssertEquals(self.CuT1:GetItem(1),{Name="MockItem2"},"Swapped item is incorrect.")
    self:AssertEquals(self.CuT1:GetItem(3),{Name="MockItem1"},"Swapped item is incorrect.")
    self:AssertEquals(#self.CuT1:GetItemSlots("MockItem1"),3,"Total slots are incorrect.")
    self:AssertEquals(#self.CuT1:GetItemSlots("MockItem2"),2,"Total slots are incorrect.")
end))

--[[
Tests removing items.
--]]
NexusUnitTesting:RegisterUnitTest(InventoryTest.new("TestRemoveSlots"):SetRun(function(self)
    --Add 5 items.
    self.CuT1:AddItem({Name="MockItem1"})
    self.CuT1:AddItem({Name="MockItem1"})
    self.CuT1:AddItem({Name="MockItem2"})
    self.CuT1:AddItem({Name="MockItem2"})
    self.CuT1:AddItem({Name="MockItem1"})

    --Remove 2 slots and assert they are removed.
    self.CuT1:RemoveSlots({2,4})
    self:AssertEquals(self.CuT1:GetItem(2),nil,"Removed item exists.")
    self:AssertEquals(self.CuT1:GetItem(4),nil,"Removed item exists.")
    self:AssertEquals(self.CuT2:GetNextOpenSlot(),2,"Next open slot is invalid.")
    self:AssertEquals(#self.CuT1:GetItemSlots("MockItem1"),2,"Total slots are incorrect.")
    self:AssertEquals(#self.CuT1:GetItemSlots("MockItem2"),1,"Total slots are incorrect.")

    --Remove 1 slot and assert it is removed.
    self.CuT1:RemoveSlot(1)
    self:AssertEquals(self.CuT1:GetItem(1),nil,"Removed item exists.")
    self:AssertEquals(self.CuT2:GetNextOpenSlot(),1,"Next open slot is invalid.")
    self:AssertEquals(#self.CuT1:GetItemSlots("MockItem1"),1,"Total slots are incorrect.")
    self:AssertEquals(#self.CuT1:GetItemSlots("MockItem2"),1,"Total slots are incorrect.")
end))



return true