--[[
TheNexusAvenger

Stores and replicates player data.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData")
local NexusDataStore = ReplicatedStorageProject:GetResource("ExternalUtil.NexusDataStore")

local PlayerDataService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
PlayerDataService:SetClassName("PlayerDataService")
PlayerDataService.PlayerData = {}
ServerScriptServiceProject:SetContextResource(PlayerDataService)

local AchievementService = ServerScriptServiceProject:GetResource("Service.AchievementService")



--[[
Initializes the data for a player.
--]]
function PlayerDataService:LoadPlayer(Player)
    --Create the player data folder.
    local PlayerDataFolder = Instance.new("Folder")
    PlayerDataFolder.Name = "PlayerData"
    PlayerDataFolder.Parent = Player
    
    --Initialize the player data.
    local SavedPlayerData = {}
    xpcall(function()
        local DataStore = NexusDataStore:GetSaveData(Player)
        for Key,_ in pairs(PlayerData.PlayerDataLayout) do
            SavedPlayerData[Key] = DataStore:Get(Key)
        end
    end,function(Message)
        --This error happens when a DataStore can't be obtained (not published to Roblox?).
        warn("Loading default data for "..Player.Name.."; "..Message)
    end)
    self.PlayerData[Player] = PlayerData.GetPlayerData(Player)
    self.PlayerData[Player]:InitializeFromSerializedData(SavedPlayerData)

    --Connect the Sorcus bloxkin (last bloxkin) being obtained.
    local LoadedPlayerData = self.PlayerData[Player]
    LoadedPlayerData:GetValueChangedSignal("CollectedBloxkins"):Connect(function()
        if LoadedPlayerData:GetValue("CollectedBloxkins")["Sorcus"] then
            AchievementService:AwardAchievement(Player,"BloxkinCollector")
        end
    end)
end

--[[
Returns the player data object for a player.
--]]
function PlayerDataService:GetPlayerData(Player)
    return self.PlayerData[Player]
end

--[[
Saves the player data for a player.
--]]
function PlayerDataService:SavesPlayerData(Player)
    xpcall(function()
        local DataStore = NexusDataStore:GetSaveData(Player)
        for Key,_ in pairs(PlayerData.PlayerDataLayout) do
            DataStore:Set(Key,self.PlayerData[Player].PlayerData[Key])
        end
    end,function(Message)
        --This error happens when a DataStore can't be obtained (not published to Roblox?).
        warn("Not saving data for "..Player.Name.."; "..Message)
    end)
end

--[[
Clears a player.
--]]
function PlayerDataService:ClearPlayer(Player)
    --Save the player data.
    self:SavesPlayerData(Player)
    NexusDataStore:GetSaveData(Player):Flush()
    NexusDataStore:RemoveFromCache(Player)

    --Clear the resources.
    self.PlayerData[Player] = nil
end



return PlayerDataService