--[[
TheNexusAvenger

Manages the quests for players.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local QuestsData = ReplicatedStorageProject:GetResource("GameData.Quest.Quests")
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local NPCLocations = ReplicatedStorageProject:GetResource("GameData.Generation.NPCLocations")
local Quests = ReplicatedStorageProject:GetResource("State.Quests")
local GameReplication = ReplicatedStorageProject:GetResource("GameReplication")

local QuestService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
QuestService:SetClassName("QuestService")
QuestService.PlayerQuests = {}
ServerScriptServiceProject:SetContextResource(QuestService)

local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")



--Set up the replication.
local QuestReplication = Instance.new("Folder")
QuestReplication.Name = "QuestReplication"
QuestReplication.Parent = GameReplication

local TurnInQuest = Instance.new("RemoteEvent")
TurnInQuest.Name = "TurnInQuest"
TurnInQuest.Parent = QuestReplication

TurnInQuest.OnServerEvent:Connect(function(Player,NPCName,QuestName)
    QuestService:CompleteQuest(Player,NPCName,QuestName)
end)

local StartQuest = Instance.new("RemoteEvent")
StartQuest.Name = "StartQuest"
StartQuest.Parent = QuestReplication

StartQuest.OnServerEvent:Connect(function(Player,NPCName,QuestName)
    QuestService:StartQuest(Player,NPCName,QuestName)
end)

local SelectQuest = Instance.new("RemoteEvent")
SelectQuest.Name = "SelectQuest"
SelectQuest.Parent = QuestReplication

SelectQuest.OnServerEvent:Connect(function(Player,QuestName)
    QuestService:SelectQuest(Player,QuestName)
end)



--[[
Initializes the data for a player.
--]]
function QuestService:LoadPlayer(Player)
    self.PlayerQuests[Player] = Quests.GetQuests(Player)
end

--[[
Returns if the given quest is valid
for a given condition.
--]]
function QuestService:QuestConditonValid(Player,QuestName,Condition)
    return self.PlayerQuests[Player]:QuestConditonValid(QuestName,Condition)
end

--[[
Starts a quest for a player. Performs security
checks to make sure the player can only accept a
quest in the current dialog. The quest name
is required because dialogs can award multiple
quests.
--]]
function QuestService:StartQuest(Player,NPCName,QuestName)
    --Return if the quest is not unlocked.
    local PlayerQuests = self.PlayerQuests[Player]
    if not PlayerQuests:QuestConditonValid(QuestName,"NotUnlocked") then
        return
    end

    --Get the NPC dialog and return if it doesn't exist.
    local Dialog = PlayerQuests:GetDialogForNPC(NPCName)
    if not Dialog then
        return
    end

    --[[
    Returns if the quest is valid for a given table.
    --]]
    local function QuestValid(DialogTable)
        --Return true if the quest matches.
        if QuestName == DialogTable.Quest then
            return true
        end

        --Return if a sub-table is true.
        for _,SubTable in pairs(DialogTable) do
            if type(SubTable) == "table" and QuestValid(SubTable) then
                return true
            end
        end

        --Return false (not valid).
        return false
    end

    --Add the quest if it is valid.
    if QuestValid(Dialog) then
        PlayerQuests:AddQuest(QuestName)
    end
end

--[[
Completes a quest for a player. The quest
name is not given since each NPC 
--]]
function QuestService:CompleteQuest(Player,NPCName,QuestName)
    --Return if the quest is not able to be turned in.
    local PlayerQuests = self.PlayerQuests[Player]
    if not PlayerQuests:QuestConditonValid(QuestName,"AllItems") then
        return
    end

    --Get the NPC dialog and return if it doesn't exist.
    local Dialog = PlayerQuests:GetDialogForNPC(NPCName)
    if not Dialog then
        return
    end

    --[[
    Returns if the quest is valid for a given table.
    --]]
    local function QuestValid(DialogTable)
        --Return true if the turn in quest matches.
        if QuestName == DialogTable.TurnIn then
            return true
        end

        --Return if a sub-table is true.
        for _,SubTable in pairs(DialogTable) do
            if type(SubTable) == "table" and QuestValid(SubTable) then
                return true
            end
        end

        --Return false (not valid).
        return false
    end

    --Complete the quest if it is valid.
    if QuestValid(Dialog) then
        PlayerQuests:CompleteQuest(QuestName)
        
        --Remove the quest items.
        local QuestData = QuestsData[QuestName]
        if QuestData.QuestType == "Items" then
            local RequiredItems = QuestData.RequiredItems[1]
            InventoryService:RemoveItemsByName(Player,RequiredItems.Name)
        end

        --Reward the player.
        for RewardType,Reward in pairs(QuestData.Rewards or {}) do
            local PlayerData = PlayerDataService:GetPlayerData(Player)
            if RewardType == "Badge" then
                --Award a bloxkin.
                local Bloxkins = PlayerData:GetValue("CollectedBloxkins")
                Bloxkins[Reward] = true
                PlayerData:SetValue("CollectedBloxkins",Bloxkins)
            elseif RewardType == "XP" then
                --Award XP.
                local XP = PlayerData:GetValue("XP") + Reward
                PlayerData:SetValue("XP",XP)
            elseif RewardType == "Items" then
                --Award items.
                for _,Item in pairs(Reward) do
                    for i = 1,Item.Amount do
                        local NewItem = {Name=Item.Name}
                        if ItemData[Item.Name].IncludeZoneData then
                            NewItem.Zone = NPCLocations[NPCName].Zone
                        end
                        InventoryService:AddItem(Player,NewItem)
                    end
                end
            end
        end
    end
end

--[[
Selects the primary quest for the player.
--]]
function QuestService:SelectQuest(Player,QuestName)
    self.PlayerQuests[Player]:SelectQuest(QuestName)
end

--[[
Clears a player.
--]]
function QuestService:ClearPlayer(Player)
    self.PlayerQuests[Player] = nil
end



return QuestService