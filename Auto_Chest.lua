loadstring(game:HttpGet("https://raw.githubusercontent.com/AnhDzaiScript/Setting/refs/heads/main/FastMax.lua"))()
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

if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
    World1 = true;
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
    World2 = true;
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
    World3 = true;
end;

getgenv().config = {
    ["Mode"] = "DarkBeard",
    ["Random Fruit"] = true,
    ["Collect Fruit"] = true,
    ["Stop when got item"] = true,
    ["Attacking"] = {
        ["Weapon"] = "Melee",
    }
}

local player = game.Players.LocalPlayer
local plr = player -- FIX: Thêm biến plr
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local HopServerModule = (loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/HopServerModule.lua")))()

-- ========== CONFIG ==========
local TweenSpeed = 350
local UpdateInterval = 1
local ChestCheckInterval = 0.3
_G.FramChest = false
_G.DarkBeard = false
_G.ChooseWP = getgenv().config["Attacking"]["Weapon"] or "Melee"

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

-- ========== CHEST CACHE ==========
local ChestCache = {}
local LastChestUpdate = 0
local ChestUpdateCooldown = 0.15 -- giảm để tránh cache rỗng

local function isValidChest(part)
    return part
        and part:IsA("BasePart")
        and part.Parent
        and part:IsDescendantOf(Workspace)
        and part:FindFirstChild("TouchInterest")
end

local function updateChestCache(force)
    local now = tick()

    if not force and (now - LastChestUpdate) < ChestUpdateCooldown and #ChestCache > 0 then
        return ChestCache
    end

    LastChestUpdate = now
    table.clear(ChestCache)

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj.Name:find("Chest") then
            if isValidChest(obj) then
                table.insert(ChestCache, obj)
            else
                local part = obj:FindFirstChildWhichIsA("BasePart")
                if isValidChest(part) then
                    table.insert(ChestCache, part)
                end
            end
        end
    end

    return ChestCache
end

-- ========== GET CLOSEST CHEST ==========
local function getClosestChest()
    local hrp = getHRP()
    if not hrp then return nil end

    local chests = updateChestCache()
    if not chests or #chests == 0 then
        chests = updateChestCache(true) -- ép scan lại
        if #chests == 0 then return nil end
    end

    local rootPos = hrp.Position
    local closest, minDist = nil, math.huge

    for _, chest in ipairs(chests) do
        if isValidChest(chest) then
            local dist = (rootPos - chest.Position).Magnitude
            if dist < minDist then
                minDist = dist
                closest = chest
            end
        end
    end

    return closest
end


-- ========== NOCLIP ==========
local BodyClip = nil
task.spawn(function()
    while task.wait(0.5) do
        if _G.FramChest or _G.DarkBeard then
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
            if _G.FramChest or _G.DarkBeard then
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
                for e, A in pairs(plr.Backpack:GetChildren()) do
                    if A.ToolTip == "Melee" then
                        if plr.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            elseif _G.ChooseWP == "Sword" then
                for e, A in pairs(plr.Backpack:GetChildren()) do
                    if A.ToolTip == "Sword" then
                        if plr.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            elseif _G.ChooseWP == "Gun" then
                for e, A in pairs(plr.Backpack:GetChildren()) do
                    if A.ToolTip == "Gun" then
                        if plr.Backpack:FindFirstChild(tostring(A.Name)) then
                            _G.SelectWeapon = A.Name
                        end
                    end
                end
            elseif _G.ChooseWP == "Blox Fruit" then
                for e, A in pairs(plr.Backpack:GetChildren()) do
                    if A.ToolTip == "Blox Fruit" then
                        if plr.Backpack:FindFirstChild(tostring(A.Name)) then
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
    
    if RandomCFrame then
        task.wait(0.2)
        
        local offsets = {
            Vector3.new(0, 30, 30),
            Vector3.new(30, 30, 0),
            Vector3.new(0, 30, 30),
            Vector3.new(-30, 30, 0)
        }
        
        for _, offset in ipairs(offsets) do
            if not e or not e.Parent then break end
            if not humanoidRootPart then break end
            
            Tween(humanoidRootPart.CFrame * CFrame.new(offset))
            task.wait(0.15)
        end
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
            else
                print("Lỗi khi store fruit: " .. fruitName .. " - " .. tostring(result))
            end
        end
    end
end

function GetBP(e)
    return player.Backpack:FindFirstChild(e) or player.Character:FindFirstChild(e)
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

-- ========== CHEST FARMING ==========
local lastJumpedChest = nil
local lastJumpTime = 0
local jumpCooldown = 1

task.spawn(function()
    while task.wait(0.1) do
        if _G.FramChest then
            SetStatus("Fram Chest", Color3.fromRGB(255, 255, 255))
            task.wait(ChestCheckInterval)

            local chest = getClosestChest()
            local fruit = FindFruit()
            
            if chest then
                Tween(chest.CFrame)

                local char = player.Character
                local hrp = char and char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildOfClass("Humanoid")

                if hrp and hum then
                    local dist = (hrp.Position - chest.Position).Magnitude
                    local now = tick()

                    if dist < 8 and chest ~= lastJumpedChest and (now - lastJumpTime) > jumpCooldown then
                        lastJumpedChest = chest
                        lastJumpTime = now
                        task.wait(0.5)
                        hum:ChangeState(Enum.HumanoidStateType.Jumping)
                    end

                    if dist > 15 and chest == lastJumpedChest then
                        lastJumpedChest = nil
                    end
                end
            end

            if fruit and getgenv().config["Collect Fruit"] then
                SetStatus("Collecting Fruit", Color3.fromRGB(255, 255, 255))
                _G.FramChest = false
                Tween(fruit.CFrame)
                task.wait(1)
                StoreFruit()
                _G.FramChest = true
            end

            if getgenv().config["Stop when got item"] and getgenv().config["Mode"] == "Normal" then
                if GetBP("Fist of Darkness") or GetBP("God's Chalice") then
                    _G.FramChest = false
                    if World2 then
                        Tween(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))
                    elseif World3 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(
                            "requestEntrance",
                            Vector3.new(-12471.17, 374.94, -7551.68)
                        )
                    end
                end
            end
        end
    end
end)

-- ========== DARK BEARD MODE ==========
task.spawn(function()
    if getgenv().config["Mode"] == "DarkBeard" then
        _G.DarkBeard = true
        
        while task.wait(0.1) do
            if _G.DarkBeard then
                if not workspace.Enemies:FindFirstChild("Darkbeard") and GetBP("Fist of Darkness") then
                    SetStatus("Summon Dark Beard", Color3.fromRGB(255, 255, 255))
                    _G.FramChest = false
                    EquipWeapon("Fist of Darkness")
                    Tween(CFrame.new(3776, 15, -3500))
                    
                elseif GetConnectionEnemies("Darkbeard") or workspace.Enemies:FindFirstChild("Darkbeard") then
                    SetStatus("Attack Dark Beard", Color3.fromRGB(255, 255, 255))
                    _G.FramChest = false
                    local e = GetConnectionEnemies("Darkbeard")
                    if e then
                        repeat
                            wait()
                            O.Kill(e, _G.DarkBeard)
                        until _G.DarkBeard == false or not e.Parent or e.Humanoid.Health <= 0
                    end
                    
                elseif not GetBP("Fist of Darkness") and not GetConnectionEnemies("Darkbeard") then
                    _G.FramChest = true
                end
            end
        end
    else
        -- FIX: Bật farm chest cho mode Normal
        _G.FramChest = true
        print("Mode Normal - Auto Farm Chest Started!")
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
task.delay(240, function()
    while task.wait(5) do
        if _G.FramChest then
            ShowBlackScreen()
            task.wait(3)
            HopServerModule:Teleport()
        end
    end
end)
