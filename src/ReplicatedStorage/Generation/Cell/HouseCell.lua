--[[
TheNexusAvenger

Generates a house cell.
--]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local BaseGrassCell = ReplicatedStorageProject:GetResource("Generation.Cell.BaseGrassCell")
local HouseData = ReplicatedStorageProject:GetResource("Generation.Houses")
local PoleItems = ReplicatedStorageProject:GetResource("Generation.Houses.PoleItems")
local StairItems = ReplicatedStorageProject:GetResource("Generation.Houses.StairItems")
local HouseState = ReplicatedStorageProject:GetResource("GameState.HouseState")
local StartHouse = ReplicatedStorageProject:GetResource("GameReplication.HouseReplication.StartHouse")

local HouseCell = BaseGrassCell:Extend()
HouseCell:SetClassName("HouseCell")



--[[
Creates a cell.
--]]
function HouseCell:__new(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self:InitializeSuper(X,Y,TopCellType,BottomCellType,LeftCellType,RightCellType)
    self.CurrentState = "ACTIVE"

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
    if LeftCellType == "Road" then
        HouseCenter = HouseCenter * CFrame.Angles(0,math.pi * (1/2),0)
    elseif RightCellType == "Road" then
        HouseCenter = HouseCenter * CFrame.Angles(0,math.pi * (3/2),0)
    elseif TopCellType == "Road" then
        HouseCenter = HouseCenter * CFrame.Angles(0,math.pi,0)
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
    
    --Set up the door.
    local MainDoorPart = HouseModel:WaitForChild("Door"):WaitForChild("MainDoor")
    self.MainDoorPart = MainDoorPart

    local DoorSound = Instance.new("Sound")
    DoorSound.SoundId = "http://www.roblox.com/asset/?id=130168771"
    DoorSound.Parent = MainDoorPart
    self.DoorSound = DoorSound

    local DoorClickDetector = Instance.new("ClickDetector")
    DoorClickDetector.MaxActivationDistance = 20
    DoorClickDetector.Parent = MainDoorPart
    self.DoorClickDetector = DoorClickDetector

    DoorClickDetector.MouseClick:Connect(function()
        if self.CurrentState == "ACTIVE" then
            StartHouse:FireServer(X,Y)
        end
    end)
    MainDoorPart.Touched:Connect(function(TouchPart)
        if self.CurrentState == "ACTIVE" then
            local Character = Players.LocalPlayer.Character
            if Character and TouchPart:IsDescendantOf(Character) then
                StartHouse:FireServer(X,Y)
            end
        end
    end)

    --Connect the state events.
    self.Events = {}
    local CellId = tostring(X).."_"..tostring(Y)
    table.insert(self.Events,HouseState.ChildAdded:Connect(function(Child)
        if Child.Name == CellId then
            table.insert(self.Events,Child.Changed:Connect(function()
                self:FetchState()
            end))
            self:FetchState()
        end
    end))
    table.insert(self.Events,HouseState.ChildRemoved:Connect(function(Child)
        if Child.Name == CellId then
            self:FetchState()
        end
    end))
    self:FetchState()
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
Updates the state of the house if it changed.
--]]
function HouseCell:UpdateState()
    --Clear the starting animation.
    if self.StartingAnimationModel then
        self.StartingAnimationModel:Destroy()
        self.StartingAnimationModel = nil
    end

    if self.CurrentState == "ACTIVE" then
        --Turn on the lights and allow clicking.
        for _,WindowModel in pairs(self.HouseModel:WaitForChild("Windows"):GetChildren()) do
            local Curtain = WindowModel:WaitForChild("Curtain")
            local Light = Curtain:WaitForChild("Light")
            Curtain.BrickColor = BrickColor.new("Pastel yellow")
            Curtain.Material = "Neon"
            Light.Enabled = true
        end
        self.DoorClickDetector.MaxActivationDistance = 20
    elseif self.CurrentState == "INACTIVE" then
        --Turn off the lights and disable clicking.
        for _,WindowModel in pairs(self.HouseModel:WaitForChild("Windows"):GetChildren()) do
            local Curtain = WindowModel:WaitForChild("Curtain")
            local Light = Curtain:WaitForChild("Light")
            Curtain.BrickColor = BrickColor.new("Black")
            Curtain.Material = "SmoothPlastic"
            Light.Enabled = false
        end
        self.DoorClickDetector.MaxActivationDistance = 0
    elseif self.CurrentState == "STARTING" then
        --Turn on the lights and disable clicking.
        for _,WindowModel in pairs(self.HouseModel:WaitForChild("Windows"):GetChildren()) do
            local Curtain = WindowModel:WaitForChild("Curtain")
            local Light = Curtain:WaitForChild("Light")
            Curtain.BrickColor = BrickColor.new("Pastel yellow")
            Curtain.Material = "Neon"
            Light.Enabled = true
        end
        self.DoorClickDetector.MaxActivationDistance = 0

        --Run the animation.
        coroutine.wrap(function()
            --Create the container and walls.
            local StartingAnimationModel = Instance.new("Model")
            StartingAnimationModel.Name = "StartingAnimationModel"
            StartingAnimationModel.Parent = self.CellModel
            self.StartingAnimationModel = StartingAnimationModel

            local Gradients = {}
            for i = 0,1.5,0.5 do
                local Border = Instance.new("Part")
                Border.Transparency = 1
                Border.CFrame = CFrame.new(self.X * 100,2,self.Y * 100) * CFrame.Angles(0,math.pi * i,0) * CFrame.new(0,0,50)
                Border.Size = Vector3.new(100,4,0.2)
                Border.Anchored = true
                Border.CanCollide = false
                Border.Parent = StartingAnimationModel

                local BorderMesh = Instance.new("BlockMesh")
                BorderMesh.Scale = Vector3.new(1,1,0)
                BorderMesh.Parent = Border

                local Gradient = Instance.new("Decal")
                Gradient.Color3 = Color3.new(0,170/255,255/255)
                Gradient.Transparency = 1
                Gradient.Texture = "http://www.roblox.com/asset/?id=154741878"
                Gradient.Face = "Front"
                Gradient.Parent = Border
                table.insert(Gradients,Gradient)

                local Gradient = Instance.new("Decal")
                Gradient.Color3 = Color3.new(0,170/255,255/255)
                Gradient.Transparency = 1
                Gradient.Texture = "http://www.roblox.com/asset/?id=154741878"
                Gradient.Face = "Back"
                Gradient.Parent = Border
                table.insert(Gradients,Gradient)
            end

            --Create the text.
            local DingPart = Instance.new("Part")
            DingPart.Transparency = 1
            DingPart.Size = Vector3.new(10,5,1)
            DingPart.CFrame = self.MainDoorPart.CFrame * CFrame.Angles(0,0,math.pi/2) * CFrame.new(0,4,-3)
            DingPart.Anchored = true
            DingPart.CanCollide = false
            DingPart.Parent = StartingAnimationModel

            local DingTexture = Instance.new("Decal")
            DingTexture.Texture = "http://www.roblox.com/asset/?id=130170915"
            DingTexture.Transparency = 1
            DingTexture.Parent = DingPart

            local DongPart = Instance.new("Part")
            DongPart.Transparency = 1
            DongPart.Size = Vector3.new(10,5,1)
            DongPart.CFrame = self.MainDoorPart.CFrame * CFrame.Angles(0,0,math.pi/2) * CFrame.new(0,4,-3)
            DongPart.Anchored = true
            DongPart.CanCollide = false
            DongPart.Parent = StartingAnimationModel

            local DongTexture = Instance.new("Decal")
            DongTexture.Texture = "http://www.roblox.com/asset/?id=130169494"
            DongTexture.Transparency = 1
            DongTexture.Parent = DongPart

            --Tween the gradients.
            for _,Gradient in pairs(Gradients) do
                TweenService:Create(Gradient,TweenInfo.new(3),{
                    Transparency = 0,
                }):Play()
            end

            --Play the sound.
            self.DoorSound:Play()

            --Display the text.
            DingTexture.Transparency = 0
            TweenService:Create(DingPart,TweenInfo.new(5.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
                CFrame = self.MainDoorPart.CFrame * CFrame.Angles(0,0,math.pi/2) * CFrame.new(math.random(-1,1),13,-4),
            }):Play()
            wait(0.15)
            DongTexture.Transparency = 0
            TweenService:Create(DongPart,TweenInfo.new(5.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{
                CFrame = self.MainDoorPart.CFrame * CFrame.Angles(0,0,math.pi/2) * CFrame.new(math.random(-1,1),8,-4),
            }):Play()

            --Hide the text.
            wait(3 - 0.15)
            TweenService:Create(DingTexture,TweenInfo.new(1.5),{
                Transparency = 1,
            }):Play()
            wait(0.15)
            TweenService:Create(DongTexture,TweenInfo.new(1.5),{
                Transparency = 1,
            }):Play()
        end)()
    end
end

--[[
Fetches the replicated state of the house.
--]]
function HouseCell:FetchState()
    --Fetch the state.
    local StateObject = HouseState:FindFirstChild(tostring(self.X).."_"..tostring(self.Y))
    local NewState = (StateObject and StateObject.Value or "ACTIVE")

    --Update the state if it changed.
    if NewState ~= self.CurrentState then
        self.CurrentState = NewState
        self:UpdateState()
    end
end

--[[
Destroys the cell.
--]]
function HouseCell:Destroy()
    self.super:Destroy()
    self.HouseModel:Destroy()
    for _,Event in pairs(self.Events) do
        Event:Disconnect()
    end
    self.Events = {}
end



return HouseCell