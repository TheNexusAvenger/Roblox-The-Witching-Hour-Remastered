--[[
TheNexusAvenger

Generates a rock cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseCell")

local RockCell = BaseCell:Extend()
RockCell:SetClassName("RockCell")



--[[
Creates a cell.
--]]
function RockCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --TODO: Generate house

    --Create the grass.
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,28,Y * 100),Vector3.new(100,84,100),Enum.Material.Sandstone)
end

--[[
Destroys the cell.
--]]
function RockCell:Destroy()
    Workspace.Terrain:FillBlock(CFrame.new(self.X * 100,28,self.Y * 100),Vector3.new(100,84,100),Enum.Material.Air)
end



return RockCell