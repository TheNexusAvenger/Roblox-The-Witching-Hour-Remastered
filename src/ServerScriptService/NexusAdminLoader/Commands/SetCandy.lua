--[[
TheNexusAvenger

Data for a command for setting candy.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService"))
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")



return {
    Keyword = "setcandy",
    Description = "Sets the candy for a set of players.",
    Arguments = {
        {
            Type = "nexusAdminPlayers",
            Name = "Players",
            Description = "Players to set candy.",
        },
        {
            Type = "integer",
            Name = "Candy",
            Description = "Candy value to set to.",
        },
    },
    Run = function(self,CommandContext,Players,Candy)
        for _,Player in pairs(Players) do
            PlayerDataService:GetPlayerData(Player):SetValue("Currency",Candy)
        end
    end
}