-- 大肥鱼 Hub 定制版 v1.0
-- 作者：大肥鱼
-- 基于 Py Hub / 圣奥里 去混淆源码定制
-- 仅改作者署名与品牌文案，功能逻辑未改动
-- 大肥鱼 Hub

do
	local stubFalse = function()
		return false
	end
	local stubNoop = function()
	end
	if type(fn12) ~= "function" then
		fn12 = stubFalse
	end
	if type(fn13) ~= "function" then
		fn13 = stubFalse
	end
	if type(fn17) ~= "function" then
		fn17 = function()
			return "{}"
		end
	end
	if type(fn14) ~= "function" then
		fn14 = function(payload)
			return payload
		end
	end
	if type(fn21) ~= "function" then
		fn21 = stubNoop
	end
	if type(fn22) ~= "function" then
		fn22 = stubNoop
	end
	if type(fn23) ~= "function" then
		fn23 = stubNoop
	end
	if type(fn24) ~= "function" then
		fn24 = function()
			return true, { Body = "{}" }
		end
	end
	if type(fn25) ~= "function" then
		fn25 = function()
			return true
		end
	end
	if type(fn19) ~= "function" then
		fn19 = function(s)
			return s
		end
	end
	if type(handlers) ~= "table" then
		handlers = {}
	end
	placeId = placeId or game.PlaceId
	jobId = jobId or game.JobId
	c = c or 0
	if type(cloneref) == "function" then
		local clonerefRaw = cloneref
		cloneref = function(inst)
			if inst == nil then
				return nil
			end
			return clonerefRaw(inst)
		end
	elseif cloneref == nil then
		cloneref = function(inst)
			return inst
		end
	end
end

local DaFeiYuEntry = function(loaderUrl, nodeUrl, scriptId, scriptVersion, _unusedScriptKey, extraC, extraD, sigSq, sigRp, debugPrint, progressPrint, reportFunc)
	progressPrint = progressPrint or function(msg)
		return function()
		end
	end
	reportFunc = reportFunc or function()
	end
	debugPrint = debugPrint or function()
	end
		local v2 = progressPrint("正在初始化...")
	local tbl = { p = 40 }
	tbl.m = "\174yM\25\4q\210\162;\233)\184\230.~\171\229~\193T\17"
	reportFunc(tbl)
	local s = "\174)\197\28b\161\231\157za:\26\8\11'\20770lw\195\232\156S\234*\203XvJ\203n"
		local v3 = "\130`$\217\169?\140\0268\1442F^\218\207\232"

	if scriptId ~= s or scriptVersion ~= v3 then

	end

	local localPlayer = game:GetService("Players").LocalPlayer
	local concat = table.concat
	local sub = string.sub
	local byte = string.byte
	local char = string.char
	local lshift = bit32.lshift
	local rshift = bit32.rshift
	local band = bit32.band
	local bxor = bit32.bxor
	local rrotate = bit32.rrotate
	local bnot = bit32.bnot

	local cloneFunc = clonefunction or function(...) return ... end

	local v4 = cloneFunc(http and http.request or request or getfenv()["http" ])
	local v5 = cloneFunc(debug.traceback)
	local v6 = cloneFunc(debug.info)
	local v7 = cloneFunc(pcall)
	local v8 = cloneFunc(getfenv)
	local v9 = cloneFunc(tostring)
	local v10 = identifyexecutor()
	local v11 = v6(1, "f")
	local script = v8(0).script
	local n2 = #v5():split("\n") - 4
	v2()
		local v12 = progressPrint("正在检查运行环境...")

	local flag3 = fn12(concat) or fn12(sub) or fn12(byte) or fn12(char) or fn12(lshift) or fn12(rshift) or fn12(band) or fn12(bxor) or fn12(rrotate) or false
	if not flag3 then
	local find = table.find
	flag3 = fn12(v4) ~= find({ "Xeno", "Helios Mac" }, v10) ~= nil
	end

	flag3 = flag3 or false
	if flag3 or fn12(setmetatable) or fn12(v5) or fn12(v6) or fn12(v7) or fn12(task.wait) or fn12(math.floor, "fr") or fn12(math.random, "fr") or fn12(v8, "fr") then

	end

	if fn13(concat) or fn13(sub) or fn13(byte) or fn13(char) or fn13(lshift) or fn13(rshift) or fn13(band) or fn13(bxor) or fn13(rrotate) or fn13(bnot) or fn13(v4) or fn13(clonefunction) or fn13(setmetatable) or fn13(v5) or fn13(v6) or fn13(v7) or fn13(task.wait) or fn13(math.floor) or fn13(math.random) or fn13(v8) or fn13(v9) or fn13(identifyexecutor) then

	end

	if #v5():split("\n") ~= 4 + n2 then

	end

	if v6(1, "f") ~= v11 or v8(0).script ~= script then

	end

	-- 卡密 / 在线验证已移除：不再连接验证服务器或心跳
	v16 = ""
	k = nil
	i = 0
	e2 = ""
	c = c or 0
	v40 = nil
	reportFunc({ s = true })

	if v40 then
	v43()
	a = v40.a
	b = v40.b
	v = i
	d = v40.d
	f = v40.f
	flag2 = true
	g = v40.g
	u = v40.h.u
	d2 = v40.h.d
	a2 = v40.h.a
	b2 = v40.h.b
	p = v40.h.p
	else
	reportFunc({ s = true })
	end

	fn2 = function(arg11, arg12)
	local v43 = assert
	local flag8 = type(arg11) == "string"
	v43(flag8, "\229\235q!WBC2W6\155\247n%\222B\132`Q\171>+\174\175&\134\20\17G\215\229\7\163\227h\19\1\187\150\254\195\145\15\17\2389Z\164\252&\19\253\189\25l")
	local v44 = assert
	local flag9 = type(arg12) == "string"
	v44(flag9, "x\206P\234f\147-\201\209\215YS\174\223\129&0\128G\0\151\232M^\198\203|\187\249\2378\246J\2297\198\219\15\249+\176\r\165Y\229`Z\21\224\224\227\156\4\17\150\196")
	return "\20\160Q\200,X\246\171Zo92N" .. arg11 .. "\229r\132\155I\133\240\7nM\129" .. arg12 .. "\233\234<.\3\167E\137-\225H$M"
	end

	fn4 = function(arg11)
	local v43 = assert
	local flag8 = type(arg11) == "table"
	v43(flag8, "\246`0K\174\196\154q\250k7\12\197\215I-\243cn(\144/S?\184\188\8\183\132\167\175/%3\229Z\180\188y\159\\\195\191Y\133\148\185-{\150Z\139B%\162")
	local v44 = assert
	local flag9 = type(arg11.Url) == "string"
	v44(flag9, "\3D\6\225\214\1817g\214\211\6\21L^mk\229\238\172\242\179\130\224\201\127@7\155\131y\"\16\27iQr\173/\130T\132\213IqmO\135\191\252\242\146\208")

	if arg11["\137\23\138!\210\176\15"] == nil then
	local str6 = "\1271\"\218$+\145"
	arg11[str6] = {}
	end

	if arg11["\230IA\27t\199"] == nil then
	local str6 = "^\172[Q2\188"
	arg11[str6] = "GET"
	end

	local v45, v46, v47 = fn24(arg11, true, v6(1, "f"), #v5():split("\n") - (1 - 2 * (3875480235 + 1251298450 + 3463155907) % 4294967296) * (1 + ((5166075928 + 3423858664 + 3790215179 + bit32.band(6155 * 65535 + bit32.lshift(bit32.band(403367925 + 57834 * 65535, 65535), 16), 4294967295) % 4294967296) % 4294967296 * 67108864 + (1275608216 + 3019359080 + bit32.band(1293 * 0 + bit32.lshift(bit32.band(1293 * bit32.rshift(0, 16) + 8541 * 0, 65535), 16), 4294967295) % 4294967296) % 4294967296) / 4503599627370496) * 2 ^ ((2022214747 + 2332765280 + 4234955590) % 4294967296 - 1023))

	if not v45 then
	if v46 == ",M\223\183<\239" then
	return { success = false, reason = "request failed", error_message = v47 }
	end
	end

	if not v45 then
	return { success = false, reason = "tampering detected" }
	end
	return { success = true, response = v46 }
	end

	fn = function(arg11, arg12)
	local v43 = assert
	local flag8 = type(arg11) == "string"
	v43(flag8, "\215\153SL\193\138\210\129\242V\219PL/\177\170 \21\134\192z\131\208a\192\21\157\2498\15\25\"0\200\190\23\182\230\245\178\r\151\148\159\234\179l\201\190\198\2169\22\238[\216")
	local v44 = assert
	local flag9 = type(arg12) == "table"
	v44(flag9, "\207\225\158\250\2223YLu\17\239\210\190\242r\216qiml\189Ntg\198V1\170\244\145r\5\128\0\1289/\196\182\237\201N3H\193qc\255\207\165z\129\25L\218")
	local v45 = fn4
	local Settings = {}
	local v46 = nodeUrl
	Settings.Url = v46 .. "\167+q\187\248\2118\190\247\148\11\255\4\242\167\2511Z\198\156\128\31\167u"
	Settings.Method = "\191i\6\2"
	Settings.Body = fn17({ d = v14(fn17({ u = arg11, d = fn17(arg12), s = s }), v16), c = c })
	local headers = {}
	local str6 = "\2348\150-\206\251\\B\14\181\228\150"
	headers[str6] = "\219KZ*\202\197\183\20\199\220\159\21\205~3="
	Settings.Headers = headers
	local v47 = v45(Settings)
	if not v47.success then
	return { success = false, fail_reason = v47.reason }
	end

	local v48, v49 = v7(function()
	local v48 = v15
	local response = v47.response
	local v49 = v48(response["\8p\205\203"], v16)
	return nil
	end)

	if not v48 then
	local tbl10 = { success = false }
	tbl10.fail_reason = "S\183|v\192\177\27TAn\235\212\159\237"
	return tbl10
	end

	if not v49.success then
	return { success = false, fail_reason = v49.reason }
	end
	return { success = true }
	end

	fn5 = function(arg11)
	local v43 = assert
	local flag8 = type(arg11) == "string"
	v43(flag8, ";\226e\175@j\r!\8<\196E\178\215VO\180\169\12\2231':u\190\179\202\154^\213tVQ6e2\211\199\132S\223D\211A\"F\n\r\161\221\210<\23")
	end

	fn3 = function(arg11, arg12)
	local v43 = assert
	local flag8 = type(arg11) == "string"
	v43(flag8, ":\174;?),\151\205-\190\209\n\214\239\189\18\253lp~\4\186\144\16N:M\202\172\147w\178\29\144?\241W\31a\22\191\204\202\197\236\144r\255\244\174\132]\252\135\182\185K7$\186\"\207\239S=")
	local v44 = assert
	local flag9 = type(arg12) == "function"
	v44(flag9, "\251\179q\174\127}\172M\209\207\230L\196\176\216\193\207\240$@\200L(\251G\200e\201\1340\1\226\179\\\253\155\199`1\193l\160\245\134.4\166\43\146\214R\176\14\248Tt\161\165\136\188t7\216\210`\249")
	handlers[arg11] = arg12
	end

	do
	local Players = game:GetService("Players")
	local ReplicatedStorage = game:GetService("ReplicatedStorage")
	localPlayer2 = Players.LocalPlayer

	pcall(function()
	local antiCheat = ReplicatedStorage:FindFirstChild("AntiCheat", true)

	if antiCheat and type(antiCheat) == "table" then
	for k2, v35 in pairs(antiCheat) do
	if type(v35) == "function" then
	antiCheat[k2] = function(...)
	local ok, result = pcall(v35, ...)
	if ok then
	return result
	end
	return true
	end
	end
	end
	end
	end)

	pcall(function()
	local Ratchet = require(ReplicatedStorage:FindFirstChild("Ratchet", true))
	local Sha256 = require(ReplicatedStorage:FindFirstChild("Sha256", true))
	local v35 = getmetatable(Ratchet)

	if v35 and v35.__index and not v35.__index.__patched then
	v35.__index.catchUp = function(arg11, arg12)
	while arg11.index < arg12 do
	arg11:advance()
	end

	return true
	end

	v35.__index.respond = function(arg11, arg12)
	return Sha256("resp|" .. tostring(arg11.state) .. "|" .. tostring(arg11.index) .. "|" .. tostring(arg12))
	end

	v35.__index.__patched = true
	end
	end)
	end

	if hookmetamethod and newcclosure then
	local v27 = nil

	local function fn38(...)
		local arg11, arg12, arg13, arg14, arg15, descendant = ...
		descendant = descendant or arg11
		if arg11 == game and (arg12 == "GetService" or arg12 == "getService") then
	return function(arg13, arg14)
	if arg14 == "InsertService" or arg14 == "Selection" or arg14 == "Stats" then
	return nil
	end
	return v27(arg11, arg14)
	end
	end

	return v27(arg11, arg12)
	end

	v27 = hookmetamethod
	v27 = v27(game, "__index", newcclosure(fn38))
	end

	local Players, ReplicatedStorage, RunService, localPlayer3, fn38, fn39, fn40, lib, tbl8, fn41
	local fn42, v27, connection, flag8, v28, fn43, Settings, fn44, fn45, textButton
	local flag9, flag10, fn46, fn47, fn48, fn49, tbl10, fn50, tbl11, tbl12
	local tbl13, tbl14, tbl15, fn51, tbl16, tbl17, fn52, fn53, PoliceSettings, fn54
	local MovementSettings, fn55, fn56, fn57, fn58, flag11, getSpeedLimitAtPos, fn59

	do
	local FlyState, fn60

	do
	local UserInputService, GuiService, ContextActionService, HttpService, Workspace, signal, fn61, v29, remote, playerEvent, playerFunc, tbl21, fn62, fn63, fn64, fn65, tbl22, connection2, Character, Core, module, fn66, v30, tbl23, connection3, screenGui, connection4, udim2, fn67, fn68, fn69, activate, activateServer, namecall, charPivotTo, notify, fn70, fn71, fn72, fn73, fn74, fn75, fn76, fn77, fn78, fn79, fn80, fn81, fn82, tbl24, fn83, fn84, fn85, n10, circle, fn86, circle2, line, tbl25, tbl26, fn87, fn88, fn89, fn90, tbl27, fn91, tbl28, fn92, fn93, fn94, thread, v31, controls, fn95, fn96, fn97, fn98, fn99, cloneFunc0, cloneFunc1, cloneFunc2, cloneFunc3

	if hookmetamethod and newcclosure and getnamecallmethod then
	do
	local v32 = nil

	local function cloneFunc4(arg11, ...)
	local v33 = table.pack(...)
	local v34 = getnamecallmethod()
	if v34 == "Kick" and arg11 == localPlayer2 then
	return
	end
	local v35

	if v34 == "FireServer" and arg11.Name == "PlayerEvent" then
	local v36 = ({ ... })[1]
	if v36 == "char2" or v36 == "coreGame" or v36 == "vehicleTrack" or v36 == "platform" or v36 == "messageDeliver" or v36 == "runOverVictim" or v36 == "DEBUG2" or v36 == "chatCommand" or v36 == "controlsGuide" then
	return
	end

	if v34 == "InvokeServer" and arg11.Name == "PlayerFunc" then
	local tbl29 = { table.unpack(v33, 1, v33.n) }
	v35 = tbl29[1]
	local flag12 = v35 == "getPlayerData" or v35 == "getPlayerBanHistory"
	local flag13 = flag12 or v35 == "getPlayerInGame"
	local flag14 = flag13 or v35 == "getPlayerServerEncounters"
	local flag15 = flag14 or v35 == "getSecret"
	if flag15 then
	return true
	end
	end
	else
	if not (v34 == "InvokeServer" and arg11.Name == "PlayerFunc") then
	return v32(arg11, ...)
	end
	v35 = ({ ... })[1]
	if v35 == "getPlayerData" or v35 == "getPlayerBanHistory" or v35 == "getPlayerInGame" or v35 == "getPlayerServerEncounters" or v35 == "getSecret" then
	return true
	end
	end

	return v32(arg11, table.unpack(v33, 1, v33.n))
	end

	v32 = hookmetamethod
	v32 = v32(game, "__namecall", newcclosure(cloneFunc4))
	end

	Players = game:GetService("Players")
	ReplicatedStorage = game:GetService("ReplicatedStorage")
	RunService = game:GetService("RunService")
	UserInputService = game:GetService("UserInputService")
	GuiService = game:GetService("GuiService")
	ContextActionService = game:GetService("ContextActionService")
	HttpService = game:GetService("HttpService")
	Workspace = game:GetService("Workspace")
	localPlayer3 = Players.LocalPlayer

	if not localPlayer3 then
	signal = Players:GetPropertyChangedSignal("LocalPlayer")
	signal:Wait()
	localPlayer3 = Players.LocalPlayer
	end

	fn61 = function()
	local hui = nil

	pcall(function()
	if type(gethui) == "function" then
	hui = gethui()
	end
	end)

	if hui then
	return hui
	end

	pcall(function()
	hui = game:FindService("CoreGui")
	end)

	if hui then
	return hui
	end

	pcall(function()
	hui = localPlayer3:WaitForChild("PlayerGui", 5)
	end)

	if hui then
	return hui
	end

	pcall(function()
	hui = localPlayer3:FindFirstChild("PlayerGui")
	end)

	return hui
	end

	v29 = fn61()
	remote = ReplicatedStorage:WaitForChild("Remote", 30)
	playerEvent = remote and remote:WaitForChild("PlayerEvent", 30)
	playerFunc = remote and remote:WaitForChild("PlayerFunc", 30)

	local function ensureMinimapCursor(root)
	if not root then
	return
	end
	local minimap = root.Name == "Minimap" and root or root:FindFirstChild("Minimap", true)
	if not minimap or not minimap:IsA("Frame") or minimap:FindFirstChild("Cursor") then
	return
	end
	local cursor = Instance.new("ImageLabel")
	cursor.Name = "Cursor"
	cursor.BackgroundTransparency = 1
	cursor.ImageTransparency = 1
	cursor.AnchorPoint = Vector2.new(0.5, 0.5)
	cursor.Position = UDim2.fromScale(0.5, 0.5)
	cursor.Size = UDim2.fromOffset(10, 10)
	cursor.ZIndex = minimap.ZIndex + 1
	cursor.Parent = minimap
	end

	task.spawn(function()
	local playerGui = localPlayer3:FindFirstChild("PlayerGui") or localPlayer3:WaitForChild("PlayerGui", 10)
	ensureMinimapCursor(playerGui)
	if playerGui then
	playerGui.DescendantAdded:Connect(function(descendant)
	if descendant.Name == "Minimap" then
	task.defer(ensureMinimapCursor, descendant)
	end
	end)
	end
	end)

	tbl21 = {
	["红色"] = Color3.fromRGB(255, 0, 0),
	["黄色"] = Color3.fromRGB(255, 255, 0),
	["绿色"] = Color3.fromRGB(0, 255, 0),
	["蓝色"] = Color3.fromRGB(0, 150, 255),
	["紫色"] = Color3.fromRGB(150, 0, 255),
	["白色"] = Color3.fromRGB(255, 255, 255),
	["黑色"] = Color3.fromRGB(0, 0, 0),
	["青色"] = Color3.fromRGB(0, 255, 255),
	["橙色"] = Color3.fromRGB(255, 165, 0),
	["粉色"] = Color3.fromRGB(255, 105, 180),
	}

	fn38 = function(arg11)
	local n11 = arg11 or 5
	return Color3.fromHSV(tick() % n11 / n11, 1, 1)
	end

	fn39 = function(arg11)
	if arg11 == "彩虹色" then
	return fn38(5)
	end
	return tbl21[arg11] or Color3.fromRGB(255, 0, 0)
	end

	fn40 = function(arg11)
	arg11 = arg11 or localPlayer3
	local seen = {}
	local list = {}
	local function add(model)
	if model and typeof(model) == "Instance" and model:IsA("Model") and not seen[model] then
	seen[model] = true
	table.insert(list, model)
	end
	end
	pcall(function()
	add(arg11.Character)
	end)
	pcall(function()
	local charactersFolder = Workspace:FindFirstChild("Characters")
	if charactersFolder then
	add(charactersFolder:FindFirstChild(arg11.Name))
	end
	end)
	for _, character in ipairs(list) do
	local humanoid = character:FindFirstChildOfClass("Humanoid") or character:FindFirstChild("Humanoid", true)
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	or character:FindFirstChild("Torso")
	or character:FindFirstChild("UpperTorso")
	or (humanoid and humanoid.RootPart)
	if not humanoidRootPart then
	humanoidRootPart = character.PrimaryPart or character:FindFirstChildWhichIsA("BasePart")
	end
	if humanoidRootPart then
	return character, humanoid, humanoidRootPart
	end
	end
	end

	fn62 = function(arg11)
	local _, v33 = fn40(arg11)
	return v33 ~= nil and v33.Health > 0
	end

	fn63 = function(arg11)
	return arg11 and arg11.Team and arg11.Team.Name or "Civilian"
	end

	fn64 = function()
	local v32, v33 = fn40(localPlayer3)
	if not v32 or not v33 then
	return
	end
	local tool = v32:FindFirstChildOfClass("Tool")
	if tool then
	return tool
	end
	local backpack = localPlayer3:FindFirstChild("Backpack")
	if not backpack then
	return
	end

	for _, child in ipairs(backpack:GetChildren()) do
	if child:IsA("Tool") then
	v33:EquipTool(child)
	task.wait(0.1)
	return v32:FindFirstChildOfClass("Tool")
	end
	end
	end

	if hookfunction and Font and Font.new then
		local fontNew = Font.new
		pcall(function()
			hookfunction(fontNew, function(family, weight, style)
				local ok, result = pcall(fontNew, family, weight, style)
				if ok then
					return result
				end
				weight = weight or Enum.FontWeight.Medium
				style = style or Enum.FontStyle.Normal
				ok, result = pcall(fontNew, Enum.Font.GothamMedium, weight, style)
				if ok then
					return result
				end
				return Font.fromEnum(Enum.Font.GothamMedium)
			end)
		end)
	end
	local windUiSrc = game:HttpGet("https://raw.githubusercontent.com/123fa98/Xi_Pro/refs/heads/main/UI.lua")
	lib = loadstring(windUiSrc)()
	if not lib then
		warn("[大肥鱼 Hub] WindUI 加载失败，请检查网络或 HttpGet")
		return
	end

	tbl8 = {
	randomBg = true,
	borderColor = nil,
	isBorderRainbow = true,
	borderEnabled = false,
	}

	fn65 = function()
	local ok, result = pcall(function()
	return readfile("DaFeiYu_Settings.txt")
	end)

	if ok and result then
	local ok2, result2 = pcall(function()
	return HttpService:JSONDecode(result)
	end)

	if ok2 and type(result2) == "table" then
	for k2, v32 in pairs(result2) do
	tbl8[k2] = v32
	end
	end
	end
	end

	fn41 = function()
	pcall(function()
	writefile("DaFeiYu_Settings.txt", HttpService:JSONEncode(tbl8))
	end)
	end

	tbl22 = {
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	"https://raw.githubusercontent.com/PYHub/assets/main/bg.jpg",
	}

	fn42 = function()
	if not tbl8.randomBg or #tbl22 == 0 then
	return ""
	end
	return tbl22[math.random(1, #tbl22)]
	end

	v27 = nil
	connection = nil
	connection2 = nil
	flag8 = false
	v28 = nil

	fn43 = function(color, arg11)
	local main = v27 and v27.UIElements and v27.UIElements.Main
	if not main then
	return
	end
	local mainBorder = main:FindFirstChild("MainBorder")
	if not mainBorder then
	return
	end
	local borderGradient = mainBorder:FindFirstChild("BorderGradient")
	if not borderGradient then
	return
	end
	mainBorder.Enabled = tbl8.borderEnabled

	if connection2 then
	connection2:Disconnect()
	connection2 = nil
	end

	if arg11 then
	local colorSequence = ColorSequence.new
	local tbl29 = {}
	local v32 = ColorSequenceKeypoint.new(0, Color3.fromHex("FF0000"))
	local v33 = ColorSequenceKeypoint.new(0.16, Color3.fromHex("FFA500"))
	local v34 = ColorSequenceKeypoint.new(0.33, Color3.fromHex("FFFF00"))
	local v35 = ColorSequenceKeypoint.new(0.5, Color3.fromHex("00FF00"))
	local v36 = ColorSequenceKeypoint.new(0.66, Color3.fromHex("0000FF"))
	local v37 = ColorSequenceKeypoint.new(0.83, Color3.fromHex("4B0082"))
	tbl29[1] = v32
	tbl29[2] = v33
	tbl29[3] = v34
	tbl29[4] = v35
	tbl29[5] = v36
	tbl29[6] = v37

	do
	local values = table.pack(ColorSequenceKeypoint.new(1, Color3.fromHex("EE82EE")))
	table.move(values, 1, values.n, 7, tbl29)
	end

	borderGradient.Color = colorSequence(tbl29)

	connection2 = RunService.Heartbeat:Connect(function()
	if borderGradient.Parent then
	borderGradient.Rotation = (borderGradient.Rotation + 1.5) % 360
	end
	end)

	tbl8.isBorderRainbow = true
	tbl8.borderColor = nil
	else
	color = color or Color3.new(1, 1, 1)
	mainBorder.Color = color
	borderGradient.Color = ColorSequence.new(color)
	borderGradient.Rotation = 0
	tbl8.isBorderRainbow = false
	tbl8.borderColor = nil
	end

	end

	Settings = {
	stamina = false,
	food = false,
	combatBlock = false,
	ghost = false,
	noRagdoll = false,
	noFallDamage = false,
	antiPrisonPull = false,
	autoMoney = false,
	infiniteAmmo = false,
	rapidFire = false,
	farmer = false,
	taxi = false,
	bus = false,
	autoMission = false,
	autoHack = false,
	golf = false,
	autoCuff = false,
	}

	Character = nil
	Core = nil
	module = nil

	pcall(function()
	local framework = localPlayer3:WaitForChild("PlayerScripts", 15):WaitForChild("Framework", 15)
	Character = require(framework:WaitForChild("Character", 15))
	Core = require(framework:WaitForChild("Core", 15))
	local inventory = framework.Character:FindFirstChild("Inventory")

	if inventory then
	module = require(inventory)
	end
	end)

	fn66 = function()
	RunService.Heartbeat:Connect(function()
	if Core then
	if Settings.stamina then
	pcall(function()
	Core.stamina = 100
	end)
	end

	if Settings.food then
	pcall(function()
	Core.food = 100
	end)
	end

	if Settings.rapidFire then
	pcall(fn44)
	end
	end

	if Settings.infiniteAmmo then
	local characters = Workspace:FindFirstChild("Characters") and Workspace.Characters:FindFirstChild(localPlayer3.Name)

	if characters then
	for _, child in ipairs(characters:GetChildren()) do
	local config = child:FindFirstChild("Config")

	if config then
	local ammo = config:FindFirstChild("Ammo")
	local totalAmmo = config:FindFirstChild("TotalAmmo")

	if ammo then
	ammo.Value = math.huge
	end

	if totalAmmo then
	totalAmmo.Value = math.huge
	end
	end
	end
	end
	end
	end)
	end

	fn44 = function()
	if not Settings.rapidFire or not getgc then
	return
	end

	for _, v32 in pairs(getgc(true)) do
	if type(v32) == "table" then
	if rawget(v32, "SHOOT_MODE") ~= nil then
	rawset(v32, "SHOOT_MODE", 2)
	end

	if rawget(v32, "RPM") ~= nil then
	rawset(v32, "RPM", math.huge)
	end
	end
	end
	end

	v30 = nil

	fn45 = function(combatBlock)
	Settings.combatBlock = combatBlock

	if combatBlock and not v30 and hookmetamethod and newcclosure then
	v30 = hookmetamethod(game, "__namecall", newcclosure(function(arg11, ...)
	local v32 = table.pack(...)
	local tbl29 = { ... }
	local v33 = getnamecallmethod()
	if Settings.combatBlock and v33 == "FireServer" and tbl29[1] == "combatMode" then
	return nil
	end
	return v30(arg11, table.unpack(v32, 1, v32.n))
	end))
	end
	end

	tbl23 = {}
	connection3 = nil
	screenGui = nil
	textButton = nil
	connection4 = nil
	flag9 = false
	flag10 = false
	udim2 = UDim2.new(0, 100, 0.5, -25)

	fn67 = function()
	for _, v32 in ipairs(tbl23) do
	pcall(function()
	v32:Disconnect()
	end)
	end

	tbl23 = {}
	end

	fn68 = function(arg11, arg12)
	if not arg11 then
	return
	end

	pcall(function()
	arg11:SetAttribute("Invisible", arg12 or nil)

	for _, descendant in ipairs(arg11:GetDescendants()) do
	if descendant:IsA("BasePart") and descendant.Name ~= "HumanoidRootPart" then
	descendant.LocalTransparencyModifier = arg12 and 0.55 or 0
	descendant.Material = arg12 and Enum.Material.ForceField or Enum.Material.SmoothPlastic
	elseif descendant:IsA("Decal") and descendant.Name == "face" then
	descendant.Transparency = arg12 and 0.55 or 0
	end
	end
	end)
	end

	fn69 = function()
	if not textButton then
	return
	end
	textButton.Text = Settings.ghost and "隐身: 开" or "隐身: 关"
	textButton.TextColor3 = Settings.ghost and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	end

	fn46 = function(ghost)
	Settings.ghost = ghost
	local character = localPlayer3.Character
	if not character then
	return
	end

	if ghost then
	pcall(function()
	local stuff = ReplicatedStorage:FindFirstChild("Stuff")
	local locations = stuff and stuff:FindFirstChild("Locations")
	locations = locations and locations:GetChildren()[1] or nil

	if playerFunc then
	playerFunc:InvokeServer("hideCharacterLocation", locations)
	end
	end)

	if module and module.canEquipSlot then
	pcall(function()
	module.canEquipSlot(true)
	end)
	end

	if Character and Character.lockHumanoidState then
	pcall(function()
	Character.lockHumanoidState("ghostMode", nil)
	end)
	end

	pcall(function()
	GuiService.TouchControlsEnabled = true
	ContextActionService:UnbindAction("LoadingGuiNoResetOnDeath")
	ContextActionService:UnbindAction("DisableCameraMovementNoResetOnDeath")
	end)

	if connection3 then
	connection3:Disconnect()
	end

	connection3 = RunService.RenderStepped:Connect(function()
	if Settings.ghost and localPlayer3.Character then
	end
	end)
	else
	if connection3 then
	connection3:Disconnect()
	connection3 = nil
	end

	pcall(function()
	if playerFunc then
	playerFunc:InvokeServer("hideCharacterLocation", false)
	end
	end)

	end

	end

	fn47 = function()
	if connection4 then
	connection4:Disconnect()
	connection4 = nil
	end

	if screenGui then
	screenGui:Destroy()
	screenGui = nil
	textButton = nil
	end
	end

	fn48 = function()
	if not flag10 then
	return
	end
	screenGui = Instance.new("ScreenGui")
	screenGui.Name = "GhostQuickSwitch"
	screenGui.ResetOnSpawn = false
	local v32 = screenGui
	local v33 = v29
	local v34

	if v29 then
	v34 = v33
	else
	v34 = nil
	end

	v32.Parent = v34
	textButton = Instance.new("TextButton")
	textButton.Size = UDim2.new(0, 80, 0, 35)
	textButton.Position = udim2
	textButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	textButton.BackgroundTransparency = 0.4
	textButton.BorderSizePixel = 0
	textButton.Font = Enum.Font.GothamSemibold
	textButton.TextSize = 12
	textButton.Parent = screenGui
	textButton.Active = not flag9
	textButton.Draggable = not flag9
	local uiCorner = Instance.new("UICorner")
	uiCorner.CornerRadius = UDim.new(0, 8)
	uiCorner.Parent = textButton
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Name = "RainbowStroke"
	uiStroke.Thickness = 1.5
	uiStroke.Parent = textButton

	connection4 = RunService.RenderStepped:Connect(function()
	if uiStroke.Parent then
	uiStroke.Color = fn38(5)
	end
	end)

	textButton.MouseButton1Click:Connect(function()
	end)

	textButton:GetPropertyChangedSignal("Position"):Connect(function()
	if not flag9 then
	udim2 = textButton.Position
	end
	end)
	end

	activate = nil
	activateServer = nil

	pcall(function()
	local Ragdoll = require(ReplicatedStorage.Modules.Ragdoll)
	activate = Ragdoll.activate
	activateServer = Ragdoll.activateServer

	Ragdoll.activate = function(arg11, arg12, arg13, ...)
	if Settings.noRagdoll and arg12 then
	return
	end
	local v32 = activate
	local v33 = table.pack(...)
	v33.n = 4 + v33.n - 1
	table.move(v33, 1, v33.n, 4, v33)
	v33[1] = arg11
	v33[2] = arg12
	v33[3] = arg13
	return v32(table.unpack(v33, 1, v33.n))
	end

	if activateServer then
	Ragdoll.activateServer = function(arg11, arg12, arg13, ...)
	if Settings.noRagdoll and arg12 then
	return
	end
	local v32 = activateServer
	local v33 = table.pack(...)
	v33.n = 4 + v33.n - 1
	table.move(v33, 1, v33.n, 4, v33)
	v33[1] = arg11
	v33[2] = arg12
	v33[3] = arg13
	return v32(table.unpack(v33, 1, v33.n))
	end
	end
	end)

	namecall = nil

	pcall(function()
	local v32 = getrawmetatable(game)
	namecall = v32.__namecall
	setreadonly(v32, false)

	v32.__namecall = newcclosure(function(arg11, ...)
	local v33 = table.pack(...)
	local tbl29 = { ... }
	local v34 = getnamecallmethod()
	if Settings.noFallDamage and v34 == "FireServer" and tostring(arg11) == "PlayerEvent" and tbl29[1] == "takeDamage" then
	return nil
	end
	return namecall(arg11, table.unpack(v33, 1, v33.n))
	end)

	setreadonly(v32, true)
	end)

	charPivotTo = nil
	notify = nil

	fn49 = function(antiPrisonPull)
	Settings.antiPrisonPull = antiPrisonPull

	pcall(function()
	local Algorithms = require(ReplicatedStorage.Modules.Algorithms)

	if antiPrisonPull and not charPivotTo then
	charPivotTo = Algorithms.charPivotTo

	Algorithms.charPivotTo = function()
	return nil
	end
	elseif not antiPrisonPull and charPivotTo then
	Algorithms.charPivotTo = charPivotTo
	charPivotTo = nil
	end
	end)

	pcall(function()
	if not Core then
	return
	end

	if antiPrisonPull and not notify then
	notify = Core.notify

	Core.notify = function(arg11)
	if arg11 and arg11.message and string.find(arg11.message, "You can't leave prison yet") then
	return nil
	end
	return notify(arg11)
	end
	elseif not antiPrisonPull and notify then
	Core.notify = notify
	notify = nil
	end
	end)
	end

	fn70 = function(arg11)
	if not arg11 or not arg11.Parent then
	return
	end
	local parent = arg11.Parent
	if parent:IsA("BasePart") then
	return parent.Position
	end

	if parent:IsA("Attachment") then
	return parent.WorldPosition
	end

	if parent:IsA("Model") then
	local primaryPart = parent.PrimaryPart or parent:FindFirstChildWhichIsA("BasePart")
	if primaryPart then
	return primaryPart.Position
	end
	end
	end

	fn71 = function(arg11)
	if not arg11 then
	return
	end

	pcall(function()
	if fireproximityprompt then
	fireproximityprompt(arg11, 0)
	else
	arg11.HoldDuration = 0
	arg11:InputHoldBegin()
	task.wait(0.1)
	arg11:InputHoldEnd()
	end
	end)
	end

	fn72 = function(arg11)
	local v32, v33, v34 = fn40(localPlayer3)
	if not v32 or not v34 or not arg11 then
	return
	end
	local cframe = CFrame.new(arg11 + Vector3.new(0, 3, 0))
	v32:PivotTo(cframe)

	pcall(function()
	if playerEvent then
	local n11 = ((v32:GetAttribute("CharPivotToId") or 0) + 1) % 100
	v32:SetAttribute("CharPivotToId", n11)
	playerEvent:FireServer("charPivotTo", cframe, v32, n11)
	end
	end)
	end

	fn73 = function()
	task.spawn(function()
	while true do
	if Settings.autoMoney then
	local v32, v33, v34 = fn40(localPlayer3)
	if v34 then
	local v35 = nil
	local v36 = nil

	for _, descendant in ipairs(Workspace:GetDescendants()) do
	local isProximityPrompt = descendant:IsA("ProximityPrompt")
	local flag12

	if isProximityPrompt then
	local promptName = descendant.Name
	local actionText = string.lower(tostring(descendant.ActionText or ""))
	local objectText = string.lower(tostring(descendant.ObjectText or ""))
	flag12 = promptName == "CashDrop"
	or promptName == "GetItem"
	or promptName == "Money"
	or actionText:find("pick", 1, true)
	or actionText:find("cash", 1, true)
	or actionText:find("collect", 1, true)
	or actionText:find("grab", 1, true)
	or objectText:find("cash", 1, true)
	or objectText:find("money", 1, true)
	else
	flag12 = isProximityPrompt
	end

	if flag12 then
	local v37 = fn70(descendant)
	if v37 then
	local magnitude = (v34.Position - v37).Magnitude

	if not v35 or magnitude < v35 then
	v35 = magnitude
	v36 = descendant
	continue
	end
	end
	end
	end

	if v36 and v35 and v35 < 120 then
	if v35 > 8 then
	fn72(fn70(v36))
	task.wait(0.3)
	end
	fn71(v36)
	end
	end
	end

	task.wait(0.3)
	end
	end)
	end

	tbl10 = {
	missionInterval = 2,
	priorityHighReward = false,
	taxiSafe = false,
	taxiDelayMode = "随机时间",
	taxiOrigin = nil,
	}

	fn74 = function()
	if not getgc then
	return
	end

	for _, v32 in pairs(getgc(true)) do
	if type(v32) == "table" and rawget(v32, "teamJobs") then
	return v32.teamJobs
	end
	end
	end

	fn75 = function()
	if localPlayer3:GetAttribute("Mission") then
	return true
	end
	local v32 = fn74()
	if v32 then
	for _, v33 in pairs(v32) do
	if v33.joined then
	return true
	end
	end
	end

	return false
	end

	fn76 = function()
	local v32 = fn74()
	if not v32 then
	return
	end
	local n11 = -math.huge
	local v33 = nil

	for k2, v34 in pairs(v32) do
	if not v34.joined then
	if not tbl10.priorityHighReward then
	return k2
	end
	local n12 = (v34.profitability or 1) * 1000000 + (v34.reward or 0)

	if n11 < n12 then
	n11 = n12
	v33 = k2
	end
	end
	end

	return v33
	end

	fn77 = function()
	task.spawn(function()
	while true do
	if Settings.autoMission and playerFunc and not fn75() then
	local v32 = fn76()
	if v32 then
	pcall(function()
	playerFunc:InvokeServer("talkToMission", tostring(v32) .. "join")
	end)
	end
	end

	task.wait(tbl10.missionInterval)
	end
	end)
	end

	fn78 = function()
	local gameplay = ReplicatedStorage:FindFirstChild("Gameplay")
	gameplay = gameplay and gameplay:FindFirstChild("Missions")
	gameplay = gameplay and gameplay:FindFirstChild("Active")

	if gameplay then
	for _, child in ipairs(gameplay:GetChildren()) do
	if child.Name:find("^Farmer") then
	for _, v32 in ipairs({ "DropOff", "Target", "Goal" }) do
	local v33 = child:FindFirstChild(v32)
	if v33 and v33:IsA("BasePart") then
	return v33.Position
	end

	if v33 and v33:IsA("ObjectValue") and v33.Value and v33.Value:IsA("BasePart") then
	return v33.Value.Position
	end
	end
	end
	end
	end
	end

	fn79 = function()
	task.spawn(function()
	while true do
	if Settings.farmer then
	local v32 = localPlayer3.Character and localPlayer3.Character:FindFirstChildOfClass("Tool")
	if v32 then
	task.wait(0.4)
	end

	local v33, v34, v35 = fn40(localPlayer3)
	if v35 then
	local v36 = nil
	local v37 = nil

	for _, descendant in ipairs(Workspace:GetDescendants()) do
	if descendant:IsA("ProximityPrompt") and descendant.ActionText == "Pick Up" then
	local v38 = fn70(descendant)
	if v38 then
	local magnitude = (v35.Position - v38).Magnitude

	if not v36 or magnitude < v36 then
	v36 = magnitude
	v37 = descendant
	continue
	end
	end
	end
	end

	if v37 then
	local pickPos = fn70(v37)
	if pickPos then
	local pickDist = (v35.Position - pickPos).Magnitude
	if pickDist > 8 then
	fn72(pickPos)
	task.wait(0.3)
	else
	fn71(v37)
	end
	end
	end
	end
	end

	task.wait(0.3)
	end
	end)
	end

	fn80 = function()
	task.spawn(function()
	local v32 = nil

	while true do
	if Settings.taxi then
	local gameplay = Workspace:FindFirstChild("Gameplay")
	gameplay = gameplay and gameplay:FindFirstChild("Entities")
	gameplay = gameplay and gameplay:FindFirstChild("ClientContent")

	if gameplay and gameplay:IsA("Model") then
		local primaryPart = gameplay.PrimaryPart or gameplay:FindFirstChildWhichIsA("BasePart")
		local v33, v34, v35 = fn40(localPlayer3)
		if primaryPart and v35 then
	local position = primaryPart.Position

	if v32 == nil or (position - v32).Magnitude > 5 then
	if tbl10.taxiSafe and tbl10.taxiOrigin then
	v35.CFrame = CFrame.new(tbl10.taxiOrigin)
	local magnitude = (tbl10.taxiOrigin - position).Magnitude
	local n11

	if tbl10.taxiDelayMode == "距离测算" then
	n11 = math.clamp(15 + (math.clamp(magnitude, 2000, 6000) - 2000) / 4000 * 30 + math.random() * 2 - 1, 15, 45)
	else
	n11 = magnitude > 2000 and math.random(15, 45) or 15
	end

	task.wait(n11)
	end

	v35.CFrame = CFrame.new(position)
	v32 = position
	end
	end
	end
	end

	task.wait(0.5)
	end
	end)
	end

	fn81 = function()
	local gameplay = Workspace:FindFirstChild("Gameplay")
	gameplay = gameplay and gameplay:FindFirstChild("Entities")
	gameplay = gameplay and gameplay:FindFirstChild("ClientContent")
	gameplay = gameplay and gameplay:GetChildren()[1]
	return gameplay and gameplay:FindFirstChild("Area")
	end

	fn82 = function()
	task.spawn(function()
	while true do
	if Settings.bus then
	local v32 = fn81()
	local v33, v34, v35 = fn40(localPlayer3)
	if v32 and v34 and v35 then
	local seatPart = v34.SeatPart

	if seatPart then
	local cFrame = v35.CFrame
	seatPart.CFrame = v32.CFrame * CFrame.new(17.5, 3, 6.5) * CFrame.Angles(0, 4.7123889803846897, 0) * cFrame:ToObjectSpace(seatPart.CFrame)
	seatPart.AssemblyLinearVelocity = Vector3.zero
	seatPart.AssemblyAngularVelocity = Vector3.zero
	task.wait(0.1)
	v34.Sit = false
	else
	v35.CFrame = v32.CFrame * CFrame.new(17.5, 3, 6.5) * CFrame.Angles(0, 4.7123889803846897, 0)
	end

	task.wait(5)
	end
	end

	task.wait(1)
	end
	end)
	end

	tbl24 = {}

	fn50 = function(autoHack)
	Settings.autoHack = autoHack

	pcall(function()
	local framework = localPlayer3.PlayerScripts:FindFirstChild("Framework")
	framework = framework and require(framework:FindFirstChild("Character"))
	local GameRules = require(ReplicatedStorage.Modules.GameRules)

	if GameRules then
	GameRules.disableHacking = autoHack
	GameRules.disableMinigames = autoHack
	end

	if framework then
	if not tbl24.hackingMinigame then
	tbl24.hackingMinigame = framework.hackingMinigame
	end

	if not tbl24.startMinigame then
	tbl24.startMinigame = framework.startMinigame
	end

	if autoHack then
	framework.hackingMinigame = function()
	return true
	end

	framework.startMinigame = function()
	return true
	end
	else
	if tbl24.hackingMinigame then
	framework.hackingMinigame = tbl24.hackingMinigame
	end

	if tbl24.startMinigame then
	framework.startMinigame = tbl24.startMinigame
	end
	end
	end
	end)
	end

	fn83 = function()
	task.spawn(function()
	local function cloneFunc4(arg11)
	local v32 = Workspace

	for _, v33 in ipairs(arg11) do
	v32 = v32 and v32:FindFirstChild(v33)
	if not v32 then
	return
	end
	end

	return v32
	end

	while true do
	if Settings.golf and playerFunc then
	pcall(function()
	playerFunc:InvokeServer("miniGolf", "createLobby")
	task.wait(0.1)
	playerFunc:InvokeServer("miniGolf", "setLobbyBid", { bid = 500 })
	task.wait(0.1)
	playerFunc:InvokeServer("miniGolf", "setLobbyReady")
	task.wait(4)
	playerFunc:InvokeServer("miniGolf", "shot")
	task.wait(0.5)
	local v32 = cloneFunc4({ "Gameplay", "Entities", "Content", localPlayer3.Name })
	local v33 = cloneFunc4({ "Gameplay", "Entities", "Content", "_Flag", "FlagPole", "Part" })

	if v32 and v33 and v32:IsA("BasePart") then
	v32.Position = v33.Position
	end
	end)
	end

	task.wait(Settings.golf and 5 or 1)
	end
	end)
	end

	tbl11 = {
	auraEnabled = false,
	auraRange = 50,
	auraDamage = 5,
	auraInterval = 0.05,
	auraOnlyPolice = false,
	auraOnlyCivilian = false,
	auraCombatCheck = false,
	bulletEnabled = false,
	bulletFov = 360,
	bulletDistance = 300,
	bulletPart = "Head",
	bulletShowFov = true,
	bulletColor = "红色",
	bulletCombatCheck = false,
	bulletOnlyPolice = false,
	bulletOnlyCivilian = false,
	}

	fn84 = function(arg11, arg12, arg13)
	if not arg11 or arg11 == localPlayer3 then
	return false
	end

	if arg12 then
	return arg11.Team and arg11.Team.Name == "Police"
	end

	if arg13 then
	return arg11.Team and arg11.Team.Name == "Civilian"
	end
	return true
	end

	fn85 = function(arg11, arg12)
	if not arg12 then
	return true
	end
	return arg11:GetAttribute("CombatMode") == true or arg11:GetAttribute("Pursuit") == true
	end

	n10 = 0

	RunService.Heartbeat:Connect(function()
	if not tbl11.auraEnabled or not playerEvent then
	return
	end
	local now = tick()
	if now - n10 < tbl11.auraInterval then
	return
	end
	local v32, v33, v34 = fn40(localPlayer3)
	if not v34 then
	return
	end
	local v35 = nil
	local v36 = nil

	for _, player in ipairs(Players:GetPlayers()) do
	if fn84(player, tbl11.auraOnlyPolice, tbl11.auraOnlyCivilian) and fn62(player) and fn85(player, tbl11.auraCombatCheck) then
	local char = player.Character
	local v39 = char and fn87(char)
	if v39 then
	local magnitude = (v39.Position - v34.Position).Magnitude

	if magnitude <= tbl11.auraRange and (not v36 or magnitude < v36) then
	v35 = player
	v36 = magnitude
	end
	end
	end
	end

	if v35 then
	local targetChar = v35.Character
	local v39 = targetChar and fn87(targetChar)
	local position = v34.Position
	if not v39 then
	return
	end

	pcall(function()
	playerEvent:FireServer("damage", {
	bodyParts = { { "Head", 1 } },
	shotCode = { position, (v39.Position - position).Unit },
	pos = v39.Position,
	target = v35,
	damageFactor = tbl11.auraDamage,
	bulletProofTool = false,
	})
	end)

	n10 = now
	end
	end)

	circle = Drawing.new("Circle")
	circle.Filled = false
	circle.NumSides = 64
	circle.Visible = false

	fn86 = function()
	local currentCamera = Workspace.CurrentCamera
	if not currentCamera then
	return
	end
	local vector2 = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
	local bulletFov = tbl11.bulletFov
	local position = nil

	for _, player in ipairs(Players:GetPlayers()) do
	if fn84(player, tbl11.bulletOnlyPolice, tbl11.bulletOnlyCivilian) and fn62(player) and fn85(player, tbl11.bulletCombatCheck) then
	local character = player.Character

	if character then
	character = character:FindFirstChild(tbl11.bulletPart) or character:FindFirstChild("HumanoidRootPart")
	end

	if character then
	if (character.Position - currentCamera.CFrame.Position).Magnitude <= tbl11.bulletDistance then
	local v32, v33 = currentCamera:WorldToScreenPoint(character.Position)

	if v33 and v32.Z > 0 then
	local magnitude = (Vector2.new(v32.X, v32.Y) - vector2).Magnitude

	if magnitude < bulletFov then
	position = character.Position
	bulletFov = magnitude
	end
	end
	end
	end
	end
	end

	return position
	end

	pcall(function()
	local raycast = Workspace.Raycast

	hookfunction(Workspace.Raycast, function(arg11, arg12, arg13, arg14)
	if tbl11.bulletEnabled and arg12 and arg13 then
	local _, _, v34 = fn40(localPlayer3)
	if v34 and (arg12 - v34.Position).Magnitude < 15 then
	local v35 = fn86()
	if v35 then
	arg13 = (v35 - arg12).Unit * arg13.Magnitude
	end
	end
	end

	return raycast(arg11, arg12, arg13, arg14)
	end)
	end)

	RunService.RenderStepped:Connect(function()
	local currentCamera = Workspace.CurrentCamera
	if not currentCamera then
	return
	end
	circle.Position = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
	circle.Radius = tbl11.bulletFov
	circle.Thickness = 2
	circle.Color = fn38(5)
	circle.Visible = tbl11.bulletEnabled and tbl11.bulletShowFov
	end)

	tbl12 = {
	enabled = false,
	prediction = false,
	teamCheck = false,
	wallCheck = false,
	showFov = false,
	showCrosshair = false,
	showTracer = false,
	friendCheck = false,
	onlyPolice = false,
	onlyCivilian = false,
	combatCheck = false,
	fov = 50,
	smoothness = 1,
	targetMode = "准心最近",
	targetPart = "头",
	color = "红色",
	fovThickness = 2,
	}

	circle2 = Drawing.new("Circle")
	circle2.Filled = false
	circle2.NumSides = 64
	line = Drawing.new("Line")

	tbl25 = {
	Top = Drawing.new("Line"),
	Bottom = Drawing.new("Line"),
	Left = Drawing.new("Line"),
	Right = Drawing.new("Line"),
	Center = Drawing.new("Line"),
	}

	for _, v32 in pairs(tbl25) do
	v32.Thickness = 2
	v32.Visible = false
	end

	tbl26 = {
	["头"] = { "Head" },
	["胸"] = { "UpperTorso", "Torso" },
	["左手"] = { "LeftHand", "Left Arm" },
	["右手"] = { "RightHand", "Right Arm" },
	["左腿"] = { "LeftFoot", "Left Leg" },
	["右腿"] = { "RightFoot", "Right Leg" },
	}

	fn87 = function(arg11)
	local v32 = ipairs
	local tbl29 = tbl26[tbl12.targetPart] or { "Head" }

	for _, v33 in v32(tbl29) do
	local v34 = arg11:FindFirstChild(v33)
	if v34 then
	return v34
	end
	end

	return arg11:FindFirstChild("HumanoidRootPart")
	end

	fn88 = function(arg11)
	if not tbl12.wallCheck then
	return true
	end
	local currentCamera = Workspace.CurrentCamera
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { localPlayer3.Character, currentCamera }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	raycastParams.IgnoreWater = true
	local hit = Workspace:Raycast(currentCamera.CFrame.Position, arg11.Position - currentCamera.CFrame.Position, raycastParams)
	return not hit or hit.Instance:IsDescendantOf(arg11.Parent)
	end

	fn89 = function()
	local currentCamera = Workspace.CurrentCamera
	if not currentCamera then
	return
	end
	local vector2 = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
	local v32 = nil
	local tbl29 = nil

	for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer3 and fn62(player) and fn84(player, tbl12.onlyPolice, tbl12.onlyCivilian) and fn85(player, tbl12.combatCheck) then
	if not (tbl12.teamCheck and localPlayer3.Team and player.Team == localPlayer3.Team) then
	if tbl12.friendCheck then
	local ok, result = pcall(function()
	return localPlayer3:IsFriendsWith(player.UserId)
	end)

	if ok and result then
	continue
	end
	end

			local character = player.Character
			if not character then
				continue
			end
			local v33 = fn87(character)
			local v34 = character:FindFirstChildOfClass("Humanoid")
			local v35 = character:FindFirstChild("HumanoidRootPart")
				or character:FindFirstChild("Torso")
				or character:FindFirstChild("UpperTorso")
			if v33 and v34 and v35 and v34.Health > 0 and fn88(v33) then
			local v36, v37 = currentCamera:WorldToViewportPoint(v33.Position)

			if v37 then
			local magnitude = (Vector2.new(v36.X, v36.Y) - vector2).Magnitude

			if magnitude <= tbl12.fov then
			if tbl12.targetMode == "距离最近" then
			local _, _, v40 = fn40(localPlayer3)
			magnitude = v40 and (v40.Position - v35.Position).Magnitude or math.huge
			elseif tbl12.targetMode == "血量最低" then
			magnitude = v34.Health
			end

			if not v32 or magnitude < v32 then
			tbl29 = { player = player, part = v33, screen = v36 }
			v32 = magnitude
			end
			end
			end
			end
	end
	end
	end

	return tbl29
	end

	RunService.RenderStepped:Connect(function(deltaTime)
	local currentCamera = Workspace.CurrentCamera
	if not currentCamera then
	return
	end
		local vector2 = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)
		local v32 = fn39(tbl12.color)
		circle2.Position = vector2
		circle2.Radius = tbl12.fov
		circle2.Thickness = tbl12.fovThickness
		circle2.Color = v32
		circle2.Visible = tbl12.enabled and tbl12.showFov
	tbl25.Top.From = Vector2.new(vector2.X, vector2.Y - 5)
	tbl25.Top.To = Vector2.new(vector2.X, vector2.Y - 5 - 15)
	tbl25.Bottom.From = Vector2.new(vector2.X, vector2.Y + 5)
	tbl25.Bottom.To = Vector2.new(vector2.X, vector2.Y + 5 + 15)
	tbl25.Left.From = Vector2.new(vector2.X - 5, vector2.Y)
	tbl25.Left.To = Vector2.new(vector2.X - 5 - 15, vector2.Y)
	tbl25.Right.From = Vector2.new(vector2.X + 5, vector2.Y)
	tbl25.Right.To = Vector2.new(vector2.X + 5 + 15, vector2.Y)
	tbl25.Center.From = Vector2.new(vector2.X - 2, vector2.Y)
	tbl25.Center.To = Vector2.new(vector2.X + 2, vector2.Y)

	for _, v33 in pairs(tbl25) do
	v33.Color = v32
	v33.Visible = tbl12.showCrosshair
	end

	line.Visible = false

		if tbl12.enabled then
		local v33 = fn89()
		if v33 then
	if tbl12.showTracer then
	line.From = vector2
	line.To = Vector2.new(v33.screen.X, v33.screen.Y)
	line.Color = v32
	line.Thickness = 2
	line.Transparency = 0.5
	line.Visible = true
	end

	local position = v33.part.Position

	if tbl12.prediction then
	position += v33.part.AssemblyLinearVelocity * deltaTime * 1.5
	end

	local cframe = CFrame.new(currentCamera.CFrame.Position, position)
	currentCamera.CFrame = tbl12.smoothness >= 1 and cframe or currentCamera.CFrame:Lerp(cframe, tbl12.smoothness)
	end
	end
	end)

	tbl13 = {
	enabled = false,
	range = 150,
	interval = 0.05,
	bodyPart = "Head",
	jobCheck = false,
	wallCheck = false,
	aliveCheck = false,
	combatCheck = false,
	policeLock = false,
	civilianLock = false,
	beam = false,
	}

	tbl14 = {
	["头部"] = "Head",
	["躯干"] = "Torso",
	["左臂"] = "LeftArm",
	["右臂"] = "RightArm",
	["左腿"] = "LeftLeg",
	["右腿"] = "RightLeg",
	}

	fn90 = function(position, position2)
	local part = Instance.new("Part")
	local part2 = Instance.new("Part")

	for _, v32 in ipairs({ part, part2 }) do
	v32.Anchored = true
	v32.CanCollide = false
	v32.Transparency = 1
	v32.Size = Vector3.new(0.1, 0.1, 0.1)
	v32.Parent = Workspace
	end

	part.Position = position
	part2.Position = position2
	local attachment = Instance.new("Attachment", part)
	local attachment2 = Instance.new("Attachment", part2)
	local beam = Instance.new("Beam", part)
	beam.Attachment0 = attachment
	beam.Attachment1 = attachment2
	beam.Width0 = 0.15
	beam.Width1 = 0.15
	beam.Color = ColorSequence.new(Color3.fromRGB(180, 200, 255))

	task.delay(0.8, function()
	pcall(function()
	part:Destroy()
	part2:Destroy()
	end)
	end)
	end

	task.spawn(function()
	while true do
	if tbl13.enabled and playerEvent then
	local v32, v33, v34 = fn40(localPlayer3)
	if v34 then
	local position = v34.Position
	local v35 = fn63(localPlayer3)
	for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer3 and fn84(player, tbl13.policeLock, tbl13.civilianLock) and fn85(player, tbl13.combatCheck) then
	local v36, v37, v38Part = fn40(player)
	local v38 = v36 and (v36:FindFirstChild(tbl13.bodyPart) or fn87(v36))
	if v36 and v37 and v38 and v37.Health > 0 then
	if tbl13.jobCheck and fn63(player) == v35 then
	continue
	end

	if (v38.Position - position).Magnitude <= tbl13.range then
	if tbl13.wallCheck then
	local raycastParams = RaycastParams.new()
	raycastParams.FilterDescendantsInstances = { localPlayer3.Character, Workspace.CurrentCamera }
	raycastParams.FilterType = Enum.RaycastFilterType.Exclude
	local hit = Workspace:Raycast(Workspace.CurrentCamera.CFrame.Position, v38.Position - Workspace.CurrentCamera.CFrame.Position, raycastParams)
	if hit and not hit.Instance:IsDescendantOf(v36) then
	continue
	end
	end

	pcall(function()
	playerEvent:FireServer("damage", {
	bodyParts = { { tbl13.bodyPart, 1 } },
	shotCode = { position, (v38.Position - position).Unit },
	pos = v38.Position,
	target = player,
	damageFactor = 1.5,
	bulletProofTool = false,
	})

	if tbl13.beam then
	end
	end)

	continue
	end
	end
	end
	end
	end
	end

	task.wait(tbl13.interval)
	end
	end)

	tbl15 = {
	active = false,
	size = 10,
	transparency = 0.7,
	teamCheck = false,
	color = "红色",
	material = "Neon",
	rainbow = false,
	checkCorpses = false,
	outline = false,
	collision = false,
	glow = false,
	pulse = false,
	affectNPC = false,
	}

	tbl27 = {}

	fn51 = function(arg11)
	arg11 = arg11 and arg11:FindFirstChild("HumanoidRootPart")
	if not arg11 then
	return
	end
	local v32 = tbl27[arg11]

	if v32 then
	arg11.Size = v32.Size
	arg11.Transparency = v32.Transparency
	arg11.Material = v32.Material
	arg11.CanCollide = v32.CanCollide
	arg11.Color = v32.Color
	end

	local pyHitboxHighlight = arg11:FindFirstChild("PY_HitboxHighlight")

	if pyHitboxHighlight then
	pyHitboxHighlight:Destroy()
	end

	local pyHitboxLight = arg11:FindFirstChild("PY_HitboxLight")

	if pyHitboxLight then
	pyHitboxLight:Destroy()
	end
	end

	fn91 = function(arg11)
	local humanoidRootPart = arg11 and arg11:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then
	return
	end

	if not tbl27[humanoidRootPart] then
	tbl27[humanoidRootPart] = {
	Size = humanoidRootPart.Size,
	Transparency = humanoidRootPart.Transparency,
	Material = humanoidRootPart.Material,
	CanCollide = humanoidRootPart.CanCollide,
	Color = humanoidRootPart.Color,
	}
	end

	if not tbl15.active then
	return
	end
	local humanoid = arg11:FindFirstChildOfClass("Humanoid")
	if tbl15.checkCorpses and humanoid and humanoid.Health <= 0 then
	return
	end
	local size = tbl15.size

	if tbl15.pulse then
	size *= math.sin(tick() * 2) * 0.2 + 1
	end

	humanoidRootPart.Size = Vector3.new(size, size, size)
	humanoidRootPart.Transparency = tbl15.transparency
	humanoidRootPart.Material = Enum.Material[tbl15.material] or Enum.Material.Neon
	humanoidRootPart.CanCollide = tbl15.collision
	humanoidRootPart.Color = tbl15.rainbow and fn38(5) or fn39(tbl15.color)
	if tbl15.outline then
	local pyHitboxHighlight = humanoidRootPart:FindFirstChild("PY_HitboxHighlight") or Instance.new("Highlight")
	pyHitboxHighlight.Name = "PY_HitboxHighlight"
	pyHitboxHighlight.FillTransparency = 1
	pyHitboxHighlight.OutlineColor = humanoidRootPart.Color
	pyHitboxHighlight.OutlineTransparency = tbl15.transparency
	pyHitboxHighlight.Parent = humanoidRootPart
	else
	local pyHitboxHighlight = humanoidRootPart:FindFirstChild("PY_HitboxHighlight")

	if pyHitboxHighlight then
	pyHitboxHighlight:Destroy()
	end
	end

	if tbl15.glow then
	local pyHitboxLight = humanoidRootPart:FindFirstChild("PY_HitboxLight") or Instance.new("PointLight")
	pyHitboxLight.Name = "PY_HitboxLight"
	pyHitboxLight.Brightness = 5
	pyHitboxLight.Range = 15
	pyHitboxLight.Color = humanoidRootPart.Color
	pyHitboxLight.Parent = humanoidRootPart
	else
	local pyHitboxLight = humanoidRootPart:FindFirstChild("PY_HitboxLight")

	if pyHitboxLight then
	pyHitboxLight:Destroy()
	end
	end
	end

	RunService.Heartbeat:Connect(function()
	for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer3 and fn40(player) then
	if tbl15.teamCheck and localPlayer3.Team and player.Team == localPlayer3.Team then
	continue
	end
	fn91(fn40(player))
	end
	end

	if tbl15.affectNPC then
	for _, descendant in ipairs(Workspace:GetDescendants()) do
	if descendant:IsA("Model") and descendant:FindFirstChildOfClass("Humanoid") and not Players:GetPlayerFromCharacter(descendant) then
	fn91(descendant)
	end
	end
	end
	end)

	tbl16 = {
	enabled = false,
	name = true,
	distance = true,
	health = true,
	highlight = true,
	tracer = false,
	tracerOrigin = "屏幕底部",
	showFugitive = true,
	selectedTeams = {
	Chef = true,
	Civilian = true,
	Delivery = true,
	Farmer = true,
	Fire = true,
	Police = true,
	Medical = true,
	Prisoner = true,
	["Road Service"] = true,
	Transit = true,
	},
	trackers = {},
	}

	tbl17 = {
	Chef = "厨师",
	Civilian = "平民",
	Delivery = "配送员",
	Farmer = "农民",
	Fire = "消防员",
	Police = "警察",
	Medical = "医护人员",
	Prisoner = "囚犯",
	["Road Service"] = "道路服务",
	Transit = "交通",
	}

	tbl28 = {
	Chef = Color3.fromRGB(255, 200, 0),
	Civilian = Color3.fromRGB(100, 200, 255),
	Delivery = Color3.fromRGB(255, 150, 50),
	Farmer = Color3.fromRGB(50, 200, 50),
	Fire = Color3.fromRGB(255, 50, 50),
	Police = Color3.fromRGB(50, 100, 255),
	Medical = Color3.fromRGB(255, 50, 255),
	Prisoner = Color3.fromRGB(255, 150, 150),
	["Road Service"] = Color3.fromRGB(255, 255, 100),
	Transit = Color3.fromRGB(100, 255, 255),
	}

	fn92 = function(arg11)
	local flag12 = arg11.Team and arg11.Team.Name == "Civilian"
	local attribute

	if flag12 then
	attribute = arg11:GetAttribute("CombatMode") or arg11:GetAttribute("Pursuit")
	else
	attribute = flag12
	end

	return attribute
	end

	fn93 = function(arg11)
	if not tbl16.enabled or arg11 == localPlayer3 then
	return false
	end
	if not fn40(arg11) then
	return false
	end

	if tbl16.showFugitive and fn92(arg11) then
	return true
	end

	local selectedCount = 0
	local totalCount = 0
	for _, selected in pairs(tbl16.selectedTeams) do
	totalCount += 1
	if selected then
	selectedCount += 1
	end
	end
	if selectedCount == 0 or selectedCount >= totalCount then
	return true
	end

	local name = arg11.Team and arg11.Team.Name
	if not name then
	return true
	end
	if tbl16.selectedTeams[name] == true then
	return true
	end
	for teamName, teamLabel in pairs(tbl17) do
	if (teamLabel == name or teamName == name) and tbl16.selectedTeams[teamName] then
	return true
	end
	end
	return false
	end

	fn52 = function(player)
	local v32 = tbl16.trackers[player]
	if not v32 then
	return
	end

	for _, v33 in pairs(v32) do
	pcall(function()
	if typeof(v33) == "RBXScriptConnection" then
	v33:Disconnect()
	elseif typeof(v33) == "Instance" then
	v33:Destroy()
	elseif type(v33) == "userdata" and v33.Remove then
	v33:Remove()
	end
	end)
	end

	tbl16.trackers[player] = nil
	end

	local function getEspHolder()
	local parent = v29 or fn61() or localPlayer3:FindFirstChild("PlayerGui")
	v29 = parent
	if not parent then
	return
	end
	local holder = parent:FindFirstChild("DaFeiYuESP")
	if holder then
	return holder
	end
	local ok, gui = pcall(function()
	local screenGui = Instance.new("ScreenGui")
	screenGui.Name = "DaFeiYuESP"
	screenGui.ResetOnSpawn = false
	screenGui.IgnoreGuiInset = true
	screenGui.DisplayOrder = 999
	screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	screenGui.Parent = parent
	return screenGui
	end)
	if ok then
	return gui
	end
	return parent
	end

	fn94 = function(arg11)
	if tbl16.trackers[arg11] or not fn93(arg11) then
	return
	end
	local character, _, humanoidRootPart = fn40(arg11)
	if not character or not humanoidRootPart then
	return
	end
	local holder = getEspHolder()
	if not holder then
	return
	end

	local billboardGui = Instance.new("BillboardGui")
	billboardGui.Name = "PlayerESP_" .. arg11.Name
	billboardGui.AlwaysOnTop = true
	billboardGui.Size = UDim2.new(8, 0, 3, 0)
	billboardGui.StudsOffset = Vector3.new(0, 3.5, 0)
	billboardGui.MaxDistance = 10000
	billboardGui.Adornee = humanoidRootPart
	billboardGui.Parent = holder
	local frame = Instance.new("Frame")
	frame.BackgroundTransparency = 1
	frame.Size = UDim2.fromScale(1, 1)
	frame.Parent = billboardGui
	local textLabel = Instance.new("TextLabel")
	textLabel.Size = UDim2.new(1, 0, 0.55, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Font = Enum.Font.GothamBold
	textLabel.TextSize = 16
	textLabel.TextStrokeTransparency = 0
	textLabel.Text = arg11.Name
	textLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
	textLabel.Parent = frame
	local textLabel2 = Instance.new("TextLabel")
	textLabel2.Size = UDim2.new(1, 0, 0.45, 0)
	textLabel2.Position = UDim2.new(0, 0, 0.55, 0)
	textLabel2.BackgroundTransparency = 1
	textLabel2.Font = Enum.Font.Gotham
	textLabel2.TextSize = 14
	textLabel2.TextStrokeTransparency = 0
	textLabel2.TextColor3 = Color3.fromRGB(0, 255, 0)
	textLabel2.Parent = frame
	local highlight = Instance.new("Highlight")
	highlight.Name = "PlayerESP_Highlight"
	highlight.Adornee = character
	highlight.FillTransparency = 0.65
	highlight.OutlineTransparency = 0
	pcall(function()
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	end)
	highlight.Parent = character
	pcall(function()
	billboardGui.Parent = humanoidRootPart
	end)
	if not billboardGui.Parent then
	billboardGui.Parent = holder
	end
	local line2
	pcall(function()
	if Drawing and Drawing.new then
	line2 = Drawing.new("Line")
	line2.Thickness = 1
	line2.Transparency = 0.5
	line2.Visible = false
	end
	end)

	tbl16.trackers[arg11] = {
	bill = billboardGui,
	highlight = highlight,
	tracer = line2,
	update = RunService.Heartbeat:Connect(function()
	local currentCharacter, targetHumanoid, currentRoot = fn40(arg11)
	if not fn93(arg11) or not currentCharacter or not currentRoot then
	if line2 then
	line2.Visible = false
	end
	if billboardGui.Parent then
	billboardGui.Enabled = false
	end
	return
	end

	humanoidRootPart = currentRoot
	billboardGui.Adornee = humanoidRootPart
	billboardGui.Enabled = true
	if highlight.Parent ~= currentCharacter then
	highlight.Parent = currentCharacter
	end
	highlight.Adornee = currentCharacter
	local showFugitive = fn92(arg11)
	local name = arg11.Team and arg11.Team.Name
	local color = showFugitive and Color3.fromRGB(255, 0, 0) or tbl28[name] or Color3.fromRGB(0, 255, 0)
	textLabel.Text = "[" .. (showFugitive and "逃犯" or tbl17[name] or name or "未知") .. "] " .. arg11.Name
	textLabel.TextColor3 = color
	textLabel.Visible = tbl16.name
	highlight.FillColor = color
	highlight.OutlineColor = color
	highlight.Enabled = tbl16.highlight
	local _, _, v38 = fn40(localPlayer3)
	local tbl29 = {}

	if tbl16.distance and v38 then
	table.insert(tbl29, string.format("%.1f", (v38.Position - humanoidRootPart.Position).Magnitude))
	end

	if tbl16.health and targetHumanoid then
	table.insert(tbl29, tostring(math.floor(targetHumanoid.Health)))
	end

	textLabel2.Text = #tbl29 > 0 and "[" .. table.concat(tbl29, "/") .. "]" or ""
	textLabel2.TextColor3 = color
	textLabel2.Visible = tbl16.distance or tbl16.health
	local currentCamera = Workspace.CurrentCamera

	if line2 then
	if tbl16.tracer and currentCamera then
	local v39, v40 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)
	if v40 then
	local viewportSize = currentCamera.ViewportSize
	if tbl16.tracerOrigin == "屏幕中心" then
	line2.From = Vector2.new(viewportSize.X / 2, viewportSize.Y / 2)
	elseif tbl16.tracerOrigin == "屏幕顶部" then
	line2.From = Vector2.new(viewportSize.X / 2, 0)
	else
	line2.From = Vector2.new(viewportSize.X / 2, viewportSize.Y)
	end
	line2.To = Vector2.new(v39.X, v39.Y)
	line2.Color = color
	line2.Visible = true
	else
	line2.Visible = false
	end
	else
	line2.Visible = false
	end
	end
	end),
	}
	end

	fn53 = function()
	for k2 in pairs(tbl16.trackers) do
	if not fn93(k2) then
	fn52(k2)
	end
	end

	if tbl16.enabled then
	for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer3 and fn93(player) and not tbl16.trackers[player] then
	pcall(fn94, player)
	end
	end
	end
	end

	local function hookEspPlayer(player)
	if player == localPlayer3 then
	return
	end
	player.CharacterAdded:Connect(function()
	task.wait(0.25)
	if tbl16.enabled then
	fn52(player)
	pcall(fn94, player)
	end
	end)
	end

	for _, player in ipairs(Players:GetPlayers()) do
	hookEspPlayer(player)
	end
	Players.PlayerAdded:Connect(hookEspPlayer)
	Players.PlayerRemoving:Connect(fn52)

	local lastEspScan = 0
	RunService.Heartbeat:Connect(function()
	if not tbl16.enabled then
	return
	end
	if tick() - lastEspScan < 0.2 then
	return
	end
	lastEspScan = tick()
	fn53()
	end)

	PoliceSettings = { range = 200, delay = 0.5, combatCheck = false, teleport = false }
	thread = nil

	fn54 = function()
	if thread then
	return
	end

	thread = task.spawn(function()
	while Settings.autoCuff do
	local v32, v33, v34 = fn40(localPlayer3)
	if v34 and playerFunc then
	for _, player in ipairs(Players:GetPlayers()) do
	if player ~= localPlayer3 and fn62(player) and fn85(player, PoliceSettings.combatCheck) then
	local _, _, v37 = fn40(player)
	if v37 and (v37.Position - v34.Position).Magnitude <= PoliceSettings.range then
	pcall(function()
	playerFunc:InvokeServer("handcuff", player, false)
	end)
	end
	end
	end

	if PoliceSettings.teleport then
	local v35 = nil
	local v36 = nil

	for _, player in ipairs(Players:GetPlayers()) do
	local flag12 = player ~= localPlayer3 and player.Team and player.Team.Name == "Civilian"

	if flag12 then
	flag12 = (player:GetAttribute("WantedLevel") or 0) > 0
	end

	if flag12 then
	local _, _, v39 = fn40(player)
	if v39 then
	local magnitude = (v39.Position - v34.Position).Magnitude

	if magnitude <= PoliceSettings.range and (not v35 or magnitude < v35) then
	v35 = magnitude
	v36 = player
	end
	end
	end
	end

	if v36 then
	local _, _, v39 = fn40(v36)
	if v39 then
	v34.CFrame = CFrame.new(v39.Position - v39.CFrame.LookVector * 3)
	end
	end
	end
	end

	task.wait(PoliceSettings.delay)
	end

	thread = nil
	end)
	end

	MovementSettings = {
	walkEnabled = false,
	walkSpeed = 200,
	jumpEnabled = false,
	jumpPower = 50,
	jumpMultiplier = 1,
	infiniteJump = false,
	flyEnabled = false,
	flySpeed = 30,
	flyMode = "传送",
	noclip = false,
	}

	FlyState = {
	walkConn = nil,
	jumpConn = nil,
	flyConn = nil,
	bodyVelocity = nil,
	bodyGyro = nil,
	noclipConn = nil,
	collisionCache = {},
	}

	v31 = nil
	UDim2.new(0, 100, 0.5, -25)
	controls = nil

	pcall(function()
	controls = require(localPlayer3.PlayerScripts:WaitForChild("PlayerModule")):GetControls()
	end)

	fn95 = function()
	if FlyState.walkConn then
	FlyState.walkConn:Disconnect()
	FlyState.walkConn = nil
	end
	end

	fn60 = function()
	fn95()
	if not MovementSettings.walkEnabled then
	return
	end

	FlyState.walkConn = RunService.Heartbeat:Connect(function()
	local _, v33 = fn40(localPlayer3)
	if v33 and MovementSettings.walkEnabled then
	v33.WalkSpeed = MovementSettings.walkSpeed
	end
	end)
	end

	fn96 = function(arg11)
	if not arg11 then
	return false
	end
	local state = arg11:GetState()
	return state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.RunningNoPhysics
	end

	fn55 = function()
	if FlyState.jumpConn then
	FlyState.jumpConn:Disconnect()
	FlyState.jumpConn = nil
	end
	end

	fn56 = function()
	fn55()
	if not MovementSettings.jumpEnabled then
	return
	end

	FlyState.jumpConn = UserInputService.JumpRequest:Connect(function()
	if not MovementSettings.jumpEnabled then
	return
	end
	local v32, v33, v34 = fn40(localPlayer3)
	if not v33 or not v34 or v33.Health <= 0 then
	return
	end

	if not MovementSettings.infiniteJump and not fn96(v33) then
	return
	end
	v34.CFrame = v34.CFrame + Vector3.new(0, MovementSettings.jumpPower * MovementSettings.jumpMultiplier * 0.1, 0)
	end)
	end

	fn97 = function()
	if FlyState.flyConn then
	FlyState.flyConn:Disconnect()
	FlyState.flyConn = nil
	end

	if FlyState.bodyVelocity then
	FlyState.bodyVelocity:Destroy()
	FlyState.bodyVelocity = nil
	end

	if FlyState.bodyGyro then
	FlyState.bodyGyro:Destroy()
	FlyState.bodyGyro = nil
	end

	local _, v33 = fn40(localPlayer3)
	if v33 then
	v33.PlatformStand = false
	v33.AutoRotate = true
	end
	end

	fn98 = function()
	if FlyState.flyConn then
	FlyState.flyConn:Disconnect()
	FlyState.flyConn = nil
	end

	local _, v33 = fn40(localPlayer3)
	if v33 then
	v33.AutoRotate = true
	end
	end

	fn99 = function()
	if not v31 then
	return
	end
	v31.Text = MovementSettings.flyEnabled and "飞行: 开" or "飞行: 关"
	v31.TextColor3 = MovementSettings.flyEnabled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
	end

	cloneFunc0 = function()
	local v32, v33, v34 = fn40(localPlayer3)
	if not v34 or not v33 then
	return
	end
	MovementSettings.flyEnabled = true
	v33.AutoRotate = false

	FlyState.flyConn = RunService.RenderStepped:Connect(function(deltaTime)
	if not MovementSettings.flyEnabled or MovementSettings.flyMode ~= "传送" then
	return
	end
	local v35, v36, v37 = fn40(localPlayer3)
	local currentCamera = Workspace.CurrentCamera
	if not v37 or not v36 or not currentCamera then
	return
	end
	local moveVector = controls and controls:GetMoveVector() or Vector3.zero
	local n11 = currentCamera.CFrame.LookVector * -moveVector.Z + currentCamera.CFrame.RightVector * moveVector.X
	local n12

	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
	n12 = 1
	else
	n12 = 0

	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
	n12 = -1
	end
	end

	v37.CFrame = v37.CFrame + (n11 + Vector3.new(0, n12, 0)) * MovementSettings.flySpeed * deltaTime
	v37.AssemblyLinearVelocity = Vector3.zero
	v37.AssemblyAngularVelocity = Vector3.zero
	v36:ChangeState(Enum.HumanoidStateType.Climbing)
	end)

	end

	cloneFunc1 = function()
	local v32, v33, v34 = fn40(localPlayer3)
	if not v34 or not v33 then
	return
	end
	MovementSettings.flyEnabled = true
	local bodyVelocity = Instance.new("BodyVelocity")
	bodyVelocity.Name = "PYPlayerFlyVelocity"
	bodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	bodyVelocity.Velocity = Vector3.zero
	bodyVelocity.Parent = v34
	FlyState.bodyVelocity = bodyVelocity
	local bodyGyro = Instance.new("BodyGyro")
	bodyGyro.Name = "PYPlayerFlyGyro"
	bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	bodyGyro.P = 90000
	bodyGyro.Parent = v34
	FlyState.bodyGyro = bodyGyro
	v33.PlatformStand = true
	v33.AutoRotate = false

	FlyState.flyConn = RunService.RenderStepped:Connect(function()
	if not MovementSettings.flyEnabled or MovementSettings.flyMode ~= "物理" then
	return
	end
	local v35, v36, v37 = fn40(localPlayer3)
	local currentCamera = Workspace.CurrentCamera
	if not v37 or not v36 or not currentCamera then
	return
	end

	if FlyState.bodyVelocity and FlyState.bodyGyro then
	local moveVector = controls and controls:GetMoveVector() or Vector3.zero
	local n11 = currentCamera.CFrame.LookVector * -moveVector.Z + currentCamera.CFrame.RightVector * moveVector.X
	local n12

	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
	n12 = 1
	else
	n12 = 0

	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
	n12 = -1
	end
	end

	local flySpeed = MovementSettings.flySpeed
	FlyState.bodyVelocity.Velocity = (n11 + Vector3.new(0, n12, 0)) * flySpeed
	FlyState.bodyGyro.CFrame = currentCamera.CFrame
	end
	end)

	end

	fn57 = function()
	if MovementSettings.flyMode == "物理" then
	cloneFunc1()
	else
	cloneFunc0()
	end
	end

	cloneFunc2 = function()
	for k2, v32 in pairs(FlyState.collisionCache) do
	if k2 and k2.Parent then
	pcall(function()
	k2.CanCollide = v32
	end)
	end
	end

	FlyState.collisionCache = {}
	end

	cloneFunc3 = function()
	if FlyState.noclipConn then
	FlyState.noclipConn:Disconnect()
	FlyState.noclipConn = nil
	end

	cloneFunc2()
	end

	fn58 = function()
	cloneFunc3()
	if not MovementSettings.noclip then
	return
	end

	FlyState.noclipConn = RunService.Stepped:Connect(function()
	if not MovementSettings.noclip then
	return
	end
	local character = localPlayer3.Character
	if not character then
	return
	end

	for _, descendant in ipairs(character:GetDescendants()) do
	if descendant:IsA("BasePart") then
	if FlyState.collisionCache[descendant] == nil then
	FlyState.collisionCache[descendant] = descendant.CanCollide
	end

	descendant.CanCollide = false
	end
	end
	end)
	end

	localPlayer3.CharacterAdded:Connect(function()
	task.wait(0.5)
	FlyState.collisionCache = {}

	if MovementSettings.walkEnabled then
	fn60()
	end

	if MovementSettings.jumpEnabled then
	fn56()
	end

	if MovementSettings.noclip then
	fn58()
	end

	if MovementSettings.flyEnabled then
	local flyMode = MovementSettings.flyMode
	MovementSettings.flyEnabled = false
	task.wait(0.2)
	MovementSettings.flyMode = flyMode
	fn57()
	end
	end)

	pcall(fn66)
	pcall(fn73)
	pcall(fn77)
	pcall(fn79)
	pcall(fn80)
	pcall(fn82)
	pcall(fn83)

	UDim2.new(0, 10, 0.5, -25)
	flag11 = false
	getSpeedLimitAtPos = nil

	pcall(function()
	local Algorithms = require(ReplicatedStorage.Modules.Algorithms)
	getSpeedLimitAtPos = Algorithms.getSpeedLimitAtPos

	Algorithms.getSpeedLimitAtPos = function(...)
	if flag11 then
	return 9999
	end
	return getSpeedLimitAtPos(...)
	end
	end)

	fn59 = nil

	fn59 = function()
	if v27 then
	pcall(function()
	v27:Destroy()
	end)

	v27 = nil
	end

	v27 = lib:CreateWindow({
	Title = "大肥鱼 Hub/圣奥里<font color='#00FF00'>定制版</font>",
	Icon = "zap",
	IconTransparency = 0.5,
	IconThemed = true,
	Author = "大肥鱼",
	Folder = "大肥鱼Hub",
	Size = UDim2.fromOffset(640, 460),
	Transparent = true,
	Theme = "Dark",
	User = {
	Enabled = false,
	Callback = function()
	end,
	Anonymous = false,
	},
	SideBarWidth = 200,
	ScrollBarEnabled = true,
	Background = fn42(),
	BackgroundImageTransparency = 0.4,
	})

	flag8 = true
	local parent = v27.Parent

	if parent then
	local function cloneFunc4(descendant)
	if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
	if descendant.Font ~= Enum.Font.Code then
	descendant.Font = Enum.Font.PermanentMarker
	end
	end
	end

	for _, descendant in ipairs(parent:GetDescendants()) do
	cloneFunc4(descendant)
	end

	parent.DescendantAdded:Connect(cloneFunc4)
	end

	local v32 = v27:Tag({ Title = "当前时间: 00:00:00", Icon = "clock", Color = Color3.fromHex("#FFFFFF"), Border = true })
	local n11 = 0

	RunService.Heartbeat:Connect(function()
	if tick() - n11 >= 0.1 then
	v32:SetTitle("当前时间: " .. os.date("!%H:%M:%S", os.time() + 28800))
	n11 = tick()
	end
	end)

	local editOpenButton = v27.EditOpenButton
	local v33 = v27

	local tbl29 = {
	Title = "大肥鱼hub<font color='#00FF00'>定制版</font>",
	Icon = "crown",
	CornerRadius = UDim.new(1, 16),
	StrokeThickness = 1.5,
	}

	local colorSequence = ColorSequence.new
	local tbl30 = {}
	local v34 = ColorSequenceKeypoint.new(0, Color3.fromHex("FF1493"))
	local v35 = ColorSequenceKeypoint.new(0.3, Color3.fromHex("FF69B4"))
	local v36 = ColorSequenceKeypoint.new(0.6, Color3.fromHex("FFB6C1"))
	local new = ColorSequenceKeypoint.new
	local color = Color3.fromHex
	tbl30[1] = v34
	tbl30[2] = v35
	tbl30[3] = v36

	do
	local values = table.pack(new(1, color("FFC0CB")))
	table.move(values, 1, values.n, 4, tbl30)
	end

	tbl29.Color = colorSequence(tbl30)
	tbl29.Draggable = true
	editOpenButton(v33, tbl29)
	local main = v27.UIElements.Main

	if main then
	local uiStroke = Instance.new("UIStroke")
	uiStroke.Name = "MainBorder"
	uiStroke.Thickness = 3
	uiStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	uiStroke.LineJoinMode = Enum.LineJoinMode.Round
	uiStroke.Enabled = tbl8.borderEnabled
	uiStroke.Parent = main
	local uiGradient = Instance.new("UIGradient")
	uiGradient.Name = "BorderGradient"
	uiGradient.Parent = uiStroke
	end

	local v36 = v27:Tab({ Title = "公告", Icon = "message-circle", Locked = false })
	v36:Paragraph({ Title = "定制版", Desc = "大肥鱼 Hub · 圣奥里定制版", Image = "message-circle", ImageSize = 32 })
	v36:Paragraph({ Title = "作者", Desc = "大肥鱼", Image = "user", ImageSize = 32 })
	local v37 = v27:Tab({ Title = "主页", Icon = "home", Locked = false })
	v37:Paragraph({ Title = "大肥鱼 Hub", Desc = "圣奥里定制版", Image = "zap", ImageSize = 32 })
	v37:Paragraph({ Title = "玩家", Desc = "当前服务器ID: " .. game.PlaceId, Image = "users", ImageSize = 32 })
	local v38 = v27:Tab({ Title = "UI设置", Icon = "settings", Locked = false })

	v38:Toggle({
	Title = "自定义光标",
	Value = false,
	Callback = function(arg11)
	v27:ToggleCustomCursor(arg11)
	end,
	})

	v38:Dropdown({
	Title = "通知位置",
	Values = { "左", "右" },
	Value = "右",
	Callback = function(arg11)
	lib:SetNotifySide(arg11 == "左" and "Left" or "Right")
	end,
	})

	v38:Dropdown({
	Title = "DPI缩放",
	Values = { "50%", "75%", "100%", "125%", "150%", "175%", "200%" },
	Value = "100%",
	Callback = function(arg11)
	local num = tonumber(arg11:gsub("%%", ""))

	if num then
	v27:SetDPIScale(num / 100)
	end
	end,
	})

	v38:Keybind({
	Title = "菜单按键",
	Value = "RightShift",
	Callback = function(arg11)
	v27:SetToggleKey(Enum.KeyCode[arg11])
	end,
	})

	v38:Divider()

	v38:Toggle({
	Title = "随机背景图",
	Value = tbl8.randomBg,
	Callback = function(randomBg)
	tbl8.randomBg = randomBg
	end,
	})

	v38:Divider()

	v38:Toggle({
	Title = "启用边框颜色",
	Value = tbl8.borderEnabled,
	Callback = function(borderEnabled)
	tbl8.borderEnabled = borderEnabled
	local main2 = v27 and v27.UIElements and v27.UIElements.Main
	main2 = main2 and main2:FindFirstChild("MainBorder")

	if main2 then
	main2.Enabled = borderEnabled
	end
	end,
	})

	v38:Dropdown({
	Title = "边框颜色",
	Values = { "旋转彩虹", "默认白色", "红色", "橙色", "黄色", "绿色", "青色", "蓝色", "紫色", "粉色" },
	Value = tbl8.isBorderRainbow and "旋转彩虹" or "默认白色",
	Callback = function(arg11)
	if arg11 == "旋转彩虹" then
	elseif arg11 == "默认白色" then
	fn43(Color3.new(1, 1, 1), false)
	else
	fn43(fn39(arg11), false)
	end
	end,
	})

	v38:Divider()

	v38:Dropdown({
	Title = "文字颜色",
	Values = { "默认", "青色", "粉色", "紫色", "橙色", "红色", "绿色", "蓝色", "黄色", "白色", "彩虹" },
	Value = "默认",
	Callback = function(arg11)
	v28 = arg11
	end,
	})

	v38:Button({
	Title = "确认应用文字颜色",
	Icon = "check",
	Callback = function()
	local v39 = lib.GetThemes()
	if not v39 or not v39.Dark then
	return
	end

	if connection then
	connection:Disconnect()
	connection = nil
	end

	if v28 == "彩虹" then
	connection = RunService.Heartbeat:Connect(function()
	local v40 = nil
	v39.Dark.Text = v40
	v39.Dark.Placeholder = v40
	v39.Dark.Button = v40
	v39.Dark.TabTitle = v40
	lib:SetTheme("Dark")
	end)
	elseif v28 and v28 ~= "默认" then
	local v40 = nil
	v39.Dark.Text = v40
	v39.Dark.Placeholder = v40
	v39.Dark.Button = v40
	v39.Dark.TabTitle = v40
	lib:SetTheme("Dark")
	else
	lib:SetTheme("Dark")
	end
	end,
	})

	local v39 = v27:Section({ Title = "功能", Opened = true })
	local v40 = v39:Tab({ Title = "主要功能", Icon = "sliders-h" })

	v40:Toggle({
	Title = "无限体力",
	Default = false,
	Callback = function(stamina)
	Settings.stamina = stamina
	end,
	})

	v40:Toggle({
	Title = "无限饥饿",
	Default = false,
	Callback = function(food)
	Settings.food = food
	end,
	})

	v40:Toggle({ Title = "战斗拦截", Default = false, Callback = fn45 })
	v40:Toggle({ Title = "隐身", Default = false, Callback = fn46 })

	v40:Toggle({
	Title = "显示隐身悬浮窗",
	Default = false,
	Callback = function(arg11)
	flag10 = arg11

	if arg11 then
	else
	end
	end,
	})

	v40:Toggle({
	Title = "锁定隐身悬浮窗位置",
	Default = false,
	Callback = function(arg11)
	flag9 = arg11

	if textButton then
	local active = not arg11
	textButton.Active = active
	textButton.Draggable = active
	end
	end,
	})

	v40:Toggle({
	Title = "防布娃娃",
	Default = false,
	Callback = function(noRagdoll)
	Settings.noRagdoll = noRagdoll
	end,
	})

	v40:Toggle({
	Title = "防摔伤",
	Default = false,
	Callback = function(noFallDamage)
	Settings.noFallDamage = noFallDamage
	end,
	})

	v40:Toggle({ Title = "防越狱拉回", Default = false, Callback = fn49 })

	v40:Toggle({
	Title = "自动捡钱",
	Default = false,
	Callback = function(autoMoney)
	Settings.autoMoney = autoMoney
	end,
	})

	v40:Toggle({
	Title = "无限子弹",
	Default = false,
	Callback = function(infiniteAmmo)
	Settings.infiniteAmmo = infiniteAmmo
	end,
	})

	v40:Toggle({
	Title = "快速射击",
	Default = false,
	Callback = function(rapidFire)
	Settings.rapidFire = rapidFire

	if rapidFire then
	end
	end,
	})

	local v41 = v39:Tab({ Title = "刷钱", Icon = "money-bill-wave" })

	v41:Toggle({
	Title = "自动接取任务",
	Default = false,
	Callback = function(autoMission)
	Settings.autoMission = autoMission
	end,
	})

	v41:Toggle({
	Title = "优先高收益任务",
	Default = false,
	Callback = function(priorityHighReward)
	tbl10.priorityHighReward = priorityHighReward
	end,
	})

	v41:Input({
	Title = "接取间隔",
	Value = "2",
	PlaceholderText = "输入间隔秒数",
	ClearTextOnFocus = false,
	Callback = function(arg11)
	local missionInterval = tonumber(arg11)

	if missionInterval and missionInterval > 0 then
	tbl10.missionInterval = missionInterval
	end
	end,
	})

	v41:Toggle({
	Title = "安全模式(出租车)",
	Default = false,
	Callback = function(taxiSafe)
	tbl10.taxiSafe = taxiSafe

	if taxiSafe then
	local _, _, v44 = fn40(localPlayer3)
	if v44 then
	tbl10.taxiOrigin = v44.Position
	end
	end
	end,
	})

	v41:Dropdown({
	Title = "出租车延迟模式",
	Values = { "随机时间", "距离测算" },
	Value = "随机时间",
	Callback = function(taxiDelayMode)
	tbl10.taxiDelayMode = taxiDelayMode
	end,
	})

	v41:Toggle({
	Title = "出租车刷钱",
	Default = false,
	Callback = function(taxi)
	Settings.taxi = taxi
	end,
	})

	v41:Toggle({
	Title = "公交车刷钱",
	Default = false,
	Callback = function(bus)
	Settings.bus = bus
	end,
	})

	v41:Toggle({
	Title = "农民刷钱",
	Default = false,
	Callback = function(farmer)
	Settings.farmer = farmer
	end,
	})

	v41:Toggle({ Title = "自动黑客小游戏", Default = false, Callback = fn50 })

	v41:Toggle({
	Title = "高尔夫刷钱",
	Default = false,
	Callback = function(golf)
	Settings.golf = golf
	end,
	})

	local v42 = v39:Tab({ Title = "战斗", Icon = "crosshairs" })

	v42:Toggle({
	Title = "杀戮光环",
	Default = false,
	Callback = function(auraEnabled)
	tbl11.auraEnabled = auraEnabled
	end,
	})

	v42:Toggle({
	Title = "只攻击警察",
	Default = false,
	Callback = function(auraOnlyPolice)
	tbl11.auraOnlyPolice = auraOnlyPolice

	if auraOnlyPolice then
	tbl11.auraOnlyCivilian = false
	end
	end,
	})

	v42:Toggle({
	Title = "只攻击平民",
	Default = false,
	Callback = function(auraOnlyCivilian)
	tbl11.auraOnlyCivilian = auraOnlyCivilian

	if auraOnlyCivilian then
	tbl11.auraOnlyPolice = false
	end
	end,
	})

	v42:Toggle({
	Title = "战斗检测",
	Default = false,
	Callback = function(auraCombatCheck)
	tbl11.auraCombatCheck = auraCombatCheck
	end,
	})

	v42:Slider({
	Title = "攻击范围",
	Value = { Min = 10, Max = 500, Default = 50 },
	Callback = function(auraRange)
	tbl11.auraRange = auraRange
	end,
	})

	v42:Slider({
	Title = "伤害倍率",
	Value = { Min = 1, Max = 100, Default = 5 },
	Callback = function(auraDamage)
	tbl11.auraDamage = auraDamage
	end,
	})

	local v43 = v39:Tab({ Title = "自瞄", Icon = "crosshairs" })

	v43:Toggle({
	Title = "开启/关闭自瞄",
	Default = false,
	Callback = function(enabled)
	tbl12.enabled = enabled
	end,
	})

	v43:Toggle({
	Title = "显示Fov圈",
	Default = false,
	Callback = function(showFov)
	tbl12.showFov = showFov
	end,
	})

	v43:Toggle({
	Title = "显示准心",
	Default = false,
	Callback = function(showCrosshair)
	tbl12.showCrosshair = showCrosshair
	end,
	})

	v43:Toggle({
	Title = "显示追踪线",
	Default = false,
	Callback = function(showTracer)
	tbl12.showTracer = showTracer
	end,
	})

	v43:Toggle({
	Title = "队伍检测",
	Default = false,
	Callback = function(teamCheck)
	tbl12.teamCheck = teamCheck
	end,
	})

	v43:Toggle({
	Title = "好友检测",
	Default = false,
	Callback = function(friendCheck)
	tbl12.friendCheck = friendCheck
	end,
	})

	v43:Toggle({
	Title = "墙壁检测",
	Default = false,
	Callback = function(wallCheck)
	tbl12.wallCheck = wallCheck
	end,
	})

	v43:Toggle({
	Title = "预判自瞄",
	Default = false,
	Callback = function(prediction)
	tbl12.prediction = prediction
	end,
	})

	v43:Toggle({
	Title = "只自瞄警察",
	Default = false,
	Callback = function(onlyPolice)
	tbl12.onlyPolice = onlyPolice

	if onlyPolice then
	tbl12.onlyCivilian = false
	end
	end,
	})

	v43:Toggle({
	Title = "只自瞄平民",
	Default = false,
	Callback = function(onlyCivilian)
	tbl12.onlyCivilian = onlyCivilian

	if onlyCivilian then
	tbl12.onlyPolice = false
	end
	end,
	})

	v43:Toggle({
	Title = "战斗检测",
	Default = false,
	Callback = function(combatCheck)
	tbl12.combatCheck = combatCheck
	end,
	})

	v43:Dropdown({
	Title = "优先锁定模式",
	Values = { "准心最近", "距离最近", "血量最低" },
	Value = "准心最近",
	Callback = function(targetMode)
	tbl12.targetMode = targetMode
	end,
	})

	v43:Dropdown({
	Title = "瞄准身体部位",
	Values = { "头", "胸", "左手", "右手", "左腿", "右腿" },
	Value = "头",
	Callback = function(targetPart)
	tbl12.targetPart = targetPart
	end,
	})

	v43:Slider({
	Title = "Fov圈大小",
	Value = { Min = 1, Max = 500, Default = 50 },
	Callback = function(fov)
	tbl12.fov = fov
	end,
	})

	v43:Slider({
	Title = "自瞄平滑度",
	Value = { Min = 1, Max = 10, Default = 10 },
	Callback = function(arg11)
	tbl12.smoothness = arg11 / 10
	end,
	})

	v43:Slider({
	Title = "Fov圈厚度",
	Value = { Min = 1, Max = 5, Default = 2 },
	Callback = function(fovThickness)
	tbl12.fovThickness = fovThickness
	end,
	})

	v43:Dropdown({
	Title = "颜色选择",
	Values = { "红色", "黄色", "绿色", "蓝色", "紫色", "白色", "黑色", "彩虹色" },
	Value = "红色",
	Callback = function(color2)
	tbl12.color = color2
	end,
	})

	local v44 = v39:Tab({ Title = "Ragebot", Icon = "bot" })

	v44:Toggle({
	Title = "Ragebot",
	Default = false,
	Callback = function(enabled)
	tbl13.enabled = enabled
	end,
	})

	v44:Slider({
	Title = "攻击距离",
	Value = { Min = 10, Max = 500, Default = 150 },
	Step = 1,
	Callback = function(range)
	tbl13.range = range
	end,
	})

	v44:Slider({
	Title = "攻击间隔",
	Value = { Min = 0.01, Max = 1, Default = 0.05 },
	Step = 0.01,
	Callback = function(interval)
	tbl13.interval = interval
	end,
	})

	v44:Dropdown({
	Title = "攻击部位",
	Values = { "头部", "躯干", "左臂", "右臂", "左腿", "右腿" },
	Value = "头部",
	Callback = function(arg11)
	tbl13.bodyPart = tbl14[arg11] or "Head"
	end,
	})

	v44:Toggle({
	Title = "职业检测",
	Default = false,
	Callback = function(jobCheck)
	tbl13.jobCheck = jobCheck
	end,
	})

	v44:Toggle({
	Title = "墙壁检测",
	Default = false,
	Callback = function(wallCheck)
	tbl13.wallCheck = wallCheck
	end,
	})

	v44:Toggle({
	Title = "活体检测",
	Default = false,
	Callback = function(aliveCheck)
	tbl13.aliveCheck = aliveCheck
	end,
	})

	v44:Toggle({
	Title = "战斗状态检测",
	Default = false,
	Callback = function(combatCheck)
	tbl13.combatCheck = combatCheck
	end,
	})

	v44:Toggle({
	Title = "锁定警察",
	Default = false,
	Callback = function(policeLock)
	tbl13.policeLock = policeLock

	if policeLock then
	tbl13.civilianLock = false
	end
	end,
	})

	v44:Toggle({
	Title = "锁定平民",
	Default = false,
	Callback = function(civilianLock)
	tbl13.civilianLock = civilianLock

	if civilianLock then
	tbl13.policeLock = false
	end
	end,
	})

	v44:Toggle({
	Title = "弹道显示",
	Default = false,
	Callback = function(beam)
	tbl13.beam = beam
	end,
	})

	local v45 = v39:Tab({ Title = "范围", Icon = "bullseye" })

	v45:Toggle({
	Title = "开启/关闭范围",
	Default = false,
	Callback = function(active)
	tbl15.active = active

	if not active then
	for _, player in ipairs(Players:GetPlayers()) do
	if player.Character then
	end
	end
	end
	end,
	})

	v45:Input({
	Title = "范围大小设置",
	Value = "10",
	Callback = function(arg11)
	local size = tonumber(arg11)

	if size and size > 0 then
	tbl15.size = size
	end
	end,
	})

	v45:Input({
	Title = "范围透明度设置(0-1)",
	Value = "0.7",
	Callback = function(arg11)
	local transparency = tonumber(arg11)

	if transparency and transparency >= 0 and transparency <= 1 then
	tbl15.transparency = transparency
	end
	end,
	})

	v45:Dropdown({
	Title = "选择范围颜色",
	Values = { "红色", "蓝色", "黄色", "绿色", "青色", "橙色", "紫色", "白色", "黑色", "彩虹色" },
	Value = "红色",
	Callback = function(color2)
	tbl15.color = color2
	tbl15.rainbow = color2 == "彩虹色"
	end,
	})

	v45:Dropdown({
	Title = "选择范围材质",
	Values = { "Neon", "Plastic", "Wood", "Slate", "Concrete", "Metal", "SmoothPlastic" },
	Value = "Neon",
	Callback = function(material)
	tbl15.material = material
	end,
	})

	v45:Toggle({
	Title = "NPC范围",
	Default = false,
	Callback = function(affectNPC)
	tbl15.affectNPC = affectNPC
	end,
	})

	v45:Toggle({
	Title = "队伍检测",
	Default = false,
	Callback = function(teamCheck)
	tbl15.teamCheck = teamCheck
	end,
	})

	v45:Toggle({
	Title = "活体检测",
	Default = false,
	Callback = function(checkCorpses)
	tbl15.checkCorpses = checkCorpses
	end,
	})

	v45:Toggle({
	Title = "显示轮廓",
	Default = false,
	Callback = function(outline)
	tbl15.outline = outline
	end,
	})

	v45:Toggle({
	Title = "启用/禁用碰撞",
	Default = false,
	Callback = function(collision)
	tbl15.collision = collision
	end,
	})

	v45:Toggle({
	Title = "发光效果",
	Default = false,
	Callback = function(glow)
	tbl15.glow = glow
	end,
	})

	v45:Toggle({
	Title = "脉动效果",
	Default = false,
	Callback = function(pulse)
	tbl15.pulse = pulse
	end,
	})

	local v46 = v39:Tab({ Title = "玩家", Icon = "user" })

	v46:Toggle({
	Title = "开启/关闭跳跃",
	Default = false,
	Callback = function(jumpEnabled)
	MovementSettings.jumpEnabled = jumpEnabled

	if jumpEnabled then
	fn56()
	else
	fn55()
	end
	end,
	})

	v46:Slider({
	Title = "设置跳跃高度",
	Value = { Min = 50, Max = 400, Default = 50 },
	Callback = function(jumpPower)
	MovementSettings.jumpPower = jumpPower
	end,
	})

	v46:Slider({
	Title = "设置跳跃倍数",
	Value = { Min = 1, Max = 10, Default = 1 },
	Callback = function(jumpMultiplier)
	MovementSettings.jumpMultiplier = jumpMultiplier
	end,
	})

	v46:Toggle({
	Title = "无限跳跃",
	Default = false,
	Callback = function(infiniteJump)
	MovementSettings.infiniteJump = infiniteJump
	end,
	})

	local v47 = v39:Tab({ Title = "警察功能", Icon = "handcuffs" })

	v47:Toggle({
	Title = "自动铐",
	Default = false,
	Callback = function(autoCuff)
	Settings.autoCuff = autoCuff

	if autoCuff then
	fn54()
	end
	end,
	})

	v47:Toggle({
	Title = "自动传送",
	Default = false,
	Callback = function(teleport)
	PoliceSettings.teleport = teleport
	end,
	})

	v47:Toggle({
	Title = "战斗检测",
	Default = false,
	Callback = function(combatCheck)
	PoliceSettings.combatCheck = combatCheck
	end,
	})

	v47:Slider({
	Title = "范围",
	Value = { Min = 10, Max = 500, Default = 200 },
	Step = 5,
	Callback = function(range)
	PoliceSettings.range = range
	end,
	})

	v47:Slider({
	Title = "间隔",
	Value = { Min = 0.1, Max = 3, Default = 0.5 },
	Step = 0.1,
	Callback = function(delay)
	PoliceSettings.delay = delay
	end,
	})

	local v48 = v39:Tab({ Title = "ESP", Icon = "eye" })

	v48:Toggle({
	Title = "玩家透视总开关",
	Default = false,
	Callback = function(enabled)
	if type(enabled) == "table" then
	enabled = enabled.Value
	end
	tbl16.enabled = enabled == true

	if not tbl16.enabled then
	for k2 in pairs(tbl16.trackers) do
	fn52(k2)
	end
	else
	pcall(fn53)
	end
	end,
	})

	v48:Toggle({
	Title = "显示名字",
	Default = true,
	Callback = function(name)
	tbl16.name = name
	end,
	})

	v48:Toggle({
	Title = "显示距离",
	Default = true,
	Callback = function(distance)
	tbl16.distance = distance
	end,
	})

	v48:Toggle({
	Title = "显示血量",
	Default = true,
	Callback = function(health)
	tbl16.health = health
	end,
	})

	v48:Toggle({
	Title = "显示高亮",
	Default = true,
	Callback = function(highlight)
	tbl16.highlight = highlight
	end,
	})

	v48:Toggle({
	Title = "显示追踪线",
	Default = false,
	Callback = function(tracer)
	tbl16.tracer = tracer
	end,
	})

	v48:Dropdown({
	Title = "追踪线起点",
	Values = { "屏幕底部", "屏幕中心", "屏幕顶部" },
	Value = "屏幕底部",
	Callback = function(tracerOrigin)
	tbl16.tracerOrigin = tracerOrigin
	end,
	})

	local tbl31 = { "逃犯", "厨师", "平民", "配送员", "农民", "消防员", "警察", "医护人员", "囚犯", "道路服务", "交通" }

	v48:Dropdown({
	Title = "选择透视队伍",
	Values = tbl31,
	Value = tbl31,
	Multi = true,
	AllowNone = true,
	Callback = function(arg11)
	for k2 in pairs(tbl16.selectedTeams) do
	tbl16.selectedTeams[k2] = false
	end
	tbl16.showFugitive = false
	if type(arg11) ~= "table" then
	return
	end
	local function applyTeam(label)
	if label == "逃犯" then
	tbl16.showFugitive = true
	return
	end
	for k2, v50 in pairs(tbl17) do
	if v50 == label or k2 == label then
	tbl16.selectedTeams[k2] = true
	end
	end
	end
	if arg11[1] ~= nil then
	for _, v49 in ipairs(arg11) do
	applyTeam(v49)
	end
	else
	for k2, v49 in pairs(arg11) do
	if v49 == true then
	applyTeam(k2)
	elseif type(v49) == "string" then
	applyTeam(v49)
	end
	end
	end
	end,
	})

	v27:OnClose(function()
	flag8 = false
	v27 = nil
	end)

	v27:OnDestroy(function()
	flag8 = false
	v27 = nil
	end)
	end

	end

	end
	end

	task.defer(function()
		pcall(function()
			if fn59 then
				fn59()
			end
		end)
	end)
end

if getgenv().DaFeiYuAutoRun ~= false then
	task.defer(function()
		local ok, err = pcall(DaFeiYuEntry, "", "", "", "", "", nil, {}, nil, nil, function()
		end, function(msg)
			local step = tostring(msg or "")
			return function()
				if step ~= "" then
					print("[大肥鱼 Hub]", step)
				end
			end
		end, function()
		end)
		if not ok then
			warn("[大肥鱼 Hub] 启动失败:", err)
		end
	end)
end

return DaFeiYuEntry
