--[[
TheNexusAvenger

Project for fetching resources in ServerScriptService.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local NexusProject = require(ReplicatedStorage:WaitForChild("ExternalUtil"):WaitForChild("NexusProject"))

return NexusProject.new(ServerScriptService)