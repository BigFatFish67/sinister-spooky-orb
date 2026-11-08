local Translations = {
    ["付费"] = "YV/TY",
    ["作者TY.TV"] = "TY/TV NB 讨口子哪他妈也能见到你",
}

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    if Translations[text] then return Translations[text] end
    for en, cn in pairs(Translations) do
        if text:find(en) then return text:gsub(en, cn) end
    end
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        setreadonly(getrawmetatable(game), true)
    end)
    if not success then
        warn("元表劫持失败:", err)
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local tText = translateText(text)
                            if tText ~= text then gui.Text = tText; translated[gui] = true end
                        end
                    end)
                end
            end
            local p = game:GetService("Players").LocalPlayer
            if p and p.PlayerGui then
                for _, gui in ipairs(p.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then gui.Text = translateText(text) end
                        end)
                    end
                end
            end
        end
        local function addListener(p)
            p.DescendantAdded:Connect(function(d)
                if d:IsA("TextLabel") or d:IsA("TextButton") or d:IsA("TextBox") then
                    task.wait(0.1); pcall(function() d.Text = translateText(d.Text) end)
                end
            end)
        end
        pcall(addListener, game:GetService("CoreGui"))
        local p = game:GetService("Players").LocalPlayer
        if p and p.PlayerGui then pcall(addListener, p.PlayerGui) end
        while true do scanAndTranslate(); task.wait(3) end
    end
end

task.wait(2)
setupTranslationEngine()

local s, e = pcall(function()
local HttpService = game:GetService("HttpService")
local fakeBody = HttpService:JSONEncode({success=true,remaining_days="9999",valid=true,message="激活成功"})
local originalRequest = syn and syn.request or http_request or request
if not originalRequest then error("No request function") end
local function hookedRequest(options)
    local url = options.Url or options.url or ""
    if type(url)=="string" and (url:find("km%.fly%-fly%.fun/api/v1/activate") or url:find("km%.fly%-fly%.fun/api/v1/verify")) then
        return {StatusCode=200,Body=fakeBody,Headers={}}
    end
    return originalRequest(options)
end
if syn then syn.request = hookedRequest end
if http_request then http_request = hookedRequest end
request = hookedRequest
local s = game:HttpGet("https://raw.githubusercontent.com/TY.TV-absb/ABSB/refs/heads/main/vvv444.lua")
loadstring(s)()
end)
if not s then warn("加载失败:", e) end
