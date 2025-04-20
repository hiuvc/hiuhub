-- Cấu hình chính
_G.AutoNear = true           -- Bật/tắt auto farm
_G.BringMob = false          -- Bật/tắt kéo mob
_G.Speed = 180               -- Tốc độ di chuyển
_G.FastAttackStrix_Mode = "Super Fast Attack"  -- Chế độ tấn công
_G.Fast_Delay = 1e-9         -- Độ trễ tấn công

-- Tùy chọn người dùng
local FarmMode = "Dodge"     -- "Stand" hoặc "Dodge"
local ChooseWeapon = "Melee" -- "Melee", "Sword", hoặc "Blox Fruit"

-- Biến hệ thống
local player = game.Players.LocalPlayer
local bringmob = false
local MonFarm = ""
local FarmPos = CFrame.new()
local SelectWeapon = "Superhuman"
local Type = 1
local Pos = CFrame.new(0, 40, 0)

-- Hàm tiện ích
function EquipTool(toolName)
    local backpack = player.Backpack
    local tool = backpack:FindFirstChild(toolName)
    if tool then
        player.Character.Humanoid:EquipTool(tool)
        print("Đã trang bị vũ khí: " .. toolName)
    else
        print("Không tìm thấy vũ khí: " .. toolName)
    end
end

function AutoHaki()
    if not player.Character then return end
    if not player.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
    end
end

function GetEquippedTool()
    if not player.Character then return nil end
    for _, item in ipairs(player.Character:GetChildren()) do
        if item:IsA("Tool") then
            return item
        end
    end
    return nil
end

-- Hệ thống tìm mục tiêu
function FindEnemiesInRange()
    if not player.Character then return nil, {} end
    
    local targets = {}
    local closestTarget = nil
    local minDistance = math.huge
    local playerPos = player.Character:GetPivot().Position

    for _, enemy in ipairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 and not enemy:GetAttribute("IsBoat") then
            local head = enemy:FindFirstChild("Head")
            if head then
                local distance = (playerPos - head.Position).Magnitude
                if distance <= 60 then
                    table.insert(targets, {enemy, head})
                    if distance < minDistance then
                        minDistance = distance
                        closestTarget = head
                    end
                end
            end
        end
    end

    return closestTarget, targets
end

-- Hệ thống tấn công
function AttackNoCoolDown()
    local closestTarget, targets = FindEnemiesInRange()
    if not closestTarget or not GetEquippedTool() then return end

    pcall(function()
        local rs = game:GetService("ReplicatedStorage")
        local registerAttack = rs:FindFirstChild("Modules") and rs.Modules:FindFirstChild("Net") and rs.Modules.Net:FindFirstChild("RE/RegisterAttack")
        local registerHit = rs:FindFirstChild("Modules") and rs.Modules:FindFirstChild("Net") and rs.Modules.Net:FindFirstChild("RE/RegisterHit")
        
        if registerAttack and registerHit then
            if #targets > 0 then
                registerAttack:FireServer(_G.Fast_Delay)
                registerHit:FireServer(closestTarget, targets)
            else
                task.wait(_G.Fast_Delay)
            end
        else
            print("Lỗi: Không tìm thấy đối tượng RegisterAttack hoặc RegisterHit trong ReplicatedStorage.")
        end
    end)
end

-- Hệ thống di chuyển
function TweenToPosition(targetCFrame)
    if not player.Character then return end

    local root = player.Character:WaitForChild("HumanoidRootPart")
    local humanoid = player.Character:FindFirstChild("Humanoid")
    local distance = (targetCFrame.Position - root.Position).Magnitude

    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 50
    end

    local tweenInfo = TweenInfo.new(distance / _G.Speed, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(root, tweenInfo, {CFrame = targetCFrame})
    tween:Play()
    tween.Completed:Wait()

    if humanoid then
        humanoid.WalkSpeed = 16
    end
end

-- Hệ thống chọn và trang bị vũ khí
task.spawn(function()
    while task.wait(1) do
        if not player.Backpack then continue end
        
        for _, item in pairs(player.Backpack:GetChildren()) do
            if item:FindFirstChild("ToolTip") then
                if ChooseWeapon == "Melee" and item.ToolTip == "Melee" then
                    SelectWeapon = item.Name
                    EquipTool(SelectWeapon)
                    break
                elseif ChooseWeapon == "Sword" and item.ToolTip == "Sword" then
                    SelectWeapon = item.Name
                    EquipTool(SelectWeapon)
                    break
                elseif ChooseWeapon == "Blox Fruit" and item.ToolTip == "Blox Fruit" then
                    SelectWeapon = item.Name
                    EquipTool(SelectWeapon)
                    break
                end
            end
        end
    end
end)

-- Đổi vị trí khi farm (né hoặc đứng yên)
task.spawn(function()
    while task.wait(5) do
        if FarmMode == "Stand" then
            Pos = CFrame.new(0, 40, 0)
        elseif FarmMode == "Dodge" then
            Type = Type % 5 + 1
            if Type == 1 then Pos = CFrame.new(0, 40, 0)
            elseif Type == 2 then Pos = CFrame.new(-40, 40, 0)
            elseif Type == 3 then Pos = CFrame.new(40, 40, 0)
            elseif Type == 4 then Pos = CFrame.new(0, 40, 40)
            elseif Type == 5 then Pos = CFrame.new(0, 40, -40) end
        end
    end
end)

-- Hệ thống kéo mob
task.spawn(function()
    while task.wait(0.1) do
        if not _G.BringMob or not bringmob then continue end

        for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            if enemy.Name == MonFarm and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                if (enemy.HumanoidRootPart.Position - FarmPos.Position).Magnitude <= 1000 then
                    enemy.HumanoidRootPart.CFrame = FarmPos
                    enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                    enemy.HumanoidRootPart.Transparency = 1
                    enemy.Humanoid.JumpPower = 0
                    enemy.Humanoid.WalkSpeed = 0
                    enemy.HumanoidRootPart.CanCollide = false
                    enemy.Head.CanCollide = false
                    if enemy.Humanoid:FindFirstChild("Animator") then
                        enemy.Humanoid.Animator:Destroy()
                    end
                    sethiddenproperty(player, "SimulationRadius", math.huge)
                end
            end
        end
    end
end)

-- Hệ thống Auto Farm chính
task.spawn(function()
    while task.wait(0.1) do
        if not _G.AutoNear then continue end

        for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
            if enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0 then
                local distance = (player.Character.HumanoidRootPart.Position - enemy.HumanoidRootPart.Position).Magnitude
                
                if distance <= 5000 then
                    bringmob = true
                    MonFarm = enemy.Name
                    FarmPos = enemy.HumanoidRootPart.CFrame
                    
                    repeat
                        task.wait(_G.Fast_Delay)
                        AutoHaki()
                        EquipTool(SelectWeapon)
                        AttackNoCoolDown()
                        TweenToPosition(enemy.HumanoidRootPart.CFrame * Pos)

                        enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                        enemy.HumanoidRootPart.Transparency = 1
                        enemy.Humanoid.JumpPower = 0
                        enemy.Humanoid.WalkSpeed = 0
                        enemy.HumanoidRootPart.CanCollide = false
                    until not _G.AutoNear or not enemy.Parent or enemy.Humanoid.Health <= 0 or not game.Workspace.Enemies:FindFirstChild(enemy.Name)
                    
                    bringmob = false
                end
            end
        end
    end
end)

print("✅ Auto Farm đã được kích hoạt thành công!")
