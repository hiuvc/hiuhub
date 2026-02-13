loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/Fastattack.lua"))()
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        l_Remotes_0.CommF_:InvokeServer("SetTeam", getgenv().team or "Marines")
        task.wait(5)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end
local HopServerModule = (loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/HopServerModule.lua")))()
do
  ply = game.Players;
  plr = ply.LocalPlayer;
  char = plr.Character or plr.CharacterAdded:Wait()
  Root = char.HumanoidRootPart;
  replicated = game:GetService("ReplicatedStorage");
  Workspace = game:GetService("Workspace")
  CommF = game:GetService("ReplicatedStorage").Remotes.CommF_
  Lv = game.Players.LocalPlayer.Data.Level.Value;
  TeleportService = game:GetService("TeleportService");
  TW = game:GetService("TweenService");
  Lighting = game:GetService("Lighting");
  Enemies = workspace.Enemies;
  vim1 = game:GetService("VirtualInputManager");
  vim2 = game:GetService("VirtualUser");
  TeamSelf = plr.Team;
  RunSer = game:GetService("RunService");
  Stats = game:GetService("Stats");
  Energy = char.Energy.Value;
  Boss = {};
  BringConnections = {};
  MaterialList = {};
  NPCList = {};
  shouldTween = false;
  SoulGuitar = false;
  KenTest = true;
  debug = false;
  Brazier1 = false;
  Brazier2 = false;
  Brazier3 = false;
  Sec = 0.1;
  ClickState = 0;
  Num_self = 25;
end;
if game.PlaceId == 2753915549 or game.PlaceId == 85211729168715 then
  World1 = true;
elseif game.PlaceId == 4442272183 or game.PlaceId == 79091703265657 then
  World2 = true;
elseif game.PlaceId == 7449423635 or game.PlaceId == 100117331123089 then
  World3 = true;
end;
Sea = World1 or World2 or World3 or print("PlaceId: "..game.PlaceId)
Marines = function()
    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines");
  end;
Pirates = function()
    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates");
  end;
if World1 then
  Boss = {
      "The Gorilla King",
      "Bobby",
      "The Saw",
      "Yeti",
      "Mob Leader",
      "Vice Admiral",
      "Saber Expert",
      "Warden",
      "Chief Warden",
      "Swan",
      "Magma Admiral",
      "Fishman Lord",
      "Wysper",
      "Thunder God",
      "Cyborg",
      "Ice Admiral",
      "Greybeard",
    };
elseif World2 then
  Boss = {
      "Diamond",
      "Jeremy",
      "Fajita",
      "Don Swan",
      "Smoke Admiral",
      "Awakened Ice Admiral",
      "Tide Keeper",
      "Darkbeard",
      "Cursed Captain",
      "Order",
    };
elseif World3 then
  Boss = {
      "Stone",
      "Hydra Leader",
      "Kilo Admiral",
      "Captain Elephant",
      "Beautiful Pirate",
      "Cake Queen",
      "Longma",
      "Soul Reaper",
    };
end;
if World1 then
  MaterialList = {
      "Leather + Scrap Metal",
      "Angel Wings",
      "Magma Ore",
      "Fish Tail",
    };
elseif World2 then
  MaterialList = {
      "Leather + Scrap Metal",
      "Radioactive Material",
      "Ectoplasm",
      "Mystic Droplet",
      "Magma Ore",
      "Vampire Fang",
    };
elseif World3 then
  MaterialList = {
      "Scrap Metal",
      "Demonic Wisp",
      "Conjured Cocoa",
      "Dragon Scale",
      "Gunpowder",
      "Fish Tail",
      "Mini Tusk",
    };
end;
local A = {
    "Flame",
    "Ice",
    "Quake",
    "Light",
    "Dark",
    "String",
    "Rumble",
    "Magma",
    "Human: Buddha",
    "Sand",
    "Bird: Phoenix",
    "Dough",
  };
local u = {
    "Snow Lurker",
    "Arctic Warrior",
    "Hidden Key",
    "Awakened Ice Admiral",
  };
local Z = {
    Mob = "Mythological Pirate",
    Mob2 = "Cursed Skeleton",
    "Hell\'s Messenger",
    Mob3 = "Cursed Skeleton",
    "Heaven\'s Guardian",
  };
local X = {
    "Part",
    "SpawnLocation",
    "Terrain",
    "WedgePart",
    "MeshPart",
  };
local C = { "Swan Pirate", "Jeremy" };
local v = { "Forest Pirate", "Captain Elephant" };
local o = { "Fajita", "Jeremy", "Diamond" };
local w = {
    "Beast Hunter",
    "Lantern",
    "Guardian",
    "Grand Brigade",
    "Dinghy",
    "Sloop",
    "The Sentinel",
  };
local l = { "Cookie Crafter" };
local G = { "Reborn Skeleton" };
local a = {
    ["Pirate Millionaire"] = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625),
    ["Pistol Billionaire"] = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625),
    ["Dragon Crew Warrior"] = CFrame.new(7021.5043945312, 55.762702941895, -730.12908935547),
    ["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
    ["Female Islander"] = CFrame.new(4692.7939453125, 797.97668457031, 858.84802246094),
    ["Venomous Assailant"] = CFrame.new(4902, 670, 39),
    ["Marine Commodore"] = CFrame.new(2401, 123, -7589),
    ["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
    ["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
    ["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
    ["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
    ["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
    ["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
    ["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
    ["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
    ["Living Zombie"] = CFrame.new(-10227, 421, 6161),
    ["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
    ["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
    ["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
    ["Peanut President"] = CFrame.new(-2215, 159, -10474),
    ["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
    ["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
    ["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
    ["Cake Guard"] = CFrame.new(-2024, 38, -12026),
    ["Baking Staff"] = CFrame.new(-1932, 38, -12848),
    ["Head Baker"] = CFrame.new(-1932, 38, -12848),
    ["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
    ["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
    ["Sweet Thief"] = CFrame.new(116, 36, -12478),
    ["Candy Rebel"] = CFrame.new(47, 61, -12889),
    Ghost = CFrame.new(5251, 5, 1111),
  };
EquipWeapon = function(e)
    if not e then
      return;
    end;
    if plr.Backpack:FindFirstChild(e) then
      plr.Character.Humanoid:EquipTool(plr.Backpack:FindFirstChild(e));
    end;
  end;
weaponSc = function(e)
    for A, u in pairs(plr.Backpack:GetChildren()) do
      if u:IsA("Tool") then
        if u.ToolTip == e then
          EquipWeapon(u.Name);
        end;
      end;
    end;
  end;

local q = workspace:FindFirstChild("Rocks");
if q then
  q:Destroy();
end;


local O = {};
O.__index = O;
O.Alive = function(v)
    return v and v.Parent and not v:FindFirstChild("VehicleSeat") and v:FindFirstChild("Humanoid") and v.Humanoid.Health > 0 and v:FindFirstChild("HumanoidRootPart")
  end;
O.Pos = function(e, A)
    return (Root.Position - mode.Position).Magnitude <= A;
  end;
O.Dist = function(e, A)
    return (Root.Position - (e:FindFirstChild("HumanoidRootPart")).Position).Magnitude <= A;
  end;
O.DistH = function(e, A)
    return (Root.Position - (e:FindFirstChild("HumanoidRootPart")).Position).Magnitude > A;
  end;
local function GetMobBaseName(name)
    return string.match(name, "^(.-)%s*%[") or name
end

local EnemyCache = {}
local BroughtTags = {} -- Track tags separately for faster cleanup

local function IndexEnemies()
    table.clear(EnemyCache)
    for _, e in ipairs(workspace.Enemies:GetChildren()) do
        local base = GetMobBaseName(e.Name)
        EnemyCache[base] = EnemyCache[base] or {}
        table.insert(EnemyCache[base], e)
    end
end

IndexEnemies()

workspace.Enemies.ChildAdded:Connect(function(e)
    local base = GetMobBaseName(e.Name)
    EnemyCache[base] = EnemyCache[base] or {}
    table.insert(EnemyCache[base], e)
end)

workspace.Enemies.ChildRemoved:Connect(function(e)
    local base = GetMobBaseName(e.Name)
    local list = EnemyCache[base]
    if not list then return end
    
    -- Use table.find for faster removal
    local index = table.find(list, e)
    if index then
        table.remove(list, index)
    end
    
    -- Cleanup empty cache entries
    if #list == 0 then
        EnemyCache[base] = nil
    end
end)

local MAX_BRING = 2

BringEnemy = function(Target, Distance)
    if not _B or not Target then return end
    
    local Char = plr.Character
    local HRP = Char and Char:FindFirstChild("HumanoidRootPart")
    if not HRP then return end
    
    local rootTarget = Target:FindFirstChild("HumanoidRootPart")
    if not rootTarget then return end
    
    -- Early exit if target is too far
    local distanceToTarget = (rootTarget.Position - HRP.Position).Magnitude
    if distanceToTarget > 25 then
        return
    end
    
    Distance = Distance or 350
    local PosMon = rootTarget.Position
    local TargetBase = GetMobBaseName(Target.Name)
    
    -- Set simulation radius once globally, not every call
    if plr.SimulationRadius ~= math.huge then
        plr.SimulationRadius = math.huge
    end
    
    local list = EnemyCache[TargetBase]
    if not list then return end
    
    local brought = 0
    local distanceSquared = Distance * Distance -- Use squared distance to avoid sqrt
    
    for i = #list, 1, -1 do
        if brought >= MAX_BRING then break end
        
        local Enemy = list[i]
        if not Enemy or not Enemy.Parent then
            table.remove(list, i)
            continue
        end
        
        -- Skip if already brought
        if Enemy:GetAttribute("IsBrought") then
            continue
        end
        
        local root = Enemy:FindFirstChild("HumanoidRootPart")
        local hum = Enemy:FindFirstChildOfClass("Humanoid")
        
        if not root or not hum or hum.Health <= 0 then
            continue
        end
        
        -- Use squared distance comparison (faster)
        local deltaPos = root.Position - PosMon
        if deltaPos.Magnitude <= Distance then -- Keep original for accuracy, or use: deltaPos:Dot(deltaPos) <= distanceSquared
            
            -- Use Attribute instead of Instance (faster, less memory)
            Enemy:SetAttribute("IsBrought", true)
            brought += 1
            
            -- Physics state
            if hum:GetState() ~= Enum.HumanoidStateType.Physics then
                hum:ChangeState(Enum.HumanoidStateType.Physics)
            end
            
            -- Destroy animator once
            local animator = hum:FindFirstChild("Animator")
            if animator then
                animator:Destroy()
            end
            
            root.CanCollide = false
            
            -- Reuse or create BodyPosition
            local bp = root:FindFirstChild("EnemyFlyPosition")
            if not bp then
                bp = Instance.new("BodyPosition")
                bp.Name = "EnemyFlyPosition"
                bp.MaxForce = Vector3.new(1e9, 1e9, 1e9)
                bp.P = 3500
                bp.D = 150
                bp.Parent = root
            end
            bp.Position = PosMon
            
            -- Cleanup on death
            hum.Died:Once(function()
                Enemy:SetAttribute("IsBrought", nil)
            end)
        end
    end
end
function Convert_CFrame(x)
    if not x then return nil end

    local t = typeof(x)

    if t == "Vector3" then
        return CFrame.new(x)

    elseif t == "CFrame" then
        return x

    elseif t == "Instance" then
        if x:IsA("Model") then
            return x:GetPivot()
        elseif x:IsA("BasePart") then
            return x.CFrame
        end
    end

    return nil
end


function GetDistance(POS_1, POS_2, NO_Y)
    if not POS_1 then return math.huge end

    local char = plr.Character
    if not char then return math.huge end

    local hum = char:FindFirstChild("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")

    if not hum or hum.Health <= 0 or not root then
        return math.huge
    end

    local cf1 = Convert_CFrame(POS_1)
    if not cf1 then return math.huge end

    local cf2 = Convert_CFrame(POS_2 or root)
    if not cf2 then return math.huge end

    local v1 = cf1.Position
    local v2 = cf2.Position

    if NO_Y then
        v1 = Vector3.new(v1.X, 0, v1.Z)
        v2 = Vector3.new(v2.X, 0, v2.Z)
    end

    return (v1 - v2).Magnitude
end


function CheckCakePrinceSkill()
    for _,v in next, workspace._WorldOrigin:GetChildren() do
        if v.Name == "Ring" or v.Name == "Fist" then
            if GetDistance(v) <= 400 then
                return true
            end
        end
    end
    return false
end

O.Kill = function(e)
    if not e or not e.Parent then return end

    local humanoidRootPart = e:FindFirstChild("HumanoidRootPart")
    local humanoid = e:FindFirstChildOfClass("Humanoid")

    if not humanoidRootPart or not humanoid or humanoid.Health <= 0 then
        return
    end

    -- lock vị trí
    if not e:GetAttribute("Locked") then
        e:SetAttribute("Locked", humanoidRootPart.Position)
    end

    PosMon = e:GetAttribute("Locked")

    EquipWeapon(_G.SelectWeapon)

    local char = game.Players.LocalPlayer.Character
    if not char then return end

    local tool = char:FindFirstChildOfClass("Tool")
    if not tool then return end

    local toolTip = tool.ToolTip or ""
    local height = (toolTip == "Blox Fruit") and 10 or 25
    local pos = humanoidRootPart.Position


    -- né skill Cake Prince
    if CheckCakePrinceSkill() then
        _tp(humanoidRootPart.CFrame * CFrame.new(0,300,0))
        return
    end

    -- TP chính
    _tp(
        CFrame.new(pos.X, pos.Y + height, pos.Z)
        * CFrame.Angles(0, math.rad(toolTip == "Blox Fruit" and 90 or 180), 0)
    )


    -- random vị trí anti detection
    if RandomCFrame then
        task.wait(0.2)

        local offsets = {
            Vector3.new(0,20,20),
            Vector3.new(20,20,0),
            Vector3.new(0,20,-20),
            Vector3.new(-20,20,0)
        }

        for _, offset in ipairs(offsets) do
            if not e.Parent or humanoid.Health <= 0 then break end

            local newPos = humanoidRootPart.Position + offset

            _tp(
                CFrame.new(newPos)
                * CFrame.Angles(0, math.rad(180), 0)
            )

            task.wait(0.15)
        end
    end
end

O.KillSea = function(e, A)
    if e and A then
      if not e:GetAttribute("Locked") then
        e:SetAttribute("Locked", e.HumanoidRootPart.CFrame);
      end;
      PosMon = (e:GetAttribute("Locked")).Position;
      EquipWeapon(_G.SelectWeapon);
      local A = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool");
      local u = A.ToolTip;
      if u == "Blox Fruit" then
        _tp((e.HumanoidRootPart.CFrame * CFrame.new(0, 10, 0)) * CFrame.Angles(0, math.rad(90), 0));
      else
        notween(e.HumanoidRootPart.CFrame * CFrame.new(0, 50, 8));
        wait(.85);
        notween(e.HumanoidRootPart.CFrame * CFrame.new(0, 400, 0));
        wait(1);
      end;
    end;
  end;
O.Sword = function(e, A)
    if e and A then
      if not e:GetAttribute("Locked") then
        e:SetAttribute("Locked", e.HumanoidRootPart.CFrame);
      end;
      PosMon = (e:GetAttribute("Locked")).Position;
      weaponSc("Sword");
      _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
      if RandomCFrame then
        wait(.1);
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
        wait(.1);
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(25, 30, 0));
        wait(.1);
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
        wait(.1);
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 30, 25));
        wait(.1);
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(-25, 30, 0));
      end;
    end;
  end;
O.Mas = function(e, A)
    if e and A then
      if not e:GetAttribute("Locked") then
        e:SetAttribute("Locked", e.HumanoidRootPart.CFrame);
      end;
      PosMon = (e:GetAttribute("Locked")).Position;
      if e.Humanoid.Health <= HealthM then
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 20, 0));
        Useskills("Blox Fruit", "Z");
        Useskills("Blox Fruit", "X");
        Useskills("Blox Fruit", "C");
      else
        weaponSc("Melee");
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
      end;
    end;
  end;
O.Masgun = function(e, A)
    if e and A then
      if not e:GetAttribute("Locked") then
        e:SetAttribute("Locked", e.HumanoidRootPart.CFrame);
      end;
      PosMon = (e:GetAttribute("Locked")).Position;
      if e.Humanoid.Health <= HealthM then
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 35, 8));
        Useskills("Gun", "Z");
        Useskills("Gun", "X");
      else
        weaponSc("Melee");
        _tp(e.HumanoidRootPart.CFrame * CFrame.new(0, 30, 0));
      end;
    end;
  end;
statsSetings = function(e, A)
    if e == "Melee" then
      if plr.Data.Points.Value ~= 0 then
        replicated.Remotes.CommF_:InvokeServer("AddPoint", "Melee", A);
      end;
    elseif e == "Defense" then
      if plr.Data.Points.Value ~= 0 then
        replicated.Remotes.CommF_:InvokeServer("AddPoint", "Defense", A);
      end;
    elseif e == "Sword" then
      if plr.Data.Points.Value ~= 0 then
        replicated.Remotes.CommF_:InvokeServer("AddPoint", "Sword", A);
      end;
    elseif e == "Gun" then
      if plr.Data.Points.Value ~= 0 then
        replicated.Remotes.CommF_:InvokeServer("AddPoint", "Gun", A);
      end;
    elseif e == "Devil" then
      if plr.Data.Points.Value ~= 0 then
        replicated.Remotes.CommF_:InvokeServer("AddPoint", "Demon Fruit", A);
      end;
    end;
  end;
Useskills = function(weapon, skill)
  if weapon == "Melee" then
    weaponSc("Melee")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);
    end
  elseif weapon == "Sword" then
    weaponSc("Sword")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  elseif weapon == "Blox Fruit" then
    weaponSc("Blox Fruit")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    elseif skill == "C" then
      vim1:SendKeyEvent(true, "C", false, game);
      vim1:SendKeyEvent(false, "C", false, game);        
    elseif skill == "V" then
      vim1:SendKeyEvent(true, "V", false, game);
      vim1:SendKeyEvent(false, "V", false, game);
    end
  elseif weapon == "Gun" then
    weaponSc("Gun")
    if skill == "Z" then
      vim1:SendKeyEvent(true, "Z", false, game);
      vim1:SendKeyEvent(false, "Z", false, game);
    elseif skill == "X" then
      vim1:SendKeyEvent(true, "X", false, game);
      vim1:SendKeyEvent(false, "X", false, game);
    end
  end
  if weapon == "nil" and skill == "Y" then
    vim1:SendKeyEvent(true, "Y", false, game);
    vim1:SendKeyEvent(false, "Y", false, game);
  end
end

local H = getrawmetatable(game);
local f = H.__namecall;
setreadonly(H, false);
H.__namecall = newcclosure(function(...)
    local e = getnamecallmethod();
    local A = { ... };
    if tostring(e) == "FireServer" then
      if tostring(A[1]) == "RemoteEvent" then
        if tostring(A[2]) ~= "true" and tostring(A[2]) ~= "false" then
          if _G.FarmMastery_G and not SoulGuitar or _G.FarmMastery_Dev or _G.FarmBlazeEM or _G.Prehis_Skills or _G.SeaBeast1 or _G.FishBoat or _G.PGB or _G.Leviathan1 or _G.Complete_Trials or _G.AimMethod and ABmethod == "AimBots Skill" or _G.AimMethod and ABmethod == "Auto Aimbots" then
            A[2] = MousePos;
            return f(unpack(A));
          end;
        end;
      end;
    end;
    return f(...);
  end);
GetConnectionEnemies = function(e)
    for A, u in pairs(replicated:GetChildren()) do
      if u:IsA("Model") and ((typeof(e) == "table" and table.find(e, u.Name) or u.Name == e) and (u:FindFirstChild("Humanoid") and u.Humanoid.Health > 0)) then
        return u;
      end;
    end;
    for A, u in next, game.Workspace.Enemies:GetChildren() do
      if u:IsA("Model") and ((typeof(e) == "table" and table.find(e, u.Name) or u.Name == e) and (u:FindFirstChild("Humanoid") and u.Humanoid.Health > 0)) then
        return u;
      end;
    end;
  end;
LowCpu = function()
    local e = true;
    local A = game;
    local u = A.Workspace;
    local Z = A.Lighting;
    local X = u.Terrain;
    X.WaterWaveSize = 0;
    X.WaterWaveSpeed = 0;
    X.WaterReflectance = 0;
    X.WaterTransparency = 0;
    Z.GlobalShadows = false;
    Z.FogEnd = 9000000000.0;
    Z.Brightness = 0;
    (settings()).Rendering.QualityLevel = "Level01";
    for A, u in pairs(A:GetDescendants()) do
      if u:IsA("Part") or u:IsA("Union") or u:IsA("CornerWedgePart") or u:IsA("TrussPart") then
        u.Material = "Plastic";
        u.Reflectance = 0;
      elseif u:IsA("Decal") or u:IsA("Texture") and e then
        u.Transparency = 1;
      elseif u:IsA("ParticleEmitter") or u:IsA("Trail") then
        u.Lifetime = NumberRange.new(0);
      elseif u:IsA("Explosion") then
        u.BlastPressure = 1;
        u.BlastRadius = 1;
      elseif u:IsA("Fire") or u:IsA("SpotLight") or u:IsA("Smoke") or u:IsA("Sparkles") then
        u.Enabled = false;
      elseif u:IsA("MeshPart") then
        u.Material = "Plastic";
        u.Reflectance = 0;
        u.TextureID = 10385902758728957;
      end;
    end;
    for e, A in pairs(Z:GetChildren()) do
      if A:IsA("BlurEffect") or A:IsA("SunRaysEffect") or A:IsA("ColorCorrectionEffect") or A:IsA("BloomEffect") or A:IsA("DepthOfFieldEffect") then
        A.Enabled = false;
      end;
    end;
  end;
CheckF = function()
    if GetBP("Dragon-Dragon") or GetBP("Gas-Gas") or GetBP("Yeti-Yeti") or GetBP("Kitsune-Kitsune") or GetBP("T-Rex-T-Rex") then
      return true;
    end;
  end;
CheckBoat = function()
    for e, A in pairs(workspace.Boats:GetChildren()) do
      if tostring(A.Owner.Value) == tostring(plr.Name) then
        return A;
      end;
    end;
    return false;
  end;
CheckEnemiesBoat = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if A.Name == "FishBoat" and (A:FindFirstChild("Health")).Value > 0 then
        return true;
      end;
    end;
    return false;
  end;
CheckPirateGrandBrigade = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if (A.Name == "PirateGrandBrigade" or A.Name == "PirateBrigade") and (A:FindFirstChild("Health")).Value > 0 then
        return true;
      end;
    end;
    return false;
  end;
CheckShark = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if A.Name == "Shark" and O.Alive(A) then
        return true;
      end;
    end;
    return false;
  end;
CheckTerrorShark = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if A.Name == "Terrorshark" and O.Alive(A) then
        return true;
      end;
    end;
    return false;
  end;
CheckPiranha = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if A.Name == "Piranha" and O.Alive(A) then
        return true;
      end;
    end;
    return false;
  end;
CheckFishCrew = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if (A.Name == "Fish Crew Member" or A.Name == "Haunted Crew Member") and O.Alive(A) then
        return true;
      end;
    end;
    return false;
  end;
CheckHauntedCrew = function()
    for e, A in pairs(workspace.Enemies:GetChildren()) do
      if A.Name == "Haunted Crew Member" and O.Alive(A) then
        return true;
      end;
    end;
    return false;
  end;
CheckSeaBeast = function()
    if workspace.SeaBeasts:FindFirstChild("SeaBeast1") then
      return true;
    end;
    return false;
  end;
CheckLeviathan = function()
    if workspace.SeaBeasts:FindFirstChild("Leviathan") then
      return true;
    end;
    return false;
  end;
UpdStFruit = function()
    for e, A in next, plr.Backpack:GetChildren() do
      StoreFruit = A:FindFirstChild("EatRemote", true);
      if StoreFruit then
        replicated.Remotes.CommF_:InvokeServer("StoreFruit", StoreFruit.Parent:GetAttribute("OriginalName"), plr.Backpack:FindFirstChild(A.Name));
      end;
    end;
  end;
collectFruits = function(e)
    if e then
      local e = plr.Character;
      for A, u in pairs(workspace:GetChildren()) do
        if string.find(u.Name, "Fruit") then
          u.Handle.CFrame = e.HumanoidRootPart.CFrame;
        end;
      end;
    end;
  end;
Getmoon = function()
    if World1 then
      return Lighting.FantasySky.MoonTextureId;
    elseif World2 then
      return Lighting.FantasySky.MoonTextureId;
    elseif World3 then
      return Lighting.Sky.MoonTextureId;
    end;
  end;
DropFruits = function()
    for e, A in next, plr.Backpack:GetChildren() do
      if string.find(A.Name, "Fruit") then
        EquipWeapon(A.Name);
        wait(.1);
        if plr.PlayerGui.Main.Dialogue.Visible == true then
          plr.PlayerGui.Main.Dialogue.Visible = false;
        end;
        EquipWeapon(A.Name);
        (plr.Character:FindFirstChild(A.Name)).EatRemote:InvokeServer("Drop");
      end;
    end;
    for e, A in pairs(plr.Character:GetChildren()) do
      if string.find(A.Name, "Fruit") then
        EquipWeapon(A.Name);
        wait(.1);
        if plr.PlayerGui.Main.Dialogue.Visible == true then
          plr.PlayerGui.Main.Dialogue.Visible = false;
        end;
        EquipWeapon(A.Name);
        (plr.Character:FindFirstChild(A.Name)).EatRemote:InvokeServer("Drop");
      end;
    end;
  end;
GetBP = function(e)
    return plr.Backpack:FindFirstChild(e) or plr.Character:FindFirstChild(e);
  end;
GetIn = function(e)
    for A, u in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
      if type(u) == "table" then
        if u.Name == e or plr.Character:FindFirstChild(e) or plr.Backpack:FindFirstChild(e) then
          return true;
        end;
      end;
    end;
    return false;
  end;
GetM = function(e)
    for A, u in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
      if type(u) == "table" then
        if u.Type == "Material" then
          if u.Name == e then
            return u.Count;
          end;
        end;
      end;
    end;
    return 0;
  end;
GetWP = function(e)
    for A, u in pairs(replicated.Remotes.CommF_:InvokeServer("getInventory")) do
      if type(u) == "table" then
        if u.Type == "Sword" then
          if u.Name == e or plr.Character:FindFirstChild(e) or plr.Backpack:FindFirstChild(e) then
            return true;
          end;
        end;
      end;
    end;
    return false;
  end;
getInfinity_Ability = function(e, A)
    if not Root then
      return;
    end;
    if e == "Soru" and A then
      for e, u in next, getgc() do
        if plr.Character.Soru then
          if typeof(u) == "function" and (getfenv(u)).script == plr.Character.Soru then
            for e, u in next, getupvalues(u) do
              if typeof(u) == "table" then
                repeat
                  wait(Sec);
                  u.LastUse = 0;
                until not A or plr.Character.Humanoid.Health <= 0;
              end;
            end;
          end;
        end;
      end;
    elseif e == "Energy" and A then
      plr.Character.Energy.Changed:connect(function()
        if A then
          plr.Character.Energy.Value = Energy;
        end;
      end);
    elseif e == "Observation" and A then
      local e = plr.VisionRadius;
      e.Value = math.huge;
    end;
  end;
Hop = function()
    HopServerModule:Teleport()
  end;
local plr = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- // 1. TẠO PART ĐIỀU KHIỂN //
local c = Instance.new("Part", workspace)
c.Size = Vector3.new(1, 1, 1)
c.Name = "Rip_Indra"
c.Anchored = true
c.CanCollide = false
c.CanTouch = false
c.Transparency = 1

-- Xóa part cũ
local oldPart = workspace:FindFirstChild(c.Name)
if oldPart and oldPart ~= c then
    oldPart:Destroy()
end

task.spawn(function()
    while task.wait() do
        if c and c.Parent == workspace then
            getgenv().OnFarm = shouldTween
        else
            getgenv().OnFarm = false
        end
    end
end)

task.spawn(function()
    repeat task.wait() until plr.Character and plr.Character.PrimaryPart
    c.CFrame = plr.Character.PrimaryPart.CFrame

    while task.wait() do
        pcall(function()
            local char = plr.Character
            if not char or not char.PrimaryPart then return end

            if getgenv().OnFarm then
                if c and c.Parent == workspace then
                    local root = char.PrimaryPart
                    -- Nếu nhân vật bị lệch quá xa (>200) do lag, kéo Part về lại nhân vật
                    if (root.Position - c.Position).Magnitude > 200 then
                        c.CFrame = root.CFrame
                    else
                        -- Bình thường: Kéo nhân vật theo Part
                        root.CFrame = c.CFrame
                    end
                end
                
                -- Tắt va chạm để không bị kẹt tường
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = false end
                end
            else
                -- Bật lại va chạm khi dừng farm
                for _, v in pairs(char:GetChildren()) do
                    if v:IsA("BasePart") then v.CanCollide = true end
                end
            end
        end)
    end
end)

-- // 4. HÀM TÌM CỔNG TELE (SEA 1, 2, 3) //
local function CheckNearestTeleporter(targetCF)
    local placeId = game.PlaceId
    local targetPos = targetCF.Position
    local teleList = {}

    if placeId == 2753915549 then -- Sea 1
        teleList = {
            Sky3 = Vector3.new(-7894, 5547, -380),
            Sky3Exit = Vector3.new(-4607, 874, -1667),
            UnderWater = Vector3.new(61163, 11, 1819),
            UnderwaterExit = Vector3.new(4050, -1, -1814)
        }
    elseif placeId == 4442272183 then -- Sea 2
        teleList = {
            ["Swan Mansion"] = Vector3.new(-390, 332, 673),
            ["Swan Room"] = Vector3.new(2285, 15, 905),
            ["Cursed Ship"] = Vector3.new(923, 126, 32852),
            ["Zombie Island"] = Vector3.new(-6509, 83, -133)
        }
    elseif placeId == 7449423635 then -- Sea 3
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

    local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local distToTarget = (targetPos - hrp.Position).Magnitude
        if minDist < 2000 and distToTarget > 3000 then
            return nearest
        end
    end
    return nil
end

local function RequestEntrance(pos)
    pcall(function()
        game.ReplicatedStorage.Remotes.CommF_:InvokeServer("requestEntrance", pos)
    end)
end

-- // 5. HÀM _tp ĐÃ FIX LỖI //
_tp = function(target)
    local char = plr.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return end
    
    local targetCF = target
    if typeof(target) == "Vector3" then
        targetCF = CFrame.new(target)
    end

    c.CFrame = char.HumanoidRootPart.CFrame
    task.wait() 

    -- BƯỚC 1: Thử tìm cổng dịch chuyển
    local bestPortal = CheckNearestTeleporter(targetCF)
    if bestPortal then
        RequestEntrance(bestPortal)
        task.wait(0.5) -- Chờ server load map
        -- Sau khi qua cổng, CẬP NHẬT LẠI vị trí Part c theo nhân vật ở đảo mới
        if char.PrimaryPart then
            c.CFrame = char.PrimaryPart.CFrame
        end
    end

    -- BƯỚC 2: Bay thường (Tween) đến đích (Dù có dùng cổng hay không vẫn chạy đoạn này để đi nốt quãng đường còn lại)
    local currentPos = c.Position
    local finalPos = targetCF.Position
    local distance = (finalPos - currentPos).Magnitude

    -- Nếu khoảng cách quá gần (< 10 studs) thì không cần tween nữa
    if distance < 10 then 
        c.CFrame = targetCF
        return 
    end
    local speed = 350
    if distance < 250 then speed = 350 end 

    local tweenInfo = TweenInfo.new(distance / speed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(c, tweenInfo, { CFrame = targetCF })

    tween:Play()

    -- Sử dụng Heartbeat thay vì Loop để mượt hơn và tránh treo script
    local connection
    connection = RunService.Heartbeat:Connect(function()
        if tween.PlaybackState ~= Enum.PlaybackState.Playing then
            connection:Disconnect()
            return
        end
        
        -- Nếu tắt tool farm hoặc Part bị mất -> Hủy tween
        if not shouldTween or not c or c.Parent ~= workspace then
            tween:Cancel()
            connection:Disconnect()
        end
    end)
end

TeleportToTarget = function(e)
    if (e.Position - plr.Character.HumanoidRootPart.Position).Magnitude > 1000 then
      _tp(e);
    else
      _tp(e);
    end;
  end;
notween = function(e)
    plr.Character.HumanoidRootPart.CFrame = e;
  end;

spawn(function()
  while task.wait() do
    pcall(function()
      if _G.StartFram then
        shouldTween = true;
        if not plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
          local e = Instance.new("BodyVelocity");
          e.Name = "BodyClip";
          e.Parent = plr.Character.HumanoidRootPart;
          e.MaxForce = Vector3.new(100000, 100000, 100000);
          e.Velocity = Vector3.new(0, 0, 0);
        end;
        if not plr.Character:FindFirstChild("highlight") then
          local e = Instance.new("Highlight");
          e.Name = "highlight";
          e.Enabled = true;
          e.FillColor = Color3.fromRGB(2, 197, 60);
          e.OutlineColor = Color3.fromRGB(255, 255, 255);
          e.FillTransparency = .5;
          e.OutlineTransparency = .2;
          e.Parent = plr.Character;
        end;
        for e, A in pairs(plr.Character:GetDescendants()) do
          if A:IsA("BasePart") then
            A.CanCollide = false;
          end;
        end;
      else
        shouldTween = false;
        if plr.Character.HumanoidRootPart:FindFirstChild("BodyClip") then
          (plr.Character.HumanoidRootPart:FindFirstChild("BodyClip")):Destroy();
        end;
        if plr.Character:FindFirstChild("highlight") then
          (plr.Character:FindFirstChild("highlight")):Destroy();
        end;
      end;
    end);
  end;
end);

QuestB = function()
    if World1 then
      if _G.FindBoss == "The Gorilla King" then
        bMon = "The Gorilla King";
        Qname = "JungleQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(-1601.6553955078, 36.85213470459, 153.38809204102);
        PosB = CFrame.new(-1088.75977, 8.13463783, -488.559906, -0.707134247, 0, .707079291, 0, 1, 0, -0.707079291, 0, -0.707134247);
      elseif _G.FindBoss == "Bobby" then
        bMon = "Bobby";
        Qname = "BuggyQuest1";
        Qdata = 3;
        PosQBoss = CFrame.new(-1140.1761474609, 4.752049446106, 3827.4057617188);
        PosB = CFrame.new(-1087.3760986328, 46.949409484863, 4040.1462402344);
      elseif _G.FindBoss == "The Saw" then
        bMon = "The Saw";
        PosB = CFrame.new(-784.89715576172, 72.427383422852, 1603.5822753906);
      elseif _G.FindBoss == "Yeti" then
        bMon = "Yeti";
        Qname = "SnowQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(1386.8073730469, 87.272789001465, -1298.3576660156);
        PosB = CFrame.new(1218.7956542969, 138.01184082031, -1488.0262451172);
      elseif _G.FindBoss == "Mob Leader" then
        bMon = "Mob Leader";
        PosB = CFrame.new(-2844.7307128906, 7.4180502891541, 5356.6723632813);
      elseif _G.FindBoss == "Vice Admiral" then
        bMon = "Vice Admiral";
        Qname = "MarineQuest2";
        Qdata = 2;
        PosQBoss = CFrame.new(-5036.2465820313, 28.677835464478, 4324.56640625);
        PosB = CFrame.new(-5006.5454101563, 88.032081604004, 4353.162109375);
      elseif _G.FindBoss == "Saber Expert" then
        bMon = "Saber Expert";
        PosB = CFrame.new(-1458.89502, 29.8870335, -50.633564);
      elseif _G.FindBoss == "Warden" then
        bMon = "Warden";
        Qname = "ImpelQuest";
        Qdata = 1;
        PosB = CFrame.new(5278.04932, 2.15167475, 944.101929, .220546961, -4.49946401e-06, .975376427, -1.95412576e-05, 1, 9.03162072e-06, -0.975376427, -2.10519756e-05, .220546961);
        PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
      elseif _G.FindBoss == "Chief Warden" then
        bMon = "Chief Warden";
        Qname = "ImpelQuest";
        Qdata = 2;
        PosB = CFrame.new(5206.92578, .997753382, 814.976746, .342041343, -0.00062915677, .939684749, .00191645394, .999998152, -2.80422337e-05, -0.939682961, .00181045406, .342041939);
        PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
      elseif _G.FindBoss == "Swan" then
        bMon = "Swan";
        Qname = "ImpelQuest";
        Qdata = 3;
        PosB = CFrame.new(5325.09619, 7.03906584, 719.570679, -0.309060812, 0, .951042235, 0, 1, 0, -0.951042235, 0, -0.309060812);
        PosQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, -0.731384635, 0, .681965172, 0, 1, 0, -0.681965172, 0, -0.731384635);
      elseif _G.FindBoss == "Magma Admiral" then
        bMon = "Magma Admiral";
        Qname = "MagmaQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(-5314.6220703125, 12.262420654297, 8517.279296875);
        PosB = CFrame.new(-5765.8969726563, 82.92064666748, 8718.3046875);
      elseif _G.FindBoss == "Fishman Lord" then
        bMon = "Fishman Lord";
        Qname = "FishmanQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
        PosB = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984);
      elseif _G.FindBoss == "Wysper" then
        bMon = "Wysper";
        Qname = "SkyExp1Quest";
        Qdata = 3;
        PosQBoss = CFrame.new(-7861.947265625, 5545.517578125, -379.85974121094);
        PosB = CFrame.new(-7866.1333007813, 5576.4311523438, -546.74816894531);
      elseif _G.FindBoss == "Thunder God" then
        bMon = "Thunder God";
        Qname = "SkyExp2Quest";
        Qdata = 3;
        PosQBoss = CFrame.new(-7903.3828125, 5635.9897460938, -1410.923828125);
        PosB = CFrame.new(-7994.984375, 5761.025390625, -2088.6479492188);
      elseif _G.FindBoss == "Cyborg" then
        bMon = "Cyborg";
        Qname = "FountainQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875);
        PosB = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813);
      elseif _G.FindBoss == "Ice Admiral" then
        bMon = "Ice Admiral";
        Qdata = nil;
        PosQBoss = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, .81913656, 0, -0.573599219);
        PosB = CFrame.new(1266.08948, 26.1757946, -1399.57678, -0.573599219, 0, -0.81913656, 0, 1, 0, .81913656, 0, -0.573599219);
      elseif _G.FindBoss == "Greybeard" then
        bMon = "Greybeard";
        Qdata = nil;
        PosQBoss = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188);
        PosB = CFrame.new(-5081.3452148438, 85.221641540527, 4257.3588867188);
      end;
    end;
    if World2 then
      if _G.FindBoss == "Diamond" then
        bMon = "Diamond";
        Qname = "Area1Quest";
        Qdata = 3;
        PosQBoss = CFrame.new(-427.5666809082, 73.313781738281, 1835.4208984375);
        PosB = CFrame.new(-1576.7166748047, 198.59265136719, 13.724286079407);
      elseif _G.FindBoss == "Jeremy" then
        bMon = "Jeremy";
        Qname = "Area2Quest";
        Qdata = 3;
        PosQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063);
        PosB = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109);
      elseif _G.FindBoss == "Fajita" then
        bMon = "Fajita";
        Qname = "MarineQuest3";
        Qdata = 3;
        PosQBoss = CFrame.new(-2441.986328125, 73.359344482422, -3217.5324707031);
        PosB = CFrame.new(-2172.7399902344, 103.32216644287, -4015.025390625);
      elseif _G.FindBoss == "Don Swan" then
        bMon = "Don Swan";
        PosB = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875);
      elseif _G.FindBoss == "Smoke Admiral" then
        bMon = "Smoke Admiral";
        Qname = "IceSideQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(-5429.0473632813, 15.977565765381, -5297.9614257813);
        PosB = CFrame.new(-5275.1987304688, 20.757257461548, -5260.6669921875);
      elseif _G.FindBoss == "Awakened Ice Admiral" then
        bMon = "Awakened Ice Admiral";
        Qname = "FrostQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(5668.9780273438, 28.519989013672, -6483.3520507813);
        PosB = CFrame.new(6403.5439453125, 340.29766845703, -6894.5595703125);
      elseif _G.FindBoss == "Tide Keeper" then
        bMon = "Tide Keeper";
        Qname = "ForgottenQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(-3053.9814453125, 237.18954467773, -10145.0390625);
        PosB = CFrame.new(-3795.6423339844, 105.88877105713, -11421.307617188);
      elseif _G.FindBoss == "Darkbeard" then
        bMon = "Darkbeard";
        Qdata = nil;
        PosQBoss = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531);
        PosB = CFrame.new(3677.08203125, 62.751937866211, -3144.8332519531);
      elseif _G.FindBoss == "Cursed Captaim" then
        bMon = "Cursed Captain";
        Qdata = nil;
        PosQBoss = CFrame.new(916.928589, 181.092773, 33422);
        PosB = CFrame.new(916.928589, 181.092773, 33422);
      elseif _G.FindBoss == "Order" then
        bMon = "Order";
        Qdata = nil;
        PosQBoss = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875);
        PosB = CFrame.new(-6217.2021484375, 28.047645568848, -5053.1357421875);
      end;
    end;
    if World3 then
      if _G.FindBoss == "Stone" then
        bMon = "Stone";
        Qname = "PiratePortQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(-289.76705932617, 43.819011688232, 5579.9384765625);
        PosB = CFrame.new(-1027.6512451172, 92.404174804688, 6578.8530273438);
      elseif _G.FindBoss == "Hydra Leader" then
        bMon = "Hydra Leader";
        Qname = "AmazonQuest2";
        Qdata = 3;
        PosQBoss = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
        PosB = CFrame.new(5821.8979492188, 1019.0950927734, -73.719230651855);
      elseif _G.FindBoss == "Kilo Admiral" then
        bMon = "Kilo Admiral";
        Qname = "MarineTreeIsland";
        Qdata = 3;
        PosQBoss = CFrame.new(2179.3010253906, 28.731239318848, -6739.9741210938);
        PosB = CFrame.new(2764.2233886719, 432.46154785156, -7144.4580078125);
      elseif _G.FindBoss == "Captain Elephant" then
        bMon = "Captain Elephant";
        Qname = "DeepForestIsland";
        Qdata = 3;
        PosQBoss = CFrame.new(-13232.682617188, 332.40396118164, -7626.01171875);
        PosB = CFrame.new(-13376.7578125, 433.28689575195, -8071.392578125);
      elseif _G.FindBoss == "Beautiful Pirate" then
        bMon = "Beautiful Pirate";
        Qname = "DeepForestIsland2";
        Qdata = 3;
        PosQBoss = CFrame.new(-12682.096679688, 390.88653564453, -9902.1240234375);
        PosB = CFrame.new(5283.609375, 22.56223487854, -110.78285217285);
      elseif _G.FindBoss == "Cake Queen" then
        bMon = "Cake Queen";
        Qname = "IceCreamIslandQuest";
        Qdata = 3;
        PosQBoss = CFrame.new(-819.376709, 64.9259796, -10967.2832, -0.766061664, 0, .642767608, 0, 1, 0, -0.642767608, 0, -0.766061664);
        PosB = CFrame.new(-678.648804, 381.353943, -11114.2012, -0.908641815, .00149294338, .41757378, .00837114919, .999857843, .0146408929, -0.417492568, .0167988986, -0.90852499);
      elseif _G.FindBoss == "Longma" then
        bMon = "Longma";
        Qdata = nil;
        PosQBoss = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125);
        PosB = CFrame.new(-10238.875976563, 389.7912902832, -9549.7939453125);
      elseif _G.FindBoss == "Soul Reaper" then
        bMon = "Soul Reaper";
        Qdata = nil;
        PosQBoss = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813);
        PosB = CFrame.new(-9524.7890625, 315.80429077148, 6655.7192382813);
      end;
    end;
  end;
QuestBeta = function()
    local e = QuestB();
    return {
      [0] = _G.FindBoss,
      [1] = bMon,
      [2] = Qdata,
      [3] = Qname,
      [4] = PosB,
    };
  end;
QuestCheck = function()
    local e = game.Players.LocalPlayer.Data.Level.Value;
    if World1 then
      if e == 1 or e <= 9 then
        if tostring(TeamSelf) == "Marines" then
          Mon = "Trainee";
          Qname = "MarineQuest";
          Qdata = 1;
          NameMon = "Trainee";
          PosM = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, .667371571, -1.09201515e-07, -0.744724929);
          PosQ = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, .667371571, -1.09201515e-07, -0.744724929);
        elseif tostring(TeamSelf) == "Pirates" then
          Mon = "Bandit";
          Qdata = 1;
          Qname = "BanditQuest1";
          NameMon = "Bandit";
          PosM = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125);
          PosQ = CFrame.new(1045.9626464844, 27.002508163452, 1560.8203125);
        end;
      elseif e == 10 or e <= 14 then
        Mon = "Monkey";
        Qdata = 1;
        Qname = "JungleQuest";
        NameMon = "Monkey";
        PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, 0, -1, 0, 0);
        PosM = CFrame.new(-1448.5180664062, 67.853012084961, 11.465796470642);
      elseif e == 15 or e <= 29 then
        Mon = "Gorilla";
        Qdata = 2;
        Qname = "JungleQuest";
        NameMon = "Gorilla";
        PosQ = CFrame.new(-1598.08911, 35.5501175, 153.377838, 0, 0, 1, 0, 1, 0, -1, 0, 0);
        PosM = CFrame.new(-1129.8836669922, 40.46354675293, -525.42370605469);
      elseif e == 30 or e <= 39 then
        Mon = "Pirate";
        Qdata = 1;
        Qname = "BuggyQuest1";
        NameMon = "Pirate";
        PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498, .965929627, 0, -0.258804798, 0, 1, 0, .258804798, 0, .965929627);
        PosM = CFrame.new(-1103.5134277344, 13.752052307129, 3896.0910644531);
      elseif e == 40 or e <= 59 then
        Mon = "Brute";
        Qdata = 2;
        Qname = "BuggyQuest1";
        NameMon = "Brute";
        PosQ = CFrame.new(-1141.07483, 4.10001802, 3831.5498, .965929627, 0, -0.258804798, 0, 1, 0, .258804798, 0, .965929627);
        PosM = CFrame.new(-1140.0837402344, 14.809885025024, 4322.9213867188);
      elseif e == 60 or e <= 74 then
        Mon = "Desert Bandit";
        Qdata = 1;
        Qname = "DesertQuest";
        NameMon = "Desert Bandit";
        PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359, .819155693, 0, -0.573571265, 0, 1, 0, .573571265, 0, .819155693);
        PosM = CFrame.new(924.7998046875, 6.4486746788025, 4481.5859375);
      elseif e == 75 or e <= 89 then
        Mon = "Desert Officer";
        Qdata = 2;
        Qname = "DesertQuest";
        NameMon = "Desert Officer";
        PosQ = CFrame.new(894.488647, 5.14000702, 4392.43359, .819155693, 0, -0.573571265, 0, 1, 0, .573571265, 0, .819155693);
        PosM = CFrame.new(1608.2822265625, 8.6142244338989, 4371.0073242188);
      elseif e == 90 or e <= 99 then
        Mon = "Snow Bandit";
        Qdata = 1;
        Qname = "SnowQuest";
        NameMon = "Snow Bandit";
        PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, .939684391, 0, 1, 0, -0.939684391, 0, -0.342042685);
        PosM = CFrame.new(1354.3479003906, 87.272773742676, -1393.9465332031);
      elseif e == 100 or e <= 119 then
        Mon = "Snowman";
        Qdata = 2;
        Qname = "SnowQuest";
        NameMon = "Snowman";
        PosQ = CFrame.new(1389.74451, 88.1519318, -1298.90796, -0.342042685, 0, .939684391, 0, 1, 0, -0.939684391, 0, -0.342042685);
        PosM = CFrame.new(6241.9951171875, 51.522083282471, -1243.9771728516);
      elseif e == 120 or e <= 149 then
        Mon = "Chief Petty Officer";
        Qdata = 1;
        Qname = "MarineQuest2";
        NameMon = "Chief Petty Officer";
        PosQ = CFrame.new(-5039.58643, 27.3500385, 4324.68018, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-4881.2309570312, 22.652044296265, 4273.7524414062);
      elseif e == 150 or e <= 174 then
        Mon = "Sky Bandit";
        Qdata = 1;
        Qname = "SkyQuest";
        NameMon = "Sky Bandit";
        PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165, .866007268, 0, .500031412, 0, 1, 0, -0.500031412, 0, .866007268);
        PosM = CFrame.new(-4953.20703125, 295.74420166016, -2899.2290039062);
      elseif e == 175 or e <= 189 then
        Mon = "Dark Master";
        Qdata = 2;
        Qname = "SkyQuest";
        NameMon = "Dark Master";
        PosQ = CFrame.new(-4839.53027, 716.368591, -2619.44165, .866007268, 0, .500031412, 0, 1, 0, -0.500031412, 0, .866007268);
        PosM = CFrame.new(-5259.8447265625, 391.39767456055, -2229.0354003906);
      elseif e == 190 or e <= 209 then
        Mon = "Prisoner";
        Qdata = 1;
        Qname = "PrisonerQuest";
        NameMon = "Prisoner";
        PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, .995993316, -2.06384709e-09, -0.0894274712);
        PosM = CFrame.new(5098.9736328125, -0.3204058110714, 474.23733520508);
      elseif e == 210 or e <= 249 then
        Mon = "Dangerous Prisoner";
        Qdata = 2;
        Qname = "PrisonerQuest";
        NameMon = "Dangerous Prisoner";
        PosQ = CFrame.new(5308.93115, 1.65517521, 475.120514, -0.0894274712, -5.00292918e-09, -0.995993316, 1.60817859e-09, 1, -5.16744869e-09, .995993316, -2.06384709e-09, -0.0894274712);
        PosM = CFrame.new(5654.5634765625, 15.633401870728, 866.29919433594);
      elseif e == 250 or e <= 274 then
        Mon = "Toga Warrior";
        Qdata = 1;
        Qname = "ColosseumQuest";
        NameMon = "Toga Warrior";
        PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, .857167721, 0, -0.515037298);
        PosM = CFrame.new(-1820.21484375, 51.683856964111, -2740.6650390625);
      elseif e == 275 or e <= 299 then
        Mon = "Gladiator";
        Qdata = 2;
        Qname = "ColosseumQuest";
        NameMon = "Gladiator";
        PosQ = CFrame.new(-1580.04663, 6.35000277, -2986.47534, -0.515037298, 0, -0.857167721, 0, 1, 0, .857167721, 0, -0.515037298);
        PosM = CFrame.new(-1292.8381347656, 56.380882263184, -3339.0314941406);
      elseif e == 300 or e <= 324 then
        Boubty = false;
        Mon = "Military Soldier";
        Qdata = 1;
        Qname = "MagmaQuest";
        NameMon = "Military Soldier";
        PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, .866048813, 0, 1, 0, -0.866048813, 0, -0.499959469);
        PosM = CFrame.new(-5411.1645507812, 11.081554412842, 8454.29296875);
      elseif e == 325 or e <= 374 then
        Mon = "Military Spy";
        Qdata = 2;
        Qname = "MagmaQuest";
        NameMon = "Military Spy";
        PosQ = CFrame.new(-5313.37012, 10.9500084, 8515.29395, -0.499959469, 0, .866048813, 0, 1, 0, -0.866048813, 0, -0.499959469);
        PosM = CFrame.new(-5802.8681640625, 86.262413024902, 8828.859375);
      elseif e == 375 or e <= 399 then
        Mon = "Fishman Warrior";
        Qdata = 1;
        Qname = "FishmanQuest";
        NameMon = "Fishman Warrior";
        PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
        PosM = CFrame.new(60878.30078125, 18.482830047607, 1543.7574462891);
      elseif e == 400 or e <= 449 then
        Mon = "Fishman Commando";
        Qdata = 2;
        Qname = "FishmanQuest";
        NameMon = "Fishman Commando";
        PosQ = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
        PosM = CFrame.new(61922.6328125, 18.482830047607, 1493.9343261719);
      elseif e == 450 or e <= 474 then
        Mon = "God\'s Guard";
        Qdata = 1;
        Qname = "SkyExp1Quest";
        NameMon = "God\'s Guard";
        PosQ = CFrame.new(-4721.88867, 843.874695, -1949.96643, .996191859, 0, -0.0871884301, 0, 1, 0, .0871884301, 0, .996191859);
        PosM = CFrame.new(-4710.04296875, 845.27697753906, -1927.3079833984);
      elseif e == 475 or e <= 524 then
        Mon = "Shanda";
        Qdata = 2;
        Qname = "SkyExp1Quest";
        NameMon = "Shanda";
        PosQ = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, .906319618, 0, 1, 0, -0.906319618, 0, -0.422592998);
        PosM = CFrame.new(-7678.4897460938, 5566.4038085938, -497.21560668945);
      elseif e == 525 or e <= 549 then
        Mon = "Royal Squad";
        Qdata = 1;
        Qname = "SkyExp2Quest";
        NameMon = "Royal Squad";
        PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-7624.2524414062, 5658.1333007812, -1467.3542480469);
      elseif e == 550 or e <= 624 then
        Mon = "Royal Soldier";
        Qdata = 2;
        Qname = "SkyExp2Quest";
        NameMon = "Royal Soldier";
        PosQ = CFrame.new(-7906.81592, 5634.6626, -1411.99194, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-7836.7534179688, 5645.6640625, -1790.6236572266);
      elseif e == 625 or e <= 649 then
        Mon = "Galley Pirate";
        Qdata = 1;
        Qname = "FountainQuest";
        NameMon = "Galley Pirate";
        PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, .087131381, 0, .996196866, 0, 1, 0, -0.996196866, 0, .087131381);
        PosM = CFrame.new(5551.0219726562, 78.901351928711, 3930.4128417969);
      elseif e >= 650 then
        Mon = "Galley Captain";
        Qdata = 2;
        Qname = "FountainQuest";
        NameMon = "Galley Captain";
        PosQ = CFrame.new(5259.81982, 37.3500175, 4050.0293, .087131381, 0, .996196866, 0, 1, 0, -0.996196866, 0, .087131381);
        PosM = CFrame.new(5441.9516601562, 42.502059936523, 4950.09375);
      end;
    elseif World2 then
      if e == 700 or e <= 724 then
        Mon = "Raider";
        Qdata = 1;
        Qname = "Area1Quest";
        NameMon = "Raider";
        PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, .974368095, 0, -0.22495985);
        PosM = CFrame.new(-728.32672119141, 52.779319763184, 2345.7705078125);
      elseif e == 725 or e <= 774 then
        Mon = "Mercenary";
        Qdata = 2;
        Qname = "Area1Quest";
        NameMon = "Mercenary";
        PosQ = CFrame.new(-429.543518, 71.7699966, 1836.18188, -0.22495985, 0, -0.974368095, 0, 1, 0, .974368095, 0, -0.22495985);
        PosM = CFrame.new(-1004.3244018555, 80.158866882324, 1424.6193847656);
      elseif e == 775 or e <= 799 then
        Mon = "Swan Pirate";
        Qdata = 1;
        Qname = "Area2Quest";
        NameMon = "Swan Pirate";
        PosQ = CFrame.new(638.43811, 71.769989, 918.282898, .139203906, 0, .99026376, 0, 1, 0, -0.99026376, 0, .139203906);
        PosM = CFrame.new(1068.6643066406, 137.61428833008, 1322.1060791016);
      elseif e == 800 or e <= 874 then
        Mon = "Factory Staff";
        Qname = "Area2Quest";
        Qdata = 2;
        NameMon = "Factory Staff";
        PosQ = CFrame.new(632.698608, 73.1055908, 918.666321, -0.0319722369, 8.96074881e-10, -0.999488771, 1.36326533e-10, 1, 8.92172336e-10, .999488771, -1.07732087e-10, -0.0319722369);
        PosM = CFrame.new(73.078674316406, 81.863441467285, -27.470672607422);
      elseif e == 875 or e <= 899 then
        Mon = "Marine Lieutenant";
        Qdata = 1;
        Qname = "MarineQuest3";
        NameMon = "Marine Lieutenant";
        PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, .866007268, 0, .500031412, 0, 1, 0, -0.500031412, 0, .866007268);
        PosM = CFrame.new(-2821.3723144531, 75.897277832031, -3070.0891113281);
      elseif e == 900 or e <= 949 then
        Mon = "Marine Captain";
        Qdata = 2;
        Qname = "MarineQuest3";
        NameMon = "Marine Captain";
        PosQ = CFrame.new(-2440.79639, 71.7140732, -3216.06812, .866007268, 0, .500031412, 0, 1, 0, -0.500031412, 0, .866007268);
        PosM = CFrame.new(-1861.2310791016, 80.176582336426, -3254.6975097656);
      elseif e == 950 or e <= 974 then
        Mon = "Zombie";
        Qdata = 1;
        Qname = "ZombieQuest";
        NameMon = "Zombie";
        PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, .95628953, 0, -0.29242146);
        PosM = CFrame.new(-5657.7768554688, 78.969734191895, -928.68701171875);
      elseif e == 975 or e <= 999 then
        Mon = "Vampire";
        Qdata = 2;
        Qname = "ZombieQuest";
        NameMon = "Vampire";
        PosQ = CFrame.new(-5497.06152, 47.5923004, -795.237061, -0.29242146, 0, -0.95628953, 0, 1, 0, .95628953, 0, -0.29242146);
        PosM = CFrame.new(-6037.66796875, 32.184638977051, -1340.6597900391);
      elseif e == 1000 or e <= 1049 then
        Mon = "Snow Trooper";
        Qdata = 1;
        Qname = "SnowMountainQuest";
        NameMon = "Snow Trooper";
        PosQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, .92718488, 0, 1, 0, -0.92718488, 0, -0.374604106);
        PosM = CFrame.new(549.14733886719, 427.38705444336, -5563.6987304688);
      elseif e == 1050 or e <= 1099 then
        Mon = "Winter Warrior";
        Qdata = 2;
        Qname = "SnowMountainQuest";
        NameMon = "Winter Warrior";
        PosQ = CFrame.new(609.858826, 400.119904, -5372.25928, -0.374604106, 0, .92718488, 0, 1, 0, -0.92718488, 0, -0.374604106);
        PosM = CFrame.new(1142.7451171875, 475.63980102539, -5199.4165039062);
      elseif e == 1100 or e <= 1124 then
        Mon = "Lab Subordinate";
        Qdata = 1;
        Qname = "IceSideQuest";
        NameMon = "Lab Subordinate";
        PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, .453972578, 0, -0.891015649, 0, 1, 0, .891015649, 0, .453972578);
        PosM = CFrame.new(-5707.4716796875, 15.951709747314, -4513.3920898438);
      elseif e == 1125 or e <= 1174 then
        Mon = "Horned Warrior";
        Qdata = 2;
        Qname = "IceSideQuest";
        NameMon = "Horned Warrior";
        PosQ = CFrame.new(-6064.06885, 15.2422857, -4902.97852, .453972578, 0, -0.891015649, 0, 1, 0, .891015649, 0, .453972578);
        PosM = CFrame.new(-6341.3666992188, 15.951770782471, -5723.162109375);
      elseif e == 1175 or e <= 1199 then
        Mon = "Magma Ninja";
        Qdata = 1;
        Qname = "FireSideQuest";
        NameMon = "Magma Ninja";
        PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
        PosM = CFrame.new(-5449.6728515625, 76.658744812012, -5808.2006835938);
      elseif e == 1200 or e <= 1249 then
        Mon = "Lava Pirate";
        Qdata = 2;
        Qname = "FireSideQuest";
        NameMon = "Lava Pirate";
        PosQ = CFrame.new(-5428.03174, 15.0622921, -5299.43457, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
        PosM = CFrame.new(-5213.3315429688, 49.737880706787, -4701.451171875);
      elseif e == 1250 or e <= 1274 then
        Mon = "Ship Deckhand";
        Qdata = 1;
        Qname = "ShipQuest1";
        NameMon = "Ship Deckhand";
        PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016);
        PosM = CFrame.new(1212.0111083984, 150.79205322266, 33059.24609375);
      elseif e == 1275 or e <= 1299 then
        Mon = "Ship Engineer";
        Qdata = 2;
        Qname = "ShipQuest1";
        NameMon = "Ship Engineer";
        PosQ = CFrame.new(1037.80127, 125.092171, 32911.6016);
        PosM = CFrame.new(919.47863769531, 43.544013977051, 32779.96875);
      elseif e == 1300 or e <= 1324 then
        Mon = "Ship Steward";
        Qdata = 1;
        Qname = "ShipQuest2";
        NameMon = "Ship Steward";
        PosQ = CFrame.new(968.80957, 125.092171, 33244.125);
        PosM = CFrame.new(919.43853759766, 129.55599975586, 33436.03515625);
      elseif e == 1325 or e <= 1349 then
        Mon = "Ship Officer";
        Qdata = 2;
        Qname = "ShipQuest2";
        NameMon = "Ship Officer";
        PosQ = CFrame.new(968.80957, 125.092171, 33244.125);
        PosM = CFrame.new(1036.0179443359, 181.4390411377, 33315.7265625);
      elseif e == 1350 or e <= 1374 then
        Mon = "Arctic Warrior";
        Qdata = 1;
        Qname = "FrostQuest";
        NameMon = "Arctic Warrior";
        PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, .358349502, 0, -0.933587909);
        PosM = CFrame.new(5966.24609375, 62.970020294189, -6179.3828125);
      elseif e == 1375 or e <= 1424 then
        Mon = "Snow Lurker";
        Qdata = 2;
        Qname = "FrostQuest";
        NameMon = "Snow Lurker";
        PosQ = CFrame.new(5667.6582, 26.7997818, -6486.08984, -0.933587909, 0, -0.358349502, 0, 1, 0, .358349502, 0, -0.933587909);
        PosM = CFrame.new(5407.0737304688, 69.194374084473, -6880.8803710938);
      elseif e == 1425 or e <= 1449 then
        Mon = "Sea Soldier";
        Qdata = 1;
        Qname = "ForgottenQuest";
        NameMon = "Sea Soldier";
        PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, .990270376, 0, -0.13915664, 0, 1, 0, .13915664, 0, .990270376);
        PosM = CFrame.new(-3028.2236328125, 64.674514770508, -9775.4267578125);
      elseif e >= 1450 then
        Mon = "Water Fighter";
        Qdata = 2;
        Qname = "ForgottenQuest";
        NameMon = "Water Fighter";
        PosQ = CFrame.new(-3054.44458, 235.544281, -10142.8193, .990270376, 0, -0.13915664, 0, 1, 0, .13915664, 0, .990270376);
        PosM = CFrame.new(-3352.9013671875, 285.01556396484, -10534.841796875);
      end;
    elseif World3 then
      if e == 1500 or e <= 1524 then
        Mon = "Pirate Millionaire";
        Qdata = 1;
        Qname = "PiratePortQuest";
        NameMon = "Pirate Millionaire";
        PosQ = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625);
        PosM = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625);
      elseif e == 1525 or e <= 1574 then
        Mon = "Pistol Billionaire";
        Qdata = 2;
        Qname = "PiratePortQuest";
        NameMon = "Pistol Billionaire";
        PosQ = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625);
        PosM = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625);
      elseif e == 1575 or e <= 1599 then
        Mon = "Dragon Crew Warrior";
        Qdata = 1;
        Qname = "AmazonQuest";
        NameMon = "Dragon Crew Warrior";
        PosQ = CFrame.new(6779.0327148438, 111.16865539551, -801.21307373047);
        PosM = CFrame.new(6779.0327148438, 111.16865539551, -801.21307373047);
      elseif e == 1600 or e <= 1624 then
        Mon = "Dragon Crew Archer";
        Qname = "AmazonQuest";
        Qdata = 2;
        NameMon = "Dragon Crew Archer";
        PosQ = CFrame.new(6955.8974609375, 546.66589355469, 309.04013061523);
        PosM = CFrame.new(6955.8974609375, 546.66589355469, 309.04013061523);
      elseif e == 1625 or e <= 1649 then
        Mon = "Hydra Enforcer";
        Qname = "VenomCrewQuest";
        Qdata = 1;
        NameMon = "Hydra Enforcer";
        PosQ = CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492);
        PosM = CFrame.new(4620.6157226562, 1002.2954711914, 399.08688354492);
      elseif e == 1650 or e <= 1699 then
        Mon = "Venomous Assailant";
        Qname = "VenomCrewQuest";
        Qdata = 2;
        NameMon = "Venomous Assailant";
        PosQ = CFrame.new(4697.5918, 1100.65137, 946.401978, .579397917, -4.19689783e-10, .81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, .579397917);
        PosM = CFrame.new(4697.5918, 1100.65137, 946.401978, .579397917, -4.19689783e-10, .81504482, -1.49287818e-10, 1, 6.21053986e-10, -0.81504482, -4.81513662e-10, .579397917);
      elseif e == 1700 or e <= 1724 then
        Mon = "Marine Commodore";
        Qdata = 1;
        Qname = "MarineTreeIsland";
        NameMon = "Marine Commodore";
        PosQ = CFrame.new(2180.54126, 27.8156815, -6741.5498, -0.965929747, 0, .258804798, 0, 1, 0, -0.258804798, 0, -0.965929747);
        PosM = CFrame.new(2286.0078125, 73.133918762207, -7159.8090820312);
      elseif e == 1725 or e <= 1774 then
        Mon = "Marine Rear Admiral";
        NameMon = "Marine Rear Admiral";
        Qname = "MarineTreeIsland";
        Qdata = 2;
        PosQ = CFrame.new(2179.98828125, 28.731239318848, -6740.0551757813);
        PosM = CFrame.new(3656.7736816406, 160.52406311035, -7001.5986328125);
      elseif e == 1775 or e <= 1799 then
        Mon = "Fishman Raider";
        Qdata = 1;
        Qname = "DeepForestIsland3";
        NameMon = "Fishman Raider";
        PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
        PosM = CFrame.new(-10407.526367188, 331.76263427734, -8368.5166015625);
      elseif e == 1800 or e <= 1824 then
        Mon = "Fishman Captain";
        Qdata = 2;
        Qname = "DeepForestIsland3";
        NameMon = "Fishman Captain";
        PosQ = CFrame.new(-10581.6563, 330.872955, -8761.18652, -0.882952213, 0, .469463557, 0, 1, 0, -0.469463557, 0, -0.882952213);
        PosM = CFrame.new(-10994.701171875, 352.38140869141, -9002.1103515625);
      elseif e == 1825 or e <= 1849 then
        Mon = "Forest Pirate";
        Qdata = 1;
        Qname = "DeepForestIsland";
        NameMon = "Forest Pirate";
        PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247);
        PosM = CFrame.new(-13274.478515625, 332.37814331055, -7769.5805664062);
      elseif e == 1850 or e <= 1899 then
        Mon = "Mythological Pirate";
        Qdata = 2;
        Qname = "DeepForestIsland";
        NameMon = "Mythological Pirate";
        PosQ = CFrame.new(-13234.04, 331.488495, -7625.40137, .707134247, 0, -0.707079291, 0, 1, 0, .707079291, 0, .707134247);
        PosM = CFrame.new(-13680.607421875, 501.08154296875, -6991.189453125);
      elseif e == 1900 or e <= 1924 then
        Mon = "Jungle Pirate";
        Qdata = 1;
        Qname = "DeepForestIsland2";
        NameMon = "Jungle Pirate";
        PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002);
        PosM = CFrame.new(-12256.16015625, 331.73828125, -10485.836914062);
      elseif e == 1925 or e <= 1974 then
        Mon = "Musketeer Pirate";
        Qdata = 2;
        Qname = "DeepForestIsland2";
        NameMon = "Musketeer Pirate";
        PosQ = CFrame.new(-12680.3818, 389.971039, -9902.01953, -0.0871315002, 0, .996196866, 0, 1, 0, -0.996196866, 0, -0.0871315002);
        PosM = CFrame.new(-13457.904296875, 391.54565429688, -9859.177734375);
      elseif e == 1975 or e <= 1999 then
        Mon = "Reborn Skeleton";
        Qdata = 1;
        Qname = "HauntedQuest1";
        NameMon = "Reborn Skeleton";
        PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0);
        PosM = CFrame.new(-8763.7236328125, 165.72299194336, 6159.8618164062);
      elseif e == 2000 or e <= 2024 then
        Mon = "Living Zombie";
        Qdata = 2;
        Qname = "HauntedQuest1";
        NameMon = "Living Zombie";
        PosQ = CFrame.new(-9479.2168, 141.215088, 5566.09277, 0, 0, 1, 0, 1, 0, -1, 0, 0);
        PosM = CFrame.new(-10144.131835938, 138.6266784668, 5838.0888671875);
      elseif e == 2025 or e <= 2049 then
        Mon = "Demonic Soul";
        Qdata = 1;
        Qname = "HauntedQuest2";
        NameMon = "Demonic Soul";
        PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-9505.8720703125, 172.10482788086, 6158.9931640625);
      elseif e == 2050 or e <= 2074 then
        Mon = "Posessed Mummy";
        Qdata = 2;
        Qname = "HauntedQuest2";
        NameMon = "Posessed Mummy";
        PosQ = CFrame.new(-9516.99316, 172.017181, 6078.46533, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-9582.0224609375, 6.2515273094177, 6205.478515625);
      elseif e == 2075 or e <= 2099 then
        Mon = "Peanut Scout";
        Qdata = 1;
        Qname = "NutsIslandQuest";
        NameMon = "Peanut Scout";
        PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-2143.2419433594, 47.721984863281, -10029.995117188);
      elseif e == 2100 or e <= 2124 then
        Mon = "Peanut President";
        Qdata = 2;
        Qname = "NutsIslandQuest";
        NameMon = "Peanut President";
        PosQ = CFrame.new(-2104.3908691406, 38.104167938232, -10194.21875, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-1859.3540039062, 38.103168487549, -10422.4296875);
      elseif e == 2125 or e <= 2149 then
        Mon = "Ice Cream Chef";
        Qdata = 1;
        Qname = "IceCreamIslandQuest";
        NameMon = "Ice Cream Chef";
        PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-872.24658203125, 65.81957244873, -10919.95703125);
      elseif e == 2150 or e <= 2199 then
        Mon = "Ice Cream Commander";
        Qdata = 2;
        Qname = "IceCreamIslandQuest";
        NameMon = "Ice Cream Commander";
        PosQ = CFrame.new(-820.64825439453, 65.819526672363, -10965.795898438, 0, 0, -1, 0, 1, 0, 1, 0, 0);
        PosM = CFrame.new(-558.06103515625, 112.04895782471, -11290.774414062);
      elseif e == 2200 or e <= 2224 then
        Mon = "Cookie Crafter";
        Qdata = 1;
        Qname = "CakeQuest1";
        NameMon = "Cookie Crafter";
        PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-08, .288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, .957576931);
        PosM = CFrame.new(-2374.13671875, 37.798263549805, -12125.30859375);
      elseif e == 2225 or e <= 2249 then
        Mon = "Cake Guard";
        Qdata = 2;
        Qname = "CakeQuest1";
        NameMon = "Cake Guard";
        PosQ = CFrame.new(-2021.32007, 37.7982254, -12028.7295, .957576931, -8.80302053e-08, .288177818, 6.9301187e-08, 1, 7.51931211e-08, -0.288177818, -5.2032135e-08, .957576931);
        PosM = CFrame.new(-1598.3070068359, 43.773197174072, -12244.581054688);
      elseif e == 2250 or e <= 2274 then
        Mon = "Baking Staff";
        Qdata = 1;
        Qname = "CakeQuest2";
        NameMon = "Baking Staff";
        PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, .250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446);
        PosM = CFrame.new(-1887.8099365234, 77.618507385254, -12998.350585938);
      elseif e == 2275 or e <= 2299 then
        Mon = "Head Baker";
        Qdata = 2;
        Qname = "CakeQuest2";
        NameMon = "Head Baker";
        PosQ = CFrame.new(-1927.91602, 37.7981339, -12842.5391, -0.96804446, 4.22142143e-08, .250778586, 4.74911062e-08, 1, 1.49904711e-08, -0.250778586, 2.64211941e-08, -0.96804446);
        PosM = CFrame.new(-2216.1882324219, 82.884521484375, -12869.293945312);
      elseif e == 2300 or e <= 2324 then
        Mon = "Cocoa Warrior";
        Qdata = 1;
        Qname = "ChocQuest1";
        NameMon = "Cocoa Warrior";
        PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438);
        PosM = CFrame.new(-21.553283691406, 80.574996948242, -12352.387695312);
      elseif e == 2325 or e <= 2349 then
        Mon = "Chocolate Bar Battler";
        Qdata = 2;
        Qname = "ChocQuest1";
        NameMon = "Chocolate Bar Battler";
        PosQ = CFrame.new(233.22836303711, 29.876001358032, -12201.233398438);
        PosM = CFrame.new(582.59057617188, 77.188095092773, -12463.162109375);
      elseif e == 2350 or e <= 2374 then
        Mon = "Sweet Thief";
        Qdata = 1;
        Qname = "ChocQuest2";
        NameMon = "Sweet Thief";
        PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688);
        PosM = CFrame.new(165.1884765625, 76.058853149414, -12600.836914062);
      elseif e == 2375 or e <= 2399 then
        Mon = "Candy Rebel";
        Qdata = 2;
        Qname = "ChocQuest2";
        NameMon = "Candy Rebel";
        PosQ = CFrame.new(150.50663757324, 30.693693161011, -12774.502929688);
        PosM = CFrame.new(134.86563110352, 77.247680664062, -12876.547851562);
      elseif e == 2400 or e <= 2449 then
        Mon = "Candy Pirate";
        Qdata = 1;
        Qname = "CandyQuest1";
        NameMon = "Candy Pirate";
        PosQ = CFrame.new(-1150.0400390625, 20.378934860229, -14446.334960938);
        PosM = CFrame.new(-1310.5003662109, 26.016523361206, -14562.404296875);
      elseif e == 2450 or e <= 2474 then
        Mon = "Isle Outlaw";
        Qdata = 1;
        Qname = "TikiQuest1";
        NameMon = "Isle Outlaw";
        PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566);
        PosM = CFrame.new(-16479.900390625, 226.6117401123, -300.31143188477);
      elseif e == 2475 or e <= 2499 then
        Mon = "Island Boy";
        Qdata = 2;
        Qname = "TikiQuest1";
        NameMon = "Island Boy";
        PosQ = CFrame.new(-16548.8164, 55.6059914, -172.8125, .213092566, 0, -0.977032006, 0, 1, 0, .977032006, 0, .213092566);
        PosM = CFrame.new(-16849.396484375, 192.86505126953, -150.78532409668);
      elseif e == 2500 or e <= 2524 then
        Mon = "Sun-kissed Warrior";
        Qdata = 1;
        Qname = "TikiQuest2";
        NameMon = "kissed Warrior";
        PosM = CFrame.new(-16347, 64, 984);
        PosQ = CFrame.new(-16538, 55, 1049);
      elseif e == 2525 or e <= 2550 then
        Mon = "Isle Champion";
        Qdata = 2;
        Qname = "TikiQuest2";
        NameMon = "Isle Champion";
        PosQ = CFrame.new(-16541.0215, 57.3082275, 1051.46118, .0410757065, 0, -0.999156058, 0, 1, 0, .999156058, 0, .0410757065);
        PosM = CFrame.new(-16602.1015625, 130.38734436035, 1087.2456054688);
      elseif e == 2551 or e <= 2574 then
        Mon = "Serpent Hunter";
        Qdata = 1;
        Qname = "TikiQuest3";
        NameMon = "Serpent Hunter";
        PosQ = CFrame.new(-16679.478515625, 176.74737548828, 1474.3995361328);
        PosM = CFrame.new(-16679.478515625, 176.74737548828, 1474.3995361328);
      elseif e >= 2575 then
        Mon = "Skull Slayer";
        Qdata = 2;
        Qname = "TikiQuest3";
        NameMon = "Skull Slayer";
        PosQ = CFrame.new(-16759.58984375, 71.283767700195, 1595.3399658203);
        PosM = CFrame.new(-16759.58984375, 71.283767700195, 1595.3399658203);
      end;
    end;
  end;
MaterialMon = function()
    local e = game.Players.LocalPlayer;
    local A = e.Character and e.Character:FindFirstChild("HumanoidRootPart");
    if not A then
      return;
    end;
    shouldRequestEntrance = function(e, u)
        local Z = (A.Position - e).Magnitude;
        if Z >= u then
          replicated.Remotes.CommF_:InvokeServer("requestEntrance", e);
        end;
      end;
    if World1 then
      if SelectMaterial == "Angel Wings" then
        MMon = {
            "Shanda",
            "Royal Squad",
            "Royal Soldier",
            "Wysper",
            "Thunder God",
          };
        MPos = CFrame.new(-4698, 845, -1912);
        SP = "Default";
        local e = Vector3.new(-4607.82275, 872.54248, -1667.55688);
        shouldRequestEntrance(e, 10000);
      elseif SelectMaterial == "Leather + Scrap Metal" then
        MMon = { "Brute", "Pirate" };
        MPos = CFrame.new(-1145, 15, 4350);
        SP = "Default";
      elseif SelectMaterial == "Magma Ore" then
        MMon = { "Military Soldier", "Military Spy", "Magma Admiral" };
        MPos = CFrame.new(-5815, 84, 8820);
        SP = "Default";
      elseif SelectMaterial == "Fish Tail" then
        MMon = { "Fishman Warrior", "Fishman Commando", "Fishman Lord" };
        MPos = CFrame.new(61123, 19, 1569);
        SP = "Default";
      end;
    elseif World2 then
      if SelectMaterial == "Leather + Scrap Metal" then
        MMon = { "Marine Captain" };
        MPos = CFrame.new(-2010.5059814453, 73.001159667969, -3326.6208496094);
        SP = "Default";
      elseif SelectMaterial == "Magma Ore" then
        MMon = { "Magma Ninja", "Lava Pirate" };
        MPos = CFrame.new(-5428, 78, -5959);
        SP = "Default";
      elseif SelectMaterial == "Ectoplasm" then
        MMon = {
            "Ship Deckhand",
            "Ship Engineer",
            "Ship Steward",
            "Ship Officer",
          };
        MPos = CFrame.new(911.35827636719, 125.95812988281, 33159.5390625);
        SP = "Default";
      elseif SelectMaterial == "Mystic Droplet" then
        MMon = { "Water Fighter" };
        MPos = CFrame.new(-3385, 239, -10542);
        SP = "Default";
      elseif SelectMaterial == "Radioactive Material" then
        MMon = { "Factory Staff" };
        MPos = CFrame.new(295, 73, -56);
        SP = "Default";
      elseif SelectMaterial == "Vampire Fang" then
        MMon = { "Vampire" };
        MPos = CFrame.new(-6033, 7, -1317);
        SP = "Default";
      end;
    elseif World3 then
      if SelectMaterial == "Scrap Metal" then
        MMon = { "Jungle Pirate", "Forest Pirate" };
        MPos = CFrame.new(-11975.78515625, 331.77340698242, -10620.030273438);
        SP = "Default";
      elseif SelectMaterial == "Fish Tail" then
        MMon = { "Fishman Raider", "Fishman Captain" };
        MPos = CFrame.new(-10993, 332, -8940);
        SP = "Default";
      elseif SelectMaterial == "Conjured Cocoa" then
        MMon = { "Chocolate Bar Battler", "Cocoa Warrior" };
        MPos = CFrame.new(620.63446044922, 78.936447143555, -12581.369140625);
        SP = "Default";
      elseif SelectMaterial == "Dragon Scale" then
        MMon = { "Dragon Crew Archer", "Dragon Crew Warrior" };
        MPos = CFrame.new(6594, 383, 139);
        SP = "Default";
      elseif SelectMaterial == "Gunpowder" then
        MMon = { "Pistol Billionaire" };
        MPos = CFrame.new(-84.855690002441, 85.620613098145, 6132.0087890625);
        SP = "Default";
      elseif SelectMaterial == "Mini Tusk" then
        MMon = { "Mythological Pirate" };
        MPos = CFrame.new(-13545, 470, -6917);
        SP = "Default";
      elseif SelectMaterial == "Demonic Wisp" then
        MMon = { "Demonic Soul" };
        MPos = CFrame.new(-9495.6806640625, 453.58624267578, 5977.3486328125);
        SP = "Default";
      end;
    end;
  end;
QuestNeta = function()
  QuestCheck()

  return {
    MonName     = Mon,      -- Tên quái
    QuestLevel  = Qdata,    -- Level quest (number)
    QuestName   = Qname,    -- Quest name (string)
    MobSpawnPos = PosM,     -- CFrame spawn quái
    QuestText   = NameMon,  -- Text kiểm tra quest GUI
    QuestNpcPos = PosQ,     -- CFrame NPC quest
  }
end
local function GetEnemyByName(name)
  for _, v in pairs(workspace.Enemies:GetChildren()) do
    if v.Name == name
    and v:FindFirstChild("Humanoid")
    and v.Humanoid.Health > 0
    and v:FindFirstChild("HumanoidRootPart") then
      return v
    end
  end
end



local UiHub = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = UiHub:CreateWindow({
    Title = "Ziris Hub",
    SubTitle = "by Minhieu_.",
    TabWidth = 160,
    Size = UDim2.fromOffset(550, 350),
    Acrylic = true, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl 
  });

local Tabs = {
  Server = Window:AddTab({Title = "Tab Server", Icon = ""}),
  Main = Window:AddTab({Title = "Tab Farming", Icon = ""}),
  Settings = Window:AddTab({Title = "Tab Setting Farm", Icon = ""}),
  Melee = Window:AddTab({Title = "Tab Auto Get Melee V2", Icon = ""}),
  Quests = Window:AddTab({Title = "Tab Items Farm", Icon = ""}),
  SeaEvent = Window:AddTab({Title = "Tab Sea Events", Icon = ""}),
  Mirage = Window:AddTab({Title = "Tab Mirage + RaceV4", Icon = ""}),
  Drago = Window:AddTab({Title = "Tab Drago Dojo", Icon = ""}),
  Prehistoric = Window:AddTab({Title = "Tab Prehistoric", Icon = ""}),
  Raids = Window:AddTab({Title = "Tab Raid", Icon = ""}),
  Combat = Window:AddTab({Title = "Tab Combat PVP", Icon = ""}),
  Travel = Window:AddTab({Title = "Tab Teleport", Icon = ""}),
  Fruit = Window:AddTab({Title = "Tab Fruits", Icon = ""}),
  Shop = Window:AddTab({Title = "Tab Shop", Icon = ""}),
  Misc = Window:AddTab({Title = "Tab Misc", Icon = ""})
}

---Tab Server----------------------
local Status_Se = Tabs.Server:AddSection("Server - Status")
local MoonStatus = Tabs.Server:AddParagraph({ Title = "Moon", Content = "" })
task.spawn(function()
    while task.wait(1) do
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
              MoonStatus:SetDesc("Status: Unknown")
                return
            end

            if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                MoonStatus:SetDesc("Status: 🌕 Full Moon")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                MoonStatus:SetDesc("Status: 🌖 75%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                MoonStatus:SetDesc("Status: 🌓 50%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                MoonStatus:SetDesc("Status: 🌘 25%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                MoonStatus:SetDesc("Status: 🌑 15%")
            else
                MoonStatus:SetDesc("Status: 🌚 0%")
            end
        end)
    end
end)

if World1 then
    local TheSawStatus = Tabs.Server:AddParagraph({ Title = "The Saw", Content = "" })
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") or game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                    TheSawStatus:SetDesc("Status : ✅️")
                else
                    TheSawStatus:SetDesc("Status : ❌️")
                end
            end)
        end
    end)

    local GreyBeardStatus = Tabs.Server:AddParagraph({ Title = "Grey Beard", Content = "" })
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") or game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                    GreyBeardStatus:SetDesc("Status : ✅️")
                else
                    GreyBeardStatus:SetDesc("Status : ❌️")
                end
            end)
        end
    end)
end

if World2 then
    local CursedCaptainStatus = Tabs.Server:AddParagraph({ Title = "Cursed Captain", Content = "" })
    task.spawn(function()
        while wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Captain") then
                    CursedCaptainStatus:SetDesc("Status : ✅️")
                else
                    CursedCaptainStatus:SetDesc("Status : ❌️")
                end
            end)
        end
    end)
    local LegendarySwordStatus = Tabs.Server:AddParagraph({ Title = "Legendary Sword", Content = "" })
    task.spawn(function()
        local previousStatus = ""
        while task.wait(1) do
            local swordStatus = "Status : ❌"
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                swordStatus = "Status: Shisui"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
                swordStatus = "Status: Wando"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
                swordStatus = "Status: Saddi"
            end
            LegendarySwordStatus:SetDesc(swordStatus)
        end
    end)
end

if World3 then
    local MirageIslandStatus = Tabs.Server:AddParagraph({ Title = "Mirage Island", Content = "" })
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game.Workspace.Map:FindFirstChild("MysticIsland") then
                    MirageIslandStatus:SetDesc("Status : ✅")
                else
                    MirageIslandStatus:SetDesc("Status : ❌")
                end
            end)
        end
    end)

    local LeviathanStatus = Tabs.Server:AddParagraph({ Title = "Spy", Content = "" })
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                local SpyStatus = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
                if (SpyStatus == 5) then
                    LeviathanStatus:SetDesc("Status : Leviathan Is Out There")
                elseif (SpyStatus == -1) then
                    LeviathanStatus:SetDesc("Status : I Don't Know")
                else
                    LeviathanStatus:SetDesc("Buy: " .. tostring(SpyStatus))
                end
            end
        end)
    end)

    local FrozenDimensionStatus = Tabs.Server:AddParagraph({ Title = "Frozen Dimension", Content = "" })
    task.spawn(function()
        pcall(function()
            while task.wait(.5) do
                if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
                    FrozenDimensionStatus:SetDesc("Status : ✅")
                else
                    FrozenDimensionStatus:SetDesc("Status : ❌")
                end
            end
        end)
    end)

    local KitsuneIslandStatus = Tabs.Server:AddParagraph({ Title = "Kitsune Island", Content = "" })
    function UpdateKitsune()
        if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
            KitsuneIslandStatus:SetDesc("Status : ✅️")
        else
            KitsuneIslandStatus:SetDesc("Status : ❌️")
        end
    end
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                UpdateKitsune()
            end
        end)
    end)

    local PrehistoricIslandStatus = Tabs.Server:AddParagraph({ Title = "Volcano Island", Content = "" })
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                    PrehistoricIslandStatus:SetDesc("Status : ✅️")
                else
                    PrehistoricIslandStatus:SetDesc("Status : ❌️")
                end
            end
        end)
    end)

    local CakePrinceStatus = Tabs.Server:AddParagraph({ Title = "Cake Prince", Content = "" })
    task.spawn(function()
        while task.wait(.5) do
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
        while task.wait(.5) do
            pcall(function()
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                    CakePrinceStatus:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                    CakePrinceStatus:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                    CakePrinceStatus:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39).." Mobs")
                else
                    CakePrinceStatus:SetDesc("Status : Cake Prince Is Spawning!")
                end
            end)
        end
    end)
    local Eyes = {}

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") and obj.Name:match("^Eye%d+$") then
            Eyes[obj] = true
        end
    end

    workspace.DescendantAdded:Connect(function(obj)
        if obj:IsA("BasePart") and obj.Name:match("^Eye%d+$") then
            Eyes[obj] = true
        end
    end)

    workspace.DescendantRemoving:Connect(function(obj)
        if Eyes[obj] then
            Eyes[obj] = nil
        end
    end)

    function CheckEyes()
        local count = 0
        for eye in pairs(Eyes) do
            if eye.Material == Enum.Material.Neon and eye.Transparency == 0 then
                count += 1
            end
        end
        return count
    end

  local TyrantStatus = Tabs.Server:AddParagraph({
      Title = "Tyrant Of The Skies",
      Content = "Status : 0/4 Eyes"
  })

  task.spawn(function()
      while task.wait(1) do
          pcall(function()
              local eyes = CheckEyes()
              TyrantStatus:SetDesc("Status : "..eyes.."/4 Eyes")
          end)
      end
  end)

    local EliteHunterStatus = Tabs.Server:AddParagraph({ Title = "Elite Hunter", Content = "" })
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                    EliteHunterStatus:SetDesc("Status : ✅️")
                else
                    EliteHunterStatus:SetDesc("Status : ❌️")
                end
            end)
        end
    end)
end
local FruitStatus = Tabs.Server:AddParagraph({ Title = "Fruit in Server", Content = "" })
task.spawn(function()
    while task.wait(.5) do
        pcall(function()
            local foundFruits = {}

            for i, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                    table.insert(foundFruits, v.Name)
                end
            end

            if #foundFruits > 0 then
                FruitStatus:SetDesc("Status: (" .. #foundFruits .. "): " .. table.concat(foundFruits, ", "))
            else
                FruitStatus:SetDesc("Status : ❌")
            end
        end)
    end
end)
local Server_Se = Tabs.Server:AddSection("Server - Function")
local ServerJobId = Tabs.Server:AddParagraph({ Title = "JobId:", Content = "" })
ServerJobId:SetDesc(game.JobId)
Tabs.Server:AddButton({ Title = "Copy JobId", Description = "", Callback = function()
  setclipboard(tostring(game.JobId))
end })
local JobID = Tabs.Server:AddInput("JobID", {Title = "JobID",Default = "",Placeholder = "",
Numeric = false, -- Only allows numbers
Finished = false, -- Only calls callback when you press enter
Callback = function(Value)
  _G.JobId = Value
end})
spawn(function()
  while wait(Sec) do
    if _G.JobId then
      pcall(function()
        local Connection
        Connection = plr.OnTeleport:Connect(function(br)
          if br == Enum.TeleportState.Failed then
          Connection:Disconnect()
          if workspace:FindFirstChild("Message") then workspace.Message:Destroy() end
          end
        end)
      end)
    end
  end
end)
Tabs.Server:AddButton({ Title = "Join Server With JobId", Description = "", Callback = function()
  replicated.__ServerBrowser:InvokeServer("teleport", _G.JobId)
end})
Tabs.Server:AddButton({ Title = "Hop Server", Description = "", Callback = function()
  pcall(function()
    Hop()
  end)
end})
Tabs.Server:AddButton({ Title = "Hop to Lowest Players", Description = "", Callback = function()
  pcall(function()
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FREE-PRIVATE-SERVER-V2-59627"))()
  end)
end })
Tabs.Server:AddButton({ Title = "Rejoin Server", Description = "", Callback = function()
  (game:GetService("TeleportService")):Teleport(game.PlaceId, game.Players.LocalPlayer);
end });

local FrameMode
if World1 or World2 then
  FrameMode = {"Fram Level", "Fram Nearest"}
else
  FrameMode = {"Fram Level", "Fram Cake Prince", "Fram Bone", "Fram Tyrant of The Skies", "Fram Nearest"}
end
local function UpdateFramMode()
    local active = _G.StartFram
    _G.Level = (_G.SelectFramMode == "Fram Level" and active)
    _G.Auto_Cake_Prince = (_G.SelectFramMode == "Fram Cake Prince" and active)
    _G.AutoFarm_Bone = (_G.SelectFramMode == "Fram Bone" and active)
    _G.AutoFarmNear = (_G.SelectFramMode == "Fram Nearest" and active)
    _G.FarmTyrant = (_G.SelectFramMode == "Fram Tyrant of The Skies" and active)
end
local SelectMode = Tabs.Main:AddDropdown("SelectFramMode",{Title = "Select Fram:",Values = FrameMode,Multi = false,Default = 1})
SelectMode:OnChanged(function(e)
    _G.SelectFramMode = e
    UpdateFramMode()
end)
local StartFram = Tabs.Main:AddToggle("StartFram", {Title = "Start Fram", Description = "", Default = false})
StartFram:OnChanged(function(e)
      _G.StartFram = e
      UpdateFramMode()
end)

-- Farm Level Logic
spawn(function()
    while task.wait(Sec) do
        if not _G.Level then continue end
        
        pcall(function()
            local Q = QuestNeta()
            local QuestGui = plr.PlayerGui.Main.Quest
            local QuestTitle = QuestGui.Container.QuestTitle.Title
            local Root = plr.Character.HumanoidRootPart
            
            -- Abandon quest if wrong target
            if QuestGui.Visible and not string.find(QuestTitle.Text, Q.QuestText) then
                CommF:InvokeServer("AbandonQuest")
                task.wait(0.5)
            end
            
            -- Start quest if not active
            if not QuestGui.Visible then
                _tp(Q.QuestNpcPos)
                repeat task.wait() until (Root.Position - Q.QuestNpcPos.Position).Magnitude <= 10 or not _G.Level
                if not _G.Level then return end
                
                CommF:InvokeServer("StartQuest", Q.QuestName, Q.QuestLevel)
                
                local t = tick()
                repeat task.wait()
                until (QuestGui.Visible and string.find(QuestTitle.Text, Q.QuestText)) or tick() - t > 5 or not _G.Level
                return
            end
            
            -- Kill target mobs
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if not _G.Level then break end
                if O.Alive(mob) and mob.Name == Q.MonName then
                    repeat
                        task.wait()
                        O.Kill(mob, true)
                        BringEnemy(mob)
                    until not mob.Parent or mob.Humanoid.Health <= 0  or not QuestGui.Visible or not _G.Level
                end
            end
            
            -- Teleport to mob spawn area
            if QuestGui.Visible then
                _tp(Q.MobSpawnPos)
            end
        end)
    end
end)
local QUEST_POS = CFrame.new(-1927.92,37.8,-12842.54)
local MIRROR_TP = CFrame.new(-2151.82,149.32,-12404.91)

local Minions = {
    "Cookie Crafter",
    "Cake Guard",
    "Baking Staff",
    "Head Baker"
}

local LastSpawner = 0
local SpawnerCD = 10

--------------------------------------------------
-- BOSS FINDER
--------------------------------------------------
local function GetBoss()
    local e = Workspace:FindFirstChild("Enemies")
    if not e then return end
    
    for _,v in pairs(e:GetChildren()) do
        if v.Name=="Cake Prince"
        and v:FindFirstChild("Humanoid")
        and v.Humanoid.Health>0 then
            return v
        end
    end
end

--------------------------------------------------
-- MAIN LOOP
--------------------------------------------------
task.spawn(function()
while task.wait(0.15) do
if not _G.Auto_Cake_Prince then continue end

pcall(function()

local Char = plr.Character
if not Char then return end
local HRP = Char:FindFirstChild("HumanoidRootPart")
if not HRP then return end

local QuestGui = plr.PlayerGui:FindFirstChild("Main")
QuestGui = QuestGui and QuestGui:FindFirstChild("Quest")

local Enemies = Workspace:FindFirstChild("Enemies")
if not Enemies then return end

--------------------------------------------------
-- PRIORITY 1 : BOSS
--------------------------------------------------
local boss = GetBoss()
if boss then
repeat task.wait()

    O.Kill(boss,true)
    BringEnemy(boss)

until not boss
or not boss.Parent
or not O.Alive(boss)
or not _G.Auto_Cake_Prince
return
end

--------------------------------------------------
-- PRIORITY 2 : MIRROR
--------------------------------------------------
local BigMirror =
Workspace:FindFirstChild("Map")
and Workspace.Map:FindFirstChild("CakeLoaf")
and Workspace.Map.CakeLoaf:FindFirstChild("BigMirror")

if BigMirror
and BigMirror:FindFirstChild("Other")
and BigMirror.Other.Transparency==0 then

if (HRP.Position-Vector3.new(-1990,4533,-14973)).Magnitude>2000 then
_tp(MIRROR_TP)
return
end
end

--------------------------------------------------
-- PRIORITY 3 : QUEST
--------------------------------------------------
if _G.AcceptQuestC and QuestGui and not QuestGui.Visible then
if (HRP.Position-QUEST_POS.Position).Magnitude>50 then
_tp(QUEST_POS)
return
end

CommF:InvokeServer("StartQuest","CakeQuest2",2)
return
end

--------------------------------------------------
-- PRIORITY 4 : SPAWNER
--------------------------------------------------
if tick()-LastSpawner>SpawnerCD then
local res = CommF:InvokeServer("CakePrinceSpawner")
local num = tonumber(string.match(res or "","%d+"))

if num==0 then
CommF:InvokeServer("CakePrinceSpawner",true)
end

LastSpawner = tick()
end

--------------------------------------------------
-- PRIORITY 5 : FARM MINIONS (CLEAR TYPE BY TYPE)
--------------------------------------------------
for _,name in ipairs(Minions) do

    while _G.Auto_Cake_Prince do
        
        -- boss interrupt realtime
        local bossCheck = GetBoss()
        if bossCheck then return end
        
        local enemy = GetEnemyByName(name)
        if not enemy then
            break -- hết loại này → sang loại khác
        end
        
        repeat task.wait()
            
            -- boss interrupt khi đang đánh
            local bossCheck2 = GetBoss()
            if bossCheck2 then return end
            
            O.Kill(enemy,true)
            BringEnemy(enemy)
            
        until not enemy
        or not enemy.Parent
        or not O.Alive(enemy)
        or not _G.Auto_Cake_Prince
        
    end

end

--------------------------------------------------
-- PRIORITY 6 : IDLE POSITION
--------------------------------------------------
_tp(CFrame.new(-2091.91,70.01,-12142.84))

end)
end
end)


-- Farm Bone Logic
local BoneEnemies = {"Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"}

--// FARM BONE THREAD
task.spawn(function()
    while task.wait(Sec) do
        if not _G.AutoFarm_Bone then continue end

        pcall(function()
            local Character = plr.Character
            local HRP = Character and Character:FindFirstChild("HumanoidRootPart")
            local QuestGui = plr.PlayerGui.Main.Quest
            if not HRP then return end

            for _, enemyName in ipairs(BoneEnemies) do
                if not _G.AutoFarm_Bone then break end

                -- CHỈ LẤY 1 ENEMY → GIẾT XONG → MỚI LẤY ENEMY KHÁC
                while _G.AutoFarm_Bone do
                    local enemy = GetEnemyByName(enemyName)
                    if not enemy then
                        break -- Hết quái tên này → sang tên tiếp
                    end

                    -- Accept Quest nếu cần
                    if _G.AcceptQuestC and not QuestGui.Visible then
                        local questPos = CFrame.new(-9516.99316, 172.017181, 6078.46533)
                        _tp(questPos)
                        repeat task.wait(0.2) until (questPos.Position - HRP.Position).Magnitude < 50

                        local questList = {
                            {"StartQuest", "HauntedQuest2", 2},
                            {"StartQuest", "HauntedQuest2", 1},
                            {"StartQuest", "HauntedQuest1", 1},
                            {"StartQuest", "HauntedQuest1", 2},
                        }
                        CommF:InvokeServer(unpack(questList[math.random(1, #questList)]))
                    end

             
                    local brought = false

                    repeat
                      task.wait()
                      O.Kill(enemy,true)
                      BringEnemy(enemy)
                    until enemy.Humanoid.Health <= 0
                        or not enemy.Parent
                        or not _G.AutoFarm_Bone
                        or (_G.AcceptQuestC and not QuestGui.Visible)
                    repeat task.wait() until not enemy.Parent or enemy.Humanoid.Health <= 0
                end
            end
            _tp(CFrame.new(-9495.68, 453.58, 5977.34))
        end)
    end
end)


local PhaBinhPoints = {
    CFrame.new(-16332.526, 158.072, 1440.325),
    CFrame.new(-16288.609, 158.167, 1470.368),
    CFrame.new(-16245.412, 158.437, 1463.366),
    CFrame.new(-16212.469, 158.167, 1466.344),
    CFrame.new(-16211.946, 158.072, 1322.398),
    CFrame.new(-16260.922, 154.921, 1323.616),
    CFrame.new(-16297.060, 159.323, 1317.224),
    CFrame.new(-16335.097, 159.334, 1324.886),
}

local MobNeedEyes = {
    ["Serpent Hunter"] = true,
    ["Skull Slayer"] = true,
    ["Isle Champion"] = true,
    ["Sun-kissed Warrior"] = true
}

local CONFIG = {
    TyrantCheckInterval = 1,
    PointWaitTime = 2,
    SkillDelay = 1,
    PointReachedDistance = 3,
    FallbackPoint = CFrame.new(-16268.287, 152.616, 1390.773)
}

-- ================== UTILS ==================
local function IsAlive(char)
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    return hum and hrp and hum.Health > 0
end

local function FindTyrant(enemies)
    if not enemies then return nil end
    
    for _, enemy in ipairs(enemies:GetChildren()) do
        if enemy.Name == "Tyrant of the Skies" then
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                return enemy
            end
        end
    end
    return nil
end

local function FindFarmableEnemy(enemies)
    if not enemies then return nil end
    
    for _, enemy in ipairs(enemies:GetChildren()) do
        if MobNeedEyes[enemy.Name] then
            local hum = enemy:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                return enemy
            end
        end
    end
    return nil
end

local function UseAllSkills()
    local skills = {
        {"Melee", "Z"}, {"Melee", "X"}, {"Melee", "C"},
        {"Blox Fruit", "Z"}, {"Blox Fruit", "X"}, {"Blox Fruit", "C"},{"Blox Fruit", "V"},
        {"Sword", "Z"}, {"Sword", "X"}

    }
    
    for _, skill in ipairs(skills) do
        if not _G.FarmTyrant then break end
        Useskills(skill[1], skill[2])
        task.wait(CONFIG.SkillDelay)
    end
end

local function TeleportToPoint(hrp, point)
    if not _tp then return false end
    
    _tp(point)
    
    -- Chờ đến khi đến nơi (KHÔNG dùng skill trong lúc di chuyển)
    local startTime = tick()
    while (hrp.Position - point.Position).Magnitude >= CONFIG.PointReachedDistance do
        if not _G.FarmTyrant or tick() - startTime > 30 then break end
        task.wait(0.1)
    end
    
    return true
end

local function HandleTyrant(Tyrant)
    if not Tyrant then return false end
    BringEnemy(Tyrant)
    O.Kill(Tyrant, true)
    return true
end

local function FarmForEyes(enemies)
    local enemy = FindFarmableEnemy(enemies)
    if enemy then
        BringEnemy(enemy)
        O.Kill(enemy, true)
        return true
    end
    
    -- Không tìm thấy quái → đứng chờ
    if _tp then
        _tp(CONFIG.FallbackPoint)
    end
    return false
end

local function BreakVases(enemies, hrp)
    for _, point in ipairs(PhaBinhPoints) do
        if not _G.FarmTyrant then return end
        
        -- Kiểm tra Tyrant trước khi teleport
        local Tyrant = FindTyrant(enemies)
        if Tyrant then
            return HandleTyrant(Tyrant)
        end
        
        -- Teleport đến vị trí (không dùng skill)
        TeleportToPoint(hrp, point)
        
        -- ĐÃ ĐẾN NƠI → BẮT ĐẦU DÙNG SKILL
        local waitStart = tick()
        while tick() - waitStart < CONFIG.PointWaitTime and _G.FarmTyrant do
            local TyrantCheck = FindTyrant(enemies)
            if TyrantCheck then
                return HandleTyrant(TyrantCheck)
            end
            
            -- Dùng skill khi đang chờ tại vị trí
            UseAllSkills()
            task.wait(CONFIG.TyrantCheckInterval)
        end
    end
end

task.spawn(function()
    while task.wait(Sec) do
        if not _G.FarmTyrant then continue end
        
        pcall(function()
            local plr = game.Players.LocalPlayer
            local char = plr.Character
            
            if not IsAlive(char) then return end
            
            local hrp = char.HumanoidRootPart
            local enemies = workspace:FindFirstChild("Enemies")
            
            if not enemies then return end
            
            local Eyes = CheckEyes()
            local Tyrant = FindTyrant(enemies)
            
            -- ================== CASE 1: CÓ TYRANT ==================
            if Tyrant then
                HandleTyrant(Tyrant)
                return
            end
            
            -- ================== CASE 2: CHƯA CÓ TYRANT ==================
            if Eyes < 4 then
                -- Chưa đủ Eyes → Farm quái
                FarmForEyes(enemies)
            else
                -- Đủ Eyes → Phá bình
                BreakVases(enemies, hrp)
            end
        end)
    end
end)
spawn(function()
  while wait() do
    pcall(function()
      if _G.AutoFarmNear then
        for e, A in pairs(workspace.Enemies:GetChildren()) do
          if A:FindFirstChild("Humanoid") or A:FindFirstChild("HumanoidRootPart") then
            if A.Humanoid.Health > 0 then
              repeat
                wait();
                BringEnemy(A)
                O.Kill(A, _G.AutoFarmNear);
              until not _G.AutoFarmNear or not A.Parent or A.Humanoid.Health <= 0;
            end;
          end;
        end;
      end;
    end);
  end;
end);

local AcceptQuest_T = Tabs.Main:AddToggle("AcceptQuest_T", {Title = "Accept Quest [Cake/Bone]", Description = "", Default = false})
AcceptQuest_T:OnChanged(function(e)
      _G.AcceptQuestC = e
end)

local MasteryFram_S = Tabs.Main:AddSection("Mastery")
local ModeFramMastery = {"Level","Cake","Bone"}
local SelectModeMastery = Tabs.Main:AddDropdown("SelectModeMastery",{Title = "Select Mode Fram Mastery:",Values = ModeFramMastery,Multi = false,Default = 1})
SelectModeMastery:OnChanged(function(Value)
  _G.FarmMastery_Dev = Value
end)
spawn(function()
  RunSer.RenderStepped:Connect(function()
    pcall(function()
      if _G.FarmMastery_Dev or _G.FarmMastery_G or _G.FarmMastery_S then
        for e, A in pairs(plr.PlayerGui.Notifications:GetChildren()) do
          if A.Name == "NotificationTemplate" then
            if string.find(A.Text, "Skill locked!") then
              A:Destroy();
            end;
          end;
        end;
      end;
    end);
  end);
end);

Tabs.Settings:AddSection("Settings / Configure")
local _Weapon = {"Melee","Sword","Blox Fruit","Gun"}
local Weapon_Config = Tabs.Settings:AddDropdown("Weapon_Config",{Title = "Select Weapon",Values = _Weapon,Multi = false,Default = 1})
Weapon_Config:OnChanged(function(Value)
  _G.ChooseWP = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if _G.ChooseWP == "Melee" then
        for _,v in pairs(plr.Backpack:GetChildren()) do
        if v.ToolTip == "Melee" then
        if plr.Backpack:FindFirstChild(tostring(v.Name)) then
            _G.SelectWeapon = v.Name              
            end
          end
        end
      elseif _G.ChooseWP == "Sword" then     
      for _,v in pairs(plr.Backpack:GetChildren()) do
        if v.ToolTip == "Sword" then
        if plr.Backpack:FindFirstChild(tostring(v.Name)) then
          _G.SelectWeapon = v.Name              
            end
          end
        end
      elseif _G.ChooseWP == "Gun" then     
       for _,v in pairs(plr.Backpack:GetChildren()) do
         if v.ToolTip == "Gun" then
        if plr.Backpack:FindFirstChild(tostring(v.Name)) then
          _G.SelectWeapon = v.Name              
            end
          end
        end
      elseif _G.ChooseWP == "Blox Fruit" then     
      for _,v in pairs(plr.Backpack:GetChildren()) do
        if v.ToolTip == "Blox Fruit" then
        if plr.Backpack:FindFirstChild(tostring(v.Name)) then
          _G.SelectWeapon = v.Name                        
            end
          end
        end        
      end
    end)
  end
end)

local Initialize = Tabs.Settings:AddToggle("Initialize", {Title = "Initialize Attack [M1/Melee/Sword]", Description = "[ Not Supported Gas M1 ]", Default = true})
Initialize:OnChanged(function(Value)
  _G.Seriality = Value
end)
local Bringmob = Tabs.Settings:AddToggle("Bringmob", {Title = "Bring Mobs", Description = "", Default = true})
Bringmob:OnChanged(function(Value)
  _B = Value
end)
local BusuAura = Tabs.Settings:AddToggle("BusuAura", {Title = "Auto Turn on Buso", Description = "", Default = true})
BusuAura:OnChanged(function(Value)
  Boud = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if Boud then
      local _HasBuso = {"HasBuso","Buso"}
      if not plr.Character:FindFirstChild(_HasBuso[1]) then replicated.Remotes.CommF_:InvokeServer(_HasBuso[2]) end
      end
    end)
  end
end)

local RaceV3Aura = Tabs.Settings:AddToggle("RaceV3Aura", {Title = "Auto Turn on Race V3", Description = "", Default = false})
RaceV3Aura:OnChanged(function(Value)
  _G.RaceClickAutov3 = Value
end)
spawn(function()
  while wait(.2) do
    pcall(function()
      if _G.RaceClickAutov3 then
        repeat
          replicated.Remotes.CommE:FireServer("ActivateAbility") 
          wait(30)
        until not _G.RaceClickAutov3   
      end 
    end)
  end
end)
local RaceV4Aura = Tabs.Settings:AddToggle("RaceV4Aura", {Title = "Auto Turn on Race V4", Description = "", Default = false})
RaceV4Aura:OnChanged(function(Value)
  _G.RaceClickAutov4 = Value
end)
spawn(function()
  while wait(.2) do
    pcall(function()
      if _G.RaceClickAutov4 then
        if plr.Character:FindFirstChild("RaceEnergy") then
        if plr.Character:FindFirstChild("RaceEnergy").Value == 1 then Useskills("nil","Y") end
        end        
      end 
    end)
  end
end)
local RandomAround = Tabs.Settings:AddToggle("RandomAround", {Title = "Auto Turn on Spin Position", Description = "", Default = false})
RandomAround:OnChanged(function(Value)
  RandomCFrame = Value
end)
local Byp = Tabs.Settings:AddToggle("Byp", {Title = "Turn on Bypass Teleport", Description = "", Default = false})
Byp:OnChanged(function(Value)
  _G.Bypass = Value
end)
local SafeModes = Tabs.Settings:AddToggle("SafeModes", {Title = "Panic Mode", Description = "turn on for safe ur health if low", Default = false})
SafeModes:OnChanged(function(Value)
  _G.Safemode = Value
end)
spawn(function()
  while task.wait(Sec) do
    pcall(function()
    if _G.Safemode then
      local Calc_Health = plr.Character.Humanoid.Health / plr.Character.Humanoid.MaxHealth * 100
      if Calc_Health < Num_self then shouldTween=true _tp(Root.CFrame * CFrame.new(0,500,0)) else shouldTween=false end
      end
    end)
  end
end)
local UnDetectedAFK = Tabs.Settings:AddToggle("UnDetectedAFK", {Title = "Anti AFK", Description = "", Default = true})
UnDetectedAFK:OnChanged(function(Value)
  _G.AntiAFK = Value
end)
plr.Idled:connect(function()
  vim2:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
  wait(1)
  vim2:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
local DisblesVFX = Tabs.Settings:AddToggle("DisblesVFX", {Title = "Remove Hit VFX", Description = "", Default = false})
DisblesVFX:OnChanged(function(Value)
  _G.DistroyHit = Value
end)
spawn(function()
  while wait(Sec) do
    if _G.DistroyHit then
      pcall(function()
        local __Efeect = {"SlashHit","CurvedRing","SwordSlash","SlashTail"}
        for _,x in pairs(workspace["_WorldOrigin"]:GetChildren()) do
        if table.find(__Effect, x.Name) then x:Destroy() end
        end
      end)
    end
  end
end)
local DisblesVFX = Tabs.Settings:AddToggle("DisblesVFX", {Title = "Remove Death & Respawned VFX", Description = "", Default = false})
DisblesVFX:OnChanged(function(Value)
  RDeath = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if RDeath then
    if replicated.Effect.Container:FindFirstChild("Death") then replicated.Effect.Container.Death:Destroy() end
      if replicated.Effect.Container:FindFirstChild("Respawn") then replicated.Effect.Container.Respawn:Destroy() end
    end
    end)
  end
end)  
local DisblesVFX = Tabs.Settings:AddToggle("DisblesVFX", {Title = "Disable Notify", Description = "", Default = false})
DisblesVFX:OnChanged(function(Value)
  RemoveDamage = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
      if RemoveDamage then
        replicated.Assets.GUI.DamageCounter.Enabled = false
        plr.PlayerGui.Notifications.Enabled = false
    else
        replicated.Assets.GUI.DamageCounter.Enabled = true
        plr.PlayerGui.Notifications.Enabled = true
      end
    end)
  end
end)      

Tabs.Settings:AddSection("Stats Upgrade")
local StatusSelect = Tabs.Settings:AddSlider("StatusSelect",{Title = "Stats Value",Description = "",Default = 10,Min = 0,Max = 1000,Rounding = 1, 
Callback = function(Value)
  pSats = Value
end})
StatusSelect:OnChanged(function(Value)
  pSats = Value
end)

local StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {Title = "Auto Melee", Description = "", Default = false})
StatsUpg:OnChanged(function(Value)
  _G.Auto_Melee = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Melee then statsSetings("Melee",pSats) end
    end)
  end
end)

local StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {Title = "Auto Swords", Description = "", Default = false})
StatsUpg:OnChanged(function(Value)
  _G.Auto_Sword = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Sword then statsSetings("Sword",pSats) end
    end)
  end
end)
local StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {Title = "Auto Gun", Description = "", Default = false})
StatsUpg:OnChanged(function(Value)
  _G.Auto_Gun = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Gun then statsSetings("Gun",pSats) end
    end)
  end
end)
local StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {Title = "Auto Blox Fruit", Description = "", Default = false})
StatsUpg:OnChanged(function(Value)
  _G.Auto_DevilFruit = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_DevilFruit then statsSetings("Devil",pSats) end
    end)
  end
end)
local StatsUpg = Tabs.Settings:AddToggle("StatsUpg", {Title = "Auto Defense", Description = "", Default = false})
StatsUpg:OnChanged(function(Value)
  _G.Auto_Defense = Value
end)
spawn(function()
  while wait(Sec) do
    pcall(function()
    if _G.Auto_Defense then statsSetings("Defense",pSats) end
    end)
  end
end)
