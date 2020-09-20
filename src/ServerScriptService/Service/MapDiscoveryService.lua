--[[
TheNexusAvenger

Stores and replicates player data.
Class is static (should not be created).
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local BoolGrid = ReplicatedStorageProject:GetResource("State.BoolGrid")
local AchievementService = ServerScriptServiceProject:GetResource("Service.AchievementService")
local PlayerDataService = ServerScriptServiceProject:GetResource("Service.PlayerDataService")
local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")

local MapDiscoveryService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
MapDiscoveryService:SetClassName("MapDiscoveryService")
MapDiscoveryService.DiscoveredCellsBoolGrids = {}
ServerScriptServiceProject:SetContextResource(MapDiscoveryService)



--[[
Initializes the data for a player.
--]]
function MapDiscoveryService:LoadPlayer(Player)
    --Set up the grid.
    local PlayerData = PlayerDataService:GetPlayerData(Player)
    local Inventory = InventoryService:GetInventory(Player)
    local PlayerBoolGrid = BoolGrid.new(200,200)
    self.DiscoveredCellsBoolGrids[Player] = PlayerBoolGrid
    self.DiscoveredCellsBoolGrids[Player]:LoadFromString(PlayerData:GetValue("DiscoveredMapCells"))

    --Set up discovering the map.
    coroutine.wrap(function()
        while Player.Parent do
            --Get the center.
            local Character = Player.Character
            if Character then
                local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
                if HumanoidRootPart then
                    local CenterX,CenterY = math.floor((HumanoidRootPart.Position.X/100) + 0.5),math.floor((HumanoidRootPart.Position.Z/100) + 0.5)
                    local Range = 2 + #Inventory:GetItemSlots("VisionRadiusIncrease")
                    
                    --Discover the sections and mark if new sections were discovered.
                    local SectionsWereDiscovered = false
                    for X = CenterX - Range,CenterX + Range do
                        for Y = CenterY - Range,CenterY + Range do
                            if not PlayerBoolGrid:GetValue(X,Y) then
                                PlayerBoolGrid:SetValue(X,Y,true)
                                SectionsWereDiscovered = true

                                --Award the beyond the rocks achievement.
                                if X < 10 and Y > 183 then
                                    AchievementService:AwardAchievement(Player,"BeyondTheRocks")
                                end
                            end
                        end
                    end

                    --Set the value if it changed.
                    if SectionsWereDiscovered then
                        PlayerData:SetValue("DiscoveredMapCells",PlayerBoolGrid:Serialize())
                        PlayerDataService:SavesPlayerData(Player)
                    end
                end
            end
            wait()
        end
    end)()
end

--[[
Clears a player.
--]]
function MapDiscoveryService:ClearPlayer(Player)
    --Clear the resources.
    self.DiscoveredCellsBoolGrids[Player] = nil
end



return MapDiscoveryService