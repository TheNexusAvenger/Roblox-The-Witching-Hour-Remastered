--[[
TheNexusAvenger

Enum type for the game items.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")




return function(NexusAdminAPI)
    --Compile the list of items.
    local ItemNames = {}
	for ItemName,_ in pairs(ItemData) do
        table.insert(ItemNames,ItemName)
    end

    --Create the item type.
    local GameItemType = {
        Listable = true,
        
        --[[
        Transforms the string to a list of game items.
        --]]
        Transform = function(Text,Executor)
            return NexusAdminAPI.Cmdr.Util.MakeFuzzyFinder(ItemNames)(Text)
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
            return Items
        end,
    }

    --Register the types.
    NexusAdminAPI.Cmdr.Registry:RegisterType("gameItems",GameItemType)
end