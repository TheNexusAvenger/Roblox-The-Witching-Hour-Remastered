--[[
TheNexusAvenger

Manages the movement of pets.
--]]

local JUMP_AFTER_STUCK_DELAY = 0.5
local MIN_DISTANCE_TO_MOVE = 5
local MAX_DISTANCE_TO_TELEPORT = 50

local TweenService = game:GetService("TweenService")



return function (CharacterModel,PetModel)
    --Get the character and pet components.
    local CharacterHumanoid = CharacterModel:WaitForChild("Humanoid")
    local CharacterHumanoidRootPart = CharacterModel:WaitForChild("HumanoidRootPart")
    local PetHumanoid = PetModel:WaitForChild("Humanoid")
    local PetHumanoidRootPart = PetModel:WaitForChild("HumanoidRootPart")

    --Set up moving the pet.
    local LastJumpStart
    coroutine.wrap(function()
        while PetModel.Parent and CharacterHumanoid.Health > 0 do
            --Determine the target CFrame and distance.
            local TargetCFrame = CharacterHumanoidRootPart.CFrame * CFrame.new(3,-1,0)
            local PetDistance = (TargetCFrame.Position - PetHumanoidRootPart.Position).magnitude

            --Move the pet.
            if PetDistance >= MAX_DISTANCE_TO_TELEPORT then
                PetHumanoidRootPart.CFrame = TargetCFrame

                --Display an animation for teleporting the pet.
                for _,Part in pairs(PetModel:GetDescendants()) do
                    if Part:IsA("BasePart") then
                        Part.Transparency = Part.Transparency + 1
                        TweenService:Create(Part,TweenInfo.new(0.5),{
                            Transparency = Part.Transparency - 1,
                        }):Play()
                    end
                end
            elseif PetDistance >= MIN_DISTANCE_TO_MOVE then
                PetHumanoid:MoveTo(TargetCFrame.Position)
            end

            --Jump the pet after a few seconds of being stuck.
            if PetHumanoid:GetState() == Enum.HumanoidStateType.Running and PetHumanoidRootPart.Velocity.magnitude < PetHumanoid.WalkSpeed/2 and PetDistance >= MIN_DISTANCE_TO_MOVE then
                if not LastJumpStart then
                    LastJumpStart = tick()
                elseif tick() - LastJumpStart > JUMP_AFTER_STUCK_DELAY then
                    PetHumanoid.Jump = true
                    LastJumpStart = nil
                end
            else
                LastJumpStart = nil
            end

            --Wait before updating.
            wait()
        end
    end)()
end