--[[
TheNexusAvenger

Map for the bottom bar.
--]]

local Players = game:GetService("Players")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
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
    Background.Size = UDim2.new(0.9 * 1.4,0,0.9,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
    Background.Position = UDim2.new(0.5,0,1.5,0)
    Background.AnchorPoint = Vector2.new(0.5,0.5)
    Background.Image = "rbxassetid://131274595"
    Background.Parent = MapScreenGui
    
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

    --Initialize the maps.
    local MiniMap = Map.new(MiniMapContainer,9)
    self.MiniMap = MiniMap
    local FullMap = Map.new(MapContainer,19)
    self.FullMap = FullMap

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
        --TODO: Implement
    end)
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

    --TODO: Set up the player indicator

    --Set up updating the map.
    if Player == Players.LocalPlayer then
        while Head.Parent do
            local PosX,PosY = Head.CFrame.X/100,Head.CFrame.Z/100
            self.MiniMap:SetCenter(PosX,PosY)
            self.FullMap:SetCenter(PosX,PosY)
            wait()
        end
    end
end



return CornerMap