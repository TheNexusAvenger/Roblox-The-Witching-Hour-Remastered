--[[
TheNexusAvenger

Transactions that can be done in the store.
The order listed is the order used for displaying
the featured list.
--]]

local EYES_COST_CANDY = 50



local Players = game:GetService("Players")

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local PlayerDataClass = ReplicatedStorageProject:GetResource("State.PlayerData")
local EnvironmentConfiguration = ReplicatedStorageProject:GetResource("EnvironmentConfiguration")



return {
    {
        TransactionName = "InventoryExpander",
        Name = "Inventory Expander",
        IconId = "rbxassetid://132793056",
        Category = "Consumables",
        Type = "Item",
        ItemName = "InventoryExpander",
        AllowMultiple = true,
        RequiresInventorySpace = true,
        CostCandy = 100,
    },
    {
        TransactionName = "VisionRadius",
        Name = "Vision Radius",
        IconId = "rbxassetid://132795587",
        Category = "Consumables",
        Type = "Item",
        ItemName = "VisionRadiusIncrease",
        AllowMultiple = true,
        RequiresInventorySpace = true,
        CostCandy = 100,
    },
    {
        TransactionName = "Teleport",
        Name = "Teleport",
        IconId = "rbxassetid://131348539",
        Category = "Unlockables",
        Type = "Custom",
        CostCandy = 250,
        CanPurchase = function(Player)
            return not PlayerDataClass.GetPlayerData(Player):GetValue("WarpPurchased")
        end,
        HandlePurchase = function(Player)
            PlayerDataClass.GetPlayerData(Player):SetValue("WarpPurchased",true)
        end,
        CreateLocalChangeCallback = function(Callback)
            local PlayerData = PlayerDataClass.GetPlayerData(Players.LocalPlayer)
            PlayerData:GetValueChangedSignal("WarpPurchased"):Connect(Callback)
        end,
    },
    {
        TransactionName = "HalloCycle",
        Name = "Hallo-Cycle",
        IconId = "rbxassetid://132644813",
        Category = "Unlockables",
        Type = "Custom",
        ProductId = EnvironmentConfiguration.DeveloperProducts.HalloCycle,
        CanPurchase = function(Player)
            return PlayerDataClass.GetPlayerData(Player):GetValue("ToolsOwned")["HalloCycle"] == nil
        end,
        HandlePurchase = function(Player)
            local PlayerData = PlayerDataClass.GetPlayerData(Player)
            local Tools = PlayerData:GetValue("ToolsOwned")
            Tools["HalloCycle"] = true
            PlayerData:SetValue("ToolsOwned",Tools)
        end,
        CreateLocalChangeCallback = function(Callback)
            local PlayerData = PlayerDataClass.GetPlayerData(Players.LocalPlayer)
            PlayerData:GetValueChangedSignal("ToolsOwned"):Connect(Callback)
        end,
    },
    {
        TransactionName = "TrickOrTreatBag",
        Name = "Trick Or Treat Bag",
        IconId = "rbxassetid://62759749",
        Category = "Unlockables",
        Type = "Custom",
        ProductId = EnvironmentConfiguration.DeveloperProducts.TrickOrTreatBag,
        CanPurchase = function(Player)
            return PlayerDataClass.GetPlayerData(Player):GetValue("ToolsOwned")["TrickOrTreatBag"] == nil
        end,
        HandlePurchase = function(Player)
            local PlayerData = PlayerDataClass.GetPlayerData(Player)
            local Tools = PlayerData:GetValue("ToolsOwned")
            Tools["TrickOrTreatBag"] = true
            PlayerData:SetValue("ToolsOwned",Tools)
        end,
        CreateLocalChangeCallback = function(Callback)
            local PlayerData = PlayerDataClass.GetPlayerData(Players.LocalPlayer)
            PlayerData:GetValueChangedSignal("ToolsOwned"):Connect(Callback)
        end,
    },
    {
        TransactionName = "Key",
        Name = "Key",
        IconId = "rbxassetid://132945186",
        Category = "Consumables",
        Type = "Item",
        ItemName = "TreasureKey",
        AllowMultiple = true,
        RequiresInventorySpace = true,
        CostCandy = 80,
    },
    {
        TransactionName = "Cat",
        Name = "Cat",
        IconId = "rbxassetid://133220975",
        Category = "Companions",
        Type = "Pet",
        CostCandy = 110,
    },
    {
        TransactionName = "Pig",
        Name = "Pig",
        IconId = "https://www.roblox.com/asset-thumbnail/image?assetId=4501800116&width=420&height=420&format=png",
        Category = "Companions",
        Type = "Pet",
        CostCandy = 250,
    },
    {
        TransactionName = "Horse",
        Name = "Horse",
        IconId = "https://www.roblox.com/asset-thumbnail/image?assetId=4501806885&width=420&height=420&format=png",
        Category = "Companions",
        Type = "Pet",
        CostCandy = 400,
    },
    {
        TransactionName = "Panda",
        Name = "Panda",
        IconId = "rbxassetid://133221030",
        Category = "Companions",
        Type = "Pet",
        CostCandy = 550,
    },
    {
        TransactionName = "Dragon",
        Name = "Dragon",
        IconId = "https://www.roblox.com/asset-thumbnail/image?assetId=4501822721&width=420&height=420&format=png",
        Category = "Companions",
        Type = "Pet",
        CostCandy = 700,
    },
    {
        TransactionName = "MapEyeBackYellow",
        Name = "Yellow Eye Map Indicator",
        IconId = "rbxassetid://131311939",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackYellow",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackRed",
        Name = "Red Eye Map Indicator",
        IconId = "rbxassetid://131311933",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackRed",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackPurple",
        Name = "Purple Eye Map Indicator",
        IconId = "rbxassetid://131311927",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackPurple",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackPink",
        Name = "Pink Eye Map Indicator",
        IconId = "rbxassetid://131311914",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackPink",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackOrange",
        Name = "Orange Eye Map Indicator",
        IconId = "rbxassetid://131311902",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackOrange",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackGrey",
        Name = "Grey Eye Map Indicator",
        IconId = "rbxassetid://131311897",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackGrey",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackGreen",
        Name = "Green Eye Map Indicator",
        IconId = "rbxassetid://131311879",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackGreen",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeBackBlue",
        Name = "Blue Eye Map Indicator",
        IconId = "rbxassetid://131311777",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeBackBlue",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontX",
        Name = "X Pupil Map Indicator",
        IconId = "rbxassetid://131312124",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontX",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "Swirl Pupil Map Indicator",
        Name = "MapEyeFrontSwirl",
        IconId = "rbxassetid://131312112",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontSwirl",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontStar",
        Name = "Star Pupil Map Indicator",
        IconId = "rbxassetid://131312101",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontStar",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontRadioactive",
        Name = "Radioactive Pupil Map Indicator",
        IconId = "rbxassetid://131312094",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontRadioactive",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontMoon",
        Name = "Moon Pupil Map Indicator",
        IconId = "rbxassetid://131312082",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontMoon",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontHeart",
        Name = "Heart Pupil Map Indicator",
        IconId = "rbxassetid://131312068",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontHeart",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontCat",
        Name = "Cat Pupil Map Indicator",
        IconId = "rbxassetid://131312006",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontCat",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "MapEyeFrontBurst",
        Name = "Burst Pupil Map Indicator",
        IconId = "rbxassetid://131311995",
        Category = "Customize",
        Type = "Item",
        ItemName = "MapEyeFrontBurst",
        AllowMultiple = false,
        RequiresInventorySpace = true,
        CostCandy = EYES_COST_CANDY,
    },
    {
        TransactionName = "17Candy",
        Name = "17 Candy",
        IconId = "rbxassetid://132736246",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 17,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy17,
    },
    {
        TransactionName = "85Candy",
        Name = "85 Candy",
        IconId = "rbxassetid://132736300",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 85,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy85,
    },
    {
        TransactionName = "170Candy",
        Name = "170 Candy",
        IconId = "rbxassetid://132736317",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 170,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy170,
    },
    {
        TransactionName = "850Candy",
        Name = "850 Candy",
        IconId = "rbxassetid://132736350",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 850,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy850,
    },
    {
        TransactionName = "1700Candy",
        Name = "1700 Candy",
        IconId = "rbxassetid://132736374",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 1700,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy1700,
    },
    {
        TransactionName = "8500Candy",
        Name = "8500 Candy",
        IconId = "rbxassetid://132736394",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 8500,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy8500,
    },
    {
        TransactionName = "17000Candy",
        Name = "17000 Candy",
        IconId = "rbxassetid://132736414",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 17000,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy17000,
    },
    {
        TransactionName = "85000Candy",
        Name = "85000 Candy",
        IconId = "rbxassetid://132736425",
        Category = "Candy",
        Type = "Candy",
        CandyAmount = 85000,
        ProductId = EnvironmentConfiguration.DeveloperProducts.Candy85000,
    },
}