--[[
TheNexusAvenger

Generates a water cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseCell")

local WaterCell = BaseCell:Extend()
WaterCell:SetClassName("WaterCell")



--[[
Creates a cell.
--]]
function WaterCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Create the blocker.
    local Blocker = Instance.new("Part")
    Blocker.Transparency = 1
    Blocker.Anchored = true
    Blocker.Size = Vector3.new(100,100,100)
    Blocker.CFrame = CFrame.new(X * 100,45,Y * 100)
    Blocker.Parent = Workspace
    self.Blocker = Blocker
    
    --Create the water and stone.
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-6,Y * 100),Vector3.new(100,8,100),Enum.Material.Water)
    Workspace.Terrain:FillBlock(CFrame.new(X * 100,-12,Y * 100),Vector3.new(100,4,100),Enum.Material.Rock)
end

--[[
Destroys the cell.
--]]
function WaterCell:Destroy()
    self.super:Destroy()
    self.Blocker:Destroy()
    Workspace.Terrain:FillBlock(CFrame.new(self.X * 100,-8,self.Y * 100),Vector3.new(100,12,100),Enum.Material.Air)
end



return WaterCell