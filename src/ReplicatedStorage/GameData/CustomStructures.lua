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
        {64,35,"BaseGrass"},
        {64,36,"BaseGrass"},
        {63,35,"BaseGrass"},
        {63,36,"BaseGrass"},
    
        --Sorcus's Graveyard.
        {24,9,"BaseGrass"},
        
        --ChiefJustus's Cave.
        {61,54,"BaseGrass"},
    
        --SolarCrane's Log Mansion.
        {14,87,"BaseGrass"},
        {14,88,"BaseGrass"},
        {13,87,"BaseGrass"},
        {13,88,"BaseGrass"},
    
        --Jeditkacheff's Swamp Cabin.
        {153,74,"Swamp"},
    
        --Shedletskys' Houses.
        {199,103,"BaseGrass"},
        {199,104,"BaseGrass"},
        {197,103,"BaseGrass"},
        {197,104,"BaseGrass"},
    
        --OstrichSized's Pyramic.
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
    },
}