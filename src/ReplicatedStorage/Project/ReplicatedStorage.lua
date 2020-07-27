--[[
TheNexusAvenger

Project for fetching resources in ReplicatedStorage.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local NexusProject = require(ReplicatedStorage:WaitForChild("ExternalUtil"):WaitForChild("NexusProject"))

return NexusProject.new(ReplicatedStorage)