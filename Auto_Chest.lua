local HttpService = game:GetService("HttpService")
local player = game.Players.LocalPlayer
local webhookUrl = _G.Webhook

local function sendWebhook(title, description)
    local data = {
        ["username"] = "Auto Chest Status",
        ["avatar_url"] = "https://i.imgur.com/qUWAHLt.jpeg",
        ["embeds"] = {{
            ["title"] = title,
            ["description"] = description,
            ["color"] = tonumber(0x5DADE2),
            ["footer"] = {
                ["text"] = "Auto Chest • " .. os.date("%d/%m/%Y at %H:%M"),
                ["icon_url"] = "https://i.imgur.com/qUWAHLt.jpeg"
            },
            ["thumbnail"] = {
                ["url"] = "https://i.imgur.com/qUWAHLt.jpeg"
            }
        }}
    }

    local jsonData = HttpService:JSONEncode(data)

    local req = (syn and syn.request) or (http and http.request) or http_request or request
    if req then
        pcall(function()
            req({
                Url = webhookUrl,
                Method = "POST",
                Headers = {
                    ["Content-Type"] = "application/json"
                },
                Body = jsonData
            })
        end)
    end
end

-- Phần chọn team và khởi động
local currentTeam = player.Team and player.Team.Name
if _G.Team == "Marine" and currentTeam ~= "Marines" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
elseif _G.Team == "Pirates" and currentTeam ~= "Pirates" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
elseif _G.Team ~= "Marine" and _G.Team ~= "Pirates" then
    player:Kick("=))???")
end
_G.Noclip = true
_G.CollectedChestCount = 0
task.wait(5)
_G.AutoCollectChest = true

-- Anti-Admin
local AdminUserIds = {17884881, 120173604, 912348, 3095250}
spawn(function()
    while task.wait(2) do
        for _, p in pairs(game:GetService("Players"):GetPlayers()) do
            if table.find(AdminUserIds, p.UserId) then
                sendWebhook("⚠️ WARNING!", "**Admin/Dev detected! Auto hop server!**")
                pcall(function()
                    game:GetService("StarterGui"):SetCore("SendNotification", {
                        Title = "⚠️ WARNING!",
                        Text = "Admin/Dev detected in the server!\nHop to a new server...",
                        Duration = 5,
                    })
                end)
                if typeof(Hop) == "function" then Hop() else player:Kick("Admin/Dev Detected") end
                break
            end
        end
    end
end)

-- Anti-AFK
player.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)
spawn(function()
    while task.wait(1) do -- Kiểm tra mỗi 1 giây là đủ
        pcall(function()
            if _G.AutoKen then
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true)
                print("Ken Haki: On")
            end
        end)
    end
end)

-- Noclip
spawn(function()
    while _G.Noclip do
        task.wait()
        local char = player.Character
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
    local char = player.Character or player.CharacterAdded:Wait()
    local HRP = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    local Distance = (P1.Position - HRP.Position).Magnitude

    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 50
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping) -- 🟢 Jump để thoát ghế trước khi Tween
    end

    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Name = "ChestBodyVel"
    bv.Parent = HRP

    local tween = game:GetService("TweenService"):Create(HRP, TweenInfo.new(Distance / _G.Speed, Enum.EasingStyle.Linear), { CFrame = P1 })
    tween:Play()
    tween.Completed:Wait()

    if HRP:FindFirstChild("ChestBodyVel") then HRP.ChestBodyVel:Destroy() end

    -- 🟢 Jump một lần nữa sau Tween để chắc chắn thoát khỏi ghế
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end



-- Hop server
function Hop()
    local beliAmount = player.Data.Beli.Value
    local placeId = game.PlaceId

    -- Xác định Sea hiện tại
    local currentSea = "Unknown"
    if placeId == 2753915549 then
        currentSea = "1"
    elseif placeId == 4442272183 then
        currentSea = "2"
    elseif placeId == 7449423635 then
        currentSea = "3"
    end

    -- Gửi webhook gộp
    sendWebhook("🔁 Auto Chest Status", "**Username:** `" .. player.Name .. "`\n**Sea:** `" .. currentSea .. "`\n**Beli:** `" .. beliAmount .. "`\n\n📡 Đã hop sang server khác")

    -- Gửi thông báo trên màn hình
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AUTO CHEST",
            Text = "HOP SERVER...",
            Duration = 5,
        })
    end)

    task.wait(2)

    -- Chuẩn bị danh sách server
    local triedServers = {}
    local cursor = ""

    local function GetServers()
        local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?sortOrder=Asc&limit=100"
        if cursor ~= "" then url = url .. "&cursor=" .. cursor end
        local success, response = pcall(function()
            return game.HttpService:JSONDecode(game:HttpGet(url))
        end)
        return success and response or nil
    end

    local function TeleportToNewServer()
        local maxRetries = 3  -- Số lần thử tối đa
        local retryCount = 0

        while retryCount < maxRetries do
            local data = GetServers()
            if not data then
                retryCount = retryCount + 1
                task.wait(2)  -- Chờ trước khi thử lại
                continue  -- Tiếp tục vòng lặp nếu không lấy được dữ liệu server
            end

            cursor = data.nextPageCursor or ""
            for _, server in ipairs(data.data) do
                if server.playing < server.maxPlayers and not table.find(triedServers, server.id) then
                    table.insert(triedServers, server.id)
                    task.wait()
                    local success = pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(placeId, server.id, player)
                    end)
                    if success then
                        return  -- Nếu teleport thành công thì thoát hàm
                    else
                        retryCount = retryCount + 1
                        task.wait(2)  -- Chờ trước khi thử lại
                    end
                end
            end

            -- Nếu không có server hợp lệ hoặc đã thử hết số lần retry, thoát vòng lặp
            if cursor == nil or cursor == "" then break end
        end

        -- Nếu không thể teleport sau số lần retry tối đa
        if retryCount >= maxRetries then
            pcall(function()
                game:GetService("StarterGui"):SetCore("SendNotification", {
                    Title = "AUTO CHEST",
                    Text = "Không thể tìm được server hợp lệ sau " .. maxRetries .. " lần thử.",
                    Duration = 5,
                })
            end)
        end
    end

    TeleportToNewServer()
end




-- Auto collect chest
spawn(function()
    local failCount = 0
    while task.wait() do
        if _G.AutoCollectChest then
            local backpack = player:FindFirstChild("Backpack")
            if backpack then
                local chalice = backpack:FindFirstChild("God's Chalice")
                local fist = backpack:FindFirstChild("Fist of Darkness")
                if chalice or fist then
                    _G.AutoCollectChest = false
                    local foundItem = chalice and "God's Chalice" or "Fist of Darkness"
                    sendWebhook("💎 Item Rare Found!", "**Username :** `" .. player.Name .. "`\n**Item:** `" .. foundItem .. "`")
                    pcall(function()
                        game:GetService("StarterGui"):SetCore("SendNotification", {
                            Title = "AUTO CHEST",
                            Text = "💎 Đã tìm thấy " .. foundItem .. ", dừng nhặt chest!",
                            Duration = 6
                        })
                    end)

                    -- Tìm Sea hiện tại và tween về vị trí
                    local placeId = game.PlaceId
                    if placeId == 4442272183 then -- Sea 2
                        -- Request entrance to The Cafe (vị trí Cafe)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-281.93707275390625, 306.130615234375, 609.280029296875))
                        wait()

                        -- Tween đến vị trí của The Cafe
                        Tween2(CFrame.new(-380.47927856445, 77.220390319824, 255.82550048828))

                    elseif placeId == 7449423635 then -- Sea 3
                        -- Request entrance to Mansion (vị trí Mansion)
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
                        wait()

                        -- Tween đến vị trí của Mansion
                        Tween2(CFrame.new(-12468.5380859375, 375.0094299316406, -7554.62548828125))
                    end

                    return
                end
            end

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
                Tween2(CFrame.new(nearestChest:GetPivot().Position))
                local timeout = 3
                repeat
                    task.wait(0.2)
                    timeout = timeout - 0.2
                until nearestChest:GetAttribute("IsDisabled") == true or timeout <= 0

                if nearestChest:GetAttribute("IsDisabled") == true then
                    _G.CollectedChestCount += 1
                    failCount = 0
                    print("✅ Đã nhặt: " .. _G.CollectedChestCount .. " rương")
                    if _G.CollectedChestCount >= _G.ChestLimit then
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        return
                    end
                else
                    failCount += 1
                    if failCount >= 3 then
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        return
                    end
                end
            else
                failCount += 1
                if failCount >= 3 then
                    _G.AutoCollectChest = false
                    _G.CollectedChestCount = 0
                    Hop()
                    return
                end
            end
        end
    end
end)

-- Notif khởi động
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AUTO CHEST",
    Text = "Made By Hiuvc \n Version: 1.0",
    Duration = 4,
})

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AUTO CHEST",
    Text = "SỐ CHEST CẦN NHẶT: " .. _G.ChestLimit,
    Duration = 4,
})
