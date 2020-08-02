--[[
TheNexusAvenger

Generates a grass cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")

local GrassCell = BaseGrassCell:Extend()
GrassCell:SetClassName("GrassCell")



--[[
Creates a cell.
--]]
function GrassCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --TODO: Generate trees
end

--[[
Destroys the cell.
--]]
function GrassCell:Destroy()
    self.super:Destroy()
    --TODO: Destroy trees
end



return GrassCell