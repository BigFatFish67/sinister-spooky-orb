
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Chat = game:GetService("Chat")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/JsYb666/UI/refs/heads/main/Wind%20lib.txt"))()

local Window = WindUI:CreateWindow({
    Folder = "DeepSeek-HUB",
    SideBarWidth = 0.5,
    Title = "大肥鱼HUB自动翻译器",
    Transparent = true,
    Theme = "Dark",
    Author = "大肥鱼定制版",
    Icon = "languages",
    Size = UDim2.fromOffset(300, 300),
})

Window:EditOpenButton({
    StrokeThickness = 2,
    Title = "打开",
    Color = ColorSequence.new(Color3.fromHex("00D1FF"), Color3.fromHex("FF6B9D")),
    Draggable = true,
    Icon = "globe",
    CornerRadius = UDim.new(0, 12),
})

local translationEnabled = false
local translationSpeed = 2
local translatedTexts = {}
local heartbeatConnection = nil

local function translateText(text)
    if not text or text == "" or #text < 2 then
        return nil
    end
    
    if translatedTexts[text] then
        return translatedTexts[text]
    end
    
    local success, result = pcall(function()
        local url = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=auto&tl=zh-CN&dt=t&q=" .. HttpService:UrlEncode(text)
        local response = game:HttpGet(url)
        local decoded = HttpService:JSONDecode(response)
        if decoded and decoded[1] and decoded[1][1] and decoded[1][1][1] then
            return decoded[1][1][1]
        end
        return nil
    end)
    
    if success and result then
        translatedTexts[text] = result
        return result
    end
    
    return nil
end

local function isEnglish(text)
    if not text or text == "" then
        return false
    end
    local englishCount = 0
    local totalCount = 0
    for char in text:gmatch(".") do
        local byte = string.byte(char)
        if byte then
            totalCount = totalCount + 1
            if (byte >= 65 and byte <= 90) or (byte >= 97 and byte <= 122) then
                englishCount = englishCount + 1
            end
        end
    end
    if totalCount == 0 then
        return false
    end
    return (englishCount / totalCount) > 0.5
end

local function processTextObject(textObject)
    if not translationEnabled then
        return
    end
    
    if not textObject:IsA("TextLabel") and not textObject:IsA("TextButton") and not textObject:IsA("TextBox") then
        return
    end
    
    local originalText = textObject.Text
    if not originalText or originalText == "" then
        return
    end
    
    if not isEnglish(originalText) then
        return
    end
    
    local translatedText = translateText(originalText)
    if translatedText and translatedText ~= originalText then
        textObject.Text = translatedText
    end
end

local function scanAndTranslate(parent)
    if not translationEnabled then
        return
    end
    
    for _, descendant in pairs(parent:GetDescendants()) do
        if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
            task.spawn(function()
                processTextObject(descendant)
            end)
        end
    end
end

local function onDescendantAdded(descendant)
    if not translationEnabled then
        return
    end
    
    if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
        task.delay(0.1, function()
            processTextObject(descendant)
        end)
    end
end

local playerGuiConnection = nil
local coreGuiConnection = nil

local function startTranslation()
    if playerGuiConnection then
        playerGuiConnection:Disconnect()
    end
    if coreGuiConnection then
        coreGuiConnection:Disconnect()
    end
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
    end
    
    local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
    
    playerGuiConnection = PlayerGui.DescendantAdded:Connect(onDescendantAdded)
    coreGuiConnection = CoreGui.DescendantAdded:Connect(onDescendantAdded)
    
    local lastScanTime = tick()
    local scanInterval = 1.5 / translationSpeed
    
    heartbeatConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if not translationEnabled then
            return
        end
        
        local currentTime = tick()
        local timeSinceLastScan = currentTime - lastScanTime
        
        if timeSinceLastScan >= scanInterval then
            lastScanTime = currentTime
            
            task.spawn(function()
                scanAndTranslate(PlayerGui)
            end)
            
            pcall(function()
                for _, gui in pairs(CoreGui:GetChildren()) do
                    if gui:IsA("ScreenGui") then
                        task.spawn(function()
                            scanAndTranslate(gui)
                        end)
                    end
                end
            end)
        end
    end)
    
    scanAndTranslate(PlayerGui)
    
    pcall(function()
        for _, gui in pairs(CoreGui:GetChildren()) do
            if gui:IsA("ScreenGui") then
                scanAndTranslate(gui)
            end
        end
    end)
end

local function stopTranslation()
    if playerGuiConnection then
        playerGuiConnection:Disconnect()
        playerGuiConnection = nil
    end
    if coreGuiConnection then
        coreGuiConnection:Disconnect()
        coreGuiConnection = nil
    end
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

local Tab = Window:Tab({
    Title = "自动翻译",
    Icon = "languages",
})

Tab:Section({
    Title = "注意:请先加载此脚本开启翻译 再加载你需要翻译的脚本",
})

Tab:Section({
    Title = "小部分特殊UI无法翻译",
})

Tab:Toggle({
    Title = "启用自动翻译",
    Default = false,
    Callback = function(value)
        translationEnabled = value
        
        if translationEnabled then
            startTranslation()
        else
            stopTranslation()
        end
    end,
})

Tab:Slider({
    Title = "翻译速度",
    Value = {
        Min = 1,
        Default = 2,
        Max = 5,
    },
    Callback = function(value)
        translationSpeed = value
    end,
})

Tab:Button({
    Title = "官方群聊",
    Desc = "点击复制",
    Callback = function()
        if setclipboard then
            setclipboard("819503470")
        elseif toclipboard then
            toclipboard("819503470")
        end
    end,
})

Window:SelectTab(1)