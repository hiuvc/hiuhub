-- Ultra Auto Parry V3 + Arrow Debug + Impact Prediction

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

local Player = Players.LocalPlayer
if not Player then warn("[UltraAutoParryV3] No LocalPlayer") return end

-- Config
getgenv().AutoParryKeypress = true
getgenv().RandomParryAccuracyEnabled = false
local Selected_Parry_Type = "Default"
local SuccessfulParryCount = 0

local function Notify(title,text,duration)
    pcall(function()
        StarterGui:SetCore("SendNotification",{Title=title,Text=text,Duration=duration or 3})
    end)
end

repeat task.wait() until Player.Character and Player.Character.PrimaryPart

-- Input APIs
local VirtualInputManager = nil
pcall(function() VirtualInputManager = game:GetService("VirtualInputManager") end)
local VirtualUser = nil
pcall(function() VirtualUser = game:GetService("VirtualUser") end)

-- Parry Remote
local function find_parry_remote()
    local candidates = {}
    if ReplicatedStorage:FindFirstChild("Remotes") then
        for _, r in pairs(ReplicatedStorage.Remotes:GetChildren()) do
            if (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) and r.Name:lower():find("parry") then
                table.insert(candidates,r)
            end
        end
    end
    for _, r in pairs(ReplicatedStorage:GetChildren()) do
        if (r:IsA("RemoteEvent") or r:IsA("RemoteFunction")) and r.Name:lower():find("parry") then
            table.insert(candidates,r)
        end
    end
    return candidates[1]
end

local ParryRemote = find_parry_remote()
if ParryRemote then warn("[UltraAutoParryV3] Found Parry remote:",ParryRemote:GetFullName())
else warn("[UltraAutoParryV3] No Parry remote found. Using keypress fallback.") end

-- Get balls
local function get_balls()
    local list = {}
    if Workspace:FindFirstChild("Balls") then
        for _, v in pairs(Workspace.Balls:GetChildren()) do table.insert(list,v) end
        return list
    end
    for _, obj in pairs(Workspace:GetChildren()) do
        if obj:IsA("BasePart") and obj.Name:lower():find("ball") then table.insert(list,obj) end
        if obj:IsA("Model") and obj.Name:lower():find("ball") then table.insert(list,obj.PrimaryPart or obj) end
    end
    return list
end

-- Parry helpers
local Last_Parry = 0
local connection = nil
local AutoParryEnabled = false

local function try_press_F()
    if VirtualInputManager then
        local ok,err = pcall(function()
            VirtualInputManager:SendKeyEvent(true,Enum.KeyCode.F,false,game)
            VirtualInputManager:SendKeyEvent(false,Enum.KeyCode.F,false,game)
        end)
        if ok then return true,"VirtualInputManager" else return false,"VIM error: "..tostring(err) end
    end
    if VirtualUser then
        pcall(function() VirtualUser:CaptureController(); VirtualUser:ClickButton1(Vector2.new(0,0)) end)
        return false,"VirtualUser fallback click"
    end
    return false,"No input API"
end

local function try_remote_parry(remote)
    if not remote then return false,"no remote" end
    local ok,err = pcall(function()
        if remote:IsA("RemoteEvent") then remote:FireServer() else remote:InvokeServer() end
    end)
    return ok,ok and "RemoteEvent fired" or ("remote error: "..tostring(err))
end

local function do_parry(parryType)
    if getgenv().AutoParryKeypress then
        local ok,msg = try_press_F()
        if ok then return true,"keypress via "..msg end
        if ParryRemote then
            local ok2,msg2 = try_remote_parry(ParryRemote)
            if ok2 then return true,"remote fallback ("..tostring(ParryRemote.Name)..")" end
            return false,"keypress failed ("..tostring(msg)..") and remote failed ("..tostring(msg2)..")"
        end
        return false,"keypress failed ("..tostring(msg)..") and no remote"
    else
        if ParryRemote then return try_remote_parry(ParryRemote)
        else local ok,msg=try_press_F() return ok,"no remote, tried keypress => "..tostring(msg) end
    end
end

-- Arrow visuals
local ballArrows = {}

local function createArrow(ball)
    if ballArrows[ball] and ballArrows[ball].Parent then return ballArrows[ball] end
    local arrow = Instance.new("Part")
    arrow.Size = Vector3.new(0.2,0.2,2)
    arrow.Anchored = true
    arrow.CanCollide = false
    arrow.Material = Enum.Material.Neon
    arrow.Parent = Workspace
    ballArrows[ball] = arrow
    return arrow
end

local function removeArrow(ball)
    if ballArrows[ball] then
        if ballArrows[ball].Parent then ballArrows[ball]:Destroy() end
        ballArrows[ball] = nil
    end
end

-- Main Loop + Impact Prediction + Arrow Debug
local function StartUltraParryV3()
    if connection then connection:Disconnect() end

    connection = RunService.PreSimulation:Connect(function()
        if not Player.Character or not Player.Character.PrimaryPart then return end
        local balls = get_balls()

        -- Xóa arrow của các quả cầu đã biến mất
        for ball,_ in pairs(ballArrows) do
            if not ball or not ball:IsDescendantOf(Workspace) then removeArrow(ball) end
        end

        local charPos = Player.Character.PrimaryPart.Position
        local ping = 0
        pcall(function() ping = Stats.Network.ServerStatsItem["Data Ping"]:GetValue()/10 end)
        local ping_factor = math.clamp(ping/10, 5, 15)

        for _, Ball in ipairs(balls) do
            if not Ball or not Ball:IsDescendantOf(Workspace) then continue end

            local zoomies = Ball:FindFirstChild("zoomies")
            local velocity = Vector3.new(0,0,0)
            if zoomies then
                if zoomies:FindFirstChild("VectorVelocity") then velocity = zoomies.VectorVelocity
                elseif zoomies.VectorVelocity then velocity = zoomies.VectorVelocity end
            end
            local speed = typeof(velocity)=="Vector3" and velocity.Magnitude or 0
            if speed < 0.01 then
                removeArrow(Ball)
                continue
            end

            -- target check
            local targetAttr
            pcall(function() targetAttr = Ball:GetAttribute("target") end)
            local targetMatches = (targetAttr and (targetAttr==tostring(Player) or targetAttr==Player.Name))

            -- Time-to-impact prediction
            local dist = (Ball.Position - charPos).Magnitude
            local advanceTime = math.clamp(0.05 + (speed/150) + math.abs(velocity.Y)/50, 0.05, 0.18)
            local predictedPos = Ball.Position + velocity * advanceTime
            local predictedDist = (predictedPos - charPos).Magnitude

            -- Dynamic Parry Accuracy
            local baseAccuracy = 9.5 + ping_factor + (speed/2.4)
            local Parry_Accuracy = baseAccuracy + (speed * advanceTime)
            if getgenv().RandomParryAccuracyEnabled then
                Parry_Accuracy = Parry_Accuracy*(0.7 + math.random()*0.35)
            end

            -- Arrow debug
            local arrow = createArrow(Ball)
            local dir = (predictedPos - Ball.Position).Unit
            arrow.Size = Vector3.new(0.2,0.2,(predictedPos - Ball.Position).Magnitude)
            arrow.CFrame = CFrame.new(Ball.Position + dir*((predictedPos - Ball.Position).Magnitude/2), predictedPos)
            if targetMatches and predictedDist <= Parry_Accuracy then
                arrow.Color = Color3.fromRGB(255,0,0)
            else
                arrow.Color = Color3.fromRGB(255,255,0)
            end

            -- Parry
            if targetMatches and predictedDist <= Parry_Accuracy then
                local now = os.clock()
                if now - Last_Parry < 0.01 then continue end
                Last_Parry = now
                local success, info = do_parry(Selected_Parry_Type)
                if success then SuccessfulParryCount += 1 end
            end
        end
    end)

    AutoParryEnabled = true
    Notify("Ultra Auto Parry V3", "✅ ĐÃ BẬT", 3)
    warn("[UltraAutoParryV3] STARTED")
end

local function StopUltraParryV3()
    if connection then connection:Disconnect() connection=nil end
    for ball,_ in pairs(ballArrows) do removeArrow(ball) end
    AutoParryEnabled=false
    Notify("Ultra Auto Parry V3","⛔ ĐÃ TẮT",3)
    warn("[UltraAutoParryV3] STOPPED")
end

-- Hotkey P
UserInputService.InputBegan:Connect(function(input,processed)
    if processed then return end
    if input.KeyCode==Enum.KeyCode.P then
        if AutoParryEnabled then StopUltraParryV3() else StartUltraParryV3() end
    end
end)

-- Mobile button
local function createMobileButton()
    local playerGui = Player:WaitForChild("PlayerGui")
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UltraAutoParryV3GUI"
    screenGui.ResetOnSpawn=false
    screenGui.Parent=playerGui

    local button = Instance.new("TextButton")
    button.Size=UDim2.new(0,160,0,50)
    button.Position=UDim2.new(0.5,-80,0.9,-25)
    button.Text=AutoParryEnabled and "UltraParry V3: ON" or "UltraParry V3: OFF"
    button.BackgroundColor3=Color3.fromRGB(50,50,50)
    button.TextColor3=Color3.fromRGB(255,255,255)
    button.Font=Enum.Font.SourceSansBold
    button.TextScaled=true
    button.Parent=screenGui

    button.MouseButton1Click:Connect(function()
        if AutoParryEnabled then StopUltraParryV3() button.Text="UltraParry V3: OFF"
        else StartUltraParryV3() button.Text="UltraParry V3: ON" end
    end)
end

createMobileButton()
Notify("Ultra Auto Parry V3","⚡ Script loaded! Press P to toggle",4)
warn("[UltraAutoParryV3] Ready (Impact Prediction + Arrow Debug)")
