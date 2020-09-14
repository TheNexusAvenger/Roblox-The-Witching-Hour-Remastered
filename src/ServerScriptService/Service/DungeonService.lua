--[[
TheNexusAvenger

Runs dungeons for players.
Class is static (should not be created).
--]]

local DUNGEON_TREASURE_CHEST_CHANCE = 0.1
local REWARD_TREASURE_CHEST_CHANGE = 0.05



local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)
local ServerStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerStorage"))

local DungeonService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
DungeonService:SetClassName("DungeonService")
DungeonService.ActivePlayers = {}
ServerScriptServiceProject:SetContextResource(DungeonService)

local DungeonAllocation = ReplicatedStorageProject:GetResource("State.DungeonAllocation")
DungeonService.DungeonAllocation = DungeonAllocation.new()
local Levels = ReplicatedStorageProject:GetResource("State.Levels")
local MonsterData = ReplicatedStorageProject:GetResource("GameData.Generation.Monsters")
local Attacks = ReplicatedStorageProject:GetResource("GameData.Item.Attacks")
local Zones = ReplicatedStorageProject:GetResource("State.Zones")
local GameReplication = ReplicatedStorageProject:GetResource("GameReplication")
local Dungeon = ServerStorageProject:GetResource("Dungeon")
local Monsters = ServerStorageProject:GetResource("Monsters")
local EnergyService = ServerScriptServiceProject:GetResource("Service.EnergyService")
local InventoryService = ServerScriptServiceProject:GetResource("Service.InventoryService")
local CharacterService = ServerScriptServiceProject:GetResource("Service.CharacterService")
local QuestService = ServerScriptServiceProject:GetResource("Service.QuestService")



local DungeonsContainer = Instance.new("Folder")
DungeonsContainer.Name = "Dungeons"
DungeonsContainer.Parent = Workspace

local DungeonReplication = Instance.new("Folder")
DungeonReplication.Name = "DungeonReplication"
DungeonReplication.Parent = GameReplication

local StartDungeon = Instance.new("RemoteEvent")
StartDungeon.Name = "StartDungeon"
StartDungeon.Parent = DungeonReplication

local EndDungeon = Instance.new("RemoteEvent")
EndDungeon.Name = "EndDungeon"
EndDungeon.Parent = DungeonReplication

local ClearDungeon = Instance.new("RemoteEvent")
ClearDungeon.Name = "ClearDungeon"
ClearDungeon.Parent = DungeonReplication

local DisplayReward = Instance.new("RemoteEvent")
DisplayReward.Name = "DisplayReward"
DisplayReward.Parent = DungeonReplication

local DisplayMessage = Instance.new("RemoteEvent")
DisplayMessage.Name = "DisplayMessage"
DisplayMessage.Parent = DungeonReplication

local PerformAttack = Instance.new("RemoteEvent")
PerformAttack.Name = "PerformAttack"
PerformAttack.Parent = DungeonReplication

PerformAttack.OnServerEvent:Connect(function(Player,AttackId,TargetPosition)
    DungeonService:PerformAttack(Player,AttackId,TargetPosition)
end)



--[[
Returns if a player is active.
--]]
function DungeonService:GetActive(Player)
    return self.ActivePlayers[Player] == true
end

--[[
Sets a player as active.
--]]
function DungeonService:SetActive(Player)
    self.ActivePlayers[Player] = true
end

--[[
Sets a player as inactive.
--]]
function DungeonService:SetInactive(Player)
    self.ActivePlayers[Player] = nil
end

--[[
Starts a dungeon and yields for it to be done.
--]]
function DungeonService:RunDungeon(X,Y,DungeonPlayers)
    --Return if there are no players who can run the dungeon.
    local PlayersAbleToPlayer = false
    for _,Player in pairs(DungeonPlayers) do
        if not self:GetActive(Player) then
            PlayersAbleToPlayer = true
            break
        end
    end
    if not PlayersAbleToPlayer then
        return
    end

    --Create the dungeon.
    local Zone = Zones:GetZone(X,Y)
    local IsTreasureDungeon = math.random() <= DUNGEON_TREASURE_CHEST_CHANCE
    local Type = IsTreasureDungeon and "Treasure" or "Monster"

    local Height,Id = self.DungeonAllocation:Allocate(X,Y)
    local DungeonModel = Dungeon:Clone()
    DungeonModel.Name = Id
    DungeonModel.PrimaryPart = DungeonModel:WaitForChild("Ground")
    DungeonModel:SetPrimaryPartCFrame(CFrame.new(X * 100,-250 * Height,Y * 100))
    DungeonModel.Parent = DungeonsContainer

    local DungeonCompleted = false
    local AlivePlayersMap = {}
    if Type == "Monster" then
        --Spawn monsters for the zone.
        local MonstersInZone = MonsterData[Zone]
        local MonsterSpawns = DungeonModel:WaitForChild("MonsterSpawns")
        local MonstersAlive = 0
        if MonstersInZone then
            for i = 1,math.random(2,3) do
                MonstersAlive = MonstersAlive + 1

                --Create a random monster.
                local RandomMonster = MonstersInZone[math.random(1,#MonstersInZone)]
                local MonsterModel = Monsters:WaitForChild(RandomMonster.Name):Clone()
                local Humanoid,HumanoidRootPart = MonsterModel:WaitForChild("Humanoid"),MonsterModel:WaitForChild("HumanoidRootPart")
                MonsterModel.PrimaryPart = HumanoidRootPart

                --Spawn the monster.
                local RandomSpawnPart = MonsterSpawns:GetChildren()[math.random(1,#MonsterSpawns:GetChildren())]
                MonsterModel:SetPrimaryPartCFrame(RandomSpawnPart.CFrame * CFrame.new((math.random() - 0.5) * RandomSpawnPart.Size.X,2 + (HumanoidRootPart.Size.Y/2) + Humanoid.HipHeight,(math.random() - 0.5) * RandomSpawnPart.Size.Z))
                MonsterModel.Parent = DungeonModel

                --Set up the monster.
                local SetupFunction = ServerStorageProject:GetResource("MonsterScripts."..RandomMonster.Type)
                SetupFunction(MonsterModel,DungeonPlayers)

                --Connect the monster being killed.
                Humanoid.Died:Connect(function()
                    --End the dungeon if all monsters were killed.
                    MonstersAlive = MonstersAlive - 1
                    if MonstersAlive == 0 then
                        DungeonCompleted = true
                    end

                    --Register the monster kill for quests.
                    for Player,_ in pairs(AlivePlayersMap) do
                        QuestService:RegisterMonsterKill(Player,RandomMonster.Name)
                    end

                    --Destroy the monster.
                    wait(5)
                    MonsterModel:Destroy()
                end)
            end
        else
            DungeonCompleted = true
        end
    elseif Type == "Treasure" then
        --Set up the treasure chests.
        local ValidChestId = math.random(1,4)
        for i,Chest in pairs(DungeonModel:WaitForChild("Chests"):GetChildren()) do
            Chest.Transparency = 0
            Chest.CanCollide = true

            local ChestUsed = false
            Chest.Touched:Connect(function(TouchPart)
                local Character = TouchPart.Parent
                local Player = Players:GetPlayerFromCharacter(Character)
                if Character and Player then
                    local Humanoid = Character:FindFirstChild("Humanoid")
                    if Humanoid and Humanoid.Health > 0 then
                        if not ChestUsed then
                            ChestUsed = true
                            Chest:WaitForChild("ColorLight").Enabled = true
                            if i == ValidChestId then
                                --End the dungeon.
                                DungeonCompleted = true
                            else
                                --Damage the player.
                                Humanoid:TakeDamage(Humanoid.MaxHealth * 0.75)

                                local Explosion = Instance.new("Explosion")
                                Explosion.BlastPressure = 0
                                Explosion.DestroyJointRadiusPercent = 0
                                Explosion.Position = Chest.Position
                                Explosion.Parent = Chest
                            end
                        end
                    end
                end
            end)
        end
    end

    --Connect players dying and move the players.
    local PlayersAlive = 0
    for _,Player in pairs(DungeonPlayers) do
        local Character = Player.Character
        if Character and not self:GetActive(Player) then
            local Humanoid = Character:FindFirstChild("Humanoid")
            if Humanoid and Humanoid.Health > 0 then
                CharacterService:SaveLastSpot(Player)
                self:SetActive(Player)
                AlivePlayersMap[Player] = true
                PlayersAlive = PlayersAlive + 1
                Humanoid.Died:Connect(function()
                    self:SetInactive(Player)
                    PlayersAlive = PlayersAlive - 1
                    AlivePlayersMap[Player] = nil
                    EndDungeon:FireClient(Player,X,Y,Id)
                end)

                StartDungeon:FireClient(Player,X,Y,Id,Type)
            end
        end
    end

    --Connect players removing.
    Players.PlayerRemoving:Connect(function(Player)
        if AlivePlayersMap[Player] then
            self:SetInactive(Player)
            AlivePlayersMap[Player] = nil
            PlayersAlive = PlayersAlive - 1
        end
    end)

    --Wait for the dungeon to end.
    --This is either by all the players dying or leaving or the dungeon completing.
    while not DungeonCompleted and PlayersAlive > 0 do
        wait()
    end
    
    --End the dungeon.
    if DungeonCompleted then
        --Award the items to the players.
        for Player,_ in pairs(AlivePlayersMap) do
            self:SetInactive(Player)
            EndDungeon:FireClient(Player,X,Y,Id)
            if not InventoryService:GetInventory(Player):GetNextOpenSlot() then
                DisplayMessage:FireClient(Player,"You have no more space in your inventory. Please free some space by buying more pages or deleting some items from it.")
            else
                if math.random() <= REWARD_TREASURE_CHEST_CHANGE then
                    InventoryService:AddItem(Player,{Name="TreasureChest",Zone=Zone})
                    DisplayReward:FireClient(Player,"TreasureChest")
                else
                    local ItemAwarded,ItemName = InventoryService:AwardRandomItem(Player,Zone)
                    if ItemAwarded then
                        DisplayReward:FireClient(Player,ItemName)
                    else
                        DisplayMessage:FireClient(Player,"There are no new items you can unlock.")
                    end
                end
            end
        end
        wait(5)

        --Teleport the players out of the house.
        for Player,_ in pairs(AlivePlayersMap) do
            CharacterService:TeleportToLastSpot(Player)
            local Character = Player.Character
            if Character then
                local Humanoid = Character:FindFirstChild("Humanoid")
                if Humanoid then
                    Humanoid.Health = Humanoid.MaxHealth
                end
            end
        end
    else
        wait(10)
    end

    --Clear the dungeon.
    ClearDungeon:FireAllClients(X,Y,Id)
    self.DungeonAllocation:Deallocate(Id)
    DungeonModel:Destroy()
end

--[[
Performs an attack from a player.
--]]
function DungeonService:PerformAttack(Player,AttackId,TargetPosition)
    --Return if the player is not in a dungeon.
    if not self:GetActive(Player) then return end
    
    --Return if the attack can't be performed.
    local AttackData = Attacks[AttackId]
    if not AttackData then return end
    if Levels.GetLevels(Player).Level < (AttackData.RequiredLevel or 0) then return end

    --Perform the attack.
    if EnergyService:UseEnergy(Player,AttackData.EnergyPerUse or 0) then
        --TODO: Implement
    end
end



return DungeonService