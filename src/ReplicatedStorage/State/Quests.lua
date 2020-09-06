--[[
TheNexusAvenger

Stores the state of quests and
validates dialogs (which are dependant
on quests).
--]]

local PET_EQIUP_SLOTS = {
    "PetCostumeHat",
    "PetCostumeCollar",
    "PetCostumeBack",
    "PetCostumeAnkle",
}



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local NexusEventCreator = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.Event.NexusEventCreator")
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local Dialogs = ReplicatedStorageProject:GetResource("GameData.Quest.Dialogs")
local QuestsData = ReplicatedStorageProject:GetResource("GameData.Quest.Quests")
local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData")
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory")

local Quests = NexusObject:Extend()
Quests.CachedQuests = {}
Quests:SetClassName("Quests")



--[[
Creates a quests object.
--]]
function Quests:__new(Player)
    self:InitializeSuper()

    --Store the state.
    self.PlayerData = PlayerData.GetPlayerData(Player)
    self.Inventory = Inventory.GetInventory(Player)
    self.QuestsChanged = NexusEventCreator.CreateEvent()
    self.QuestData = self.PlayerData:GetValue("Quests")
    self:FixQuestData()

    --Connect the quests changing.
    self.PlayerData:GetValueChangedSignal("Quests"):Connect(function()
        self.QuestData = self.PlayerData:GetValue("Quests")
        self.QuestsChanged:Fire()
        self:FixQuestData()
    end)
end

--[[
Returns a quests object for a
given player.
--]]
function Quests.GetQuests(Player)
    --Create the cached object if it doesn't exist.
    if not Quests.CachedQuests[Player] then
        Quests.CachedQuests[Player] = Quests.new(Player)
    end

    --Return the cached object.
    return Quests.CachedQuests[Player]
end

--[[
Populates missing attributes of quest data.
--]]
function Quests:FixQuestData()
    --Add the missing tables.
    if not self.QuestData.CompletedQuests then
        self.QuestData.CompletedQuests = {}
    end
    if not self.QuestData.ActiveQuests then
        self.QuestData.ActiveQuests = {}
    end
    if not self.QuestData.MonsterKillCounters then
        self.QuestData.MonsterKillCounters = {}
    end

    --Remove the selected quest if it is not active.
    if self.QuestData.SelectedQuest and not self.QuestData.ActiveQuests[self.QuestData.SelectedQuest] then
        self.QuestData.SelectedQuest = nil
    end
    
    --Add a selected quest if none exists.
    if not self.QuestData.SelectedQuest then
        for QuestName,QuestActive in pairs(self.QuestData.ActiveQuests) do
            if QuestActive then
                self.QuestData.SelectedQuest = QuestName
                break
            end
        end
    end
end

--[[
Returns if the condition for a quest
is satisfied.
--]]
function Quests:QuestConditonValid(QuestName,Condition)
    --Return a true condition if the condition is a table.
    if type(Condition) == "table" then
        for _,SubCondtion in pairs(Condition) do
            if self:QuestConditonValid(QuestName,SubCondtion) then
                return true
            end
        end
        return false
    end

    if Condition == "TurnedIn" then
        --Return if the quest is completed.
        return self.QuestData.CompletedQuests[QuestName] == true
    elseif Condition == "NotUnlocked" then
        --Return if the quest hasn't been started.
        return not self.QuestData.CompletedQuests[QuestName] and not self.QuestData.ActiveQuests[QuestName]
    else
        --Return if the quest is completed or not started.
        if self.QuestData.CompletedQuests[QuestName] or not self.QuestData.ActiveQuests[QuestName] then
            return false
        end

        --Return based on the items.
        local QuestData = QuestsData[QuestName]
        if QuestData then
            if QuestData.QuestType == "Items" then
                local RequiredItems = QuestData.RequiredItems
                if RequiredItems and RequiredItems[1] then
                    local RequiredItem = RequiredItems[1]
                    local TotalItems = #self.Inventory:GetItemSlots(RequiredItem.Name)

                    if Condition == "Inventory" then
                        --Return if some but not all required items were obtained.
                        return TotalItems < RequiredItem.Amount
                    elseif Condition == "AllItems" then
                        --Return if all the required items were obtained.
                        return TotalItems >= RequiredItem.Amount
                    end
                end
            elseif QuestData.QuestType == "Dressup" then
                local RequiredSet = QuestData.RequiredSet
                if RequiredSet then
                    --Return if the slots are invalid.
                    for _,SlotName in pairs(PET_EQIUP_SLOTS) do
                        local Item = self.Inventory:GetItem(SlotName)
                        if Item and Item.Name then
                            local Data = ItemData[Item.Name]
                            if Data and Data.CostumeName and Data.CostumeName ~= RequiredSet.Name then
                                return Condition ~= "AllItems"
                            end
                        else
                            return Condition ~= "AllItems"
                        end
                    end
                    return Condition == "AllItems"
                end
            elseif QuestData.QuestType == "Monsters" then
                local RequiredMonsters = QuestData.RequiredMonsters
                if RequiredMonsters and RequiredMonsters[1] then
                    --Return if enough monsters were killed.
                    local RequiredMonstersName = RequiredMonsters[1].Name
                    local RequiredKills = RequiredMonsters[1].Amount or 0
                    local MonstersKilled = self.QuestData.MonsterKillCounters[RequiredMonstersName] or 0

                    if Condition == "Inventory" then
                        --Return if some but not all required items were obtained.
                        return MonstersKilled < RequiredKills
                    elseif Condition == "AllItems" then
                        --Return if all the required items were obtained.
                        return MonstersKilled >= RequiredKills
                    end
                end
            end
        end

        --Return true (no items required; such as finding an NPC).
        return true
    end
end

--[[
Returns the data of the dialog to use
for the given NPC.
--]]
function Quests:GetDialogForNPC(NPCName)
    --Return nil if no data exists.
    if not Dialogs[NPCName] then
        return
    end

    --Iterate over the NPC's dialogs until one is valid.
    for _,DialogData in pairs(Dialogs[NPCName]) do
        --Determine if the conditions are valid.
        local DailogQuestConditionsMet = true
        for _,Quest in pairs(DialogData.RequiredQuests or {}) do
            if not self:QuestConditonValid(Quest.Name,Quest.Status) then
                DailogQuestConditionsMet = false
                break
            end
        end

        --Return if the dialog can be used.
        if DailogQuestConditionsMet then
            return DialogData
        end
    end
end

--[[
Returns the status icon for the given quest.
--]]
function Quests:GetStatusIcon(QuestName)
    if self:QuestConditonValid(QuestName,"TurnedIn") then
        return "rbxassetid://132881903"
    elseif self:QuestConditonValid(QuestName,"AllItems") then
        return "rbxassetid://132881888"
    elseif self:QuestConditonValid(QuestName,"Inventory") then
        return "rbxassetid://132881863"
    else
        return "rbxassetid://133436920"
    end
end

--[[
Returns the status text of the quest.
--]]
function Quests:GetStatusText(QuestName)
    --Return the basic results.
    local QuestData = QuestsData[QuestName]
    if self:QuestConditonValid(QuestName,"NotUnlocked") then
        return "Not Unlocked"
    elseif self:QuestConditonValid(QuestName,"TurnedIn") then
        return "Quest Complete!"
    elseif self:QuestConditonValid(QuestName,"AllItems") and QuestData.QuestType ~= "NPC" then
        return "Ready to turn in!"
    end

    --Return a full result.
    if QuestData.QuestType == "Items" then
        local RequiredItems = QuestData.RequiredItems[1]
        return tostring(#self.Inventory:GetItemSlots(RequiredItems.Name)).."/"..tostring(RequiredItems.Amount).." "..QuestData.RequiredItems.DisplayName
    elseif QuestData.QuestType == "Dressup" then
        return "Equip the "..QuestData.RequiredSet.DisplayName
    elseif QuestData.QuestType == "Monsters" then
        local RequiredMonsters = QuestData.RequiredMonsters[1]
        return tostring(self.QuestData.MonsterKillCounters[RequiredMonsters.Name] or 0).."/"..tostring(RequiredMonsters.Amount).." "..QuestData.RequiredMonsters.DisplayName
    elseif QuestData.QuestType == "NPC" then
        return "Find "..QuestData.RequiredNPC.Name
    end
end

--[[
Saves the quest values.
--]]
function Quests:Save()
    self:FixQuestData()
    self.PlayerData:SetValue("Quests",self.QuestData)
end

--[[
Adds a quest.
--]]
function Quests:AddQuest(QuestName)
    --Return if the quest hasn't been unlocked.
    if not self:QuestConditonValid(QuestName,"NotUnlocked") then
        return
    end

    --Add the quuest and add the monster counter if needed.
    local QuestData = QuestsData[QuestName]
    self.QuestData.ActiveQuests[QuestName] = true
    if QuestData and QuestData.RequiredMonsters and QuestData.RequiredMonsters[1] then
        self.QuestData.MonsterKillCounters[QuestData.RequiredMonsters[1].Name] = 0
    end

    --Save the quests.
    self.QuestData.SelectedQuest = QuestName
    self:Save()
end

--[[
Completes a quest.
--]]
function Quests:CompleteQuest(QuestName)
    --Return if the quest hasn't been completed.
    if not self:QuestConditonValid(QuestName,"AllItems") then
        return
    end

    --Move the quest and remove the kill counter.
    local QuestData = QuestsData[QuestName]
    self.QuestData.ActiveQuests[QuestName] = nil
    self.QuestData.CompletedQuests[QuestName] = true
    if QuestData and QuestData.RequiredMonsters and QuestData.RequiredMonsters[1] then
        self.QuestData.MonsterKillCounters[QuestData.RequiredMonsters[1].Name] = nil
    end

    --Save the quests.
    self:Save()
end

--[[
Selects the primary quest to display.
--]]
function Quests:SelectQuest(QuestName)
    --Return if the quest isn't an option.
    if not self:QuestConditonValid(QuestName,{"Inventory","AllItems"}) then
        return
    end

    --Select the quest and save the quests.
    self.QuestData.SelectedQuest = QuestName
    self:Save()
end

--[[
Registers a monster kill.
--]]
function Quests:RegisterMonsterKill(MonsterName)
    --Return if the monster isn't being tracked.
    if not self.QuestData.MonsterKillCounters[MonsterName] then
        return
    end

    --Increment the monster counter and save the quests.
    self.QuestData.MonsterKillCounters[MonsterName] = self.QuestData.MonsterKillCounters[MonsterName] + 1
    self:Save()
end



return Quests