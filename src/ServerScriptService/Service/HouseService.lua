--[[
TheNexusAvenger

Controls the houses and starting dungeons.
Class is static (should not be created).
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local ServerScriptServiceProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ServerScriptService")):GetContext(script)

local HouseService = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusInstance"):Extend()
HouseService:SetClassName("HouseService")
HouseService.LastPlayerCFrames = {}
ServerScriptServiceProject:SetContextResource(HouseService)

local MapCellData = ReplicatedStorageProject:GetResource("GameData.Generation.MapCells")
local GameState = ReplicatedStorageProject:GetResource("GameState")
local GameReplication = ReplicatedStorageProject:GetResource("GameReplication")



--Set up the replication.
local HouseState = Instance.new("Folder")
HouseState.Name = "HouseState"
HouseState.Parent = GameState

local HouseReplication = Instance.new("Folder")
HouseReplication.Name = "HouseReplication"
HouseReplication.Parent = GameReplication

local StartHouse = Instance.new("RemoteEvent")
StartHouse.Name = "StartHouse"
StartHouse.Parent = HouseReplication



--[[
Gets the state object for a house.
--]]
function HouseService:GetHouseStateObject(X,Y)
    return HouseState:FindFirstChild(tostring(X).."_"..tostring(Y))
end

--[[
Gets the state for a house.
--]]
function HouseService:GetHouseState(X,Y)
    local StateObject = self:GetHouseStateObject(X,Y)
    return StateObject and StateObject.Value or "ACTIVE"
end

--[[
Sets the state for a house.
--]]
function HouseService:SetHouseState(X,Y,State)
    local StateObject = self:GetHouseStateObject(X,Y)
    if State == "ACTIVE" then
        --Destroy the state object if the house meant to be active (no object implies active)
        if StateObject then
            StateObject:Destroy()
        end
    else
        --Create the object if it doesn't exist, or set the state object.
        if not StateObject then
            StateObject = Instance.new("StringValue")
            StateObject.Name = tostring(X).."_"..tostring(Y)
            StateObject.Value = State
            StateObject.Parent = HouseState
        else
            StateObject.Value = State
        end
    end
end

--[[
Starts the house.
--]]
function HouseService:StartHouse(X,Y)
    --Return if the house isn't a house.
    if not MapCellData[X] or MapCellData[X][Y] ~= 7 then
        return
    end

    --Return if the house isn't acitve.
    if self:GetHouseState(X,Y) ~= "ACTIVE" then
        return
    end

    --Prepare the house.
    self:SetHouseState(X,Y,"STARTING")
    wait(5)

    --Determine the players in the cell.
    local PlayersInCell = {}
    for _,Player in pairs(Players:GetPlayers()) do
        local Character = Player.Character
        if Character then
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            local Humanoid = Character:FindFirstChild("Humanoid")
            if HumanoidRootPart and Humanoid and Humanoid.Health > 0 and HumanoidRootPart.Position.X >= (X * 100) - 50 and HumanoidRootPart.Position.X <= (X * 100) + 50 and HumanoidRootPart.Position.Z >= (Y * 100) - 50 and HumanoidRootPart.Position.Z <= (Y * 100) + 50 and HumanoidRootPart.Position.Y >= 0 then
                table.insert(PlayersInCell,Player)
            end
        end
    end

    --Start the house.
    self:SetHouseState(X,Y,"INACTIVE")
    if #PlayersInCell > 0 then
        --TODO: Start dungeon.
        --TODO: Wait for dungeon to end.
        wait(10)
    else
        wait(30)
    end

    --Reset the house.
    self:SetHouseState(X,Y,"ACTIVE")
end



--Connect replication.
StartHouse.OnServerEvent:Connect(function(Player,X,Y)
    --Return if the player is not in the cell.
    local Character = Player.Character
    if not Character then return end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end
    if not (HumanoidRootPart.Position.X >= (X * 100) - 50 and HumanoidRootPart.Position.X <= (X * 100) + 50 and HumanoidRootPart.Position.Z >= (Y * 100) - 50 and HumanoidRootPart.Position.Z <= (Y * 100) + 50 and HumanoidRootPart.Position.Y >= 0) then return end
    
    --Start the house.
    HouseService:StartHouse(X,Y)
end)



return HouseService