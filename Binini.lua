getgenv().BringRange = 350

task.spawn(function()
    while task.wait(0.1) do
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
