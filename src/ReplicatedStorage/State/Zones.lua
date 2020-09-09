--[[
TheNexusAvenger

Utility for zones.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local NPCLocations = ReplicatedStorageProject:GetResource("GameData.Generation.NPCLocations")
local MapGraphSolver = ReplicatedStorageProject:GetResource("State.PathFind.MapGraphSolver")

local Zones = NexusObject:Extend()
Zones.CachedResults = {}
Zones.MapGraph = MapGraphSolver.Create()
Zones:SetClassName("Zones")



--[[
Returns the zone for a given cell.
The cell can be decimal.
--]]
function Zones:GetZone(X,Y)
    X,Y = math.round(X),math.round(Y)
    local ZoneId = tostring(X).."_"..tostring(Y)

    --Populate the cached entry.
    if not self.CachedResults[ZoneId] then
        --Determine the closest node.
        local LowestDistanceToNode,ClosestNode = math.huge,nil
        for Id,Node in pairs(self.MapGraph.Nodes) do
            local Distance = (((X - Node.X) ^ 2) + ((Y - Node.Y) ^ 2)) ^ 0.5
            if Distance < LowestDistanceToNode then
                LowestDistanceToNode = Distance
                ClosestNode = Id
            end
        end

        --Determine the closest NPC's zone.
        local LowestDistanceToNPC,ClosestZone = math.huge,nil
        for _,NPCLocationData in pairs(NPCLocations) do
            local NPCId = tostring(NPCLocationData.CellX).."_"..tostring(NPCLocationData.CellY)
            local Distance = self.MapGraph:GetShortestDistance(ClosestNode,NPCId)
            if Distance < LowestDistanceToNPC then
                LowestDistanceToNPC = Distance
                ClosestZone = NPCLocationData.Zone
            end
        end

        --Store the closest zone.
        self.CachedResults[ZoneId] = ClosestZone
    end

    --Return the cached entry.
    return self.CachedResults[ZoneId]
end



return Zones