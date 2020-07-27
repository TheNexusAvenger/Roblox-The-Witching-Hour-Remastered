--[[
TheNexusAvenger

Generates the map from the map data.
--]]

local MAP_RADIUS = 20
local ID_TO_CELL_TYPE = {
    [-1] = "None",
    [0] = "Custom",
    [1] = "Grass",
    [2] = "Swamp",
    [3] = "Pumpkins",
    [4] = "Water",
    [5] = "Rock",
    [6] = "Road",
    [7] = "House",
}



local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local MapCellData = ReplicatedStorageProject:GetResource("GameData.MapCellData")
local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local CellGenerators = {
    Grass = ReplicatedStorageProject:GetResource("Generation.Cell.GrassCell"),
    --Swamp = ReplicatedStorageProject:GetResource("Generation.Cell.SwampCell"),
    --Pumpkins = ReplicatedStorageProject:GetResource("Generation.Cell.PumpkinsCell"),
    Water = ReplicatedStorageProject:GetResource("Generation.Cell.WaterCell"),
    Rock = ReplicatedStorageProject:GetResource("Generation.Cell.RockCell"),
    Road = ReplicatedStorageProject:GetResource("Generation.Cell.RoadCell"),
    House = ReplicatedStorageProject:GetResource("Generation.Cell.HouseCell"),
}

local MapGenerator = NexusObject:Extend()
MapGenerator:SetClassName("MapGenerator")



--[[
Creates the map generator.
--]]
function MapGenerator:__new()
    self:InitializeSuper()

    self.Cells = {}
end

--[[
Returns the cell name at a given coordinate.
--]]
function MapGenerator:GetCellType(X,Y)
    if not MapCellData[X] then
        return ID_TO_CELL_TYPE[-1]
    end
    return ID_TO_CELL_TYPE[MapCellData[X][Y] or -1]
end

--[[
Generates a cell.
--]]
function MapGenerator:GenerateCell(X,Y)
    --Return if the cell exists.
    if not self.Cells[X] then
        self.Cells[X] = {}
    end
    if self.Cells[X][Y] then
        return
    end

    --Create and store the cell.
    local CellType = self:GetCellType(X,Y)
    if CellGenerators[CellType] then
        self.Cells[X][Y] = CellGenerators[CellType].new(X,Y,self:GetCellType(X,Y+1),self:GetCellType(X,Y-1),self:GetCellType(X-1,Y),self:GetCellType(X+1,Y))
    end
end

--[[
Generates the cells centered around a region.
--]]
function MapGenerator:GenerateCells(CenterX,CenterY)
    for X = CenterX - MAP_RADIUS,CenterX + MAP_RADIUS do
        for Y = CenterY - MAP_RADIUS,CenterY + MAP_RADIUS do
            self:GenerateCell(X,Y)
        end
    end
end



return MapGenerator