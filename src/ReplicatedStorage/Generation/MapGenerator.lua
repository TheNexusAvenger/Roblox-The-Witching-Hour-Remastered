--[[
TheNexusAvenger

Generates the map from the map data.
--]]

local CELLS_PER_PASS = 10
local MAP_RADIUS = 10
local CLEAR_MAP_RADIUS = 13
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
    Swamp = ReplicatedStorageProject:GetResource("Generation.Cell.SwampCell"),
    Pumpkins = ReplicatedStorageProject:GetResource("Generation.Cell.PumpkinsCell"),
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

    self.QueuedAction = {}
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
    local CellId = tostring(X).."_"..tostring(Y)
    if self.Cells[CellId] then
        return
    end

    --Create and store the cell.
    local CellType = self:GetCellType(X,Y)
    if CellGenerators[CellType] then
        self.Cells[CellId] = CellGenerators[CellType].new(X,Y,self:GetCellType(X,Y+1),self:GetCellType(X,Y-1),self:GetCellType(X-1,Y),self:GetCellType(X+1,Y))
    end
end

--[[
Performs a pass on the queued cells.
--]]
function MapGenerator:UpdateQueuedCells()
    --Fetch the cells to update.
    local CellsToUpdate = {}
    for CellId,_ in pairs(self.QueuedAction) do
        table.insert(CellsToUpdate,CellId)
        if #CellsToUpdate >= CELLS_PER_PASS then
            break
        end
    end

    --Generate the cells.
    for _,CellId in pairs(CellsToUpdate) do
        local Action = self.QueuedAction[CellId]
        if Action[1] == "CREATE" then
            self:GenerateCell(Action[2],Action[3])
        elseif Action[1] == "DELETE" then
            self.Cells[CellId]:Destroy()
            self.Cells[CellId] = nil
        end
        self.QueuedAction[CellId] = nil
    end
end

--[[
Queues generating a cell.
--]]
function MapGenerator:QueueGenerateCell(X,Y)
    local CellId = tostring(X).."_"..tostring(Y)
    if not self.Cells[CellId] and not self.QueuedAction[CellId] then
        self.QueuedAction[CellId] = {"CREATE",X,Y}
    end
end

--[[
Queues deleting a cell.
--]]
function MapGenerator:QueueDeleteCell(X,Y)
    local CellId = tostring(X).."_"..tostring(Y)
    if self.Cells[CellId] and not self.QueuedAction[CellId] then
        self.QueuedAction[CellId] = {"DELETE",X,Y}
    end
end

--[[
Generates the cells centered around a region.
--]]
function MapGenerator:GenerateCells(CenterX,CenterY)
    --Generate the cell the player is in.
    self:GenerateCell(CenterX,CenterY)

    --Queue generating the cells.
    for X = CenterX - MAP_RADIUS,CenterX + MAP_RADIUS do
        for Y = CenterY - MAP_RADIUS,CenterY + MAP_RADIUS do
            self:QueueGenerateCell(X,Y)
        end
    end

    --Queue deleting cells.
    for _,Cell in pairs(self.Cells) do
        if math.abs(Cell.X - CenterX) >= CLEAR_MAP_RADIUS or math.abs(Cell.Y - CenterY) >= CLEAR_MAP_RADIUS then
            self:QueueDeleteCell(Cell.X,Cell.Y)
        end
    end
end



return MapGenerator