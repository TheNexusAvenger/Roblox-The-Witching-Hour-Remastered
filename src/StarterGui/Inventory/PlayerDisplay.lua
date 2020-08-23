--[[
TheNexusAvenger

Displays the player for the inventory.
--]]

local CAMERA_FIELD_OF_VIEW = 20
local CAMERA_CFRAME_BACK = 19
local ROTATE_SPEED_MULTIPLIER = 0.5



local RunService = game:GetService("RunService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ItemDataModule = ReplicatedStorageProject:GetObjectReference("GameData.ItemData")
local R15CharacterModel = ReplicatedStorageProject:GetResource("R15CharacterModel")

local PlayerDisplay = NexusObject:Extend()
PlayerDisplay:SetClassName("ItemIcon")



--[[
Creates a player display.
--]]
function PlayerDisplay:__new(Parent)
    self:InitializeSuper()

    --Store the state.
    self.PreviousLimbs = {}
    self.PreviousLimbChanges = {}

    --Create the container.
    local ViewportFrame = Instance.new("ViewportFrame")
    ViewportFrame.BackgroundTransparency = 1
    ViewportFrame.Size = UDim2.new(1,0,1,0)
    ViewportFrame.Parent = Parent
    self.ViewportFrame = ViewportFrame

    local Camera = Instance.new("Camera")
    Camera.FieldOfView = CAMERA_FIELD_OF_VIEW
    Camera.Parent = ViewportFrame
    self.Camera = Camera
    ViewportFrame.CurrentCamera = Camera

    --Create the character.
    local WorldModel = Instance.new("WorldModel")
    WorldModel.Parent = ViewportFrame

    self.Character = R15CharacterModel:Clone()
    self.Character.PrimaryPart = self.Character:WaitForChild("HumanoidRootPart")
    self.Character:SetPrimaryPartCFrame(CFrame.Angles(0,math.pi,0))
    self.Head = self.Character:WaitForChild("Head")

    local BodyColors = Instance.new("BodyColors")
    BodyColors.HeadColor = BrickColor.new("Bright yellow")
    BodyColors.LeftArmColor = BrickColor.new("Bright yellow")
    BodyColors.RightArmColor = BrickColor.new("Bright yellow")
    BodyColors.TorsoColor = BrickColor.new("Bright green")
    BodyColors.LeftLegColor = BrickColor.new("Bright blue")
    BodyColors.RightLegColor = BrickColor.new("Bright blue")
    BodyColors.Parent = self.Character
    self.Character.Parent = WorldModel

    --Start the animation.
    local Animation = Instance.new("Animation")
    Animation.AnimationId = "http://www.roblox.com/asset/?id=913376220"

    local Humanoid = self.Character:WaitForChild("Humanoid")
    self.Humanoid = Humanoid
    local AnimationTrack = Humanoid:LoadAnimation(Animation)
    AnimationTrack.Stopped:Connect(function()
        AnimationTrack:Play()
    end)
    AnimationTrack:Play()

    --Start rotating the camera.
    RunService.RenderStepped:Connect(function()
        Camera.CFrame = CFrame.Angles(0,math.sin(tick() * ROTATE_SPEED_MULTIPLIER)/2,0) * CFrame.new(0,0,CAMERA_CFRAME_BACK)
    end)
end

--[[
Sets the hat to wear.
--]]
function PlayerDisplay:SetHat(HatItem)
    --Get the hat name.
    local HatName
    if HatItem then
        HatName = HatItem.Name
    end

    --Return if the hat hasn't changed.
    if self.CurrentHatName == HatName then
        return
    end
    self.CurrentHatName = HatName

    --Clear the existing hat.
    if self.CurrentHat then
        self.CurrentHat:Destroy()
    end

    --Add the new hat.
    if HatName then
        local HatModel = ItemDataModule:FindFirstChild(HatName)
        if HatModel then
            local Hat = HatModel:FindFirstChildWhichIsA("Accoutrement")
            if Hat then
                --Add the new hat.
                local NewHat = Hat:Clone()
                NewHat.Parent = self.Character
                self.CurrentHat = NewHat

                --Weld the hat to the character.
                --This isn't done automatically by WorldModels.
                local Handle = NewHat:FindFirstChild("Handle")
                local HatAttachment = Handle:FindFirstChildWhichIsA("Attachment")
                if HatAttachment and Handle then
                    local HeadAttachment = self.Head:FindFirstChild(HatAttachment.Name)
                    if HeadAttachment then
                        local HatWeld = Instance.new("Weld")
                        HatWeld.Part0 = self.Head
                        HatWeld.Part1 = Handle
                        HatWeld.C0 = HeadAttachment.CFrame
                        HatWeld.C1 = HatAttachment.CFrame
                        HatWeld.Parent = self.Head
                    end
                end
            end
        end
    end
end

--[[
Sets the limb to use.
--]]
function PlayerDisplay:SetItem(LimbName,Item)
    --Get the hat name.
    local ItemName
    if Item then
        ItemName = Item.Name
    end

    --Return if the limb hasn't changed.
    if self.PreviousLimbs[LimbName] == ItemName then
        return
    end
    self.PreviousLimbs[LimbName] = ItemName

    --Set the limb.
    local BodyPartsChanged = {}
    if ItemName then
        local LimbModel = ItemDataModule:FindFirstChild(ItemName)
        if LimbModel then
            local LimbModelR15 = LimbModel:FindFirstChild("R15")
            if LimbModelR15 then
                for _,Part in pairs(LimbModelR15:GetChildren()) do
                    if Part:IsA("BasePart") then
                        local BodyPartEnum = Enum.BodyPartR15[Part.Name]
                        self.Humanoid:ReplaceBodyPartR15(BodyPartEnum,Part)
                        BodyPartsChanged[BodyPartEnum] = Part.Name
                    end
                end
            end
        end
    end

    --Revert the unchanged limb parts.
    local ExistingLimbChanges = self.PreviousLimbChanges[LimbName]
    if ExistingLimbChanges then
        for BodyPartEnum,PartName in pairs(ExistingLimbChanges) do
            if not BodyPartsChanged[BodyPartEnum] then
                local Part = R15CharacterModel:FindFirstChild(PartName)
                if Part then
                    self.Humanoid:ReplaceBodyPartR15(BodyPartEnum,Part)
                end
            end
        end
    end
    self.PreviousLimbChanges[LimbName] = BodyPartsChanged
end



return PlayerDisplay