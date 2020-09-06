--[[
TheNexusAvenger

Custom cells and locations for custom cells.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))
local Tree = ReplicatedStorageProject:GetResource("Generation.Tree")
local TreeRandomGenerator = Random.new(243326526256) --Arbitrary random seed, but must be consistent to have the trees be the same between clients.

--[[
Generates a tree.
--]]
local function GenerateTree(X,Z,Parent)
    Tree.new(CFrame.new(X,0,Z) * CFrame.Angles(0,TreeRandomGenerator:NextNumber() * 2 * math.pi,0),Parent,TreeRandomGenerator)
end



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
        {14,87,"Grass"},
        {14,88,"BaseGrass"},
        {14,89,"Grass"},
        {13,87,"Grass"},
        {13,88,"BaseGrass"},
        {13,89,"Grass"},
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

            --Add extra trees.
            local StickMasterLukesBarn = Workspace:WaitForChild("StickMasterLukesBarn")
            GenerateTree(17360,17720,StickMasterLukesBarn)
            GenerateTree(17320,17720,StickMasterLukesBarn)
            GenerateTree(17280,17720,StickMasterLukesBarn)
            GenerateTree(17360,17780,StickMasterLukesBarn)
            GenerateTree(17320,17780,StickMasterLukesBarn)
            GenerateTree(17280,17780,StickMasterLukesBarn)
        end},
        ["Generation.CustomStructures.DarthskrillsSwampCabin"] = {153,74},
        ["Generation.CustomStructures.OstrichSizedsPyramid"] = {105,117,function()
            --Fill the sand for the pyramid.
            Workspace.Terrain:FillBlock(CFrame.new(10550,-4,11750),Vector3.new(200,4,200),Enum.Material.Sand)
        end},
        ["Generation.CustomStructures.TarabytesHouse"] = {63,35,function()
            --Add extra trees.
            local TarabytesHouse = Workspace:WaitForChild("TarabytesHouse")
            GenerateTree(6300 + 30,3500 - 20,TarabytesHouse)
            GenerateTree(6300 - 40,3500 + 10,TarabytesHouse)
            GenerateTree(6300 - 10,3500 - 30,TarabytesHouse)
            GenerateTree(6300 - 20,3600 + 40,TarabytesHouse)
            GenerateTree(6300 + 30,3600 + 20,TarabytesHouse)
            GenerateTree(6300 - 30,3600 - 10,TarabytesHouse)
        end},
        ["Generation.CustomStructures.SorcussGraveyard"] = {24,9},
        ["Generation.CustomStructures.ChiefJustussCave"] = {61,54},
        ["Generation.CustomStructures.OnlyTwentyCharactersLogCabin"] = {20,162},
        ["Generation.CustomStructures.SolarCranesMansion"] = {13,88,function()
            --Fill the grass for the hill.
            for _,Part in pairs(Workspace:WaitForChild("SolarCranesMansion"):WaitForChild("TerrainHill"):GetChildren()) do
                if Part:IsA("BasePart") then
                    if Part.Shape == Enum.PartType.Ball then
                        Workspace.Terrain:FillBall(Part.Position,Part.Size.X/2,Enum.Material.LeafyGrass)
                    else
                        Workspace.Terrain:FillBlock(Part.CFrame,Part.Size,Enum.Material.LeafyGrass)
                    end
                end
            end
        end},
        ["Generation.CustomStructures.FusrobloxsMansion"] = {99,194},
    },
}