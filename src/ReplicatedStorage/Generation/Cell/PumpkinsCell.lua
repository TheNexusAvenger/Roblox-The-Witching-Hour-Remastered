--[[
TheNexusAvenger

Generates a pumpkin cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")
local Tree = ReplicatedStorageProject:GetResource("Generation.Tree")

local PumpkinsCell = BaseGrassCell:Extend()
PumpkinsCell:SetClassName("PumpkinsCell")



--[[
Creates a cell.
--]]
function PumpkinsCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Create the dirt.
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-8,Y * 100),Vector3.new(100,12,100),Enum.Material.Ground)

    --Create the pumpkins.
    for PumpkinX = (X * 100) - 30,(X * 100) + 30,20 do
        for PumpkinY = (Y * 100) - 30,(Y * 100) + 30,20 do
            local Pumpkin = Instance.new("Part")
            Pumpkin.Shape = "Ball"
            Pumpkin.Size = Vector3.new(4,4,4)
            Pumpkin.CFrame = CFrame.new(PumpkinX + self.RandomNumberGenerator:NextNumber(-8,8),2,PumpkinY + self.RandomNumberGenerator:NextNumber(-8,8)) * CFrame.Angles(self.RandomNumberGenerator:NextNumber(math.rad(-5),math.rad(5)),self.RandomNumberGenerator:NextNumber(math.rad(-180),math.rad(180)),self.RandomNumberGenerator:NextNumber(math.rad(-5),math.rad(5)))
            Pumpkin.Anchored = true
            Pumpkin.Parent = self.CellModel

            local PumpkinMesh = Instance.new("SpecialMesh")
            PumpkinMesh.MeshType = "FileMesh"
            PumpkinMesh.MeshId = "http://www.roblox.com/asset/?id=430748458"
            PumpkinMesh.TextureId = "http://www.roblox.com/asset/?id=430751682"
            PumpkinMesh.Scale = Vector3.new(0.025,0.025,0.025)
            PumpkinMesh.Parent = Pumpkin
        end
    end

    --Create the fence posts.
    local CenterX,CenterY = X * 100,Y * 100
    for PostX = CenterX - 48,CenterX - 8,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(PostX,1.5,CenterY - 48) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostX = CenterX + 8,CenterX + 48,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(PostX,1.5,CenterY - 48) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostX = CenterX - 48,CenterX - 8,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(PostX,1.5,CenterY + 48) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostX = CenterX + 8,CenterX + 48,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(PostX,1.5,CenterY + 48) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostY = CenterY - 38,CenterY - 8,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(CenterX - 48,1.5,PostY) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostY = CenterY + 8,CenterY + 38,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(CenterX - 48,1.5,PostY) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostY = CenterY - 38,CenterY - 8,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(CenterX + 48,1.5,PostY) * CFrame.Angles(0,0,math.pi/2))
    end
    for PostY = CenterY + 8,CenterY + 38,10 do
        self:CreateWoodPart(Vector3.new(4,1,1),CFrame.new(CenterX + 48,1.5,PostY) * CFrame.Angles(0,0,math.pi/2))
    end

    --Create the fence.
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX - 28,3,CenterY - 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX - 28,1.5,CenterY - 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX + 28,3,CenterY - 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX + 28,1.5,CenterY - 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX - 28,3,CenterY + 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX - 28,1.5,CenterY + 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX + 28,3,CenterY + 48))
    self:CreateWoodPart(Vector3.new(40,0.8,0.2),CFrame.new(CenterX + 28,1.5,CenterY + 48))

    
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX - 48,3,CenterY - 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX - 48,1.5,CenterY - 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX + 48,3,CenterY - 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX + 48,1.5,CenterY - 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX - 48,3,CenterY + 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX - 48,1.5,CenterY + 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX + 48,3,CenterY + 28))
    self:CreateWoodPart(Vector3.new(0.2,0.8,40),CFrame.new(CenterX + 48,1.5,CenterY + 28))
end

--[[
Creates a wood part.
--]]
function PumpkinsCell:CreateWoodPart(Size,Center)
    local Wood = Instance.new("Part")
	Wood.BrickColor = BrickColor.new("Brown")
	Wood.Material = "Wood"
	Wood.Size = Size
	Wood.CFrame = Center
	Wood.Anchored = true
	Wood.TopSurface = "Smooth"
	Wood.BottomSurface = "Smooth"
    Wood.Parent = self.CellModel
end



return PumpkinsCell