--[[
TheNexusAvenger

Controls spawning and modifying characters.
Class is static (should not be created).
--]]

local BASE_SPAWN_GRID_X = 178
local BASE_SPAWN_GRID_Y = 13
local RESPAWN_DELAY = 5



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PhysicsService = game:GetService("PhysicsService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")

local CharacterService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
CharacterService:SetClassName("CharacterService")
CharacterService.LastPlayerCFrames = {}
ServerScriptServiceProject:SetContextResource(CharacterService)

local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")
local PetService = ServerScriptServiceProject:GetResource("Service.PetService")



--Set up the characters collision group.
PhysicsService:CreateCollisionGroup("Characters")
PhysicsService:CollisionGroupSetCollidable("Characters","Characters",false)



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
    if self.LastPlayerCFrames[Player] then
        HumanoidRootPart.CFrame = self.LastPlayerCFrames[Player]
        self.LastPlayerCFrames[Player] = nil
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

    --Make the character uncollidable with others.
    for _,Part in pairs(Character:GetDescendants()) do
        if Part:IsA("BasePart") then
            PhysicsService:SetPartCollisionGroup(Part,"Characters")
        end
    end
    Character.DescendantAdded:Connect(function(Part)
        if Part:IsA("BasePart") then
            PhysicsService:SetPartCollisionGroup(Part,"Characters")
        end
    end)

    --Remove the default healing script.
    local HealthScript = Character:FindFirstChild("Health")
    if HealthScript then
        HealthScript:Destroy()
    end
end

--[[
Saves the last CFrame of a player.
--]]
function CharacterService:SaveLastSpot(Player)
    local Character = Player.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            self.LastPlayerCFrames[Player] = HumanoidRootPart.CFrame
        end
    end
end

--[[
Teleports the player to last CFrame.
--]]
function CharacterService:TeleportToLastSpot(Player)
    local Character = Player.Character
    if Character and self.LastPlayerCFrames[Player] then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            HumanoidRootPart.CFrame = self.LastPlayerCFrames[Player]
        end
        self.LastPlayerCFrames[Player] = nil
    end
end



return CharacterService