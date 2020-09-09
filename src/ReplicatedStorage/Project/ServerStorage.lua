--[[
TheNexusAvenger

Project for fetching resources in ServerStorage.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local NexusProject = require(ReplicatedStorage:WaitForChild("ExternalUtil"):WaitForChild("NexusProject"))

return NexusProject.new(ServerStorage)