--[[
TheNexusAvenger

Reads and manipulates player data.
--]]

local PLAYER_DATA_LAYOUT = {
    DiscoveredMapCells = {
        Type = "String",
        Default = "[]",
    },
    CollectedBloxkins = {
        Type = "Table",
        Default = "[]",
    },
    Inventory = {
        Type = "Table",
        Default = "[]",
    },
    PetsOwned = {
        Type = "Table",
        Default = "[]",
    },
    ToolsOwned = {
        Type = "Table",
        Default = "[]",
    },
    CurrentPet = {
        Type = "String",
        Default = "Dog",
    },
    Currency = {
        Type = "Integer",
        Default = 0,
    },
    WarpPurchased = {
        Type = "Boolean",
        Default = true,
    },
    Quests = {
        Type = "Table",
        Default = "[]",
    },
    XP = {
        Type = "Integer",
        Default = 0,
    },
}
local TYPE_TO_SERIALIZATION = {
    String = {
        ValueType = "StringValue",
    },
    Table = {
        ValueType = "StringValue",
        Serialize = function(Data)
            return game:GetService("HttpService"):JSONEncode(Data)
        end,
        Deserialize = function(String)
            return game:GetService("HttpService"):JSONDecode(String)
        end,
    },
    Number = {
        ValueType = "NumberValue",
    },
    Integer = {
        ValueType = "IntValue",
    },
    Boolean = {
        ValueType = "BoolValue",
    },
}



local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local NexusEvent = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.Event.NexusEvent")

local PlayerData = NexusObject:Extend()
PlayerData.PlayerDataLayout = PLAYER_DATA_LAYOUT
PlayerData.CachedPlayerData = {}
setmetatable(PlayerData.CachedPlayerData,{__mode="k"})
PlayerData:SetClassName("PlayerData")



--[[
Creates a player data object.
--]]
function PlayerData:__new(Folder)
    self:InitializeSuper()

    --Store the state.
    self.PlayerDataFolder = Folder
    self.PlayerData = {}
    self.ValueChangedEvents = {}
    self.ValueChanged = NexusEvent.new()

    --Connect the value objects.
    for _,ValueObject in pairs(Folder:GetChildren()) do
        self:ConnectValueObject(ValueObject)
    end
    Folder.ChildAdded:Connect(function(ValueObject)
        self:ConnectValueObject(ValueObject)
    end)
end

--[[
Returns a player data object for a
given player.
--]]
function PlayerData.GetPlayerData(Player)
    --Create the cached object if it doesn't exist.
    local Folder = Player:WaitForChild("PlayerData")
    if not PlayerData.CachedPlayerData[Folder] then
        PlayerData.CachedPlayerData[Folder] = PlayerData.new(Folder)
    end

    --Return the cached object.
    return PlayerData.CachedPlayerData[Folder]
end

--[[
Connects a value being added.
--]]
function PlayerData:ConnectValueObject(ValueObject)
    --Connect changes to the object.
    local ValueName = ValueObject.Name
    ValueObject.Changed:Connect(function()
        self.PlayerData[ValueName] = ValueObject.Value
        self.ValueChanged:Fire(ValueName)
        if self.ValueChangedEvents[ValueName] then
            self.ValueChangedEvents[ValueName]:Fire()
        end
    end)

    --Store the current value.
    self.PlayerData[ValueName] = ValueObject.Value

    --Fire the changed event for the initial object.
    --Done in case of a race condition.
    self.ValueChanged:Fire(ValueName)
    if self.ValueChangedEvents[ValueName] then
        self.ValueChangedEvents[ValueName]:Fire()
    end
end

--[[
Initializes the player data from a table
of serialized data.
--]]
function PlayerData:InitializeFromSerializedData(SerializedData)
    --Set the player data.
    self.PlayerData = SerializedData or {}

    --Add the defaults if they don't exist.
    for KeyName,ValueData in pairs(PLAYER_DATA_LAYOUT) do
        if not self.PlayerData[KeyName] then
            self.PlayerData[KeyName] = ValueData.Default
        end
    end

    --Create the object values.
    for KeyName,ValueData in pairs(PLAYER_DATA_LAYOUT) do
        local ValueObject = self.PlayerDataFolder:FindFirstChild(KeyName) or Instance.new(TYPE_TO_SERIALIZATION[ValueData.Type].ValueType)
        ValueObject.Name = KeyName
        ValueObject.Value = self.PlayerData[KeyName]
        ValueObject.Parent = self.PlayerDataFolder
    end
end

--[[
Returns a value.
--]]
function PlayerData:GetValue(Key)
    --Get the value.
    local Value = self.PlayerData[Key]

    --Deserialize the value.
    local ValueData = PLAYER_DATA_LAYOUT[Key]
    if ValueData then
        Value = Value or ValueData.Default
        local ValueTypeData = TYPE_TO_SERIALIZATION[ValueData.Type]
        if ValueTypeData and ValueTypeData.Deserialize then
            Value = ValueTypeData.Deserialize(Value)
        end
    end

    --Return the value.
    return Value
end

--[[
Sets a value.
--]]
function PlayerData:SetValue(Key,Value)
    --Serialize the value if needed.
    local ValueData = PLAYER_DATA_LAYOUT[Key]
    if ValueData then
        local ValueTypeData = TYPE_TO_SERIALIZATION[ValueData.Type]
        if ValueTypeData and ValueTypeData.Serialize then
            Value = ValueTypeData.Serialize(Value)
        end
    end

    --Store the value and invoke the changed events.
    local OldValue = self.PlayerData[Key]
    if OldValue ~= Value then
        self.PlayerData[Key] = Value
        local ValueObject = self.PlayerDataFolder:FindFirstChild(Key)
        if ValueObject then
            ValueObject.Value = Value
        end
    end
end

--[[
Returns the change event for a specific value.
--]]
function PlayerData:GetValueChangedSignal(ValueName)
    --Create the event if it doesn't exist.
    if not self.ValueChangedEvents[ValueName] then
        self.ValueChangedEvents[ValueName] = NexusEvent.new()
    end

    --Return the event.
    return self.ValueChangedEvents[ValueName]
end



return PlayerData