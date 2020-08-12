--[[
TheNexusAvenger

Binds changing the images of buttons.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local ImageEventBinder = NexusObject:Extend()
ImageEventBinder:SetClassName("ImageEventBinder")



--[[
Creates an event binder.
--]]
function ImageEventBinder:__new(ImageLabel,ButtonSize,BaseImage,HoverImage,PressImage)
    self:InitializeSuper()

    --Create the button.
    local Button = Instance.new("TextButton")
    Button.BackgroundTransparency = 1
    Button.Size = ButtonSize
    Button.Text = ""
    Button.Parent = ImageLabel

    --Storage the state.
    self.ImageLabel = ImageLabel
    self.BaseImage = BaseImage
    self.HoverImage = HoverImage
    self.PressImage = PressImage
    self.Hovering = false
    self.Pressing = false
    self.Button = Button

    --Connect the events.
    Button.MouseEnter:Connect(function()
        self.Hovering = true
        self:UpdateImage()
    end)
    Button.MouseLeave:Connect(function()
        self.Hovering = false
        self.Pressing = false
        self:UpdateImage()
    end)
    Button.MouseButton1Down:Connect(function()
        self.Pressing = true
        self:UpdateImage()
    end)
    Button.MouseButton1Up:Connect(function()
        self.Pressing = false
        self:UpdateImage()
    end)
    self:UpdateImage()
end

--[[
Updates image of the button.
--]]
function ImageEventBinder:UpdateImage()
    if self.Pressing then
        self.ImageLabel.Image = self.PressImage
    elseif self.Hovering then
        self.ImageLabel.Image = self.HoverImage
    else
        self.ImageLabel.Image = self.BaseImage
    end
end



return ImageEventBinder