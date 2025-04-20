-- Cấu hình
_G.AutoRauDen = false
_G.AutoNear = true -- Mặc định tắt, bật sau khi spawn Darkbeard
_G.Fast_Delay = 0.15
_G.Speed = 250
FarmMode = "Stand"
Pos = CFrame.new(0, 40, 0)
Type = 0

local player = game.Players.LocalPlayer
local RauDenPos = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531)
local SpawnDarkbeardPos = CFrame.new(3777.04785, 14.6759768, -3499.86719)

-- Luân chuyển vị trí khi farm
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

-- Tween mượt
function TweenToPosition(targetCFrame)
	local char = player.Character or player.CharacterAdded:Wait()
	local root = char:WaitForChild("HumanoidRootPart")
	local humanoid = char:FindFirstChild("Humanoid")
	local distance = (targetCFrame.Position - root.Position).Magnitude

	if humanoid then
		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 50
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end

	local bv = Instance.new("BodyVelocity")
	bv.Velocity = Vector3.new(0, 0, 0)
	bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
	bv.Name = "ChestBodyVel"
	bv.Parent = root

	local tween = game:GetService("TweenService"):Create(root, TweenInfo.new(distance / _G.Speed, Enum.EasingStyle.Linear), { CFrame = targetCFrame })
	tween:Play()
	tween.Completed:Wait()

	if root:FindFirstChild("ChestBodyVel") then root.ChestBodyVel:Destroy() end

	if humanoid then
		humanoid.WalkSpeed = 16
		humanoid.JumpPower = 50
		humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end

-- Tìm mục tiêu trong phạm vi
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

-- Main Auto Darkbeard
task.spawn(function()
	while task.wait() do
		if _G.AutoRauDen then
			local darkbeard = workspace.Enemies:FindFirstChild("Darkbeard")
			if darkbeard and darkbeard:FindFirstChild("Humanoid") and darkbeard.Humanoid.Health > 0 then
				MonFarm = "Darkbeard"
				FarmPos = darkbeard.HumanoidRootPart.CFrame
				bringmob = true
				repeat
					task.wait(_G.Fast_Delay)
					pcall(function()
						AutoHaki()
						EquipTool(SelectWeapon)
						AttackNoCoolDown()  -- Tấn công
						darkbeard.HumanoidRootPart.CanCollide = false
						darkbeard.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
						TweenToPosition(darkbeard.HumanoidRootPart.CFrame * Pos)
					end)
				until not _G.AutoRauDen or darkbeard.Humanoid.Health <= 0 or not darkbeard.Parent
				bringmob = false
			else
				TweenToPosition(RauDenPos)

				local fist = player.Backpack:FindFirstChild("Fist of Darkness") or player.Character:FindFirstChild("Fist of Darkness")
				if fist then
					repeat
						task.wait()
						TweenToPosition(SpawnDarkbeardPos)
						EquipTool("Fist of Darkness")
					until workspace.Enemies:FindFirstChild("Darkbeard")
					
					-- Bỏ Fist sau khi dùng
					UnEquipWeapon("Fist of Darkness")
					
					-- ✅ Bật AutoNear sau khi spawn Darkbeard
					task.wait(0.5)
					_G.AutoNear = true
				end
			end
		end
	end
end)
