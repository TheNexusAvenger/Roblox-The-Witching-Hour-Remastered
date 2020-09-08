--[[
TheNexusAvenger

Tests the GraphSolver class.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local GraphSolver = ReplicatedStorageProject:GetResource("State.PathFind.GraphSolver")



--[[
Setups up the test.
--]]
local GraphSolverTest = NexusUnitTesting.UnitTest:Extend()
function GraphSolverTest:Setup()
    --Create the component under testing.
    self.CuT = GraphSolver.new()

    --Add the nodes.
    self.CuT:AddNode("A",0,0)
    self.CuT:AddNode("B",2,0)
    self.CuT:AddNode("C",0,3)
    self.CuT:AddNode("D",4,4)
    self.CuT:AddNode("E",1,-4)
    self.CuT:AddNode("F",5,5)
    self.CuT:AddNode("G",10,10)
    self.CuT:AddNode("H",11,10)

    --Add the edges.
    self.CuT:AddEdge("A","B")
    self.CuT:AddEdge("A","C")
    self.CuT:AddEdge("A","E")
    self.CuT:AddEdge("B","D")
    self.CuT:AddEdge("C","D")
    self.CuT:AddEdge("D","F")
    self.CuT:AddEdge("E","D")
    self.CuT:AddEdge("E","F")
    self.CuT:AddEdge("G","H")
end

--[[
Returns the distance for a path.
--]]
function GraphSolverTest:GetPathLength(...)
    local Length = 0
    local Nodes = {...}
    for i = 2,#Nodes do
        Length = Length + self.CuT:GetDistance(Nodes[i - 1],Nodes[i])
    end
    return Length
end

--[[
Tests getting the shortest distance.
--]]
NexusUnitTesting:RegisterUnitTest(GraphSolverTest.new("TestGetShortestDistance"):SetRun(function(self)
    self:AssertEquals(self.CuT:GetShortestDistance("A","A"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","B"),self:GetPathLength("A","B"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","C"),self:GetPathLength("A","C"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","D"),self:GetPathLength("A","B","D"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","E"),self:GetPathLength("A","E"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","F"),self:GetPathLength("A","B","D","F"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","G"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("A","H"),nil,"Distance exists.")
    
    self:AssertEquals(self.CuT:GetShortestDistance("B","A"),self:GetPathLength("A","B"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","B"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","C"),self:GetPathLength("B","A","C"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","D"),self:GetPathLength("B","D"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","E"),self:GetPathLength("B","A","E"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","F"),self:GetPathLength("B","D","F"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","G"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("B","H"),nil,"Distance exists.")
    
    self:AssertEquals(self.CuT:GetShortestDistance("C","A"),self:GetPathLength("C","A"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","B"),self:GetPathLength("B","A","C"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","C"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","D"),self:GetPathLength("C","D"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","E"),self:GetPathLength("C","A","E"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","F"),self:GetPathLength("C","D","F"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","G"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("C","H"),nil,"Distance exists.")
    
    self:AssertEquals(self.CuT:GetShortestDistance("D","A"),self:GetPathLength("D","B","A"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","B"),self:GetPathLength("D","B"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","C"),self:GetPathLength("C","D"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","D"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","E"),self:GetPathLength("D","E"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","F"),self:GetPathLength("D","F"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","G"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("D","H"),nil,"Distance exists.")
    
    self:AssertEquals(self.CuT:GetShortestDistance("E","A"),self:GetPathLength("E","A"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","B"),self:GetPathLength("E","A","B"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","C"),self:GetPathLength("E","A","C"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","D"),self:GetPathLength("E","D"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","E"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","F"),self:GetPathLength("E","F"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","G"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("E","H"),nil,"Distance exists.")
    
    self:AssertEquals(self.CuT:GetShortestDistance("F","A"),self:GetPathLength("F","D","B","A"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","B"),self:GetPathLength("F","D","B"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","C"),self:GetPathLength("F","D","C"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","D"),self:GetPathLength("F","D"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","E"),self:GetPathLength("F","E"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","F"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","G"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("F","H"),nil,"Distance exists.")

    self:AssertEquals(self.CuT:GetShortestDistance("G","A"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","B"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","C"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","D"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","E"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","F"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","G"),0,"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("G","H"),self:GetPathLength("G","H"),"Distance is incorrect.")

    self:AssertEquals(self.CuT:GetShortestDistance("H","A"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","B"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","C"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","D"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","E"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","F"),nil,"Distance exists.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","G"),self:GetPathLength("H","G"),"Distance is incorrect.")
    self:AssertEquals(self.CuT:GetShortestDistance("H","H"),0,"Distance is incorrect.")
end))



return true