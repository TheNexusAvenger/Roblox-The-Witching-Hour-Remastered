--[[
TheNexusAvenger

Data structure for a grid of bools.
--]]

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local BoolGrid = NexusObject:Extend()
BoolGrid:SetClassName("BoolGrid")



--[[
Creates a bool grid.
--]]
function BoolGrid:__new(GridSizeX,GridSizeY,DefaultValue)
    self:InitializeSuper()

    --Store the state.
    self.GridSizeX = GridSizeX
    self.GridSizeY = GridSizeY
    self.Grid = {}
    self.DefaultValue = DefaultValue or false

    --Initialize the grid.
    for X = 1,GridSizeX do
        self.Grid[X] = {}
        for Y = 1,GridSizeY do
            self.Grid[X][Y] = DefaultValue or false
        end
    end
end

--[[
Returns the value for a given grid position.
--]]
function BoolGrid:GetValue(X,Y)
    --Return the default if the value is out of range.
    if X < 1 or X > self.GridSizeX or Y < 1 or Y > self.GridSizeY then
        return self.DefaultValue
    end

    --Return the value in the grid.
    return self.Grid[X][Y]
end

--[[
Sets the value for a given grid position.
--]]
function BoolGrid:SetValue(X,Y,Value)
    --Return if the value is out of range.
    if X < 1 or X > self.GridSizeX or Y < 1 or Y > self.GridSizeY then
        return
    end

    --Set the value.
    self.Grid[X][Y] = Value
end

--[[
Initializes the grid from a string.
--]]
function BoolGrid:LoadFromString(DataString)
    --Parse the string.
    local Data = HttpService:JSONDecode(DataString)

    --Set the data from the string.
    for X = 1,self.GridSizeX do
        local Row = Data[X]
        if Row then
            local CurrentValue = Row[1]
            local CurrentNumber = 2
            local Remaining = Row[2]
            for Y = 1,self.GridSizeY do
                --Set the value.
                self.Grid[X][Y] = CurrentValue
                Remaining = Remaining - 1

                --Set the next value if there is it should be changed.
                if Remaining == 0 then
                    CurrentValue = not CurrentValue
                    CurrentNumber = CurrentNumber + 1
                    Remaining = Row[CurrentNumber] or 0
                end
            end
        end
    end
end

--[[
Serializes the grid to a string.
--]]
function BoolGrid:Serialize()
    --Serailize the rows.
    local Data = {}
    for X,Row in pairs(self.Grid) do
        local RowData = {Row[1],0}
        Data[X] = RowData
        local CurrentValue = Row[1]
        local CurrentId = 2
        for Y,Value in pairs(Row) do
            if Value == CurrentValue then
                RowData[CurrentId] = RowData[CurrentId] + 1
            else
                CurrentId = CurrentId + 1
                CurrentValue = Value
                RowData[CurrentId] = 1
            end
        end
    end

    --Return the data as a string.
    return HttpService:JSONEncode(Data)
end



return BoolGrid