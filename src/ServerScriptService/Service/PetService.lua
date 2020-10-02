--[[
TheNexusAvenger

Controls spawning and updating pets.
--]]

local SLOT_TO_PART_NAME = {
	PetCostumeHat = "Hat",
	PetCostumeCollar = "Collar",
	PetCostumeBack = "Cape",
	PetCostumeAnkle = "Anklet",
}



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local PetSkinTextures = ReplicatedStorageProject:GetResource("GameData.Item.PetSkinTextures")

local PetService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
PetService:SetClassName("PetService")
ServerScriptServiceProject:SetContextResource(PetService)

local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")
local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")



--[[
Spawns a pet for the player.
--]]
function PetService:SpawnPet(Player)
    --Return if the character doesn't exist.
    local Character = Player.Character
    if not Character then
        return
    end

    --Destroy the existing pet.
    local ExistingPet = Character:FindFirstChild("Pet")
    if ExistingPet then
        ExistingPet:Destroy()
    end

    --Create the pet.
    local PetModel = ReplicatedStorageProject:GetResource("PetModels."..tostring(PlayerDataService:GetPlayerData(Player):GetValue("CurrentPet"))):Clone()
    local HumanoidRootPart = PetModel:WaitForChild("HumanoidRootPart")
    PetModel.Name = "Pet"
    PetModel.PrimaryPart = HumanoidRootPart
    PetModel.Parent = Character
    HumanoidRootPart:SetNetworkOwner(Player)

    --Update the pet's appearance.
    self:UpdatePet(Player)
end

--[[
Updates the pet's appearance for a player.
--]]
function PetService:UpdatePet(Player)
    --Return if the character doesn't exist.
    local Character = Player.Character
    if not Character then
        return
    end

    --Get the pet and return if it doesn't exist.
    local Pet = Character:FindFirstChild("Pet")
    if not Pet then
        return
    end
    local PetClothes = Pet:FindFirstChild("Clothes")
    if not PetClothes then
        return
    end

    --Get the pet information.
    local PetType = PlayerDataService:GetPlayerData(Player):GetValue("CurrentPet")
    local ClothingItemNames = {}
    local ClothingItemCostumeName = {}
    local PartNameToSlot = {}
    for SlotName,PartName in pairs(SLOT_TO_PART_NAME) do
        PartNameToSlot[PartName] = SlotName
        local Item = InventoryService:GetItem(Player,SlotName)
        if Item then
            ClothingItemNames[SlotName] = Item.Name
            if ClothingItemNames[SlotName] then
                ClothingItemCostumeName[SlotName] = (ItemData[Item.Name] or {}).CostumeName
            end
        end
    end

    --Update the clothes.
    for _,Part in pairs(PetClothes:GetChildren()) do
        if Part:IsA("BasePart") and PartNameToSlot[Part.Name] then
            local Mesh = Part:FindFirstChildWhichIsA("FileMesh")
            if Mesh then
                local ClothingItem = ClothingItemNames[PartNameToSlot[Part.Name]]
                if ClothingItem then
                    local ClothingItemData = ItemData[ClothingItem]
                    if ClothingItemData then
                        Part.Transparency = 0
                        Mesh.TextureId = "rbxassetid://"..tostring(ClothingItemData.TextureId)
                    end
                else
                    Part.Transparency = 1
                end
            end
        end
    end

    --Update the pet texture if all 4 parts are part of costume match.
	local HasFullCostume = (ClothingItemCostumeName["PetCostumeHat"] == ClothingItemCostumeName["PetCostumeCollar"]) and (ClothingItemCostumeName["PetCostumeHat"] == ClothingItemCostumeName["PetCostumeBack"]) and (ClothingItemCostumeName["PetCostumeHat"] == ClothingItemCostumeName["PetCostumeAnkle"])
	local Costume = HasFullCostume and ClothingItemCostumeName["PetCostumeHat"] or "Default"
    local PetTextureId = PetSkinTextures[Costume][PetType]
	for _,Part in pairs(Pet:GetChildren()) do
		if Part:IsA("BasePart") then
			local Mesh = Part:FindFirstChildWhichIsA("FileMesh")
			if Mesh then
                Mesh.TextureId = "rbxassetid://"..tostring(PetTextureId)
            elseif Part:IsA("MeshPart") then
                Part.TextureID = "rbxassetid://"..tostring(PetTextureId)
			end
		end
	end
end


return PetService