--[[
TheNexusAvenger

Displays the location of a character on the map.
--]]

local FULL_MAP_SIZE_CELLS = 200


local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local ItemData = ReplicatedStorageProject:GetResource("GameData.ItemData")
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory")

local CharacterIndicator = NexusObject:Extend()
CharacterIndicator:SetClassName("PlayerIndicator")



--[[
Creates a character indicator.
--]]
function CharacterIndicator:__new(MapContainer,Player)
    self:InitializeSuper()

    --Create the image labels.
    local PlayerIconBack = Instance.new("ImageLabel")
    PlayerIconBack.BackgroundTransparency = 1
    PlayerIconBack.Size = UDim2.new(0.6/FULL_MAP_SIZE_CELLS,0,0.6/FULL_MAP_SIZE_CELLS,0)
    PlayerIconBack.AnchorPoint = Vector2.new(0.5,0.5)
    PlayerIconBack.ZIndex = 5
    PlayerIconBack.Parent = MapContainer
    self.PlayerIconBack = PlayerIconBack

    local PlayerIconFront = Instance.new("ImageLabel")
    PlayerIconFront.BackgroundTransparency = 1
    PlayerIconFront.Size = UDim2.new(1,0,1,0)
    PlayerIconFront.ZIndex = 5
    PlayerIconFront.Parent = PlayerIconBack
    self.PlayerIconFront = PlayerIconFront

    local PlayerNameText = Instance.new("TextLabel")
    PlayerNameText.BackgroundTransparency = 1
    PlayerNameText.Size = UDim2.new(4,0,0.7,0)
    PlayerNameText.Position = UDim2.new(0.5,0,-0.7,0)
    PlayerNameText.AnchorPoint = Vector2.new(0.5,0)
    PlayerNameText.Font = Enum.Font.Antique
    PlayerNameText.Text = Player.Name
    PlayerNameText.TextColor3 = Color3.new(1,1,1)
    PlayerNameText.TextScaled = true
    PlayerNameText.TextXAlignment = "Center"
    PlayerNameText.ZIndex = 5
    PlayerNameText.Parent = PlayerIconBack

    --Connect the events.
    local Character = Player.Character
    self.Head = Player.Character:WaitForChild("Head")
    self.Inventory = Inventory.GetInventory(Player)
    coroutine.wrap(function()
        while Character.Parent and self.PlayerIconBack.Parent do
            self:UpdatePosition()
            wait()
        end
    end)()
    self.InventoryChangedEvent = self.Inventory.InventoryChanged:Connect(function()
        self:UpdateTextures()
    end)
    self:UpdateTextures()
end

--[[
Updates the textures of the eye.
--]]
function CharacterIndicator:UpdateTextures()
    --Update the back.
    local EyeBackName = (self.Inventory:GetItem("MapEyeBack") or {Name="MapEyeBackBrown"}).Name
    self.PlayerIconBack.Image = "rbxassetid://"..tostring(ItemData[EyeBackName].TextureId)

    --Update the front.
    local EyeFrontName = (self.Inventory:GetItem("MapEyeFront") or {Name="MapEyeFrontDefault"}).Name
    self.PlayerIconFront.Image = "rbxassetid://"..tostring(ItemData[EyeFrontName].TextureId)
end

--[[
Updates the position of the indicator.
--]]
function CharacterIndicator:UpdatePosition()
    self.PlayerIconBack.Position = UDim2.new(((self.Head.CFrame.Z/100) - 0.5)/FULL_MAP_SIZE_CELLS,0,(FULL_MAP_SIZE_CELLS - (self.Head.CFrame.X/100) + 0.5)/FULL_MAP_SIZE_CELLS,0)
end

--[[
Destroys the indicator.
--]]
function CharacterIndicator:Destroy()
    self.InventoryChangedEvent:Disconnect()
    self.PlayerIconBack:Destroy()
end


return CharacterIndicator