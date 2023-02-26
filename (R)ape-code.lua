runcode(function()
local infJumpConnection
local infjump = {["Enabled"] = false}
infjump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
    ["Name"] = "InfiniteJump",
    ["HoverText"] = "Jump without touching ground",
    ["Function"] = function(callback) 
        if callback then    
            infJumpConnection = uis.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.Space and not uis:GetFocusedTextBox() then
                    if InfHold.Enabled and entity.isAlive then 
                        repeat 
                        lplr.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
                        task.wait()
                        until not uis:IsKeyDown(Enum.KeyCode.Space) or not infjump.Enabled or not InfHold.Enabled or uis:GetFocusedTextBox()
                    else 
                        if entity.isAlive then 
                                lplr.Character:WaitForChild("Humanoid"):ChangeState("Jumping")
                            end 
                        end 
                    end
                end)
            else
                if infJumpConnection then
                    infJumpConnection:Disconnect()
                end
            end
        end
    })
    InfHold = infjump.CreateToggle({
        ["Name"] = "Hold",
        ["HoverText"] = "Hold down space to jump?",
        ["Function"] = function() end
    })
end)

runcode(function()
    local PistonwareAntivoid = {["Enabled"] = false}
    local antivoidpart
    PistonwareAntivoid = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "BlueAntivoid",
        ["HoverText"] = "Stud antivoid, but blue",
        ["Function"] = function(callback)
            if callback then
                task.spawn(function()
                    antivoidpart = Instance.new("Part")
                    antivoidpart.Size = Vector3.new(2100, 0.5, 2000)
                    antivoidpart.Position = Vector3.new(160.5, 25, 247.5)
                    antivoidpart.Transparency = 0.4
                    antivoidpart.Anchored = true
                    antivoidpart.Color = Color3.fromRGB(97,150,255)
                    antivoidpart.Parent = workspace
                end)
            else               
		        if antivoidpart then
                    antivoidpart:Remove()
                    antivoidpart = nil
                end
            end
        end
    })
end)

runcode(function()
    local Chat = {["Enabled"] = false}
    Chat = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Chat",
        ["HoverText"] = "Moves the Chat",
        ["Function"] = function(callback)
            if callback then
                game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0, 0, 0.7, 0))
            else
                game:GetService("StarterGui"):SetCore('ChatWindowPosition', UDim2.new(0, 0, 0, 0))
            end
        end
    })
end)



runcode(function()
    local KillFeed = {["Enabled"] = false}
    local container

    KillFeed = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "KillFeed",
        ["HoverText"] = "Destroys the KillFeed",
        ["Function"] = function(callback)
            if callback then
                task.spawn(function()
                    if container == nil then
                        repeat
                            local suc, res = pcall(function() return lplr.PlayerGui.KillFeedGui.KillFeedContainer end)
                            if suc then
                                container = res
                            end
                            task.wait()
                        until container ~= nil
                    end
                    container.Visible = false
                end)
            else
                if container then
                    container.Visible = true
                end
            end
        end
    })
end)

runcode(function()
    local RootRemover = {["Enabled"] = false}
    RootRemover = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "RootRemover",
        ["HoverText"] = "Destroys your HumanoidRootPart",
        ["Function"] = function(callback)
            if callback then
                local char = lplr.Character
                local primary = char.PrimaryPart
                primary.Parent = nil
                char:MoveTo(char:GetPivot().p)
                task.wait()
                primary.Parent = char
            else
                createwarning("PolyWare", "Reset to disable", 3)
            end
        end
    })
end)

runcode(function()
    local CFrameHighJump = {["Enabled"] = false}
    CFrameHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "CFrameHighJump",
        ["HoverText"] = "DISABLE GRAVITY",
        ["Function"] = function(callback)
            if callback then
                if entity.isAlive then
                    workspace.Gravity = 0
                    entity.character.HumanoidRootPart.CFrame -= Vector3.new(0, 2, 0)
                    task.spawn(function()
                        repeat
                            if not CFrameHighJump["Enabled"] then break end
                            if not entity.isAlive then break end
                            workspace.Gravity = 0
                            entity.character.HumanoidRootPart.CFrame += Vector3.new(0, 5, 0)
                            task.wait(0.05)
                            entity.character.HumanoidRootPart.CFrame += Vector3.new(0, 3, 0)
                        until not CFrameHighJump["Enabled"]
                    end)
                end
            else
                workspace.Gravity = 196.2
            end
        end
    })
end)

runcode(function()
    local NameHider = {["Enabled"] = true}
    local fakeplr = {["Name"] = "ETB", ["UserId"] = "239702688"}
    local otherfakeplayers = {["Name"] = "Skids", ["UserId"] = "1"}

    local function plrthing(obj, property)
        for i,v in pairs(game:GetService("Players"):GetChildren()) do
            if v ~= lplr then
                obj[property] = obj[property]:gsub(v.Name, otherfakeplayers["Name"])
                obj[property] = obj[property]:gsub(v.DisplayName, otherfakeplayers["Name"])
                obj[property] = obj[property]:gsub(v.UserId, otherfakeplayers["UserId"])
            else
                obj[property] = obj[property]:gsub(v.Name, fakeplr["Name"])
                obj[property] = obj[property]:gsub(v.DisplayName, fakeplr["Name"])
                obj[property] = obj[property]:gsub(v.UserId, fakeplr["UserId"])
            end
        end
    end

    local function newobj(v)
        if v:IsA("TextLabel") or v:IsA("TextButton") then
            plrthing(v, "Text")
            v:GetPropertyChangedSignal("Text"):connect(function()
                plrthing(v, "Text")
            end)
        end
        if v:IsA("ImageLabel") then
            plrthing(v, "Image")
            v:GetPropertyChangedSignal("Image"):connect(function()
                plrthing(v, "Image")
            end)
        end
    end

    NameHider = GuiLibrary["ObjectsThatCanBeSaved"]["UtilityWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "NameHider",
        ["HoverText"] = "Disable TargetHud (And Don't Use Nametags)",
        ["Function"] = function(callback)
            if callback then
                for i,v in pairs(game:GetDescendants()) do
                    newobj(v)
                end
                game.DescendantAdded:connect(newobj, obj)
            else
                createwarning("PolyWare", "Join A New Match To Reset Your Name And Other Names.", 3)
            end
        end
    })
end)

runcode(function()
    local RedChams = {["Enabled"] = false}

    local settings_tbl = {
        ESP_Enabled = true,
        ESP_TeamCheck = false,
        Chams = true,
        Chams_Color = Color3.fromRGB(97,150,255),
        Chams_Transparency = 0.1,
        Chams_Glow_Color = Color3.fromRGB(0, 0, 0),
    }
    local function destroy_chams(char)
        for k,v in next, char:GetChildren() do
            if v:IsA("BasePart") and v.Transparency ~= 1 then
                if v:FindFirstChild("Glow") and v:FindFirstChild("Chams") then
                    v.Glow:Destroy()
                    v.Chams:Destroy()
                end
            end
        end
    end

    local RunService = game:GetService("RunService")

    RedChams = GuiLibrary["ObjectsThatCanBeSaved"]["RenderWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "BlueChams",
        ["HoverText"] = "Ugly asf but it's blue",
        ["Function"] = function(callback)
                if callback then
                    RunService.RenderStepped:Connect(function()
                    if settings_tbl.ESP_Enabled then
                        for k,v in next, players:GetPlayers() do 
                            if v == lplr then
                                continue
                            end
                            if isAlive(v) then
                                if not settings_tbl.ESP_TeamCheck then
                                    local char = v.Character
                                    for k, b in next, char:GetChildren() do
                                        if b:IsA("BasePart") and 
                                            b.Transparency ~= 1 then
                                            if settings_tbl.Chams then
                                                if not b:FindFirstChild("Glow") and not b:FindFirstChild("Chams") then
                                                    local chams_box = Instance.new("BoxHandleAdornment", b)
                                                    chams_box.Name = "Chams"
                                                    chams_box.AlwaysOnTop = true 
                                                    chams_box.ZIndex = 4 
                                                    chams_box.Adornee = b 
                                                    chams_box.Color3 = settings_tbl.Chams_Color
                                                    chams_box.Transparency = settings_tbl.Chams_Transparency
                                                    chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)
                                                    local glow_box = Instance.new("BoxHandleAdornment", b)
                                                    glow_box.Name = "Glow"
                                                    glow_box.AlwaysOnTop = false 
                                                    glow_box.ZIndex = 3 
                                                    glow_box.Adornee = b 
                                                    glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                                    glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)
                                                end
                                            else
                                                destroy_chams(char)
                                            end
                                        end
                                    end
                                elseif settings_tbl.ESP_TeamCheck and v.Team == lplr.Team then
                                    destroy_chams(v.Character)
                                end
                            else
                                destroy_chams(v.Character)
                            end
                        end
                    else
                        for k, v in next, players:GetPlayers() do
                            if v ~= lplr and isAlive(v) then
                                destroy_chams(v.Character)
                            end
                        end
                    end
                end)
            else
                createwarning("PolyWare", "Disabling Next Game", 3)
            end
        end
    })
end)

runcode(function()
    local VeloHighJump = {["Enabled"] = false}
    VeloHighJump = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "VeloHighJump",
        ["HoverText"] = "HighJump but velocity",
        ["Function"] = function(callback)
            if callback then
                workspace.Gravity = 196.2
                if entity.isAlive then
                    entity.character.HumanoidRootPart.Velocity = entity.character.HumanoidRootPart.Velocity + Vector3.new(0, 450, 0)
                end
                VeloHighJump["ToggleButton"](false)
            end
        end
    })
end)

runcode(function()
    local part
    local part2
    local Airwalk = {["Enabled"] = false}
    Airwalk = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Airwalk",
        ["HoverText"] = "pro fly",
        ["Function"] = function(callback)
            if callback then
                part = Instance.new("Part")
                part2 = Instance.new("Part")
                part.Transparency = 1
                part2.Transparency = 1
                part.Parent = workspace
                part.Anchored = true
                part2.Parent = workspace
                part2.Anchored = true
                task.spawn(function()
                    repeat
                        task.wait()
                        if entity.isAlive then
			    part.CFrame = entity.character.HumanoidRootPart.CFrame - Vector3.new(0, 3.6, 0)
			    part2.CFrame = entity.character.HumanoidRootPart.CFrame + Vector3.new(0, 2.5, 0)
                        end
                    until not Airwalk["Enabled"]
                end)
            else
                if part then
                    part:Destroy()
                end
                if part2 then
                    part2:Destroy()
                end
            end
        end
    })
end)

runcode(function() 
    local Heatseeker = {["Enabled"] = false}
	local BoostSpeed = {["Value"] = 70}
	local CoolDown = {["Value"] = 20}
	local FirstWait = {["Value"] = 1}
	local SecondWait = {["Value"] = 1}


    Heatseeker = GuiLibrary["ObjectsThatCanBeSaved"]["BlatantWindow"]["Api"].CreateOptionsButton({
        ["Name"] = "Heatseeker",
        ["Function"] = function(callback)
            if callback then 
                task.spawn(function()
                    repeat
                        if entity.isAlive then
							if entity.character.Humanoid.FloorMaterial ~= "Air" and networkownerfunc(entity.character.HumanoidRootPart) then 
								lplr.Character.Humanoid.WalkSpeed = CoolDown["Value"]
								task.wait(FirstWait["Value"] / 10)
								lplr.Character.Humanoid.WalkSpeed = BoostSpeed["Value"]
								task.wait(SecondWait["Value"] / 100)
								lplr.Character.Humanoid.WalkSpeed = CoolDown["Value"]
							end
                        end 
                        task.wait()
                    until not Heatseeker.Enabled 
                end)
            end
        end
    })
    BoostSpeed = Heatseeker.CreateSlider({
        ["Name"] = "Boost",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 1000,
        ["Default"] = 70
    })
    CoolDown = Heatseeker.CreateSlider({
        ["Name"] = "Cooldown Speed",
        ["Function"] = function() end,
        ["Min"] = 1,
        ["Max"] = 50,
        ["Default"] = 20
    })
    FirstWait = Heatseeker.CreateSlider({
        ["Name"] = "Boost wait",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 50,
        ["Default"] = 10,
		["Double"] = 10
    })
    SecondWait = Heatseeker.CreateSlider({
        ["Name"] = "After Boost wait",
        ["Function"] = function() end,
        ["Min"] = 0,
        ["Max"] = 100,
        ["Default"] = 5,
		["Double"] = 100
    })
end)
