--[[
TheNexusAvenger

Generates a swamp cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")
local Tree = ReplicatedStorageProject:GetResource("Generation.Tree")

local SwampCell = BaseGrassCell:Extend()
SwampCell:SetClassName("SwampCell")



--[[
Creates a cell.
--]]
function SwampCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Create the water.
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-8,Y * 100),Vector3.new(100,12,100),Enum.Material.Water)
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-10,Y * 100),Vector3.new(100,8,100),Enum.Material.Mud)

    --Create the mud.
    for TerrainX = (X * 100) - 50,(X * 100) + 50,4 do
        for TerrainY = (Y * 100) - 50,(Y * 100) + 50,4 do
            if math.noise(0,TerrainX/20,TerrainY/20) > 0 then
                Workspace.Terrain:FillBlock(CFrame.new(TerrainX,-8,TerrainY),Vector3.new(4,12,4),Enum.Material.Mud)
            end
        end
    end

    --Create the ground.
    local Base = Instance.new("Part")
	Base.BrickColor = BrickColor.new("Earth green")
	Base.Material = "Grass"
	Base.Size = Vector3.new(100,12,100)
	Base.CFrame = CFrame.new(X * 100,-8.5,Y * 100)
	Base.Anchored = true
	Base.TopSurface = "Smooth"
	Base.BottomSurface = "Smooth"
    Base.Parent = self.CellModel

    local Mist = Instance.new("Part")
	Mist.BrickColor = BrickColor.new("Earth green")
    Mist.Transparency = 0.5
	Mist.Material = "Grass"
	Mist.Size = Vector3.new(100,2,100)
	Mist.CFrame = CFrame.new(X * 100,-0.5,Y * 100)
    Mist.Anchored = true
    Mist.CanCollide = false
	Mist.TopSurface = "Smooth"
	Mist.BottomSurface = "Smooth"
    Mist.Parent = self.CellModel
    
    local MistMesh = Instance.new("BlockMesh")
    MistMesh.Scale = Vector3.new(1,0,1)
    MistMesh.Parent = Mist
end



return SwampCell