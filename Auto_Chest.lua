

-- Chọn team
local player = game.Players.LocalPlayer
local currentTeam = player.Team and player.Team.Name

-- Đảm bảo là team đã được thay đổi xong trước khi bật tính năng auto chest
if _G.Team == "Marine" and currentTeam ~= "Marines" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
elseif _G.Team == "Pirates" and currentTeam ~= "Pirates" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
elseif _G.Team ~= "Marine" and _G.Team ~= "Pirates" then
    player:Kick("=))???")
end
_G.Noclip = true
_G.CollectedChestCount = 0
-- Trì hoãn việc bật AutoCollectChest một chút để đảm bảo team đã được thay đổi hoàn tất
task.wait(5)  -- Thời gian trì hoãn 2 giây

-- Bật tính năng AutoCollectChest sau khi đã chắc chắn rằng team đã thay đổi
_G.AutoCollectChest = true

----------------------------------------------------------------------------------------------------------------------------------
-- Anti-Cheat / Anti-Ban
local AdminUserIds = {17884881, 120173604, 912348, 3095250}

-- Theo dõi admin và tự hop
spawn(function()
    while task.wait(2) do
        for _, player in pairs(game:GetService("Players"):GetPlayers()) do
            if table.find(AdminUserIds, player.UserId) then
                -- Gửi thông báo
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "⚠️ ANTI BAN",
                        Text = "Admin/Dev detected in the server!\nHop to a new server...",
                        Duration = 5,
                    })
                end)

                -- Gọi hàm Hop nếu có
                if typeof(Hop) == "function" then
                    Hop()
                else
                    -- Nếu chưa có hàm Hop, kick tạm thời
                    game.Players.LocalPlayer:Kick("Admin/Dev Detected")
                end
                break
            end
        end
    end
end)

-- Anti-Afk
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

----------------------------------------------------------------------------------------------------------------------------------

-- Noclip
spawn(function()
    while _G.Noclip do
        task.wait()
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.CanCollide == true then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Tween giữ đứng yên
function Tween2(P1)
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local HRP = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    local Distance = (P1.Position - HRP.Position).Magnitude

    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
    end

    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Name = "ChestBodyVel"
    bv.Parent = HRP

    local tween = game:GetService("TweenService"):Create(
        HRP,
        TweenInfo.new(Distance / _G.Speed, Enum.EasingStyle.Linear),
        { CFrame = P1 }
    )
    tween:Play()
    tween.Completed:Wait()

    if HRP:FindFirstChild("ChestBodyVel") then
        HRP.ChestBodyVel:Destroy()
    end
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

-- Hop server
function Hop()
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AUTO CHEST",
            Text = "HOP SERVER...",
            Duration = 5,
        })
    end)

    task.wait(2)

    local placeId = game.PlaceId
    local triedServers = {}
    local cursor = ""

    local function GetServers()
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
        if cursor ~= "" then
            url = url .. "&cursor=" .. cursor
        end
        local success, response = pcall(function()
            return game.HttpService:JSONDecode(game:HttpGet(url))
        end)
        return success and response or nil
    end

    local function TeleportToNewServer()
        while true do
            local data = GetServers()
            if not data then break end

            cursor = data.nextPageCursor or ""

            for _, server in ipairs(data.data) do
                if server.playing < server.maxPlayers and not table.find(triedServers, server.id) then
                    table.insert(triedServers, server.id)
                    task.wait()
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, server.id, game.Players.LocalPlayer)
                    end)
                    return
                end
            end

            if cursor == nil or cursor == "" then break end
        end
    end

    TeleportToNewServer()
end

-- Auto collect chest
spawn(function()
    local failCount = 0

    while task.wait() do
        if _G.AutoCollectChest then
            -- Kiểm tra item hiếm
            local backpack = game:GetService("Players").LocalPlayer:FindFirstChild("Backpack")
            if backpack then
                local chalice = backpack:FindFirstChild("God's Chalice")
                local fist = backpack:FindFirstChild("Fist of Darkness")

                if chalice or fist then
                    _G.AutoCollectChest = false
                    local foundItem = chalice and "God's Chalice" or "Fist of Darkness"
                    print("💎 Đã tìm thấy " .. foundItem)

                    pcall(function()
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "AUTO CHEST",
                            Text = "💎 Đã tìm thấy " .. foundItem .. ", dừng nhặt chest!",
                            Duration = 6
                        })
                    end)

                    return
                end
            end

            -- Tìm chest gần nhất
            local player = game:GetService("Players").LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local pos = char:GetPivot().Position
            local tagged = game:GetService("CollectionService"):GetTagged("_ChestTagged")
            local nearestDist, nearestChest = math.huge

            for _, chest in ipairs(tagged) do
                local chestPos = chest:GetPivot().Position
                local dist = (chestPos - pos).Magnitude
                if not chest:GetAttribute("IsDisabled") and dist < nearestDist then
                    nearestDist, nearestChest = dist, chest
                end
            end

            if nearestChest then
                local chestCF = CFrame.new(nearestChest:GetPivot().Position)
                Tween2(chestCF)

                local timeout = 3
                repeat
                    task.wait(0.2)
                    timeout = timeout - 0.2
                until nearestChest:GetAttribute("IsDisabled") == true or timeout <= 0

                if nearestChest:GetAttribute("IsDisabled") == true then
                    _G.CollectedChestCount = _G.CollectedChestCount + 1
                    failCount = 0
                    print("✅ Đã nhặt: " .. _G.CollectedChestCount .. " rương")

                    if _G.CollectedChestCount >= _G.ChestLimit then
                        print("🌍 Đã đủ số rương, chuẩn bị chuyển server...")
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        return
                    end
                else
                    failCount = failCount + 1
                    print("⚠️ Bỏ qua rương không phản hồi. (" .. failCount .. "/3)")

                    if failCount >= 3 then
                        print("🚨 Gặp quá nhiều rương lỗi! Đang chuyển server...")
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        return
                    end
                end
            else
                print("⛔ Không tìm thấy rương nào.")
                failCount = failCount + 1
                task.wait(1)

                if failCount >= 3 then
                    print("🚨 Không có rương trong map hoặc lỗi! Đang chuyển server...")
                    _G.AutoCollectChest = false
                    _G.CollectedChestCount = 0
                    Hop()
                    return
                end
            end
        end
    end
end)

-- Thông báo khởi động
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AUTO CHEST",
    Text = "Made By Hiuvc \n Version: 1.0",
    Duration = 4,
})

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AUTO CHEST",
    Text = "SỐ CHEST CẦN NHẶT: ".._G.ChestLimit,
    Duration = 4,
})
