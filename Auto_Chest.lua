-- Cấu hình
--_G.Team = "Pirates" -- hoặc "Marine"
--_G.Noclip = true
--_G.AutoCollectChest = true
--_G.CollectedChestCount = 0
--_G.ChestLimit = 10 -- Số rương cần nhặt trước khi chuyển server
--_G.Speed =  180
-- Chọn team
local player = game.Players.LocalPlayer
local currentTeam = player.Team and player.Team.Name

if _G.Team == "Marine" and currentTeam ~= "Marines" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
elseif _G.Team == "Pirates" and currentTeam ~= "Pirates" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
elseif _G.Team ~= "Marine" and _G.Team ~= "Pirates" then
    player:Kick("=))???")
end

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

    -- Giữ đứng yên
    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 0
    end

    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(0, 0, 0)
    bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bv.Name = "ChestBodyVel"
    bv.Parent = HRP

    -- Tween
    local tween = game:GetService("TweenService"):Create(
        HRP,
        TweenInfo.new(Distance / _G.Speed, Enum.EasingStyle.Linear),
        { CFrame = P1 }
    )
    tween:Play()
    tween.Completed:Wait()

    -- Gỡ các giới hạn sau tween
    if HRP:FindFirstChild("ChestBodyVel") then
        HRP.ChestBodyVel:Destroy()
    end
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

-- Hop server kèm thông báo
function Hop()
    pcall(function()
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "AUTO CHEST",
            Text = "Đang chuyển server mới...",
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
    while task.wait() do
        if _G.AutoCollectChest then
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

            -- Nếu có rương gần nhất
            if nearestChest then
                local chestCF = CFrame.new(nearestChest:GetPivot().Position)
                Tween2(chestCF)

                -- Đợi chest bị disable (đã nhặt xong)
                local timeout = 3
                repeat
                    task.wait(0.2)
                    timeout = timeout - 0.2
                until nearestChest:GetAttribute("IsDisabled") == true or timeout <= 0

                if nearestChest:GetAttribute("IsDisabled") == true then
                    _G.CollectedChestCount = _G.CollectedChestCount + 1
                    print("✅ Đã nhặt: " .. _G.CollectedChestCount .. " rương")

                    if _G.CollectedChestCount >= _G.ChestLimit then
                        print("🌍 Đã đủ số rương, chuẩn bị chuyển server...")
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        return -- dừng toàn bộ thread sau khi hop
                    end
                else
                    print("⚠️ Bỏ qua rương không phản hồi.")
                    -- không làm gì thêm => tiếp tục vòng while
                end
            else
                print("⛔ Không tìm thấy rương nào.")
            end
        end
    end
end)

game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "AUTO CHEST",
    Text = "Made by Hiuvc \n version: 1.0",
    Duration = 4,
})
