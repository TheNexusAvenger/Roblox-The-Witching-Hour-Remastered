--[[
TheNexusAvenger

Loads types on the client for Nexus Admin.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local NexusAdminAPI = require(ReplicatedStorage:WaitForChild("NexusAdminClient"))
local NexusAdminTypes = ReplicatedStorage:WaitForChild("NexusAdminTypes")



--[[
Loads a type.
--]]
local function LoadType(Module)
    if Module:IsA("ModuleScript") then
        require(Module)(NexusAdminAPI)
    end
end



--Load the types.
NexusAdminTypes.ChildAdded:Connect(LoadType)
for _,Module in pairs(NexusAdminTypes:GetChildren()) do
    LoadType(Module)
end