--[[
TheNexusAvenger

Ensures the latest open window has the highest display order.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local DisplayOrderController = NexusObject:Extend()
DisplayOrderController.DisplayOrders = {}
DisplayOrderController:SetClassName("DisplayOrderController")



--[[
Registers a frame to control.
--]]
function DisplayOrderController:Register(ScreenGui,OpenStateValue)
    --Connect the open state.
    OpenStateValue.Changed:Connect(function()
        if OpenStateValue.Value then
            --Get the highest display order.
            local HighestDisplayOrder = 1
            for OtherScreenGui,_ in pairs(self.DisplayOrders) do
                HighestDisplayOrder = math.max(HighestDisplayOrder,OtherScreenGui.DisplayOrder)
            end

            --Set and store the display order.
            local NewDisplayOrder = HighestDisplayOrder + 1
            ScreenGui.DisplayOrder = NewDisplayOrder
            self.DisplayOrders[ScreenGui] = NewDisplayOrder
        else
            --Remove the display order.
            self.DisplayOrders[ScreenGui] = nil
        end
    end)
end



return DisplayOrderController