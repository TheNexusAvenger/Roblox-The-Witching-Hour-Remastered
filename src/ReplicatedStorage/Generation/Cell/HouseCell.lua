--[[
TheNexusAvenger

Generates a house cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")

local HouseCell = BaseGrassCell:Extend()
HouseCell:SetClassName("HouseCell")



--[[
Creates a cell.
--]]
function HouseCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --TODO: Generate house
end

--[[
Destroys the cell.
--]]
function HouseCell:Destroy()
    --TODO: Destroy house
end



return HouseCell