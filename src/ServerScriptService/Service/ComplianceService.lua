--[[
TheNexusAvenger

Service for managing user compliance.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PolicyService = game:GetService("PolicyService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local ComplianceService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
ComplianceService:SetClassName("ComplianceService")
ComplianceService.PlayerPolicies = {}


--[[
Initializes the inventory for a player.
--]]
function ComplianceService:LoadPlayer(Player: Player): nil
    --Load the compliance data.
    local Worked, Error = pcall(function()
        self.PlayerPolicies[Player] = PolicyService:GetPolicyInfoForPlayerAsync(Player)
    end)
    if not Worked then
        warn("Failed to load policy information for "..tostring(Player).." because "..tostring(Error))
    end

    --Create the value for purchasing keys.
    local CanPurchaseKeyValue = Instance.new("BoolValue")
    CanPurchaseKeyValue.Name = "CanPurchaseKey"
    CanPurchaseKeyValue.Value = self:CanUseRandomPaidItems(Player)
    CanPurchaseKeyValue.Parent = Player
end

--[[
Clears a player.
--]]
function ComplianceService:ClearPlayer(Player: Player): nil
    self.PlayerPolicies[Player] = nil
end

--[[
Returns if a player can use random paid items.
--]]
function ComplianceService:CanUseRandomPaidItems(Player: Player): nil
    return not self.PlayerPolicies[Player] or (self.PlayerPolicies[Player].ArePaidRandomItemsRestricted ~= true)
end



return ComplianceService