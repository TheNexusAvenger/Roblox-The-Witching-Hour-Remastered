--[[
TheNexusAvenger

Displays the map of the game.
--]]

local FULL_MAP_SIZE_CELLS = 200
local ID_TO_TEXTURE = {
    [-1] = {"rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131315995","rbxassetid://131316239"}, --Unknown
    [0] = {"rbxassetid://130857246"}, --Custom structure (grass)
    [1] = {"rbxassetid://130857246"}, --Grass
    [2] = {"rbxassetid://132785906"}, --Swamp
    [3] = {"rbxassetid://130857373"}, --Pumpkins
    [4] = {"rbxassetid://130857355"}, --Water
    [5] = {"rbxassetid://130857360"}, --Rock
    [6] = {"rbxassetid://130857349"}, --Road
    [7] = {"rbxassetid://130857451","rbxassetid://130857442","rbxassetid://130857424"}, --House
}
local CONFIDENCE_ID_TO_COLOR = {
    [0] = Color3.new(0,1,0),
    [1] = Color3.new(1,0,0),
    [2] = Color3.new(0,0,1),
}



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local MapCellData = ReplicatedStorageProject:GetResource("GameData.Generation.MapCells")
local MapConfidenceData = ReplicatedStorageProject:GetResource("GameData.Generation.MapConfidence")
local TeleportLocations = ReplicatedStorageProject:GetResource("GameData.Generation.TeleportLocations")
local Landmarks = ReplicatedStorageProject:GetResource("GameData.Generation.Landmarks")
local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData")
local CharacterIndicator = require(script:WaitForChild("CharacterIndicator"))
local StartDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.StartDungeon")
local EndDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.EndDungeon")

local Map = NexusObject:Extend()
Map:SetClassName("Map")



--[[
Creates a map.
--]]
function Map:__new(Container,MaxGridWidth,DiscoveredCellsBoolGrid)
    self:InitializeSuper()

    --Set up the initial state.
    self.LastX = -1
    self.LastY = -1
    self.LastGridUpdateX = -1
    self.LastGridUpdateY = -1
    self.ViewableWidth = 6
    self.MaxGridWidth = MaxGridWidth
    self.CharacterIndicators = {}
    self.ShowMapConfidence = false
    self.DiscoveredCellsBoolGrid = DiscoveredCellsBoolGrid

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

    --Create the landmarks.
    for Name,LocationData in pairs(Landmarks) do
        local LandmarkIcon = Instance.new("ImageLabel")
        LandmarkIcon.BackgroundTransparency = 1
        LandmarkIcon.Size = UDim2.new(0.8/FULL_MAP_SIZE_CELLS,0,0.8/FULL_MAP_SIZE_CELLS,0)
        LandmarkIcon.AnchorPoint = Vector2.new(0.5,0.5)
        LandmarkIcon.Position = UDim2.new((LocationData[2] - 0.5)/FULL_MAP_SIZE_CELLS,0,(FULL_MAP_SIZE_CELLS - LocationData[1] + 0.5)/FULL_MAP_SIZE_CELLS,0)
        LandmarkIcon.Image = "rbxassetid://131348500"
        LandmarkIcon.ZIndex = 3
        LandmarkIcon.Parent = FullContainer

        local LandmarkText = Instance.new("TextLabel")
        LandmarkText.BackgroundTransparency = 1
        LandmarkText.Size = UDim2.new(3,0,0.6,0)
        LandmarkText.Position = UDim2.new(0.5,0,-0.6,0)
        LandmarkText.AnchorPoint = Vector2.new(0.5,0)
        LandmarkText.Font = Enum.Font.Antique
        LandmarkText.Text = Name
        LandmarkText.TextColor3 = Color3.new(1,1,1)
        LandmarkText.TextScaled = true
        LandmarkText.TextXAlignment = "Center"
        LandmarkText.ZIndex = 3
        LandmarkText.Parent = LandmarkIcon
    end
    
    --Connect warping being purchased.
    local MapPlayerData = PlayerData.GetPlayerData(Players.LocalPlayer)
    self.WarpIconsVisible = MapPlayerData:GetValue("WarpPurchased")
    MapPlayerData:GetValueChangedSignal("WarpPurchased"):Connect(function()
        self.WarpIconsVisible = MapPlayerData:GetValue("WarpPurchased")
        self:UpdateWarpIconVisibility()
    end)

    --Create the warp icons.
    local WarpIcons = {}
    self.WarpIcons = WarpIcons
    for Name,LocationData in pairs(TeleportLocations) do
        local WarpIcon = Instance.new("ImageButton")
        WarpIcon.BackgroundTransparency = 1
        WarpIcon.Size = UDim2.new(0.8/FULL_MAP_SIZE_CELLS,0,0.8/FULL_MAP_SIZE_CELLS,0)
        WarpIcon.AnchorPoint = Vector2.new(0.5,0.5)
        WarpIcon.Position = UDim2.new((LocationData[2] - 0.5)/FULL_MAP_SIZE_CELLS,0,(FULL_MAP_SIZE_CELLS - LocationData[1] + 0.5)/FULL_MAP_SIZE_CELLS,0)
        WarpIcon.Image = "rbxassetid://131348539"
        WarpIcon.ZIndex = 4
        WarpIcon.Visible = false
        WarpIcon.Parent = FullContainer
        WarpIcons[Name] = WarpIcon
    end
end

--[[
Returns the texture to use for a given cell.
--]]
function Map:GetCellTexture(X,Y)
    --Get the ids to pick from.
    local Ids = ID_TO_TEXTURE[-1]
    if self.DiscoveredCellsBoolGrid:GetValue(X,Y) and MapCellData[X] and MapCellData[X][Y] then
        Ids = ID_TO_TEXTURE[MapCellData[X][Y]] or ID_TO_TEXTURE[-1]
    end

    --Return a random texture.
    return Ids[Random.new(X + (Y * 1000)):NextInteger(1,#Ids)]
end

--[[
Returns the color to use for a cell representing
the confidence value. Will return white
if displaying it is disabled.
--]]
function Map:GetCellConfidenceColor(X,Y)
    --Return the color for a cell.
    if self.ShowMapConfidence and MapConfidenceData[X] and MapConfidenceData[X][Y] then
        return CONFIDENCE_ID_TO_COLOR[MapConfidenceData[X][Y]] or Color3.new(1,1,1)
    end

    --Return white (disabled or no data).
    return Color3.new(1,1,1)
end

--[[
Updates the visibility of the warp icons.
--]]
function Map:UpdateWarpIconVisibility()
    for WarpIconName,WarpIcon in pairs(self.WarpIcons) do
        local WarpData = TeleportLocations[WarpIconName]
        WarpIcon.Visible = self.WarpIconsVisible and self.DiscoveredCellsBoolGrid:GetValue(math.floor(WarpData[1] + 0.5),math.floor(WarpData[2] + 0.5))
    end
end

--[[
Updates the cells of the map.
--]]
function Map:UpdateCells()
    local StartX,StartY = math.floor(self.LastGridUpdateX - (self.MaxGridWidth/2)),math.floor(self.LastGridUpdateY - (self.MaxGridWidth/2))
    for XOffset,ImageLabels in pairs(self.CellFrames) do
        for YOffset,ImageLabel in pairs(ImageLabels) do
            local X,Y = StartX + (YOffset + 1),StartY + (XOffset - 1)
            ImageLabel.Image = self:GetCellTexture(X,Y)
            ImageLabel.ImageColor3 = self:GetCellConfidenceColor(X,Y)
        end
    end
    self:UpdateWarpIconVisibility()
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
    self.LastX,self.LastY = MapCenterX,MapCenterY
    self.FullContainer.Position = UDim2.new(0.5 + (0.5/self.ViewableWidth) - (MapCenterY/self.ViewableWidth),0,0.5 - (0.5/self.ViewableWidth) - (((FULL_MAP_SIZE_CELLS - MapCenterX)/self.ViewableWidth)),0)
    self.CellContainer.Position = UDim2.new(0.5 - (((MapCenterY/self.ViewableWidth)) % (1/self.ViewableWidth)),0,0.5 - ((((FULL_MAP_SIZE_CELLS - MapCenterX)/self.ViewableWidth)) % (1/self.ViewableWidth)),0)

    --Update the cells if the display should be updated.
    local NewCellX,NewCellY = math.floor(math.clamp(self.LastX,MinMapPos,MaxMapPos)),math.ceil(math.clamp(self.LastY,MinMapPos,MaxMapPos))
    if NewCellX ~= self.LastGridUpdateX or NewCellY ~= self.LastGridUpdateY then
        self.LastGridUpdateX,self.LastGridUpdateY = NewCellX,NewCellY
        self:UpdateCells()
    end
end

--[[
Removes a character indicator.
--]]
function Map:RemoveCharacterIndicator(Player)
    local Indicator = self.CharacterIndicators[Player]
    if Indicator then
        self.CharacterIndicators[Player] = nil
        Indicator:Destroy()
    end
end

--[[
Adds a character indicator.
--]]
function Map:AddCharacterIndicator(Player)
    --Remove the existing indicator.
    self:RemoveCharacterIndicator(Player)

    --Add the indicator.
    if Player.Character then
        self.CharacterIndicators[Player] = CharacterIndicator.new(self.FullContainer,Player)
    end
end

--[[
Enables being able to use the warp buttons.
--]]
function Map:EnableWarping()
    --Set up the buttons.
    local CurrentDungeon
    for Name,Button in pairs(self.WarpIcons) do
        local LocationData = TeleportLocations[Name]

        --Set up clicking the button.
        local DB = true
        Button.MouseButton1Down:Connect(function()
            if DB and not CurrentDungeon then
                DB = false
                local Character = Players.LocalPlayer.Character
                if Character then
                    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                    if Character then
                        --Display the animation.
                        local Scale = Instance.new("UIScale")
                        Scale.Parent = Button
                        for i = 1,3 do
                            TweenService:Create(Scale,TweenInfo.new(0.5),{ Scale = 1.5 }):Play()
                            wait(0.5)
                            TweenService:Create(Scale,TweenInfo.new(0.5),{ Scale = 1 }):Play()
                            wait(0.5)
                        end
                        Scale:Destroy()

                        --Teleport the player.
                        if not CurrentDungeon then
                            HumanoidRootPart.CFrame = CFrame.new(LocationData[1] * 100,3,LocationData[2] * 100) * CFrame.Angles(0,(-math.pi/2) + LocationData[3],0) * CFrame.new(math.random(-10,10),0,math.random(-10,10))
                        end
                    end
                end
                
                wait()
                DB = true
            end
        end)
    end

    --Connect entering and leaving dungeons.
    StartDungeon.OnClientEvent:Connect(function(_,_,Id)
        CurrentDungeon = Id
    end)
    
    EndDungeon.OnClientEvent:Connect(function(_,_,Id)
        if CurrentDungeon == Id then
            CurrentDungeon = nil
        end
    end)
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

--[[
Sets the map confidence being visible or not.
--]]
function Map:SetMapConfidence(MapConfidence)
    self.ShowMapConfidence = MapConfidence
    self:UpdateCells()
end



return Map