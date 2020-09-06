--[[
TheNexusAvenger

Data for a command for giving items to players.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService"))
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local NPCLocations = ReplicatedStorageProject:GetResource("GameData.Generation.NPCLocations")
local QuestData = ReplicatedStorageProject:GetResource("GameData.Quest.Quests")
local QuestService = ServerScriptServiceProject:GetResource("Service.QuestService")
local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")



return {
    Keyword = "satisfycurrentquest",
    Description = "Satisfies the requirements for a quest. Doesn't complete the quest to allow testing of the dialogs.",
    Arguments = {
        {
            Type = "nexusAdminPlayers",
            Name = "Players",
            Description = "Players to satisfy the selected quest.",
        },
    },
    Run = function(self,CommandContext,Players)
        for _,Player in pairs(Players) do
            local PlayerQuests = QuestService.PlayerQuests[Player]
            local SelectedQuestName = PlayerQuests.QuestData.SelectedQuest
            if SelectedQuestName then
                local SelectedQuest = QuestData[SelectedQuestName]
                if SelectedQuest then
                    if SelectedQuest.QuestType == "Items" then
                        --Give the remaining items for the quest.
                        local RequiredItems = SelectedQuest.RequiredItems[1]
                        for i = 1,RequiredItems.Amount do
                            InventoryService:AddItem(Player,RequiredItems.Name)
                        end
                    elseif SelectedQuest.QuestType == "Dressup" then
                        --Set the pet item slots to the pet costume.
                        local RequiredSet = SelectedQuest.RequiredSet.Name
                        local PlayerInventory = InventoryService:GetInventory(Player)
                        for ItemName,Data in pairs(ItemData) do
                            if Data.CostumeName == RequiredSet then
                                PlayerInventory.Inventory[Data.ItemType] = {Name=ItemName}
                            end
                        end
                        PlayerInventory:Save()
                    elseif SelectedQuest.QuestType == "Monsters" then
                        --Add monster kills for the quest.
                        local RequiredMonsters = SelectedQuest.RequiredMonsters[1]
                        for i = 1,RequiredMonsters.Amount do
                            PlayerQuests:RegisterMonsterKill(RequiredMonsters.Name)
                        end
                    elseif SelectedQuest.QuestType == "NPC" then
                        --Teleport the player to the NPC.
                        local RequiredNPC = SelectedQuest.RequiredNPC.Name
                        local Location = NPCLocations[RequiredNPC]
                        local TargetCFrame = CFrame.new(Location.CellX * 100,4,Location.CellY * 100) * Location.OffsetCFrame * CFrame.new(0,0,-3) * CFrame.Angles(0,math.pi,0)
                        local Character = Player.Character
                        if Character then
                            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                            if HumanoidRootPart then
                                HumanoidRootPart.CFrame = TargetCFrame
                            end
                        end
                    end
                end
            end 
        end
    end
}