--[[
TheNexusAvenger

Generates a tree.
--]]

local LEAVE_COLORS = {
    BrickColor.new("Bright yellow"),
    BrickColor.new("Bright orange"),
    BrickColor.new("Bright red"),
}



local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local Tree = NexusObject:Extend()
Tree:SetClassName("Tree")



--[[
Creates a tree.
--]]
function Tree:__new(Center,Parent,RandomNumberGenerator)
    self:InitializeSuper()

    --Create the model.
    local TreeModel = Instance.new("Model")
    TreeModel.Name = "Tree"
    TreeModel.Parent = Parent
    self.TreeModel = TreeModel
    self.RandomNumberGenerator = RandomNumberGenerator

    --Create the trunk.
    local TrunkLength = RandomNumberGenerator:NextNumber(8,10)
	Center = self:CreateWood(TrunkLength,3,Center * CFrame.new(0,-1,0) * CFrame.Angles(RandomNumberGenerator:NextNumber(-math.rad(5),math.rad(5)),0,RandomNumberGenerator:NextNumber(-math.rad(5),math.rad(5))))
    Center = self:CreateWood(TrunkLength,3,Center * CFrame.Angles(RandomNumberGenerator:NextNumber(-math.rad(10),math.rad(10)),0,RandomNumberGenerator:NextNumber(-math.rad(10),math.rad(10))))
    
    --Create the branches.
	local TotalBranches = RandomNumberGenerator:NextInteger(3,4)
	for i = 1,TotalBranches do
		local BranchCenter = Center * CFrame.Angles(0,(2 * math.pi * (i/TotalBranches)) + RandomNumberGenerator:NextNumber(-math.rad(15),math.rad(15)),0) * CFrame.Angles(RandomNumberGenerator:NextNumber(math.rad(40),math.rad(65)),RandomNumberGenerator:NextNumber(-math.rad(15),math.rad(15)),0)
		BranchCenter = self:CreateWood(RandomNumberGenerator:NextNumber(6,10),2,BranchCenter)
		for j = 1,2 do
			local LeavesCenter = BranchCenter * CFrame.Angles(0,(math.pi * j) + RandomNumberGenerator:NextNumber(-math.rad(45),math.rad(45)),0) * CFrame.Angles(RandomNumberGenerator:NextNumber(math.rad(30),math.rad(50)),0,0)
			LeavesCenter = self:CreateWood(RandomNumberGenerator:NextNumber(4,6),1,LeavesCenter)
			self:CreateLeaves(RandomNumberGenerator:NextNumber(12,16),LeavesCenter * CFrame.Angles(RandomNumberGenerator:NextNumber(),RandomNumberGenerator:NextNumber(),RandomNumberGenerator:NextNumber()))
		end
	end
end

--[[
Creates a part in the tree model.
--]]
function Tree:CreatePart(Color,Material,Size,Center,Shape)
    local Part = Instance.new("Part")
	Part.BrickColor = Color
	Part.Material = Material
	Part.Shape = Shape or "Block"
	Part.Size = Size
	Part.CFrame = Center
	Part.Anchored = true
	Part.TopSurface = "Smooth"
	Part.BottomSurface = "Smooth"
	Part.Parent = self.TreeModel
end

--[[
Creates a wood part for the tree.
Returns the end CFrame.
--]]
function Tree:CreateWood(Length,Width,Center)
    self:CreatePart(BrickColor.new("Brown"),"Wood",Vector3.new(Length,Width,Width),Center * CFrame.new(0,Length/2,0) * CFrame.Angles(0,0,math.pi/2),"Cylinder")
	self:CreatePart(BrickColor.new("Brown"),"Wood",Vector3.new(Width,Width,Width),Center * CFrame.new(0,Length,0) * CFrame.Angles(0,0,math.pi/2),"Ball")
	return Center * CFrame.new(0,Length,0)
end

--[[
Creates a set of leaves for the tree.
--]]
function Tree:CreateLeaves(Width,Center)
    local Size = Vector3.new(Width,Width,Width)
	self:CreatePart(LEAVE_COLORS[self.RandomNumberGenerator:NextInteger(1,#LEAVE_COLORS)],"Grass",Size,Center * CFrame.Angles(self.RandomNumberGenerator:NextNumber(),self.RandomNumberGenerator:NextNumber(),self.RandomNumberGenerator:NextNumber()))
	self:CreatePart(LEAVE_COLORS[self.RandomNumberGenerator:NextInteger(1,#LEAVE_COLORS)],"Grass",Size * 0.8,Center * CFrame.Angles(self.RandomNumberGenerator:NextNumber(),self.RandomNumberGenerator:NextNumber(),self.RandomNumberGenerator:NextNumber()))
end

--[[
Destroys the tree.
--]]
function Tree:Destroy()
    self.TreeModel:Destroy()
end



return Tree