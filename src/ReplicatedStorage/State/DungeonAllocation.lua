--[[
TheNexusAvenger

Manages the allocation of dungeons since they overlap houses.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local DungeonAllocation = NexusObject:Extend()
DungeonAllocation:SetClassName("DungeonAllocation")



--[[
Creates a bool grid.
--]]
function DungeonAllocation:__new()
    self:InitializeSuper()

    --Store the state.
    self.AllocatedDungeons = {}
end

--[[
Allocates a slot and returns the height as a
number and a string with the id.
--]]
function DungeonAllocation:Allocate(X,Y)
    local Depth = 1
    while true do
        --Determine if the slot has not been allocated to the current or selected slot.
        local SlotTaken = false
        for SubX = X - 1,X + 1 do
            for SubY = Y - 1,Y + 1 do
                if self.AllocatedDungeons[tostring(SubX).."_"..tostring(SubY).."_"..tostring(Depth)] then
                    SlotTaken = true
                    break
                end
            end
        end

        --Allocate the id and return the id and height if the slot is not allocated.
        if not SlotTaken then
            local Id = tostring(X).."_"..tostring(Y).."_"..tostring(Depth)
            self.AllocatedDungeons[Id] = true
            return Depth,Id
        end

        --Increase the depth and continue if it can't be allocated.
        Depth = Depth + 1
    end
end

--[[
Deallocates a slot.
--]]
function DungeonAllocation:Deallocate(Id)
    self.AllocatedDungeons[Id] = nil
end



return DungeonAllocation