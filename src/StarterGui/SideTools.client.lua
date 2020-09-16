--[[
TheNexusAvenger

Displays the navigation tools on the side of the screen.
--]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local PlayerData = ReplicatedStorageProject:GetResource("State.PlayerData").GetPlayerData(Players.LocalPlayer)
local StartDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.StartDungeon")
local EndDungeon = ReplicatedStorageProject:GetResource("GameReplication.DungeonReplication.EndDungeon")
local GuiOpenStates = script.Parent:WaitForChild("GuiOpenStates")
local StoreOpenState = GuiOpenStates:WaitForChild("Store")
local MapOpenState = GuiOpenStates:WaitForChild("Map")



--Create the ScreenGui.
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SideToolsView"
ScreenGui.Parent = script.Parent

--Create the container.
local Background = Instance.new("ImageLabel")
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(1,0,0.5,0)
Background.AnchorPoint = Vector2.new(0.95,0.6)
Background.Image = "rbxassetid://132929425"
Background.Parent = ScreenGui

AspectRatioSwitcher.new(ScreenGui,1,function()
    Background.Size = UDim2.new(0.2 * (97/206),0,0.2,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeYY
end,function()
    Background.Size = UDim2.new(0.2 * (97/206),0,0.2,0)
    Background.SizeConstraint = Enum.SizeConstraint.RelativeXX
end)

local CycleButton = Instance.new("ImageButton")
CycleButton.BackgroundTransparency = 1
CycleButton.AnchorPoint = Vector2.new(0.5,0.5)
CycleButton.Size = UDim2.new(63/97,0,63/206,0)
CycleButton.Position = UDim2.new(0.5,0,0.31,0)
CycleButton.Image = "rbxassetid://132929353"
CycleButton.Parent = Background

local BagButton = Instance.new("ImageButton")
BagButton.BackgroundTransparency = 1
BagButton.AnchorPoint = Vector2.new(0.5,0.5)
BagButton.Size = UDim2.new(73/97,0,73/206,0)
BagButton.Position = UDim2.new(0.5,0,0.7,0)
BagButton.Image = "rbxassetid://133390487"
BagButton.Parent = Background

local TeleportButton = Instance.new("ImageButton")
TeleportButton.BackgroundTransparency = 1
TeleportButton.AnchorPoint = Vector2.new(0.5,0.5)
TeleportButton.Size = UDim2.new(64/97,0,64/206)
TeleportButton.Position = UDim2.new(0.5,0,1.09,0)
TeleportButton.Image = "rbxassetid://131348539"
TeleportButton.Parent = Background



--[[
Updates the buttons.
--]]
local function UpdateButtons()
    local Character = Players.LocalPlayer.Character
    if Character then
        if Character:FindFirstChild("HalloCycle") then
            CycleButton.Image = "rbxassetid://132929399"
        else
            CycleButton.Image = "rbxassetid://132929353"
        end
        if Character:FindFirstChild("TrickOrTreatBag") then
            BagButton.Image = "rbxassetid://133389683"
        else
            BagButton.Image = "rbxassetid://133390487"
        end
    end
end

--[[
Shows the stroe.
--]]
local function ShowStore()
    StoreOpenState.Value = true
end

--[[
Shows the map.
--]]
local function ShowMap()
    MapOpenState.Value = true
end

--[[
Toggles a tool being equipped.
--]]
local function ToggleEquipped(ToolName)
    --Show the store and return if the tool hasn't been purchased.
    if not PlayerData:GetValue("ToolsOwned")[ToolName] then
        ShowStore()
        return
    end

    --Toggle the tool.
    local Backpack = Players.LocalPlayer:WaitForChild("Backpack")
    local Character = Players.LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            local Tool = Backpack:FindFirstChild(ToolName)
            if Tool then
                Humanoid:EquipTool(Tool)
            else
                Humanoid:UnequipTools()
            end
            UpdateButtons()
        end
    end
end



--Connect the buttons.
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.Backpack,false)
local DB = true
CycleButton.MouseButton1Down:Connect(function()
    if DB and Background.Visible then
        DB = false
        ToggleEquipped("HalloCycle")
        wait()
        DB = true
    end
end)
BagButton.MouseButton1Down:Connect(function()
    if DB and Background.Visible then
        DB = false
        ToggleEquipped("TrickOrTreatBag")
        wait()
        DB = true
    end
end)
TeleportButton.MouseButton1Down:Connect(function()
    if DB and Background.Visible then
        DB = false
        if PlayerData:GetValue("WarpPurchased") then
            ShowMap()
        else
            ShowStore()
        end
        wait()
        DB = true
    end
end)
Players.LocalPlayer.CharacterAdded:Connect(UpdateButtons)

--Connect showing and hiding the UI.
StartDungeon.OnClientEvent:Connect(function()
    Background.Visible = false
    local Character = Players.LocalPlayer.Character
    if Character then
        local Humanoid = Character:FindFirstChild("Humanoid")
        if Humanoid then
            Humanoid:UnequipTools()
            UpdateButtons()
        end
    end
end)

EndDungeon.OnClientEvent:Connect(function()
    Background.Visible = true
end)