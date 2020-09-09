--[[
TheNexusAvenger

Extends the graph solver to add caching.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local GraphSolver = ReplicatedStorageProject:GetResource("State.PathFind.GraphSolver")

local CachedGraphSolver = GraphSolver:Extend()
CachedGraphSolver:SetClassName("CachedGraphSolver")



--[[
Creates a cached graph solver.
--]]
function CachedGraphSolver:__new()
    self:InitializeSuper()

    --Set up the cache.
    self.PathCache = {}
end

--[[
Adds an edge between 2 nodes.
--]]
function CachedGraphSolver:AddEdge(Id1,Id2)
    self.PathCache = {}
    self.super:AddEdge(Id1,Id2)
end

--[[
Returns the shortest distance between 2 nodes.
--]]
function CachedGraphSolver:GetShortestDistance(StartId,EndId)
    --Add the cache entry.
    if not self.PathCache[StartId] then
        self.PathCache[StartId] = {}
    end
    if not self.PathCache[StartId][EndId] then
        self.PathCache[StartId][EndId] = self.super:GetShortestDistance(StartId,EndId)
    end

    --Return the cached entry.
    return self.PathCache[StartId][EndId]
end



return CachedGraphSolver