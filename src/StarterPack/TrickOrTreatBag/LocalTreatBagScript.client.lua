--[[
TheNexusAvenger

Boosts the walkspeed of the player when equipped.
--]]

local Tool = script.Parent
local Humanoid



--[[
Invoked when the tool is equipped.
--]]
local function OnEquip()
    local Character = Tool.Parent
        if Character then
        Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            Humanoid.WalkSpeed = 22
        end
    end
end

--[[
Invoked when the tool is unequipped.
--]]
local function OnUnequip()
    if Humanoid then
        Humanoid.WalkSpeed = 16
    end
end



--Connect the events.
Tool.Equipped:Connect(OnEquip)
Tool.Unequipped:Connect(OnUnequip)