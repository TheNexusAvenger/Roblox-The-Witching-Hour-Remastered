--[[
TheNexusAvenger

Decorates an ImageLabel with the
appearance of a wide text button.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")

local WideTextButtonDecorator = ImageEventBinder:Extend()
WideTextButtonDecorator:SetClassName("WideTextButtonDecorator")



--[[
Creates a button decorator.
--]]
function WideTextButtonDecorator:__new(ImageLabel,Text)
    self:InitializeSuper(ImageLabel,UDim2.new(1,0,1,0),"rbxassetid://5558262263","rbxassetid://5558312338","rbxassetid://5558312888")

    --Create the text label.
    local ButtonText = Instance.new("TextLabel")
    ButtonText.BackgroundTransparency = 1
    ButtonText.Size = UDim2.new(0.8,0,0.8,0)
    ButtonText.Position = UDim2.new(0.1,0,0.025,0)
    ButtonText.Font = Enum.Font.Antique
    ButtonText.Text = Text
    ButtonText.TextColor3 = Color3.new(40/255,40/255,40/255)
    ButtonText.TextScaled = true
    ButtonText.ZIndex = ImageLabel.ZIndex
    ButtonText.Parent = ImageLabel

    --Connect updating the text color.
    ImageLabel:GetPropertyChangedSignal("Image"):Connect(function()
        if ImageLabel.Image == "rbxassetid://5558312338" then
            ButtonText.TextColor3 = Color3.new(81/255,41/255,89/255)
        elseif ImageLabel.Image == "rbxassetid://5558312888" then
            ButtonText.TextColor3 = Color3.new(67/255,27/255,75/255)
        else
            ButtonText.TextColor3 = Color3.new(40/255,40/255,40/255)
        end
    end)
end



return WideTextButtonDecorator