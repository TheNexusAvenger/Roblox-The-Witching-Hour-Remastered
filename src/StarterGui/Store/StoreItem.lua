--[[
TheNexusAvenger

Frame for showing store items.
--]]

local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local StoreItems = ReplicatedStorageProject:GetResource("GameData.Item.Store")
local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")
local Inventory = ReplicatedStorageProject:GetResource("State.Inventory").GetInventory(Players.LocalPlayer)
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")

local StoreItem = NexusObject:Extend()
StoreItem:SetClassName("StoreItem")



--[[
Creates a store item frame.
--]]
function StoreItem:__new(TransactionId,Parent)
    self:InitializeSuper()

    --Store the data.
    self.TransactionData = StoreItems[TransactionId]

    --Create the frame.
    local Background = Instance.new("ImageLabel")
    Background.BackgroundTransparency = 1
    Background.Image = "rbxassetid://132606169"
    Background.Parent = Parent
    self.Background = Background

    local ItemBackground = Instance.new("ImageLabel")
    ItemBackground.BackgroundTransparency = 1
    ItemBackground.AnchorPoint = Vector2.new(0,0.5)
    ItemBackground.Position = UDim2.new(6/202,0,0.5,0)
    ItemBackground.Size = UDim2.new(92/202,0,101/116,0)
    ItemBackground.Image = "rbxassetid://132606210"
    ItemBackground.Parent = Background

    local ItemIcon = Instance.new("ImageLabel")
    ItemIcon.BackgroundTransparency = 1
    ItemIcon.AnchorPoint = Vector2.new(0.5,0.5)
    ItemIcon.Position = UDim2.new(0.5,0,0.5,0)
    ItemIcon.Size = UDim2.new(64/92,0,64/101,0)
    ItemIcon.Image = self.TransactionData.IconId
    ItemIcon.Parent = ItemBackground

    local ItemName = Instance.new("TextLabel")
    ItemName.BackgroundTransparency = 1
    ItemName.Position = UDim2.new(0.5,0,0.17,0)
    ItemName.Size = UDim2.new(0.48,0,0.16,0)
    ItemName.Font = Enum.Font.Antique
    ItemName.Text = self.TransactionData.Name
    ItemName.TextScaled = true
    ItemName.TextColor3 = Color3.new(171/255,173/255,173/255)
    ItemName.Parent = Background

    local ItemCost = Instance.new("TextLabel")
    ItemCost.BackgroundTransparency = 1
    ItemCost.Position = UDim2.new(0.5,0,0.5,0)
    ItemCost.Size = UDim2.new(0.48,0,0.16,0)
    ItemCost.Font = Enum.Font.Antique
    ItemCost.Text = "Offsale"
    ItemCost.TextStrokeTransparency = 0
    ItemCost.TextScaled = true
    ItemCost.Parent = Background
    self.ItemCostLabel = ItemCost
    coroutine.wrap(function()
        self:UpdateCost()
    end)()

    local BuyStatusText = Instance.new("TextLabel")
    BuyStatusText.BackgroundTransparency = 1
    BuyStatusText.AnchorPoint = Vector2.new(0,0.5)
    BuyStatusText.Position = UDim2.new(0.5,0,92/116,0)
    BuyStatusText.Size = UDim2.new(0.48,0,0.16,0)
    BuyStatusText.Font = Enum.Font.Antique
    BuyStatusText.Text = ""
    BuyStatusText.TextStrokeTransparency = 0
    BuyStatusText.TextScaled = true
    BuyStatusText.Parent = Background
    self.ItemCostLabel = ItemCost

    local BuyImage = Instance.new("ImageLabel")
    BuyImage.BackgroundTransparency = 1
    BuyImage.Position = UDim2.new(107/202,0,80/116,0)
    BuyImage.Size = UDim2.new(84/202,0,24/116,0)
    BuyImage.Parent = Background
    local BuyButton = ImageEventBinder.new(BuyImage,UDim2.new(1,0,1,0),"rbxassetid://132623813","rbxassetid://132623803","rbxassetid://132623811")
    self.BuyImage = BuyImage

    --Connect buying the item.
    local DB = true
    if self.TransactionData.ProductId then
        BuyButton.Button.MouseButton1Down:Connect(function()
            if DB then
                DB = false
                MarketplaceService:PromptProductPurchase(Players.LocalPlayer,self.TransactionData.ProductId)
                wait()
                DB = true
            end
        end)
    else
        BuyButton.Button.MouseButton1Down:Connect(function()
            if DB then
                --Hide the button.
                DB = false
                BuyImage.Visible = false
                
                --Start the purchase.
                BuyStatusText.Text = "Please wait..."
                BuyStatusText.TextColor3 = Color3.new(1,1,1)
                BuyStatusText.TextStrokeColor3 = Color3.new(0,0,0)
                BuyStatusText.Visible = true
                local PurchaseSuccessful = true --TODO: Implment
    
                --Show the status.
                if PurchaseSuccessful then
                    BuyStatusText.Text = "Success"
                    BuyStatusText.TextColor3 = Color3.new(0,170/255,0)
                    BuyStatusText.TextStrokeColor3 = Color3.new(0,100/255,0)
                else
                    BuyStatusText.Text = "Failed"
                    BuyStatusText.TextColor3 = Color3.new(170/255,0,0)
                    BuyStatusText.TextStrokeColor3 = Color3.new(100/255,0,0)
                end
                wait(1)
                BuyImage.Visible = true
                BuyStatusText.Visible = false
                DB = true
            end
        end)
    end

    --Connect inventory space running out.
    if self.TransactionData.RequiresInventorySpace then
        Inventory.InventoryChanged:Connect(function()
            if Inventory:GetNextOpenSlot() then
                BuyStatusText.Visible = false
                BuyImage.Visible = true
            else
                BuyStatusText.Visible = true
                BuyStatusText.Text = "Inventory Full"
                BuyStatusText.TextColor3 = Color3.new(1,1,1)
                BuyStatusText.TextStrokeColor3 = Color3.new(0,0,0)
                BuyImage.Visible = false
            end
        end)
    end
    if self.TransactionData.AllowMultiple ~= true then
        Inventory.InventoryChanged:Connect(function()
            self:UpdateVisibility()
        end)
    end

    --Connect the callback.
    if self.TransactionData.CreateLocalChangeCallback then
        self.TransactionData.CreateLocalChangeCallback(function()
            self:UpdateVisibility()
        end)
    end

    --Set up updating the Robux price occasionally.
    if self.TransactionData.ProductId then
        coroutine.wrap(function()
            while true do
                wait(60)
                self:UpdateCost()
            end
        end)()
    end
end

--[[
Updates the displayed cost.
--]]
function StoreItem:UpdateCost()
    if self.TransactionData.CostCandy then
        --Update the Candy price.
        self.ItemCostLabel.Text = tostring(self.TransactionData.CostCandy).." Candy"
        self.ItemCostLabel.TextColor3 = Color3.new(238/255,205/255,255/255)
        self.ItemCostLabel.TextStrokeColor3 = Color3.new(0,0,0)
    elseif self.TransactionData.ProductId then
        --Get the product info.
        local Worked,ProductInfo = pcall(function()
            return MarketplaceService:GetProductInfo(self.TransactionData.ProductId,Enum.InfoType.Product)
        end)

        --Update the Robux price.
        if Worked then
            self.ItemCostLabel.Text = tostring(ProductInfo.PriceInRobux).." Robux"
            self.ItemCostLabel.TextColor3 = Color3.new(0/255,170/255,0/255)
            self.ItemCostLabel.TextStrokeColor3 = Color3.new(0/255,100/255,0/255)
            self.BuyImage.Visible = true
        else
            self.ItemCostLabel.Text = "Offsale"
            self.ItemCostLabel.TextColor3 = Color3.new(200/255,200/255,200/255)
            self.ItemCostLabel.TextStrokeColor3 = Color3.new(100/255,100/255,100/255)
            self.BuyImage.Visible = false
            warn("Failed to fetch product info for "..tostring(self.TransactionData.ProductId).." because "..tostring(ProductInfo))
        end
    end
end

--[[
Updates the visibility of the frame.
--]]
function StoreItem:UpdateVisibility(Category)
    --Correct the category.
    Category = Category or self.Category or "Featured"
    self.Category = Category

    --Determine if the item can be shown.
    local CanShowItem = true
    if CanShowItem and self.TransactionData.CanPurchase and not self.TransactionData.CanPurchase(Players.LocalPlayer) then
        CanShowItem = false
    end
    if CanShowItem and self.TransactionData.Type == "Item" and self.TransactionData.AllowMultiple ~= true and #Inventory:GetItemSlots(self.TransactionData.ItemName) > 0 then
        CanShowItem = false
    end

    --Show the item if the category is valid.
    if Category == "Featured" or Category == self.TransactionData.Category then
        self.Background.Visible = CanShowItem
    else
        self.Background.Visible = false
    end
end



return StoreItem