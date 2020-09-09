--[[
TheNexusAvenger

Tests the MapGraphSolver class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local MapGraphSolver = ReplicatedStorageProject:GetResource("State.PathFind.MapGraphSolver")



--[[
Setups up the test.
--]]
local MapGraphSolverTest = NexusUnitTesting.UnitTest:Extend()
function MapGraphSolverTest:Setup()
    --Create the component under testing.
    self.CuT = MapGraphSolver.new()
end

--[[
Tests getting the cells for a line.
--]]
NexusUnitTesting:RegisterUnitTest(MapGraphSolverTest.new("TextGetCellsForLine"):SetRun(function(self)
    --[[
    Sorts 2 points.
    --]]
    local function SortPoints(Point1,Point2)
        if Point1.X ~= Point2.X then
            return Point1.X < Point2.X
        end
        return Point1.Y < Point2.Y
    end

    --[[
    Asserts that two sets of points match.
    --]]
    local function AssertLines(Line1,Line2)
        --Sort the lines.
        table.sort(Line1,SortPoints)
        table.sort(Line2,SortPoints)

        --Assert the lines are equal.
        self:AssertEquals(HttpService:JSONEncode(Line1),HttpService:JSONEncode(Line2),"Line points aren't the same.")
    end

    AssertLines(self.CuT:GetCellsForLine(5,5,5,5),{{X=5,Y=5}})
    AssertLines(self.CuT:GetCellsForLine(5,5,8,5),{{X=5,Y=5},{X=6,Y=5},{X=7,Y=5},{X=8,Y=5}})
    AssertLines(self.CuT:GetCellsForLine(8,5,5,5),{{X=5,Y=5},{X=6,Y=5},{X=7,Y=5},{X=8,Y=5}})
    AssertLines(self.CuT:GetCellsForLine(5,5,5,8),{{X=5,Y=5},{X=5,Y=6},{X=5,Y=7},{X=5,Y=8}})
    AssertLines(self.CuT:GetCellsForLine(5,8,5,5),{{X=5,Y=5},{X=5,Y=6},{X=5,Y=7},{X=5,Y=8}})
    AssertLines(self.CuT:GetCellsForLine(5,5,8,8),{{X=5,Y=5},{X=6,Y=6},{X=7,Y=7},{X=8,Y=8}})
    AssertLines(self.CuT:GetCellsForLine(8,8,5,5),{{X=5,Y=5},{X=6,Y=6},{X=7,Y=7},{X=8,Y=8}})
    AssertLines(self.CuT:GetCellsForLine(5,5,7,10),{{X=5,Y=5},{X=5,Y=6},{X=6,Y=7},{X=6,Y=8},{X=7,Y=9},{X=7,Y=10}})
    AssertLines(self.CuT:GetCellsForLine(7,10,5,5),{{X=5,Y=5},{X=5,Y=6},{X=6,Y=7},{X=6,Y=8},{X=7,Y=9},{X=7,Y=10}})
    AssertLines(self.CuT:GetCellsForLine(5,5,10,7),{{X=5,Y=5},{X=6,Y=5},{X=7,Y=6},{X=8,Y=6},{X=9,Y=7},{X=10,Y=7}})
    AssertLines(self.CuT:GetCellsForLine(10,7,5,5),{{X=5,Y=5},{X=6,Y=5},{X=7,Y=6},{X=8,Y=6},{X=9,Y=7},{X=10,Y=7}})
end))

--[[
Tests paths on the map being blocked.
--]]
NexusUnitTesting:RegisterUnitTest(MapGraphSolverTest.new("TestIsPathBlocked"):SetRun(function(self)
    --Assert lines over non-terrain and non-water arne't blocked.
    self:AssertFalse(self.CuT:IsPathBlocked(183,15,183,19),"Path is blocked.")
    self:AssertFalse(self.CuT:IsPathBlocked(173,35,178,63),"Path is blocked.")
    self:AssertFalse(self.CuT:IsPathBlocked(185,181,180,154),"Path is blocked.")
    self:AssertFalse(self.CuT:IsPathBlocked(13,88,55,100),"Path is blocked.")
    self:AssertFalse(self.CuT:IsPathBlocked(59,34,138,33),"Path is blocked.")

    --Asert lines over water and terrain are blocked.
    self:AssertTrue(self.CuT:IsPathBlocked(173,7,178,8),"Path isn't blocked.")
    self:AssertTrue(self.CuT:IsPathBlocked(187,15,192,15),"Path isn't blocked.")
    self:AssertTrue(self.CuT:IsPathBlocked(167,83,147,65),"Path isn't blocked.")
    self:AssertTrue(self.CuT:IsPathBlocked(149,62,152,67),"Path isn't blocked.")
    self:AssertTrue(self.CuT:IsPathBlocked(108,198,100,193),"Path isn't blocked.")
end))

--[[
Tests checking for road nodes.
--]]
NexusUnitTesting:RegisterUnitTest(MapGraphSolverTest.new("TestCellIsRoadNode"):SetRun(function(self)
    --Check non-roads not being nodes.
    self:AssertFalse(self.CuT:CellIsRoadNode(179,12),"Custom is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(177,10),"House is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(175,15),"Water is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(177,76),"Grass is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(182,26),"Swamp is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(181.148),"Pumpkins is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(181,1),"Rock is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(-1,-1),"Void is a node cell.")

    --Check road sections not being nodes.
    self:AssertFalse(self.CuT:CellIsRoadNode(173,10),"Horizontal road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(174,12),"Vertical road is a node cell.")

    --Check road ends being nodes.
    self:AssertTrue(self.CuT:CellIsRoadNode(199,7),"End road isn't a node cell.")
    self:AssertTrue(self.CuT:CellIsRoadNode(181,15),"End road isn't a node cell.")
    self:AssertTrue(self.CuT:CellIsRoadNode(191,63),"End road isn't a node cell.")
    self:AssertTrue(self.CuT:CellIsRoadNode(167,14),"End road isn't a node cell.")

    --Check road corners being nodes.
    self:AssertFalse(self.CuT:CellIsRoadNode(175,12),"Corner road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(175,14),"Corner road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(178,7),"Corner road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(186,11),"Corner road is a node cell.")

    --Check 3-way and 4-way road intersecitons not being nodes.
    self:AssertFalse(self.CuT:CellIsRoadNode(186,19),"3-way road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(186,22),"3-way road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(183,124),"3-way road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(172,177),"3-way road is a node cell.")
    self:AssertFalse(self.CuT:CellIsRoadNode(192,19),"4-way road is a node cell.")
end))



return true