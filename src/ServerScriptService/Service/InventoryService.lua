--[[
TheNexusAvenger

Controls the inventory of the player.
Class is static (should not be created).
--]]

local QUEST_ITEM_MULTIPLIER = 5




local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local ItemDataModule = ReplicatedStorageProject:GetObjectReference("GameData.Item.Items")
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local Quests = ReplicatedStorageProject:GetResource("GameData.Quest.Quests")
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory")
local GameReplication = ReplicatedStorageProject:GetResource("GameReplication")

local InventoryService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
InventoryService:SetClassName("InventoryService")
InventoryService.PlayerInventories = {}
ServerScriptServiceProject:SetContextResource(InventoryService)

local ComplianceService = ServerScriptServiceProject:GetResource("Service.ComplianceService")
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")
local PetService = ServerScriptServiceProject:GetResource("Service.PetService")
local QuestService = ServerScriptServiceProject:GetResource("Service.QuestService")



--Set up the replication.
local InventoryReplication = Instance.new("Folder")
InventoryReplication.Name = "InventoryReplication"
InventoryReplication.Parent = GameReplication

local SwapSlots = Instance.new("RemoteEvent")
SwapSlots.Name = "SwapSlots"
SwapSlots.Parent = InventoryReplication
SwapSlots.OnServerEvent:Connect(function(Player,Slot1,Slot2)
    InventoryService:SwapSlots(Player,Slot1,Slot2)
end)

local SetPet = Instance.new("RemoteEvent")
SetPet.Name = "SetPet"
SetPet.Parent = InventoryReplication
SetPet.OnServerEvent:Connect(function(Player,PetName)
    local PlayerData = PlayerDataService:GetPlayerData(Player)
    if PetName == "Dog" or PlayerData:GetValue("PetsOwned")[PetName] then
        PlayerData:SetValue("CurrentPet",PetName)
        PetService:SpawnPet(Player)
    end
end)

local UnlockChest = Instance.new("RemoteEvent")
UnlockChest.Name = "UnlockChest"
UnlockChest.Parent = InventoryReplication
UnlockChest.OnServerEvent:Connect(function(Player,Slot)
    InventoryService:UnlockChest(Player,Slot)
end)

local DeleteItem = Instance.new("RemoteEvent")
DeleteItem.Name = "DeleteItem"
DeleteItem.Parent = InventoryReplication
DeleteItem.OnServerEvent:Connect(function(Player,Slot)
    InventoryService:DeleteItem(Player,Slot)
end)



--[[
Initializes the inventory for a player.
--]]
function InventoryService:LoadPlayer(Player)
    local PlayerInventory = Inventory.GetInventory(Player)
    self.PlayerInventories[Player] = PlayerInventory

    --Unlock all locked chests if the region does not allow for random items.
    if not ComplianceService:CanUseRandomPaidItems(Player) then
        local SlotsToUnlock = {}
        for Slot, Item in PlayerInventory.Inventory do
            if Item.Name == "TreasureChest" then
                SlotsToUnlock[Slot] = Item.Zone
            end
        end
        for Slot, Zone in SlotsToUnlock do
            PlayerInventory:RemoveSlot(Slot)
            self:AwardRandomItem(Player, Zone)
        end
    end
end

--[[
Clears a player.
--]]
function InventoryService:ClearPlayer(Player)
    self.PlayerInventories[Player] = nil
end

--[[
Inserts all of the character items. Yields for them all
to be inserted or fail. This is required for the local
inventory display.
--]]
function InventoryService:LoadCharacterAssets()
    --Start loading the assets.
    local AssetsRemaining = 0
    local AssetLoaded = Instance.new("BindableEvent")
    for Name,AssetData in pairs(ItemData) do
        local AssetId = AssetData.RobloxId
        if AssetId then
            AssetsRemaining = AssetsRemaining + 1
            coroutine.wrap(function()
                local Worked,Model = pcall(function()
                    return InsertService:LoadAsset(AssetId)
                end)

                --Set up the asset.
                if Worked then
                    Model.Name = Name
                    Model.Parent = ItemDataModule
                else
                    warn("Failed to load "..tostring(AssetId).." because "..tostring(Model))
                end

                --Register the model is loaded.
                AssetsRemaining = AssetsRemaining - 1
                AssetLoaded:Fire()
            end)()
        end
    end

    --Wait for the assets to load.
    while AssetsRemaining > 0 do
        AssetLoaded.Event:Wait()
    end
end

--[[
Returns the inventory object for a player.
--]]
function InventoryService:GetInventory(Player)
    return self.PlayerInventories[Player]
end

--[[
Returns the item for a given slot.
--]]
function InventoryService:GetItem(Player,SlotName)
    local PlayerInventory = self.PlayerInventories[Player]
    return PlayerInventory and PlayerInventory:GetItem(SlotName)
end

--[[
Returns the inventory changed event for a player.
--]]
function InventoryService:GetInventoryChangedEvent(Player)
    return self.PlayerInventories[Player].InventoryChanged
end

--[[
Adds an item to a player's inventory.
Returns if it was successful.
--]]
function InventoryService:AddItem(Player,Item)
    --Wrap the item as a table if it is a string.
    if type(Item) == "string" then
        Item = {Name=Item}
    end

    --Get the next open slot and return false if the inventory is full.
    local PlayerInventory = self.PlayerInventories[Player]
    local OpenSlot = PlayerInventory:GetNextOpenSlot()
    if not OpenSlot then
        return false
    end

    --Add the item and return true.
    PlayerInventory:AddItem(Item)
    return true
end

--[[
Awards a random item to the given player.
Returns if an item was given and the name
of the item.
--]]
function InventoryService:AwardRandomItem(Player,Zone)
    --Return if the inventory is full.
    local PlayerInventory = self:GetInventory(Player)
    if not PlayerInventory:GetNextOpenSlot() then
        return false
    end
    
    --Compile the options for items.
    local Items = {}
    for ItemName,Data in pairs(ItemData) do
        if Data.Awardable ~= false and (Zone == nil or Zone == Data.Zone) then
            --Determine how many of an item the player can have.
            local TotalPossible = 1
            local Multiplier = 1
            local QuestName = Data.Quest
            if QuestName then
                if QuestService:QuestConditonValid(Player,QuestName,"Inventory") then
                    --Set the total possible as the items for the quest.
                    local QuestData = Quests[QuestName]
                    if QuestData and QuestData.RequiredItems and QuestData.RequiredItems[1] and QuestData.RequiredItems[1].Name == ItemName then
                        TotalPossible = QuestData.RequiredItems[1].Amount or 0
                        Multiplier = QUEST_ITEM_MULTIPLIER
                    end
                else
                    --Set the item as unobtainable.
                    TotalPossible = 0
                end
            end

            --Add the item if the player can have more of an item.
            if TotalPossible > #PlayerInventory:GetItemSlots(ItemName) then
                for i = 1,Multiplier do
                    table.insert(Items,ItemName)
                end
            end
        end
    end

    --Award without the zone limit if no options are possible for the zone.
    if Zone ~= nil and #Items == 0 then
        return self:AwardRandomItem(Player)
    end

    --Add a random item if one exists.
    if #Items > 0 then
        local ItemName = Items[math.random(1,#Items)]
        self:AddItem(Player,ItemName)
        return true,ItemName
    else
        return false
    end
end

--[[
Swaps two slots in a player's inventory.
--]]
function InventoryService:SwapSlots(Player,Slot1,Slot2)
    local PlayerInventory = self.PlayerInventories[Player]
    if PlayerInventory:CanSwap(Slot1,Slot2) then
        PlayerInventory:SwapSlots(Slot1,Slot2)
    end
end

--[[
Unlocks a chest for a player.
--]]
function InventoryService:UnlockChest(Player,Slot)
    --Return if the item isnt' a chest.
    local PlayerInventory = self.PlayerInventories[Player]
    local Item = PlayerInventory:GetItem(Slot)
    if not Item or (Item.Name ~= "Quest Chest" and Item.Name ~= "TreasureChest") then
        return
    end

    --Remove a key if it is a treasure chest.
    if Item.Name == "TreasureChest" then
        --Return if a key doesn't exist.
        local KeySlots = PlayerInventory:GetItemSlots("TreasureKey")
        if #KeySlots == 0 then
            return
        end

        --Remove a key.
        PlayerInventory:RemoveSlot(KeySlots[1])
    end

    --Remove the chest.
    PlayerInventory:RemoveSlot(Slot)

    --Add a new random item.
    self:AwardRandomItem(Player,Item.Zone)
end

--[[
Removes the items of a player's inventory.
--]]
function InventoryService:RemoveItemsByName(Player,Name)
    local PlayerInventory = self.PlayerInventories[Player]
    PlayerInventory:RemoveSlots(PlayerInventory:GetItemSlots(Name))
end

--[[
Deletes an item from a player's inventory.
--]]
function InventoryService:DeleteItem(Player,Slot)
    local PlayerInventory = self.PlayerInventories[Player]
    PlayerInventory:RemoveSlot(Slot)
end



return InventoryService