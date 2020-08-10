--[[
TheNexusAvenger

Custom cells and locations for custom cells.
--]]

local Workspace = game:GetService("Workspace")

return {
    Cells = {
        --Builderman's Town hall.
        {180,12,"BaseGrass"},
        {180,13,"BaseGrass"},
        {180,14,"BaseGrass"},
        {179,12,"BaseGrass"},
        {179,13,"BaseGrass"},
        {179,14,"BaseGrass"},
    
        --Center statue.
        {174,13,"BaseGrass"},
    
        --ReeseMcBlox's House.
        {119,33,"BaseGrass"},
    
        --Tarabyte's House.
        {63,35,"BaseGrass"},
        {63,36,"BaseGrass"},
    
        --Sorcus's Graveyard.
        {24,9,"BaseGrass"},
        
        --ChiefJustus's Cave.
        {61,54,"BaseGrass"},
    
        --SolarCrane's Mansion.
        {14,87,"BaseGrass"},
        {14,88,"BaseGrass"},
        {14,89,"BaseGrass"},
        {13,87,"BaseGrass"},
        {13,88,"BaseGrass"},
        {13,89,"BaseGrass"},
        {12,87,"BaseGrass"},
        {12,88,"BaseGrass"},
        {12,89,"BaseGrass"},
    
        --Darkskrills's Swamp Cabin.
        {153,74,"Swamp"},
    
        --Shedletskys' Houses.
        {199,103,"BaseGrass"},
        {199,104,"BaseGrass"},
        {199,105,"BaseGrass"},
        {197,103,"BaseGrass"},
        {197,104,"BaseGrass"},
        {197,105,"BaseGrass"},
    
        --OstrichSized's Pyramid.
        {106,117,"BaseGrass"},
        {106,118,"BaseGrass"},
        {105,117,"BaseGrass"},
        {105,118,"BaseGrass"},
    
        --OnlyTwentyCharacter's Log Cabin.
        {20,162,"BaseGrass"},
    
        --StickMasterLuke's Barn.
        {175,177,"BaseGrass"},
        {175,178,"BaseGrass"},
        {174,177,"BaseGrass"},
        {174,178,"BaseGrass"},
        {173,177,"BaseGrass"},
        {173,178,"BaseGrass"},
    
        --Fusroblox's Mansion.
        {100,194,"BaseGrass"},
        {100,195,"BaseGrass"},
        {100,196,"BaseGrass"},
        {99,194,"BaseGrass"},
        {99,195,"BaseGrass"},
        {99,196,"BaseGrass"},
    },
    Structures = {
        ["Generation.CustomStructures.TownHall"] = {179,13},
        ["Generation.CustomStructures.Fountain"] = {174,13,function()
            --Fill the fountain with water.
            Workspace.Terrain:FillCylinder(CFrame.new(17400,2,1300),4,28,Enum.Material.Water)
        end},
        ["Generation.CustomStructures.ReeseMcBloxsHouse"] = {119,33,function()
            --Fill the dirt for the garden.
            Workspace.Terrain:FillBlock(CFrame.new(11900 - 24,-4,3300 - 16),Vector3.new(20,4,8),Enum.Material.Ground)
            Workspace.Terrain:FillBlock(CFrame.new(11900 - 24,-4,3300),Vector3.new(20,4,8),Enum.Material.Ground)
            Workspace.Terrain:FillBlock(CFrame.new(11900 - 4,-4,3300 + 36),Vector3.new(12,4,8),Enum.Material.Ground)
        end},
        ["Generation.CustomStructures.ShedletskysMansion"] = {199,104},
        ["Generation.CustomStructures.BrightEyessMansion"] = {197,104},
        ["Generation.CustomStructures.StickMasterLukesBarn"] = {173,177,function()
            --Fill the dirt for the barn.
            Workspace.Terrain:FillBlock(CFrame.new(17456,-4,17754),Vector3.new(96,4,44),Enum.Material.Ground)
            Workspace.Terrain:FillBlock(CFrame.new(17304,-4,17750),Vector3.new(108,4,16),Enum.Material.Ground)
        end},
        ["Generation.CustomStructures.DarthskrillsSwampCabin"] = {153,74},
        ["Generation.CustomStructures.OstrichSizedsPyramid"] = {105,117,function()
            --Fill the sand for the pyramid.
            Workspace.Terrain:FillBlock(CFrame.new(10550,-4,11750),Vector3.new(200,4,200),Enum.Material.Sand)
        end},
        ["Generation.CustomStructures.TarabytesHouse"] = {63,35},
        ["Generation.CustomStructures.SorcussGraveyard"] = {24,9},
        ["Generation.CustomStructures.ChiefJustussCave"] = {61,54},
        ["Generation.CustomStructures.OnlyTwentyCharactersLogCabin"] = {20,162},
        ["Generation.CustomStructures.SolarCranesMansion"] = {13,88,function()
            --Fill the grass for the hill.
            for _,Part in pairs(Workspace:WaitForChild("SolarCranesMansion"):WaitForChild("TerrainHill"):GetChildren()) do
                if Part:IsA("BasePart") then
                    if Part.Shape == Enum.PartType.Ball then
                        Workspace.Terrain:FillBall(Part.CFrame.p,Part.Size.X/2,Enum.Material.LeafyGrass)
                    else
                        Workspace.Terrain:FillBlock(Part.CFrame,Part.Size,Enum.Material.LeafyGrass)
                    end
                end
            end
        end},
    },
}