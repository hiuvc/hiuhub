-- Auto Parry (improved, with diagnostics)
-- Toggle bằng P, hiển thị notify, in debug, cố gắng dùng keypress hoặc remote

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Stats = game:GetService("Stats")

local Player = Players.LocalPlayer
if not Player then
    warn("[AutoParry] Không tìm thấy Players.LocalPlayer")
    return
end

-- cấu hình
getgenv().AutoParryKeypress = true         -- ưu tiên nhấn phím F nếu có VirtualInputManager
getgenv().RandomParryAccuracyEnabled = false
getgenv().AutoAbility = false
getgenv().CooldownProtection = false

local Selected_Parry_Type = "Default"
local Speed_Divisor_Multiplier = 1
local SuccessfulParryCount = 0

local function Notify(title, text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {Title = title, Text = text, Duration = duration or 3})
    end)
end

-- đợi character sẵn sàng
repeat task.wait() until Player.Character and Player.Character.PrimaryPart

-- try lấy VirtualInputManager (exploit)
local VirtualInputManager = nil
pcall(function()
    VirtualInputManager = game:GetService("VirtualInputManager")
end)

-- fallback VirtualUser (không chắc parry bằng key F)
local VirtualUser = nil
pcall(function()
    VirtualUser = game:GetService("VirtualUser")
end)

-- tìm remote có tên liên quan đến "parry"
local function find_parry_remote()
    local candidates = {}
    if ReplicatedStorage:FindFirstChild("Remotes") then
        for _, r in pairs(ReplicatedStorage.Remotes:GetChildren()) do
            if (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) and r.Name:lower():find("parry") then
                table.insert(candidates, r)
            end
        end
    end
    for _, r in pairs(ReplicatedStorage:GetChildren()) do
        if (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) and r.Name:lower():find("parry") then
            table.insert(candidates, r)
        end
    end
    return candidates[1]
end

local ParryRemote = find_parry_remote()
if ParryRemote then
    warn("[AutoParry] Tìm thấy Parry remote:", ParryRemote:GetFullName())
else
    warn("[AutoParry] Không tìm thấy Parry remote trong ReplicatedStorage.Remotes (sẽ thử keypress).")
end

-- Lấy balls: ưu tiên workspace.Balls, fallback scan
local function get_balls()
    local list = {}
    if workspace:FindFirstChild("Balls") then
        for _, v in pairs(workspace.Balls:GetChildren()) do
            table.insert(list, v)
        end
        return list
    end
    -- fallback: scan BaseParts có 'ball' trong tên
    for _, obj in pairs(workspace:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("ball") then
            table.insert(list, obj)
        end
        if obj:IsA("Model") and obj.Name:lower():find("ball") then
            table.insert(list, obj.PrimaryPart or obj)
        end
    end
    return list
end

local Last_Parry = 0
local Parried = false
local connection = nil
local AutoParryEnabled = false

-- helper: simulate press F (tries VirtualInputManager first)
local function try_press_F()
    if VirtualInputManager then
        local ok, err = pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.F, false, game)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.F, false, game)
        end)
        if ok then
            return true, "VirtualInputManager"
        else
            return false, "VIM error: "..tostring(err)
        end
    end
    -- fallback: VirtualUser -> không guarantee nhấn F, nhưng vẫn thử
    if VirtualUser then
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton1(Vector2.new(0,0))
        end)
        return false, "VirtualUser (fallback click)"
    end
    return false, "No input API"
end

-- helper: try remote fire
local function try_remote_parry(remote)
    if not remote then return false, "no remote" end
    local ok, err = pcall(function()
        -- thử gọi không tham số trước
        if remote:IsA("RemoteEvent") then
            remote:FireServer()
        else
            remote:InvokeServer()
        end
    end)
    return ok, ok and "RemoteEvent fired" or ("remote error: "..tostring(err))
end

local function do_parry(parryType)
    -- ưu tiên keypress nếu bật và có VIM
    if getgenv().AutoParryKeypress then
        local ok, msg = try_press_F()
        if ok then
            return true, "keypress via "..msg
        else
            -- nếu keypress thất bại nhưng có remote, thử remote
            if ParryRemote then
                local ok2, msg2 = try_remote_parry(ParryRemote)
                if ok2 then return true, "remote fallback ("..tostring(ParryRemote.Name)..")" end
                return false, "keypress failed ("..tostring(msg)..") and remote failed ("..tostring(msg2)..")"
            end
            return false, "keypress failed ("..tostring(msg)..") and no remote"
        end
    else
        if ParryRemote then
            local ok, msg = try_remote_parry(ParryRemote)
            return ok, msg
        else
            local ok, msg = try_press_F()
            return ok, "no remote, tried keypress => "..tostring(msg)
        end
    end
end

-- main loop
local function StartAutoParry()
    if connection then connection:Disconnect() end
    connection = RunService.PreSimulation:Connect(function()
        if not Player.Character or not Player.Character.PrimaryPart then return end
        local balls = get_balls()
        if #balls == 0 then
            -- debug: show that no balls found
            -- warn("[AutoParry] Không tìm thấy bóng nào trong workspace.Balls hoặc qua scan.")
        end
        for _, Ball in ipairs(balls) do
            if Ball and Ball:IsDescendantOf(workspace) then
                local zoomies = Ball:FindFirstChild("zoomies")
                -- một số map dùng attribute realBall hoặc child 'ff' để nhận diện
                if not zoomies then
                    -- DEBUG: nếu Ball có attribute realBall hoặc child 'ff' thì vẫn xử lý
                    if not Ball:GetAttribute("realBall") and not Ball:FindFirstChild("ff") then
                        -- không phải real ball -> skip
                        -- continue equivalent:
                        -- (skip to next)
                    else
                        -- có realBall/ff nhưng không có zoomies: đặt vector 0
                    end
                end

                -- lấy velocity (fallback 0)
                local velocity = Vector3.new(0,0,0)
                if zoomies and zoomies:FindFirstChild("VectorVelocity") then
                    velocity = zoomies.VectorVelocity
                elseif zoomies and zoomies.VectorVelocity then
                    velocity = zoomies.VectorVelocity
                else
                    -- đôi khi là property VectorVelocity trực tiếp
                    if zoomies and zoomies.VectorVelocity then velocity = zoomies.VectorVelocity end
                end

                local speed = 0
                if typeof(velocity) == "Vector3" then
                    speed = velocity.Magnitude
                elseif typeof(velocity) == "userdata" and velocity.Magnitude then
                    speed = velocity.Magnitude
                end

                -- target check (nhiều game set attribute "target" = tostring(player) hoặc Player.Name)
                local targetAttr = nil
                pcall(function() targetAttr = Ball:GetAttribute("target") end)
                local targetMatches = (targetAttr and (targetAttr == tostring(Player) or targetAttr == Player.Name))

                -- distance
                local dist = math.huge
                pcall(function()
                    dist = (Player.Character.PrimaryPart.Position - Ball.Position).Magnitude
                end)

                local ping = 0
                pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue() / 10 end)
                local ping_threshold = math.clamp(ping / 10, 5, 17)
                local cappedSpeedDiff = math.min(math.max(speed - 9.5, 0), 650)
                local speed_divisor_base = 2.4 + cappedSpeedDiff * 0.002
                local effectiveMultiplier = Speed_Divisor_Multiplier or 1
                if getgenv().RandomParryAccuracyEnabled then
                    if speed < 200 then
                        effectiveMultiplier = 0.7 + (math.random(40, 100) - 1) * (0.35 / 99)
                    else
                        effectiveMultiplier = 0.7 + (math.random(1, 100) - 1) * (0.35 / 99)
                    end
                end
                local speed_divisor = speed_divisor_base * effectiveMultiplier
                local Parry_Accuracy = ping_threshold + math.max(speed / speed_divisor, 9.5)

                -- debug condition output (tắt nếu bạn ko cần)
                -- warn(("[AutoParry] ball=%s target=%s dist=%.2f speed=%.2f acc=%.2f"):format(
                --     tostring(Ball.Name), tostring(targetAttr), dist, speed, Parry_Accuracy))

                if targetMatches and dist <= Parry_Accuracy then
                    if getgenv().AutoAbility and false then
                        -- nếu cần check skill -> gọi AutoAbility (bỏ trống)
                    end
                    if getgenv().CooldownProtection and false then
                        -- nếu cần check cooldown -> gọi cooldownProtection (bỏ trống)
                    end

                    -- tránh spam liên tục
                    local now = os.clock()
                    if now - Last_Parry < 0.45 then
                        -- skip
                    else
                        Last_Parry = now
                        local ok, info = pcall(do_parry, Selected_Parry_Type)
                        local success, msg = do_parry(Selected_Parry_Type)
                        if success then
                            SuccessfulParryCount += 1
                            Parried = true
                        else
                            warn(("❌ AutoParry: thất bại -> %s"):format(tostring(msg)))
                            -- hiển thị 1 notify nhỏ để debug
                            Notify("Auto Parry", "Thất bại: "..tostring(msg), 2)
                        end
                    end

                    -- đợi 1s hoặc đến khi Parried false
                    local t0 = tick()
                    repeat task.wait() until (tick() - t0) >= 1 or not Parried
                    Parried = false
                end
            end
        end
    end)
    AutoParryEnabled = true
    Notify("Auto Parry", "✅ ĐÃ BẬT", 3)
    warn("[AutoParry] STARTED")
end

local function StopAutoParry()
    if connection then
        connection:Disconnect()
        connection = nil
    end
    AutoParryEnabled = false
    Notify("Auto Parry", "⛔ ĐÃ TẮT", 3)
    warn("[AutoParry] STOPPED")
end

-- Hotkey P toggle
UserInputService.InputBegan:Connect(function(input, processed)
    if processed then return end
    if input.KeyCode == Enum.KeyCode.P then
        if AutoParryEnabled then StopAutoParry() else StartAutoParry() end
    end
end)
-- Tạo nút bật/tắt cho mobile
local function createMobileButton()
    local playerGui = Player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "AutoParryMobileGUI"
    screenGui.ResetOnSpawn = false
    screenGui.Parent = playerGui

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 120, 0, 50)
    button.Position = UDim2.new(0.5, -60, 0.9, -25) -- ở giữa dưới màn hình
    button.Text = AutoParryEnabled and "Auto Parry: ON" or "Auto Parry: OFF"
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.SourceSansBold
    button.TextScaled = true
    button.Parent = screenGui

    button.MouseButton1Click:Connect(function()
        if AutoParryEnabled then
            StopAutoParry()
            button.Text = "Auto Parry: OFF"
        else
            StartAutoParry()
            button.Text = "Auto Parry: ON"
        end
    end)
end

-- tạo button khi script load
createMobileButton()

Notify("Auto Parry", "⚡ Script loaded! Nhấn P để bật/tắt", 4)
warn("[AutoParry] Ready. Press P to toggle.")
