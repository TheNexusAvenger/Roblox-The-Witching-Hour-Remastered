--[[
TheNexusAvenger

Map for the bottom bar.
--]]

local MAP_LANDMARK_MAX_MOVE_SPEED = 25



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local Landmarks = ReplicatedStorageProject:GetResource("GameData.Landmarks")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local WideTextButtonDecorator = ReplicatedStorageProject:GetResource("UI.Button.WideTextButtonDecorator")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local Map = require(script.Parent:WaitForChild("Map"))

local CornerMap = NexusObject:Extend()
CornerMap:SetClassName("CornerMap")



--[[
Creates a corner map.
--]]
function CornerMap:__new(BottomFrame)
    self:InitializeSuper()
    
    --Create the bottom bar container.
    local MapBottomBarBackground = Instance.new("ImageLabel")
    MapBottomBarBackground.Size = UDim2.new(1.8,0,1.8,0)
    MapBottomBarBackground.SizeConstraint = "RelativeYY"
    MapBottomBarBackground.Position = UDim2.new(1,0,0,0)
    MapBottomBarBackground.AnchorPoint = Vector2.new(0.8,0.325)
    MapBottomBarBackground.BackgroundTransparency = 1
    MapBottomBarBackground.Image = "rbxassetid://132725398"
    MapBottomBarBackground.Parent = BottomFrame

    local MiniMapContainer = Instance.new("ImageButton")
    MiniMapContainer.BackgroundTransparency = 1
    MiniMapContainer.Size = UDim2.new(0.6,0,0.6,0)
    MiniMapContainer.Position = UDim2.new(0.13,0,0.21,0)
    MiniMapContainer.ClipsDescendants = true
    MiniMapContainer.Parent = MapBottomBarBackground

    --Create the window.
    local MapScreenGui = Instance.new("ScreenGui")
    MapScreenGui.Name = "Map"
    MapScreenGui.DisplayOrder = 2
    MapScreenGui.Parent = script.Parent.Parent

    local Background = Instance.new("ImageLabel")
    Background.BackgroundTransparency = 1
    Background.Position = UDim2.new(0.5,0,1.5,0)
    Background.AnchorPoint = Vector2.new(0.5,0.5)
    Background.Image = "rbxassetid://131274595"
    Background.Parent = MapScreenGui
    
    AspectRatioSwitcher.new(MapScreenGui,1.4,function()
        Background.Size = UDim2.new(0.9 * 1.4,0,0.9,0)
        Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
    end,function()
        Background.Size = UDim2.new(0.9,0,0.9/1.4,0)
        Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
    end)

    local MapContainer = Instance.new("Frame")
    MapContainer.Size = UDim2.new(0.8,0,0.8,0)
    MapContainer.SizeConstraint = Enum.SizeConstraint.RelativeYY
    MapContainer.Position = UDim2.new(0.04,0,0.1,0)
    MapContainer.ClipsDescendants = true
    MapContainer.Parent = Background

    local MapCover = Instance.new("ImageLabel")
    MapCover.BackgroundTransparency = 1
    MapCover.Size = UDim2.new(0.82,0,0.82,0)
    MapCover.SizeConstraint = Enum.SizeConstraint.RelativeYY
    MapCover.Position = UDim2.new(0.03,0,0.09,0)
    MapCover.ZIndex = 5
    MapCover.Image = "rbxassetid://131275262"
    MapCover.Parent = Background

    local ZoomInImage = Instance.new("ImageLabel")
    ZoomInImage.BackgroundTransparency = 1
    ZoomInImage.Size = UDim2.new(0.1,0,0.1,0)
    ZoomInImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    ZoomInImage.Position = UDim2.new(0.625,0,0.65,0)
    ZoomInImage.Parent = Background
    local ZoomInButton = ImageEventBinder.new(ZoomInImage,UDim2.new(1,0,1,0),"rbxassetid://131275208","rbxassetid://131275187","rbxassetid://131275204")

    local ZoomOutImage = Instance.new("ImageLabel")
    ZoomOutImage.BackgroundTransparency = 1
    ZoomOutImage.Size = UDim2.new(0.1,0,0.1,0)
    ZoomOutImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    ZoomOutImage.Position = UDim2.new(0.625,0,0.775,0)
    ZoomOutImage.Parent = Background
    local ZoomOutButton = ImageEventBinder.new(ZoomOutImage,UDim2.new(1,0,1,0),"rbxassetid://131275165","rbxassetid://131275136","rbxassetid://131275148")

    local Legend = Instance.new("ImageLabel")
    Legend.BackgroundTransparency = 1
    Legend.Size = UDim2.new(0.35,0,0.6,0)
    Legend.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Legend.Position = UDim2.new(0.715,0,0.35,0)
    Legend.Image = "rbxassetid://131274953"
    Legend.Parent = Background

    local RecenterImage = Instance.new("ImageLabel")
    RecenterImage.BackgroundTransparency = 1
    RecenterImage.AnchorPoint = Vector2.new(0.5,1)
    RecenterImage.Size = UDim2.new(0.1 * (188/52),0,0.1,0)
    RecenterImage.SizeConstraint = Enum.SizeConstraint.RelativeYY
    RecenterImage.Position = UDim2.new(0.5,0,0.95,0)
    RecenterImage.ZIndex = 8
    RecenterImage.Visible = false
    RecenterImage.Parent = MapContainer
    local RecenterButton = WideTextButtonDecorator.new(RecenterImage,"RECENTER")
    self.RecenterImage = RecenterImage

    local LandmarkList = Instance.new("ScrollingFrame")
    LandmarkList.BackgroundTransparency = 1
    LandmarkList.BorderSizePixel = 0
    LandmarkList.AnchorPoint = Vector2.new(1,0)
    LandmarkList.Position = UDim2.new(0.94,12,0.07,0)
    LandmarkList.Size = UDim2.new(0.25 * (1/4) * (188/52),12,0.25,0)
    LandmarkList.Parent = Background

    --Initialize the maps.
    local MiniMap = Map.new(MiniMapContainer,9)
    self.MiniMap = MiniMap
    local FullMap = Map.new(MapContainer,19)
    FullMap:EnableWarping()
    self.FullMap = FullMap

    --Sort the landmark names by alphabetical order.
    local LandmarkNames = {}
    for LandmarkName,_ in pairs(Landmarks) do
        table.insert(LandmarkNames,LandmarkName)
    end
    table.sort(LandmarkNames)

    --Add the landmarks to the list.
    LandmarkList.CanvasSize = UDim2.new(0,0,(0.25/4) * #LandmarkNames,0)
    local CurrentTween
    for i,LandmarkName in pairs(LandmarkNames) do
        --Create the button.
        local LandmarkImage = Instance.new("ImageLabel")
        LandmarkImage.BackgroundTransparency = 1
        LandmarkImage.Size = UDim2.new(1,-12,1/#LandmarkNames,0)
        LandmarkImage.Position = UDim2.new(0,0,(i - 1)/#LandmarkNames,0)
        LandmarkImage.Parent = LandmarkList
        local LandmarkButton = WideTextButtonDecorator.new(LandmarkImage,LandmarkName)

        --Connect clicking the button.
        local LandmarkData = Landmarks[LandmarkName]
        local DB = true
        LandmarkButton.Button.MouseButton1Down:Connect(function()
            if DB then
                DB = false

                --Calculate the tween.
                local StartX,StartY = FullMap.LastX,FullMap.LastY
                local DeltaX,DeltaY = LandmarkData[1] - StartX,LandmarkData[2] - StartY
                local TravelDistance = ((DeltaX ^ 2) + (DeltaY ^ 2)) ^ 0.5
                local TravelTime = TravelDistance / MAP_LANDMARK_MAX_MOVE_SPEED

                --Tween the map to the target while it isn't being dragged or recentered.
                local StartTime = tick()
                CurrentTween = StartTime
                self.MainMapAttached = false
                RecenterImage.Visible = true
                while not self.DraggingMainMap and not self.MainMapAttached and CurrentTween == StartTime and tick() - StartTime <= TravelTime do
                    --Determine and smooth the delta.
                    local Delta = (tick() - StartTime)/TravelTime
                    Delta = (1 - math.cos(Delta * math.pi))/2

                    --Move the map.
                    local X,Y = StartX + (DeltaX * Delta),StartY + (DeltaY * Delta)
                    FullMap:SetCenter(X,Y)
                    RunService.RenderStepped:Wait()
                end

                DB = true
            end
        end)
    end

    --Set up opening and closing the map.
    local DB = true
    local MapOpen = false
    MiniMapContainer.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            MapOpen = not MapOpen
            Background:TweenPosition(UDim2.new(0.5,0,MapOpen and 0.5 or 1.5),"Out","Quad",0.5,true)
            wait()
            DB = true
        end
    end)

    --Connect the main map events.
    local CurrentZoom = 6
    local LastMousePosition
    self.DraggingMainMap = false
    self.MainMapAttached = true
    ZoomInButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            wait()
            CurrentZoom = math.clamp(CurrentZoom - 2,6,16)
            FullMap:SetViewableWidth(CurrentZoom)
            DB = true
        end
    end)
    ZoomOutButton.Button.MouseButton1Down:Connect(function()
        if DB then
            DB = false
            wait()
            CurrentZoom = math.clamp(CurrentZoom + 2,6,16)
            FullMap:SetViewableWidth(CurrentZoom)
            DB = true
        end
    end)
    MapContainer.InputBegan:Connect(function(Input,Processed)
        if not Processed and not self.DraggingMainMap and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
            LastMousePosition = Input.Position
            self.DraggingMainMap = true
            self.MainMapAttached = false
            RecenterImage.Visible = true
        end
    end)
    UserInputService.InputEnded:Connect(function(Input)
        if self.DraggingMainMap and (Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch) then
            self.DraggingMainMap = false
        end
    end)
    UserInputService.InputChanged:Connect(function(Input)
        if self.DraggingMainMap and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            --Determine the delta.
            local MouseDelta = Input.Position - LastMousePosition
            local PixelsPerCell = MapContainer.AbsoluteSize.X/CurrentZoom
            local CellDeltaX,CellDeltaY = MouseDelta.X/PixelsPerCell,MouseDelta.Y/PixelsPerCell
            LastMousePosition = Input.Position

            --Move the map.
            FullMap:SetCenter(FullMap.LastX + CellDeltaY,FullMap.LastY - CellDeltaX)
        end
    end)
    RecenterButton.Button.MouseButton1Down:Connect(function()
        if DB and not self.DraggingMainMap then
            DB = false
            self.MainMapAttached = true
            RecenterImage.Visible = false
            wait()
            DB = true
        end
    end)

    --Connect players being added and removed.
    for _,Player in pairs(Players:GetPlayers()) do
        coroutine.wrap(function()
            self:PlayerAdded(Player)
        end)()
    end
    Players.PlayerAdded:Connect(function(Player)
        self:PlayerAdded(Player)
    end)
    Players.PlayerRemoving:Connect(function(Player)
        self.MiniMap:RemoveCharacterIndicator(Player)
        self.FullMap:RemoveCharacterIndicator(Player)
    end)

    --Register a toggle command for the map confidence data.
    coroutine.wrap(function()
        local NexusAdminAPI = ReplicatedStorageProject:GetResource("NexusAdminClient")
        
        NexusAdminAPI.Registry:LoadCommand({
            Keyword = "showmapconfidence",
            Prefix = NexusAdminAPI.Configuration.CommandPrefix,
            Category = "GameDebug",
            Description = "Displays the confidence of the map data. Green is confirmed by video, red is not confirmed, and blue is arbitrary.",
            AdminLevel = -1,
            Arguments = {
                {
                    Type = "boolean",
                    Name = "Show",
                    Default = true,
                    Description = "Whether the confidence values should be shown.",
                },
            },
            Run = function(_,CommandContext,ShowMapConfidence)
                self.MiniMap:SetMapConfidence(ShowMapConfidence)
                self.FullMap:SetMapConfidence(ShowMapConfidence)
            end,
        })
    end)()
end

--[[
Invoked when a player is added.
--]]
function CornerMap:PlayerAdded(Player)
    Player.CharacterAdded:Connect(function(Character)
        self:CharacterAdded(Character,Player)
    end)
    if Player.Character then
        self:CharacterAdded(Player.Character,Player)
    end
end

--[[
Invoked when a character is added.
--]]
function CornerMap:CharacterAdded(Character,Player)
    local Head = Character:WaitForChild("Head")

    --Add the character indicators.
    self.MiniMap:AddCharacterIndicator(Player)
    self.FullMap:AddCharacterIndicator(Player)

    --Set up updating the map.
    if Player == Players.LocalPlayer then
        while Character.Parent do
            local PosX,PosY = Head.CFrame.X/100,Head.CFrame.Z/100
            self.MiniMap:SetCenter(PosX,PosY)
            if self.MainMapAttached then
                self.FullMap:SetCenter(PosX,PosY) 
            end
            wait()
        end
    end
end



return CornerMap