--[[
TheNexusAvenger

Controls spawning and updating pets.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local PetService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
PetService:SetClassName("PetService")
ServerScriptServiceProject:SetContextResource(PetService)

local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")



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

end


return PetService