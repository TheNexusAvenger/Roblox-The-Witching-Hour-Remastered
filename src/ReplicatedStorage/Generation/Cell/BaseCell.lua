--[[
TheNexusAvenger

Base class for generating a cell.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local BaseCell = NexusObject:Extend()
BaseCell:SetClassName("BaseCell")



--[[
Creates a cell.
--]]
function BaseCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper()

    self.X = X
    self.Y = Y
    self.TopCellType = TopCellType
    self.BottomCellType = BottomCellType
    self.LeftCellType = LeftCellType
    self.RightCellType = RightCellType
end

--[[
Destroys the cell.
--]]
function BaseCell:Destroy()
    
end



return BaseCell