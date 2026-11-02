local REQUIRES_PAYLOAD = true
local originalArguments = { n = select("#", ...), ... }
local VERIFY_URL = "http://such.xn--rhyr4ib67a.top/license_verify.php"
local SCRIPT_ID = "d710e2aedc7480448a27e1cfe4f62b03"
local DEFAULT_LAYOUT = "violet"
local IS_WHITELIST = true

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
if not game:IsLoaded() then
    game.Loaded:Wait()
end
local player = Players.LocalPlayer
local playerDeadline = os.clock() + 30
while not player and os.clock() < playerDeadline do
    task.wait(0.1)
    player = Players.LocalPlayer
end
if not player then
    warn("验证界面启动失败：请进入游戏后在客户端重新执行。")
    return
end
local playerGui = player:WaitForChild("PlayerGui", 30)
if not playerGui then
    warn("验证界面启动失败：游戏界面尚未准备好，请重新执行。")
    return
end
local GUI_NAME = (IS_WHITELIST and "SLWhitelistVerification_" or "SLKeyVerification_") .. SCRIPT_ID
local previousGui = playerGui:FindFirstChild(GUI_NAME)
if previousGui then
    previousGui:Destroy()
end

local requestFunction
if type(request) == "function" then
    requestFunction = request
elseif type(http_request) == "function" then
    requestFunction = http_request
elseif type(syn) == "table" and type(syn.request) == "function" then
    requestFunction = syn.request
end

local colors = {
    panel = Color3.fromRGB(250, 247, 255),
    input = Color3.fromRGB(241, 234, 252),
    primary = Color3.fromRGB(144, 107, 202),
    text = Color3.fromRGB(58, 44, 80),
    muted = Color3.fromRGB(110, 94, 132),
    error = Color3.fromRGB(157, 52, 85),
    success = Color3.fromRGB(47, 117, 83),
}
local layouts = { classic = true, split = true, dock = true, compact = true, terminal = true, passport = true, ribbon = true, steps = true, noir = true, note = true, aurora = true, jade = true, violet = true }
local layout = layouts[DEFAULT_LAYOUT] and DEFAULT_LAYOUT or "classic"
local nextLayout = layout
local qqGroupNumber = ""
local state = "intro"
local closed = false
local verified = false
local announcementAccepted = false
local payloadStarted = false
local executionCommitted = false
local authorizedExpiresAt
local payloadTicket
local payloadSource
local pendingLayout = false
local connections = {}
local tweens = {}
local tasks = {}
local panelPosition = UDim2.fromScale(0.5, 0.5)
local panelMaxSize = Vector2.new(420, 440)

local function create(className, properties, parent)
    local object = Instance.new(className)
    for property, value in pairs(properties) do
        object[property] = value
    end
    object.Parent = parent
    return object
end

local function round(object, radius)
    return create("UICorner", { CornerRadius = UDim.new(0, radius) }, object)
end

local gui = create("ScreenGui", {
    Name = GUI_NAME,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    DisplayOrder = 100,
}, playerGui)
local overlay = create("Frame", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Active = true,
}, gui)
local playerCard = create("CanvasGroup", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Size = UDim2.fromOffset(92, 142),
    BackgroundColor3 = colors.panel,
    BorderSizePixel = 0,
    Visible = false,
}, overlay)
round(playerCard, 16)
local playerCardOutline = create("UIStroke", { Color = colors.input, Thickness = 1 }, playerCard)
local playerAvatar = create("ImageLabel", {
    Position = UDim2.fromOffset(14, 14),
    Size = UDim2.fromOffset(64, 64),
    BackgroundColor3 = colors.input,
    BorderSizePixel = 0,
    Image = "",
}, playerCard)
round(playerAvatar, 14)
local playerName = create("TextLabel", {
    Position = UDim2.fromOffset(6, 90),
    Size = UDim2.new(1, -12, 0, 40),
    BackgroundTransparency = 1,
    Text = player.Name,
    TextWrapped = true,
    TextTruncate = Enum.TextTruncate.AtEnd,
    TextColor3 = colors.text,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
}, playerCard)
local playerCardProgress = create("NumberValue", { Value = 0 }, gui)
local playerCardStarted = false
local playerCardWidth = 92
local playerCardGap = 12
local playerCardScale = create("UIScale", { Scale = 1 }, playerCard)
local panel = create("CanvasGroup", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 1.5),
    Size = UDim2.new(1, -24, 1, -24),
    BackgroundColor3 = colors.panel,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    Visible = false,
}, overlay)
panel.ZIndex = 2
playerCard.ZIndex = 1
round(panel, 20)
local panelConstraint = create("UISizeConstraint", { MaxSize = Vector2.new(420, 440) }, panel)
local panelScale = create("UIScale", { Scale = 1 }, panel)
local panelOutline = create("UIStroke", { Color = colors.input, Thickness = 1, Transparency = 0.2 }, panel)
local panelGradient = create("UIGradient", { Rotation = 120, Enabled = false }, panel)
local content = create("CanvasGroup", {
    Size = UDim2.fromScale(1, 1),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
}, panel)
local titleLabel = create("TextLabel", {
    Position = UDim2.fromOffset(20, 12),
    Size = UDim2.new(1, -84, 0, 36),
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "SL Whitelist Verification" or "SL Key Verification",
    Font = Enum.Font.GothamBold,
    TextSize = 19,
    TextColor3 = colors.text,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
}, content)
local scroll = create("ScrollingFrame", {
    Position = UDim2.fromOffset(16, 62),
    Size = UDim2.new(1, -32, 1, -74),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.fromOffset(0, 352),
    AutomaticCanvasSize = Enum.AutomaticSize.None,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = colors.primary,
}, content)
local sideRail = create("Frame", {
    Position = UDim2.fromOffset(0, 0),
    Size = UDim2.new(0, 68, 1, 0),
    BackgroundColor3 = Color3.fromRGB(112, 77, 42),
    BorderSizePixel = 0,
    Visible = false,
}, content)
local railMark = create("TextLabel", {
    Position = UDim2.fromOffset(8, 24),
    Size = UDim2.new(1, -16, 0, 32),
    BackgroundTransparency = 1,
    Text = "SL",
    TextColor3 = Color3.fromRGB(255, 243, 223),
    Font = Enum.Font.GothamBold,
    TextSize = 24,
}, sideRail)
local railCaption = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.fromOffset(150, 24),
    Rotation = -90,
    BackgroundTransparency = 1,
    Text = "ACCESS / 授权",
    TextColor3 = Color3.fromRGB(235, 212, 174),
    Font = Enum.Font.GothamBold,
    TextSize = 13,
}, sideRail)
local stepsBar = create("Frame", {
    Position = UDim2.fromOffset(20, 20),
    Size = UDim2.new(1, -40, 0, 40),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Visible = false,
}, content)
local stepIndicators = {}
for index, label in ipairs({ "01  输入", "02  验证", "03  开启" }) do
    stepIndicators[index] = create("TextLabel", {
        Position = UDim2.new((index - 1) / 3, 2, 0, 0),
        Size = UDim2.new(1 / 3, -4, 1, 0),
        BackgroundColor3 = Color3.fromRGB(220, 234, 249),
        BorderSizePixel = 0,
        Text = label,
        TextColor3 = Color3.fromRGB(86, 117, 151),
        Font = Enum.Font.GothamBold,
        TextSize = 12,
    }, stepsBar)
    round(stepIndicators[index], 10)
end
local introSection = create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0 }, scroll)
round(introSection, 12)
local passMark = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 0),
    Size = UDim2.fromOffset(44, 44),
    BackgroundColor3 = Color3.fromRGB(40, 99, 78),
    BorderSizePixel = 0,
    Text = "SL",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Visible = false,
}, introSection)
round(passMark, 22)
local passDivider = create("Frame", {
    BackgroundColor3 = Color3.fromRGB(181, 206, 191),
    BorderSizePixel = 0,
    Visible = false,
}, scroll)
local introHeading = create("TextLabel", {
    Position = UDim2.fromOffset(14, 12),
    Size = UDim2.new(1, -28, 0, 30),
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "账号授权" or "脚本授权",
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextColor3 = colors.text,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    Visible = false,
}, introSection)
local descriptionLabel = create("TextLabel", {
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "使用当前账号用户名验证白名单，面板入场后自动开始验证。"
        or "输入卡密后点击验证；公益模式可留空直接验证。限时卡首次验证成功后开始计时。",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextWrapped = true,
    TextColor3 = colors.muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, introSection)
local entrySection = create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0 }, scroll)
round(entrySection, 12)
local stepLabel = create("TextLabel", {
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "01  当前账号" or "01  输入卡密",
    TextColor3 = colors.muted,
    Font = Enum.Font.GothamBold,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
    Visible = false,
}, entrySection)
local keyInput = create("TextBox", {
    Size = UDim2.new(1, 0, 0, 48),
    BackgroundColor3 = colors.input,
    BorderSizePixel = 0,
    Text = IS_WHITELIST and player.Name or "",
    PlaceholderText = "输入卡密 / Enter key",
    PlaceholderColor3 = colors.muted,
    TextColor3 = colors.text,
    Font = Enum.Font.Gotham,
    TextSize = 16,
    ClearTextOnFocus = false,
    MultiLine = false,
    TextEditable = false,
    TextXAlignment = Enum.TextXAlignment.Left,
}, entrySection)
local inputCorner = round(keyInput, 12)
create("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }, keyInput)
local inputOutline = create("UIStroke", {
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Color = colors.primary,
    Thickness = 1.5,
    Transparency = 1,
}, keyInput)
local actions = create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0 }, entrySection)
local verifyButton = create("TextButton", {
    BackgroundColor3 = colors.primary,
    BorderSizePixel = 0,
    Text = IS_WHITELIST and "验证账号" or "验证卡密",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    AutoButtonColor = false,
}, actions)
local verifyCorner = round(verifyButton, 12)
local clearButton = create("TextButton", {
    BackgroundColor3 = colors.input,
    BorderSizePixel = 0,
    Text = "清空",
    TextColor3 = colors.text,
    Font = Enum.Font.Gotham,
    TextSize = 15,
    AutoButtonColor = false,
    Visible = not IS_WHITELIST,
}, actions)
round(clearButton, 12)
local statusLabel = create("TextLabel", {
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "等待入场完成后验证当前账号。" or "请输入卡密后点击验证。",
    TextColor3 = colors.muted,
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
    RichText = false,
}, entrySection)
create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingTop = UDim.new(0, 8), PaddingRight = UDim.new(0, 8) }, statusLabel)
local footerLabel = create("TextLabel", {
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "验证仅发送脚本编号、当前账号用户名和白名单系统标识。"
        or "最多 128 字符。验证仅发送脚本编号和卡密。",
    TextColor3 = colors.muted,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextWrapped = true,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, scroll)
local qqGroupButton = create("TextButton", {
    BackgroundColor3 = colors.input,
    BorderSizePixel = 0,
    Text = "",
    Font = Enum.Font.GothamBold,
    TextSize = 13,
    TextWrapped = true,
    TextColor3 = colors.text,
    Visible = false,
}, scroll)
round(qqGroupButton, 10)
local loadingMask = create("CanvasGroup", {
    Size = UDim2.fromScale(1, 1),
    BackgroundColor3 = colors.panel,
    BackgroundTransparency = 0.25,
    GroupTransparency = 1,
    BorderSizePixel = 0,
    Active = true,
    ZIndex = 5,
    Visible = false,
}, panel)
local spinner = create("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, -20),
    Size = UDim2.fromOffset(56, 56),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 6,
}, loadingMask)
round(spinner, 28)
local spinnerStroke = create("UIStroke", {
    ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    Color = colors.primary,
    Thickness = 3,
}, spinner)
create("UIGradient", {
    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0), NumberSequenceKeypoint.new(1, 1) }),
}, spinnerStroke)
local loadingLabel = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 34),
    Size = UDim2.new(1, -24, 0, 28),
    BackgroundTransparency = 1,
    Text = "正在验证卡密…",
    Font = Enum.Font.GothamBold,
    TextSize = 17,
    TextColor3 = colors.text,
    ZIndex = 6,
}, loadingMask)
local introLabel = create("TextLabel", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(1, -40, 0, 100),
    BackgroundTransparency = 1,
    Text = IS_WHITELIST and "SL Whitelist Verification System" or "SL Key Verification System",
    Font = Enum.Font.GothamBold,
    TextSize = 28,
    TextWrapped = true,
    TextColor3 = Color3.fromRGB(255, 255, 255),
    TextTransparency = 1,
    ZIndex = 3,
}, overlay)
local announcementPanel = create("CanvasGroup", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),
    Size = UDim2.new(1, -24, 1, -24),
    BackgroundColor3 = colors.panel,
    BorderSizePixel = 0,
    GroupTransparency = 1,
    Visible = false,
    ZIndex = 4,
}, overlay)
round(announcementPanel, 20)
local announcementOutline = create("UIStroke", { Color = colors.input, Thickness = 1 }, announcementPanel)
create("UISizeConstraint", { MaxSize = Vector2.new(440, 360) }, announcementPanel)
local announcementTitle = create("TextLabel", {
    Position = UDim2.fromOffset(18, 16),
    Size = UDim2.new(1, -36, 0, 30),
    BackgroundTransparency = 1,
    Text = "脚本公告",
    TextColor3 = colors.text,
    Font = Enum.Font.GothamBold,
    TextSize = 20,
    TextXAlignment = Enum.TextXAlignment.Left,
}, announcementPanel)
local announcementScroll = create("ScrollingFrame", {
    Position = UDim2.fromOffset(18, 58),
    Size = UDim2.new(1, -36, 1, -166),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    CanvasSize = UDim2.fromOffset(0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
    ScrollingDirection = Enum.ScrollingDirection.Y,
    ScrollBarThickness = 3,
    ScrollBarImageColor3 = colors.primary,
}, announcementPanel)
local announcementBody = create("TextLabel", {
    Size = UDim2.new(1, -10, 0, 0),
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundTransparency = 1,
    Text = "",
    RichText = false,
    TextWrapped = true,
    TextColor3 = colors.text,
    Font = Enum.Font.Gotham,
    TextSize = 15,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextYAlignment = Enum.TextYAlignment.Top,
}, announcementScroll)
local announcementCountdown = create("TextLabel", {
    Position = UDim2.new(0, 18, 1, -100),
    Size = UDim2.new(1, -36, 0, 32),
    BackgroundTransparency = 1,
    Text = "",
    TextWrapped = true,
    TextColor3 = colors.success,
    Font = Enum.Font.Gotham,
    TextSize = 12,
    TextXAlignment = Enum.TextXAlignment.Left,
}, announcementPanel)
local acknowledgeButton = create("TextButton", {
    Position = UDim2.new(0, 18, 1, -60),
    Size = UDim2.new(1, -36, 0, 44),
    BackgroundColor3 = colors.primary,
    BorderSizePixel = 0,
    Text = REQUIRES_PAYLOAD and "关闭公告并执行脚本" or "关闭公告",
    TextColor3 = Color3.fromRGB(255, 255, 255),
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    Active = false,
    AutoButtonColor = false,
}, announcementPanel)
round(acknowledgeButton, 14)

local function isOpen()
    return not closed and gui.Parent ~= nil
end

local function connect(signal, callback)
    connections[#connections + 1] = signal:Connect(callback)
end

local function cancelTask(name)
    local thread = tasks[name]
    tasks[name] = nil
    if thread and thread ~= coroutine.running() and coroutine.status(thread) ~= "dead" then
        task.cancel(thread)
    end
end

local function launch(name, callback)
    cancelTask(name)
    tasks[name] = task.defer(function()
        if isOpen() then
            callback()
        end
        if tasks[name] == coroutine.running() then
            tasks[name] = nil
        end
    end)
end

local function stopTween(object)
    if tweens[object] then
        tweens[object]:Cancel()
        tweens[object] = nil
    end
end

local function animate(object, duration, properties, repeats, easing)
    if not isOpen() then
        return nil
    end
    stopTween(object)
    local tween = TweenService:Create(object,
        TweenInfo.new(duration, easing or Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, repeats or 0), properties)
    tweens[object] = tween
    tween:Play()
    return tween
end

local function waitTween(tween)
    if not tween then
        return false
    end
    return tween.Completed:Wait() == Enum.PlaybackState.Completed and isOpen()
end

local function updateControls()
    if not isOpen() then
        return
    end
    local ready = state == "ready" and requestFunction ~= nil and not verified
    if layout == "steps" then
        local currentStep = verified and 3 or (state == "verifying" and 2 or 1)
        for index, indicator in ipairs(stepIndicators) do
            indicator.BackgroundColor3 = index <= currentStep and colors.primary or colors.input
            indicator.TextColor3 = index <= currentStep and Color3.fromRGB(255, 255, 255) or colors.muted
        end
    end
    verifyButton.Active = ready
    clearButton.Active = ready and not IS_WHITELIST
    keyInput.TextEditable = ready and not IS_WHITELIST
    verifyButton.BackgroundTransparency = ready and 0 or 0.25
    verifyButton.Text = state == "verifying" and "Verifying…"
        or (verified and "验证成功" or (IS_WHITELIST and "验证账号" or "验证并继续"))
end

local function applyLayout(entering)
    if not isOpen() then
        return
    end
    if state ~= "intro" and state ~= "ready" and not (entering and state == "entering") then
        pendingLayout = true
        return
    end
    pendingLayout = false
    layout = nextLayout
    local letter = layout == "classic"
    local orbit = layout == "split"
    local horizontal = layout == "dock"
    local terminal = layout == "terminal"
    local compact = layout == "compact"
    local passport = layout == "passport"
    local ribbon = layout == "ribbon"
    local steps = layout == "steps"
    local noir = layout == "noir"
    local note = layout == "note"
    local aurora = layout == "aurora"
    local jade = layout == "jade"
    local violet = layout == "violet"
    local wide = overlay.AbsoluteSize.X - 224 >= 600
    colors.panel = terminal and Color3.fromRGB(23, 29, 44) or (compact and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(250, 247, 255))
    colors.input = terminal and Color3.fromRGB(36, 44, 62) or (compact and Color3.fromRGB(244, 245, 248) or Color3.fromRGB(241, 234, 252))
    colors.primary = terminal and Color3.fromRGB(111, 138, 225) or (compact and Color3.fromRGB(49, 54, 71) or Color3.fromRGB(144, 107, 202))
    colors.text = terminal and Color3.fromRGB(240, 243, 252) or (compact and Color3.fromRGB(32, 36, 46) or Color3.fromRGB(58, 44, 80))
    colors.muted = terminal and Color3.fromRGB(164, 176, 202) or (compact and Color3.fromRGB(119, 124, 137) or Color3.fromRGB(110, 94, 132))
    colors.error = terminal and Color3.fromRGB(255, 157, 173) or Color3.fromRGB(157, 52, 85)
    colors.success = terminal and Color3.fromRGB(139, 224, 190) or Color3.fromRGB(47, 117, 83)
    if letter then
        colors.panel = Color3.fromRGB(255, 240, 237)
        colors.input = Color3.fromRGB(255, 255, 255)
        colors.primary = Color3.fromRGB(196, 86, 73)
        colors.text = Color3.fromRGB(97, 54, 47)
        colors.muted = Color3.fromRGB(161, 111, 103)
    elseif orbit then
        colors.panel = Color3.fromRGB(32, 27, 54)
        colors.input = Color3.fromRGB(51, 43, 80)
        colors.primary = Color3.fromRGB(128, 101, 201)
        colors.text = Color3.fromRGB(240, 234, 253)
        colors.muted = Color3.fromRGB(177, 163, 209)
        colors.error = Color3.fromRGB(255, 157, 173)
        colors.success = Color3.fromRGB(139, 224, 190)
    elseif horizontal then
        colors.panel = Color3.fromRGB(238, 243, 233)
        colors.input = Color3.fromRGB(255, 255, 255)
        colors.primary = Color3.fromRGB(72, 102, 67)
        colors.text = Color3.fromRGB(45, 69, 43)
        colors.muted = Color3.fromRGB(122, 142, 114)
    elseif passport then
        colors.panel = Color3.fromRGB(237, 248, 242)
        colors.input = Color3.fromRGB(255, 255, 255)
        colors.primary = Color3.fromRGB(40, 99, 78)
        colors.text = Color3.fromRGB(36, 79, 66)
        colors.muted = Color3.fromRGB(107, 142, 126)
    end
    if ribbon then
        colors.panel = Color3.fromRGB(253, 246, 231)
        colors.input = Color3.fromRGB(245, 232, 207)
        colors.primary = Color3.fromRGB(112, 77, 42)
        colors.text = Color3.fromRGB(73, 52, 33)
        colors.muted = Color3.fromRGB(144, 116, 83)
    elseif steps then
        colors.panel = Color3.fromRGB(241, 248, 255)
        colors.input = Color3.fromRGB(220, 234, 249)
        colors.primary = Color3.fromRGB(49, 119, 187)
        colors.text = Color3.fromRGB(31, 65, 99)
        colors.muted = Color3.fromRGB(86, 117, 151)
    end
    if noir then
        colors.panel = Color3.fromRGB(239, 245, 252)
        colors.input = Color3.fromRGB(255, 255, 255)
        colors.primary = Color3.fromRGB(73, 112, 166)
        colors.text = Color3.fromRGB(39, 61, 89)
        colors.muted = Color3.fromRGB(113, 134, 160)
    elseif note then
        colors.panel = Color3.fromRGB(251, 250, 247)
        colors.input = Color3.fromRGB(241, 239, 234)
        colors.primary = Color3.fromRGB(103, 118, 111)
        colors.text = Color3.fromRGB(53, 64, 59)
        colors.muted = Color3.fromRGB(136, 144, 137)
    end
    if aurora then
        colors.panel = Color3.fromRGB(19, 34, 48)
        colors.input = Color3.fromRGB(29, 53, 67)
        colors.primary = Color3.fromRGB(55, 157, 151)
        colors.text = Color3.fromRGB(235, 249, 248)
        colors.muted = Color3.fromRGB(145, 181, 188)
        colors.error = Color3.fromRGB(255, 167, 179)
        colors.success = Color3.fromRGB(135, 230, 197)
    elseif jade then
        colors.panel = Color3.fromRGB(240, 249, 246)
        colors.input = Color3.fromRGB(255, 255, 255)
        colors.primary = Color3.fromRGB(49, 121, 105)
        colors.text = Color3.fromRGB(39, 76, 68)
        colors.muted = Color3.fromRGB(113, 149, 136)
    elseif violet then
        colors.panel = Color3.fromRGB(248, 244, 252)
        colors.input = Color3.fromRGB(237, 228, 247)
        colors.primary = Color3.fromRGB(117, 83, 159)
        colors.text = Color3.fromRGB(74, 51, 101)
        colors.muted = Color3.fromRGB(150, 127, 172)
    end
    sideRail.Visible = ribbon or violet
    sideRail.Size = UDim2.new(0, violet and 48 or 68, 1, 0)
    sideRail.BackgroundColor3 = violet and colors.primary or Color3.fromRGB(112, 77, 42)
    railMark.TextColor3 = violet and Color3.fromRGB(251, 245, 255) or Color3.fromRGB(255, 243, 223)
    railCaption.TextColor3 = violet and Color3.fromRGB(224, 207, 243) or Color3.fromRGB(235, 212, 174)
    railCaption.Text = violet and "PRIVATE / 专属" or "ACCESS / 授权"
    stepsBar.Visible = steps
    panel.BackgroundColor3 = colors.panel
    panelOutline.Color = colors.input
    panelGradient.Enabled = terminal or aurora
    panelGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(176, 191, 228))
    titleLabel.TextColor3 = colors.text
    introHeading.TextColor3 = colors.text
    descriptionLabel.TextColor3 = colors.muted
    stepLabel.TextColor3 = colors.muted
    keyInput.BackgroundColor3 = colors.input
    keyInput.TextColor3 = colors.text
    keyInput.PlaceholderColor3 = colors.muted
    inputOutline.Color = colors.primary
    verifyButton.BackgroundColor3 = colors.primary
    clearButton.BackgroundColor3 = colors.input
    clearButton.TextColor3 = colors.muted
    statusLabel.TextColor3 = colors.muted
    footerLabel.TextColor3 = colors.muted
    scroll.ScrollBarImageColor3 = colors.primary
    loadingMask.BackgroundColor3 = colors.panel
    spinnerStroke.Color = colors.primary
    loadingLabel.TextColor3 = colors.text
    loadingLabel.Text = IS_WHITELIST and "正在验证账号…" or "正在验证卡密…"
    announcementPanel.BackgroundColor3 = colors.panel
    announcementOutline.Color = colors.input
    announcementTitle.TextColor3 = colors.text
    announcementBody.TextColor3 = colors.text
    announcementCountdown.TextColor3 = colors.muted
    announcementScroll.ScrollBarImageColor3 = colors.primary
    acknowledgeButton.BackgroundColor3 = colors.primary
    panelMaxSize = orbit and Vector2.new(540, 430)
        or (horizontal and Vector2.new(740, 258)
        or (compact and Vector2.new(400, 390)
        or (terminal and Vector2.new(680, 430)
        or (passport and Vector2.new(460, 470)
        or (ribbon and Vector2.new(520, 450)
        or (steps and Vector2.new(620, 350) or Vector2.new(430, 490)))))))
    if noir then
        panelMaxSize = Vector2.new(600, wide and 310 or 380)
    elseif note then
        panelMaxSize = Vector2.new(420, 430)
    end
    if aurora then
        panelMaxSize = Vector2.new(680, wide and 360 or 510)
    elseif jade then
        panelMaxSize = Vector2.new(420, 490)
    elseif violet then
        panelMaxSize = Vector2.new(500, 460)
    end
    local compactPlayerCard = overlay.AbsoluteSize.X < 600
    playerCardScale.Scale = compactPlayerCard and 0.65 or 1
    playerCardWidth = 92 * playerCardScale.Scale
    playerCardGap = compactPlayerCard and 8 or 12
    panel.Size = UDim2.new(1, -2 * (playerCardWidth + playerCardGap + 8), 1, -24)
    playerCard.BackgroundColor3 = colors.panel
    playerCardOutline.Color = colors.input
    playerAvatar.BackgroundColor3 = colors.input
    playerName.TextColor3 = colors.text
    local anchor = Vector2.new(0.5, 0.5)
    panelPosition = UDim2.fromScale(0.5, 0.5)
    if state == "ready" then
        animate(panelConstraint, 0.2, { MaxSize = panelMaxSize })
        animate(panel, 0.2, { AnchorPoint = anchor, Position = panelPosition })
    else
        panelConstraint.MaxSize = panelMaxSize
        panel.AnchorPoint = anchor
    end
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.Visible = compact or terminal
    titleLabel.Text = terminal and "SL  /  ACCESS"
        or (compact and "SL  /  授权中心"
        or (IS_WHITELIST and "SL Whitelist Verification" or "SL Key Verification"))
    titleLabel.Size = UDim2.new(1, -40, 0, 36)
    titleLabel.TextSize = (compact or terminal) and 14 or 19
    scroll.Position = UDim2.fromOffset(16, 62)
    scroll.Size = UDim2.new(1, -32, 1, -74)
    scroll.CanvasPosition = Vector2.zero
    passMark.Visible = passport or horizontal
    passMark.Parent = introSection
    passMark.AnchorPoint = Vector2.new(0.5, 0)
    passMark.Position = UDim2.new(0.5, 0, 0, 0)
    passMark.Size = UDim2.fromOffset(44, 44)
    passMark.BackgroundColor3 = colors.primary
    passDivider.Visible = passport
    introHeading.TextXAlignment = passport and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    descriptionLabel.TextXAlignment = passport and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left
    introHeading.Visible = not compact
    introHeading.Text = terminal and "专属访问" or (IS_WHITELIST and "账号授权" or "脚本授权")
    introHeading.TextSize = terminal and 28 or 20
    introHeading.Position = UDim2.fromOffset(14, 12)
    introHeading.Size = UDim2.new(1, -28, 0, 30)
    introSection.BackgroundColor3 = colors.input
    introSection.BackgroundTransparency = 1
    introSection.Position = UDim2.fromOffset(0, 0)
    introSection.Size = UDim2.new(1, -4, 0, 56)
    descriptionLabel.Position = UDim2.fromOffset(0, 0)
    descriptionLabel.Size = UDim2.fromScale(1, 1)
    descriptionLabel.Font = Enum.Font.Gotham
    descriptionLabel.Text = terminal and "验证你的专属授权。\n完成授权后即可开启脚本。"
        or (compact and "输入你的授权卡密，开启脚本。"
        or (IS_WHITELIST and "使用当前账号用户名验证白名单，面板入场后自动开始验证。"
        or "输入卡密后点击验证；公益模式可留空直接验证。限时卡首次验证成功后开始计时。"))
    entrySection.BackgroundColor3 = colors.input
    entrySection.BackgroundTransparency = compact and 0.45 or 1
    entrySection.Position = UDim2.fromOffset(0, 68)
    entrySection.Size = UDim2.new(1, -4, 0, 220)
    stepLabel.Visible = terminal or passport or ribbon or letter
    stepLabel.Text = "授权卡密"
    keyInput.Position = UDim2.fromOffset(0, 0)
    keyInput.Size = UDim2.new(1, 0, 0, 48)
    keyInput.Font = Enum.Font.Gotham
    keyInput.TextSize = 16
    inputCorner.CornerRadius = UDim.new(0, 12)
    verifyCorner.CornerRadius = UDim.new(0, 12)
    actions.Parent = entrySection
    actions.BackgroundTransparency = 1
    actions.Position = UDim2.fromOffset(0, 60)
    actions.Size = UDim2.new(1, 0, 0, 48)
    verifyButton.Position = UDim2.fromOffset(0, 0)
    verifyButton.TextSize = 16
    verifyButton.Size = IS_WHITELIST and UDim2.fromScale(1, 1) or UDim2.new(0.64, -6, 1, 0)
    clearButton.Visible = not IS_WHITELIST
    clearButton.Position = UDim2.new(0.64, 6, 0, 0)
    clearButton.Size = UDim2.new(0.36, -6, 1, 0)
    statusLabel.Position = UDim2.fromOffset(0, 120)
    statusLabel.Size = UDim2.new(1, 0, 0, 92)
    statusLabel.Font = Enum.Font.Gotham
    footerLabel.Text = IS_WHITELIST and "验证仅发送脚本编号、当前账号用户名和白名单系统标识。"
        or "最多 128 字符。验证仅发送脚本编号和卡密。"
    footerLabel.Position = UDim2.fromOffset(0, 300)
    footerLabel.Size = UDim2.new(1, -8, 0, 44)
    scroll.CanvasSize = UDim2.fromOffset(0, 352)
    if aurora then
        scroll.Position = UDim2.fromOffset(20, 22)
        scroll.Size = UDim2.new(1, -40, 1, -44)
        introSection.BackgroundTransparency = 0
        introSection.Size = wide and UDim2.new(0.43, -10, 0, 240) or UDim2.new(1, -4, 0, 152)
        introHeading.Text = "极光通行"
        introHeading.Position = UDim2.fromOffset(16, 20)
        introHeading.Size = UDim2.new(1, -32, 0, 42)
        introHeading.TextSize = 27
        descriptionLabel.Text = "SL / AURORA\n连接你的专属空间。"
        descriptionLabel.Position = UDim2.fromOffset(16, 80)
        descriptionLabel.Size = UDim2.new(1, -32, 0, 58)
        entrySection.Position = wide and UDim2.new(0.43, 12, 0, 8) or UDim2.fromOffset(0, 172)
        entrySection.Size = wide and UDim2.new(0.57, -16, 0, 232) or UDim2.new(1, -4, 0, 232)
        keyInput.Size = UDim2.new(1, 0, 0, 52)
        actions.Position = UDim2.fromOffset(0, 68)
        actions.Size = UDim2.new(1, 0, 0, 48)
        verifyButton.Size = UDim2.fromScale(1, 1)
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 134)
        statusLabel.Size = UDim2.new(1, 0, 0, 92)
        footerLabel.Text = "SL / 让每一次相遇，都有回响。"
        footerLabel.Position = UDim2.fromOffset(0, wide and 262 or 426)
        footerLabel.Size = UDim2.new(1, -4, 0, 30)
        scroll.CanvasSize = UDim2.fromOffset(0, wide and 300 or 464)
    elseif jade then
        scroll.Position = UDim2.fromOffset(22, 22)
        scroll.Size = UDim2.new(1, -44, 1, -44)
        passMark.Visible = true
        passMark.Size = UDim2.fromOffset(48, 48)
        introHeading.Text = "青瓷通行证"
        introHeading.TextXAlignment = Enum.TextXAlignment.Center
        introHeading.Position = UDim2.fromOffset(0, 62)
        introHeading.Size = UDim2.new(1, 0, 0, 34)
        introHeading.TextSize = 24
        descriptionLabel.Text = "此刻，为你开放。"
        descriptionLabel.TextXAlignment = Enum.TextXAlignment.Center
        descriptionLabel.Position = UDim2.fromOffset(0, 108)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 28)
        introSection.Size = UDim2.new(1, -4, 0, 142)
        passDivider.Visible = true
        passDivider.Position = UDim2.fromOffset(0, 154)
        passDivider.Size = UDim2.new(1, -4, 0, 1)
        passDivider.BackgroundColor3 = colors.primary
        entrySection.Position = UDim2.fromOffset(0, 174)
        entrySection.Size = UDim2.new(1, -4, 0, 212)
        keyInput.Size = UDim2.new(1, 0, 0, 48)
        actions.Position = UDim2.fromOffset(0, 62)
        actions.Size = UDim2.new(1, 0, 0, 46)
        verifyButton.Size = UDim2.fromScale(1, 1)
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 126)
        statusLabel.Size = UDim2.new(1, 0, 0, 76)
        footerLabel.Text = "SL / 此证属于当前账号。"
        footerLabel.Position = UDim2.fromOffset(0, 404)
        footerLabel.Size = UDim2.new(1, -4, 0, 28)
        scroll.CanvasSize = UDim2.fromOffset(0, 440)
    elseif violet then
        scroll.Position = UDim2.fromOffset(64, 24)
        scroll.Size = UDim2.new(1, -82, 1, -44)
        introSection.Size = UDim2.new(1, -4, 0, 102)
        introHeading.Text = "专属邀请"
        introHeading.Position = UDim2.fromOffset(0, 2)
        introHeading.Size = UDim2.new(1, 0, 0, 34)
        introHeading.TextSize = 24
        descriptionLabel.Text = "欢迎回到\n你的专属空间。"
        descriptionLabel.Position = UDim2.fromOffset(0, 48)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 50)
        entrySection.BackgroundTransparency = 0
        entrySection.Position = UDim2.fromOffset(0, 118)
        entrySection.Size = UDim2.new(1, -4, 0, 222)
        keyInput.Position = UDim2.fromOffset(12, 14)
        keyInput.Size = UDim2.new(1, -24, 0, 48)
        keyInput.BackgroundColor3 = colors.panel
        actions.Position = UDim2.fromOffset(12, 76)
        actions.Size = UDim2.new(1, -24, 0, 44)
        verifyButton.Size = UDim2.fromScale(1, 1)
        verifyButton.TextSize = 13
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(12, 136)
        statusLabel.Size = UDim2.new(1, -24, 0, 74)
        footerLabel.Text = "SL / 欢迎如约而至。"
        footerLabel.Position = UDim2.fromOffset(0, 358)
        footerLabel.Size = UDim2.new(1, -4, 0, 30)
        scroll.CanvasSize = UDim2.fromOffset(0, 396)
    elseif noir then
        scroll.Position = UDim2.fromOffset(20, 20)
        scroll.Size = UDim2.new(1, -40, 1, -40)
        introSection.Size = UDim2.new(1, -4, 0, 74)
        introHeading.Text = IS_WHITELIST and "账号通行" or "授权连接"
        introHeading.Position = UDim2.fromOffset(0, 0)
        introHeading.Size = UDim2.new(1, 0, 0, 32)
        introHeading.TextSize = 23
        descriptionLabel.Text = IS_WHITELIST and "识别当前账号，连接你的专属脚本。" or "输入卡密，连接你的专属脚本。"
        descriptionLabel.Position = UDim2.fromOffset(0, 40)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 30)
        entrySection.Position = UDim2.fromOffset(0, 92)
        entrySection.Size = UDim2.new(1, -4, 0, 144)
        keyInput.Size = wide and UDim2.new(0.66, -8, 0, 52) or UDim2.new(1, 0, 0, 48)
        actions.Position = wide and UDim2.new(0.66, 4, 0, 0) or UDim2.fromOffset(0, 60)
        actions.Size = wide and UDim2.new(0.34, -4, 0, 52) or UDim2.new(1, 0, 0, 44)
        verifyButton.Size = UDim2.fromScale(1, 1)
        verifyButton.TextSize = 13
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, wide and 66 or 116)
        statusLabel.Size = UDim2.new(1, 0, 0, 56)
        footerLabel.Text = "SL / 每一次连接，都有回应。"
        footerLabel.Position = UDim2.fromOffset(0, wide and 228 or 284)
        footerLabel.Size = UDim2.new(1, -4, 0, 28)
        scroll.CanvasSize = UDim2.fromOffset(0, wide and 264 or 320)
    elseif note then
        scroll.Position = UDim2.fromOffset(22, 22)
        scroll.Size = UDim2.new(1, -44, 1, -44)
        introSection.Size = UDim2.new(1, -4, 0, 94)
        introHeading.Text = IS_WHITELIST and "你好，欢迎回来" or "开启你的灵感"
        introHeading.Position = UDim2.fromOffset(0, 4)
        introHeading.Size = UDim2.new(1, 0, 0, 34)
        introHeading.TextSize = 23
        descriptionLabel.Text = IS_WHITELIST and "当前账号即是你的通行凭证。" or "一枚卡密，打开专属体验。"
        descriptionLabel.Position = UDim2.fromOffset(0, 48)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 40)
        entrySection.BackgroundTransparency = 0
        entrySection.Position = UDim2.fromOffset(0, 110)
        entrySection.Size = UDim2.new(1, -4, 0, 202)
        keyInput.Position = UDim2.fromOffset(14, 14)
        keyInput.Size = UDim2.new(1, -28, 0, 48)
        inputCorner.CornerRadius = UDim.new(0, 10)
        verifyCorner.CornerRadius = UDim.new(0, 10)
        actions.Position = UDim2.fromOffset(14, 76)
        actions.Size = UDim2.new(1, -28, 0, 44)
        verifyButton.Size = UDim2.fromScale(1, 1)
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(14, 132)
        statusLabel.Size = UDim2.new(1, -28, 0, 60)
        footerLabel.Text = "SL / 为灵感留一处空间。"
        footerLabel.Position = UDim2.fromOffset(0, 332)
        footerLabel.Size = UDim2.new(1, -4, 0, 28)
        scroll.CanvasSize = UDim2.fromOffset(0, 368)
    elseif letter then
        scroll.Position = UDim2.fromOffset(20, 22)
        scroll.Size = UDim2.new(1, -40, 1, -38)
        introSection.Size = UDim2.new(1, -4, 0, 122)
        introHeading.Text = "让灵感开始运行"
        introHeading.Position = UDim2.fromOffset(0, 8)
        introHeading.Size = UDim2.new(1, 0, 0, 38)
        introHeading.TextSize = 25
        descriptionLabel.Text = "SL / 脚本授权\n输入卡密，为这次体验解锁。"
        descriptionLabel.Position = UDim2.fromOffset(0, 58)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 56)
        entrySection.BackgroundTransparency = 0
        entrySection.Position = UDim2.fromOffset(0, 138)
        entrySection.Size = UDim2.new(1, -4, 0, 224)
        stepLabel.Position = UDim2.fromOffset(16, 14)
        stepLabel.Size = UDim2.new(1, -32, 0, 22)
        keyInput.Position = UDim2.fromOffset(16, 46)
        keyInput.Size = UDim2.new(1, -32, 0, 52)
        keyInput.BackgroundColor3 = Color3.fromRGB(255, 244, 241)
        actions.Position = UDim2.fromOffset(16, 112)
        actions.Size = UDim2.new(1, -32, 0, 48)
        verifyButton.Position = IS_WHITELIST and UDim2.fromOffset(0, 0) or UDim2.new(0.28, 8, 0, 0)
        verifyButton.Size = IS_WHITELIST and UDim2.fromScale(1, 1) or UDim2.new(0.72, -8, 1, 0)
        clearButton.Position = UDim2.fromOffset(0, 0)
        clearButton.Size = UDim2.new(0.28, 0, 1, 0)
        statusLabel.Position = UDim2.fromOffset(8, 168)
        statusLabel.Size = UDim2.new(1, -16, 0, 50)
        footerLabel.Text = "SL / 每一次灵感，都值得开启。"
        footerLabel.Position = UDim2.fromOffset(0, 382)
        footerLabel.Size = UDim2.new(1, -4, 0, 30)
        scroll.CanvasSize = UDim2.fromOffset(0, 420)
    elseif orbit then
        scroll.Position = UDim2.fromOffset(20, 22)
        scroll.Size = UDim2.new(1, -40, 1, -38)
        introSection.Size = UDim2.new(1, -4, 0, 112)
        introHeading.Text = "星轨控制台"
        introHeading.Position = UDim2.fromOffset(0, 0)
        introHeading.Size = UDim2.new(1, 0, 0, 38)
        introHeading.TextSize = 26
        descriptionLabel.Text = "SL / ORBIT\n连接你的专属授权，准备启程。"
        descriptionLabel.Position = UDim2.fromOffset(0, 50)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 56)
        entrySection.Position = UDim2.fromOffset(0, 128)
        entrySection.Size = UDim2.new(1, -4, 0, 186)
        keyInput.Size = UDim2.new(1, -98, 0, 56)
        statusLabel.Position = UDim2.fromOffset(0, 72)
        statusLabel.Size = UDim2.new(1, -98, 0, 106)
        actions.Position = UDim2.new(1, -84, 0, 0)
        actions.Size = UDim2.fromOffset(84, 186)
        verifyButton.Size = UDim2.new(1, 0, 0, 128)
        verifyButton.TextSize = 13
        clearButton.Position = UDim2.fromOffset(0, 142)
        clearButton.Size = UDim2.fromOffset(84, 44)
        footerLabel.Text = "SL / 你的授权，是启程的坐标。"
        footerLabel.Position = UDim2.fromOffset(0, 336)
        footerLabel.Size = UDim2.new(1, -4, 0, 30)
        scroll.CanvasSize = UDim2.fromOffset(0, 374)
    elseif horizontal then
        scroll.Position = UDim2.fromOffset(16, 20)
        scroll.Size = UDim2.new(1, -32, 1, -36)
        introSection.Size = UDim2.new(1, -4, 0, 48)
        passMark.Parent = scroll
        passMark.AnchorPoint = Vector2.new(0, 0)
        passMark.Position = UDim2.fromOffset(0, 68)
        passMark.Size = UDim2.fromOffset(44, 44)
        introHeading.Text = "森绿横笺"
        introHeading.Position = UDim2.fromOffset(0, 0)
        introHeading.Size = UDim2.new(1, 0, 0, 32)
        introHeading.TextSize = 23
        descriptionLabel.Text = ""
        entrySection.Position = UDim2.fromOffset(56, 52)
        entrySection.Size = UDim2.new(1, -60, 0, 112)
        keyInput.Size = UDim2.new(1, -94, 0, 48)
        keyInput.TextSize = 14
        actions.Position = UDim2.new(1, -82, 0, 0)
        actions.Size = UDim2.fromOffset(82, 48)
        verifyButton.Size = UDim2.fromScale(1, 1)
        verifyButton.TextSize = 12
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 58)
        statusLabel.Size = UDim2.new(1, 0, 0, 50)
        footerLabel.Text = "SL / 输入卡密，开启此刻。"
        footerLabel.Position = UDim2.fromOffset(0, 178)
        footerLabel.Size = UDim2.new(1, -4, 0, 28)
        scroll.CanvasSize = UDim2.fromOffset(0, 214)
    elseif ribbon then
        scroll.Position = UDim2.fromOffset(86, 24)
        scroll.Size = UDim2.new(1, -106, 1, -44)
        introSection.Size = UDim2.new(1, -4, 0, 100)
        introHeading.Text = "开启专属脚本"
        introHeading.Position = UDim2.fromOffset(0, 0)
        introHeading.Size = UDim2.new(1, 0, 0, 36)
        introHeading.TextSize = 22
        descriptionLabel.Text = "输入你的卡密，完成本次访问授权。"
        descriptionLabel.Position = UDim2.fromOffset(0, 48)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 48)
        entrySection.Position = UDim2.fromOffset(0, 116)
        entrySection.Size = UDim2.new(1, -4, 0, 230)
        stepLabel.Position = UDim2.fromOffset(0, 0)
        stepLabel.Size = UDim2.new(1, 0, 0, 22)
        keyInput.Position = UDim2.fromOffset(0, 32)
        keyInput.Size = UDim2.new(1, 0, 0, 50)
        actions.Position = UDim2.fromOffset(0, 96)
        actions.Size = UDim2.new(1, 0, 0, 48)
        verifyButton.Size = UDim2.fromScale(1, 1)
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 156)
        statusLabel.Size = UDim2.new(1, 0, 0, 74)
        footerLabel.Text = "SL / 专属授权"
        footerLabel.Position = UDim2.fromOffset(0, 364)
        scroll.CanvasSize = UDim2.fromOffset(0, 408)
    elseif steps then
        scroll.Position = UDim2.fromOffset(20, 78)
        scroll.Size = UDim2.new(1, -40, 1, -94)
        introSection.Size = UDim2.new(1, -4, 0, 78)
        introHeading.Text = "连接你的授权"
        introHeading.Position = UDim2.fromOffset(0, 0)
        introHeading.Size = UDim2.new(1, 0, 0, 32)
        introHeading.TextSize = 23
        descriptionLabel.Text = "输入卡密，验证通过后开启脚本。"
        descriptionLabel.Position = UDim2.fromOffset(0, 42)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 32)
        entrySection.Position = UDim2.fromOffset(0, 92)
        entrySection.Size = UDim2.new(1, -4, 0, 108)
        keyInput.Size = UDim2.new(1, -112, 0, 52)
        actions.Position = UDim2.new(1, -102, 0, 0)
        actions.Size = UDim2.fromOffset(102, 52)
        verifyButton.Size = UDim2.fromScale(1, 1)
        verifyButton.TextSize = 13
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 62)
        statusLabel.Size = UDim2.new(1, 0, 0, 46)
        footerLabel.Text = "SL / 输入 · 验证 · 开启"
        footerLabel.Position = UDim2.fromOffset(0, 214)
        footerLabel.Size = UDim2.new(1, -4, 0, 28)
        scroll.CanvasSize = UDim2.fromOffset(0, 250)
    elseif passport then
        scroll.Position = UDim2.fromOffset(22, 24)
        scroll.Size = UDim2.new(1, -44, 1, -40)
        introSection.Size = UDim2.new(1, -4, 0, 138)
        introHeading.Text = "脚本通行证"
        introHeading.Position = UDim2.fromOffset(0, 58)
        introHeading.Size = UDim2.new(1, 0, 0, 32)
        introHeading.TextSize = 24
        descriptionLabel.Text = "输入卡密，解锁本次访问。"
        descriptionLabel.Position = UDim2.fromOffset(0, 100)
        descriptionLabel.Size = UDim2.new(1, 0, 0, 28)
        passDivider.Position = UDim2.fromOffset(0, 148)
        passDivider.Size = UDim2.new(1, -4, 0, 1)
        entrySection.Position = UDim2.fromOffset(0, 168)
        entrySection.Size = UDim2.new(1, -4, 0, 190)
        stepLabel.Position = UDim2.fromOffset(0, 0)
        stepLabel.Size = UDim2.new(1, 0, 0, 22)
        keyInput.Position = UDim2.fromOffset(0, 30)
        keyInput.Size = UDim2.new(1, 0, 0, 50)
        statusLabel.Position = UDim2.fromOffset(0, 98)
        statusLabel.Size = UDim2.new(0.45, -8, 0, 84)
        actions.Position = UDim2.new(0.45, 4, 0, 106)
        actions.Size = UDim2.new(0.55, -4, 0, 50)
        verifyButton.Size = UDim2.fromScale(1, 1)
        verifyButton.TextSize = 14
        clearButton.Visible = false
        footerLabel.Text = "SL / 授权通行凭证"
        footerLabel.Position = UDim2.fromOffset(0, 378)
        footerLabel.Size = UDim2.new(1, -4, 0, 28)
        scroll.CanvasSize = UDim2.fromOffset(0, 414)
    elseif compact then
        introSection.Size = UDim2.new(1, -20, 0, 32)
        introSection.Position = UDim2.fromOffset(8, 8)
        entrySection.BackgroundTransparency = 1
        entrySection.Position = UDim2.fromOffset(8, 56)
        entrySection.Size = UDim2.new(1, -20, 0, 206)
        keyInput.Size = UDim2.new(1, 0, 0, 52)
        actions.Position = UDim2.fromOffset(0, 66)
        actions.Size = UDim2.new(1, 0, 0, 48)
        verifyButton.Size = UDim2.fromScale(1, 1)
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 126)
        statusLabel.Size = UDim2.new(1, 0, 0, 72)
        footerLabel.Text = "限时授权从首次验证成功开始计时。"
        footerLabel.Position = UDim2.fromOffset(8, 266)
        footerLabel.Size = UDim2.new(1, -20, 0, 32)
        scroll.CanvasSize = UDim2.fromOffset(0, 306)
    elseif terminal then
        introSection.Size = wide and UDim2.new(0.42, -12, 0, 266) or UDim2.new(1, -4, 0, 120)
        introHeading.Position = UDim2.fromOffset(12, 16)
        introHeading.Size = UDim2.new(1, -24, 0, 40)
        descriptionLabel.Position = UDim2.fromOffset(12, 68)
        descriptionLabel.Size = UDim2.new(1, -24, 1, -72)
        entrySection.Position = wide and UDim2.new(0.42, 0, 0, 8) or UDim2.fromOffset(8, 140)
        entrySection.Size = wide and UDim2.new(0.58, -8, 0, 258) or UDim2.new(1, -20, 0, 258)
        stepLabel.Position = UDim2.fromOffset(0, 0)
        stepLabel.Size = UDim2.new(1, 0, 0, 22)
        keyInput.Position = UDim2.fromOffset(0, 32)
        keyInput.Size = UDim2.new(1, 0, 0, 52)
        actions.Position = UDim2.fromOffset(0, 100)
        actions.Size = UDim2.new(1, 0, 0, 48)
        verifyButton.Size = UDim2.fromScale(1, 1)
        clearButton.Visible = false
        statusLabel.Position = UDim2.fromOffset(0, 164)
        statusLabel.Size = UDim2.new(1, 0, 0, 86)
        footerLabel.Text = "SL  /  每一次开启，都由你的授权连接。"
        footerLabel.Position = UDim2.fromOffset(12, wide and 284 or 414)
        scroll.CanvasSize = UDim2.fromOffset(0, wide and 336 or 466)
    end
    qqGroupButton.Visible = qqGroupNumber ~= ""
    qqGroupButton.BackgroundColor3 = colors.input
    qqGroupButton.TextColor3 = colors.text
    qqGroupButton.Text = "QQ群：" .. qqGroupNumber .. "  /  一键复制群聊"
    qqGroupButton.Position = UDim2.fromOffset(footerLabel.Position.X.Offset, footerLabel.Position.Y.Offset + footerLabel.Size.Y.Offset + 12)
    qqGroupButton.Size = UDim2.new(1, -8, 0, 44)
    if qqGroupNumber ~= "" then
        scroll.CanvasSize = UDim2.fromOffset(0, math.max(scroll.CanvasSize.Y.Offset, qqGroupButton.Position.Y.Offset + 56))
    end
    updateControls()
end

local function belowScreen()
    return UDim2.new(0.5, 0, 1, math.max(panel.AbsoluteSize.Y, panelMaxSize.Y) + 32)
end

local function stopLoading()
    stopTween(content)
    stopTween(loadingMask)
    stopTween(spinner)
    spinner.Rotation = 0
    loadingMask.GroupTransparency = 1
    loadingMask.Visible = false
    content.GroupTransparency = 0
end

local function showStatus(message, color)
    if not isOpen() then
        return
    end
    statusLabel.Text = message
    statusLabel.TextColor3 = color or colors.muted
end

local function fail(message)
    if not isOpen() then
        return
    end
    state = "ready"
    verified = false
    announcementAccepted = false
    payloadStarted = false
    executionCommitted = false
    payloadTicket = nil
    payloadSource = nil
    for _, name in ipairs({ "intro", "verify", "success", "config", "layout", "failure", "verifyTimeout" }) do
        cancelTask(name)
    end
    stopLoading()
    stopTween(panelScale)
    panelScale.Scale = 1
    panel.GroupTransparency = 0
    introLabel.Visible = false
    announcementPanel.Visible = false
    stopTween(panelConstraint)
    panelConstraint.MaxSize = panelMaxSize
    stopTween(panel)
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    panel.Position = panelPosition
    playerCardStarted = true
    playerCardProgress.Value = 1
    panel.Visible = true
    updateControls()
    showStatus(message, colors.error)
    scroll.CanvasPosition = Vector2.new(0, entrySection.Position.Y.Offset + statusLabel.Position.Y.Offset)
    launch("failure", function()
        for _, offset in ipairs({ -5, 5, -3, 3, 0 }) do
            if not isOpen() then
                return
            end
            if not waitTween(animate(panel, 0.04, {
                Position = UDim2.new(panelPosition.X.Scale, panelPosition.X.Offset + offset,
                    panelPosition.Y.Scale, panelPosition.Y.Offset),
            })) then
                return
            end
        end
    end)
end

local function showExecutionCard()
    local cardName = GUI_NAME .. "_Authorization"
    local previous = playerGui:FindFirstChild(cardName)
    if previous then previous:Destroy() end
    local cardGui = create("ScreenGui", {
        Name = cardName,
        ResetOnSpawn = false,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        DisplayOrder = 90,
    }, playerGui)
    local surface = create("Frame", {
        Size = UDim2.fromScale(1, 1),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    }, cardGui)
    local card = create("Frame", {
        Position = UDim2.fromOffset(-252, 12),
        Size = UDim2.new(1, -24, 0, 64),
        BackgroundColor3 = colors.panel,
        BorderSizePixel = 0,
        Active = true,
        ClipsDescendants = true,
    }, surface)
    create("UISizeConstraint", { MaxSize = Vector2.new(220, 64) }, card)
    round(card, 11)
    create("UIStroke", { Color = colors.input, Thickness = 1 }, card)
    local avatar = create("ImageLabel", {
        Position = UDim2.fromOffset(10, 12),
        Size = UDim2.fromOffset(40, 40),
        BackgroundColor3 = colors.input,
        BorderSizePixel = 0,
        Image = playerAvatar.Image,
    }, card)
    round(avatar, 9)
    create("TextLabel", {
        Position = UDim2.fromOffset(60, 8),
        Size = UDim2.new(1, -70, 0, 20),
        BackgroundTransparency = 1,
        Text = player.Name,
        TextColor3 = colors.text,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextTruncate = Enum.TextTruncate.AtEnd,
        Font = Enum.Font.GothamBold,
        TextSize = 12,
    }, card)
    create("TextLabel", {
        Position = UDim2.fromOffset(60, 30),
        Size = UDim2.new(1, -70, 0, 26),
        BackgroundTransparency = 1,
        Text = authorizedExpiresAt and ("到期：" .. authorizedExpiresAt) or "永久有效",
        TextColor3 = colors.muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        TextWrapped = true,
        Font = Enum.Font.Gotham,
        TextSize = 10,
    }, card)
    local inputService = game:GetService("UserInputService")
    local cardConnections = {}
    local heldInput
    local dragging = false
    local holdTask
    local startPointer
    local startPosition
    local entranceComplete = false
    local entrance = TweenService:Create(card,
        TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out),
        { Position = UDim2.fromOffset(12, 12) })
    local function listen(signal, callback)
        cardConnections[#cardConnections + 1] = signal:Connect(callback)
    end
    local function stopHold()
        heldInput = nil
        dragging = false
        if holdTask and coroutine.status(holdTask) ~= "dead" then task.cancel(holdTask) end
        holdTask = nil
    end
    local function moveTo(x, y)
        local maxX = math.max(0, surface.AbsoluteSize.X - card.AbsoluteSize.X)
        local maxY = math.max(0, surface.AbsoluteSize.Y - card.AbsoluteSize.Y)
        card.Position = UDim2.fromOffset(math.clamp(x, 0, maxX), math.clamp(y, 0, maxY))
    end
    listen(card.InputBegan, function(input)
        if not entranceComplete or heldInput then return end
        if input.UserInputType ~= Enum.UserInputType.MouseButton1
            and input.UserInputType ~= Enum.UserInputType.Touch then return end
        heldInput = input
        startPointer = input.Position
        startPosition = card.Position
        holdTask = task.defer(function()
            task.wait(0.4)
            if cardGui.Parent and heldInput == input then dragging = true end
            holdTask = nil
        end)
    end)
    listen(inputService.InputChanged, function(input)
        if not heldInput then return end
        local touch = heldInput.UserInputType == Enum.UserInputType.Touch
        if (touch and input ~= heldInput)
            or (not touch and input.UserInputType ~= Enum.UserInputType.MouseMovement) then return end
        local dx = input.Position.X - startPointer.X
        local dy = input.Position.Y - startPointer.Y
        if not dragging then
            if math.abs(dx) > 10 or math.abs(dy) > 10 then stopHold() end
            return
        end
        moveTo(startPosition.X.Offset + dx, startPosition.Y.Offset + dy)
    end)
    listen(inputService.InputEnded, function(input)
        if input == heldInput or (heldInput and heldInput.UserInputType == Enum.UserInputType.MouseButton1
            and input.UserInputType == Enum.UserInputType.MouseButton1) then stopHold() end
    end)
    listen(inputService.WindowFocusReleased, stopHold)
    listen(surface:GetPropertyChangedSignal("AbsoluteSize"), function()
        if entranceComplete then
            stopHold()
            moveTo(card.Position.X.Offset, card.Position.Y.Offset)
        end
    end)
    listen(cardGui.Destroying, function()
        stopHold()
        entrance:Cancel()
        for _, connection in ipairs(cardConnections) do connection:Disconnect() end
        table.clear(cardConnections)
    end)
    entrance:Play()
    task.defer(function()
        if entrance.Completed:Wait() == Enum.PlaybackState.Completed and cardGui.Parent then
            entranceComplete = true
            moveTo(card.Position.X.Offset, card.Position.Y.Offset)
        end
    end)
    if avatar.Image == "" then
        task.defer(function()
            local ok, image = pcall(function()
                return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
            end)
            if ok and cardGui.Parent and type(image) == "string" then avatar.Image = image end
        end)
    end
    return cardGui
end

local function claimAndExecute()
    if not isOpen() or not verified or not announcementAccepted or state ~= "announcementOut" or payloadStarted then
        return
    end
    payloadStarted = true
    state = "payload"
    if REQUIRES_PAYLOAD then
        local received, source = pcall(function()
            local response = requestFunction({
                Url = VERIFY_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json", ["Accept"] = "application/json" },
                Body = HttpService:JSONEncode({ script_id = SCRIPT_ID, action = "payload", ticket = payloadTicket }),
                Timeout = 15,
            })
            if not isOpen() or state ~= "payload" or type(response) ~= "table" then
                return nil
            end
            local statusCode = tonumber(response.StatusCode or response.Status or response.status_code)
            if not statusCode or statusCode < 200 or statusCode >= 300
                or type(response.Body or response.body) ~= "string" then
                return nil
            end
            local result = HttpService:JSONDecode(response.Body or response.body)
            if type(result) ~= "table" or result.success ~= true or result.code ~= "payload"
                or type(result.source) ~= "string" or result.source == "" or not utf8.len(result.source) then
                return nil
            end
            return result.source
        end)
        payloadTicket = nil
        if not isOpen() or state ~= "payload" then
            source = nil
            return
        end
        if not received or type(source) ~= "string" then
            source = nil
            fail("执行授权已失效或脚本领取失败，请重新验证后继续。")
            return
        end
        payloadSource = source
        source = nil
    end
    if not isOpen() or state ~= "payload" then
        return
    end
    local executeSource = payloadSource
    payloadSource = nil
    payloadTicket = nil
    state = "complete"
    executionCommitted = true
    tasks.success = nil
    gui:Destroy()
    if REQUIRES_PAYLOAD and executeSource then
        task.defer(function()
            if not executionCommitted then
                executeSource = nil
                return
            end
            executionCommitted = false
            if type(loadstring) ~= "function" then
                executeSource = nil
                warn("验证成功，但当前执行环境不支持编译原脚本。")
                return
            end
            local compiled, runSource = pcall(loadstring, executeSource, "SL-" .. SCRIPT_ID)
            executeSource = nil
            if not compiled or type(runSource) ~= "function" then
                runSource = nil
                warn("原脚本编译失败，本次加载已结束。")
                return
            end
            local cardOk, authorizationCard = pcall(showExecutionCard)
            if not cardOk then
                authorizationCard = nil
                warn("授权卡片暂不可用，脚本继续执行。")
            end
            local succeeded, runtimeError = pcall(runSource, table.unpack(originalArguments, 1, originalArguments.n))
            runSource = nil
            if not succeeded then
                if authorizationCard and authorizationCard.Parent then authorizationCard:Destroy() end
                warn("脚本执行失败：" .. tostring(runtimeError))
            end
        end)
    else
        local cardOk = pcall(showExecutionCard)
        if not cardOk then warn("授权卡片暂不可用。") end
    end
end

local function acceptAnnouncement()
    if not isOpen() or state ~= "announcement" or announcementAccepted then
        return
    end
    announcementAccepted = true
    state = "announcementOut"
    acknowledgeButton.Active = false
    launch("success", function()
        if not waitTween(animate(announcementPanel, 0.25, { GroupTransparency = 1 })) then
            return
        end
        announcementPanel.Visible = false
        claimAndExecute()
    end)
end

local function finishVerification(announcement, ticket, announcementEnabled)
    if not isOpen() or state ~= "verifying" or verified then
        return
    end
    if REQUIRES_PAYLOAD then
        if type(ticket) ~= "string" or #ticket ~= 64 or not ticket:match("^[0-9a-fA-F]+$") then
            ticket = nil
            stopLoading()
            fail("未取得有效的执行授权，请重新验证。")
            return
        end
        payloadTicket = ticket
    end
    ticket = nil
    verified = true
    state = "exiting"
    stopLoading()
    updateControls()
    launch("success", function()
        panel.AnchorPoint = Vector2.new(0.5, 0.5)
        panel.Position = panelPosition
        if not waitTween(animate(playerCardProgress, 0.4, { Value = 0 }, 0, Enum.EasingStyle.Quint)) then
            return
        end
        playerCardStarted = false
        playerCard.Visible = false
        if not isOpen() or state ~= "exiting" then return end
        if not waitTween(animate(panel, 0.45, { Position = belowScreen() }, 0, Enum.EasingStyle.Quint)) then
            return
        end
        panel.Visible = false
        RunService.RenderStepped:Wait()
        if not isOpen() or state ~= "exiting" then
            return
        end
        if not announcementEnabled then
            announcementAccepted = true
            state = "announcementOut"
            claimAndExecute()
            return
        end
        state = "announcementIn"
        announcementBody.Text = type(announcement) == "string" and announcement ~= "" and announcement
            or "授权验证成功。阅读完成后，关闭公告即可继续。"
        announcement = nil
        announcementScroll.CanvasPosition = Vector2.zero
        announcementCountdown.Text = ""
        announcementPanel.Visible = true
        if not waitTween(animate(announcementPanel, 0.25, { GroupTransparency = 0 })) then
            return
        end
        if not isOpen() or state ~= "announcementIn" then
            return
        end
        state = "announcement"
        acknowledgeButton.Active = true
        announcementCountdown.Text = REQUIRES_PAYLOAD and "阅读公告后，点击下方按钮继续运行脚本。" or "阅读完成后，点击下方按钮关闭公告。"
    end)
end

local fallbackMessages = {
    invalid = IS_WHITELIST and "当前账号不在白名单中，请联系商家。" or "卡密无效，请检查后重试。",
    expired = IS_WHITELIST and "白名单授权已过期。" or "卡密已过期。",
    disabled = "授权或脚本已停用。",
    rate_limit = "请求过于频繁，请稍后重试。",
}

local function verify()
    if not isOpen() or state ~= "ready" or verified then
        return
    end
    if not requestFunction then
        fail("当前运行环境不支持 request、http_request 或 syn.request，无法联网验证。")
        return
    end
    if not SCRIPT_ID:match("^[0-9a-fA-F]+$") or #SCRIPT_ID ~= 32
        or not VERIFY_URL:lower():match("^https?://") then
        fail("验证配置尚未生成，请从网站重新下载此文件。")
        return
    end
    local key = IS_WHITELIST and "" or keyInput.Text:match("^%s*(.-)%s*$")
    local keyLength = utf8.len(key)
    if not keyLength or keyLength > 128 then
        key = nil
        fail("卡密需为有效文本，且不能超过 128 字符。")
        return
    end
    if pendingLayout then
        applyLayout()
    end
    state = "verifying"
    cancelTask("layout")
    cancelTask("failure")
    local verificationStarted = os.clock()
    stopTween(panelConstraint)
    panelConstraint.MaxSize = panelMaxSize
    panel.AnchorPoint = Vector2.new(0.5, 0.5)
    stopTween(content)
    keyInput:ReleaseFocus()
    stopTween(panel)
    panel.Position = panelPosition
    stopTween(inputOutline)
    inputOutline.Transparency = 1
    updateControls()
    showStatus("正在连接验证服务，请稍候。")
    animate(content, 0.4, { GroupTransparency = 0.6 })
    loadingMask.GroupTransparency = 1
    loadingMask.Visible = true
    animate(loadingMask, 0.4, { GroupTransparency = 0 })
    spinner.Rotation = 0
    animate(spinner, 0.9, { Rotation = 360 }, -1, Enum.EasingStyle.Linear)
    local encoded, body = pcall(function()
        if IS_WHITELIST then
            return HttpService:JSONEncode({ script_id = SCRIPT_ID, username = player.Name, system = "whitelist" })
        end
        return HttpService:JSONEncode({ script_id = SCRIPT_ID, key = key })
    end)
    key = nil
    if not encoded then
        body = nil
        fail("无法生成验证请求，请检查输入后重试。")
        return
    end
    launch("verifyTimeout", function()
        task.wait(15)
        if isOpen() and state == "verifying" then
            fail("验证请求超时，请检查网络后重试。")
        end
    end)
    local networkOk, response = pcall(requestFunction, {
        Url = VERIFY_URL,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json", ["Accept"] = "application/json" },
        Body = body,
        Timeout = 15,
    })
    body = nil
    cancelTask("verifyTimeout")
    local remaining = 3 - (os.clock() - verificationStarted)
    if remaining > 0 then
        task.wait(remaining)
    end
    if not isOpen() or state ~= "verifying" then
        response = nil
        return
    end
    stopLoading()
    if not networkOk then
        response = nil
        warn("验证网络请求失败或超时。")
        fail("网络请求失败或超时，请检查网络后重新验证。")
        return
    end
    if type(response) ~= "table" or type(response.Body or response.body) ~= "string" then
        response = nil
        fail("验证服务返回了无法识别的响应。")
        return
    end
    local decoded, result = pcall(function()
        return HttpService:JSONDecode(response.Body or response.body)
    end)
    if not decoded or type(result) ~= "table" or type(result.success) ~= "boolean" or type(result.code) ~= "string" then
        response = nil
        result = nil
        fail("验证服务返回格式错误。")
        return
    end
    local statusCode = tonumber(response.StatusCode or response.Status or response.status_code)
    response = nil
    if not statusCode or statusCode < 200 or statusCode >= 300 then
        result = nil
        warn("验证服务 HTTP 请求失败。")
        fail("验证服务请求失败，请稍后重新验证。")
        return
    end
    if result.success and result.code == "valid" then
        if type(result.announcement_enabled) ~= "boolean" then
            result = nil
            fail("公告配置无效，请联系商家更新站点后重新验证。")
            return
        end
        if not IS_WHITELIST then
            keyInput.Text = ""
        end
        authorizedExpiresAt = type(result.expires_at) == "string" and result.expires_at ~= "" and result.expires_at or nil
        local message = "验证成功。"
        if type(result.expires_at) == "string" and result.expires_at ~= "" then
            message = message .. "\n有效期至：" .. result.expires_at
        end
        showStatus(message, colors.success)
        finishVerification(result.announcement, result.payload_ticket, result.announcement_enabled)
        result = nil
        return
    end
    local message = fallbackMessages[result.code] or "验证失败，请稍后重试。"
    if not result.success and type(result.message) == "string" and result.message ~= "" then
        message = result.message
    end
    result = nil
    fail(message)
end

local function startVerification()
    if not isOpen() or state ~= "ready" or verified or tasks.verify then
        return
    end
    launch("verify", function()
        local ok = pcall(verify)
        if not ok and isOpen() and state == "verifying" then
            fail("验证处理失败，请重新验证；如仍失败，请更新执行环境。")
        end
    end)
end

local function queueLayout()
    pendingLayout = true
    if state == "intro" then
        applyLayout()
    elseif state == "ready" and not tasks.layout then
        launch("layout", function()
            if not isOpen() or state ~= "ready" then
                return
            end
            if not waitTween(animate(content, 0.1, { GroupTransparency = 1 })) then
                return
            end
            if state ~= "ready" then
                return
            end
            applyLayout()
            waitTween(animate(content, 0.2, { GroupTransparency = 0 }))
        end)
    end
end

for _, button in ipairs({ verifyButton, clearButton, acknowledgeButton }) do
    local scale = create("UIScale", { Scale = 1 }, button)
    local function baseColor()
        return button == clearButton and colors.input or colors.primary
    end
    local function allowed()
        return isOpen() and button.Active and ((button == acknowledgeButton and state == "announcement") or state == "ready")
    end
    connect(button.MouseEnter, function()
        if allowed() then
            animate(button, 0.12, { BackgroundColor3 = baseColor():Lerp(colors.text, 0.12) })
        end
    end)
    connect(button.MouseButton1Down, function()
        if allowed() then
            animate(scale, 0.08, { Scale = 0.96 })
        end
    end)
    connect(button.MouseButton1Up, function()
        animate(scale, 0.08, { Scale = 1 })
    end)
    connect(button.MouseLeave, function()
        animate(scale, 0.08, { Scale = 1 })
        animate(button, 0.12, { BackgroundColor3 = baseColor() })
    end)
end
connect(qqGroupButton.Activated, function()
    if not isOpen() or qqGroupNumber == "" then
        return
    end
    local copy = type(setclipboard) == "function" and setclipboard
        or (type(toclipboard) == "function" and toclipboard or nil)
    if copy and pcall(copy, qqGroupNumber) then
        qqGroupButton.Text = "QQ群：" .. qqGroupNumber .. "  /  已复制"
    else
        qqGroupButton.Text = "请手动复制群号：" .. qqGroupNumber
    end
end)
connect(verifyButton.Activated, startVerification)
connect(clearButton.Activated, function()
    if isOpen() and state == "ready" and not IS_WHITELIST then
        keyInput.Text = ""
        showStatus("已清空，请重新输入卡密。")
    end
end)
connect(keyInput.Focused, function()
    if isOpen() and state == "ready" and not IS_WHITELIST then
        animate(inputOutline, 0.15, { Transparency = 0 })
    end
end)
connect(keyInput.FocusLost, function(enterPressed)
    animate(inputOutline, 0.15, { Transparency = 1 })
    if enterPressed and not IS_WHITELIST then
        startVerification()
    end
end)
connect(keyInput:GetPropertyChangedSignal("Text"), function()
    if not isOpen() or IS_WHITELIST or state ~= "ready" then
        return
    end
    local length = utf8.len(keyInput.Text)
    if not length or length > 128 then
        showStatus("卡密需为有效文本，且不能超过 128 字符。", colors.error)
    end
end)
connect(acknowledgeButton.Activated, acceptAnnouncement)
connect(overlay:GetPropertyChangedSignal("AbsoluteSize"), queueLayout)
connect(gui.Destroying, function()
    closed = true
    if state ~= "complete" then
        executionCommitted = false
    end
    state = "closed"
    payloadTicket = nil
    payloadSource = nil
    for _, connection in ipairs(connections) do
        connection:Disconnect()
    end
    for _, tween in pairs(tweens) do
        tween:Cancel()
    end
    local currentThread = coroutine.running()
    for _, thread in pairs(tasks) do
        if thread ~= currentThread and coroutine.status(thread) ~= "dead" then
            task.cancel(thread)
        end
    end
    table.clear(connections)
    table.clear(tweens)
    table.clear(tasks)
    keyInput.Text = ""
end)

local function updatePlayerCard()
    if not isOpen() then return end
    playerCard.Visible = panel.Visible and playerCardStarted
    playerCard.GroupTransparency = panel.GroupTransparency
    local left = panel.Position.X.Offset - panel.AbsoluteSize.X * panelScale.Scale / 2
    playerCard.Position = UDim2.new(panel.Position.X.Scale,
        left + playerCardWidth / 2 - (playerCardWidth + playerCardGap) * playerCardProgress.Value,
        panel.Position.Y.Scale, panel.Position.Y.Offset)
end
connect(playerCardProgress:GetPropertyChangedSignal("Value"), updatePlayerCard)
connect(panel:GetPropertyChangedSignal("Position"), updatePlayerCard)
connect(panel:GetPropertyChangedSignal("AbsoluteSize"), updatePlayerCard)
connect(panel:GetPropertyChangedSignal("Visible"), updatePlayerCard)
connect(panel:GetPropertyChangedSignal("GroupTransparency"), updatePlayerCard)
connect(panelScale:GetPropertyChangedSignal("Scale"), updatePlayerCard)
launch("avatar", function()
    local ok, image = pcall(function()
        return Players:GetUserThumbnailAsync(player.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
    end)
    if ok and isOpen() and type(image) == "string" then playerAvatar.Image = image end
end)
applyLayout()
updatePlayerCard()
updateControls()
if not requestFunction then
    fail("当前运行环境不支持 request、http_request 或 syn.request，无法联网验证。")
elseif not SCRIPT_ID:match("^[0-9a-fA-F]+$") or #SCRIPT_ID ~= 32
    or not VERIFY_URL:lower():match("^https?://") then
    fail("验证配置尚未生成，请从网站重新下载此文件。")
else
    launch("config", function()
        local networkOk, response = pcall(function()
            return requestFunction({
                Url = VERIFY_URL,
                Method = "POST",
                Headers = { ["Content-Type"] = "application/json", ["Accept"] = "application/json" },
                Body = HttpService:JSONEncode({ script_id = SCRIPT_ID, action = "config" }),
                Timeout = 15,
            })
        end)
        if not isOpen() or verified then
            response = nil
            return
        end
        if networkOk and type(response) == "table" and type(response.Body or response.body) == "string" then
            local statusCode = tonumber(response.StatusCode or response.Status or response.status_code)
            local decoded, result = pcall(function()
                return HttpService:JSONDecode(response.Body or response.body)
            end)
            if decoded and type(result) == "table" and result.success == true and result.code == "config"
                and statusCode and statusCode >= 200 and statusCode < 300 and layouts[result.layout] then
                qqGroupNumber = type(result.qq_group_number) == "string" and #result.qq_group_number >= 5
                    and #result.qq_group_number <= 12 and result.qq_group_number:match("^[1-9][0-9]+$")
                    and result.qq_group_number or ""
                nextLayout = result.layout
                queueLayout()
            end
            result = nil
        end
        response = nil
    end)
    launch("intro", function()
        if not waitTween(animate(introLabel, 0.5, { TextTransparency = 0 })) then
            return
        end
        task.wait(0.25)
        if not isOpen() or state ~= "intro" then
            return
        end
        if not waitTween(animate(introLabel, 0.4, { TextTransparency = 1 })) then
            return
        end
        introLabel.Visible = false
        state = "entering"
        applyLayout(true)
        panel.Position = belowScreen()
        panel.Visible = true
        if not waitTween(animate(panel, 0.4, { Position = panelPosition })) then
            return
        end
        if not isOpen() or state ~= "entering" then
            return
        end
        while pendingLayout and isOpen() and state == "entering" do
            applyLayout(true)
            if not waitTween(animate(panel, 0.2, { Position = panelPosition })) then
                return
            end
        end
        if not isOpen() or state ~= "entering" then
            return
        end
        playerCardStarted = true
        updatePlayerCard()
        if not waitTween(animate(playerCardProgress, 0.45, { Value = 1 }, 0, Enum.EasingStyle.Quint)) then
            return
        end
        state = "ready"
        updateControls()
        if IS_WHITELIST then
            startVerification()
        end
    end)
end
