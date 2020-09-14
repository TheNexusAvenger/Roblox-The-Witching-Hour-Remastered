--[[
TheNexusAvenger

Manages energy for players.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local EnergyService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
EnergyService:SetClassName("EnergyService")
ServerScriptServiceProject:SetContextResource(EnergyService)



--[[
Initializes the energy for a player.
--]]
function EnergyService:LoadPlayer(Player)
    --Create the energy value.
    local EnergyValue = Instance.new("IntValue")
    EnergyValue.Name = "Energy"
    EnergyValue.Value = 100
    EnergyValue.Parent = Player

    --Set up regeneration.
    coroutine.wrap(function()
        while Player.Parent do
            EnergyValue.Value = math.min(EnergyValue.Value + 1,100)
            wait(0.05)
        end
    end)()
end

--[[
Uses a player's energy. Returns if the enough
energy existed.
--]]
function EnergyService:UseEnergy(Player,Energy)
    --Return if there is not enough energy.
    local EnergyValue = Player:WaitForChild("Energy")
    if EnergyValue.Value < Energy then
        return false
    end

    --Use the energy and return true.
    EnergyValue.Value = EnergyValue.Value - Energy
    return true
end



return EnergyService