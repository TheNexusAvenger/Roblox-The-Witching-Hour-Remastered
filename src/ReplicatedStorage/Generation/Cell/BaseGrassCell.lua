--[[
TheNexusAvenger

Generates a base grass cell.
--]]

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

    --Create the grass.
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-8,Y * 100),Vector3.new(100,12,100),Enum.Material.Grass)
end

--[[
Destroys the cell.
--]]
function BaseGrassCell:Destroy()
    Workspace.Terrain:FillBlock(CFrame.new(self.X * 100,-8,self.Y * 100),Vector3.new(100,12,100),Enum.Material.Air)
end



return BaseGrassCell