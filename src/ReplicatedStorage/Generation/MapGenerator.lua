--[[
TheNexusAvenger

Generates the map from the map data.
--]]

local NORMAL_CELLS_PER_PASS = 3
local ACCELERATED_CELL_CREATION_THRESHOLD = 50
local ACCELERATED_CELLS_PER_PASS_MULTIPLIER = 0.25
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
local CUSTOM_CELLS = {
    --Builderman's Town hall.
    {180,12,"BaseGrass"},
    {180,13,"BaseGrass"},
    {180,14,"BaseGrass"},
    {179,12,"BaseGrass"},
    {179,13,"BaseGrass"},
    {179,14,"BaseGrass"},

    --Center statue.
    {174,13,"BaseGrass"},

    --ReeseMcBlox's House.
    {119,33,"BaseGrass"},

    --Tarabyte's House.
    {64,35,"BaseGrass"},
    {64,36,"BaseGrass"},
    {63,35,"BaseGrass"},
    {63,36,"BaseGrass"},

    --Sorcus's Graveyard.
    {24,9,"BaseGrass"},
    
    --ChiefJustus's Cave.
    {61,54,"BaseGrass"},

    --SolarCrane's Log Mansion.
    {14,87,"BaseGrass"},
    {14,88,"BaseGrass"},
    {13,87,"BaseGrass"},
    {13,88,"BaseGrass"},

    --Jeditkacheff's Swamp Cabin.
    {153,74,"Swamp"},

    --Shedletskys' Houses.
    {199,103,"BaseGrass"},
    {199,104,"BaseGrass"},
    {197,103,"BaseGrass"},
    {197,104,"BaseGrass"},

    --OstrichSized's Pyramic.
    {106,117,"BaseGrass"},
    {106,118,"BaseGrass"},
    {105,117,"BaseGrass"},
    {105,118,"BaseGrass"},

    --OnlyTwentyCharacter's Log Cabin.
    {20,162,"BaseGrass"},

    --StickMasterLuke's Barn.
    {175,177,"BaseGrass"},
    {175,178,"BaseGrass"},
    {174,177,"BaseGrass"},
    {174,178,"BaseGrass"},
    {173,177,"BaseGrass"},
    {173,178,"BaseGrass"},

    --Fusroblox's Mansion.
    {100,194,"BaseGrass"},
    {100,195,"BaseGrass"},
    {100,196,"BaseGrass"},
    {99,194,"BaseGrass"},
    {99,195,"BaseGrass"},
    {99,196,"BaseGrass"},
}


local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local MapCellData = ReplicatedStorageProject:GetResource("GameData.MapCellData")
local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local CellGenerators = {
    BaseGrass = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell"),
    Grass = ReplicatedStorageProject:GetResource("Generation.Cell.GrassCell"),
    Swamp = ReplicatedStorageProject:GetResource("Generation.Cell.SwampCell"),
    Pumpkins = ReplicatedStorageProject:GetResource("Generation.Cell.PumpkinsCell"),
    Water = ReplicatedStorageProject:GetResource("Generation.Cell.WaterCell"),
    Rock = ReplicatedStorageProject:GetResource("Generation.Cell.RockCell"),
    Road = ReplicatedStorageProject:GetResource("Generation.Cell.RoadCell"),
    House = ReplicatedStorageProject:GetResource("Generation.Cell.HouseCell"),
}
local CustomStructures = {
    [ReplicatedStorageProject:GetResource("Generation.CustomStructures.TownHall")] = {179,13},
}

local MapGenerator = NexusObject:Extend()
MapGenerator:SetClassName("MapGenerator")



--[[
Creates the map generator.
--]]
function MapGenerator:__new()
    self:InitializeSuper()

    self.LastX = 0
    self.LastY = 0
    self.QueuedAction = {}
    self.TotalQueuedCreateActions = 0
    self.Cells = {}
end

--[[
Generates the custom cells.
--]]
function MapGenerator:GenerateCustomCells()
    --Generate the cells.
    for _,CellData in pairs(CUSTOM_CELLS) do
        local X,Y = CellData[1],CellData[2]
        CellGenerators[CellData[3]].new(X,Y,self:GetCellType(X,Y+1),self:GetCellType(X,Y-1),self:GetCellType(X-1,Y),self:GetCellType(X+1,Y))
    end

    --Generate the structures.
    for StructureModel,Location in pairs(CustomStructures) do
        local NewStructureModel = StructureModel:Clone()
        NewStructureModel:SetPrimaryPartCFrame(CFrame.new(Location[1] * 100,-0.5,Location[2] * 100))
        NewStructureModel.Parent = Workspace
    end

    --Generate the NPCs.
    --TODO
end

--[[
Returns if a cell position is in the range
of the last call.
--]]
function MapGenerator:CellInLastCall(X,Y)
    return math.abs(X - self.LastX) < CLEAR_MAP_RADIUS and math.abs(Y - self.LastY) < CLEAR_MAP_RADIUS
end

--[[
Returns the cell id at a given coordinate.
--]]
function MapGenerator:GetCellTypeId(X,Y)
    if not MapCellData[X] then
        return -1
    end
    return MapCellData[X][Y] or -1
end

--[[
Returns the cell name at a given coordinate.
--]]
function MapGenerator:GetCellType(X,Y)
    return ID_TO_CELL_TYPE[self:GetCellTypeId(X,Y)]
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
    --Determine how many cells to create.
    local MaxCellsToCreate = NORMAL_CELLS_PER_PASS
    if self.TotalQueuedCreateActions >= ACCELERATED_CELL_CREATION_THRESHOLD then
        MaxCellsToCreate = math.ceil(self.TotalQueuedCreateActions * ACCELERATED_CELLS_PER_PASS_MULTIPLIER)
    end

    --Fetch the cells to update.
    local CellsToUpdate = {}
    local CreateCellCalls = 0
    for CellId,Action in pairs(self.QueuedAction) do
        --Ignore the cell if it shouldn't be created.
        if Action[1] == "CREATE" and not self:CellInLastCall(Action[2],Action[3]) then
            Action[1] = "IGNORE"
            self.TotalQueuedCreateActions = self.TotalQueuedCreateActions - 1
        end

        --Add the cell to update.
        table.insert(CellsToUpdate,CellId)
        if Action[1] == "CREATE" then
            CreateCellCalls = CreateCellCalls + 1
        end
        if CreateCellCalls >= MaxCellsToCreate then
            break
        end
    end

    --Generate the cells.
    for _,CellId in pairs(CellsToUpdate) do
        local Action = self.QueuedAction[CellId]
        if Action[1] == "CREATE" then
            self:GenerateCell(Action[2],Action[3])
            self.TotalQueuedCreateActions = self.TotalQueuedCreateActions - 1
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
    if not self.Cells[CellId] and not self.QueuedAction[CellId] and self:GetCellTypeId(X,Y) >= 1 then
        self.QueuedAction[CellId] = {"CREATE",X,Y}
        self.TotalQueuedCreateActions = self.TotalQueuedCreateActions + 1
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
    --Return if the position didn't change.
    if CenterX == self.LastX and CenterY == self.LastY then
        return
    end
    self.LastX,self.LastY = CenterX,CenterY

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
        if not self:CellInLastCall(Cell.X,Cell.Y) then
            self:QueueDeleteCell(Cell.X,Cell.Y)
        end
    end
end



return MapGenerator