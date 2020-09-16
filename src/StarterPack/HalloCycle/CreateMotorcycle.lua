--[[
TheNexusAvenger

Creates the motorcycle model.
--]]



--[[
Creates a part.
--]]
local function CreatePart()
    local Part = Instance.new("Part")
    Part.Material = Enum.Material.SmoothPlastic
    Part.TopSurface = Enum.SurfaceType.Smooth
    Part.BottomSurface = Enum.SurfaceType.Smooth
    Part.Size = Vector3.new(0.2,0.2,0.2)
    return Part
end

--[[
Creates a wheel.
--]]
local function CreateWheel()
    local Wheel = CreatePart()
    Wheel.Size = Vector3.new(0.5,1,1)
    Wheel.CanCollide = false

    local WheelMesh = Instance.new("SpecialMesh")
    WheelMesh.MeshType = Enum.MeshType.FileMesh
    WheelMesh.MeshId = "rbxassetid://122202439"
    WheelMesh.TextureId = "rbxassetid://132642245"
    WheelMesh.Scale = Vector3.new(2.5,2.5,2.5)
    WheelMesh.Parent = Wheel

    return Wheel
end



--[[
Creates a motorcycle.
--]]
return function()
    local Body = CreatePart()
    Body.Name = "Motorcycle"
    Body.Size = Vector3.new(1,4.9,6)

    local BodyMesh = Instance.new("SpecialMesh")
    BodyMesh.MeshType = Enum.MeshType.FileMesh
    BodyMesh.MeshId = "http://www.roblox.com/asset/?id=122185640"
    BodyMesh.TextureId = "http://www.roblox.com/asset/?id=132642245"
    BodyMesh.Scale = Vector3.new(2.5,2.5,2.5)
    BodyMesh.Parent = Body

    local FrontWheel,BackWheel = CreateWheel(),CreateWheel()
    FrontWheel.Name = "FrontWheel"
    FrontWheel.Parent = Body
    BackWheel.Name = "BackWheel"
    BackWheel.Parent = Body

    local FrontMotor = Instance.new("Motor6D")
    FrontMotor.Name = "Motor"
    FrontMotor.Part0 = Body
    FrontMotor.Part1 = FrontWheel
    FrontMotor.C0 = CFrame.new(0,-1.1,-3.6) * CFrame.Angles(0,math.pi/2,0)
    FrontMotor.C1 = CFrame.Angles(0,-math.pi/2,0)
    FrontMotor.Parent = FrontWheel

    local BackMotor = Instance.new("Motor6D")
    BackMotor.Name = "Motor"
    BackMotor.Part0 = Body
    BackMotor.Part1 = BackWheel
    BackMotor.C0 = CFrame.new(0,-1.1,2.8) * CFrame.Angles(0,math.pi/2,0)
    BackMotor.C1 = CFrame.Angles(0,-math.pi/2,0)
    BackMotor.Parent = BackWheel

    local SmokePart = CreatePart()
    SmokePart.Name = "SmokePart"
    SmokePart.Transparency = 1
    SmokePart.Parent = Body

    local ExhaustSmoke = Instance.new("Smoke")
    ExhaustSmoke.Name = "ExhaustSmoke"
    ExhaustSmoke.Size = 0.1
    ExhaustSmoke.RiseVelocity = 0.01
    ExhaustSmoke.Color = Color3.new(127/255,127/255,127/255)
    ExhaustSmoke.Parent = SmokePart

    local SmokeWeld = Instance.new("Weld")
    SmokeWeld.C0 = CFrame.new(0,1,-2.7)
    SmokeWeld.Part0 = SmokePart
    SmokeWeld.Part1 = Body
    SmokeWeld.Parent = SmokePart

    local LightPart = CreatePart()
    LightPart.Name = "LightPart"
    LightPart.Transparency = 1
    LightPart.Parent = Body

    local Light = Instance.new("SpotLight")
    Light.Name = "Light"
    Light.Brightness = 5
    Light.Angle = 45
    Light.Color = Color3.new(255/255,252/255,153/255)
    Light.Range = 40
    Light.Shadows = true
    Light.Parent = LightPart

    local LightWeld = Instance.new("Weld")
    LightWeld.Part0 = Body
    LightWeld.Part1 = LightPart
    LightWeld.C0 = CFrame.new(0,0.75,-2.5)
    LightWeld.Parent = LightPart

    local RunningSound = Instance.new("Sound")
    RunningSound.Name = "RunningSound"
    RunningSound.Looped = true
    RunningSound.SoundId = "http://www.roblox.com/asset/?id=122292723"
    RunningSound.Parent = Body

    return Body
end