 -- Chờ người chơi vào game đầy đủ
repeat wait() until game.Players.LocalPlayer 
    and game.Players.LocalPlayer.Character 
    and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") 
    and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid")

local mouse = game.Players.LocalPlayer:GetMouse()
repeat wait() until mouse

-- Biến
local plr = game.Players.LocalPlayer
local torso = plr.Character:FindFirstChild("HumanoidRootPart")  -- Đổi từ Torso sang HumanoidRootPart (hỗ trợ R15)
local flying = false
local ctrl = {f = 0, b = 0, l = 0, r = 0}
local speed = 0
local maxspeed = math.random(45, 55)  -- Tránh tốc độ cố định
local bg, bv

-- Hàm tạo lại BodyGyro và BodyVelocity (Anti-Cheat Bypass)
local function createFlightObjects()
    if not torso then return end

    -- Nếu bị xóa, tạo lại
    if not bg or not bg.Parent then
        bg = Instance.new("BodyGyro")
        bg.P = 9e4
        bg.maxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.cframe = torso.CFrame
        bg.Parent = game:GetService("CoreGui")  -- Ẩn đi để tránh bị phát hiện
    end

    if not bv or not bv.Parent then
        bv = Instance.new("BodyVelocity")
        bv.velocity = Vector3.new(0, 0.1, 0)
        bv.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Parent = game:GetService("CoreGui")
    end
end

-- Hàm bay
local function Fly()
    game.StarterGui:SetCore("SendNotification", {Title = "Fly Activated", Text = "WeAreDevs.net", Duration = 1})

    flying = true
    createFlightObjects()
    
    repeat wait()
        -- Nếu anti-cheat xóa, tạo lại
        createFlightObjects()

        plr.Character.Humanoid.PlatformStand = true  -- Ngăn nhân vật rơi

        -- Kiểm soát tốc độ bay
        if ctrl.f + ctrl.b ~= 0 or ctrl.l + ctrl.r ~= 0 then
            speed = math.min(speed + 0.5 + (speed / maxspeed), maxspeed)
        else
            speed = math.max(speed - 1, 0)
        end

        -- Tạo chuyển động bay
        local moveDirection = (game.Workspace.CurrentCamera.CFrame.lookVector * (ctrl.f + ctrl.b)) + 
            ((game.Workspace.CurrentCamera.CFrame * CFrame.new(ctrl.l + ctrl.r, 0, 0).p) - game.Workspace.CurrentCamera.CFrame.p)

        bv.velocity = moveDirection * speed
        bg.cframe = game.Workspace.CurrentCamera.CFrame * CFrame.Angles(-math.rad((ctrl.f + ctrl.b) * 30), 0, 0)
    until not flying

    -- Khi dừng bay
    plr.Character.Humanoid.PlatformStand = false
    if bg then bg:Destroy() end
    if bv then bv:Destroy() end
    bg, bv = nil, nil

    game.StarterGui:SetCore("SendNotification", {Title = "Fly Deactivated", Text = "WeAreDevs.net", Duration = 1})
end

-- Điều khiển phím
mouse.KeyDown:Connect(function(key)
    if key:lower() == "e" then
        flying = not flying
        if flying then Fly() end
    elseif key:lower() == "w" then
        ctrl.f = 1
    elseif key:lower() == "s" then
        ctrl.b = -1
    elseif key:lower() == "a" then
        ctrl.l = -1
    elseif key:lower() == "d" then
        ctrl.r = 1
    end
end)

mouse.KeyUp:Connect(function(key)
    if key:lower() == "w" then ctrl.f = 0
    elseif key:lower() == "s" then ctrl.b = 0
    elseif key:lower() == "a" then ctrl.l = 0
    elseif key:lower() == "d" then ctrl.r = 0
    end
end)
fly()
