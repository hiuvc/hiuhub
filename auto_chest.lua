-- Chọn team
if _G.Team == "Marine" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
elseif _G.Team == "Pirates" then
    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
else
    game.Players.LocalPlayer:Kick("=))???")
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

            if nearestChest then
                local chestCF = CFrame.new(nearestChest:GetPivot().Position)
                Tween2(chestCF)

                -- Đợi chest bị disable (tức là đã được nhặt)
                local timeout = 3
                repeat
                    task.wait(0.2)
                    timeout -= 0.2
                until nearestChest:GetAttribute("IsDisabled") == true or timeout <= 0

                -- Nếu chest bị disable, xác nhận đã nhặt
                if nearestChest:GetAttribute("IsDisabled") == true then
                    _G.CollectedChestCount += 1
                    print("✅ Đã nhặt: " .. _G.CollectedChestCount .. " rương")

                    if _G.CollectedChestCount >= _G.ChestLimit then
                        print("🌍 Đã đủ số rương, chuyển server...")
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        break
                    end
                else
                    print("⚠️ Rương không phản hồi, thử tiếp...")
                end
            end
        end
    end
end)

-- Tween di chuyển đến rương
function Tween2(targetCFrame)
    local root = game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
    local distance = (targetCFrame.Position - root.Position).Magnitude
    local speed = 180 -- tăng tốc
    local tweenTime = distance / speed
    local tweenInfo = TweenInfo.new(tweenTime, Enum.EasingStyle.Linear)
    local tween = game:GetService("TweenService"):Create(root, tweenInfo, { CFrame = targetCFrame })
    tween:Play()

    if _G.CancelTween2 then
        tween:Cancel()
    end

    _G.Clip2 = true
    task.wait(tweenTime)
    _G.Clip2 = false
end

-- Hop server
function Hop()
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
