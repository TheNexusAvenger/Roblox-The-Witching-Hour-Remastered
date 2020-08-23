--[[
TheNexusAvenger

Controls the inventory of the player.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local ItemDataModule = ReplicatedStorageProject:GetObjectReference("GameData.ItemData")
local ItemData = ReplicatedStorageProject:GetResource("GameData.ItemData")
local Inventory = ReplicatedStorageProject:GetResource("UI.Inventory")

local InventoryService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
InventoryService:SetClassName("InventoryService")
InventoryService.PlayerInventories = {}
ServerScriptServiceProject:SetContextResource(InventoryService)



--[[
Initializes the inventory for a player.
--]]
function InventoryService:LoadPlayer(Player)
    self.PlayerInventories[Player] = Inventory.new(Player)
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



return InventoryService