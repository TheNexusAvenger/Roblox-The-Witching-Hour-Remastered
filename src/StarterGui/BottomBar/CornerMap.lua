--[[
TheNexusAvenger

Map for the bottom bar.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

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

    --Set up opening and closing the map.
    MiniMapContainer.MouseButton1Down:Connect(function()
        --TODO: Implement
    end)
end



return CornerMap