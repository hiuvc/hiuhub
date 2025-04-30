Dưới đây là phiên bản tách riêng hàm EquipMelee() ra khỏi AttackNoCooldown() để dễ tái sử dụng:


---

Hàm trang bị vũ khí Melee (dựa trên ToolTip)

function EquipMelee()
    local player = game.Players.LocalPlayer
    local backpack = player:WaitForChild("Backpack")

    for _, tool in ipairs(backpack:GetChildren()) do
        if tool:IsA("Tool") and tool:FindFirstChild("ToolTip") then
            if string.find(tool.ToolTip.Value, "Melee") then
                player.Character.Humanoid:EquipTool(tool)
                break
            end
        end
    end
end


---

Hàm tấn công không delay (Fast Attack with delay limit)

function AttackNoCooldown(delay)
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local VirtualUser = game:GetService("VirtualUser")
    local LocalPlayer = Players.LocalPlayer
    local lastAttackTime = 0
    local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)

    -- Tắt rung camera
    pcall(function()
        CameraShaker:Stop()
    end)

    -- Trang bị vũ khí Melee
    EquipMelee()

    -- Fast Attack xử lý
    coroutine.wrap(function()
        for _, func in pairs(getreg()) do
            if typeof(func) == "function" and getfenv(func).script == LocalPlayer.PlayerScripts:FindFirstChild("CombatFramework") then
                for _, upvalue in pairs(debug.getupvalues(func)) do
                    if typeof(upvalue) == "table" and upvalue.activeController then
                        local controller = upvalue.activeController
                        RunService.RenderStepped:Connect(function()
                            if tick() - lastAttackTime >= delay then
                                pcall(function()
                                    controller.timeToNextAttack = 0
                                    controller.attacking = false
                                    controller.increment = 4
                                    controller.blocking = false
                                    controller.hitboxMagnitude = 150
                                    controller.humanoid.AutoRotate = true
                                    controller.focusStart = 0
                                    controller.currentAttackTrack = 0
                                    sethiddenproperty(LocalPlayer, "SimulationRaxNerous", math.huge)
                                    lastAttackTime = tick()
                                end)
                            end
                        end)
                    end
                end
            end
        end
    end)()

    -- Auto Click liên tục
    RunService.RenderStepped:Connect(function()
        pcall(function()
            VirtualUser:CaptureController()
            VirtualUser:Button1Down(Vector2.new(0, 1))
        end)
    end)
end


---

Cách sử dụng

EquipMelee()
AttackNoCooldown(0.15)


---

Bạn có muốn mở rộng EquipWeaponByType("Sword") hoặc "Blox Fruit" để chọn theo loại vũ khí không?

