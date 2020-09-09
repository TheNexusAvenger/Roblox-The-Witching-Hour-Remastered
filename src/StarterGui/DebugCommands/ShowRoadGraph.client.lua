--[[
TheNexusAvenger

Registers a command for showing the road graph.
--]]

local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusAdminAPI = ReplicatedStorageProject:GetResource("NexusAdminClient")



NexusAdminAPI.Registry:LoadCommand({
    Keyword = "showroadgraph",
    Prefix = NexusAdminAPI.Configuration.CommandPrefix,
    Category = "GameDebug",
    Description = "Displays the graph of the roads above the player. The graph is used for determining the zones of houses.",
    AdminLevel = -1,
    Run = function(self,CommandContext,ShowMapConfidence)
        if not self.CommandWasRun then
            self.CommandWasRun = true

            --Set up the zones.
            --Done here in case the client doesn't create the graph elsewhere to save memory.
            local Zones = ReplicatedStorageProject:GetResource("State.Zones")

            --Draw the vertices.
            for _,Vertex in pairs(Zones.MapGraph.Nodes) do
                local VertexPart = Instance.new("Part")
                VertexPart.Name = "DebugRoadVertex"
                VertexPart.Color = Color3.new(0,1,0)
                VertexPart.Size = Vector3.new(20,20,20)
                VertexPart.CFrame = CFrame.new(Vertex.X * 100,100,Vertex.Y * 100)
                VertexPart.Anchored = true
                VertexPart.CanCollide = false
                VertexPart.Shape = Enum.PartType.Ball
                VertexPart.TopSurface = Enum.SurfaceType.Smooth
                VertexPart.BottomSurface = Enum.SurfaceType.Smooth
                VertexPart.Parent = Workspace
            end

            --Draw the edges.
            local DrawnVertices = {}
            for StartVertexId,EndVertexIds in pairs(Zones.MapGraph.Edges) do
                DrawnVertices[StartVertexId] = true
                local StartVertex = Zones.MapGraph.Nodes[StartVertexId]
                for _,EndVertexId in pairs(EndVertexIds) do
                    local EndVertex = Zones.MapGraph.Nodes[EndVertexId]
                    local Distance = Zones.MapGraph:GetDistance(StartVertexId,EndVertexId)
                    local EdgePart = Instance.new("Part")
                    EdgePart.Name = "DebugRoadEdge"
                    EdgePart.Color = Color3.new(1,1,0)
                    EdgePart.Size = Vector3.new(10,10,100)
                    EdgePart.CFrame = CFrame.new(Vector3.new(StartVertex.X * 100,100,StartVertex.Y * 100),Vector3.new(EndVertex.X * 100,100,EndVertex.Y * 100)) * CFrame.new(0,0,-(Distance * 100)/2)
                    EdgePart.Anchored = true
                    EdgePart.CanCollide = false
                    EdgePart.TopSurface = Enum.SurfaceType.Smooth
                    EdgePart.BottomSurface = Enum.SurfaceType.Smooth
                    EdgePart.Parent = Workspace

                    local EdgeMesh = Instance.new("SpecialMesh")
                    EdgeMesh.MeshType = Enum.MeshType.Brick
                    EdgeMesh.Scale = Vector3.new(1,1,Distance)
                    EdgeMesh.Parent = EdgePart
                end
            end

            return "Verticies and edges will now appear above."
        else
            return "Command already ran."
        end
    end,
})