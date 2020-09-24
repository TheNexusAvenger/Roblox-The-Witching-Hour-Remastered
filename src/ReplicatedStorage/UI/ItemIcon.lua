--[[
TheNexusAvenger

Displays an item in the inventory.
--]]

local CAMERA_FIELD_OF_VIEW = 20
local CAMERA_CFRAME_BACK_MULTIPLIER = 3.6
local ROTATE_SPEED_MULTIPLIER = 0.5



local RunService = game:GetService("RunService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ItemDataModule = ReplicatedStorageProject:GetObjectReference("GameData.Item.Items")
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")

local ItemIcon = NexusObject:Extend()
ItemIcon:SetClassName("ItemIcon")



--[[
Creates an item icon.
--]]
function ItemIcon:__new()
    self:InitializeSuper()

    --Create the container.
    local ViewportFrame = Instance.new("ViewportFrame")
    ViewportFrame.BackgroundTransparency = 1
    ViewportFrame.Size = UDim2.new(1,0,1,0)
    self.ViewportFrame = ViewportFrame

    local Camera = Instance.new("Camera")
    Camera.FieldOfView = CAMERA_FIELD_OF_VIEW
    Camera.Parent = ViewportFrame
    self.Camera = Camera
    ViewportFrame.CurrentCamera = Camera
end

--[[
Sets the item to display.
--]]
function ItemIcon:SetItem(ModelName)
    --Return if the model name hasn't changed.
    if self.LastModelname == ModelName then return end
    self.LastModelname = ModelName

    --Destroy the existing model.
    if self.Model then
        self.Model:Destroy()
    end
    if self.RotateModelEvent then
        self.RotateModelEvent:Disconnect()
    end

    --Return if the model name is undefined (such as clearing).
    if not ModelName or not ItemData[ModelName] then return end

    --Create the model.
    local ModelData = ItemData[ModelName]
    local Model = ItemDataModule:FindFirstChild(ModelName)
    if Model then
        if ModelData.ItemType == "PlayerHat" then
            --Clone the hat's handle if it exists.
            local Accessory = Model:FindFirstChildWhichIsA("Accoutrement")
            if Accessory then
                local Handle = Accessory:FindFirstChild("Handle")
                if Handle then
                    self.Model = Handle:Clone()
                    self.Model.Parent = self.ViewportFrame
                end
            end
        elseif Model:FindFirstChild("R6") then
            --Create the body part for the R6 body part.
            local CharacterMesh = Model:FindFirstChild("R6"):FindFirstChildWhichIsA("CharacterMesh")
            if CharacterMesh then
                self.Model = Instance.new("Part")
                self.Model.Size = (ModelData.ItemType == "PlayerTorso" and Vector3.new(2,2,1) or Vector3.new(1,2,1))
                self.Model.Parent = self.ViewportFrame

                if ModelData.ItemType == "PlayerTorso" then
                    self.Model.BrickColor = BrickColor.new("Bright green")
                elseif ModelData.ItemType == "PlayerLeftArm" or  ModelData.ItemType == "PlayerRightArm" then
                    self.Model.BrickColor = BrickColor.new("Bright blue")
                else
                    self.Model.BrickColor = BrickColor.new("Bright yellow")
                end

                local Mesh = Instance.new("SpecialMesh")
                Mesh.MeshType = Enum.MeshType.FileMesh
                Mesh.MeshId = "rbxassetid://"..CharacterMesh.MeshId
                if CharacterMesh.OverlayTextureId ~= 0 then
                    Mesh.TextureId = "rbxassetid://"..CharacterMesh.OverlayTextureId
                elseif CharacterMesh.BaseTextureId ~= 0 then
                    Mesh.TextureId = "rbxassetid://"..CharacterMesh.BaseTextureId
                end
                Mesh.Parent = self.Model
            end
        end
    else
        if ModelData.MeshId then
            --Create the mesh.
            local Part = Instance.new("Part")
            Part.Size = ModelData.Size or Vector3.new(1,1,1)
            Part.Parent = self.ViewportFrame
            self.Model = Part

            local Mesh = Instance.new("SpecialMesh")
            Mesh.MeshType = Enum.MeshType.FileMesh
            Mesh.MeshId = "rbxassetid://"..tostring(ModelData.MeshId)
            Mesh.TextureId = "rbxassetid://"..tostring(ModelData.TextureId)
            Mesh.Parent = Part
        elseif ModelData.TextureId then
             --Create the mesh.
             local Part = Instance.new("Part")
             Part.Transparency = 1
             Part.Size = ModelData.Size or Vector3.new(1,1,1)
             Part.Parent = self.ViewportFrame
             self.Model = Part
 
             local Mesh = Instance.new("SpecialMesh")
             Mesh.MeshType = Enum.MeshType.Brick
             Mesh.Scale = Vector3.new(1,1,0)
             Mesh.Parent = Part

             local Front = Instance.new("Decal")
             Front.Texture = "rbxassetid://"..tostring(ModelData.TextureId)
             Front.Face = Enum.NormalId.Front
             Front.Parent = Part

             local Back = Instance.new("Decal")
             Back.Texture = "rbxassetid://"..tostring(ModelData.TextureId)
             Back.Face = Enum.NormalId.Back
             Back.Parent = Part
        end
    end

    --Update the camera.
    if self.Model then
        self.Camera.CFrame = CFrame.new(0,0,CAMERA_CFRAME_BACK_MULTIPLIER * math.max(self.Model.Size.X,self.Model.Size.Y,self.Model.Size.Z))
    end

    --Start rotating the model.
    if self.Model then
        self.RotateModelEvent = RunService.RenderStepped:Connect(function()
            self.Model.CFrame = CFrame.Angles(0,0,math.rad(-30)) * CFrame.Angles(0,(tick() * ROTATE_SPEED_MULTIPLIER) % (math.pi * 2),0)
        end)
    end
end

--[[
Sets the parent of the frame.
--]]
function ItemIcon:SetParent(Parent)
    self.ViewportFrame.Parent = Parent
    self.ViewportFrame.ZIndex = Parent.ZIndex
end

--[[
Destroys the frame.
--]]
function ItemIcon:Destroy()
    if self.Model then
        self.Model:Destroy()
    end
    if self.RotateModelEvent then
        self.RotateModelEvent:Disconnect()
    end
    self.ViewportFrame:Destroy()
end


return ItemIcon