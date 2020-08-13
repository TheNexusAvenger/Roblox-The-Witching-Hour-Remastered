--[[
TheNexusAvenger

Runs callbacks when the aspect ratio of a GUI
requires switching for portrait and landscape.
--]]

local ReplicatedStorageProject = require(game:GetService("ReplicatedStorage"):WaitForChild("Project"):WaitForChild("ReplicatedStorage"))

local NexusObject = ReplicatedStorageProject:GetResource("ExternalUtil.NexusInstance.NexusObject")

local AspectRatioSwitcher = NexusObject:Extend()
AspectRatioSwitcher:SetClassName("AspectRatioSwitcher")



--[[
Creates an aspect ratio swticher.
--]]
function AspectRatioSwitcher:__new(Frame,MinimumAspectRatioForLandscape,SwitchToLandscapeCallback,SwitchToPortraitCallback)
    self:InitializeSuper()

    --Store the state.
    self.CurrentState = "Unitialized"
    self.Frame = Frame
    self.MinimumAspectRatioForLandscape = MinimumAspectRatioForLandscape
    self.SwitchCallbacks = {
        Landscape = SwitchToLandscapeCallback,
        Portrait = SwitchToPortraitCallback,
    }

    --Create the changed size event.
    Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
        self:UpdateState()
    end)
    self:UpdateState()
end

--[[
Updates the state.
--]]
function AspectRatioSwitcher:UpdateState()
    --Determine the new state.
    local AspectRatio = self.Frame.AbsoluteSize.X/self.Frame.AbsoluteSize.Y
    local NewState = (AspectRatio > self.MinimumAspectRatioForLandscape and "Landscape" or "Portrait")

    --Call the callback if the state changed.
    if NewState ~= self.CurrentState then
        self.CurrentState = NewState
        self.SwitchCallbacks[NewState]()
    end
end



return AspectRatioSwitcher