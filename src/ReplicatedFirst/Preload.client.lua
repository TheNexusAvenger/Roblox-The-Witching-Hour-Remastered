--[[
TheNexusAvenger

Preloads content on the client.
--]]

local ASSETS_TO_PRELOAD = {
    Texture = {
        --Wide text button.
        "rbxassetid://5558262263",
        "rbxassetid://5558312338",
        "rbxassetid://5558312888",

        --Map images.
        "rbxassetid://131315995",
        "rbxassetid://131316239",
        "rbxassetid://130857246",
        "rbxassetid://130857246",
        "rbxassetid://132785906",
        "rbxassetid://130857373",
        "rbxassetid://130857355",
        "rbxassetid://130857360",
        "rbxassetid://130857349",
        "rbxassetid://130857451",
        "rbxassetid://130857442",
        "rbxassetid://130857424",
        "rbxassetid://131348500",
        "rbxassetid://131348539",

        --Bottom bar background.
        "rbxassetid://132724864",

        --Center stats.
        "rbxassetid://132724931",
        "rbxassetid://132725297",
        "rbxassetid://132725332",
        "rbxassetid://132725297",
        "rbxassetid://132725076",
        "rbxassetid://132725125",
        "rbxassetid://132725249",
        "rbxassetid://132725193",
        "rbxassetid://132725160",
        "rbxassetid://133251112",

        --Map containers.
        "rbxassetid://132725398",
        "rbxassetid://131274595",
        "rbxassetid://131275262",
        "rbxassetid://131274953",
        "rbxassetid://131302488",
        "rbxassetid://131302438",
        "rbxassetid://131302465",
        "rbxassetid://131275208",
        "rbxassetid://131275187",
        "rbxassetid://131275204",
        "rbxassetid://131275165",
        "rbxassetid://131275136",
        "rbxassetid://131275148",

        --Corner buttons.
        "rbxassetid://132724720",
        "rbxassetid://132718207",
        "rbxassetid://132717837",
        "rbxassetid://132717848",
        "rbxassetid://132718288",
        "rbxassetid://132717962",
        "rbxassetid://132717976",
        "rbxassetid://132718167",
        "rbxassetid://132717791",
        "rbxassetid://132717809",
        "rbxassetid://132718256",
        "rbxassetid://132717904",
        "rbxassetid://132717928",

        --Inventory
        "rbxassetid://131461868",
        "rbxassetid://5558262263",
        "rbxassetid://131302488",
        "rbxassetid://131302438",
        "rbxassetid://131302465",
        "rbxassetid://131462032",
        "rbxassetid://131490682",
        "rbxassetid://131462130",
        "rbxassetid://131489625",
        "rbxassetid://131490729",
        "rbxassetid://131490698",
        "rbxassetid://131490717",
        "rbxassetid://5655605683",
        "rbxassetid://132073816",
        "rbxassetid://132064980",
        "rbxassetid://132064800",
        "rbxassetid://132065130",
        "rbxassetid://132064980",
        "rbxassetid://132064940",
        "rbxassetid://132064966",
        "rbxassetid://132064800",
        "rbxassetid://132064800",
        "rbxassetid://132064768",
        "rbxassetid://132065130",
        "rbxassetid://132065075",
        "rbxassetid://132065098",
        "rbxassetid://131490682",
        "rbxassetid://131528533",
        "rbxassetid://131528494",
        "rbxassetid://131528543",
        "rbxassetid://132064980",
        "rbxassetid://132064940",
        "rbxassetid://132064966",
        "rbxassetid://131528431",
        "rbxassetid://131528431",
        "rbxassetid://131528420",
        "rbxassetid://131503240",
        "rbxassetid://131502836",
        "rbxassetid://131462464",
        "rbxassetid://131462433",
        "rbxassetid://131462447",
        "rbxassetid://131462518",
        "rbxassetid://131462503",
        "rbxassetid://131462515",
        "rbxassetid://5558262263",
        "rbxassetid://5558262263",
        "rbxassetid://5558262263",
        "rbxassetid://132065232",
        "rbxassetid://132065183",
        "rbxassetid://132065208",
        "rbxassetid://132065751",
        "rbxassetid://132065680",
        "rbxassetid://132065721",
        "rbxassetid://132065051",
        "rbxassetid://132064995",
        "rbxassetid://132065018",

        --Store.
        "rbxassetid://132891351",
        "rbxassetid://131302488",
        "rbxassetid://131302438",
        "rbxassetid://131302465",
        "rbxassetid://132625772",
        "rbxassetid://132625751",
        "rbxassetid://132625763",
        "rbxassetid://132606169",
        "rbxassetid://132606210",
        "rbxassetid://132623813",
        "rbxassetid://132623803",
        "rbxassetid://132623811",

        --Active quest.
        "rbxassetid://132725463",

        --Collectables view.
        "rbxassetid://132834923",
        "rbxassetid://132202849",

        --NPC dialogs.
        "rbxassetid://132726116",
        "rbxassetid://132725671",
        "rbxassetid://132725706",
        "rbxassetid://132840460",
        "rbxassetid://132840480",

        --Quests log.
        "rbxassetid://132880888",
        "rbxassetid://132882115",
        "rbxassetid://132882144",
        "rbxassetid://132882131",
        "rbxassetid://133086498",
        "rbxassetid://132881695",
        "rbxassetid://132881723",

        --Side tools.
        "rbxassetid://132929425",
        "rbxassetid://132929353",
        "rbxassetid://133390487",
        "rbxassetid://132929399",
        "rbxassetid://133389683",
        "rbxassetid://131348539",

        --Scrollbar.
        "rbxassetid://5706837205",
        "rbxassetid://5706836960",
        "rbxassetid://5706836746",

        --Pumpkin attack.
        "rbxassetid://37606814",

        --Boost attack.
        "rbxassetid://1084955012",
        "rbxassetid://1084955488",

        --Heal attack.
        "rbxassetid://1084996976",
        "rbxassetid://1084997326",
        "rbxassetid://1084996536",
        "rbxassetid://1084965356",

        --Spider web attack.
        "rbxassetid://519097994",

        --Sword attack.
        "rbxassetid://132795756",
    },

    Mesh = {
        --Pumpkin attack.
        "rbxassetid://37606814",

        --Sword attack.
        "rbxassetid://132795650",
    },
}



local ContentProvider = game:GetService("ContentProvider")
local ReplicatedStorage = game:GetService("ReplicatedStorage")



--[[
Preloads a set of assets.
--]]
local function PreloadAssets(Assets)
    for Type,SubAssets in pairs(Assets) do
        for _,AssetId in pairs(SubAssets) do
            --Create the asset item.
            local AssetItem
            if Type == "Texture" then
                AssetItem = Instance.new("Decal")
                AssetItem.Texture = AssetId
            elseif Type == "Mesh" then
                AssetItem = Instance.new("SpecialMesh")
                AssetItem.MeshId = AssetId
            elseif Type == "Animation" then
                AssetItem = Instance.new("Animation")
                AssetItem.AnimationId = AssetId
            end

            --Load the asset.
            coroutine.wrap(function()
                if AssetItem then
                    ContentProvider:PreloadAsync({AssetItem})
                end
            end)()
        end
    end
end



--Preload the main assets.
PreloadAssets(ASSETS_TO_PRELOAD)

--Preload the attacks.
local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local AttacksAssets = {
    Texture = {},
}
for _,Attack in pairs(ReplicatedStorageProject:GetResource("GameData.Item.Attacks")) do
    table.insert(AttacksAssets.Texture,"rbxassetid://"..tostring(Attack.Icon))
end
PreloadAssets(AttacksAssets)

--Preload the bloxkins.
local BloxkinAssets = {
    Texture = {},
}
for _,Bloxkin in pairs(ReplicatedStorageProject:GetResource("GameData.Item.Bloxkins")) do
    table.insert(BloxkinAssets.Texture,Bloxkin.LockedImage)
    table.insert(BloxkinAssets.Texture,Bloxkin.UnlockedImage)
end
PreloadAssets(BloxkinAssets)

--Preload the items.
local ItemAssets = {
    Texture = {},
    Mesh = {},
}
for _,Item in pairs(ReplicatedStorageProject:GetResource("GameData.Item.Items")) do
    if Item.TextureId then
        table.insert(ItemAssets.Texture,"rbxassetid://"..Item.TextureId)
    end
    if Item.MeshId then
        table.insert(ItemAssets.Mesh,"rbxassetid://"..Item.MeshId)
    end
end
PreloadAssets(ItemAssets)

--Preload the pet textures.
local PetTextures = {
    Texture = {},
}
for _,Item in pairs(ReplicatedStorageProject:GetResource("GameData.Item.PetSkinTextures")) do
    for _,Id in pairs(Item) do
        if Id ~= 0 then
            table.insert(PetTextures.Texture,"rbxassetid://"..tostring(Id))
        end
    end
end
PreloadAssets(PetTextures)

--Preload the store textures.
local StoreTextures = {
    Texture = {},
}
for _,Item in pairs(ReplicatedStorageProject:GetResource("GameData.Item.Store")) do
    table.insert(StoreTextures.Texture,Item.IconId)
end
PreloadAssets(StoreTextures)

--Load the animations.
local Animations = {
    Animation = {},
}
for _,AnimationId in pairs(ReplicatedStorageProject:GetResource("EnvironmentConfiguration").Animations) do
    table.insert(Animations.Animation,AnimationId)
end
PreloadAssets(Animations)

--Preload the item models.
local ItemsModule = ReplicatedStorageProject:GetObjectReference("GameData.Item.Items")
for _,Model in pairs(ItemsModule:GetChildren()) do
    coroutine.wrap(function()
        ContentProvider:PreloadAsync({Model})
    end)()
end
ItemsModule.ChildAdded:Connect(function(Model)
    ContentProvider:PreloadAsync({Model})
end)

--Preload the pet models.
local PetModels = ReplicatedStorageProject:GetObjectReference("PetModels")
ContentProvider:PreloadAsync({PetModels})