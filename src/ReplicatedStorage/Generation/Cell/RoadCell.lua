--[[
TheNexusAvenger

Generates a road cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")

local RoadCell = BaseGrassCell:Extend()
RoadCell:SetClassName("RoadCell")



--[[
Creates a cell.
--]]
function RoadCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Create the road and corner sidewalks.
    local CenterX,CenterY = X * 100,Y * 100
    local RoadModel = Instance.new("Model")
    RoadModel.Name = "Road"
    RoadModel.Parent = Workspace
    self.RoadModel = RoadModel

    self:CreateConcretePart(Vector3.new(90,1,90),CFrame.new(CenterX,0,CenterY),BrickColor.new("Black"))
    self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
    self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
    self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
    self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))

    --Create the sidewalks.
    if TopCellType ~= "Road" then
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 35,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 25,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 15,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 5,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 5,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 15,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 25,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 35,0.1,CenterY + 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(92,2,9.6),CFrame.new(CenterX,0.05,CenterY + 45),BrickColor.new("Dark stone grey"))
    end
    if BottomCellType ~= "Road" then
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 35,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 25,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 15,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 5,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 5,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 15,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 25,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 35,0.1,CenterY - 45),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(92,2,9.6),CFrame.new(CenterX,0.05,CenterY - 45),BrickColor.new("Dark stone grey"))
    end
    if LeftCellType ~= "Road" then
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY - 35),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY - 25),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY - 15),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY - 5),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY + 5),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY + 15),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY + 25),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX - 45,0.1,CenterY + 35),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.6,2,92),CFrame.new(CenterX - 45,0.05,CenterY),BrickColor.new("Dark stone grey"))
    end
    if RightCellType ~= "Road" then
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY - 35),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY - 25),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY - 15),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY - 5),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY + 5),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY + 15),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY + 25),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.8,2,9.8),CFrame.new(CenterX + 45,0.1,CenterY + 35),BrickColor.new("Medium stone grey"))
        self:CreateConcretePart(Vector3.new(9.6,2,92),CFrame.new(CenterX + 45,0.05,CenterY),BrickColor.new("Dark stone grey"))
    end

    --Create the connectors to the next roads.
    if TopCellType == "Road" then
        self:CreateConcretePart(Vector3.new(9.6,2,2),CFrame.new(CenterX - 45,0.05,CenterY + 50),BrickColor.new("Dark stone grey"))
        self:CreateConcretePart(Vector3.new(9.6,2,2),CFrame.new(CenterX + 45,0.05,CenterY + 50),BrickColor.new("Dark stone grey"))
        self:CreateConcretePart(Vector3.new(90,1,10),CFrame.new(CenterX,0,CenterY + 50),BrickColor.new("Black"))
    end
    if RightCellType == "Road" then
        self:CreateConcretePart(Vector3.new(2,2,9.6),CFrame.new(CenterX + 50,0.05,CenterY - 45),BrickColor.new("Dark stone grey"))
        self:CreateConcretePart(Vector3.new(2,2,9.6),CFrame.new(CenterX + 50,0.05,CenterY + 45),BrickColor.new("Dark stone grey"))
        self:CreateConcretePart(Vector3.new(10,1,90),CFrame.new(CenterX + 50,0,CenterY),BrickColor.new("Black"))
    end
end

--[[
Creates a concrete part.
--]]
function RoadCell:CreateConcretePart(Size,CFrame,Color)
    local Part = Instance.new("Part")
    Part.BrickColor = Color
    Part.Material = "Concrete"
    Part.Anchored = true
    Part.Size = Size
    Part.CFrame = CFrame
    Part.TopSurface = "Smooth"
    Part.BottomSurface = "Smooth"
    Part.Parent = self.RoadModel
end

--[[
Destroys the cell.
--]]
function RoadCell:Destroy()
    self.super:Destroy()
    self.RoadModel:Destroy()
end



return RoadCell