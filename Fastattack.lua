local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local RS = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local VIM = game:GetService("VirtualInputManager")

local Player = Players.LocalPlayer
local Character

local Net = RS.Modules.Net
local RegisterAttack = Net["RE/RegisterAttack"]
local RegisterHit = Net["RE/RegisterHit"]
local ShootGunEvent = Net["RE/ShootGunEvent"]
local GunValidator = RS.Remotes.Validator2

-- CONFIG
local Config = {
    Distance = 60,
    ScanDelay = 0.1,
    AttackCooldown = 0.1,
    ComboReset = 0.3,
    MaxCombo = 4,
    HitLimbs = {"RightHand","LeftHand","HumanoidRootPart"},
    AttackMobs = true,
    AttackPlayers = true
}

-- STATE
local EnemyCache = {}
local LastScan = 0
local LastAttack = 0
local Combo = 0
local LastCombo = 0

-- UTILS
local function Alive(model)
    local hum = model and model:FindFirstChild("Humanoid")
    return hum and hum.Health > 0
end

local function GetHRP(model)
    return model and model:FindFirstChild("HumanoidRootPart")
end

-- SCAN TARGETS
local function ScanTargets()
    table.clear(EnemyCache)
    Character = Player.Character
    local HRP = GetHRP(Character)
    if not HRP then return end

    local function scan(folder)
        for _, v in ipairs(folder:GetChildren()) do
            if v ~= Character and Alive(v) then
                local root = GetHRP(v)
                if root and (root.Position - HRP.Position).Magnitude <= Config.Distance then
                    table.insert(EnemyCache, v)
                end
            end
        end
    end

    if Config.AttackMobs then scan(Workspace.Enemies) end
    if Config.AttackPlayers then scan(Workspace.Characters) end
end

-- COMBO
local function GetCombo()
    if tick() - LastCombo > Config.ComboReset then
        Combo = 1
    else
        Combo = Combo + 1
        if Combo > Config.MaxCombo then Combo = 1 end
    end
    LastCombo = tick()
    return Combo
end

-- Cài đặt biến môi trường
getgenv()["Fast Attack"] = true
local AttackDelay = 0 

task.spawn(function()
    while task.wait(AttackDelay) do
        -- Kiểm tra nếu đang bật Fast Attack và không có lệnh dừng
        if getgenv()["Fast Attack"] and not Stop_Fast_Attack then
            
            -- Lấy người chơi và GUI để kiểm tra phiên bản (Logic 1)
            local LocalPlayer = game.Players.LocalPlayer
            local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
            local VersionText = PlayerGui.Main.Version.Text
            
            -- === LOGIC 1: Dành cho phiên bản game mới (v26.6.1 trở lên) ===
            -- Giả định L_1_[45]["sf"] là string.find
            if string.find(VersionText, "v26.6.1") then
                xpcall(function()
                    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
                    local Tool = Character:FindFirstChildOfClass("Tool")

                    -- Điều kiện: Phải cầm tool và còn sống
                    if Tool and Humanoid and Humanoid.Health > 0 then
                        
                        -- Duyệt qua danh sách kẻ địch (Giả định L_1_[25] là thư mục chứa quái)
                        local EnemiesFolder = workspace:FindFirstChild("Enemies") -- Cần chỉnh lại đường dẫn nếu game khác
                        
                        if EnemiesFolder then
                            for _, Enemy in pairs(EnemiesFolder:GetChildren()) do
                                if Enemy:FindFirstChildOfClass("Humanoid") and Enemy.Humanoid.Health > 0 and Enemy:FindFirstChild("HumanoidRootPart") then
                                    
                                    -- Kiểm tra khoảng cách (<= 60 studs)
                                    local Distance = (Enemy.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude
                                    if Distance <= 60 then
                                        
                                        -- [Xóa hiệu ứng xấu] Xóa Stun (choáng) và Busy (bận)
                                        if Character:FindFirstChild("Stun") then Character.Stun.Value = 0 end
                                        if Character:FindFirstChild("Busy") then Character.Busy.Value = false end
                                        if Enemy:FindFirstChild("Stun") then Enemy.Stun.Value = 0 end
                                        if Enemy:FindFirstChild("Busy") then Enemy.Busy.Value = false end

                                        -- [Bypass] Can thiệp vào Network để đánh nhanh hơn
                                        local NetModule = game.ReplicatedStorage.Modules.Net
                                        if NetModule:FindFirstChild("RE") and NetModule.RE:FindFirstChild("RegisterHit") then
                                            local hitRemote = NetModule.RE.RegisterHit
                                            hitRemote:SetAttribute("Virtual", not hitRemote:GetAttribute("Virtual"))
                                        end
                                        Character:SetAttribute("Clashable", not Character:GetAttribute("Clashable"))

                                        -- [Tính toán Delay] Đếm số lượng quái xung quanh để chỉnh tốc độ đánh
                                        local EnemiesNear = 0
                                        for _, subEnemy in pairs(EnemiesFolder:GetChildren()) do
                                            if subEnemy:FindFirstChild("Humanoid") and subEnemy.Humanoid.Health > 0 and subEnemy:FindFirstChild("HumanoidRootPart") then
                                                if (subEnemy.HumanoidRootPart.Position - Character.HumanoidRootPart.Position).Magnitude <= 60 then
                                                    EnemiesNear = EnemiesNear + 1
                                                end
                                            end
                                        end

                                        -- Logic giảm lag/phát hiện: Nhiều quái thì đánh chậm lại chút
                                        if EnemiesNear > 5 then
                                            AttackDelay = 0.1
                                        elseif EnemiesNear > 2 then
                                            AttackDelay = 0.03
                                        else
                                            AttackDelay = 0 -- Spam tối đa
                                        end

                                        -- [Gửi lệnh tấn công]
                                        -- Giả định L_1_[48] là nơi chứa RemoteEvent
                                        local RemoteFolder = game.ReplicatedStorage -- Hoặc đường dẫn remote của game
                                        
                                        -- Gửi RegisterAttack với sát thương vô cực (math.huge)
                                        if RemoteFolder:FindFirstChild("RegisterAttack") then
                                            RemoteFolder.RegisterAttack:FireServer(math.huge)
                                        end
                                        
                                        -- Gửi RegisterHit vào đầu quái
                                        if RemoteFolder:FindFirstChild("RegisterHit") then
                                            -- Tạo key xác thực giả (Fake validation key)
                                            local key = (tostring(LocalPlayer.UserId)):sub(2, 4) .. (tostring(coroutine.running())):sub(11, 15)
                                            RemoteFolder.RegisterHit:FireServer(Enemy.Head, { {Enemy, Enemy.Head} }, nil, key)
                                        end
                                    end
                                end
                            end
                        end
                    end
                end, warn) -- In lỗi nếu có

            -- === LOGIC 2: Dành cho phiên bản cũ hoặc game không hỗ trợ logic trên ===
            else
                -- Kiểm tra hỗ trợ Exploit
                assert(getrenv, "Exploit not supported")
                
                local CollectionService = game:GetService("CollectionService")
                local ReplicatedStorage = game:GetService("ReplicatedStorage")
                local Players = game:GetService("Players")
                local LocalPlayer = Players.LocalPlayer
                
                -- Lấy function nội bộ (Upvalue) của _G.SendHitsToServer để bypass cooldown
                local SendHitsToServer = debug.getupvalue(getrenv()._G.SendHitsToServer, 1)
                local RegisterAttackRE = ReplicatedStorage.Modules.Net["RE/RegisterAttack"]

                -- Hàm tìm mục tiêu gần nhất
                local function FindTargets()
                    local Mobs = CollectionService:GetTagged("BasicMob")
                    if #Mobs == 0 then return nil end

                    local ValidTargets = {}
                    local CharacterPos = LocalPlayer.Character and LocalPlayer.Character.PrimaryPart.Position
                    if not CharacterPos then return nil end

                    for _, Mob in pairs(Mobs) do
                        local Humanoid = Mob:FindFirstChildOfClass("Humanoid")
                        local Root = Mob.PrimaryPart
                        if Humanoid and Humanoid.Health > 0 and Root then
                            local Dist = (Root.Position - CharacterPos).Magnitude
                            if Dist <= 100 then
                                table.insert(ValidTargets, {mob = Mob, distance = Dist})
                            end
                        end
                    end

                    if #ValidTargets == 0 then return nil end

                    -- Sắp xếp theo khoảng cách gần nhất
                    table.sort(ValidTargets, function(a, b)
                        return a.distance < b.distance
                    end)

                    -- Trả về tối đa 2 mục tiêu gần nhất
                    return #ValidTargets > 2 and {ValidTargets[1], ValidTargets[2]} or ValidTargets
                end

                -- Hàm thực hiện tấn công
                local function DoAttack()
                    local Targets = FindTargets()
                    if not Targets then return end

                    local HitList = {}
                    for _, data in pairs(Targets) do
                        local HRP = data.mob:FindFirstChild("HumanoidRootPart")
                        if HRP then
                            table.insert(HitList, {data.mob, HRP})
                        end
                    end

                    if #HitList > 0 then
                        -- Gửi sát thương NaN (0/0) để gây lỗi/bypass damage cap
                        RegisterAttackRE:FireServer(0 / 0)
                        
                        -- Gọi trực tiếp hàm xử lý hit bằng coroutine để bỏ qua check client
                        coroutine.resume(SendHitsToServer, HitList[1][2], { table.unpack(HitList, 2) })
                    end
                end

                -- Chạy tấn công an toàn
                local success, err = pcall(function()
                    DoAttack()
                end)
                
                if not success then
                    warn("Error in Combat script: " .. tostring(err))
                end
            end
        end
    end
end)

-- GUN
local function ShootGun(tool)
    local target = EnemyCache[1]
    if not target then return end
    GunValidator:FireServer()
    ShootGunEvent:FireServer(target.HumanoidRootPart.Position)
end

-- FRUIT M1
local function FruitM1(tool)
    local target = EnemyCache[1]
    if not target then return end
    local dir = (target.HumanoidRootPart.Position - Character:GetPivot().Position).Unit
    tool.LeftClickRemote:FireServer(dir, GetCombo())
end

-- MAIN LOOP
RunService.Heartbeat:Connect(function()
    Character = Player.Character
    if not Alive(Character) then return end

    if tick() - LastScan >= Config.ScanDelay then
        LastScan = tick()
        ScanTargets()
    end

    if tick() - LastAttack < Config.AttackCooldown then return end
    LastAttack = tick()

    local tool = Character:FindFirstChildOfClass("Tool")
    if not tool then return end

    if tool.ToolTip == "Gun" then
        ShootGun(tool)
    elseif tool.ToolTip == "Blox Fruit" and tool:FindFirstChild("LeftClickRemote") then
        FruitM1(tool)
    end
end)
