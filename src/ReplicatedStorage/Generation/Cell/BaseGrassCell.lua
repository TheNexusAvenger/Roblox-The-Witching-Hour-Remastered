--[[
TheNexusAvenger

Generates a base grass cell.
--]]

local RANDOM_SEED = 4302981239 --This number is completely random, but must be consistent accross clients for generation.



local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseCell")

local BaseGrassCell = BaseCell:Extend()
BaseGrassCell:SetClassName("BaseGrassCell")



--[[
Creates a cell.
--]]
function BaseGrassCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Get the random number generator.
    --This is done using a constant seed and the X and Y coordinate
    --to be consisent between clients.
    self.RandomNumberGenerator = Random.new(math.noise(RANDOM_SEED,X/100,Y/100) * (10^15))

    --Create the grass.
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-8,Y * 100),Vector3.new(100,12,100),Enum.Material.Grass)

    --Create the leaves.
    local CellModel = Instance.new("Model")
    CellModel.Name = "Cell_"..tostring(X).."_"..tostring(Y)
    CellModel.Parent = Workspace
    self.CellModel = CellModel
    for _ = 1,self.RandomNumberGenerator:NextInteger(8,12) do
        local Size = self.RandomNumberGenerator:NextNumber(8,12)
        local LeavesPart = Instance.new("Part")
        LeavesPart.Transparency = 1
        LeavesPart.Size = Vector3.new(Size,0.2,Size)
        LeavesPart.CFrame = CFrame.new((X * 100) + (self.RandomNumberGenerator:NextNumber(-45,45)),-0.075,(Y * 100) + (self.RandomNumberGenerator:NextNumber(-45,45))) * CFrame.Angles(0,self.RandomNumberGenerator:NextNumber(-math.pi,math.pi),0)
        LeavesPart.Anchored = true
        LeavesPart.CanCollide = false
        LeavesPart.TopSurface = "Smooth"
        LeavesPart.BottomSurface = "Smooth"
        LeavesPart.Parent = CellModel
        
        local LeavesDecal = Instance.new("Decal")
        LeavesDecal.Texture = "rbxassetid://134660590"
        LeavesDecal.Face = "Top"
        LeavesDecal.Parent = LeavesPart
    end
end

--[[
Destroys the cell.
--]]
function BaseGrassCell:Destroy()
    --Clear the grass.
    Workspace.Terrain:FillBlock(CFrame.new(self.X * 100,-8,self.Y * 100),Vector3.new(100,12,100),Enum.Material.Air)

    --Clear the cell.
    self.CellModel:Destroy()
end



return BaseGrassCell