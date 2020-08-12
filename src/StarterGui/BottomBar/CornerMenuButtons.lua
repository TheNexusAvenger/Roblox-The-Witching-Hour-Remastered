--[[
TheNexusAvenger

Menu buttons for the bottom bar.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local CornerMenuButtons = NexusObject:Extend()
CornerMenuButtons:SetClassName("CornerMenuButtons")



--[[
Creates corner menu buttons.
--]]
function CornerMenuButtons:__new(BottomFrame)
    self:InitializeSuper()

    --Create the bottom bar container.
    local MenuBottomBarBackground = Instance.new("ImageLabel")
    MenuBottomBarBackground.Size = UDim2.new(1.8,0,1.8,0)
    MenuBottomBarBackground.SizeConstraint = "RelativeYY"
    MenuBottomBarBackground.AnchorPoint = Vector2.new(0.025,0.325)
    MenuBottomBarBackground.BackgroundTransparency = 1
    MenuBottomBarBackground.Image = "rbxassetid://132724720"
    MenuBottomBarBackground.Parent = BottomFrame

    --Create the currency display.
    --TODO

    --Create the buttons.
    --TODO: Implement
end



return CornerMenuButtons