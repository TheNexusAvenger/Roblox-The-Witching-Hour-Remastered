--[[
TheNexusAvenger

Data for a command for giving items to players.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService"))
local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")



return {
    Keyword = "giveitems",
    Description = "Gives items to a set of players.",
    Arguments = {
        {
            Type = "nexusAdminPlayers",
            Name = "Players",
            Description = "Players to give items.",
        },
        {
            Type = "gameItems",
            Name = "Players",
            Description = "Items to give.",
        },
    },
    Run = function(self,CommandContext,Players,Items)
        for _,Player in pairs(Players) do
            for _,Item in pairs(Items) do
                InventoryService:AddItem(Player,Item)
            end
        end
    end
}