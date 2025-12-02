if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        l_Remotes_0.CommF_:InvokeServer("SetTeam", getgenv().team or "Marines")
        task.wait(3)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end
-- Global cooldown
getgenv().Seriality = getgenv().Seriality or false
getgenv().AttackCooldown = getgenv().AttackCooldown or 0.1 
local lastAttackTime = 0

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

-- Player
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

-- Main loop
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

-- Cờ trạng thái
local isTweening = false      
local allowBypass = false        
local bypassDistance = 3500
local defaultTweenSpeed = 300

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

    local speed = getgenv().TweenSpeed or defaultTweenSpeed
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

function TP1(target)
    topos(target)
end

function EquipWeapon(weaponName)
    if weaponName == nil or weaponName == "" then
        warn("EquipWeapon: Weapon name is nil or empty")
        return
    end

    local player = game.Players.LocalPlayer
    local backpack = player:FindFirstChild("Backpack")
    local character = player.Character
    if not backpack or not character then
        warn("EquipWeapon: Backpack hoặc Character không tồn tại")
        return
    end

    local tool = backpack:FindFirstChild(weaponName)
    if tool then
        pcall(function()
            character.Humanoid:EquipTool(tool)
        end)
    else
        return
    end
end

local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game.Players.LocalPlayer

local function SetNetworkOwner(part)
    if part and part:CanSetNetworkOwnership() then
        pcall(function()
            part:SetNetworkOwnership(LocalPlayer)
        end)
    end
end

function TweenEnemyToTarget(enemy, targetCFrame, size)
    pcall(function()
        -- Chặn gọi trùng
        if enemy:FindFirstChild("IsBeingBrought") then return end
        local flag = Instance.new("BoolValue")
        flag.Name = "IsBeingBrought"
        flag.Parent = enemy

        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        local humanoid = enemy:FindFirstChild("Humanoid")
        if not hrp or not humanoid or humanoid.Health <= 0 then
            flag:Destroy()
            return
        end

        hrp.Size = size or Vector3.new(4,4,4)
        hrp.CanCollide = false
        if enemy:FindFirstChild("Head") then
            enemy.Head.CanCollide = false
        end

        humanoid:ChangeState(Enum.HumanoidStateType.Physics)
        sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)

        local finalCFrame = targetCFrame
        if not finalCFrame then
            local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not root then 
                flag:Destroy()
                return 
            end
            finalCFrame = CFrame.new(root.Position - Vector3.new(0, hrp.Size.Y/2 + 2, 0))
        end

        -- TWEEN (no leak)
        local tween = TweenService:Create(
            hrp,
            TweenInfo.new(0.5, Enum.EasingStyle.Linear),
            {CFrame = finalCFrame}
        )
        tween:Play()

        -- Force position loop
        local anchorPos = finalCFrame.Position
        local conn
        conn = RunService.Stepped:Connect(function()
            if not enemy.Parent or humanoid.Health <= 0 then
                conn:Disconnect()
                tween:Cancel()
                tween:Destroy()
                flag:Destroy()
                return
            end

            hrp.CFrame = CFrame.new(anchorPos)
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero
        end)

        -- Cleanup tween khi xong
        tween.Completed:Connect(function()
            tween:Destroy()
        end)
    end)
end




local function Get_G()
    for k, v in pairs(_G) do
        if v == true then
            return true
        end
    end
    return false
end



task.spawn(function()
    pcall(function()
        while task.wait() do
            if Get_G() then
                if  not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
                    local v2263 = Instance.new("BodyVelocity");
                    v2263.Name = "BodyClip";
                    v2263.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
                    v2263.MaxForce = Vector3.new(100000, 100000, 100000);
                    v2263.Velocity = Vector3.new(0, 0, 0);
                end
            end
        end
    end);
end);
task.spawn(function()
    pcall(function()
        while task.wait() do
            if Get_G() then
                local v2121 = game:GetService("Players").LocalPlayer;
                local v2122 = v2121.Character and v2121.Character:FindFirstChildOfClass("Humanoid") ;
                if v2122 then
                    local v2269 = v2122:GetState();
                    if ((v2269 ~= Enum.HumanoidStateType.Seated) and (v2269 ~= Enum.HumanoidStateType.Running) and (v2269 ~= Enum.HumanoidStateType.Landed)) then
                        v2122:ChangeState(5);
                    end
                end
            end
        end
    end);
end);
task.spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if Get_G() then
                for v2191, v2192 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v2192:IsA("BasePart") then
                        v2192.CanCollide = false;
                    end
                end
            end
        end);
    end);
end);



local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EffectContainer = ReplicatedStorage:FindFirstChild("Effect") and ReplicatedStorage.Effect:FindFirstChild("Container")

if EffectContainer then
    for _, name in ipairs({"Death", "Respawn"}) do
        local module = EffectContainer:FindFirstChild(name)
        if module then
            local success, func = pcall(require, module)
            if success and type(func) == "function" then
                hookfunction(func, function(...) end)
            end
        end
    end
end
if (game.PlaceId == 2753915549) then
    World1 = true
elseif (game.PlaceId == 4442272183) then
    World2 = true
elseif (game.PlaceId == 7449423635) then
    World3 = true
end
-- Bảng dữ liệu quest theo level
local QuestData = {
    -- World 1
    World1 = {
        {1, 9, "Bandit", 1, "BanditQuest1", "Bandit", CFrame.new(1059, 17, 1546), CFrame.new(943, 45, 1562)},
        {10, 14, "Monkey", 1, "JungleQuest", "Monkey", CFrame.new(-1598, 37, 153), CFrame.new(-1524, 50, 37)},
        {15, 29, "Gorilla", 2, "JungleQuest", "Gorilla", CFrame.new(-1598, 37, 153), CFrame.new(-1128, 40, -451)},
        {30, 39, "Pirate", 1, "BuggyQuest1", "Pirate", CFrame.new(-1140, 4, 3829), CFrame.new(-1262, 40, 3905)},
        {40, 59, "Brute", 2, "BuggyQuest1", "Brute", CFrame.new(-1140, 4, 3829), CFrame.new(-976, 55, 4304)},
        {60, 74, "Desert Bandit", 1, "DesertQuest", "Desert Bandit", CFrame.new(897, 6, 4389), CFrame.new(924, 7, 4482)},
        {75, 89, "Desert Officer", 2, "DesertQuest", "Desert Officer", CFrame.new(897, 6, 4389), CFrame.new(1608, 9, 4371)},
        {90, 99, "Snow Bandit", 1, "SnowQuest", "Snow Bandit", CFrame.new(1385, 87, -1298), CFrame.new(1362, 120, -1531)},
        {100, 119, "Snowman", 2, "SnowQuest", "Snowman", CFrame.new(1385, 87, -1298), CFrame.new(1243, 140, -1437)},
        {120, 149, "Chief Petty Officer", 1, "MarineQuest2", "Chief Petty Officer", CFrame.new(-5035, 29, 4326), CFrame.new(-4881, 23, 4274)},
        {150, 174, "Sky Bandit", 1, "SkyQuest", "Sky Bandit", CFrame.new(-4844, 718, -2621), CFrame.new(-4953, 296, -2899)},
        {175, 189, "Dark Master", 2, "SkyQuest", "Dark Master", CFrame.new(-4844, 718, -2621), CFrame.new(-5260, 391, -2229)},
        {190, 209, "Prisoner", 1, "PrisonerQuest", "Prisoner", CFrame.new(5306, 2, 477), CFrame.new(5099, 0, 474)},
        {210, 249, "Dangerous Prisoner", 2, "PrisonerQuest", "Dangerous Prisoner", CFrame.new(5306, 2, 477), CFrame.new(5655, 16, 866)},
        {250, 299, "Toga Warrior", 1, "ColosseumQuest", "Toga Warrior", CFrame.new(-1581, 7, -2982), CFrame.new(-1692.509765625, 9.30445384979248, -2931.4755859375)},
        {300, 324, "Military Soldier", 1, "MagmaQuest", "Military Soldier", CFrame.new(-5319, 12, 8515), CFrame.new(-5335, 46, 8638)},
        {325, 374, "Military Spy", 2, "MagmaQuest", "Military Spy", CFrame.new(-5319, 12, 8515), CFrame.new(-5803, 86, 8829)},
        {375, 399, "Fishman Warrior", 1, "FishmanQuest", "Fishman Warrior", CFrame.new(61122, 18, 1567), CFrame.new(60998, 50, 1534)},
        {400, 449, "Fishman Commando", 2, "FishmanQuest", "Fishman Commando", CFrame.new(61122, 18, 1567), CFrame.new(61866, 55, 1655)},
        {450, 474, "God's Guard", 1, "SkyExp1Quest", "God's Guard", CFrame.new(-4720, 846, -1951), CFrame.new(-4720, 846, -1951)},
        {475, 524, "Shanda", 2, "SkyExp1Quest", "Shanda", CFrame.new(-7861, 5545, -381), CFrame.new(-7741, 5580, -395)},
        {525, 549, "Royal Squad", 1, "SkyExp2Quest", "Royal Squad", CFrame.new(-7903, 5636, -1412), CFrame.new(-7727, 5650, -1410)},
        {550, 624, "Royal Soldier", 2, "SkyExp2Quest", "Royal Soldier", CFrame.new(-7903, 5636, -1412), CFrame.new(-7894, 5640, -1629)},
        {625, 649, "Galley Pirate", 1, "FountainQuest", "Galley Pirate", CFrame.new(5258, 39, 4052), CFrame.new(5391, 70, 4023)},
        {650, math.huge, "Galley Captain", 2, "FountainQuest", "Galley Captain", CFrame.new(5258, 39, 4052), CFrame.new(5985, 70, 4790)}
    },
    
    -- World 2
    World2 = {
        {700, 724, "Raider", 1, "Area1Quest", "Raider", CFrame.new(-427, 73, 1835), CFrame.new(-614, 90, 2240)},
        {725, 774, "Mercenary", 2, "Area1Quest", "Mercenary", CFrame.new(-427, 73, 1835), CFrame.new(-867, 110, 1621)},
        {775, 874, "Swan Pirate", 1, "Area2Quest", "Swan Pirate", CFrame.new(635, 73, 919), CFrame.new(898.23, 73.00, 1311.18)},
        {875, 899, "Marine Lieutenant", 1, "MarineQuest3", "Marine Lieutenant", CFrame.new(-2441, 73, -3219), CFrame.new(-2552, 110, -3050)},
        {900, 949, "Marine Captain", 2, "MarineQuest3", "Marine Captain", CFrame.new(-2441, 73, -3219), CFrame.new(-1695, 110, -3299)},
        {950, 974, "Zombie", 1, "ZombieQuest", "Zombie", CFrame.new(-5495, 48, -794), CFrame.new(-5715, 90, -917)},
        {975, 999, "Vampire", 2, "ZombieQuest", "Vampire", CFrame.new(-5495, 48, -794), CFrame.new(-6027, 50, -1130)},
        {1000, 1049, "Snow Trooper", 1, "SnowMountainQuest", "Snow Trooper", CFrame.new(607, 401, -5371), CFrame.new(445, 440, -5175)},
        {1050, 1099, "Winter Warrior", 2, "SnowMountainQuest", "Winter Warrior", CFrame.new(607, 401, -5371), CFrame.new(1224, 460, -5332)},
        {1100, 1124, "Lab Subordinate", 1, "IceSideQuest", "Lab Subordinate", CFrame.new(-6061, 16, -4904), CFrame.new(-5941, 50, -4322)},
        {1125, 1174, "Horned Warrior", 2, "IceSideQuest", "Horned Warrior", CFrame.new(-6061, 16, -4904), CFrame.new(-6306, 50, -5752)},
        {1175, 1199, "Magma Ninja", 1, "FireSideQuest", "Magma Ninja", CFrame.new(-5430, 16, -5298), CFrame.new(-5233, 60, -6227)},
        {1200, 1249, "Lava Pirate", 2, "FireSideQuest", "Lava Pirate", CFrame.new(-5430, 16, -5298), CFrame.new(-4955, 60, -4836)},
        {1250, 1274, "Ship Deckhand", 1, "ShipQuest1", "Ship Deckhand", CFrame.new(1033, 125, 32909), CFrame.new(1033, 125, 32909)},
        {1275, 1299, "Ship Engineer", 2, "ShipQuest1", "Ship Engineer", CFrame.new(1033, 125, 32909), CFrame.new(809, 80, 33090)},
        {1300, 1324, "Ship Steward", 1, "ShipQuest2", "Ship Steward", CFrame.new(973, 125, 33245), CFrame.new(838, 160, 33408)},
        {1325, 1349, "Ship Officer", 2, "ShipQuest2", "Ship Officer", CFrame.new(973, 125, 33245), CFrame.new(1238, 220, 33148)},
        {1350, 1374, "Arctic Warrior", 1, "FrostQuest", "Arctic Warrior", CFrame.new(5668, 28, -6484), CFrame.new(5836, 80, -6257)},
        {1375, 1424, "Snow Lurker", 2, "FrostQuest", "Snow Lurker", CFrame.new(5668, 28, -6484), CFrame.new(5700, 80, -6724)},
        {1425, 1449, "Sea Soldier", 1, "ForgottenQuest", "Sea Soldier", CFrame.new(-3056, 240, -10145), CFrame.new(-2583, 80, -9821)},
        {1450, math.huge, "Water Fighter", 2, "ForgottenQuest", "Water Fighter", CFrame.new(-3056, 240, -10145), CFrame.new(-3339, 290, -10412)}
    },
    
    -- World 3
    World3 = {
        {1500, 1524, "Pirate Millionaire", 1, "PiratePortQuest", "Pirate Millionaire", CFrame.new(-291, 44, 5580), CFrame.new(-44, 70, 5623)},
        {1525, 1574, "Pistol Billionaire", 2, "PiratePortQuest", "Pistol Billionaire", CFrame.new(-291, 44, 5580), CFrame.new(219, 105, 6018)},
        {1575, 1599, "Dragon Crew Warrior", 1, "AmazonQuest", "Dragon Crew Warrior", CFrame.new(5834, 51, -1103), CFrame.new(5992, 90, -1581)},
        {1600, 1624, "Dragon Crew Archer", 2, "AmazonQuest", "Dragon Crew Archer", CFrame.new(5834, 51, -1103), CFrame.new(6472, 370, -151)},
        {1625, 1649, "Female Islander", 1, "AmazonQuest2", "Female Islander", CFrame.new(5448, 602, 748), CFrame.new(4836, 740, 928)},
        {1650, 1699, "Giant Islander", 2, "AmazonQuest2", "Giant Islander", CFrame.new(5448, 602, 748), CFrame.new(4784, 660, 155)},
        {1700, 1724, "Marine Commodore", 1, "MarineTreeIsland", "Marine Commodore", CFrame.new(2180, 29, -6738), CFrame.new(3156, 120, -7837)},
        {1725, 1774, "Marine Rear Admiral", 2, "MarineTreeIsland", "Marine Rear Admiral", CFrame.new(2180, 29, -6738), CFrame.new(3205, 120, -6742)},
        {1775, 1799, "Fishman Raider", 1, "DeepForestIsland3", "Fishman Raider", CFrame.new(-10581, 332, -8758), CFrame.new(-10550, 380, -8574)},
        {1800, 1824, "Fishman Captain", 2, "DeepForestIsland3", "Fishman Captain", CFrame.new(-10581, 332, -8758), CFrame.new(-10764, 380, -8799)},
        {1825, 1849, "Forest Pirate", 1, "DeepForestIsland", "Forest Pirate", CFrame.new(-13233, 332, -7626), CFrame.new(-13335, 380, -7660)},
        {1850, 1899, "Mythological Pirate", 2, "DeepForestIsland", "Mythological Pirate", CFrame.new(-13233, 332, -7626), CFrame.new(-13844, 520, -7016)},
        {1900, 1924, "Jungle Pirate", 1, "DeepForestIsland2", "Jungle Pirate", CFrame.new(-12682, 391, -9901), CFrame.new(-12166, 380, -10375)},
        {1925, 1974, "Musketeer Pirate", 2, "DeepForestIsland2", "Musketeer Pirate", CFrame.new(-12682, 391, -9901), CFrame.new(-13098, 450, -9831)},
        {1975, 1999, "Reborn Skeleton", 1, "HauntedQuest1", "Reborn Skeleton", CFrame.new(-9481, 142, 5565), CFrame.new(-8680, 190, 5852)},
        {2000, 2024, "Living Zombie", 2, "HauntedQuest1", "Living Zombie", CFrame.new(-9481, 142, 5565), CFrame.new(-10144, 140, 5932)},
        {2025, 2049, "Demonic Soul", 1, "HauntedQuest2", "Demonic Soul", CFrame.new(-9515, 172, 607), CFrame.new(-9275, 210, 6166)},
        {2050, 2074, "Posessed Mummy", 2, "HauntedQuest2", "Posessed Mummy", CFrame.new(-9515, 172, 607), CFrame.new(-9442, 60, 6304)},
        {2075, 2099, "Peanut Scout", 1, "NutsIslandQuest", "Peanut Scout", CFrame.new(-2104, 38, -10194), CFrame.new(-1870, 100, -10225)},
        {2100, 2124, "Peanut President", 2, "NutsIslandQuest", "Peanut President", CFrame.new(-2104, 38, -10194), CFrame.new(-2005, 100, -10585)},
        {2125, 2149, "Ice Cream Chef", 1, "IceCreamIslandQuest", "Ice Cream Chef", CFrame.new(-818, 66, -10964), CFrame.new(-501, 100, -10883)},
        {2150, 2199, "Ice Cream Commander", 2, "IceCreamIslandQuest", "Ice Cream Commander", CFrame.new(-818, 66, -10964), CFrame.new(-690, 100, -11350)},
        {2200, 2224, "Cookie Crafter", 1, "CakeQuest1", "Cookie Crafter", CFrame.new(-2023, 38, -12028), CFrame.new(-2332, 90, -12049)},
        {2225, 2249, "Cake Guard", 2, "CakeQuest1", "Cake Guard", CFrame.new(-2023, 38, -12028), CFrame.new(-1514, 90, -12422)},
        {2250, 2274, "Baking Staff", 1, "CakeQuest2", "Baking Staff", CFrame.new(-1931, 38, -12840), CFrame.new(-1930, 90, -12963)},
        {2275, 2299, "Head Baker", 2, "CakeQuest2", "Head Baker", CFrame.new(-1931, 38, -12840), CFrame.new(-2123, 110, -12777)},
        {2300, 2324, "Cocoa Warrior", 1, "ChocQuest1", "Cocoa Warrior", CFrame.new(235, 25, -12199), CFrame.new(110, 80, -12245)},
        {2325, 2349, "Chocolate Bar Battler", 2, "ChocQuest1", "Chocolate Bar Battler", CFrame.new(235, 25, -12199), CFrame.new(579, 80, -12413)},
        {2350, 2374, "Sweet Thief", 1, "ChocQuest2", "Sweet Thief", CFrame.new(150, 25, -12777), CFrame.new(-68, 80, -12692)},
        {2375, 2399, "Candy Rebel", 2, "ChocQuest2", "Candy Rebel", CFrame.new(150, 25, -12777), CFrame.new(17, 80, -12962)},
        {2400, 2424, "Candy Pirate", 1, "CandyQuest1", "Candy Pirate", CFrame.new(-1148, 14, -14446), CFrame.new(-1371, 70, -14405)},
        {2425, 2449, "Snow Demon", 2, "CandyQuest1", "Snow Demon", CFrame.new(-1148, 14, -14446), CFrame.new(-836, 70, -14326)},
        {2450, 2474, "Isle Outlaw", 1, "TikiQuest1", "Isle Outlaw", CFrame.new(-16547, 56, -172), CFrame.new(-16431, 90, -223)},
        {2475, 2499, "Island Boy", 2, "TikiQuest1", "Island Boy", CFrame.new(-16547, 56, -172), CFrame.new(-16668, 70, -243)},
        {2500, 2524, "Sun-kissed Warrior", 1, "TikiQuest2", "kissed", CFrame.new(-16540, 56, 1051), CFrame.new(-16345, 80, 1004)},
        {2525, 2549, "Isle Champion", 2, "TikiQuest2", "Isle Champion", CFrame.new(-16540, 56, 1051), CFrame.new(-16634, 85, 1106)},
        {2550, 2574, "Serpent Hunter", 1, "TikiQuest3", "Serpent Hunter", CFrame.new(-16665, 105, 1580), CFrame.new(-16542.4824, 146.675156, 1529.61401, -0.999948919, 1.0729811e-8, 0.0101067368, 1.0128324e-8, 1, -5.9564663e-8, -0.0101067368, -5.9459257e-8, -0.999948919)},
        {2575, 2600, "Skull Slayer", 2, "TikiQuest3", "Skull Slayer", CFrame.new(-16665, 105, 1580), CFrame.new(-16849.9336, 147.005066, 1640.88354, 0.470148534, 0.491874039, -0.732816696, 1.72165e-8, 0.83030504, 0.55730921, 0.882587314, -0.262018114, 0.390366673)}
    }
}

function CheckQuest()
    local MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value
    
    -- Xác định world hiện tại
    local currentWorld = World1 and "World1" or World2 and "World2" or World3 and "World3"
    
    if not currentWorld then return end
    
    -- Tìm quest phù hợp với level
    local worldData = QuestData[currentWorld]
    for _, questInfo in ipairs(worldData) do
        local minLevel, maxLevel = questInfo[1], questInfo[2]
        
        if MyLevel >= minLevel and MyLevel <= maxLevel then
            Mon = questInfo[3]
            LevelQuest = questInfo[4]
            NameQuest = questInfo[5]
            NameMon = questInfo[6]
            CFrameQuest = questInfo[7]
            CFrameMon = questInfo[8]
            return
        end
    end
end

-- Danh sách quái
local MaterialList = {
    "Factory Staff", "Water Fighter", "Military Spy", "Magma Ninja", "God's Guard",
    "Brute", "Marine Captain", "Jungle Pirate", "Swan Pirate", "Fishman Raider",
    "Fishman Warrior", "Demonic Soul", "Vampire", "Chocolate Bar Battler",
    "Dragon Crew Archer", "Pistol Billionaire", "Hydra Enforcer", "Venomous Assailant",
    "Mythological Pirate", "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"
}
local BoneList = { "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy" }
local DoughList = { "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker" }

-- Config magnet
local magnetConfigs = {
    {
        enabled = function() return _G.Ectoplasm and StartEctoplasmMagnet end,
        filter = function(name) return string.find(name, "Ship") end,
        position = function() return EctoplasmMon end,
        size = nil
    },
    {
        enabled = function() return _G.Rengoku and StartRengokuMagnet end,
        filter = function(name) return name == "Snow Lurker" or name == "Arctic Warrior" end,
        position = function() return RengokuMon end,
        size = Vector3.new(1500,1500,1500)
    },
    {
        enabled = function() return _G.MusketeerHat and StartMagnetMusketeerhat end,
        filter = function(name) return name == "Forest Pirate" end,
        position = function() return MusketeerHatMon end
    },
    {
        enabled = function() return _G.ObservationHakiV2 and Mangnetcitzenmon end,
        filter = function(name) return name == "Forest Pirate" end,
        position = function() return PosHee end
    },
    {
        enabled = function() return _G.EvoRace and StartEvoMagnet end,
        filter = function(name) return name == "Zombie" end,
        position = function() return PosMonEvo end
    },
    {
        enabled = function() return _G.Bartilo and AutoBartiloBring end,
        filter = function(name) return name == "Swan Pirate" end,
        position = function() return PosMonBarto end
    },
    {
        enabled = function() return _G.AutoMaterial and StartMaterialMagnet end,
        filter = function(name) return table.find(MaterialList,name) end,
        position = function() return PosMonMaterial end
    },
    {
        enabled = function() return _G.FarmFruitMastery and StartMasteryFruitMagnet end,
        filter = function(name) return name == "Monkey" or name == "Factory Staff" or name == Mon end,
        position = function() return PosMonMasteryFruit end
    },
    {
        enabled = function() return _G.FarmGunMastery and StartMasteryGunMagnet end,
        filter = function(name) return name == "Monkey" or name == "Factory Staff" or name == Mon end,
        position = function() return PosMonMasteryGun end
    },
    {
        enabled = function() return _G.Bone and StartMagnetBoneMon end,
        filter = function(name) return table.find(BoneList,name) end,
        position = function() return PosMonBone end
    },
    {
        enabled = function() return _G.DoughtBoss and MagnetDought end,
        filter = function(name) return table.find(DoughList,name) end,
        position = function() return PosMonDoughtOpenDoor end
    },
    {
        enabled = function() return _G.FarmNearest and AutoFarmNearestMagnet end,
        filter = function(name) return true end,
        position = function() return PosMonNear end
    },
    {
        enabled = function() return _G.Level and StartMagnet end,
        filter = function(name) return name == Mon end,
        position = function() return PosMon end,
        customDistance = function(enemyDist)
            local specialList = {
                "Skibidi","ChaleloChalala","MeoMayBe"
            }
            return table.find(specialList,Mon) and enemyDist <= 500 or enemyDist <= getgenv().BringRange
        end
    }
}

getgenv().BringRange = 600

task.spawn(function()
    while task.wait(0.5) do
        pcall(function()

            if not getgenv().BringMonster then return end
            if CheckQuest then CheckQuest() end

            local plr = game.Players.LocalPlayer
            if not plr.Character then return end

            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if not root then return end

            local candidates = {}

            -------------------------------------------------------------------
            -- THU THẬP DANH SÁCH MOB HỢP LỆ
            -------------------------------------------------------------------
            for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                
                local hrp = enemy:FindFirstChild("HumanoidRootPart")
                local hum = enemy:FindFirstChild("Humanoid")

                if hrp and hum and hum.Health > 0 then
                    
                    for _, cfg in pairs(magnetConfigs) do
                        if cfg.enabled() and cfg.filter(enemy.Name) then
                            
                            local target = cfg.position()
                            if not target or not target.Position then break end

                            local dist = (hrp.Position - target.Position).Magnitude
                            if dist <= getgenv().BringRange then
                                table.insert(candidates, {
                                    Enemy = enemy,
                                    HRP = hrp,
                                    Size = cfg.size,
                                })
                                break
                            end
                        end
                    end
                end
            end

            -------------------------------------------------------------------
            -- GHÉP CẶP MOB (2 CON / CẶP)
            -------------------------------------------------------------------
            local pairsList = {}  
            table.sort(candidates, function(a,b)
                return a.HRP.Position.Magnitude < b.HRP.Position.Magnitude
            end)

            local i = 1
            while i <= #candidates - 1 do
                local A = candidates[i]
                local B = candidates[i + 1]

                table.insert(pairsList, {A, B})

                i = i + 2
            end

            -- Nếu còn 1 con lẻ → bỏ qua không bring
            -- ✔ đúng yêu cầu của bạn

            -------------------------------------------------------------------
            -- XỬ LÝ TỪNG CẶP VỚI MIDPOINT RIÊNG BIỆT
            -------------------------------------------------------------------
            for _, pair in pairs(pairsList) do
                local A = pair[1]
                local B = pair[2]

                local mid = (A.HRP.Position + B.HRP.Position) / 2
                local midpointCF = CFrame.new(mid)

                -- tween mỗi con trong cặp về midpoint riêng
                TweenEnemyToTarget(A.Enemy, midpointCF, A.Size)
                TweenEnemyToTarget(B.Enemy, midpointCF, B.Size)
            end

        end)
    end
end)

local HiuUi =  loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/main/LoadUi.lua"))()
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/main/HopServerModule.lua"))()
local HttpService = game:GetService("HttpService")
local Window = HiuUi:Window({
    Title = "Vex Hub",
    SubTitle = "Blox Kid",
    Theme = "rbxassetid://84435441882847",
    UiTransparency = 0.75,
    Size = UDim2.new(0, 550, 0, 350),
    TabWidth = 120
})

----------------------------------Server Tab---------------------------------------------------------------------------------------------
local ServerTab = Window:Tab("Server","")
ServerTab:Seperator("Server Status")
ServerTab:Line()
local MoonStatus_La = ServerTab:Label("Moon Status: Unknown")
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            local lighting = game:GetService("Lighting")
            local moonTextureId = nil

            for _, obj in pairs(lighting:GetChildren()) do
                if obj:IsA("Sky") then
                    moonTextureId = obj.MoonTextureId
                    break
                end
            end

            if not moonTextureId then
                MoonStatus_La:Set("Moon Status: Unknown")
                return
            end

            if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                MoonStatus_La:Set("Moon Status: 🌕 Full Moon")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                MoonStatus_La:Set("Moon Status: 🌖 75%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                MoonStatus_La:Set("Moon Status: 🌓 50%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                MoonStatus_La:Set("Moon Status: 🌘 25%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                MoonStatus_La:Set("Moon Status: 🌑 15%")
            else
                MoonStatus_La:Set("Moon Status: 🌚 0%")
            end
        end)
    end
end)
if World1 then
    local TheSawStatus_La = ServerTab:Label("The Saw Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") or game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                    TheSawStatus_La:Set("The Saw Status : ✅️")
                else
                    TheSawStatus_La:Set("The Saw Status : ❌️")
                end
            end)
        end
    end)

    local GreyBeardStatus_La = ServerTab:Label("Grey Beard Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") or game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                    GreyBeardStatus_La:Set("Grey Beard Status : ✅️")
                else
                    GreyBeardStatus_La:Set("Grey Beard Status : ❌️")
                end
            end)
        end
    end)
end
if World2 then
    local CursedCaptainStatus_La = ServerTab:Label("Cursed Captain Status: Unknown")
    task.spawn(function()
        while wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Captain") then
                    CursedCaptainStatus_La:Set("Cursed Captain Status : ✅️")
                else
                    CursedCaptainStatus_La:Set("Cursed Captain Status : ❌️")
                end
            end)
        end
    end)
    local LegendarySwordStatus = ServerTab:Label("Legendary Sword Status: Unknown")
    task.spawn(function()
        local previousStatus = ""
        while task.wait(0.5) do
            local swordStatus = "Legendary Sword Status : ❌"
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                swordStatus = "Legendary Sword Status: Shisui"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
                swordStatus = "Legendary Sword Status: Wando"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
                swordStatus = "Legendary Sword Status: Saddi"
            end
            LegendarySwordStatus:Set(swordStatus)
        end
    end)
end

if World3 then

    local MirageIslandStatus = ServerTab:Label("Mirage Island Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game.Workspace.Map:FindFirstChild("MysticIsland") then
                    MirageIslandStatus:Set("Mirage Island Status : ✅")
                else
                    MirageIslandStatus:Set("Mirage Island Status : ❌")
                end
            end)
        end
    end)

    local LeviathanStatus = ServerTab:Label("Spy Status: Unknown")
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                local SpyStatus = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
                if (SpyStatus == 5) then
                    LeviathanStatus:Set("Spy Status : Leviathan Is Out There")
                elseif (SpyStatus == -1) then
                    LeviathanStatus:Set("Spy Status : I Don't Know")
                else
                    LeviathanStatus:Set("Buy: " .. tostring(SpyStatus))
                end
            end
        end)
    end)

    local FrozenDimensionStatus = ServerTab:Label("Frozen Dimension Status: Unknown")
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
                    FrozenDimensionStatus:Set("Frozen Dimension Status : ✅")
                else
                    FrozenDimensionStatus:Set("Frozen Dimension Status : ❌")
                end
            end
        end)
    end)

    local KitsuneIslandStatus = ServerTab:Label("Kitsune Island Status: Unknown")
    function UpdateKitsune()
        if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
            KitsuneIslandStatus:Set("Kitsune Island Status : ✅️")
        else
            KitsuneIslandStatus:Set("Kitsune Island Status : ❌️")
        end
    end
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                UpdateKitsune()
            end
        end)
    end)

    local PrehistoricIslandStatus = ServerTab:Label("Volcano Island: Unknown")
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                    PrehistoricIslandStatus:Set("Volcano Island : ✅️")
                else
                    PrehistoricIslandStatus:Set("Volcano Island : ❌️")
                end
            end
        end)
    end)

    local CakePrinceStatus = ServerTab:Label("Cake Prince Status: ")
    task.spawn(function()
        while wait() do
            pcall(function()
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                    KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41)) - 500)
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                    KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),40,41)) - 500)
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                    KillMob = (tonumber(string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),41,41)) - 500)
                end
            end)
        end
    end)

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                    CakePrinceStatus:Set("Cake Prince Status Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                    CakePrinceStatus:Set("Cake Prince Status Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                    CakePrinceStatus:Set("Cake Prince Status Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39).." Mobs")
                else
                    CakePrinceStatus:Set("Cake Prince Status : Cake Prince Is Spawning!")
                end
            end)
        end
    end)

    local EliteHunterStatus = ServerTab:Label("Elite Hunter Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                    EliteHunterStatus:Set("Elite Hunter : ✅️")
                else
                    EliteHunterStatus:Set("Elite Hunter : ❌️")
                end
            end)
        end
    end)
end
local FruitStatus = ServerTab:Label("Fruit in Server: Unknown")
local FruitList = {
    "Bomb Fruit", "Spike Fruit", "Spring Fruit", "Spin Fruit",
    "Eagle Fruit", "Smoke Fruit", "Flame Fruit", "Ice Fruit", "Sand Fruit", "Dark Fruit",
    "Diamond Fruit", "Light Fruit", "Love Fruit", "Rubber Fruit", "Rocket Fruit",
    "Creation Fruit", "Magma Fruit", "Portal Fruit", "Quake Fruit", "Buddha Fruit",
    "String Fruit", "Phoenix Fruit", "Rumble Fruit", "Pain Fruit", "Gravity Fruit",
    "Dough Fruit", "Venom Fruit", "Shadow Fruit", "Control Fruit", "Spirit Fruit",
    "Dragon Fruit", "Leopard Fruit", "Blizzard Fruit", "Sound Fruit", "Spider Fruit",
    "T-Rex Fruit", "Ghost Fruit", "Gas Fruit", "Yeti Fruit", "Kitsune Fruit", "Mammoth Fruit","Tiger Fruit"
}
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local foundFruits = {}

            for i, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                    table.insert(foundFruits, v.Name)
                end
            end

            if #foundFruits > 0 then
                FruitStatus:Set("Fruit in Server: (" .. #foundFruits .. "): " .. table.concat(foundFruits, ", "))
            else
                FruitStatus:Set("Fruit in Server: ❌")
            end
        end)
    end
end)

ServerTab:Seperator("Server")
ServerTab:Line()

local ShowJobId = ServerTab:Label("JobId: Unknown")
ShowJobId:Set("JobId: "..game.JobId)

local CopyJobId = ServerTab:Button("Copy JobId", function()
    setclipboard(tostring(game.JobId))
    HiuUi:Notify("Copied JobId Server!")
end)

local JobIdText = ServerTab:Textbox("Enter JobId Here",false, function(n)
    getgenv().JobId = n
end)

local JoinButton = ServerTab:Button("Join Server With JobId", function()
    if getgenv().JobId == "PV" then
        HiuUi:Notify("Teleporting to Vip Server, and Hello Boss: "..game.Players.LocalPlayer.Name)
        task.wait(1.5)
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FREE-PRIVATE-SERVER-V2-59627"))()

    elseif getgenv().JobId and getgenv().JobId ~= "" then
        HiuUi:Notify("Teleporting to JobId: "..getgenv().JobId)
        task.wait(1.5)
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            getgenv().JobId,
            game.Players.LocalPlayer
        )

    else
        HiuUi:Notify("Please Enter JobId First!")
    end
end)


local ClearJobId = ServerTab:Button("Clear JobId", function()
    if not getgenv().JobId or getgenv().JobId == "" then
        return
    end
    getgenv().JobId = nil
    JobIdText:SetValue("")
    HiuUi:Notify("JobId has been cleared!")
end)

local HopServerButton = ServerTab:Button("Hop Server", function ()
    HiuUi:Notify("Teleporting to server: "..ServerHop:GetNextServerJobId())
    task.wait(1.5)
    ServerHop:Teleport()
end)
local HopLowPlayer = ServerTab:Button("Hop Server Less Player",function()
    HiuUi:Notify("Teleporting to server")
    task.wait(1.5)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/main/HopServerLessPlayer.lua"))()
end)

local ShopTab = Window:Tab("Shop","")
ShopTab:Seperator("Fighting Shop")
ShopTab:Line()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF_Remote = Remotes:WaitForChild("CommF_")

local BuyBlackLeg_T = ShopTab:Toggle("Black Leg", false,"", function(v)
    _G.BuyBlackLeg = v
    if not v then StopTween() end
end)

task.spawn(function()
    while task.wait(0.5) do
        if _G.BuyBlackLeg then
            local BlackLegNPC_W1 = CFrame.new(-987.873047, 13.7778397, 3989.4978, 1, 0, 0, 0, 1, 0, 0, 0, 1)
            local BlackLegNPC_W2 = CFrame.new(-4995.461, 42.93, -4499.034, 0.173, 0, 0.985, 0, 1, 0, -0.985, 0, 0.173)
            local targetNPC
            if World1 then
                targetNPC = BlackLegNPC_W1
            elseif World2 then
                targetNPC = BlackLegNPC_W2
            end

            if targetNPC then
                TP1(targetNPC)

                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and (hrp.Position - targetNPC.Position).Magnitude <= 5 then
                    local success, result = pcall(function()
                        return CommF_Remote:InvokeServer("BuyBlackLeg")
                    end)
                    if not success then
                        warn("Failed to buy BlackLeg:", result)
                    end
                end
            end
        end
    end
end)

---------------------FramingTab----------------------------------------------------------------------------------------------------
local FramingTab = Window:Tab("Framing","")
local FramingTab_Se = FramingTab:Seperator("Framing")
local FramingTab_L = FramingTab:Line()

local FramLevel_T = FramingTab:Toggle("Auto Fram Level",false,"",function(v)
    _G.Level = v 
    if not v then StopTween() end
end)

task.spawn(function()
    while task.wait(0.1) do
        if _G.Level then
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local questUI = player.PlayerGui.Main.Quest
                local questTitle = questUI.Container.QuestTitle.Title.Text
                --Hủy Quest nếu nhận sai 
                if not string.find(questTitle, NameMon) then
                    StartMagnet = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end
                --Chưa có Quest thì Quest
                if not questUI.Visible then
                    StartMagnet = false
                    CheckQuest()
                    TP1(CFrameQuest)
                    
                    if (player.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                    end

                elseif questUI.Visible then
                    CheckQuest()
                    local foundEnemy = false

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy.Name == Mon 
                            and enemy:FindFirstChild("HumanoidRootPart") 
                            and enemy:FindFirstChild("Humanoid") 
                            and enemy.Humanoid.Health > 0 then

                            if string.find(questTitle, NameMon) then
                                foundEnemy = true
                                repeat
                                    task.wait(0.1)
                                    StartMagnet = true
                                    EquipWeapon(getgenv().SelectWeapon)
                                    PosMon = enemy.HumanoidRootPart.CFrame
                                    TP1(enemy.HumanoidRootPart.CFrame * Pos)
                                    getgenv().Seriality = true
                                    enemy.HumanoidRootPart.CanCollide = false
                                    enemy.Humanoid.WalkSpeed = 0
                                    enemy.Head.CanCollide = false
                                    enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                until not _G.Level 
                                    or enemy.Humanoid.Health <= 0 
                                    or not enemy.Parent 
                                    or not questUI.Visible
                            else
                                StartMagnet = false
                                getgenv().Seriality = false
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                            end
                        end
                    end

                    if not foundEnemy then
                        StartMagnet = false
                        getgenv().Seriality = false
                        local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                        if hrp and CFrameMon then
                            local scanHeight = PosY  -- độ cao
                            local scanRadius = 100 -- bán kính hình vuông

                            local offsets = {
                                Vector3.new(scanRadius, scanHeight, scanRadius),
                                Vector3.new(-scanRadius, scanHeight, scanRadius),
                                Vector3.new(scanRadius, scanHeight, -scanRadius),
                                Vector3.new(-scanRadius, scanHeight, -scanRadius)
                            }

                            for _, offset in ipairs(offsets) do
                                if not _G.Level or not questUI.Visible then break end
                                local targetCF = CFrameMon * CFrame.new(offset)
                                TP1(targetCF)
                                task.wait(1)
                            end
                        end
                    end
                end
            end)
        end
    end
end)

FramingTab:Seperator("Auto World Quest")
FramingTab:Line()

if World1 then
    local AutoDessrosaQuest_T = FramingTab:Toggle("Auto Dressrosa Quest", false, "", function(v)
        _G.DressrosaQuest = v
        if not v then StopTween() end
    end)

    -- Helper functions
    local function HasKey()
        local player = game.Players.LocalPlayer
        local char = player.Character
        return player.Backpack:FindFirstChild("Key") or (char and char:FindFirstChild("Key"))
    end

    local function FindIceAdmiral()
        for _, v in pairs(workspace.Enemies:GetChildren()) do
            if v.Name == "Ice Admiral"
            and v:FindFirstChild("Humanoid")
            and v:FindFirstChild("HumanoidRootPart")
            and v.Humanoid.Health > 0 then
                return v
            end
        end
        return nil
    end

    local function FightBoss(boss)
        if not boss then return end
        if not boss:FindFirstChild("HumanoidRootPart") then return end
        if not boss:FindFirstChild("Humanoid") then return end

        repeat
            task.wait()

            if not boss:FindFirstChild("Humanoid") then break end
            if not boss:FindFirstChild("HumanoidRootPart") then break end
            if boss.Humanoid.Health <= 0 then break end
            if not boss:IsDescendantOf(workspace) then break end
            EquipWeapon(getgenv().SelectWeapon)
            boss.HumanoidRootPart.CanCollide = false
            boss.Humanoid.WalkSpeed = 0
            boss.Head.CanCollide = false
            boss.HumanoidRootPart.Size = Vector3.new(50, 50, 50)

            getgenv().Seriality = true

            pcall(function()
                topos(boss.HumanoidRootPart.CFrame * Pos)
            end)

            pcall(function()
                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
            end)

        until not _G.DressrosaQuest
            or not boss:IsDescendantOf(workspace)
            or boss.Humanoid.Health <= 0

        -- Boss defeated → Go to Sea 2
        if _G.DressrosaQuest and boss.Humanoid.Health <= 0 then
            print("Boss defeated → Traveling to Sea 2...")

            task.wait(2)
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:
                    InvokeServer("TravelDressrosa")
            end)
        end
    end

    -- Main loop
    task.spawn(function()
        while task.wait(0.1) do
            if _G.DressrosaQuest then
                local player = game.Players.LocalPlayer
                local char = player.Character or player.CharacterAdded:Wait()
                local hrp = char:FindFirstChild("HumanoidRootPart")

                local level = player.Data and player.Data:FindFirstChild("Level")

                if hrp and level and level.Value >= 700 and World1 then

                    -------------------------
                    -- Step 1: Go to quest giver
                    -------------------------
                    local questCFrame = CFrame.new(4852.936, 5.6865, 719.443)
                    repeat
                        topos(questCFrame)
                        task.wait(0.5)
                    until (hrp.Position - questCFrame.Position).Magnitude <= 3
                        or not _G.DressrosaQuest

                    -------------------------
                    -- Step 2: Accept quest
                    -------------------------
                    pcall(function()
                        game.ReplicatedStorage.Remotes.CommF_:
                            InvokeServer("DressrosaQuestProgress", "Detective")
                    end)

                    -------------------------
                    -- Step 3: Equip the key
                    -------------------------
                    if HasKey() then
                        EquipWeapon("Key")
                    end

                    -------------------------
                    -- Step 4: Go to Ice Door
                    -------------------------
                    local doorCFrame = CFrame.new(1347.693, 37.3844, -1325.168)
                    repeat
                        topos(doorCFrame)
                        task.wait(0.5)
                    until (hrp.Position - doorCFrame.Position).Magnitude <= 3
                        or not _G.DressrosaQuest

                    task.wait(1)

                    -------------------------
                    -- Step 5: Find and fight Ice Admiral
                    -------------------------
                    local boss = nil

                    -- Wait for boss to spawn (max 10 seconds)
                    for i = 1, 20 do
                        boss = FindIceAdmiral()
                        if boss then break end
                        task.wait(0.5)
                    end

                    if boss then
                        FightBoss(boss)
                    else
                        print("Boss not found → Traveling to Sea 2...")
                        pcall(function()
                            game.ReplicatedStorage.Remotes.CommF_:
                                InvokeServer("TravelDressrosa")
                        end)
                    end

                end
            end
        end
    end)
end


---------------------SettingTab----------------------------------------------------------------------------------------------------
local SettingsTab = Window:Tab("Settings Fram","")
SettingsTab:Seperator("Weapon Settings")
SettingsTab:Line()

local Weaponlist = {"Melee","Sword","Blox Fruits"}
local SelectWeapon_Dd = SettingsTab:Dropdown("Select Weapon:", Weaponlist, "Melee", function(v)
    getgenv().SelectWeaponType = v
end)

getgenv().SelectWeapon = nil

task.spawn(function()
    while task.wait() do
        pcall(function()
            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v.ToolTip == getgenv().SelectWeaponType then
                    getgenv().SelectWeapon = v.Name
                    break
                end
            end
        end)
    end
end)

SettingsTab:Seperator("Character Settings")
SettingsTab:Line()

local SpeedList = {"180", "250", "300", "325", "350"}

local TweenSpeed_Dd = SettingsTab:Dropdown("Tween Speed:", SpeedList, "350", function(v)
    getgenv().TweenSpeed = tonumber(v)
end)

local TurnOnBuso_T = SettingsTab:Toggle("Buso Haki", true, "", function(v)
    getgenv().Haki = v
end)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Haki then
            local char = game.Players.LocalPlayer.Character
            if char and not char:FindFirstChild("HasBuso") then
                game.ReplicatedStorage.Remotes.CommF_:InvokeServer("Buso")
            end
        end
    end
end)

local TurnOnKen_T = SettingsTab:Toggle("Turn On Ken", false, "", function(v)
    getgenv().Ken = v
end)
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Ken then
            local player = game:GetService("Players").LocalPlayer
            local playerGui = player:WaitForChild("PlayerGui")
            local screenGui = playerGui:FindFirstChild("ScreenGui")
            if screenGui and not screenGui:FindFirstChild("ImageLabel") then
                local vu = game:GetService("VirtualUser")
                vu:CaptureController()
                vu:SetKeyDown("0x65") -- E
                task.wait(0.05)
                vu:SetKeyUp("0x65")
            end
        end
    end
end)

getgenv().PointAmount = 9999
getgenv().AddPointMode = getgenv().AddPointMode or "Melee"

-- Hàm lấy Stat hiện tại của Player
local function GetStat(stat)
    return game.Players.LocalPlayer.Data.Stats[stat].Level.Value
end

-- Thêm điểm
local function AddPoint(stat, amount)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AddPoint", stat, amount)
end

-- Check stat còn lên được hay không
local function CanStillLevel(stat)
    local before = GetStat(stat)
    AddPoint(stat, 1)
    task.wait(0.1)
    return GetStat(stat) > before
end

local StatsList = {
    "Melee",
    "Defense",
    "Gun",
    "Blox Fruit"
}

SettingsTab:Dropdown("Select Stats: ", StatsList, "Melee", function(v)
    getgenv().AddPointMode = v
end)

task.spawn(function()
    local MeleeMaxed, DefenseMaxed = false, false

    while task.wait(0.5) do
        if not getgenv().AutoStats then continue end

        local mode = getgenv().AddPointMode

        if mode == "Auto Add Point (Melee + Defense)" then
            if not MeleeMaxed then
                if CanStillLevel("Melee") then
                    AddPoint("Melee", getgenv().PointAmount)
                    continue
                else
                    MeleeMaxed = true
                end
            end

            if not DefenseMaxed then
                if CanStillLevel("Defense") then
                    AddPoint("Defense", getgenv().PointAmount)
                    continue
                else
                    DefenseMaxed = true
                end
            end
        else

            local statMap = {
                ["Melee"] = "Melee",
                ["Defense"] = "Defense",
                ["Gun"] = "Gun",
                ["Blox Fruit"] = "Demon Fruit"
            }

            local chosen = statMap[mode]
            if chosen then
                AddPoint(chosen, getgenv().PointAmount)
            end
        end
    end
end)

local AddStats_T = SettingsTab:Toggle("Auto Stats", false, "", function(v)
    getgenv().AutoStats = v
end)


SettingsTab:Seperator("Distance Settings")
SettingsTab:Line()

Type = 1
PosX = 0 or PosX
PosY = 20 or PosY
PosZ = 0 or PosZ

local PosX_Sd = SettingsTab:Slider("Distance X", 0, 60, PosX, function(v)
    PosX = v
end)

local PosY_Sd = SettingsTab:Slider("Distance Y", 0, 60, PosY, function(v)
    PosY = v
end)

local PosZ_Sd = SettingsTab:Slider("Distance Z", 0, 60, PosZ, function(v)
    PosZ = v
end)

task.spawn(function()
    while task.wait() do
        Pos = CFrame.new(PosX, PosY, PosZ)
    end
end)

task.spawn(function()
    while task.wait() do
        Type = (Type % 4) + 1  
    end
end)

SettingsTab:Seperator("Fram Settings")
SettingsTab:Line()

local FastAttack_T = SettingsTab:Toggle("Fast Attack",true,"",function(v)
    getgenv().KID = v
end)

local RemoveNotify_T = SettingsTab:Toggle("Remove Notifications", false, "", function(v)
    getgenv().Remove_Notify = v
end)

task.spawn(function()
    while task.wait(0.1) do
        if getgenv().Remove_Notify then
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false
        else
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true
        end
    end
end)

local BringMob_T = SettingsTab:Toggle("Bring Mob", true, "", function(v)
    getgenv().BringMonster = v
end)


