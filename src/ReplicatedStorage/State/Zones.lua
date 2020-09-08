--[[
TheNexusAvenger

Utility for zones.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local Zones = NexusObject:Extend()
Zones.CachedResults = {}
Zones.MapGraph = nil --TODO: Implement
Zones:SetClassName("Zones")



--[[
Returns the zone for a given cell.
--]]
function Zones:GetZone(X,Y)

end



return Zones