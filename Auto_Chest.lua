getgenv().config = {
    ["Mode"] = "DarkBeard",
    ["Random Fruit"] = true,
    ["Collect Fruit"] = true,
    ["Stop when got item"] = true,
    ["Attacking"] = {
        ["Weapon"] = "Melee",
        ["Factory"] = true,
    }
}

if queue_on_teleport then
    queue_on_teleport([[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/Auto_Chest.lua"))()
    ]])
elseif syn and syn.queue_on_teleport then
    syn.queue_on_teleport([[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/Auto_Chest.lua"))()
    ]])
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/FastAttack.lua"))()

if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        l_Remotes_0.CommF_:InvokeServer("SetTeam", getgenv().team or "Marines")
        wait(3)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end

repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players.LocalPlayer

-- ========== WORLD DETECTION ==========
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
    World1 = true
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
    World2 = true
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
    World3 = true
end

-- ========== SERVICES ==========
local player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local HopServerModule = (loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/HopServerModule.lua")))()

-- ========== MODE SYSTEM (NO CONFLICT) ==========
local Mode = {
    IDLE = 0,
    FRAM_CHEST = 1,
    COLLECT_FRUIT = 2,
    DARKBEARD_SUMMON = 3,
    DARKBEARD_ATTACK = 4,
    FACTORY = 5
}

_G.CurrentMode = Mode.IDLE
_G.PriorityLock = false
_G.ChooseWP = getgenv().config["Attacking"]["Weapon"] or "Melee"

local function SetMode(newMode)
    if _G.PriorityLock then return false end
    _G.CurrentMode = newMode
    return true
end

local function LockMode(duration)
    _G.PriorityLock = true
    task.delay(duration, function()
        _G.PriorityLock = false
    end)
end

-- ========== CONFIG ==========
local TweenSpeed = 350
local UpdateInterval = 1
local ChestCheckInterval = 0.5

-- ========== GUI SETUP ==========
local function createGUI()
    local gui = Instance.new("ScreenGui")
    gui.Name = "DoughOverlay"
    gui.ResetOnSpawn = false
    gui.IgnoreGuiInset = true
    gui.Parent = player:WaitForChild("PlayerGui")

    local background = Instance.new("Frame")
    background.Size = UDim2.new(1, 0, 1, 0)
    background.BackgroundColor3 = Color3.new(0, 0, 0)
    background.BackgroundTransparency = 0.4
    background.Parent = gui

    local topText = Instance.new("TextLabel")
    topText.Size = UDim2.new(1, 0, 0.1, 0)
    topText.Position = UDim2.new(0.5, 0, 0.3, 0)
    topText.AnchorPoint = Vector2.new(0.5, 0)
    topText.BackgroundTransparency = 1
    topText.Text = "Tobii HUB"
    topText.TextColor3 = Color3.fromRGB(255, 255, 255)
    topText.TextScaled = true
    topText.Font = Enum.Font.FredokaOne
    topText.Parent = background

    local statusText = Instance.new("TextLabel")
    statusText.Size = UDim2.new(1, 0, 0.10, 0)
    statusText.Position = UDim2.new(0.5, 0, 0.45, 0)
    statusText.AnchorPoint = Vector2.new(0.5, 0)
    statusText.BackgroundTransparency = 1
    statusText.Text = "Status: Loading..."
    statusText.TextColor3 = Color3.fromRGB(255, 255, 255)
    statusText.TextScaled = true
    statusText.Font = Enum.Font.FredokaOne
    statusText.Parent = background

    local timeLabel = Instance.new("TextLabel")
    timeLabel.Size = UDim2.new(1, 0, 0.05, 0)
    timeLabel.Position = UDim2.new(0, 0, 0.9, 0)
    timeLabel.BackgroundTransparency = 1
    timeLabel.Text = "Time: 0h 0m 0s"
    timeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    timeLabel.TextScaled = true
    timeLabel.Font = Enum.Font.FredokaOne
    timeLabel.Parent = background

    local infoLabel = Instance.new("TextLabel")
    infoLabel.Size = UDim2.new(0.95, 0, 0.05, 0)
    infoLabel.Position = UDim2.new(0.025, 0, 0.94, 0)
    infoLabel.BackgroundTransparency = 1
    infoLabel.TextColor3 = Color3.new(1, 1, 1)
    infoLabel.TextScaled = true
    infoLabel.Font = Enum.Font.FredokaOne
    infoLabel.Text = "Loading..."
    infoLabel.Parent = background

    return gui, statusText, timeLabel, infoLabel
end

local gui, statusText, timeLabel, infoLabel = createGUI()

local function SetStatus(text, color)
    if not statusText then return end
    statusText.Text = "Status: " .. tostring(text)
    if color then
        statusText.TextColor3 = color
    end
end

-- ========== INFO UPDATE ==========
local seconds = 0
task.spawn(function()
    while task.wait(UpdateInterval) do
        seconds += UpdateInterval
        local hrs = math.floor(seconds / 3600)
        local mins = math.floor((seconds % 3600) / 60)
        local secs = math.floor(seconds % 60)
        timeLabel.Text = string.format("Time: %dh %dm %ds", hrs, mins, secs)
        
        pcall(function()
            local data = player.Data
            infoLabel.Text = string.format("Player: %s | Level: %d | Beli: %d | Fragments: %d",
                player.DisplayName,
                data.Level.Value,
                data.Beli.Value,
                data.Fragments.Value
            )
        end)
    end
end)

local function ShowBlackScreen()
    local hopGui = Instance.new("ScreenGui")
    hopGui.Name = "HopUI"
    hopGui.ResetOnSpawn = false
    hopGui.IgnoreGuiInset = true
    hopGui.Parent = game:GetService("CoreGui")

    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.new(0, 0, 0)
    bg.Parent = hopGui

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 0.3, 0)
    text.Position = UDim2.new(0, 0, 0.35, 0)
    text.BackgroundTransparency = 1
    text.Text = "Auto Collect Chest | by Minhieu_.\nHopping Server..."
    text.TextColor3 = Color3.fromRGB(255, 170, 0)
    text.Font = Enum.Font.SourceSansBold
    text.TextScaled = true
    text.Parent = bg
end

-- ========== CHARACTER UTILS ==========
local function getCharacter()
    local char = player.Character
    if not char then
        char = player.CharacterAdded:Wait()
    end
    return char
end

local function getHRP()
    local char = getCharacter()
    return char:WaitForChild("HumanoidRootPart", 3)
end

-- ========== NOCLIP (FIXED) ==========
local BodyClip = nil
task.spawn(function()
    while task.wait(0.5) do
        if _G.CurrentMode ~= Mode.IDLE then
            pcall(function()
                local char = player.Character
                if not char then return end
                
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp and not hrp:FindFirstChild("BodyClip") then
                    BodyClip = Instance.new("BodyVelocity")
                    BodyClip.Name = "BodyClip"
                    BodyClip.Parent = hrp
                    BodyClip.MaxForce = Vector3.new(100000, 100000, 100000)
                    BodyClip.Velocity = Vector3.zero
                end
            end)
        end
    end
end)

local noclipConnection
task.spawn(function()
    pcall(function()
        noclipConnection = RunService.Stepped:Connect(function()
            if _G.CurrentMode ~= Mode.IDLE then
                local char = player.Character
                if not char then return end
                
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end)
end)

-- Anti-stun
task.spawn(function()
    player.CharacterAdded:Connect(function(char)
        local stun = char:WaitForChild("Stun", 5)
        if stun then
            stun.Changed:Connect(function()
                stun.Value = 0
            end)
        end
    end)
end)

-- ========== WEAPON SELECTION ==========
spawn(function()
    while wait(0.1) do
        pcall(function()
            if _G.ChooseWP == "Melee" then
                for e, A in pairs(player.Backpack:GetChildren()) do
                    if A.ToolTip == "Melee" then
                        if player.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            elseif _G.ChooseWP == "Sword" then
                for e, A in pairs(player.Backpack:GetChildren()) do
                    if A.ToolTip == "Sword" then
                        if player.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            elseif _G.ChooseWP == "Gun" then
                for e, A in pairs(player.Backpack:GetChildren()) do
                    if A.ToolTip == "Gun" then
                        if player.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            elseif _G.ChooseWP == "Blox Fruit" then
                for e, A in pairs(player.Backpack:GetChildren()) do
                    if A.ToolTip == "Blox Fruit" then
                        if player.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            end
        end)
    end
end)

-- ========== TWEEN MOVEMENT ==========
local currentTween = nil

local function Tween(targetCFrame)
    if currentTween then
        currentTween:Cancel()
    end
    
    local char = getCharacter()
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    
    if player.Character.Humanoid.Sit == true then
        player.Character.Humanoid.Sit = false
    end
    local distance = (targetCFrame.Position - hrp.Position).Magnitude
    local speed = distance >= 350 and TweenSpeed or TweenSpeed * 0.8
    
    local tweenInfo = TweenInfo.new(
        distance / speed,
        Enum.EasingStyle.Linear,
        Enum.EasingDirection.Out
    )
    
    currentTween = TweenService:Create(hrp, tweenInfo, {CFrame = targetCFrame})
    currentTween:Play()
    
    return currentTween
end

function AutoHaki()
    if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function EquipWeapon(e)
    if not e then return end
    if player.Backpack:FindFirstChild(e) then
        player.Character.Humanoid:EquipTool(player.Backpack:FindFirstChild(e))
    end
end

local O = {}
O.__index = O

function O.Kill(e, A)
    if not e or not A then return end
    
    local humanoidRootPart = e:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    
    if not e:GetAttribute("Locked") then
        e:SetAttribute("Locked", humanoidRootPart.CFrame)
    end
    
    PosMon = e:GetAttribute("Locked").Position
    AutoHaki()
    EquipWeapon(_G.SelectWeapon)
    
    local tool = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool")
    if not tool then return end
    
    local toolTip = tool.ToolTip
    
    local initialOffset = CFrame.new(0, toolTip == "Blox Fruit" and 10 or 30, 0)
    local initialRotation = CFrame.Angles(0, math.rad(toolTip == "Blox Fruit" and 90 or 180), 0)
    Tween(humanoidRootPart.CFrame * initialOffset * initialRotation)
    
    task.wait(0.2)
    
    local offsets = {
        Vector3.new(0, 30, 30),
        Vector3.new(30, 30, 0),
        Vector3.new(0, 30, -30),
        Vector3.new(-30, 30, 0)
    }
    
    for _, offset in ipairs(offsets) do
        if not e or not e.Parent then break end
        if not humanoidRootPart then break end
        
        Tween(humanoidRootPart.CFrame * CFrame.new(offset))
        task.wait(0.15)
    end
end

local function FindFruit()
    for _,obj in pairs(workspace:GetChildren()) do
        if obj:IsA("Tool") and string.find(obj.Name, "Fruit") then
            local handle = obj:FindFirstChild("Handle")
            if handle then
                return handle
            end
        end
    end
    return nil
end

function StoreFruit()
    local backpack = game.Players.LocalPlayer.Backpack
    local remoteFolder = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
    local commF = remoteFolder:WaitForChild("CommF_")
    
    for _, item in pairs(backpack:GetChildren()) do
        if item:FindFirstChild("EatRemote") then
            local fruitName = item:GetAttribute("OriginalName") or item.Name
            
            local success, result = pcall(function()
                return commF:InvokeServer("StoreFruit", fruitName, item)
            end)
            
            if success then
                print("Đã store fruit: " .. fruitName)
            end
        end
    end
end

-- Auto store fruit
spawn(function()
    while true do
        wait(1)
        StoreFruit()
    end
end)

game.Players.LocalPlayer.Backpack.ChildAdded:Connect(function(item)
    wait(1)
    
    if item:FindFirstChild("EatRemote") then
        local remoteFolder = game:GetService("ReplicatedStorage"):WaitForChild("Remotes")
        local commF = remoteFolder:WaitForChild("CommF_")
        local fruitName = item:GetAttribute("OriginalName") or item.Name
        
        pcall(function()
            commF:InvokeServer("StoreFruit", fruitName, item)
        end)
    end
end)

function GetBP(e)
    return player.Backpack:FindFirstChild(e) or player.Character:FindFirstChild(e)
end

function GetM(e)
    for A, u in pairs(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getInventory")) do
        if type(u) == "table" then
            if u.Type == "Material" then
                if u.Name == e then
                    return u.Count
                end
            end
        end
    end
    return 0
end

function GetConnectionEnemies(e)
    for A, u in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
        if u:IsA("Model") and ((typeof(e) == "table" and table.find(e, u.Name) or u.Name == e) and (u:FindFirstChild("Humanoid") and u.Humanoid.Health > 0)) then
            return u
        end
    end
    for A, u in next, game.Workspace.Enemies:GetChildren() do
        if u:IsA("Model") and ((typeof(e) == "table" and table.find(e, u.Name) or u.Name == e) and (u:FindFirstChild("Humanoid") and u.Humanoid.Health > 0)) then
            return u
        end
    end
end

local RemoveDamage = true
spawn(function()
    while wait(.1) do
        pcall(function()
            if RemoveDamage then
                game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = false
                player.PlayerGui.Notifications.Enabled = false
            else
                game:GetService("ReplicatedStorage").Assets.GUI.DamageCounter.Enabled = true
                player.PlayerGui.Notifications.Enabled = true
            end
        end)
    end
end)

-- ========== MAIN CONTROLLER (NO CONFLICT) ==========
task.spawn(function()
    while task.wait(ChestCheckInterval) do
        local fruit = FindFruit()
        local darkbeardEnemy = GetConnectionEnemies("Darkbeard")
        local coreEnemy = GetConnectionEnemies("Core")
        
        -- PRIORITY 1: Collect Fruit (Highest)
        if fruit and getgenv().config["Collect Fruit"] then
            if SetMode(Mode.COLLECT_FRUIT) then
                SetStatus("Collecting Fruit", Color3.fromRGB(255, 215, 0))
                Tween(fruit.CFrame)
                LockMode(2)
            end
            
        -- PRIORITY 2: DarkBeard Attack
        elseif getgenv().config["Mode"] == "DarkBeard" and darkbeardEnemy then
            if SetMode(Mode.DARKBEARD_ATTACK) then
                SetStatus("Attacking DarkBeard", Color3.fromRGB(255, 0, 0))
                repeat
                    O.Kill(darkbeardEnemy, true)
                    wait(0.1)
                    darkbeardEnemy = GetConnectionEnemies("Darkbeard")
                until not darkbeardEnemy or darkbeardEnemy.Humanoid.Health <= 0
                LockMode(1)
            end
            
        -- PRIORITY 3: DarkBeard Summon
        elseif getgenv().config["Mode"] == "DarkBeard" and GetBP("Fist of Darkness") and not darkbeardEnemy then
            if SetMode(Mode.DARKBEARD_SUMMON) then
                SetStatus("Summoning DarkBeard", Color3.fromRGB(255, 165, 0))
                EquipWeapon("Fist of Darkness")
                Tween(CFrame.new(3775.789551, 14.910309, -3499.971191))
                wait(0.5)
                Tween(CFrame.new(3776.124756, 14.910310, -3500.035645))
                LockMode(3)
            end
            
        -- PRIORITY 4: Factory
        elseif getgenv().config["Attacking"]["Factory"] and coreEnemy then
            if SetMode(Mode.FACTORY) then
                SetStatus("Attacking Factory Core", Color3.fromRGB(0, 255, 255))
                repeat
                    Tween(CFrame.new(448.46756, 199.356781, -441.389252))
                    wait(0.1)
                    coreEnemy = GetConnectionEnemies("Core")
                until not coreEnemy or coreEnemy.Humanoid.Health <= 0
                LockMode(1)
            end
            
        -- PRIORITY 5: Fram Chest (Default)
        else
            if SetMode(Mode.FRAM_CHEST) then
                SetStatus("Farming Chests", Color3.fromRGB(255, 255, 255))
                
                pcall(function()
                    local e = game:GetService("CollectionService")
                    local C = e:GetTagged("_ChestTagged")
                    local char = getCharacter()
                    if not char then return end
                    
                    local X = char:GetPivot().Position
                    local v, o = math.huge, nil
                    
                    for i = 1, #C do
                        local chest = C[i]
                        local dist = ((chest:GetPivot()).Position - X).Magnitude
                        if not chest:GetAttribute("IsDisabled") and dist < v then
                            v = dist
                            o = chest
                        end
                    end
                    
                    if o then
                        local tweenResult = Tween(o:GetPivot())
                        if tweenResult and tweenResult.Completed then
                            tweenResult.Completed:Wait()
                        else
                            wait(v / 100)
                        end
                        char.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end)
            end
        end
        
        -- STOP CONDITION
        if getgenv().config["Stop when got item"] and getgenv().config["Mode"] ~= "DarkBeard" then
            if GetBP("Fist of Darkness") or GetBP("God's Chalice") then
                _G.CurrentMode = Mode.IDLE
                SetStatus("Got Item! Stopping...", Color3.fromRGB(0, 255, 0))
                if World2 then
                    Tween(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
                elseif World3 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                        "requestEntrance",
                        Vector3.new(-12471.17, 374.94, -7551.68)
                    )
                end
                break
            end
        end
    end
end)

-- ========== RANDOM FRUIT ==========
spawn(function()
    while wait(5) do
        pcall(function()
            if getgenv().config["Random Fruit"] then
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Cousin", "Buy")
            end
        end)
    end
end)

-- ========== AUTO HOP SERVER ==========
task.delay(150, function()
    while task.wait(5) do
        if _G.CurrentMode == Mode.FRAM_CHEST then
            ShowBlackScreen()
            task.wait(3)
            HopServerModule:Teleport()
        end
    end
end)
