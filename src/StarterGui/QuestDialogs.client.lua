--[[
TheNexusAvenger

Performs dialogs for quests.
--]]

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ReplicatedStorageProject = require(ReplicatedStorage:WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local Quests = ReplicatedStorageProject:GetResource("State.Quests").new(Players.LocalPlayer)
local ImageEventBinder = ReplicatedStorageProject:GetResource("UI.Button.ImageEventBinder")
local AspectRatioSwitcher = ReplicatedStorageProject:GetResource("UI.AspectRatioSwitcher")
local StartQuest = ReplicatedStorageProject:GetResource("GameReplication.QuestReplication.StartQuest")
local TurnInQuest = ReplicatedStorageProject:GetResource("GameReplication.QuestReplication.TurnInQuest")



--Create the ScreenGui.
local DB = true
local DialogActive = false
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DialogView"
ScreenGui.DisplayOrder = 2
ScreenGui.Parent = script.Parent

local StartDialogEvent = Instance.new("BindableEvent")
StartDialogEvent.Name = "StartDialog"
StartDialogEvent.Parent = ScreenGui

--Create the dialog billboard Gui.
local NPCDialogBillboardGui = Instance.new("BillboardGui")
NPCDialogBillboardGui.Name = "NPCDialog"
NPCDialogBillboardGui.AlwaysOnTop = true
NPCDialogBillboardGui.Enabled = false
NPCDialogBillboardGui.SizeOffset = Vector2.new(0.5,0.5)
NPCDialogBillboardGui.Parent = script.Parent

local NPCDialogBackground = Instance.new("ImageLabel")
NPCDialogBackground.BackgroundTransparency = 1
NPCDialogBackground.Size = UDim2.new(1,0,1,0)
NPCDialogBackground.Image = "rbxassetid://132726116"
NPCDialogBackground.Parent = NPCDialogBillboardGui

local NPCDialogText = Instance.new("TextLabel")
NPCDialogText.BackgroundTransparency = 1
NPCDialogText.AnchorPoint = Vector2.new(0.5,0.5)
NPCDialogText.Position = UDim2.new(0.35,0,0.42,0)
NPCDialogText.Size = UDim2.new(0.6,0,0.54,0)
NPCDialogText.Font = Enum.Font.Antique
NPCDialogText.TextColor3 = Color3.new(0,0,0)
NPCDialogText.TextWrapped = true
NPCDialogText.TextXAlignment = Enum.TextXAlignment.Left
NPCDialogText.Parent = NPCDialogBackground

local function ResizeNPCDialog()
    local WindowHeight = ScreenGui.AbsoluteSize.Y
    NPCDialogBillboardGui.Size = UDim2.new(0,WindowHeight * 0.5,0,WindowHeight * 0.25)
    NPCDialogText.TextSize = 28 * ((WindowHeight * 0.25)/256)
end
ScreenGui:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeNPCDialog)
ResizeNPCDialog()

--Create the container.
local Background = Instance.new("ImageLabel")
Background.BackgroundTransparency = 1
Background.Position = UDim2.new(0.5,0,1.5,0)
Background.AnchorPoint = Vector2.new(0.3175,0.48)
Background.Image = "rbxassetid://132725671"
Background.Parent = ScreenGui

AspectRatioSwitcher.new(ScreenGui,1.1,function()
    Background.Size = UDim2.new(1,0,0.5,0)
    Background.SizeConstraint = "RelativeYY"
end,function()
    Background.Size = UDim2.new(0.8,0,0.4,0)
    Background.SizeConstraint = "RelativeXX"
end)

--Create the buttons.
local DialogButtons = {}
for i = 1,5 do
    local Image = Instance.new("ImageLabel")
    Image.BackgroundTransparency = 1
    Image.Size = UDim2.new(1,0,32/512,0)
    Image.Position = UDim2.new(0.039,0,0.03 + (i * 0.07),0)
    Image.Parent = Background
    local Button = ImageEventBinder.new(Image,UDim2.new(0.547,0,0.9,0),"rbxassetid://132725706","rbxassetid://132840460","rbxassetid://132840480")

    local ButtonText = Instance.new("TextLabel")
    ButtonText.BackgroundTransparency = 1
    ButtonText.Size = UDim2.new(1,0,0.8,0)
    ButtonText.Position = UDim2.new(0.01,0,-0.05,0)
    ButtonText.Font = Enum.Font.Antique
    ButtonText.TextColor3 = Color3.new(0,0,0)
    ButtonText.TextScaled = true
    ButtonText.TextXAlignment = Enum.TextXAlignment.Left
    ButtonText.Parent = Image
    table.insert(DialogButtons,{Image,Button,ButtonText})
end



--[[
Ends the dialog.
--]]
local function EndDialog()
    --Hide the dialog.
    DialogActive = false
    NPCDialogBillboardGui.Enabled = false
    Background:TweenPosition(UDim2.new(0.5,0,1.5,0),"Out","Quad",0.5,true)

    --Unlock the player.
    local Character = Players.LocalPlayer.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            local PositionLock = HumanoidRootPart:FindFirstChild("PositionLock")
            if PositionLock then
                PositionLock:Destroy()
            end
        end
    end
end

--[[
Runs the dialog for a specific step.
--]]
local function RunDialogSection(DialogData,NPCName)
    --Turn in a quest if there is one to turn in.
    if DialogData.TurnIn then
        TurnInQuest:FireServer(NPCName,DialogData.TurnIn)
    end

    --Update the text bubble.
    NPCDialogText.Text = DialogData.Text

    if DialogData.Alternatives then
        --Set up the buttons.
        local ResponseEvents = {}
        for i,ButtonData in pairs(DialogButtons) do
            local RepsonseData = DialogData.Alternatives[i]
            if RepsonseData then
                --Show and update the button.
                ButtonData[1].Visible = true
                ButtonData[3].Text = RepsonseData.Text

                --Connect the button.
                table.insert(ResponseEvents,ButtonData[2].Button.MouseButton1Down:Connect(function()
                    if DB then
                        DB = false
                        --Disconnect the button events.
                        for _,Event in pairs(ResponseEvents) do
                            Event:Disconnect()
                        end

                        --Claim the quest.
                        if RepsonseData.Quest then
                            Quests:AddQuest(RepsonseData.Quest)
                            StartQuest:FireServer(NPCName,RepsonseData.Quest)
                        end

                        if RepsonseData.Response then
                            --Run the next dialog.
                            RunDialogSection(RepsonseData.Response,NPCName)
                        else
                            --End the dialog.
                            EndDialog()
                        end

                        wait()
                        DB = true
                    end
                end))
            else
                --Hide the button.
                ButtonData[1].Visible = false
            end
        end
    else
        --Hide the dialog.
        EndDialog()
        NPCDialogBillboardGui.Enabled = true
        local OriginalText = NPCDialogText.Text
        delay(5,function()
            if OriginalText == NPCDialogText.Text then
                NPCDialogBillboardGui.Enabled = false
            end
        end)
    end
end

--[[
Starts a dialog.
--]]
local function RunDialog(DialogData,NPCName,Adornee)
    --Show the GUIs.
    DialogActive = true
    NPCDialogBillboardGui.Enabled = true
    NPCDialogBillboardGui.Adornee = Adornee
    Background:TweenPosition(UDim2.new(0.5,0,1,0),"Out","Quad",0.5,true)

    --Lock the player.
    local Character = Players.LocalPlayer.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart and not HumanoidRootPart:FindFirstChild("PositionLock") then
            local PositionLock = Instance.new("BodyPosition")
            PositionLock.Name = "PositionLock"
            PositionLock.Position = HumanoidRootPart.Position
            PositionLock.MaxForce = Vector3.new(math.huge,0,math.huge)
            PositionLock.Parent = HumanoidRootPart
        end
    end

    --Run the dialog.
    RunDialogSection(DialogData,NPCName)
end

--[[
Starts a dialog for a given NPC.
--]]
local function RunDialogForNPC(NPCName)
    --Return if a dialog is in progress.
    if DialogActive then
        return
    end

    --Get the dialog and return if there is no valid dialog.
    local DialogData = Quests:GetDialogForNPC(NPCName)
    if not DialogData then
        return
    end

    --Run the dialog.
    RunDialog(DialogData,NPCName,Workspace:WaitForChild(NPCName):WaitForChild("Head"))
end



--Connect starting dialogs.
StartDialogEvent.Event:Connect(RunDialogForNPC)