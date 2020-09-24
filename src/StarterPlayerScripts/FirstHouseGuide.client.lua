--[[
TheNexusAvenger

Helps players get used to using houses
for the first quest.
--]]

local HOUSE_INDICATOR_LOCATIONS = {
    {X=177,Y=11},
    {X=177,Y=12},
    {X=177,Y=14},
    {X=177,Y=15},
    {X=179,Y=11},
    {X=179,Y=15},
}

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local Quests = ReplicatedStorageProject:GetResource("State.Quests").new(Players.LocalPlayer)
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory").new(Players.LocalPlayer)

local InitialQuestActive = false



--[[
Updates the inital quest being active.
--]]
local function UpdateInitialQuestActive()
    InitialQuestActive = Quests:QuestConditonValid("Fortifying Town Hall","Inventory")
end



--Create the gradients.
local Gradients = {}
for _,Position in pairs(HOUSE_INDICATOR_LOCATIONS) do
    for i = 0,1.5,0.5 do
        local Border = Instance.new("Part")
        Border.Transparency = 1
        Border.CFrame = CFrame.new(Position.X * 100,10,Position.Y * 100) * CFrame.Angles(0,math.pi * i,0) * CFrame.new(0,0,50)
        Border.Size = Vector3.new(100,20,0.2)
        Border.Anchored = true
        Border.CanCollide = false
        Border.Parent = Workspace

        local BorderMesh = Instance.new("SpecialMesh")
        BorderMesh.MeshType = Enum.MeshType.Brick
        BorderMesh.Scale = Vector3.new(1,1,0)
        BorderMesh.Parent = Border

        local FrontGradient = Instance.new("Decal")
        FrontGradient.Color3 = Color3.new(0,170/255,0)
        FrontGradient.Transparency = 1
        FrontGradient.Texture = "http://www.roblox.com/asset/?id=154741878"
        FrontGradient.Face = "Front"
        FrontGradient.Parent = Border
        table.insert(Gradients,FrontGradient)

        local BackGradient = Instance.new("Decal")
        BackGradient.Color3 = Color3.new(0,170/255,0)
        BackGradient.Transparency = 1
        BackGradient.Texture = "http://www.roblox.com/asset/?id=154741878"
        BackGradient.Face = "Back"
        BackGradient.Parent = Border
        table.insert(Gradients,BackGradient)
    end
end

--Set up updating the gradients.
RunService.RenderStepped:Connect(function()
    local Transparency = InitialQuestActive and (math.sin(tick())/4) + 0.75 or 1
    for _,Gradient in pairs(Gradients) do
        Gradient.Transparency = Transparency
    end
end)

--Set up updating the quests.
Quests.QuestsChanged:Connect(UpdateInitialQuestActive)
Inventory.InventoryChanged:Connect(UpdateInitialQuestActive)
UpdateInitialQuestActive()