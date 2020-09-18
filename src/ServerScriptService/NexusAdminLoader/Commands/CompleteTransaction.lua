
--[[
TheNexusAvenger

Data for a command for completing mock transactions.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService"))
local StoreService = ServerScriptServiceProject:GetResource("Service.StoreService")



return {
    Keyword = "completetransaction",
    Description = "Completes a mock transaction a set of players.",
    Arguments = {
        {
            Type = "nexusAdminPlayers",
            Name = "Players",
            Description = "Players to complete transactions.",
        },
        {
            Type = "gameStoreTransaction",
            Name = "Transaction",
            Description = "Transaction to perform.",
        },
    },
    Run = function(self,CommandContext,Players,TransactionId)
        local Result = ""
        for _,Player in pairs(Players) do
            if Result ~= "" then Result = Result.."\n" end
            if StoreService:CompleteTransaction(Player,TransactionId) then
                Result = Result.."Transaction for "..Player.Name.." worked."
            else
                Result = Result.."Transaction for "..Player.Name.." failed."
            end
        end
        return Result
    end
}