--[[
TheNexusAvenger

Animation for an item being awarded.
"Inpired" from Lego Universe's animation.
--]]

local ADDITIONAL_HEIGHT_MULTIPLIER = 0.5



local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local Bloxkins = ReplicatedStorageProject:GetResource("GameData.Item.Bloxkins")
local ItemIcon = ReplicatedStorageProject:GetResource("UI.ItemIcon")

local ItemAwardAnimation = NexusObject:Extend()
ItemAwardAnimation:SetClassName("ItemAwardAnimation")



--[[
Creates an item award animation.
--]]
function ItemAwardAnimation:__new(Frame,StartPosition,EndFrame,AnimationTime)
    self:InitializeSuper()

    --Store the information.
    self.Frame = Frame
    self.StartPosition = StartPosition
    self.EndFrame = EndFrame
    self.AnimationTime = AnimationTime

    --Create the container.
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.DisplayOrder = 100
    ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    self.ScreenGui = ScreenGui
end

--[[
Displays an award animation for an item
from a start position.
--]]
function ItemAwardAnimation.DisplayItemAwardFromPosition(ItemName,StartPosition)
    --Create the frame.
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1
    local Icon = ItemIcon.new()
    Icon:SetParent(Frame)
    Icon:SetItem(ItemName)

    --Play the animation and clear the icon.
    coroutine.wrap(function()
        local EndFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BottomBarGui"):WaitForChild("BottomFrame"):WaitForChild("MenuBottomBarBackground"):WaitForChild("Inventory"):WaitForChild("TextButton")
        local Animation = ItemAwardAnimation.new(Frame,StartPosition,EndFrame,0.5)
        Animation:Play()
        Icon:Destroy()
    end)()
end

--[[
Displays an award animation for an item
from a start frame.
--]]
function ItemAwardAnimation.DisplayItemAwardFromFrame(ItemName,StartFrame)
    local StartPosition = StartFrame.AbsolutePosition + (StartFrame.AbsoluteSize/2)
    ItemAwardAnimation.DisplayItemAwardFromPosition(ItemName,UDim2.new(0,StartPosition.X,0,StartPosition.Y))
end

--[[
Displays an award animation for a bloxkin
from a start position.
--]]
function ItemAwardAnimation.DisplayBloxkinAwardFromPosition(BloxkinName,StartPosition)
    --Create the frame.
    local Frame = Instance.new("Frame")
    Frame.BackgroundTransparency = 1

    local BloxkinImage = Instance.new("ImageLabel")
    BloxkinImage.BackgroundTransparency = 1
    BloxkinImage.AnchorPoint = Vector2.new(0.5,0.5)
    BloxkinImage.Size = UDim2.new(1,0,2,0)
    BloxkinImage.Position = UDim2.new(0.5,0,0.5,0)
    BloxkinImage.Image = Bloxkins[BloxkinName].UnlockedImage
    BloxkinImage.Parent = Frame

    --Play the animation.
    coroutine.wrap(function()
        local EndFrame = Players.LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("BottomBarGui"):WaitForChild("BottomFrame"):WaitForChild("MenuBottomBarBackground"):WaitForChild("Collectables"):WaitForChild("TextButton")
        local Animation = ItemAwardAnimation.new(Frame,StartPosition,EndFrame,0.5)
        Animation:Play()
    end)()
end

--[[
Displays an award animation for a bloxkin
from a start frame.
--]]
function ItemAwardAnimation.DisplayBloxkinAwardFromFrame(BloxkinName,StartFrame)
    local StartPosition = StartFrame.AbsolutePosition + (StartFrame.AbsoluteSize/2)
    ItemAwardAnimation.DisplayBloxkinAwardFromPosition(BloxkinName,UDim2.new(0,StartPosition.X,0,StartPosition.Y))
end

--[[
Plays the animation.
--]]
function ItemAwardAnimation:Play()
    --Finalize the frame.
    self.Frame.Size = UDim2.new(0.075,0,0.075,0)
    self.Frame.AnchorPoint = Vector2.new(0.5,0.5)
    self.Frame.SizeConstraint = Enum.SizeConstraint.RelativeYY
    self.Frame.Parent = self.ScreenGui

    --Play the tween animation.
    local StartTime = tick()
    while tick() - StartTime < self.AnimationTime do
        self:SetFramePosition((tick() - StartTime)/self.AnimationTime)
        RunService.RenderStepped:Wait()
    end
    self:SetFramePosition(1)

    --Destroy the frame and play the end animation.
    self.Frame:Destroy()
    local EndPosition = self.EndFrame.AbsolutePosition + (self.EndFrame.AbsoluteSize/2)
    local EndFrame = Instance.new("Frame")
    EndFrame.AnchorPoint = Vector2.new(0.5,0.5)
    EndFrame.BackgroundColor3 = Color3.new(1,1,1)
    EndFrame.BorderSizePixel = 0
    EndFrame.Size = UDim2.new(0,0,0,0)
    EndFrame.SizeConstraint = "RelativeYY"
    EndFrame.Position = UDim2.new(0,EndPosition.X,0,EndPosition.Y)
    EndFrame.Parent = self.ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0.5,0)
    UICorner.Parent = EndFrame

    TweenService:Create(EndFrame,TweenInfo.new(0.25),{
        BackgroundTransparency = 1,
        Size = UDim2.new(0.1,0,0.1,0),
    }):Play()
    wait(0.25)

    --Destroy the ScreenGui.
    self.ScreenGui:Destroy()
end

--[[
Moves the frame for the current
--]]
function ItemAwardAnimation:SetFramePosition(Ratio)
    --Calculate the start and end.
    local EndPosition = self.EndFrame.AbsolutePosition + (self.EndFrame.AbsoluteSize/2)
    local StartPosition = Vector2.new((self.StartPosition.X.Scale * self.ScreenGui.AbsoluteSize.X) + self.StartPosition.X.Offset,(self.StartPosition.Y.Scale * self.ScreenGui.AbsoluteSize.Y) + self.StartPosition.Y.Offset)
    local DeltaPosition = EndPosition - StartPosition
    local Time = self.AnimationTime * Ratio

    --Calculate the arc.
    --Remember that Y is positive in the down direction.
    local TargetHeight = math.min(EndPosition.Y,StartPosition.Y) - (self.ScreenGui.AbsoluteSize.Y * ADDITIONAL_HEIGHT_MULTIPLIER)
    local HeightRelativeToStart = TargetHeight - StartPosition.Y
    local ThrowAngle = math.atan2(HeightRelativeToStart,DeltaPosition.X/2)
    local ThrowVelocityX = DeltaPosition.X/self.AnimationTime
    local ThrowVelocity = ThrowVelocityX/math.cos(ThrowAngle)
    local ThrowVelocityY = math.sin(ThrowAngle) * ThrowVelocity
    local Acceleration = (2 * (DeltaPosition.Y - (ThrowVelocityY * self.AnimationTime))) / (self.AnimationTime ^ 2)
    local StepHeight = (ThrowVelocityY * Time) + (0.5 * Acceleration * (Time ^ 2))

    --Move the frame.
    self.Frame.Position = UDim2.new(0,StartPosition.X + (DeltaPosition.X * Ratio),0,StartPosition.Y + StepHeight)
end



return ItemAwardAnimation