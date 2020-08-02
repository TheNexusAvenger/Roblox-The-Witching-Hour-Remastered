--[[
TheNexusAvenger

Generates a house cell.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")
local HouseData = ReplicatedStorageProject:GetResource("Generation.Houses")
local PoleItems = ReplicatedStorageProject:GetResource("Generation.Houses.PoleItems")
local StairItems = ReplicatedStorageProject:GetResource("Generation.Houses.StairItems")

local HouseCell = BaseGrassCell:Extend()
HouseCell:SetClassName("HouseCell")



--[[
Creates a cell.
--]]
function HouseCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)

    --Get the house data.
    local WallColor = HouseData.Colors.WallColors[self.RandomNumberGenerator:NextInteger(1,#HouseData.Colors.WallColors)]
    local RoofColor = HouseData.Colors.RoofColors[self.RandomNumberGenerator:NextInteger(1,#HouseData.Colors.RoofColors)]
    local AssemblyData = HouseData.HouseAssemblies[self.RandomNumberGenerator:NextInteger(1,#HouseData.HouseAssemblies)]
    local Components = {}
    for _,Component in pairs(AssemblyData.Components) do
        local ChosenComponent = Component.Options[self.RandomNumberGenerator:NextInteger(1,#Component.Options)]
        if ChosenComponent ~= nil then
            Components[Component.Group] = AssemblyData.HouseName.."."..Component.Group.."."..ChosenComponent
        end
    end

    --Determine the center.
    local HouseCenter = CFrame.new(X * 100,0,Y * 100)
    if TopCellType == "Road" then
        HouseCenter = HouseCenter * CFrame.Angles(0,math.pi,0)
    elseif LeftCellType == "Road" then
        HouseCenter = HouseCenter * CFrame.Angles(0,math.pi * (1/2),0)
    elseif RightCellType == "Road" then
        HouseCenter = HouseCenter * CFrame.Angles(0,math.pi * (3/2),0)
    end

    --Assemble the house model.
    local HouseModel = Instance.new("Model")
    HouseModel.Name = "House"
    HouseModel.Parent = self.CellModel
    self.HouseModel = HouseModel

    local BaseLevel = self:AddModel(Components["BaseLevels"],HouseCenter)
    local Front = self:AddModel(Components["Fronts"],HouseCenter)
    local SecondLevel
    if Components["SecondLevels"] then
        SecondLevel = self:AddModel(Components["SecondLevels"],BaseLevel:WaitForChild("TopCenter").CFrame)
    end
    local Roof = self:AddModel(Components["Roofs"],SecondLevel and SecondLevel:WaitForChild("TopCenter").CFrame or BaseLevel:WaitForChild("TopCenter").CFrame)
    if Components["Additions"] then
        self:AddModel(Components["Additions"],HouseCenter)
    end

    --Set the colors.
    local Roof = HouseModel:WaitForChild("Roof")
    for _,Part in pairs(HouseModel:WaitForChild("ColoredWalls"):GetChildren()) do
        if Part:IsA("BasePart") then
            Part.BrickColor = WallColor
        end
    end
    for _,Part in pairs(Roof:GetChildren()) do
        if Part:IsA("BasePart") then
            Part.BrickColor = RoofColor
        end
    end

    --Add leaves to the roof.
    for _,RoofPart in pairs(Roof:GetChildren()) do
        for _ = 1,(RoofPart.Size.X * RoofPart.Size.Z) / 200 do
            local Size = self.RandomNumberGenerator:NextNumber(8,12)
            if RoofPart.Size.X > Size and RoofPart.Size.Z > Size then
                local LeavesPart = Instance.new("Part")
                LeavesPart.Transparency = 1
                LeavesPart.Size = Vector3.new(Size,0.2,Size)
                LeavesPart.CFrame = RoofPart.CFrame * CFrame.new(self.RandomNumberGenerator:NextNumber(-(RoofPart.Size.X - Size)/2,(RoofPart.Size.X - Size)/2),RoofPart.Size.Y/2 - 0.075,self.RandomNumberGenerator:NextNumber(-(RoofPart.Size.Z - Size)/2,(RoofPart.Size.Z - Size)/2)) * CFrame.Angles(0,self.RandomNumberGenerator:NextNumber(-math.pi,math.pi),0)
                LeavesPart.Anchored = true
                LeavesPart.CanCollide = false
                LeavesPart.TopSurface = "Smooth"
                LeavesPart.BottomSurface = "Smooth"
                LeavesPart.Parent = HouseModel
                
                local LeavesDecal = Instance.new("Decal")
                LeavesDecal.Texture = "rbxassetid://134660590"
                LeavesDecal.Face = "Top"
                LeavesDecal.Parent = LeavesPart
            end
        end
    end

    --Add the lawn decorations.
    for i = 1,self.RandomNumberGenerator:NextInteger(1,3) do
        --Determine the center.
        local PoleCenter = HouseCenter * CFrame.new(0,0,-50 + self.RandomNumberGenerator:NextNumber(2,AssemblyData.LawnDepth))
        if self.RandomNumberGenerator:NextNumber() >= 0.5 then
            PoleCenter = PoleCenter * CFrame.new(self.RandomNumberGenerator:NextNumber(-45,-6),0,0)
        else
            PoleCenter = PoleCenter * CFrame.new(self.RandomNumberGenerator:NextNumber(6,45),0,0)
        end
        PoleCenter = PoleCenter * CFrame.Angles(0,self.RandomNumberGenerator:NextNumber(math.rad(-10),math.rad(10)),0)

        --Add a random pole model.
        local PoleModel = PoleItems:GetChildren()[self.RandomNumberGenerator:NextInteger(1,#PoleItems:GetChildren())]:Clone()
        PoleModel.PrimaryPart = PoleModel:WaitForChild("Pole")
        PoleModel:SetPrimaryPartCFrame(PoleCenter * CFrame.new(0,PoleModel.PrimaryPart.Size.X/2,0) * CFrame.Angles(0,0,math.pi/2))
        PoleModel.Parent = HouseModel
    end

    --Add the stair decorations.
    for _,StairPart in pairs({HouseModel:WaitForChild("Stairs"):FindFirstChild("Left"),HouseModel:WaitForChild("Stairs"):FindFirstChild("Right")}) do
        if StairPart then
            for i = 1,self.RandomNumberGenerator:NextInteger(0,1) do
                local Part = StairItems:GetChildren()[self.RandomNumberGenerator:NextInteger(1,#StairItems:GetChildren())]:Clone()
                Part.CFrame = StairPart.CFrame * CFrame.new(self.RandomNumberGenerator:NextNumber(-0.3,0.3),(StairPart.Size.Y/2) + (Part.Size.Y/2),self.RandomNumberGenerator:NextNumber(-0.3,0.3)) * CFrame.Angles(0,self.RandomNumberGenerator:NextNumber(math.rad(-20),math.rad(20)),0)
                Part.Parent = HouseModel
            end
        end
    end
    
    --TODO: Set up the state
    --TODO: Set up clicking
end

--[[
Adds a model to the house.
--]]
function HouseCell:AddModel(ModelPath,Center)
    --Get the model.
    local Model = ReplicatedStorageProject:GetResource("Generation.Houses."..ModelPath):Clone()
    Model.PrimaryPart = Model:WaitForChild("Center")
    Model:SetPrimaryPartCFrame(Center)

    --Merge the model.
    for _,Child in pairs(Model:GetChildren()) do
        if Child.Name ~= "Center" and Child.Name ~= "TopCenter" then
            local Parent = self.HouseModel:FindFirstChild(Child.Name)
            if Parent and Child:IsA("Model") then
                for _,SubChild in pairs(Child:GetChildren()) do
                    SubChild.Parent = Parent
                end
            else
                Child.Parent = self.HouseModel
            end
        end
    end

    --Return the model.
    return Model
end

--[[
Destroys the cell.
--]]
function HouseCell:Destroy()
    self.super:Destroy()
    self.HouseModel:Destroy()
end



return HouseCell