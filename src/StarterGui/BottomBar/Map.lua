--[[
TheNexusAvenger

Displays the map of the game.
--]]

local FULL_MAP_SIZE_CELLS = 200
local ID_TO_TEXTURE = {
    [-1] = {"rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131316239"}, --Unknown
    [0] = {"rbxassetid://130857246"}, --Custom structure (grass)
    [1] = {"rbxassetid://130857246"}, --Grass
    [2] = {"rbxassetid://132785906"}, --Swamp
    [3] = {"rbxassetid://130857373"}, --Pumpkins
    [4] = {"rbxassetid://130857355"}, --Water
    [5] = {"rbxassetid://130857360"}, --Rock
    [6] = {"rbxassetid://130857349"}, --Road
    [7] = {"rbxassetid://130857451","rbxassetid://130857442","rbxassetid://130857424"}, --House
}



local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local MapCellData = ReplicatedStorageProject:GetResource("GameData.MapCellData")

local Map = NexusObject:Extend()
Map:SetClassName("Map")



--[[
Creates a map.
--]]
function Map:__new(Container,MaxGridWidth)
    self:InitializeSuper()

    --Set up the initial state.
    self.LastX = -1
    self.LastY = -1
    self.LastGridUpdateX = -1
    self.LastGridUpdateY = -1
    self.ViewableWidth = 6
    self.MaxGridWidth = MaxGridWidth

    --Create the containers.
    local FullContainer = Instance.new("Frame")
    FullContainer.BackgroundTransparency = 1
    FullContainer.BackgroundColor3 = Color3.new(0,0,0)
    FullContainer.BorderSizePixel = 0
    FullContainer.Parent = Container
    self.FullContainer = FullContainer

    local CellContainer = Instance.new("Frame")
    CellContainer.BackgroundTransparency = 1
    CellContainer.BackgroundColor3 = Color3.new(0,0,0)
    CellContainer.AnchorPoint = Vector2.new(0.5,0.5)
    CellContainer.BorderSizePixel = 0
    CellContainer.Parent = Container
    self.CellContainer = CellContainer

    --Create the cells.
    self.CellFrames = {}
    for X = 1,MaxGridWidth do
        self.CellFrames[X] = {}
        for Y = 1,MaxGridWidth do
            local Cell = Instance.new("ImageLabel")
            Cell.BackgroundTransparency = 1
            Cell.Size = UDim2.new(1/MaxGridWidth,0,1/MaxGridWidth,0)
            Cell.Position = UDim2.new((X - 1)/MaxGridWidth,0,(MaxGridWidth - Y)/MaxGridWidth,0)
            Cell.Parent = CellContainer
            self.CellFrames[X][Y] = Cell
        end
    end
end

--[[
Returns the texture to use for a given cell.
--]]
function Map:GetCellTexture(X,Y)
    --TODO: Return if the cell hasn't been discovered.

    --Get the ids to pick from.
    local Ids = ID_TO_TEXTURE[-1]
    if MapCellData[X] and MapCellData[X][Y] then
        Ids = ID_TO_TEXTURE[MapCellData[X][Y]] or ID_TO_TEXTURE[-1]
    end

    --Return a random texture.
    return Ids[Random.new(X + (Y * 1000)):NextInteger(1,#Ids)]
end

--[[
Updates the cells of the map.
--]]
function Map:UpdateCells()
    local StartX,StartY = math.floor(self.LastGridUpdateX - (self.MaxGridWidth/2)),math.floor(self.LastGridUpdateY - (self.MaxGridWidth/2))
    for XOffset,ImageLabels in pairs(self.CellFrames) do
        for YOffset,ImageLabel in pairs(ImageLabels) do
            ImageLabel.Image = self:GetCellTexture(StartX + (YOffset + 1),StartY + (XOffset - 1))
        end
    end
end

--[[
Updates the map.
--]]
function Map:UpdateMap()
    --Update the sizes.
    self.FullContainer.Size = UDim2.new(FULL_MAP_SIZE_CELLS/self.ViewableWidth,0,FULL_MAP_SIZE_CELLS/self.ViewableWidth,0)
    self.CellContainer.Size = UDim2.new(self.MaxGridWidth/self.ViewableWidth,0,self.MaxGridWidth/self.ViewableWidth,0)

    --Update the positions.
    local MinMapPos,MaxMapPos = (self.ViewableWidth/2) + 0.5,FULL_MAP_SIZE_CELLS - (self.ViewableWidth/2) + 0.5
    local MapCenterX,MapCenterY = math.clamp(self.LastX,MinMapPos,MaxMapPos),math.clamp(self.LastY,MinMapPos,MaxMapPos)
    self.FullContainer.Position = UDim2.new(-(MapCenterY/self.ViewableWidth),0,-((FULL_MAP_SIZE_CELLS - MapCenterX)/self.ViewableWidth),0)
    self.CellContainer.Position = UDim2.new(0.5 - (((MapCenterY/self.ViewableWidth)) % (1/self.ViewableWidth)),0,0.5 - ((((FULL_MAP_SIZE_CELLS - MapCenterX)/self.ViewableWidth)) % (1/self.ViewableWidth)),0)

    --Update the cells if the display should be updated.
    local NewCellX,NewCellY = math.floor(math.clamp(self.LastX,MinMapPos,MaxMapPos)),math.ceil(math.clamp(self.LastY,MinMapPos,MaxMapPos))
    if NewCellX ~= self.LastGridUpdateX or NewCellY ~= self.LastGridUpdateY then
        self.LastGridUpdateX,self.LastGridUpdateY = NewCellX,NewCellY
        self:UpdateCells()
    end
end

--[[
Sets the map's center. Can be decimal.
--]]
function Map:SetCenter(X,Y)
    self.LastX,self.LastY = X,Y
    self:UpdateMap()
end

--[[
Sets the viewable amount of cells in
the X and Y axes.
--]]
function Map:SetViewableWidth(Width)
    self.ViewableWidth = Width
    self:UpdateMap()
end



return Map