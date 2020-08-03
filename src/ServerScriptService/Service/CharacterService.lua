--[[
TheNexusAvenger

Controls spawning and modifying characters.
Class is static (should not be created).
--]]

local BASE_SPAWN_GRID_X = 178
local BASE_SPAWN_GRID_Y = 13
local RESPAWN_DELAY = 5



local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local CharacterService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
CharacterService:SetClassName("CharacterService")
CharacterService.LastPlayerCFrames = {}
ServerScriptServiceProject:SetContextResource(CharacterService)



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

    --TODO: Determine body parts.
    
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
end



--Set up players joining.
Players.PlayerAdded:Connect(function(Player)
    CharacterService:SpawnCharacter(Player)
end)



return CharacterService