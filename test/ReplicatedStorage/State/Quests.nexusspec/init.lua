--[[
TheNexusAvenger

Tests the Quests class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local Quests = ReplicatedStorageProject:GetResource("State.Quests")



--[[
Setups up the test.
--]]
local QuestsTest = NexusUnitTesting.UnitTest:Extend()
function QuestsTest:Setup()
    --Create the mock player.
    local MockPlayer = Instance.new("Folder")
    local PlayerData = Instance.new("Folder")
    PlayerData.Name = "PlayerData"
    PlayerData.Parent = MockPlayer
    local InventoryValue = Instance.new("StringValue")
    InventoryValue.Name = "Inventory"
    InventoryValue.Value = "[]"
    InventoryValue.Parent = PlayerData
    self.InventoryValue = InventoryValue
    local QuestsValue = Instance.new("StringValue")
    QuestsValue.Name = "Quests"
    QuestsValue.Value = "[]"
    QuestsValue.Parent = PlayerData
    self.QuestsValue = QuestsValue

    --Create the component under testing.
    self.CuT = Quests.GetQuests(MockPlayer)
end

--[[
Sets the inventory.
--]]
function QuestsTest:SetInventory(Items)
    --Create the table.
    local NewInventory = {}
    for i,Item in pairs(Items) do
        NewInventory[tostring(i)] = {Name=Item}
    end

    --Set the value.
    self.InventoryValue.Value = HttpService:JSONEncode(NewInventory)
end

--[[
Sets the quests.
--]]
function QuestsTest:SetQuests(Quests)
    self.QuestsValue.Value = HttpService:JSONEncode(Quests)
end

--[[
Asserts the dialog of an NPC.
--]]
function QuestsTest:AssertDialog(NPCName,DialogName)
    local Dialog = self.CuT:GetDialogForNPC(NPCName)
    if Dialog == nil then
        if DialogName ~= nil then
            self:Fail("No dialog was returned.")
        else
            return
        end
    end
    self:AssertEquals(Dialog.Name,DialogName,"Wrong dialog was returned.")
end

--[[
Tests quest conditions being valid.
--]]
NexusUnitTesting:RegisterUnitTest(QuestsTest.new("TestQuestConditonValid"):SetRun(function(self)
    --Test the conditions for an item quest.
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","NotUnlocked"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","TurnedIn"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit",{"AllItems","TurnedIn"}),false)
    self:SetQuests({ActiveQuests={["Mech Suit"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","TurnedIn"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit",{"AllItems","TurnedIn"}),false)
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","TurnedIn"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit",{"AllItems","TurnedIn"}),false)
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","AllItems"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","TurnedIn"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit",{"AllItems","TurnedIn"}),true)
    self:SetQuests({ActiveQuests={},CompletedQuests={["Mech Suit"] = true}})
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit","TurnedIn"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Mech Suit",{"AllItems","TurnedIn"}),true)

    --Test the conditions for an NPC quest.
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","NotUnlocked"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","TurnedIn"),false)
    self:SetQuests({ActiveQuests={["Find Telamom"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","AllItems"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","TurnedIn"),false)
    self:SetQuests({ActiveQuests={},CompletedQuests={["Find Telamom"] = true}})
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Find Telamom","TurnedIn"),true)

    --Test the conditions for an Dressup quest.
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","NotUnlocked"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","TurnedIn"),false)
    self:SetQuests({ActiveQuests={["Fur'-ocious Fashion"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","TurnedIn"),false)
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","TurnedIn"),false)
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeBack="PetSwampMonsterCostumeCape",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","TurnedIn"),false)
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeBack="PetCatCostumeCape",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","AllItems"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","TurnedIn"),false)
    self:SetQuests({ActiveQuests={},CompletedQuests={["Fur'-ocious Fashion"] = true}})
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Fur'-ocious Fashion","TurnedIn"),true)

    --Test the conditions for an Monsters quest.
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","NotUnlocked"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","TurnedIn"),false)
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","TurnedIn"),false)
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 4}})
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","Inventory"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","TurnedIn"),false)
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 15}})
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","AllItems"),true)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","TurnedIn"),false)
    self:SetQuests({ActiveQuests={},CompletedQuests={["Attack Of The SwampWolves"] = true}})
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","NotUnlocked"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","Inventory"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","AllItems"),false)
    self:AssertEquals(self.CuT:QuestConditonValid("Attack Of The SwampWolves","TurnedIn"),true)
end))

--[[
Test the GetStatusIcon method.
--]]
NexusUnitTesting:RegisterUnitTest(QuestsTest.new("TestGetStatusIcon"):SetRun(function(self)
    --Test the icons for an item quest.
    self:AssertEquals(self.CuT:GetStatusIcon("Mech Suit"),"rbxassetid://133436920")
    self:SetQuests({ActiveQuests={["Mech Suit"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusIcon("Mech Suit"),"rbxassetid://132881863")
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:GetStatusIcon("Mech Suit"),"rbxassetid://132881863")
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:GetStatusIcon("Mech Suit"),"rbxassetid://132881888")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Mech Suit"] = true}})
    self:AssertEquals(self.CuT:GetStatusIcon("Mech Suit"),"rbxassetid://132881903")

    --Test the conditions for an NPC quest.
    self:AssertEquals(self.CuT:GetStatusIcon("Find Telamom"),"rbxassetid://133436920")
    self:SetQuests({ActiveQuests={["Find Telamom"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusIcon("Find Telamom"),"rbxassetid://132881888")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Find Telamom"] = true}})
    self:AssertEquals(self.CuT:GetStatusIcon("Find Telamom"),"rbxassetid://132881903")

    --Test the conditions for an Dressup quest.
    self:AssertEquals(self.CuT:GetStatusIcon("Fur'-ocious Fashion"),"rbxassetid://133436920")
    self:SetQuests({ActiveQuests={["Fur'-ocious Fashion"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusIcon("Fur'-ocious Fashion"),"rbxassetid://132881863")
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:GetStatusIcon("Fur'-ocious Fashion"),"rbxassetid://132881863")
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeBack="PetSwampMonsterCostumeCape",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:GetStatusIcon("Fur'-ocious Fashion"),"rbxassetid://132881863")
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeBack="PetCatCostumeCape",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:GetStatusIcon("Fur'-ocious Fashion"),"rbxassetid://132881888")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Fur'-ocious Fashion"] = true}})
    self:AssertEquals(self.CuT:GetStatusIcon("Fur'-ocious Fashion"),"rbxassetid://132881903")

    --Test the conditions for an Monsters quest.
    self:AssertEquals(self.CuT:GetStatusIcon("Attack Of The SwampWolves"),"rbxassetid://133436920")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusIcon("Attack Of The SwampWolves"),"rbxassetid://132881863")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 4}})
    self:AssertEquals(self.CuT:GetStatusIcon("Attack Of The SwampWolves"),"rbxassetid://132881863")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 15}})
    self:AssertEquals(self.CuT:GetStatusIcon("Attack Of The SwampWolves"),"rbxassetid://132881888")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Attack Of The SwampWolves"] = true}})
    self:AssertEquals(self.CuT:GetStatusIcon("Attack Of The SwampWolves"),"rbxassetid://132881903")
end))

--[[
Test the GetStatusText method.
--]]
NexusUnitTesting:RegisterUnitTest(QuestsTest.new("TestGetStatusText"):SetRun(function(self)
    --Test the icons for an item quest.
    self:AssertEquals(self.CuT:GetStatusText("Mech Suit"),"Not Unlocked")
    self:SetQuests({ActiveQuests={["Mech Suit"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusText("Mech Suit"),"0/6 Black Iron Ingots")
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:GetStatusText("Mech Suit"),"3/6 Black Iron Ingots")
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:GetStatusText("Mech Suit"),"Ready to turn in!")
    self:SetInventory({"Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot","Black Iron Ingot"})
    self:AssertEquals(self.CuT:GetStatusText("Mech Suit"),"Ready to turn in!")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Mech Suit"] = true}})
    self:AssertEquals(self.CuT:GetStatusText("Mech Suit"),"Quest Complete!")

    --Test the conditions for an NPC quest.
    self:AssertEquals(self.CuT:GetStatusText("Find Telamom"),"Not Unlocked")
    self:SetQuests({ActiveQuests={["Find Telamom"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusText("Find Telamom"),"Find Telamom")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Find Telamom"] = true}})
    self:AssertEquals(self.CuT:GetStatusText("Find Telamom"),"Quest Complete!")

    --Test the conditions for an Dressup quest.
    self:AssertEquals(self.CuT:GetStatusText("Fur'-ocious Fashion"),"Not Unlocked")
    self:SetQuests({ActiveQuests={["Fur'-ocious Fashion"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusText("Fur'-ocious Fashion"),"Equip the Cat Companion Set")
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:GetStatusText("Fur'-ocious Fashion"),"Equip the Cat Companion Set")
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeBack="PetSwampMonsterCostumeCape",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:GetStatusText("Fur'-ocious Fashion"),"Equip the Cat Companion Set")
    self:SetInventory({PetCostumeHat="PetCatCostumeHat",PetCostumeCollar="PetCostumeCollar",PetCostumeBack="PetCatCostumeCape",PetCostumeAnkle="PetCatCostumeAnklet"})
    self:AssertEquals(self.CuT:GetStatusText("Fur'-ocious Fashion"),"Ready to turn in!")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Fur'-ocious Fashion"] = true}})
    self:AssertEquals(self.CuT:GetStatusText("Fur'-ocious Fashion"),"Quest Complete!")

    --Test the conditions for an Monsters quest.
    self:AssertEquals(self.CuT:GetStatusText("Attack Of The SwampWolves"),"Not Unlocked")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={}})
    self:AssertEquals(self.CuT:GetStatusText("Attack Of The SwampWolves"),"0/15 Swamp Wolves")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 4}})
    self:AssertEquals(self.CuT:GetStatusText("Attack Of The SwampWolves"),"4/15 Swamp Wolves")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 15}})
    self:AssertEquals(self.CuT:GetStatusText("Attack Of The SwampWolves"),"Ready to turn in!")
    self:SetQuests({ActiveQuests={["Attack Of The SwampWolves"] = true},CompletedQuests={},MonsterKillCounters={["Swamp Wolf"] = 18}})
    self:AssertEquals(self.CuT:GetStatusText("Attack Of The SwampWolves"),"Ready to turn in!")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Attack Of The SwampWolves"] = true}})
    self:AssertEquals(self.CuT:GetStatusText("Attack Of The SwampWolves"),"Quest Complete!")
end))

--[[
Tests the dialogs data order as a base test. The full
quests flow is covered by other tests.
--]]
NexusUnitTesting:RegisterUnitTest(QuestsTest.new("TestDialogOrder"):SetRun(function(self)
    self:AssertDialog("Builderman","Builderman_FortifyingTownHall_START")
    self:SetQuests({ActiveQuests={["Fortifying Town Hall"] = true},CompletedQuests={}})
    self:AssertDialog("Builderman","Builderman_FortifyingTownHall_MID")
    self:SetInventory({"Old Board","Old Board","Old Board"})
    self:AssertDialog("Builderman","Builderman_FortifyingTownHall_MID")
    self:SetInventory({"Old Board","Old Board","Old Board","Old Board"})
    self:AssertDialog("Builderman","Builderman_FortifyingTownHall_DONE")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Fortifying Town Hall"] = true}})
    self:AssertDialog("Builderman","Builderman_FrazzledJim_START")
    self:SetQuests({ActiveQuests={["Frazzled Jim"] = true},CompletedQuests={["Fortifying Town Hall"] = true}})
    self:AssertDialog("Builderman","Builderman_FrazzledJim_MID")
    self:AssertDialog("Frazzled Clerk Jim","FrazzledClerkJim_FrazzledJim_CHECKUP")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Fortifying Town Hall"] = true,["Frazzled Jim"] = true}})
    self:AssertDialog("Builderman","Builderman_TheBeginning_START")
    self:SetQuests({ActiveQuests={["The beginning..."] = true},CompletedQuests={["Fortifying Town Hall"] = true,["Frazzled Jim"] = true}})
    self:AssertDialog("Builderman","Builderman_TheBeginning_MID")
    self:SetInventory({PetCostumeHat="PetSkeletonCostumeHat",PetCostumeCollar="PetSkeletonCostumeCollar",PetCostumeBack="PetSkeletonCostumeCape",PetCostumeAnkle="PetSkeletonCostumeAnklet"})
    self:AssertDialog("Builderman","Builderman_TheBeginning_DONE")
    self:SetQuests({ActiveQuests={},CompletedQuests={["Fortifying Town Hall"] = true,["Frazzled Jim"] = true,["The beginning..."] = true}})
    self:AssertDialog("Builderman","Builderman_ALL_DONE")
end))

--[[
Tests adding and completing quests.
--]]
NexusUnitTesting:RegisterUnitTest(QuestsTest.new("TestAddingAndCompletingQuests"):SetRun(function(self)
    --Assert quests are added correctly.
    self.CuT:AddQuest("Fortifying Town Hall")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Fortifying Town Hall",ActiveQuests={["Fortifying Town Hall"] = true},CompletedQuests={},MonsterKillCounters={}},"Quest data is invalid.")
    self.CuT:AddQuest("Fortifying Town Hall")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Fortifying Town Hall",ActiveQuests={["Fortifying Town Hall"] = true},CompletedQuests={},MonsterKillCounters={}},"Quest data is invalid.")
    self.CuT:AddQuest("Clean-up Crew")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Fortifying Town Hall",ActiveQuests={["Fortifying Town Hall"] = true,["Clean-up Crew"] = true},CompletedQuests={},MonsterKillCounters={["Ghost Spider"] = 0}},"Quest data is invalid.")
    self.CuT:AddQuest("Paw-inormal Activity")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Fortifying Town Hall",ActiveQuests={["Fortifying Town Hall"] = true,["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={},MonsterKillCounters={["Ghost Spider"] = 0,["Ghost Wolf"] = 0}},"Quest data is invalid.")

    --Assert quests are completed correctly.
    self.CuT:CompleteQuest("Fortifying Town Hall")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Fortifying Town Hall",ActiveQuests={["Fortifying Town Hall"] = true,["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={},MonsterKillCounters={["Ghost Spider"] = 0,["Ghost Wolf"] = 0}},"Quest data is invalid.")
    self:SetInventory({"Old Board","Old Board","Old Board","Old Board"})
    self.CuT:CompleteQuest("Fortifying Town Hall")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest=self.CuT.QuestData.SelectedQuest,ActiveQuests={["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={["Fortifying Town Hall"] = true},MonsterKillCounters={["Ghost Spider"] = 0,["Ghost Wolf"] = 0}},"Quest data is invalid.")
    for i = 1,13 do
        self.CuT:RegisterMonsterKill("Ghost Spider")
    end
    for i = 1,20 do
        self.CuT:RegisterMonsterKill("Ghost Wolf")
    end
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest=self.CuT.QuestData.SelectedQuest,ActiveQuests={["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={["Fortifying Town Hall"] = true},MonsterKillCounters={["Ghost Spider"] = 13,["Ghost Wolf"] = 20}},"Quest data is invalid.")
    self.CuT:SelectQuest("Paw-inormal Activity")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Paw-inormal Activity",ActiveQuests={["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={["Fortifying Town Hall"] = true},MonsterKillCounters={["Ghost Spider"] = 13,["Ghost Wolf"] = 20}},"Quest data is invalid.")
    self.CuT:SelectQuest("Clean-up Crew")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Clean-up Crew",ActiveQuests={["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={["Fortifying Town Hall"] = true},MonsterKillCounters={["Ghost Spider"] = 13,["Ghost Wolf"] = 20}},"Quest data is invalid.")
    self.CuT:SelectQuest("Clean-up Crew")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Clean-up Crew",ActiveQuests={["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},CompletedQuests={["Fortifying Town Hall"] = true},MonsterKillCounters={["Ghost Spider"] = 13,["Ghost Wolf"] = 20}},"Quest data is invalid.")
    self.CuT:CompleteQuest("Clean-up Crew")
    self:AssertEquals(self.CuT.QuestData,{SelectedQuest="Paw-inormal Activity",ActiveQuests={["Paw-inormal Activity"] = true},CompletedQuests={["Fortifying Town Hall"] = true,["Clean-up Crew"] = true},MonsterKillCounters={["Ghost Wolf"] = 20}},"Quest data is invalid.")
    self.CuT:CompleteQuest("Paw-inormal Activity")
    self:AssertEquals(self.CuT.QuestData,{ActiveQuests={},CompletedQuests={["Fortifying Town Hall"] = true,["Clean-up Crew"] = true,["Paw-inormal Activity"] = true},MonsterKillCounters={}},"Quest data is invalid.")
end))



--Return the quests class so it can be used by sub-modules.
return QuestsTest