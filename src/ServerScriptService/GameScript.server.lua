--[[
TheNexusAvenger

Runs the game.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService"))



--Initialize the services.
for _,ServiceModule in pairs(ServerScriptServiceProject:GetResource("Service"):GetChildren()) do
    ServerScriptServiceProject:GetResource("Service."..ServiceModule.Name)
end