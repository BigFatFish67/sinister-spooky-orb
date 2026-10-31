if not game:IsLoaded() then
    game.Loaded:Wait()
end

local SCRIPT_NAME = "大肥鱼脚本"
local SCRIPT_VERSION = "版本 3.1"

local Library
local Window

local ok, result = pcall(function()
    local url = "https://raw.githubusercontent.com/sixfourshi/Games/refs/heads/main/fip?cb=" .. tostring(os.time())
    local chunk, compileErr = loadstring(game:HttpGet(url))
    if type(chunk) ~= "function" then
        error("库编译失败: " .. tostring(compileErr), 0)
    end
    local lib = chunk()
    if type(lib) ~= "table" then
        error("界面库没有正确返回内容", 0)
    end
    return lib
end)
if not ok then
    error("界面库加载失败: " .. tostring(result), 0)
end
Library = result

if getgenv then
    local oldWin = getgenv().BigFishWindow
    if oldWin and type(oldWin.Destroy) == "function" then
        pcall(function() oldWin:Destroy() end)
    end
end

Library:SetDefaultTheme("Rose")

Window = Library:CreateWindow({
    Name = SCRIPT_NAME,
    LoadingSubtitle = SCRIPT_VERSION,
    ToggleUIKeybind = "RightControl",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "BigFishHub",
        FileName = "default",
    },
    ToggleButton = { Platform = "Mobile" },
    Home = {
        Title = "欢迎使用 " .. SCRIPT_NAME .. "！",
        Tier = SCRIPT_VERSION,
        Stats = { "玩家数", "在线时长", "帧率", "延迟" },
    },
})

if getgenv then getgenv().BigFishWindow = Window end

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

local Running = {}
local Enabled = {}

local function Notify(title, content, kind)
    pcall(function()
        Library:Notify({
            Title = title,
            Content = content,
            Type = kind or "Info",
            Duration = 3,
        })
    end)
end

local Toast = function(msg) Notify(SCRIPT_NAME, msg, "Info") end

local function DisconnectItem(c)
    if not c then return end
    if type(c) == "function" then
        pcall(c)
    elseif type(c) == "table" and type(c.Disconnect) == "function" then
        pcall(c.Disconnect, c)
    else
        pcall(function() c:Disconnect() end)
    end
end

local function Track(key, item)
    local list = Running[key]
    if not list then
        list = {}
        Running[key] = list
    end
    table.insert(list, item)
end

local function StopFeature(key)
    local list = Running[key]
    if not list then return end
    for _, item in ipairs(list) do
        DisconnectItem(item)
    end
    Running[key] = nil
end

local function StopAll()
    local keys = {}
    for k in pairs(Running) do table.insert(keys, k) end
    for _, k in ipairs(keys) do StopFeature(k) end
    for k in pairs(Enabled) do Enabled[k] = nil end
end

local function GetChar()
    return LocalPlayer.Character
end

local function GetHRP()
    local c = GetChar()
    if c then return c:FindFirstChild("HumanoidRootPart") end
    return nil
end

local function GetHumanoid()
    local c = GetChar()
    if c then return c:FindFirstChildOfClass("Humanoid") end
    return nil
end

local function RemoveChildByName(parent, name)
    if not parent then return end
    local c = parent:FindFirstChild(name)
    if c then pcall(function() c:Destroy() end) end
end

local function ForEachBasePart(fn)
    local c = GetChar()
    if not c then return end
    for _, v in ipairs(c:GetDescendants()) do
        if v:IsA("BasePart") then pcall(fn, v) end
    end
end

local function ApplySpeed(v)
    local hum = GetHumanoid()
    if hum then hum.WalkSpeed = v end
end

local homeCFrame = nil
task.spawn(function()
    task.wait(3)
    local hrp = GetHRP()
    if hrp then homeCFrame = hrp.CFrame end
end)

local fpsGui, fpsLabel, fpsEnabled = nil, nil, false

local function BuildFPSGui()
    if fpsGui then return end
    local parent = nil
    pcall(function() parent = game:GetService("CoreGui") end)
    if not parent then
        parent = LocalPlayer:WaitForChild("PlayerGui", 10)
    end
    local sg = Instance.new("ScreenGui")
    sg.Name = "BigFishFPS"
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 50
    local placed = pcall(function() sg.Parent = parent end)
    if not placed or not sg.Parent then
        pcall(function() sg.Parent = LocalPlayer:WaitForChild("PlayerGui", 10) end)
    end

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(0, 160, 0, 26)
    lbl.Position = UDim2.new(0, 10, 0, 10)
    lbl.BackgroundTransparency = 1
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 16
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextColor3 = Color3.fromRGB(255, 255, 255)
    lbl.TextStrokeTransparency = 0.4
    lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    lbl.RichText = true
    lbl.Parent = sg

    fpsGui = sg
    fpsLabel = lbl
end

local fpsFrames, fpsClock = 0, os.clock()
RunService.RenderStepped:Connect(function()
    if not fpsEnabled then return end
    fpsFrames = fpsFrames + 1
    local now = os.clock()
    if now - fpsClock >= 0.5 then
        local fps = 0
        if now - fpsClock > 0 then
            fps = math.floor(fpsFrames / (now - fpsClock))
        end
        fpsFrames = 0
        fpsClock = now
        if fpsLabel and fpsLabel.Parent then
            local color = fps >= 30 and "120,255,140" or "255,220,90"
            fpsLabel.Text = string.format('<font color="rgb(200,200,200)">帧率 </font><font color="rgb(%s)">%d</font>', color, fps)
        end
    end
end)

local forceSpeed, forceJump = nil, nil
RunService.Heartbeat:Connect(function()
    local hum = GetHumanoid()
    if not hum then return end
    if forceSpeed and math.abs(hum.WalkSpeed - forceSpeed) > 0.5 then
        hum.WalkSpeed = forceSpeed
    end
    if forceJump and math.abs(hum.JumpHeight - forceJump) > 0.5 then
        hum.JumpHeight = forceJump
    end
end)

local rotateSpeed = 0
RunService.RenderStepped:Connect(function()
    if rotateSpeed <= 0 then return end
    local hrp = GetHRP()
    if hrp then
        pcall(function()
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(rotateSpeed) / 60, 0)
        end)
    end
end)

local authorESPEnabled = false
local authorHighlights, authorLabels = {}, {}
local teamHighlights, enemyHighlights = {}, {}

local function ClearTableList(t)
    for k, v in pairs(t) do
        pcall(function() v:Destroy() end)
        t[k] = nil
    end
end

local function ClearAuthorESP() ClearTableList(authorHighlights); ClearTableList(authorLabels) end
local function ClearTeamGlow() ClearTableList(teamHighlights) end
local function ClearEnemyGlow() ClearTableList(enemyHighlights) end

local function MarkAuthor(p)
    if not p or p == LocalPlayer then return end
    if p.Name ~= "CHANGCHENG66" then return end
    local char = p.Character
    if not char then return end
    if authorHighlights[p] and authorHighlights[p].Parent then return end

    local hl = Instance.new("Highlight")
    hl.Name = "BigFishAuthorESP"
    hl.FillColor = Color3.fromRGB(255, 200, 40)
    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
    hl.FillTransparency = 0.4
    hl.Adornee = char
    hl.Parent = char
    authorHighlights[p] = hl

    local head = char:FindFirstChild("Head")
    if head and not authorLabels[p] then
        local bb = Instance.new("BillboardGui")
        bb.Name = "BigFishAuthorTag"
        bb.Size = UDim2.new(0, 240, 0, 36)
        bb.StudsOffset = Vector3.new(0, 3, 0)
        bb.AlwaysOnTop = true
        bb.Parent = head
        local lbl = Instance.new("TextLabel")
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = "皇冠 " .. p.Name .. " · 脚本作者"
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextColor3 = Color3.fromRGB(255, 215, 60)
        lbl.TextStrokeTransparency = 0
        lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        lbl.Parent = bb
        authorLabels[p] = bb
    end
end

local function RefreshAuthorESP()
    for _, p in ipairs(Players:GetPlayers()) do
        MarkAuthor(p)
    end
end

Players.PlayerAdded:Connect(function(p)
    if authorESPEnabled then
        p.CharacterAdded:Connect(function()
            task.wait(0.6)
            if authorESPEnabled then MarkAuthor(p) end
        end)
        MarkAuthor(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if authorHighlights[p] then
        pcall(function() authorHighlights[p]:Destroy() end)
        authorHighlights[p] = nil
    end
    if authorLabels[p] then
        pcall(function() authorLabels[p]:Destroy() end)
        authorLabels[p] = nil
    end
end)

local serverInfoGui = nil

local function ToggleServerInfo(on)
    if on then
        if serverInfoGui then pcall(function() serverInfoGui:Destroy() end) end
        local pg = LocalPlayer:WaitForChild("PlayerGui", 10)
        local sg = Instance.new("ScreenGui")
        sg.Name = "BigFishServerInfo"
        sg.ResetOnSpawn = false
        sg.Parent = pg
        serverInfoGui = sg

        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 300, 0, 190)
        frame.Position = UDim2.new(1, -310, 0, 60)
        frame.BackgroundColor3 = Color3.fromRGB(28, 28, 32)
        frame.BackgroundTransparency = 0.15
        frame.BorderSizePixel = 0
        frame.Parent = sg
        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 10)
        corner.Parent = frame
        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 12)
        pad.PaddingRight = UDim.new(0, 12)
        pad.PaddingTop = UDim.new(0, 10)
        pad.Parent = frame

        local l1 = Instance.new("TextLabel")
        l1.Size = UDim2.new(1, 0, 0, 24)
        l1.BackgroundTransparency = 1
        l1.Font = Enum.Font.GothamBold
        l1.TextSize = 14
        l1.TextXAlignment = Enum.TextXAlignment.Left
        l1.TextColor3 = Color3.fromRGB(255, 255, 255)
        l1.Text = "服务器信息"
        l1.Parent = frame

        local l2 = Instance.new("TextLabel")
        l2.Size = UDim2.new(1, 0, 0, 24)
        l2.Position = UDim2.new(0, 0, 0, 26)
        l2.BackgroundTransparency = 1
        l2.Font = Enum.Font.Gotham
        l2.TextSize = 12
        l2.TextXAlignment = Enum.TextXAlignment.Left
        l2.TextColor3 = Color3.fromRGB(190, 190, 195)
        l2.Parent = frame

        local l3 = Instance.new("TextLabel")
        l3.Size = UDim2.new(1, 0, 0, 120)
        l3.Position = UDim2.new(0, 0, 0, 54)
        l3.BackgroundTransparency = 1
        l3.Font = Enum.Font.Gotham
        l3.TextSize = 11
        l3.TextXAlignment = Enum.TextXAlignment.Left
        l3.TextYAlignment = Enum.TextYAlignment.Top
        l3.TextColor3 = Color3.fromRGB(175, 175, 180)
        l3.Parent = frame

        local alive = true
        Track("serverinfo", function()
            alive = false
            if serverInfoGui then
                pcall(function() serverInfoGui:Destroy() end)
                serverInfoGui = nil
            end
        end)
        Track("serverinfo", task.spawn(function()
            while alive do
                if not sg.Parent then
                    alive = false
                    break
                end
                l1.Text = "服务器人数：" .. tostring(#Players:GetPlayers())
                local hrp = GetHRP()
                local myPos = hrp and hrp.Position
                if myPos then
                    l2.Text = string.format("坐标：横 %d  高 %d  纵 %d",
                        math.floor(myPos.X), math.floor(myPos.Y), math.floor(myPos.Z))
                end
                local lines = { "附近玩家：" }
                if myPos then
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer then
                            local phrp = p.Character and p.Character:FindFirstChild("HumanoidRootPart")
                            if phrp then
                                local d = math.floor((phrp.Position - myPos).Magnitude)
                                table.insert(lines, string.format("  %s - %d 米", p.Name, d))
                            end
                        end
                    end
                end
                l3.Text = table.concat(lines, "\n")
                task.wait(0.5)
            end
        end))
    else
        StopFeature("serverinfo")
        if serverInfoGui then
            pcall(function() serverInfoGui:Destroy() end)
            serverInfoGui = nil
        end
    end
end

local function AttachTrail(name, a0Name, a1Name, colorSeq, lifetime, minLen)
    local hrp = GetHRP()
    if not hrp then return end
    RemoveChildByName(hrp, name)
    RemoveChildByName(hrp, a0Name)
    RemoveChildByName(hrp, a1Name)

    local a0 = Instance.new("Attachment")
    a0.Name = a0Name
    a0.Parent = hrp

    local a1 = Instance.new("Attachment")
    a1.Name = a1Name
    a1.Position = Vector3.new(0, -2, 0)
    a1.Parent = hrp

    local trail = Instance.new("Trail")
    trail.Name = name
    trail.Attachment0 = a0
    trail.Attachment1 = a1
    trail.Color = colorSeq
    trail.Lifetime = lifetime
    trail.MinLength = minLen
    trail.Parent = hrp
end

local function SetFeature(code, on)
    on = on and true or false
    if on then Enabled[code] = true else Enabled[code] = nil end

    if not on then
        StopFeature(code)

        if code == "esp" then
            authorESPEnabled = false
            ClearAuthorESP()
        elseif code == "night" then
            pcall(function()
                Lighting.Brightness = 2
                Lighting.GlobalShadows = true
                Lighting.FogEnd = 100000
                Lighting.FogStart = 0
            end)
        elseif code == "clearfog" then
            pcall(function()
                Lighting.FogEnd = 100000
                Lighting.FogStart = 0
            end)
        elseif code == "fps" then
            fpsEnabled = false
            if fpsGui then
                pcall(function() fpsGui:Destroy() end)
                fpsGui, fpsLabel = nil, nil
            end
        elseif code == "serverinfo" then
            ToggleServerInfo(false)
        elseif code == "noclip" then
            ForEachBasePart(function(part) part.CanCollide = true end)
        elseif code == "fulllight" then
            pcall(function()
                Lighting.Brightness = 2
                Lighting.GlobalShadows = true
            end)
        elseif code == "superspeed" then
            forceSpeed = nil
            ApplySpeed(16)
        elseif code == "dance1" then
            local hum = GetHumanoid()
            if hum then
                pcall(function()
                    for _, t in ipairs(hum:GetPlayingAnimationTracks()) do t:Stop() end
                end)
            end
        elseif code == "fire" then
            local hrp = GetHRP()
            if hrp then RemoveChildByName(hrp, "FireFX") end
        elseif code == "glow" then
            local c = GetChar()
            if c then RemoveChildByName(c, "PlayerGlow") end
        elseif code == "upsidedown" then
            local hrp = GetHRP()
            if hrp then
                pcall(function()
                    hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 0, math.rad(180))
                end)
            end
        elseif code == "bighead" then
            local c = GetChar()
            local head = c and c:FindFirstChild("Head")
            if head then
                pcall(function()
                    local mesh = head:FindFirstChildOfClass("SpecialMesh")
                    if mesh then mesh.Scale = Vector3.new(1, 1, 1) end
                    head.Size = Vector3.new(2, 1, 1)
                end)
            end
        elseif code == "giant" then
            local saved = Running["giant_saved"]
            if saved then
                for part, sz in pairs(saved) do
                    pcall(function() part.Size = sz end)
                end
                Running["giant_saved"] = nil
            end
        elseif code == "screenfx" then
            RemoveChildByName(Lighting, "ScreenFX")
        elseif code == "trail" then
            local hrp = GetHRP()
            if hrp then
                RemoveChildByName(hrp, "PlayerTrail")
                RemoveChildByName(hrp, "TrailAttachment0")
                RemoveChildByName(hrp, "TrailAttachment1")
            end
        elseif code == "firetrail" then
            local hrp = GetHRP()
            if hrp then
                RemoveChildByName(hrp, "FireTrail")
                RemoveChildByName(hrp, "FireTrailA0")
                RemoveChildByName(hrp, "FireTrailA1")
            end
        elseif code == "icetrail" then
            local hrp = GetHRP()
            if hrp then
                RemoveChildByName(hrp, "IceTrail")
                RemoveChildByName(hrp, "IceTrailA0")
                RemoveChildByName(hrp, "IceTrailA1")
            end
        elseif code == "subtitle" then
            local pg = LocalPlayer:FindFirstChild("PlayerGui")
            if pg then RemoveChildByName(pg, "BigFishSubtitle") end
        elseif code == "rainbowname" then
            local c = GetChar()
            local head = c and c:FindFirstChild("Head")
            if head then RemoveChildByName(head, "BigFishNameTag") end
        elseif code == "teamglow" then
            ClearTeamGlow()
        elseif code == "enemyglow" then
            ClearEnemyGlow()
        end
        return
    end

    if code == "esp" then
        authorESPEnabled = true
        RefreshAuthorESP()

    elseif code == "night" then
        pcall(function()
            Lighting.Brightness = 3
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(160, 160, 170)
        end)

    elseif code == "clearfog" then
        pcall(function()
            Lighting.FogEnd = 100000
            Lighting.FogStart = 50000
        end)

    elseif code == "fps" then
        BuildFPSGui()
        fpsEnabled = true
        fpsFrames, fpsClock = 0, os.clock()

    elseif code == "float" then
        local hrp = GetHRP()
        if hrp then
            local fixedY = hrp.Position.Y
            local alive = true
            Track(code, function() alive = false end)
            Track(code, task.spawn(function()
                while alive do
                    local h = GetHRP()
                    if h then
                        pcall(function()
                            h.Velocity = Vector3.new(h.Velocity.X, 0, h.Velocity.Z)
                            h.CFrame = CFrame.new(h.Position.X, fixedY, h.Position.Z)
                        end)
                    end
                    task.wait()
                end
            end))
        else
            Toast("角色还没加载好，请稍后再开")
        end

    elseif code == "antiafk" then
        local vu = game:GetService("VirtualUser")
        Track(code, LocalPlayer.Idled:Connect(function()
            pcall(function()
                vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
                task.wait(1)
                vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            end)
        end))

    elseif code == "collect" then
        local pickWords = { "drop", "coin", "cash", "money", "loot", "gem", "ore", "crate", "chest" }
        local function isPickup(obj)
            local name = string.lower(tostring(obj.Name))
            for _, w in ipairs(pickWords) do
                if string.find(name, w, 1, true) then return true end
            end
            return false
        end
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local hrp = GetHRP()
                if hrp then
                    for _, obj in ipairs(workspace:GetDescendants()) do
                        if isPickup(obj) then
                            local target = nil
                            if obj:IsA("BasePart") then
                                target = obj
                            elseif obj:IsA("Tool") then
                                target = obj:FindFirstChild("Handle")
                            end
                            if target and target:IsA("BasePart") then
                                pcall(function()
                                    target.CFrame = hrp.CFrame + Vector3.new(math.random(-3, 3), 0, math.random(-3, 3))
                                end)
                            end
                        end
                    end
                end
                task.wait(0.25)
            end
        end))

    elseif code == "clicktp" then
        local mouse = LocalPlayer:GetMouse()
        Track(code, mouse.Button1Down:Connect(function()
            local hrp = GetHRP()
            local hit = mouse.Hit
            if hrp and hit then
                pcall(function()
                    hrp.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
                end)
            end
        end))

    elseif code == "autoclick" then
        local vu = game:GetService("VirtualUser")
        local cam = workspace.CurrentCamera
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local s = cam and cam.ViewportSize
                if s then
                    pcall(function()
                        vu:Button1Down(Vector2.new(s.X / 2, s.Y / 2))
                        vu:Button1Up(Vector2.new(s.X / 2, s.Y / 2))
                    end)
                end
                task.wait(0.1)
            end
        end))

    elseif code == "speedhack" then
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                for _, v in ipairs(workspace:GetDescendants()) do
                    if v:IsA("Animation") then
                        pcall(function() v.Speed = 2 end)
                    end
                end
                task.wait(2)
            end
        end))

    elseif code == "itemesp" then
        local function mark(item)
            if item:FindFirstChild("BigFishItemESP") then return end
            pcall(function()
                local hl = Instance.new("Highlight")
                hl.Name = "BigFishItemESP"
                hl.FillColor = Color3.fromRGB(0, 255, 120)
                hl.OutlineColor = Color3.fromRGB(255, 255, 0)
                hl.Parent = item
            end)
        end
        local alive = true
        Track(code, function()
            alive = false
            for _, item in ipairs(workspace:GetDescendants()) do
                local hl = item:FindFirstChild("BigFishItemESP")
                if hl then pcall(function() hl:Destroy() end) end
            end
        end)
        Track(code, task.spawn(function()
            while alive do
                for _, item in ipairs(workspace:GetDescendants()) do
                    if item:IsA("Tool") then
                        mark(item)
                    elseif item:IsA("BasePart") and string.find(string.lower(item.Name), "drop", 1, true) then
                        mark(item)
                    end
                end
                task.wait(2)
            end
        end))

    elseif code == "invisible" then
        local saved = {}
        local alive = true
        ForEachBasePart(function(part)
            saved[part] = part.Transparency
            part.Transparency = 0.85
        end)
        Track(code, function()
            alive = false
            for part, tr in pairs(saved) do
                pcall(function() part.Transparency = tr end)
            end
        end)
        Track(code, task.spawn(function()
            while alive do
                ForEachBasePart(function(part)
                    if saved[part] == nil then
                        saved[part] = part.Transparency
                    end
                    part.Transparency = 0.85
                end)
                task.wait(0.5)
            end
        end))

    elseif code == "noclip" then
        ForEachBasePart(function(part) part.CanCollide = false end)
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                ForEachBasePart(function(part) part.CanCollide = false end)
                task.wait(0.15)
            end
        end))

    elseif code == "god" then
        local hum = GetHumanoid()
        local alive = true
        if hum then
            hum.MaxHealth = 99999
            hum.Health = 99999
        end
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local h = GetHumanoid()
                if h then
                    if h.MaxHealth < 99999 then h.MaxHealth = 99999 end
                    h.Health = 99999
                end
                task.wait(0.2)
            end
        end))

    elseif code == "teamglow" then
        ClearTeamGlow()
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local myTeam = LocalPlayer.Team
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Team == myTeam then
                        local char = p.Character
                        if char then
                            local hl = teamHighlights[p]
                            if not hl or not hl.Parent then
                                hl = Instance.new("Highlight")
                                hl.FillColor = Color3.fromRGB(0, 120, 255)
                                hl.OutlineColor = Color3.fromRGB(0, 170, 255)
                                hl.FillTransparency = 0.5
                                hl.Parent = char
                                teamHighlights[p] = hl
                            elseif hl.Parent ~= char then
                                hl.Parent = char
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end))

    elseif code == "enemyglow" then
        ClearEnemyGlow()
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local myTeam = LocalPlayer.Team
                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer and p.Team ~= myTeam then
                        local char = p.Character
                        if char then
                            local hl = enemyHighlights[p]
                            if not hl or not hl.Parent then
                                hl = Instance.new("Highlight")
                                hl.FillColor = Color3.fromRGB(255, 40, 40)
                                hl.OutlineColor = Color3.fromRGB(255, 90, 90)
                                hl.FillTransparency = 0.5
                                hl.Parent = char
                                enemyHighlights[p] = hl
                            elseif hl.Parent ~= char then
                                hl.Parent = char
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end))

    elseif code == "autoattack" then
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local c = GetChar()
                local hrp = c and c:FindFirstChild("HumanoidRootPart")
                local myHum = c and c:FindFirstChildOfClass("Humanoid")
                if hrp and myHum and myHum.Health > 0 then
                    local myTeam = LocalPlayer.Team
                    local nearest, minDist = nil, 15
                    for _, p in ipairs(Players:GetPlayers()) do
                        if p ~= LocalPlayer and p.Team ~= myTeam then
                            local pc = p.Character
                            local phrp = pc and pc:FindFirstChild("HumanoidRootPart")
                            local phum = pc and pc:FindFirstChildOfClass("Humanoid")
                            if phrp and phum and phum.Health > 0 then
                                local d = (phrp.Position - hrp.Position).Magnitude
                                if d < minDist then
                                    minDist = d
                                    nearest = pc
                                end
                            end
                        end
                    end
                    if nearest then
                        local nhrp = nearest:FindFirstChild("HumanoidRootPart")
                        if nhrp then
                            pcall(function()
                                hrp.CFrame = nhrp.CFrame * CFrame.new(0, 0, 2.5)
                            end)
                            local tool = c:FindFirstChildOfClass("Tool")
                            if tool then
                                pcall(function() tool:Activate() end)
                                local handle = tool:FindFirstChild("Handle")
                                if handle and type(firetouchinterest) == "function" then
                                    pcall(function()
                                        firetouchinterest(handle, nearest, 0)
                                        firetouchinterest(handle, nearest, 1)
                                    end)
                                end
                            end
                        end
                    end
                end
                task.wait(0.12)
            end
        end))

    elseif code == "fulllight" then
        pcall(function()
            Lighting.Brightness = 5
            Lighting.ClockTime = 14
            Lighting.FogEnd = 100000
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        end)

    elseif code == "suicide" then
        local hum = GetHumanoid()
        if hum then hum.Health = 0 end

    elseif code == "superspeed" then
        forceSpeed = 1000
        ApplySpeed(1000)
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                ApplySpeed(1000)
                task.wait(0.25)
            end
        end))

    elseif code == "infstamina" then
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local c = GetChar()
                if c then
                    for _, v in ipairs(c:GetDescendants()) do
                        if v:IsA("NumberValue") then
                            local n = string.lower(v.Name)
                            if string.find(n, "stamina", 1, true) or string.find(n, "energy", 1, true) then
                                pcall(function() v.Value = 1e9 end)
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end))

    elseif code == "infammo" then
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                local c = GetChar()
                if c then
                    for _, tool in ipairs(c:GetChildren()) do
                        if tool:IsA("Tool") then
                            for _, v in ipairs(tool:GetDescendants()) do
                                if v:IsA("ValueBase") and type(v.Value) == "number" then
                                    local n = string.lower(v.Name)
                                    if string.find(n, "ammo", 1, true) or n == "count" or n == "clip" then
                                        pcall(function() v.Value = 999 end)
                                    end
                                end
                            end
                        end
                    end
                end
                task.wait(0.5)
            end
        end))

    elseif code == "infjump" then
        Track(code, UserInputService.JumpRequest:Connect(function()
            local hum = GetHumanoid()
            if hum then
                pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
            end
        end))

    elseif code == "serverinfo" then
        ToggleServerInfo(true)

    elseif code == "dance1" then
        local hum = GetHumanoid()
        if hum then
            pcall(function()
                local anim = Instance.new("Animation")
                anim.AnimationId = "rbxassetid://5918726674"
                local animator = hum:FindFirstChildOfClass("Animator")
                local track
                if animator then
                    track = animator:LoadAnimation(anim)
                else
                    track = hum:LoadAnimation(anim)
                end
                track:Play()
                Track(code, function() pcall(function() track:Stop() end) end)
            end)
        end

    elseif code == "fire" then
        local hrp = GetHRP()
        if hrp then
            RemoveChildByName(hrp, "FireFX")
            local fx = Instance.new("ParticleEmitter")
            fx.Name = "FireFX"
            fx.Color = ColorSequence.new(Color3.fromRGB(255, 120, 0))
            fx.Rate = 30
            fx.Speed = NumberRange.new(3, 6)
            fx.Lifetime = NumberRange.new(0.5, 1)
            fx.Size = NumberSequence.new(1.5)
            fx.Parent = hrp
        end

    elseif code == "glow" then
        local c = GetChar()
        if c then
            RemoveChildByName(c, "PlayerGlow")
            local hl = Instance.new("Highlight")
            hl.Name = "PlayerGlow"
            hl.FillColor = Color3.fromRGB(255, 255, 0)
            hl.OutlineColor = Color3.fromRGB(255, 200, 0)
            hl.FillTransparency = 0.3
            hl.Adornee = c
            hl.Parent = c
        end

    elseif code == "upsidedown" then
        local hrp = GetHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = hrp.CFrame * CFrame.Angles(0, 0, math.rad(180))
            end)
        end

    elseif code == "bighead" then
        local c = GetChar()
        local head = c and c:FindFirstChild("Head")
        if head then
            pcall(function()
                local mesh = head:FindFirstChildOfClass("SpecialMesh")
                if mesh then mesh.Scale = Vector3.new(4, 4, 4) end
                head.Size = Vector3.new(8, 8, 8)
            end)
        end

    elseif code == "giant" then
        local saved = {}
        ForEachBasePart(function(part)
            saved[part] = part.Size
            part.Size = part.Size * 2.5
        end)
        Running["giant_saved"] = saved

    elseif code == "screenfx" then
        RemoveChildByName(Lighting, "ScreenFX")
        local fx = Instance.new("ColorCorrectionEffect")
        fx.Name = "ScreenFX"
        fx.TintColor = Color3.fromRGB(255, 120, 200)
        fx.Saturation = 0.2
        fx.Parent = Lighting

    elseif code == "trail" then
        AttachTrail("PlayerTrail", "TrailAttachment0", "TrailAttachment1",
            ColorSequence.new(Color3.fromRGB(255, 0, 0), Color3.fromRGB(0, 255, 0)), 0.5, 0.1)

    elseif code == "firetrail" then
        AttachTrail("FireTrail", "FireTrailA0", "FireTrailA1",
            ColorSequence.new(Color3.fromRGB(255, 50, 0), Color3.fromRGB(255, 200, 0)), 0.3, 0.05)

    elseif code == "icetrail" then
        AttachTrail("IceTrail", "IceTrailA0", "IceTrailA1",
            ColorSequence.new(Color3.fromRGB(100, 200, 255), Color3.fromRGB(220, 245, 255)), 0.4, 0.08)

    elseif code == "rainbowname" then
        local c = GetChar()
        local head = c and c:FindFirstChild("Head")
        if head then
            RemoveChildByName(head, "BigFishNameTag")
            local bb = Instance.new("BillboardGui")
            bb.Name = "BigFishNameTag"
            bb.Size = UDim2.new(0, 220, 0, 34)
            bb.StudsOffset = Vector3.new(0, 3, 0)
            bb.AlwaysOnTop = true
            bb.Parent = head
            local lbl = Instance.new("TextLabel")
            lbl.Name = "RainbowName"
            lbl.Size = UDim2.new(1, 0, 1, 0)
            lbl.BackgroundTransparency = 1
            lbl.Text = LocalPlayer.DisplayName .. " · 管理员"
            lbl.Font = Enum.Font.GothamBold
            lbl.TextSize = 15
            lbl.TextStrokeTransparency = 0
            lbl.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
            lbl.Parent = bb
        end
        local hue = 0
        local alive = true
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                hue = (hue + 0.02) % 1
                local char = GetChar()
                local h = char and char:FindFirstChild("Head")
                local tag = h and h:FindFirstChild("BigFishNameTag")
                local lbl = tag and tag:FindFirstChild("RainbowName")
                if lbl then
                    pcall(function() lbl.TextColor3 = Color3.fromHSV(hue, 1, 1) end)
                end
                task.wait(0.05)
            end
        end))

    elseif code == "subtitle" then
        local pg = LocalPlayer:WaitForChild("PlayerGui", 10)
        RemoveChildByName(pg, "BigFishSubtitle")
        local sg = Instance.new("ScreenGui")
        sg.Name = "BigFishSubtitle"
        sg.ResetOnSpawn = false
        sg.Parent = pg

        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(0, 520, 0, 40)
        title.Position = UDim2.new(0.5, -260, 0, 12)
        title.BackgroundTransparency = 1
        title.Text = LocalPlayer.Name .. " 已进入服务器"
        title.Font = Enum.Font.GothamBold
        title.TextSize = 24
        title.TextStrokeTransparency = 0
        title.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        title.Parent = sg

        local sid = Instance.new("TextLabel")
        sid.Size = UDim2.new(0, 520, 0, 26)
        sid.Position = UDim2.new(0.5, -260, 0, 52)
        sid.BackgroundTransparency = 1
        sid.Text = "服务器编号：" .. tostring(game.JobId)
        sid.Font = Enum.Font.Gotham
        sid.TextSize = 14
        sid.TextColor3 = Color3.fromRGB(200, 200, 205)
        sid.TextStrokeTransparency = 0
        sid.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        sid.Parent = sg

        local clock = Instance.new("TextLabel")
        clock.Size = UDim2.new(0, 520, 0, 24)
        clock.Position = UDim2.new(0.5, -260, 0, 82)
        clock.BackgroundTransparency = 1
        clock.Font = Enum.Font.Gotham
        clock.TextSize = 13
        clock.TextColor3 = Color3.fromRGB(180, 180, 185)
        clock.TextStrokeTransparency = 0
        clock.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
        clock.Parent = sg

        local alive = true
        local hue = 0
        Track(code, function() alive = false end)
        Track(code, task.spawn(function()
            while alive do
                hue = (hue + 0.015) % 1
                pcall(function() title.TextColor3 = Color3.fromHSV(hue, 1, 1) end)
                local ok2, t = pcall(function() return os.date("*t") end)
                if ok2 and type(t) == "table" then
                    clock.Text = string.format("%d年%d月%d日 %02d:%02d:%02d",
                        t.year, t.month, t.day, t.hour, t.min, t.sec)
                end
                task.wait(0.5)
            end
        end))

    elseif code == "deletepart" then
        local mouse = LocalPlayer:GetMouse()
        local curHl = nil
        Track(code, function()
            if curHl then pcall(function() curHl:Destroy() end); curHl = nil end
        end)
        Track(code, mouse.Button1Down:Connect(function()
            local target = mouse.Target
            if not target then return end
            local model = target:FindFirstAncestorOfClass("Model") or target
            if curHl then pcall(function() curHl:Destroy() end) end
            local hl = Instance.new("Highlight")
            hl.FillColor = Color3.fromRGB(255, 40, 40)
            hl.OutlineColor = Color3.fromRGB(255, 120, 120)
            hl.Adornee = model
            hl.Parent = model
            curHl = hl

            pcall(function()
                Library:Confirm({
                    Title = "确定要删除这个模型吗？",
                    Content = tostring(model.Name),
                    ConfirmText = "确定删除",
                    Callback = function()
                        pcall(function() model:Destroy() end)
                        if curHl then
                            pcall(function() curHl:Destroy() end)
                            curHl = nil
                        end
                        Toast("已删除：" .. tostring(model.Name))
                    end,
                })
            end)
        end))
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    local keep = {}
    for k in pairs(Enabled) do table.insert(keep, k) end
    for _, code in ipairs(keep) do
        if Enabled[code] then
            pcall(SetFeature, code, true)
        end
    end
end)

local MainTab = Window:CreateTab({ Name = "主要", Icon = "house" })
local CombatTab = Window:CreateTab({ Name = "战斗", Icon = "swords" })
local FunTab = Window:CreateTab({ Name = "娱乐", Icon = "sparkles" })
local MusicTab = Window:CreateTab({ Name = "音乐", Icon = "music" })
local ScriptTab = Window:CreateTab({ Name = "游戏脚本", Icon = "layers" })
local PlayerTab = Window:CreateTab({ Name = "玩家", Icon = "users" })
local SettingsTab = Window:CreateTab({ Name = "设置", Icon = "settings" })

local gBase = MainTab:AddLeftGroupbox({ Name = "基础功能", Icon = "zap" })

local function AddToggle(group, name, flag, code)
    group:CreateToggle({
        Name = name,
        CurrentValue = false,
        Flag = flag,
        Callback = function(v) pcall(SetFeature, code, v) end,
    })
end

AddToggle(gBase, "无敌模式", "GodMode", "god")
AddToggle(gBase, "千倍速度", "SuperSpeed", "superspeed")
AddToggle(gBase, "无限体力", "InfStamina", "infstamina")
AddToggle(gBase, "无限弹药", "InfAmmo", "infammo")
AddToggle(gBase, "无限跳跃", "InfJump", "infjump")
AddToggle(gBase, "穿墙模式", "NoClip", "noclip")
AddToggle(gBase, "踏空行走", "Float", "float")
AddToggle(gBase, "动作加速", "SpeedHack", "speedhack")

local gPlus = MainTab:AddRightGroupbox({ Name = "辅助功能", Icon = "wand-sparkles" })

AddToggle(gPlus, "自动收集", "AutoCollect", "collect")
AddToggle(gPlus, "自动连点", "AutoClick", "autoclick")
AddToggle(gPlus, "点击传送", "ClickTP", "clicktp")
AddToggle(gPlus, "防挂机", "AntiAFK", "antiafk")
AddToggle(gPlus, "物品透视", "ItemESP", "itemesp")
AddToggle(gPlus, "隐身模式", "Invisible", "invisible")
AddToggle(gPlus, "删除模型", "DeletePart", "deletepart")
AddToggle(gPlus, "夜视模式", "NightVision", "night")
AddToggle(gPlus, "去除雾效", "ClearFog", "clearfog")
AddToggle(gPlus, "显示帧率", "ShowFPS", "fps")
AddToggle(gPlus, "服务器信息", "ServerInfo", "serverinfo")

local gNum = MainTab:AddLeftGroupbox({ Name = "数值调节", Icon = "sliders-horizontal" })

gNum:CreateSlider({
    Name = "移动速度",
    Range = { 8, 500 },
    Increment = 1,
    CurrentValue = 16,
    Flag = "SpeedValue",
    Callback = function(v)
        forceSpeed = v
        ApplySpeed(v)
    end,
})

gNum:CreateSlider({
    Name = "跳跃高度",
    Range = { 1, 200 },
    Increment = 1,
    CurrentValue = 50,
    Flag = "JumpValue",
    Callback = function(v)
        forceJump = v
        local hum = GetHumanoid()
        if hum then hum.JumpHeight = v end
    end,
})

gNum:CreateSlider({
    Name = "视角广角",
    Range = { 40, 120 },
    Increment = 1,
    CurrentValue = 70,
    Flag = "FOVValue",
    Callback = function(v)
        local cam = workspace.CurrentCamera
        if cam then cam.FieldOfView = v end
    end,
})

gNum:CreateSlider({
    Name = "世界重力",
    Range = { 0, 300 },
    Increment = 1,
    CurrentValue = 196,
    Flag = "GravityValue",
    Callback = function(v)
        workspace.Gravity = v
    end,
})

gNum:CreateSlider({
    Name = "自动旋转速度",
    Range = { 0, 360 },
    Increment = 1,
    CurrentValue = 0,
    Flag = "SpinValue",
    Callback = function(v)
        rotateSpeed = v
    end,
})

local gQuick = MainTab:AddRightGroupbox({ Name = "快捷操作", Icon = "mouse-pointer-click" })

gQuick:CreateButton({
    Name = "快速回家",
    Icon = "navigation",
    Callback = function()
        local hrp = GetHRP()
        if hrp and homeCFrame then
            pcall(function() hrp.CFrame = homeCFrame end)
            Toast("已传送回记录点")
        else
            Toast("还没有记录点，请稍后再试")
        end
    end,
})

gQuick:CreateButton({
    Name = "记录当前位置",
    Icon = "map-pin",
    Callback = function()
        local hrp = GetHRP()
        if hrp then
            homeCFrame = hrp.CFrame
            Toast("位置已记录")
        else
            Toast("角色还没加载好")
        end
    end,
})

gQuick:CreateButton({
    Name = "重置角色",
    Icon = "rotate-cw",
    Callback = function()
        local hum = GetHumanoid()
        if hum then hum.Health = 0 end
    end,
})

local gVision = CombatTab:AddLeftGroupbox({ Name = "视野增强", Icon = "eye" })

AddToggle(gVision, "作者透视", "AuthorESP", "esp")
AddToggle(gVision, "队友高亮", "TeamGlow", "teamglow")
AddToggle(gVision, "敌人高亮", "EnemyGlow", "enemyglow")
AddToggle(gVision, "全图点亮", "FullLight", "fulllight")

local gFight = CombatTab:AddRightGroupbox({ Name = "战斗辅助", Icon = "sword" })

AddToggle(gFight, "自动攻击", "AutoAttack", "autoattack")

gFight:CreateButton({
    Name = "一键自杀",
    Icon = "skull",
    Callback = function()
        pcall(SetFeature, "suicide", true)
        Toast("已重置角色")
    end,
})

gFight:CreateButton({
    Name = "清除所有高亮",
    Icon = "eraser",
    Callback = function()
        ClearAuthorESP()
        ClearTeamGlow()
        ClearEnemyGlow()
        Toast("已清除所有高亮")
    end,
})

local gFun1 = FunTab:AddLeftGroupbox({ Name = "角色特效", Icon = "sparkles" })

AddToggle(gFun1, "喷火模式", "FireFX", "fire")
AddToggle(gFun1, "光环模式", "GlowFX", "glow")
AddToggle(gFun1, "彩虹拖尾", "RainbowTrail", "trail")
AddToggle(gFun1, "火焰拖尾", "FireTrail", "firetrail")
AddToggle(gFun1, "冰霜拖尾", "IceTrail", "icetrail")
AddToggle(gFun1, "全屏滤镜", "ScreenFX", "screenfx")

local gFun2 = FunTab:AddRightGroupbox({ Name = "搞怪模式", Icon = "laugh" })

AddToggle(gFun2, "机械舞", "Dance", "dance1")
AddToggle(gFun2, "倒立行走", "UpsideDown", "upsidedown")
AddToggle(gFun2, "大头模式", "BigHead", "bighead")
AddToggle(gFun2, "巨大化", "Giant", "giant")
AddToggle(gFun2, "彩虹名字", "RainbowName", "rainbowname")
AddToggle(gFun2, "屏幕字幕", "Subtitle", "subtitle")

local musicGroup = MusicTab:AddLeftGroupbox({ Name = "音乐播放", Icon = "music" })
local musicGroup2 = MusicTab:AddRightGroupbox({ Name = "控制", Icon = "volume-2" })

local currentSound = nil

local function StopMusic()
    if currentSound then
        pcall(function()
            currentSound:Stop()
            currentSound:Destroy()
        end)
        currentSound = nil
        return true
    end
    return false
end

local function PlayMusic(soundId, name)
    StopMusic()
    local s = Instance.new("Sound")
    s.Name = "BigFishMusic"
    s.SoundId = "rbxassetid://" .. tostring(soundId)
    s.Volume = 1
    s.Parent = workspace
    pcall(function() s:Play() end)
    currentSound = s
    pcall(function()
        s.Ended:Connect(function()
            if currentSound == s then currentSound = nil end
            pcall(function() s:Destroy() end)
        end)
    end)
    Toast("正在播放：" .. name)
end

local songs = {
    { "进击的巨人", "89711807693889" },
    { "误闯天家", "124384558101360" },
    { "电音喂喂喂", "90054735589094" },
    { "不开心", "88523902860927" },
    { "震撼小曲二", "137717310854691" },
    { "曾经的王", "121931252233493" },
    { "离开我的依赖", "112834898401032" },
    { "雨爱", "79277371759525" },
    { "爱酷", "75047041148646" },
    { "玉米饼", "142376088" },
    { "我太想进步了", "126846792948717" },
    { "最初的记忆", "108869978075942" },
    { "海与你", "76421239273915" },
    { "失眠", "138048397060431" },
    { "传说之下", "138048397060431" },
    { "祖国人进行曲", "86555185586884" },
}

for index, song in ipairs(songs) do
    local group = (index % 2 == 1) and musicGroup or musicGroup2
    local songName = song[1]
    local songId = song[2]
    group:CreateButton({
        Name = songName,
        Icon = "play",
        Callback = function()
            PlayMusic(songId, songName)
        end,
    })
end

MusicTab:AddLeftGroupbox({ Name = "提示", Icon = "info" }):CreateButton({
    Name = "停止播放",
    Icon = "square",
    Callback = function()
        if StopMusic() then
            Toast("已停止播放")
        else
            Toast("当前没有正在播放的音乐")
        end
    end,
})

local scriptData = {
    {
        "常用工具",
        {
            { "飞行模式", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/refs/heads/main/%E9%A3%9E%E9%A5%BC" },
            { "抓包工具", "https://raw.githubusercontent.com/Klinac/scripts/main/utopia_spy.lua" },
            { "碰撞甩飞", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/main/%E5%B8%85%E9%A3%9E" },
            { "自瞄通用", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/main/%E8%87%AA%E7%9E%84" },
            { "多功能脚本 3.3", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/main/nt" },
            { "无限罗宝", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/main/%E9%94%81%E6%9C%BA" },
            { "翻译工具", "https://raw.githubusercontent.com/JsYb666/Item/refs/heads/main/Auto-language" },
        },
    },
    {
        "娱乐脚本",
        {
            { "祖国人", "https://raw.githubusercontent.com/giobolqv1/homelander-by-GioBolqv1-/refs/heads/main/homelander.lua" },
            { "动作动画包", "https://rawscripts.net/raw/Universal-Script-7yd7-I-Emote-Script-48024" },
            { "自定义播放器", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/main/%E6%92%AD%E6%94%BE" },
            { "多人甩飞", "https://raw.githubusercontent.com/hgvuyguyg/jjjjjjjjj/main/%E7%94%A9%E9%A3%9E" },
        },
    },
    {
        "国内脚本",
        {
            { "小皮脚本", "https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ3106633104-Roblox-Pi-script.lua" },
        },
    },
}

local function RunRemote(scriptName, url)
    Toast("正在加载：" .. scriptName)
    task.spawn(function()
        local success, err = pcall(function()
            local src = game:HttpGet(url)
            local fn, compileErr = loadstring(src)
            if type(fn) ~= "function" then
                error(tostring(compileErr), 0)
            end
            pcall(fn)
        end)
        if success then
            Notify(scriptName, "加载成功", "Success")
        else
            Notify(scriptName, "加载失败：" .. tostring(err), "Error")
        end
    end)
end

for _, category in ipairs(scriptData) do
    local catName = category[1]
    local items = category[2]
    local group = ScriptTab:AddLeftGroupbox({ Name = catName, Icon = "folder" })
    for _, item in ipairs(items) do
        local name = item[1]
        local url = item[2]
        group:CreateButton({
            Name = name,
            Icon = "download",
            Callback = function()
                RunRemote(name, url)
            end,
        })
    end
end

ScriptTab:AddRightGroupbox({ Name = "使用提示", Icon = "info" }):CreateButton({
    Name = "脚本加载失败怎么办",
    Icon = "alert-circle",
    Callback = function()
        Toast("多为远程地址失效或游戏不兼容，换一个试试")
    end,
})

local playerGroup = PlayerTab:AddLeftGroupbox({ Name = "选择目标", Icon = "users" })
local actionGroup = PlayerTab:AddRightGroupbox({ Name = "操作", Icon = "mouse-pointer-click" })

local targetName = nil

local function GetPlayerNames()
    local names = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            table.insert(names, p.Name)
        end
    end
    if #names == 0 then
        table.insert(names, "暂无其他玩家")
    end
    return names
end

local initialNames = GetPlayerNames()
targetName = initialNames[1]

playerGroup:CreateDropdown({
    Name = "目标玩家",
    Options = initialNames,
    CurrentOption = initialNames[1],
    AllowNone = false,
    Flag = "TargetPlayer",
    Callback = function(option)
        if type(option) == "table" then
            targetName = option[1]
        else
            targetName = option
        end
    end,
})

playerGroup:CreateButton({
    Name = "刷新玩家列表",
    Icon = "refresh-cw",
    Callback = function()
        local names = GetPlayerNames()
        targetName = names[1]
        Toast("当前共 " .. tostring(#names) .. " 位玩家，目标已切到 " .. tostring(targetName))
    end,
})

local function FindTarget()
    if not targetName then return nil end
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Name == targetName then return p end
    end
    return nil
end

actionGroup:CreateButton({
    Name = "传送到目标旁边",
    Icon = "navigation",
    Callback = function()
        local p = FindTarget()
        local hrp = GetHRP()
        local targetHRP = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
        if hrp and targetHRP then
            pcall(function() hrp.CFrame = targetHRP.CFrame * CFrame.new(3, 0, 0) end)
            Toast("已传送到 " .. tostring(p.Name))
        else
            Toast("找不到该玩家")
        end
    end,
})

local followConn = nil
local followToggle

followToggle = actionGroup:CreateToggle({
    Name = "持续跟随目标",
    CurrentValue = false,
    Flag = "FollowPlayer",
    Callback = function(v)
        if followConn then
            pcall(function() followConn:Disconnect() end)
            followConn = nil
        end
        if not v then return end
        followConn = RunService.Heartbeat:Connect(function()
            local p = FindTarget()
            local hrp = GetHRP()
            local targetHRP = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
            if hrp and targetHRP then
                pcall(function()
                    hrp.CFrame = targetHRP.CFrame * CFrame.new(3, 0, 0)
                end)
            end
        end)
        Toast("开始跟随 " .. tostring(targetName))
    end,
})

UserInputService.JumpRequest:Connect(function()
    if followConn then
        pcall(function() followConn:Disconnect() end)
        followConn = nil
        pcall(function()
            if type(followToggle) == "table" and type(followToggle.Set) == "function" then
                followToggle:Set(false)
            end
        end)
    end
end)

actionGroup:CreateButton({
    Name = "传送到我身边",
    Icon = "users",
    Callback = function()
        Toast("该功能需要服务端权限，客户端无法强制拉人")
    end,
})

local settingGroup = SettingsTab:AddLeftGroupbox({ Name = "界面设置", Icon = "monitor" })

settingGroup:CreateKeybind({
    Name = "显示 / 隐藏界面",
    CurrentKeybind = "RightControl",
    Flag = "ToggleUIKey",
    Callback = function() end,
    OnChanged = function(key)
        pcall(function() Window:SetKeybind(key) end)
    end,
})

settingGroup:CreateDropdown({
    Name = "移动端悬浮按钮",
    Options = { "仅手机显示", "手机与电脑都显示" },
    CurrentOption = "仅手机显示",
    AllowNone = false,
    Flag = "ToggleButtonPlatform",
    Callback = function(option)
        local choice = type(option) == "table" and option[1] or option
        pcall(function()
            if choice == "手机与电脑都显示" then
                Window:SetToggleButtonPlatform("Both")
            else
                Window:SetToggleButtonPlatform("Mobile")
            end
        end)
    end,
})

settingGroup:CreateButton({
    Name = "停止所有功能",
    Icon = "square",
    Callback = function()
        StopAll()
        Toast("所有功能已停止")
    end,
})

settingGroup:CreateButton({
    Name = "卸载界面",
    Icon = "power",
    Callback = function()
        pcall(function()
            Library:Confirm({
                Title = "确定卸载界面？",
                Content = "所有功能会被一起关闭",
                ConfirmText = "卸载",
                Callback = function()
                    StopAll()
                    pcall(function() Window:Destroy() end)
                end,
            })
        end)
    end,
})

SettingsTab:CreateConfigManager({ Name = "配置管理", Side = "Left" })
SettingsTab:CreateThemeManager({ Name = "主题外观", Side = "Right" })

Window:LoadAutoload()

Notify(SCRIPT_NAME, "加载成功，祝玩得开心", "Success")
print(SCRIPT_NAME .. " " .. SCRIPT_VERSION .. " 已加载完毕")
