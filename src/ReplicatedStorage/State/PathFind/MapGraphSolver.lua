--[[
TheNexusAvenger

Creates and solves graphs of the map.
--]]

local MAP_SIZE_X = 200
local MAP_SIZE_Y = 200



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local MapCells = ReplicatedStorageProject:GetResource("GameData.Generation.MapCells")
local NPCLocations = ReplicatedStorageProject:GetResource("GameData.Generation.NPCLocations")
local CachedGraphSolver = ReplicatedStorageProject:GetResource("State.PathFind.CachedGraphSolver")

local MapGraphSolver = CachedGraphSolver:Extend()
MapGraphSolver:SetClassName("MapGraphSolver")



--[[
Creates a map graph solver.
--]]
function MapGraphSolver.Create()
    local Solver = MapGraphSolver.new()
    Solver:PopulateMapData()
    return Solver
end

--[[
Returns the cells between 2 points.
--]]
function MapGraphSolver:GetCellsForLine(StartX,StartY,EndX,EndY)
    local Points = {}
    local UsedPointsMap = {}

    --[[
    Adds a point.
    --]]
    local function AddPoint(X,Y)
        if not UsedPointsMap[tostring(X).."_"..tostring(Y)] then
            table.insert(Points,{X=X,Y=Y})
            UsedPointsMap[tostring(X).."_"..tostring(Y)] = true
        end
    end
    AddPoint(StartX,StartY)
    AddPoint(EndX,EndY)

    --Add the cells going in the X direction.
    if StartX ~= EndX then
        if EndX < StartX then
            StartX,EndX = EndX,StartX
            StartY,EndY = EndY,StartY
        end
        for X = StartX,EndX do
            local Ratio = (X - StartX)/(EndX - StartX)
            AddPoint(X,math.round(StartY + ((EndY - StartY) * Ratio)))
        end
    end

    --Add the cells going in the Y direction.
    if StartY ~= EndY then
        if EndY < StartY then
            StartX,EndX = EndX,StartX
            StartY,EndY = EndY,StartY
        end
        for Y = StartY,EndY do
            local Ratio = (Y - StartY)/(EndY - StartY)
            AddPoint(math.round(StartX + ((EndX - StartX) * Ratio)),Y)
        end
    end

    --Return the points.
    return Points
end

--[[
Returns the cell type for a given position.
--]]
function MapGraphSolver:GetCellType(X,Y)
    if not MapCells[X] then
        return -1
    end
    return MapCells[X][Y] or -1
end

--[[
Returns if a path is blocked.
--]]
function MapGraphSolver:IsPathBlocked(StartX,StartY,EndX,EndY)
    --Return true if the path hits rock or water.
    for _,Cell in pairs(self:GetCellsForLine(StartX,StartY,EndX,EndY)) do
        local CellType = self:GetCellType(Cell.X,Cell.Y)
        if CellType == 4 or CellType == 5 then
            return true
        end
    end

    --Return false (not blocked).
    return false
end

--[[
Returns if a cell is a road node.
--]]
function MapGraphSolver:CellIsRoadNode(X,Y)
    --Return if the cell isn't a road.
    if self:GetCellType(X,Y) ~= 6 then
        return false
    end

    --Return depending on the surrounding cells.
    local TopIsRoad,BottomIsRoad,LeftIsRoad,RightIsRoad = self:GetCellType(X,Y + 1) == 6,self:GetCellType(X,Y - 1) == 6,self:GetCellType(X + 1,Y) == 6,self:GetCellType(X - 1,Y) == 6
    if TopIsRoad and not BottomIsRoad and not LeftIsRoad and not RightIsRoad then
        return true
    elseif not TopIsRoad and BottomIsRoad and not LeftIsRoad and not RightIsRoad then
        return true
    elseif not TopIsRoad and not BottomIsRoad and LeftIsRoad and not RightIsRoad then
        return true
    elseif not TopIsRoad and not BottomIsRoad and not LeftIsRoad and RightIsRoad then
        return true
    end
    return false
end

--[[
Populates the nodes for the connected roads.
--]]
function MapGraphSolver:PopulateConnectedRoads()
    --Create the nodes.
    local Nodes = {}
    for X = 1,MAP_SIZE_X do
        for Y = 1,MAP_SIZE_Y do
            if self:GetCellType(X,Y) == 6 then
                local TopIsRoad,BottomIsRoad,LeftIsRoad,RightIsRoad = self:GetCellType(X,Y + 1) == 6,self:GetCellType(X,Y - 1) == 6,self:GetCellType(X + 1,Y) == 6,self:GetCellType(X - 1,Y) == 6
                if not (TopIsRoad and BottomIsRoad and not LeftIsRoad and not RightIsRoad) and not (not TopIsRoad and not BottomIsRoad and LeftIsRoad and RightIsRoad) then
                    local Id = tostring(X).."_"..tostring(Y)
                    Nodes[Id] = {X,Y,Id,LeftIsRoad,TopIsRoad}
                    self:AddNode(Id,X,Y)
                end
            end
        end
    end

    --Connect the nodes.
    --Only the top and right are checked since they connect to left and bottom.
    for NodeId,Node in pairs(Nodes) do
        --Connect to the right.
        if Node[4] then
            for X = Node[1] + 1,MAP_SIZE_X do
                local RightId = tostring(X).."_"..tostring(Node[2])
                if Nodes[RightId] then
                    self:AddEdge(NodeId,RightId)
                    break
                end
            end
        end

        --Connect to the top.
        if Node[5] then
            for Y = Node[2] + 1,MAP_SIZE_Y do
                local TopId = tostring(Node[1]).."_"..tostring(Y)
                if Nodes[TopId] then
                    self:AddEdge(NodeId,TopId)
                    break
                end
            end
        end
    end
end

--[[
Populates the nodes for the road ends.
--]]
function MapGraphSolver:PopulateRoadEnds()
    --Create the nodes.
    local Nodes = {}
    for X = 1,MAP_SIZE_X do
        for Y = 1,MAP_SIZE_Y do
            if self:CellIsRoadNode(X,Y) then
                local Id = tostring(X).."_"..tostring(Y)
                table.insert(Nodes,{X,Y,Id})
                self:AddNode(Id,X,Y)
            end
        end
    end

    --Create the edges between the closest end nodes.
    --All possible edges aren't created due to performance reasons.
    for i = 1,#Nodes do
        --Add the nodes and sort by the closest.
        local Start = Nodes[i]
        local ConnectableNodes,Distances = {},{}
        for j = i + 1,#Nodes do
            table.insert(ConnectableNodes,j)
            Distances[j] = self:GetDistance(Start[3],Nodes[j][3])
        end
        table.sort(ConnectableNodes,function(a,b)
            return Distances[a] < Distances[b]
        end)

        --Add the edge.
        for _,EndId in pairs(ConnectableNodes) do
            local End = Nodes[EndId]
            if not self:IsPathBlocked(Start[1],Start[2],End[1],End[2]) then
                self:AddEdge(Start[3],End[3])
                break
            end
        end
    end
end

--[[
Connects the NPCs to the nearest nodes.
--]]
function MapGraphSolver:PopulateNPCs()
    --Create the nodes.
    local Nodes = {}
    for _,NPCLocationData in pairs(NPCLocations) do
        local X,Y = NPCLocationData.CellX,NPCLocationData.CellY
        local Id = tostring(X).."_"..tostring(Y)
        Nodes[Id] = {X,Y,Id}
        self:AddNode(Id,X,Y)
    end

    --Connect the NPCs to the nearest nodes.
    for _,Start in pairs(Nodes) do
        --Get the closest node.
        local LowestDistance,ClosestNodeId = math.huge,nil
        for Id,_ in pairs(self.Nodes) do
            if Id ~= Start[3] and not Nodes[Id] then
                local Distance = self:GetDistance(Start[3],Id)
                if Distance < LowestDistance then
                    LowestDistance = Distance
                    ClosestNodeId = Id
                end
            end
        end

        --Create the edge.
        if ClosestNodeId then
            self:AddEdge(Start[3],ClosestNodeId)
        end
    end
end

--[[
Populates the nodes and edges with the map data.
--]]
function MapGraphSolver:PopulateMapData()
    self:PopulateRoadEnds()
    self:PopulateConnectedRoads()
    self:PopulateNPCs()
end



return MapGraphSolver