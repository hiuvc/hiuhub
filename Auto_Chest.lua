-- // 1. CẤU HÌNH (SETTINGS) & KHỞI TẠO BAN ĐẦU // --
getgenv().Settings = {
    AutoCollectChest = true,
    AutoDarkBeard = true,
    ChestLimit = 30,
    AutoRejoin = true,
    Speed = 350,
    Webhook = "",
    AutoExecute = true,
    Team = "Marines",
}

-- Sử dụng biến cục bộ để truy cập dễ dàng hơn
local Settings = getgenv().Settings

if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        -- SỬ DỤNG Settings.Team
        l_Remotes_0.CommF_:InvokeServer("SetTeam", Settings.Team or "Marines")
        task.wait(5)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end

-- // DỊCH VỤ & BIẾN // --
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local CoreGui = game:GetService("CoreGui")
local GuiService = game:GetService("GuiService")
local CollectionService = game:GetService("CollectionService")

local Player = Players.LocalPlayer
local queue_on_teleport = queue_on_teleport or syn.queue_on_teleport

-- SỬ DỤNG Settings.AutoExecute
if Settings.AutoExecute then
    if queue_on_teleport then
        queue_on_teleport([[
            repeat task.wait() until game:IsLoaded()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/Auto_Chest.lua"))()
        ]])
    end
end


---
-- // 2. AUTO REJOIN (CHỐNG DISCONNECT/KICK) // --
-- SỬ DỤNG Settings.AutoRejoin
if Settings.AutoRejoin then
    local function Rejoin()
        if #Players:GetPlayers() <= 1 then
            Player:Kick("\nKai Script: Server vắng, đang Rejoin...")
            task.wait()
            TeleportService:Teleport(game.PlaceId, Player)
        else
            TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, Player)
        end
    end

    -- Bắt sự kiện khi bị kick hoặc mất kết nối
    GuiService.ErrorMessageChanged:Connect(function()
        print("Kai Script: Detected Kick/Disconnect! Rejoining...")
        task.wait(0.5)
        Rejoin()
    end)
    
    -- Bắt sự kiện bảng thông báo lỗi hiện lên
    task.spawn(function()
        while task.wait(1) do
            local prompt = CoreGui:FindFirstChild("RobloxPromptGui")
            if prompt then
                local overlay = prompt:FindFirstChild("promptOverlay")
                if overlay and overlay:FindFirstChild("ErrorPrompt") then
                    Rejoin()
                end
            end
        end
    end)
end

---
-- // 3. GIAO DIỆN (UI) // --
local CoreGui = game:GetService("CoreGui")
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Status = Instance.new("TextLabel")
local Info = Instance.new("TextLabel")
local UICorner = Instance.new("UICorner")
local UIStroke = Instance.new("UIStroke")

ScreenGui.Name = "KaiAutoChest"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)

-- 🟩 Căn giữa màn hình
Frame.Position = UDim2.new(0.5, -130, 0.5, -70)
Frame.Size = UDim2.new(0, 260, 0, 140)

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

UIStroke.Parent = Frame
UIStroke.Color = Color3.fromRGB(0, 255, 150)
UIStroke.Thickness = 1.5

Title.Parent = Frame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0.05, 0)
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Font = Enum.Font.GothamBold
Title.Text = "AUTO CHEST & REJOIN"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 18

Status.Parent = Frame
Status.BackgroundTransparency = 1
Status.Position = UDim2.new(0, 10, 0.35, 0)
Status.Size = UDim2.new(1, -20, 0, 40)
Status.Font = Enum.Font.Gotham
Status.Text = "Status: Loading..."
Status.TextColor3 = Color3.fromRGB(200, 200, 200)
Status.TextSize = 14
Status.TextWrapped = true
Status.TextXAlignment = Enum.TextXAlignment.Center

Info.Parent = Frame
Info.BackgroundTransparency = 1
Info.Position = UDim2.new(0, 10, 0.7, 0)
Info.Size = UDim2.new(1, -20, 0, 25)
Info.Font = Enum.Font.Gotham
Info.Text = "Chest: 0 | Beli: 0"
Info.TextColor3 = Color3.fromRGB(255, 255, 100)
Info.TextSize = 14
Info.TextXAlignment = Enum.TextXAlignment.Center


-- // GLOBAL VARS // --
getgenv().CollectedCount = 0
getgenv().StopScript = false
getgenv().AttackCooldown = 0.1 -- Đặt ở đây hoặc trong Settings, giữ nguyên để không làm thay đổi logic Attack

local Players = game:GetService("Players")
local Player = Players.LocalPlayer

local function UpdateStatus(text)
    Status.Text = "Status: " .. text
end

local function UpdateInfo()
    if Player:FindFirstChild("Data") and Player.Data:FindFirstChild("Beli") then
        Info.Text = "Chest: " .. getgenv().CollectedCount .. " | Beli: " .. math.floor(Player.Data.Beli.Value)
    end
end


-- // DRAG UI (PC + MOBILE) // --
local UIS = game:GetService("UserInputService")
local dragging, dragInput, dragStart, startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 
    or input.UserInputType == Enum.UserInputType.Touch then
        
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement 
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UIS.InputChanged:Connect(function(input)
    if dragging and input == dragInput then
        update(input)
    end
end)


---
-- // HÀM HỖ TRỢ (FUNCTIONS) // --

-- Webhook
local function SendWebhook(title, desc)
    -- SỬ DỤNG Settings.Webhook
    if Settings.Webhook == "" then return end
    local embed = {
        ["title"] = title,
        ["description"] = desc,
        ["color"] = 65280,
        ["footer"] = {["text"] = "Kai Auto • " .. os.date("%H:%M:%S")}
    }
    pcall(function()
        (syn and syn.request or http_request or request)({
            Url = Settings.Webhook,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = HttpService:JSONEncode({["embeds"] = {embed}})
        })
    end)
end

-- Anti AFK
Player.Idled:Connect(function()
    VirtualUser:Button2Down(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
    task.wait(1)
    VirtualUser:Button2Up(Vector2.new(0,0), Workspace.CurrentCamera.CFrame)
end)

-- Noclip (Optimized)
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            if Player.Character then
                for _, v in pairs(Player.Character:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            end
        end)
    end
end)

-- Global cooldown
getgenv().Seriality = getgenv().Seriality or false
local lastAttackTime = 0

-- Services (Đã khai báo ở trên, chỉ giữ lại phần cần thiết cho logic Attack)
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- CameraShaker
local CameraShakerR = require(ReplicatedStorage.Util.CameraShaker)
CameraShakerR:Stop()

--Check if entity alive
local function IsEntityAlive(entity)
    local humanoid = entity:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

-- Get enemies and players in range
local function GetEnemiesInRange(character, range)
    local enemies = Workspace.Enemies:GetChildren()
    local players = Players:GetPlayers()
    local targets = {}
    local playerPos = character:GetPivot().Position

    for _, enemy in ipairs(enemies) do
        local rootPart = enemy:FindFirstChild("HumanoidRootPart")
        if rootPart and IsEntityAlive(enemy) then
            if (rootPart.Position - playerPos).Magnitude <= range then
                table.insert(targets, enemy)
            end
        end
    end

    for _, otherPlayer in ipairs(players) do
        if otherPlayer ~= player and otherPlayer.Character then
            local rootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart and IsEntityAlive(otherPlayer.Character) then
                if (rootPart.Position - playerPos).Magnitude <= range then
                    table.insert(targets, otherPlayer.Character)
                end
            end
        end
    end

    return targets
end

-- Attack function with global cooldown
local function Attack()
    local currentTime = tick()
    if currentTime - lastAttackTime < getgenv().AttackCooldown then return end

    local character = player.Character
    if not character then return end

    local equippedWeapon = character:FindFirstChildOfClass("Tool")
    if not equippedWeapon then return end

    local enemiesInRange = GetEnemiesInRange(character, 60)
    if #enemiesInRange == 0 then return end

    local modules = ReplicatedStorage:FindFirstChild("Modules")
    if not modules then return end

    local attackEvent = modules:WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
    local hitEvent = modules:WaitForChild("Net"):WaitForChild("RE/RegisterHit")
    if not attackEvent or not hitEvent then return end

    local targets, mainTarget = {}, nil
    for _, enemy in ipairs(enemiesInRange) do
        if not enemy:GetAttribute("IsBoat") then
            local HitboxLimbs = {"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}
            local hitPart = enemy:FindFirstChild(HitboxLimbs[math.random(#HitboxLimbs)]) or enemy.PrimaryPart
            if hitPart then
                table.insert(targets, {enemy, hitPart})
                mainTarget = hitPart
            end
        end
    end
    if not mainTarget then return end

    attackEvent:FireServer(0)

    local playerScripts = player:FindFirstChild("PlayerScripts")
    if playerScripts then
        local localScript = playerScripts:FindFirstChildOfClass("LocalScript")
        while not localScript do
            playerScripts.ChildAdded:Wait()
            localScript = playerScripts:FindFirstChildOfClass("LocalScript")
        end

        local hitFunction
        if getsenv then
            local success, scriptEnv = pcall(getsenv, localScript)
            if success and scriptEnv then
                hitFunction = scriptEnv._G.SendHitsToServer
            end
        end

        local successFlags, combatRemoteThread = pcall(function()
            return require(modules.Flags).COMBAT_REMOTE_THREAD or false
        end)

        if successFlags and combatRemoteThread and hitFunction then
            hitFunction(mainTarget, targets)
        elseif successFlags and not combatRemoteThread then
            hitEvent:FireServer(mainTarget, targets)
        end
    end

    lastAttackTime = tick()
end

-- Get monster near player
local function get_Monster()
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        local c = enemy:FindFirstChild("UpperTorso") or enemy:FindFirstChild("Head")
        if enemy:FindFirstChild("HumanoidRootPart", true) and c then
            if (c.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                return true, c.Position
            end
        end
    end
    for _, beast in pairs(Workspace.SeaBeasts:GetChildren()) do
        if beast:FindFirstChild("HumanoidRootPart") and beast:FindFirstChild("Health") and beast.Health.Value > 0 then
            return true, beast.HumanoidRootPart.Position
        end
    end
    for _, vehicle in pairs(Workspace.Enemies:GetChildren()) do
        if vehicle:FindFirstChild("Health") and vehicle.Health.Value > 0 and vehicle:FindFirstChild("VehicleSeat") then
            return true, vehicle.Engine.Position
        end
    end
    return false, nil
end

-- Activate tool function
local function Actived()
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if tool then
        for _, c in next, getconnections(tool.Activated) do
            if typeof(c.Function) == 'function' then
                getupvalues(c.Function)
            end
        end
    end
end

-- Main Attack Loop
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if not getgenv().Seriality then return end

            -- Attack normal enemies
            Attack()

            -- MobAura/Blox Fruit attack
            local tool = player.Character:FindFirstChildOfClass("Tool")
            if tool then
                local ToolTip = tool.ToolTip
                local MobAura, Mon = get_Monster()
                if ToolTip == "Blox Fruit" and MobAura then
                    local currentTime = tick()
                    if currentTime - lastAttackTime >= getgenv().AttackCooldown then
                        local LeftClickRemote = tool:FindFirstChild('LeftClickRemote')
                        if LeftClickRemote then
                            Actived()
                            LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
                            LeftClickRemote:FireServer(false)
                            lastAttackTime = tick()
                        end
                    end
                end
            end
        end)
    end)
end)

-- Equip Weapon
local function EquipWeapon(name)
    local Backpack = Player.Backpack
    local Char = Player.Character
    if Char and not Char:FindFirstChild(name) and Backpack:FindFirstChild(name) then
        Char.Humanoid:EquipTool(Backpack[name])
    end
end


-- Cờ trạng thái
local isTweening = false      
local allowBypass = false        
local bypassDistance = 3500
local defaultTweenSpeed = 350

-- Đợi HumanoidRootPart
function WaitHumanoidRootPart(player)
    if not player then return end
    return player.Character:WaitForChild("HumanoidRootPart", 9)
end

-- Tìm tele gần nhất
function CheckNearestTeleporter(targetCF)
    local placeId = game.PlaceId
    local targetPos = targetCF.Position
    local teleList = {}

    if placeId == 2753915549 then -- First Sea
        teleList = {
            Sky3 = Vector3.new(-7894, 5547, -380),
            Sky3Exit = Vector3.new(-4607, 874, -1667),
            UnderWater = Vector3.new(61163, 11, 1819),
            UnderwaterExit = Vector3.new(4050, -1, -1814)
        }
    elseif placeId == 4442272183 then -- Second Sea
        teleList = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif placeId == 7449423635 then -- Third Sea
        teleList = {
            ["Floating Turtle"] = Vector3.new(-12462, 375, -7552),
            ["Hydra Island"] = Vector3.new(5745, 610, -267),
            Mansion = Vector3.new(-12462, 375, -7552),
            Castle = Vector3.new(-5036, 315, -3179),
            ["Beautiful Pirate"] = Vector3.new(5319, 23, -93),
            ["Beautiful Room"] = Vector3.new(5314.58, 22.53, -125.94),
            ["Temple of Time"] = Vector3.new(28286, 14897, 103)
        }
    end

    local nearest, minDist = nil, math.huge
    for _, pos in pairs(teleList) do
        local dist = (pos - targetPos).Magnitude
        if dist < minDist then
            minDist = dist
            nearest = pos
        end
    end

    local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not _G.Framing and hrp then
        local distToTarget = (targetPos - hrp.Position).Magnitude
        if minDist < 2000 and distToTarget > bypassDistance then
            return nearest
        end
    end
end

-- Gửi requestEntrance
function RequestEntrance(pos)
    local success = pcall(function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", pos)
    end)
    if success then
        local hrp = game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 50, 0)
        end
        task.wait(0.5)
    end
end

-- Dừng tween
function StopTween()
    _G.StopTween = true
    task.wait()

    local player = game.Players.LocalPlayer
    local character = player and player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")

    if hrp then hrp.CFrame = hrp.CFrame end
    if hrp and hrp:FindFirstChild("BodyClip") then hrp.BodyClip:Destroy() end
    if character and character:FindFirstChild("Highlight") then character.Highlight:Destroy() end

    _G.Clip = false
    _G.StopTween = false
end

-- Tween đến vị trí target
function topos(target)
    local player = game.Players.LocalPlayer
    local character = player and player.Character
    local hrp = character and character:FindFirstChild("HumanoidRootPart")
    if not (character and character:FindFirstChild("Humanoid") and character.Humanoid.Health > 0 and hrp) then
        warn("TweenToPosition: nhân vật không hợp lệ hoặc đã chết")
        return
    end

    if not target or (typeof(target) ~= "CFrame" and typeof(target) ~= "Vector3") then
        warn("TweenToPosition: target không hợp lệ")
        return
    end

    local targetCFrame = typeof(target) == "Vector3" and CFrame.new(target) or target
    local distance = (targetCFrame.Position - hrp.Position).Magnitude

    -- Kiểm tra có nên teleport không
    local nearestTele = CheckNearestTeleporter(targetCFrame)
    if nearestTele then
        RequestEntrance(nearestTele)
        task.wait(0.5)
    end

    -- Tạo PartTele nếu chưa có
    if not character:FindFirstChild("PartTele") then
        local part = Instance.new("Part")
        part.Size = Vector3.new(10, 1, 10)
        part.Name = "PartTele"
        part.Anchored = true
        part.Transparency = 1
        part.CanCollide = false
        part.CFrame = hrp.CFrame
        part.Parent = character

        part:GetPropertyChangedSignal("CFrame"):Connect(function()
            if not isTweening then return end
            task.wait()
            if character and character:FindFirstChild("HumanoidRootPart") then
                local cf = part.CFrame
                hrp.CFrame = CFrame.new(cf.Position.X, targetCFrame.Position.Y, cf.Position.Z)
            end
        end)
    end
    
    isTweening = true

    if allowBypass and distance > bypassDistance then
        if typeof(bypass) == "function" then
            bypass(targetCFrame)
        end
    end

    local speed = Settings.Speed or defaultTweenSpeed
    if distance <= 250 then
        speed = speed * 3
    end

    local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(character.PartTele, tweenInfo, {
        CFrame = targetCFrame
    })

    tween:Play()

    tween.Completed:Connect(function(state)
        if state == Enum.PlaybackState.Completed then
            if character:FindFirstChild("PartTele") then
                character.PartTele:Destroy()
            end
            isTweening = false
        end
    end)
end

function Tween(target)
    topos(target)
end


-- Hop Server (Improved)
local function Hop()
    UpdateStatus("Hopping Server...")
    SendWebhook("Server Hop", "Đang chuyển server...\nChests: " .. getgenv().CollectedCount)
    getgenv().CollectedCount = 0 -- Reset count sau khi Hop
    
    if queue_on_teleport then
        queue_on_teleport("print('Kai Script: Hopping complete!')")
    end

    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundSomething = ""
    local actualHour = os.date("!*t").hour
    
    local function TPReturner()
        local Site;
        if foundSomething == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundSomething))
        end
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundSomething = Site.nextPageCursor
        end
        local num = 0;
        for i,v in pairs(Site.data) do
            local Possible = true
            local ID = tostring(v.id)
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                delfile("NotSameServers.json")
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait()
                    pcall(function()
                        wait(0.5)
                        TeleportService:TeleportToPlaceInstance(PlaceID, ID, Player)
                    end)
                    wait(4)
                end
            end
        end
    end
    
    while wait() do
        pcall(function()
            TPReturner()
            if foundSomething ~= "" then
                TPReturner()
            end
        end)
    end
end

-- // DARKBEARD LOGIC // --
local function CheckRareItems()
    local Char = Player.Character
    local Backpack = Player.Backpack
    if Char:FindFirstChild("God's Chalice") or Backpack:FindFirstChild("God's Chalice") then
        return "God's Chalice"
    elseif Char:FindFirstChild("Fist of Darkness") or Backpack:FindFirstChild("Fist of Darkness") then
        return "Fist of Darkness"
    end
    return nil
end

local function SummonDarkbeard()
    local AltarPos = CFrame.new(3777, 14, -3499)
    UpdateStatus("Summoning Darkbeard...")
    EquipWeapon("Fist of Darkness")
    Tween(AltarPos)
end

local function FightDarkbeard(Boss)
    UpdateStatus("Fighting Darkbeard...")
    -- Tự động chọn vũ khí Melee hoặc Sword tốt nhất
    local bestWeapon = nil
    for _,v in pairs(Player.Backpack:GetChildren()) do
        if v.ToolTip == "Melee" or v.ToolTip == "Sword" then bestWeapon = v.Name break end
    end
    if bestWeapon then EquipWeapon(bestWeapon) end
    
    local BossHRP = Boss:FindFirstChild("HumanoidRootPart")
    if BossHRP then
        local AttackPos = BossHRP.CFrame * CFrame.new(0, 15, 0)
        getgenv().Seriality = true
        Tween(AttackPos)
    end
end

---
-- // MAIN LOGIC // --
task.spawn(function()
    while task.wait() do
        pcall(function()
            if getgenv().StopScript then return end
            UpdateInfo()
            
            -- Check Rare Item
            local RareItem = CheckRareItems()
            if RareItem == "God's Chalice" then
                getgenv().AutoCollectChest = false
                UpdateStatus("GOT CHALICE! HIDING...")
                SendWebhook("RARE ITEM", "Tìm thấy God's Chalice! Dừng farm để bảo toàn.")
                if game.PlaceId == 7449423635 then Tween(CFrame.new(-12470, 375, -7550)) end
                getgenv().StopScript = true
                return
            -- SỬ DỤNG Settings.AutoDarkBeard
            elseif RareItem == "Fist of Darkness" and Settings.AutoDarkBeard then
                SummonDarkbeard()
                return
            end
            
            -- Check Darkbeard
            local Darkbeard = Workspace.Enemies:FindFirstChild("Darkbeard")
            -- SỬ DỤNG Settings.AutoDarkBeard
            if Darkbeard and Darkbeard:FindFirstChild("Humanoid") and Darkbeard.Humanoid.Health > 0 and Settings.AutoDarkBeard then
                FightDarkbeard(Darkbeard)
                return
            end
            
            -- Auto Chest (Đã sửa đổi logic đếm Beli và Hop Server)
            -- SỬ DỤNG Settings.AutoCollectChest
            if Settings.AutoCollectChest then
                -- SỬ DỤNG Settings.ChestLimit
                if getgenv().CollectedCount >= Settings.ChestLimit then
                    Hop()
                    return
                end

                local Chests = CollectionService:GetTagged("_ChestTagged")
                local NearestChest = nil
                local MinDist = math.huge
                
                for _, Chest in pairs(Chests) do
                    if Chest.Parent and Chest:FindFirstChild("TouchInterest") then
                        local Dist = (Player.Character.HumanoidRootPart.Position - Chest.Position).Magnitude
                        if Dist < MinDist then
                            MinDist = Dist
                            NearestChest = Chest
                        end
                    end
                end
                
                if NearestChest then
                    UpdateStatus("Collecting Chest...")
                    
                    local BeliData = Player:FindFirstChild("Data") and Player.Data:FindFirstChild("Beli")
                    local initialBeli = BeliData and BeliData.Value or 0
                    local beliChanged = false
                    
                    -- Theo dõi sự thay đổi Beli
                    local BeliCheckConnection
                    BeliCheckConnection = BeliData.Changed:Connect(function(newBeliValue)
                        if newBeliValue > initialBeli then
                            beliChanged = true
                        end
                    end)
                    
                    -- Di chuyển đến rương
                    Tween(NearestChest.CFrame)
                    
                    -- Đợi ngắn để rương được nhặt
                    local waitTime = 1 -- Đợi 1 giây để rương nhặt (có thể điều chỉnh)
                    local startTime = tick()
                    while tick() - startTime < waitTime do
                        if beliChanged then break end
                        task.wait()
                    end
                    
                    -- Ngắt kết nối để tránh memory leak
                    BeliCheckConnection:Disconnect()

                    -- Kiểm tra xem Beli có thay đổi (rương đã được nhặt thành công) không
                    if beliChanged then
                        getgenv().CollectedCount = getgenv().CollectedCount + 1
                    end
                    
                else
                    -- Không tìm thấy rương nào
                    UpdateStatus("No Chests found. Hopping...")
                    Hop()
                end
            end
        end)
    end
end)

-- // AUTO HAKI // --
task.spawn(function()
    while task.wait(5) do
        pcall(function()
            if Player.Character and not Player.Character:FindFirstChild("HasBuso") then
                ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end
        end)
    end
end)
