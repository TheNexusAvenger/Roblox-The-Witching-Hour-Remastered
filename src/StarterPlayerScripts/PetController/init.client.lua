--[[
TheNexusAvenger

Initializes and controls the pets of the player.
--]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local PetMovement = require(script:WaitForChild("PetMovement"))
local PetAnimation = require(script:WaitForChild("PetAnimation"))



--[[
Sets up a pet.
--]]
local function PetAdded(Character,Pet)
    --Set up the pet movement and animations.
    if Character == LocalPlayer.Character then
        PetMovement(Character,Pet)
    end
    PetAnimation(Pet)

    --Move the pet to Workspace. Parenting to the character
    --flinging when jumping when the pet is stuck.
    if Character == LocalPlayer.Character then
        wait()
        Pet.Parent = Workspace
    end
end

--[[
Sets up a character.
--]]
local function CharacterAdded(Character)
    --Set up pets being added.
    Character.ChildAdded:Connect(function(PetModel)
        if PetModel.Name == "Pet" then
            PetAdded(Character,PetModel)
        end
    end)

    --Set up the existing pet.
    local ExistingPet = Character:FindFirstChild("Pet")
    if ExistingPet then
        PetAdded(Character,ExistingPet)
    end
end

--[[
Sets up a player.
--]]
function PlayerAdded(Player)
    Player.CharacterAdded:Connect(CharacterAdded)
    if Player.Character then
        CharacterAdded(Player.Character)
    end
end



--Set up players.
Players.PlayerAdded:Connect(PlayerAdded)
for _,Player in pairs(Players:GetPlayers()) do
    coroutine.wrap(function()
        PlayerAdded(Player)
    end)()
end