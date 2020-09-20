--[[
TheNexusAvenger

Tests the MapCells being valid.
--]]

local NexusUnitTesting = require("NexusUnitTesting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local MapCells = ReplicatedStorageProject:GetResource("GameData.Generation.MapCells")

local MapCellsTest = NexusUnitTesting.UnitTest:Extend()



--[[
Tests for invalid cells.
--]]
NexusUnitTesting:RegisterUnitTest(MapCellsTest.new("TestInvalidCells"):SetRun(function(self)
    --Get the invalid cells.
    local InvalidCells = ""
    for X = 1,200 do
        for Y = 1,200 do
            local Id = MapCells[X][Y]
            if Id ~= 0 and Id ~= 1 and Id ~= 2 and Id ~= 3 and Id ~= 4 and Id ~= 5 and Id ~= 6 and Id ~= 7 then
                InvalidCells = InvalidCells.."\n"..tostring(X)..","..tostring(Y)
            end
        end
    end

    --Fail the test if invalid houses exist.
    if InvalidCells ~= "" then
        self:Fail("The following cells have an invalid id:"..InvalidCells)
    end
end))

--[[
Tests the houses being valid (connected
to 1 road).
--]]
NexusUnitTesting:RegisterUnitTest(MapCellsTest.new("TestHouses"):SetRun(function(self)
    --Get the invalid cells.
    local InvalidCells = ""
    for X = 2,199 do
        for Y = 2,199 do
            if MapCells[X][Y] == 7 then
                if MapCells[X - 1][Y] ~= 6 and MapCells[X + 1][Y] ~= 6 and MapCells[X][Y - 1]~= 6 and MapCells[X][Y + 1] ~= 6 then
                    InvalidCells = InvalidCells.."\n"..tostring(X)..","..tostring(Y)
                end
            end
        end
    end

    --Fail the test if invalid houses exist.
    if InvalidCells ~= "" then
        self:Fail("The following house cells are disconnected:"..InvalidCells)
    end
end))



return true