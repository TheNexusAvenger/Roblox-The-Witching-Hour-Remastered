--[[
TheNexusAvenger

Handles purchases by players.
Class is static (should not be created).
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MarketplaceService = game:GetService("MarketplaceService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local StoreItems = ReplicatedStorageProject:GetResource("GameData.Item.Store")
local GameReplication = ReplicatedStorageProject:GetResource("GameReplication")

local StoreService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
StoreService:SetClassName("StoreService")
ServerScriptServiceProject:SetContextResource(StoreService)

local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")



--Set up the replication.
local StoreReplication = Instance.new("Folder")
StoreReplication.Name = "StoreReplication"
StoreReplication.Parent = GameReplication

local PurchaseItem = Instance.new("RemoteFunction")
PurchaseItem.Name = "PurchaseItem"
PurchaseItem.Parent = StoreReplication

PurchaseItem.OnServerInvoke = function(Player,TransactionId)
    return StoreService:PurchaseItemWithCoins(Player,TransactionId)
end



--[[
Completes a transaction.
--]]
function StoreService:CompleteTransaction(Player,TransactionId)
    --Return false if the transaction doesn't exists.
    local Transaction = StoreItems[TransactionId]
    if not Transaction then
        return false
    end

    --Return if the transaction can't be satisfied.
    local Inventory = InventoryService:GetInventory(Player)
    local PlayerData = PlayerDataService:GetPlayerData(Player)
    if Transaction.CanPurchase and not Transaction.CanPurchase(Player) then
        return false
    end
    if Transaction.Type == "Item" then
        if not Inventory:GetNextOpenSlot() then
            return false
        end
        if Transaction.AllowMultiple ~= true and #Inventory:GetItemSlots(Transaction.ItemName) > 0 then
            return false
        end
    end

    --Complete the transaction and return true.
    if Transaction.HandlePurchase then
        Transaction.HandlePurchase(Player)
    elseif Transaction.Type == "Item" then
        InventoryService:AddItem(Player,Transaction.ItemName)
    elseif Transaction.Type == "Candy" then
        PlayerData:SetValue("Currency",PlayerData:GetValue("Currency") + Transaction.CandyAmount)
    end
    return true
end

--[[
Purchases an item with coins.
--]]
function StoreService:PurchaseItemWithCoins(Player,TransactionId)
    --Return false if the transaction doesn't exists.
    local Transaction = StoreItems[TransactionId]
    if not Transaction then
        return false
    end

    --Return false if the transaction isn't coin based.
    if not Transaction.CostCandy then
        return false
    end

    --Return false if the player doesn't have enough coins.
    local PlayerData = PlayerDataService:GetPlayerData(Player)
    if PlayerData:GetValue("Currency") < Transaction.CostCandy then
        return false
    end

    --Complete the transaction and return if it worked.
    local TransactionCompleted = self:CompleteTransaction(Player,TransactionId)
    if TransactionCompleted then
        PlayerData:SetValue("Currency",PlayerData:GetValue("Currency") - Transaction.CostCandy)
    end
    return TransactionCompleted
end



--Set up handling Robux purchases.
MarketplaceService.ProcessReceipt = function(Receipt)
    local UserId,ProductId = Receipt.PlayerId,Receipt.ProductId

    --Return not processed if the player is not in the game.
    local Player = Players:GetPlayerByUserId(UserId)
    if not Player then
        return Enum.ProductPurchaseDecision.NotProcessedYet
    end

    --Return not processed if the transaction doesn't exist.
    local TransactionId
    for Id,Transaction in pairs(StoreItems) do
        if Transaction.ProductId == ProductId then
            TransactionId = Id
            break
        end
    end
    if not TransactionId then
        return Enum.ProductPurchaseDecision.NotProcessedYet
    end

    --Return based on the result of the transaction.
    if StoreService:CompleteTransaction(Player,TransactionId) then
        return Enum.ProductPurchaseDecision.PurchaseGranted
    else
        return Enum.ProductPurchaseDecision.NotProcessedYet
    end
end



return StoreService