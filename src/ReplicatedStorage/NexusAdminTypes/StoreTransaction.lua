--[[
TheNexusAvenger

Enum type for the store transactions.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local StoreItems = ReplicatedStorageProject:GetResource("GameData.Item.Store")




return function(NexusAdminAPI)
    --Compile the list of transactions.
    local TransactionNames = {}
    local TransactionNamesToId = {}
	for Id,Transaction in pairs(StoreItems) do
        table.insert(TransactionNames,Transaction.TransactionName)
        TransactionNamesToId[Transaction.TransactionName] = Id
    end

    --Create the item type.
    local GameItemType = {
        --[[
        Transforms the string to a list of store transactions.
        --]]
        Transform = function(Text,Executor)
            return NexusAdminAPI.Cmdr.Util.MakeFuzzyFinder(TransactionNames)(Text)
        end,

        --[[
        Returns if the input is valid and an error message
        for when it is invalid.
        --]]
        Validate = function(Items)
            return #Items > 0,"No items were found matching that query."
        end,
    
        --[[
        Returns the results for auto completing.
        --]]
        Autocomplete = function(Items)
            return Items
        end,
    
        --[[
        Returns the value to use.
        --]]
        Parse = function(Items)
            return TransactionNamesToId[Items[1]]
        end,
    }

    --Register the types.
    NexusAdminAPI.Cmdr.Registry:RegisterType("gameStoreTransaction",GameItemType)
end