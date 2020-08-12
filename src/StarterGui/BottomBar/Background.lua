--[[
TheNexusAvenger

Background for the bottom bar.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local Background = NexusObject:Extend()
Background:SetClassName("Background")



--[[
Creates a background.
--]]
function Background:__new(BottomFrame)
    self:InitializeSuper()

    --Create the background.
    local FenceImage = Instance.new("ImageLabel")
    FenceImage.BackgroundTransparency = 1
    FenceImage.Size = UDim2.new(1,0,1,0)
    FenceImage.Image = "rbxassetid://132724864"
    FenceImage.ScaleType = Enum.ScaleType.Tile
    FenceImage.Parent = BottomFrame
    self.FenceImage = FenceImage

    --Set up updating the tile size.
    FenceImage:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        self:UpdateImageSize()
    end)
    self:UpdateImageSize()
end

--[[
Updates the tile size of the background.
--]]
function Background:UpdateImageSize()
    self.FenceImage.TileSize = UDim2.new(1/(self.FenceImage.AbsoluteSize.X/(self.FenceImage.AbsoluteSize.Y * 8)),0,2,0)
end



return Background