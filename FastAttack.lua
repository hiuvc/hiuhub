--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local plr = Players.LocalPlayer
local xw = plr

--// FastAttack throttle
local FastAttackDelay = 0.15
local LastFastAttack = 0
_G.Seriality = true
--// Check alive
local function Ww(e)
	if not e then return false end
	local hum = e:FindFirstChild("Humanoid")
	return hum and hum.Health > 0
end

--// Get targets in range
local function pw(char, range)
	local enemies = Workspace.Enemies:GetChildren()
	local players = Players:GetPlayers()
	local results = {}
	local pos = char:GetPivot().Position

	for _, mob in ipairs(enemies) do
		local hrp = mob:FindFirstChild("HumanoidRootPart")
		if hrp and Ww(mob) then
			if (hrp.Position - pos).Magnitude <= range then
				table.insert(results, mob)
			end
		end
	end

	for _, p in ipairs(players) do
		if p ~= xw and p.Character then
			local hrp = p.Character:FindFirstChild("HumanoidRootPart")
			if hrp and Ww(p.Character) then
				if (hrp.Position - pos).Magnitude <= range then
					table.insert(results, p.Character)
				end
			end
		end
	end

	return results
end

--// Attack without cooldown (server side)
function AttackNoCoolDown()
	local char = plr.Character
	if not char then return end

	local tool
	for _, v in ipairs(char:GetChildren()) do
		if v:IsA("Tool") then
			tool = v
			break
		end
	end
	if not tool then return end

	local targets = pw(char, 60)
	if #targets == 0 then return end

	local modules = ReplicatedStorage:FindFirstChild("Modules")
	if not modules then return end

	local net = modules:FindFirstChild("Net")
	if not net then return end

	local RegisterAttack = net:FindFirstChild("RE/RegisterAttack")
	local RegisterHit = net:FindFirstChild("RE/RegisterHit")
	if not RegisterAttack or not RegisterHit then return end

	local hitList = {}
	local lastPart = nil

	for _, mob in ipairs(targets) do
		if not mob:GetAttribute("IsBoat") then
			local parts = {
				"RightLowerArm","RightUpperArm",
				"LeftLowerArm","LeftUpperArm",
				"RightHand","LeftHand"
			}
			local part = mob:FindFirstChild(parts[math.random(#parts)]) or mob.PrimaryPart
			if part then
				table.insert(hitList, {mob, part})
				lastPart = part
			end
		end
	end
	if not lastPart then return end

	RegisterAttack:FireServer(0)

	local ps = plr:FindFirstChild("PlayerScripts")
	if not ps then return end

	local localscript = ps:FindFirstChildOfClass("LocalScript")
	while not localscript do
		ps.ChildAdded:Wait()
		localscript = ps:FindFirstChildOfClass("LocalScript")
	end

	local SendHits
	if getsenv then
		local ok, env = pcall(getsenv, localscript)
		if ok and env then
			SendHits = env._G.SendHitsToServer
		end
	end

	local ok2, useThread = pcall(function()
		return require(modules.Flags).COMBAT_REMOTE_THREAD or false
	end)

	if ok2 and useThread and SendHits then
		SendHits(lastPart, hitList)
	else
		RegisterHit:FireServer(lastPart, hitList)
	end
end

--// Disable camera shake
local CameraShakerR = require(ReplicatedStorage.Util.CameraShaker)
CameraShakerR:Stop()

--// Detect nearby monster
get_Monster = function()
	for _, mob in pairs(Workspace.Enemies:GetChildren()) do
		local torso = mob:FindFirstChild("UpperTorso") or mob:FindFirstChild("Head")
		if mob:FindFirstChild("HumanoidRootPart", true) and torso then
			if (mob.Head.Position - plr.Character.HumanoidRootPart.Position).Magnitude <= 50 then
				return true, torso.Position
			end
		end
	end

	for _, sb in pairs(Workspace.SeaBeasts:GetChildren()) do
		if sb:FindFirstChild("HumanoidRootPart")
		and sb:FindFirstChild("Health")
		and sb.Health.Value > 0 then
			return true, sb.HumanoidRootPart.Position
		end
	end

	for _, boat in pairs(Workspace.Enemies:GetChildren()) do
		if boat:FindFirstChild("Health")
		and boat.Health.Value > 0
		and boat:FindFirstChild("VehicleSeat") then
			return true, boat.Engine.Position
		end
	end
end

--// Trigger tool connections
Actived = function()
	local tool = plr.Character:FindFirstChildOfClass("Tool")
	if not tool then return end
	for _, c in next, getconnections(tool.Activated) do
		if typeof(c.Function) == "function" then
			getupvalues(c.Function)
		end
	end
end

task.spawn(function()
	RunService.Heartbeat:Connect(function()
		pcall(function()
			if not _G.Seriality then return end

			-- FastAttack throttle
			if tick() - LastFastAttack >= FastAttackDelay then
				LastFastAttack = tick()
				AttackNoCoolDown()
			end

			local tool = plr.Character and plr.Character:FindFirstChildOfClass("Tool")
			if not tool then return end

			if tool.ToolTip == "Blox Fruit" then
				local found = get_Monster()
				if found then
					local remote = tool:FindFirstChild("LeftClickRemote")
					if remote then
						Actived()
						remote:FireServer(Vector3.new(.01, -500, .01), 1, true)
						remote:FireServer(false)
					end
				end
			end
		end)
	end)
end)
