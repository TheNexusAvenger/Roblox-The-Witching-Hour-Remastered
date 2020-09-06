--[[
TheNexusAvenger

Displays the pet for the inventory.
--]]

local CAMERA_FIELD_OF_VIEW = 20
local CAMERA_CFRAME_BACK = 12
local ROTATE_SPEED_MULTIPLIER = 0.5
local SLOT_TO_PART_NAME = {
	PetCostumeHat = "Hat",
	PetCostumeCollar = "Collar",
	PetCostumeBack = "Cape",
	PetCostumeAnkle = "Anklet",
}



local RunService = game:GetService("RunService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ItemData = ReplicatedStorageProject:GetResource("GameData.Item.Items")
local PetSkinTextures = ReplicatedStorageProject:GetResource("GameData.Item.PetSkinTextures")

local PetDisplay = NexusObject:Extend()
PetDisplay:SetClassName("PetDisplay")



--[[
Creates a pet display.
--]]
function PetDisplay:__new(Parent)
	self:InitializeSuper()
	
	--Store the state.
	self.LastClothes = {}
	self.LastClothCostumes = {}
	
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
	
	local WorldModel = Instance.new("WorldModel")
	WorldModel.Parent = ViewportFrame
	self.WorldModel = WorldModel
	
	--Start rotating the camera.
	RunService.RenderStepped:Connect(function()
		Camera.CFrame = CFrame.Angles(0,math.sin(tick() * ROTATE_SPEED_MULTIPLIER)/2,0) * CFrame.new(0,0,CAMERA_CFRAME_BACK)
	end)
end

--[[
Sets the pet to display.
--]]
function PetDisplay:SetPet(PetName)
	--Return if the pet hasn't changed.
	if self.LastPetName == PetName then return end
	self.LastPetName = PetName

	--Destroy the existing pet.
	if self.Pet then
		self.Pet:Destroy()
	end

	--Add the pet.
	local Pet = ReplicatedStorageProject:GetResource("PetModels."..PetName):Clone()
	Pet.PrimaryPart = Pet:WaitForChild("HumanoidRootPart")
	Pet:SetPrimaryPartCFrame(CFrame.Angles(0,math.pi,0))
	Pet.Parent = self.WorldModel
	self.Pet = Pet
	self.Clothes = Pet:WaitForChild("Clothes")
	
	--Set the clothing.
	local ExistingClothing = self.LastClothes
	for Slot,_ in pairs(SLOT_TO_PART_NAME) do
		self:SetItem(Slot,{Name=ExistingClothing[Slot]},true)
	end

	--Start animating the pet.
	local Animation = Instance.new("Animation")
	Animation.AnimationId = "rbxassetid://161210451"
	
	local Humanoid = Pet:WaitForChild("Humanoid")
	local AnimationTrack = Humanoid:LoadAnimation(Animation)
	AnimationTrack.Stopped:Connect(function()
		AnimationTrack:Play()
	end)
	AnimationTrack:Play()
end

--[[
Sets the clothing to use for the pet.
--]]
function PetDisplay:SetItem(Slot,Item,ForceUpdate)
	local Name
	if Item then Name = Item.Name end

	--Return if the name hasn't changed.
	if self.LastClothes[Slot] == Name and not ForceUpdate then
		return
	end
	self.LastClothes[Slot] = Name

	--Determine the texture.
	local Texture
	if Name and ItemData[Name] then
		Texture = ItemData[Name].TextureId
	end

	--Update the textures.
	for _,Part in pairs(self.Clothes:GetChildren()) do
		if Part:IsA("BasePart") and Part.Name == SLOT_TO_PART_NAME[Slot] then
			local Mesh = Part:FindFirstChildWhichIsA("FileMesh")
			if Mesh then
				if Texture then
					Part.Transparency = 0
					Mesh.TextureId = "rbxassetid://"..tostring(Texture)
				else
					Part.Transparency = 1
				end
			end
		end
	end

	--Update the costume for the slot.
	if Name and ItemData[Name] then
		self.LastClothCostumes[Slot] = ItemData[Name].CostumeName
	else
		self.LastClothCostumes[Slot] = nil
	end

	--Update the pet texture if all 4 parts are part of costume match.
	local HasFullCostume = (self.LastClothCostumes["PetCostumeHat"] == self.LastClothCostumes["PetCostumeCollar"]) and (self.LastClothCostumes["PetCostumeHat"] == self.LastClothCostumes["PetCostumeBack"]) and (self.LastClothCostumes["PetCostumeHat"] == self.LastClothCostumes["PetCostumeAnkle"])
	local Costume = HasFullCostume and self.LastClothCostumes["PetCostumeHat"] or "Default"
	local PetTextureId = PetSkinTextures[Costume][self.LastPetName]
	for _,Part in pairs(self.Pet:GetChildren()) do
		if Part:IsA("BasePart") then
			local Mesh = Part:FindFirstChildWhichIsA("FileMesh")
			if Mesh then
				Mesh.TextureId = "rbxassetid://"..tostring(PetTextureId)
			end
		end
	end
end



return PetDisplay