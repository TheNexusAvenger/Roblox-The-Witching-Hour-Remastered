--[[
TheNexusAvenger

Implementation of A* to find the shortest paths.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local GraphSolver = NexusObject:Extend()
GraphSolver:SetClassName("GraphSolver")



--[[
Creates a graph solver.
--]]
function GraphSolver:__new()
    self:InitializeSuper()

    --Set up the state.
    self.Nodes = {}
    self.Edges = {}
end

--[[
Adds a node to the graph.
--]]
function GraphSolver:AddNode(Id,X,Y)
    if not self.Nodes[Id] then
        self.Nodes[Id] = {X=X,Y=Y}
        self.Edges[Id] = {}
    end
end

--[[
Adds an edge between 2 nodes.
--]]
function GraphSolver:AddEdge(Id1,Id2)
    --Return if the edge exists.
    for _,EdgeId in pairs(self.Edges[Id1]) do
        if EdgeId == Id2 then
            return
        end
    end

    --Add the edge.
    table.insert(self.Edges[Id1],Id2)
    table.insert(self.Edges[Id2],Id1)
end

--[[
Returns the distance between 2 nodes.
--]]
function GraphSolver:GetDistance(Id1,Id2)
    return (((self.Nodes[Id1].X - self.Nodes[Id2].X) ^ 2) + ((self.Nodes[Id1].Y - self.Nodes[Id2].Y) ^ 2)) ^ 0.5
end

--[[
Returns the shortest distance between 2 nodes.
--]]
function GraphSolver:GetShortestDistance(StartId,EndId)
    local TotalOpenNodes = 1
    local OpenNodes,ClosedNodes = {},{}
    local GScores,FScores = {},{}
    OpenNodes[StartId] = true
    GScores[StartId] = 0
    FScores[StartId] = self:GetDistance(StartId,EndId)

    while TotalOpenNodes > 0 do
        --Determine the next lowest node.
        local LowestFScore,LowesetNodeId = math.huge,nil
        for NodeId,_  in pairs(OpenNodes) do
            local FScore = FScores[NodeId]
            if FScore < LowestFScore then
                LowestFScore = FScore
                LowesetNodeId = NodeId
            end
        end

        --Return if the current node is the target.
        if LowesetNodeId == EndId then
            return GScores[EndId]
        end

        --Move the node to the used set.
        OpenNodes[LowesetNodeId] = nil
        TotalOpenNodes = TotalOpenNodes - 1
        ClosedNodes[LowesetNodeId] = true

        --Add the neighbor nodes if they aren't used already.
        for _,NeighborNodeId in pairs(self.Edges[LowesetNodeId]) do
            if not ClosedNodes[NeighborNodeId] then
                local NewGScore = GScores[LowesetNodeId] + self:GetDistance(LowesetNodeId,NeighborNodeId)
                if not GScores[NeighborNodeId] or NewGScore < GScores[NeighborNodeId] then
                    GScores[NeighborNodeId] = NewGScore
                    FScores[NeighborNodeId] = NewGScore + self:GetDistance(NeighborNodeId,EndId)
                    if not OpenNodes[NeighborNodeId] then
                        OpenNodes[NeighborNodeId] = true
                        TotalOpenNodes = TotalOpenNodes + 1
                    end
                end
            end
        end
    end
end



return GraphSolver