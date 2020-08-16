--[[
TheNexusAvenger

Controls loading NPC models and interactions with them.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InsertService = game:GetService("InsertService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local NPCService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
NPCService:SetClassName("NPCService")
ServerScriptServiceProject:SetContextResource(NPCService)

local NPCHumanoidDescriptions = ReplicatedStorageProject:GetResource("GameData.NPCHumanoidDescriptions")
local GameReplication = ReplicatedStorageProject:GetResource("GameReplication")



--[[
Gets the state object for a house.
--]]
function NPCService:LoadNPCModels()
    --Create the container.
    local NPCModels = Instance.new("Folder")
    NPCModels.Name = "NPCModels"
    NPCModels.Parent = ReplicatedStorage

    --Load the character model.
    local Worked,CharacterModel = pcall(function()
        return InsertService:LoadAsset(1664543044):GetChildren()[1]
    end)
    if not Worked then
        warn("Failed to insert the default character model because "..tostring(CharacterModel))

        --Create the backup model.
        CharacterModel = Instance.new("Model")

        local Humanoid = Instance.new("Humanoid")
        Humanoid.Parent = CharacterModel

        local HumanoidRootPart = Instance.new("Part")
        HumanoidRootPart.Name = "HumanoidRootPart"
        HumanoidRootPart.Size = Vector3.new(4,5,1)
        HumanoidRootPart.Parent = CharacterModel
    end

    --Load the characters.
    for _,HumanoidDescription in pairs(NPCHumanoidDescriptions:GetChildren()) do
        local NewCharacter = CharacterModel:Clone()
        NewCharacter.Name = HumanoidDescription.Name
        NewCharacter:WaitForChild("HumanoidRootPart").Anchored = true
        NewCharacter.Parent = ReplicatedStorage

        --Apply the humanoid description.
        coroutine.wrap(function()
            local Worked,Error = pcall(function()
                NewCharacter:WaitForChild("Humanoid"):ApplyDescription(HumanoidDescription)
            end)
            if not Worked then
                warn("Failed to load humanoid description for "..tostring(HumanoidDescription.Name).." because"..tostring(Error))
            end
            NewCharacter.Parent = NPCModels
        end)()
    end
end




return NPCService