--[[
TheNexusAvenger

Generates a grass cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")
local Tree = ReplicatedStorageProject:GetResource("Generation.Tree")

local GrassCell = BaseGrassCell:Extend()
GrassCell:SetClassName("GrassCell")



--[[
Creates a cell.
--]]
function GrassCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Generate trees.
    local Center = CFrame.new(X * 100,0,Y * 100)
    for i = 1,2 do
        Tree.new(Center * CFrame.Angles(0,(math.pi * i) + self.RandomNumberGenerator:NextNumber(-math.rad(60),math.rad(60)),0) * CFrame.new(0,0,self.RandomNumberGenerator:NextNumber(5,50)),self.CellModel,self.RandomNumberGenerator)
    end
end



return GrassCell