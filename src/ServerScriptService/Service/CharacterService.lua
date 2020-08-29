--[[
TheNexusAvenger

Controls spawning and modifying characters.
Class is static (should not be created).
--]]

local BASE_SPAWN_GRID_X = 178
local BASE_SPAWN_GRID_Y = 13
local RESPAWN_DELAY = 5



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local ItemData = ReplicatedStorageProject:GetResource("GameData.ItemData")

local CharacterService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
CharacterService:SetClassName("CharacterService")
CharacterService.LastPlayerCFrames = {}
ServerScriptServiceProject:SetContextResource(CharacterService)

local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")
local PetService = ServerScriptServiceProject:GetResource("Service.PetService")



--[[
Returns the Roblox id for a given slot
of a player's inventory. Returns 0 if
no items is equipped in the slot.
--]]
function CharacterService:GetRobloxIdForSlot(Player,SlotName)
    --Return the item's Roblox id.
    local Item = InventoryService:GetItem(Player,SlotName)
    if Item and Item.Name then
        return ItemData[Item.Name].RobloxId
    end
    
    --Return 0 (not found).
    return 0
end

--[[
Returns the humanoid description to use
for a player.
--]]
function CharacterService:GetHumanoidDescription(Player)
    --Create the base description.
    local Description = Instance.new("HumanoidDescription")
    Description.HeadColor = BrickColor.new("Bright yellow").Color
    Description.LeftArmColor = BrickColor.new("Bright yellow").Color
    Description.RightArmColor = BrickColor.new("Bright yellow").Color
    Description.TorsoColor = BrickColor.new("Bright green").Color
    Description.LeftLegColor = BrickColor.new("Bright blue").Color
    Description.RightLegColor = BrickColor.new("Bright blue").Color

    --Add the body parts.
    Description.HatAccessory = self:GetRobloxIdForSlot(Player,"PlayerHat")
    Description.Torso = self:GetRobloxIdForSlot(Player,"PlayerTorso")
    Description.LeftArm = self:GetRobloxIdForSlot(Player,"PlayerLeftArm")
    Description.RightArm = self:GetRobloxIdForSlot(Player,"PlayerRightArm")
    Description.LeftLeg = self:GetRobloxIdForSlot(Player,"PlayerLeftLeg")
    Description.RightLeg = self:GetRobloxIdForSlot(Player,"PlayerRightLeg")
    
    --Return the description.
    return Description
end

--[[
Spawns a player.
--]]
function CharacterService:SpawnCharacter(Player)
    --Load the character.
    Player:LoadCharacterWithHumanoidDescription(self:GetHumanoidDescription(Player))

    --Move the character.
    local Character = Player.Character
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    if CharacterService.LastPlayerCFrames[Player] then
        HumanoidRootPart.LastPlayerCFrames = CharacterService.LastPlayerCFrames[Player]
    else
        HumanoidRootPart.CFrame = CFrame.new((BASE_SPAWN_GRID_X * 100) + math.random(-30,30),3.5,(BASE_SPAWN_GRID_Y * 100) + math.random(-30,30)) * CFrame.Angles(0,-math.pi/2,0)
    end

    --Connect the player being killed.
    local Humanoid = Character:WaitForChild("Humanoid")
    Humanoid.Died:Connect(function()
        wait(RESPAWN_DELAY)
        self:SpawnCharacter(Player)
    end)

    --Connect the inventory changing.
    InventoryService:GetInventoryChangedEvent(Player):Connect(function()
        if Character.Parent then
            Humanoid:ApplyDescription(self:GetHumanoidDescription(Player))
            PetService:UpdatePet(Player)
        end
    end)

    --Spawn the pet.
    PetService:SpawnPet(Player)
end



return CharacterService