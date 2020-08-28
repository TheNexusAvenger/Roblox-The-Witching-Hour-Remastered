--[[
TheNexusAvenger

Tests the Inventory class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory")



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

--[[
Tests validating slots.
--]]
NexusUnitTesting:RegisterUnitTest(InventoryTest.new("TestCanFitInSlot"):SetRun(function(self)
    --Add 5 items.
    self.CuT1:AddItem({Name="VirtualBloxconHelmet"})
    self.CuT1:AddItem({Name="VirtualBloxconHelmet"})
    self.CuT1:AddItem({Name="VirtualBloxconTorso"})
    self.CuT1:AddItem({Name="VirtualBloxconTorso"})
    self.CuT1:AddItem({Name="VirtualBloxconHelmet"})

    --Test the ability for items to be able to be in slots.
    self:AssertTrue(self.CuT1:CanFitInSlot({Name="UnknownItem"},"5"),"Unknown item can't fit in a number slot.")
    self:AssertTrue(self.CuT1:CanFitInSlot({Name="UnknownItem"},5),"Unknown item can't fit in a number slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="UnknownItem"},0),"Unknown item can fit in out of bounds slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="UnknownItem"},106),"Unknown item can fit in out of bounds slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="UnknownItem"},5.4),"Unknown item can fit in decimal slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="UnknownItem"},"PlayerHat"),"Unknown item can fit in special slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="UnknownItem"},"PlayerTorso"),"Unknown item can fit in special slot.")

    self:AssertTrue(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},"5"),"Known item can't fit in a number slot.")
    self:AssertTrue(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},5),"Known item can't fit in a number slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},0),"Known item can fit in out of bounds slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},106),"Known item can fit in out of bounds slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},5.4),"Unknown item can fit in decimal slot.")
    self:AssertTrue(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},"PlayerHat"),"Known item can't fit in special slot.")
    self:AssertFalse(self.CuT1:CanFitInSlot({Name="VirtualBloxconHelmet"},"PlayerTorso"),"Known item can fit in special slot.")

    --Swap an item and assert the swapping is valid.
    self.CuT1:SwapSlots(2,"PlayerHat")
    self:AssertTrue(self.CuT1:CanSwap(3,4),"Can't swap between numbers.")
    self:AssertTrue(self.CuT1:CanSwap(3,10),"Can't swap between numbers with one empty.")
    self:AssertTrue(self.CuT1:CanSwap(10,3),"Can't swap between numbers with one empty.")
    self:AssertTrue(self.CuT1:CanSwap("PlayerHat",5),"Can't swap between same type and number.")
    self:AssertTrue(self.CuT1:CanSwap(5,"PlayerHat"),"Can't swap between same type and number.")
    self:AssertFalse(self.CuT1:CanSwap("PlayerHat",3),"Can swap between same type and number.")
    self:AssertFalse(self.CuT1:CanSwap(3,"PlayerHat"),"Can swap between same type and number.")
    self:AssertFalse(self.CuT1:CanSwap("PlayerHat","PlayerTorso"),"Can swap between different types.")
end))



return true