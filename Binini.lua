local v14 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
local v15 = v14:CreateWindow({
    Title = "Hiu Hub",
    SubTitle = "By hiuvc",
    TabWidth = 160,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 350),
    MinimizeKey = Enum.KeyCode.LeftControl
});
local v16 = {
    Server_Status = v15:AddTab({
        Title = "Server-Status"
    }),
    Status = v15:AddTab({
        Title = "Server"
    }),
    Main = v15:AddTab({
        Title = "Framing"
    }),
    Sea = v15:AddTab({
        Title = "Sea Events"
    }),
    ITM = v15:AddTab({
        Title = "Item"
    }),
    Setting = v15:AddTab({
        Title = "Settings"
    }),
    Stats = v15:AddTab({
        Title = "Stats"
    }),
    Player = v15:AddTab({
        Title = "Player"
    }),
    Teleport = v15:AddTab({
        Title = "Teleport"
    }),
    Fruit = v15:AddTab({
        Title = "Fruit"
    }),
    Raid = v15:AddTab({
        Title = "Raid"
    }),
    Race = v15:AddTab({
        Title = "Race"
    }),
    Shop = v15:AddTab({
        Title = "Shop"
    }),
    EPS = v15:AddTab({
        Title = "EPS"
    }),
    Misc = v15:AddTab({
        Title = "Mic"
    })
};
local v17 = v14.Options;
do
local v22 = Instance.new("ScreenGui");
local v23 = Instance.new("ImageButton");
local v24 = Instance.new("UICorner");
local v25 = Instance.new("ParticleEmitter");
local v26 = game:GetService("TweenService");
v22.Parent = game.CoreGui;
v22.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
v23.Parent = v22;
v23.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v23.BorderSizePixel = 0;
v23.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0);
v23.Size = UDim2.new(0, 50, 0, 50);
v23.Draggable = true;
v23.Image = "http://www.roblox.com/asset/?id=133979080007875";
v24.Parent = v23;
v24.CornerRadius = UDim.new(0, 12);
v25.Parent = v23;
v25.LightEmission = 1;
v25.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.1),
    NumberSequenceKeypoint.new(1, 0)
});
v25.Lifetime = NumberRange.new(0.5, 1);
v25.Rate = 0;
v25.Speed = NumberRange.new(5, 10);
v25.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255));
local v47 = v26:Create(v23, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Rotation = 360
});
v23.MouseButton1Down:Connect(function()
    v25.Rate = 100;
    task.delay(1, function()
        v25.Rate = 0;
    end);
    v47:Play();
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game);
    v47.Completed:Connect(function()
        v23.Rotation = 0;
    end);
    local v235 = v26:Create(v23, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 60, 0, 60)
    });
    v235:Play();
    v235.Completed:Connect(function()
        local v483 = v26:Create(v23, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 50, 0, 50)
        });
        v483:Play();
    end);
end);
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Death") then
    game:GetService("ReplicatedStorage").Effect.Container.Death:Destroy();
end
if game:GetService("ReplicatedStorage").Effect.Container:FindFirstChild("Respawn") then
    game:GetService("ReplicatedStorage").Effect.Container.Respawn:Destroy();
end

if (game.PlaceId == 2753915549) then
    World1 = true;
elseif (game.PlaceId == 4442272183) then
    World2 = true;
elseif (game.PlaceId == 7449423635) then
    World3 = true;
end
function CheckQuest()
    MyLevel = game:GetService("Players").LocalPlayer.Data.Level.Value;
    if World1 then
        if ((MyLevel == 1) or (MyLevel <= 9)) then
            Mon = "Bandit";
            LevelQuest = 1;
            NameQuest = "BanditQuest1";
            NameMon = "Bandit";
            CFrameQuest = CFrame.new(1059, 17, 1546);
            CFrameMon = CFrame.new(943, 45, 1562);
        elseif ((MyLevel == 10) or (MyLevel <= 14)) then
            Mon = "Monkey";
            LevelQuest = 1;
            NameQuest = "JungleQuest";
            NameMon = "Monkey";
            CFrameQuest = CFrame.new( -1598, 37, 153);
            CFrameMon = CFrame.new( -1524, 50, 37);
        elseif ((MyLevel == 15) or (MyLevel <= 29)) then
            Mon = "Gorilla";
            LevelQuest = 2;
            NameQuest = "JungleQuest";
            NameMon = "Gorilla";
            CFrameQuest = CFrame.new( -1598, 37, 153);
            CFrameMon = CFrame.new( -1128, 40, -451);
        elseif ((MyLevel == 30) or (MyLevel <= 39)) then
            Mon = "Pirate";
            LevelQuest = 1;
            NameQuest = "BuggyQuest1";
            NameMon = "Pirate";
            CFrameQuest = CFrame.new( -1140, 4, 3829);
            CFrameMon = CFrame.new( -1262, 40, 3905);
        elseif ((MyLevel == 40) or (MyLevel <= 59)) then
            Mon = "Brute";
            LevelQuest = 2;
            NameQuest = "BuggyQuest1";
            NameMon = "Brute";
            CFrameQuest = CFrame.new( -1140, 4, 3829);
            CFrameMon = CFrame.new( -976, 55, 4304);
        elseif ((MyLevel == 60) or (MyLevel <= 74)) then
            Mon = "Desert Bandit";
            LevelQuest = 1;
            NameQuest = "DesertQuest";
            NameMon = "Desert Bandit";
            CFrameQuest = CFrame.new(897, 6, 4389);
            CFrameMon = CFrame.new(924, 7, 4482);
        elseif ((MyLevel == 75) or (MyLevel <= 89)) then
            Mon = "Desert Officer";
            LevelQuest = 2;
            NameQuest = "DesertQuest";
            NameMon = "Desert Officer";
            CFrameQuest = CFrame.new(897, 6, 4389);
            CFrameMon = CFrame.new(1608, 9, 4371);
        elseif ((MyLevel == 90) or (MyLevel <= 99)) then
            Mon = "Snow Bandit";
            LevelQuest = 1;
            NameQuest = "SnowQuest";
            NameMon = "Snow Bandit";
            CFrameQuest = CFrame.new(1385, 87, -1298);
            CFrameMon = CFrame.new(1362, 120, -1531);
        elseif ((MyLevel == 100) or (MyLevel <= 119)) then
            Mon = "Snowman";
            LevelQuest = 2;
            NameQuest = "SnowQuest";
            NameMon = "Snowman";
            CFrameQuest = CFrame.new(1385, 87, -1298);
            CFrameMon = CFrame.new(1243, 140, -1437);
        elseif ((MyLevel == 120) or (MyLevel <= 149)) then
            Mon = "Chief Petty Officer";
            LevelQuest = 1;
            NameQuest = "MarineQuest2";
            NameMon = "Chief Petty Officer";
            CFrameQuest = CFrame.new( -5035, 29, 4326);
            CFrameMon = CFrame.new( -4881, 23, 4274);
        elseif ((MyLevel == 150) or (MyLevel <= 174)) then
            Mon = "Sky Bandit";
            LevelQuest = 1;
            NameQuest = "SkyQuest";
            NameMon = "Sky Bandit";
            CFrameQuest = CFrame.new( -4844, 718, -2621);
            CFrameMon = CFrame.new( -4953, 296, -2899);
        elseif ((MyLevel == 175) or (MyLevel <= 189)) then
            Mon = "Dark Master";
            LevelQuest = 2;
            NameQuest = "SkyQuest";
            NameMon = "Dark Master";
            CFrameQuest = CFrame.new( -4844, 718, -2621);
            CFrameMon = CFrame.new( -5260, 391, -2229);
        elseif ((MyLevel == 190) or (MyLevel <= 209)) then
            Mon = "Prisoner";
            LevelQuest = 1;
            NameQuest = "PrisonerQuest";
            NameMon = "Prisoner";
            CFrameQuest = CFrame.new(5306, 2, 477);
            CFrameMon = CFrame.new(5099, "-0", 474);
        elseif ((MyLevel == 210) or (MyLevel <= 249)) then
            Mon = "Dangerous Prisoner";
            LevelQuest = 2;
            NameQuest = "PrisonerQuest";
            NameMon = "Dangerous Prisoner";
            CFrameQuest = CFrame.new(5306, 2, 477);
            CFrameMon = CFrame.new(5655, 16, 866);
        elseif ((MyLevel == 250) or (MyLevel <= 299)) then
            Mon = "Toga Warrior";
            LevelQuest = 1;
            NameQuest = "ColosseumQuest";
            NameMon = "Toga Warrior";
            CFrameQuest = CFrame.new( -1581, 7, -2982);
            CFrameMon = CFrame.new( -1820, 51, -2741);
        elseif ((MyLevel == 300) or (MyLevel <= 324)) then
            Mon = "Military Soldier";
            LevelQuest = 1;
            NameQuest = "MagmaQuest";
            NameMon = "Military Soldier";
            CFrameQuest = CFrame.new( -5319, 12, 8515);
            CFrameMon = CFrame.new( -5335, 46, 8638);
        elseif ((MyLevel == 325) or (MyLevel <= 374)) then
            Mon = "Military Spy";
            LevelQuest = 2;
            NameQuest = "MagmaQuest";
            NameMon = "Military Spy";
            CFrameQuest = CFrame.new( -5319, 12, 8515);
            CFrameMon = CFrame.new( -5803, 86, 8829);
        elseif ((MyLevel == 375) or (MyLevel <= 399)) then
            Mon = "Fishman Warrior";
            LevelQuest = 1;
            NameQuest = "FishmanQuest";
            NameMon = "Fishman Warrior";
            CFrameQuest = CFrame.new(61122, 18, 1567);
            CFrameMon = CFrame.new(60998, 50, 1534);
        elseif ((MyLevel == 400) or (MyLevel <= 449)) then
            Mon = "Fishman Commando";
            LevelQuest = 2;
            NameQuest = "FishmanQuest";
            NameMon = "Fishman Commando";
            CFrameQuest = CFrame.new(61122, 18, 1567);
            CFrameMon = CFrame.new(61866, 55, 1655);
        elseif ((MyLevel == 450) or (MyLevel <= 474)) then
            Mon = "God's Guard";
            LevelQuest = 1;
            NameQuest = "SkyExp1Quest";
            NameMon = "God's Guard";
            CFrameQuest = CFrame.new( -4720, 846, -1951);
            CFrameMon = CFrame.new( -4720, 846, -1951);
        elseif ((MyLevel == 475) or (MyLevel <= 524)) then
            Mon = "Shanda";
            LevelQuest = 2;
            NameQuest = "SkyExp1Quest";
            NameMon = "Shanda";
            CFrameQuest = CFrame.new( -7861, 5545, -381);
            CFrameMon = CFrame.new( -7741, 5580, -395);
        elseif ((MyLevel == 525) or (MyLevel <= 549)) then
            Mon = "Royal Squad";
            LevelQuest = 1;
            NameQuest = "SkyExp2Quest";
            NameMon = "Royal Squad";
            CFrameQuest = CFrame.new( -7903, 5636, -1412);
            CFrameMon = CFrame.new( -7727, 5650, -1410);
        elseif ((MyLevel == 550) or (MyLevel <= 624)) then
            Mon = "Royal Soldier";
            LevelQuest = 2;
            NameQuest = "SkyExp2Quest";
            NameMon = "Royal Soldier";
            CFrameQuest = CFrame.new( -7903, 5636, -1412);
            CFrameMon = CFrame.new( -7894, 5640, -1629);
        elseif ((MyLevel == 625) or (MyLevel <= 649)) then
            Mon = "Galley Pirate";
            LevelQuest = 1;
            NameQuest = "FountainQuest";
            NameMon = "Galley Pirate";
            CFrameQuest = CFrame.new(5258, 39, 4052);
            CFrameMon = CFrame.new(5391, 70, 4023);
        elseif (MyLevel >= 650) then
            Mon = "Galley Captain";
            LevelQuest = 2;
            NameQuest = "FountainQuest";
            NameMon = "Galley Captain";
            CFrameQuest = CFrame.new(5258, 39, 4052);
            CFrameMon = CFrame.new(5985, 70, 4790);
        end
    elseif World2 then
        if ((MyLevel == 700) or (MyLevel <= 724)) then
            Mon = "Raider";
            LevelQuest = 1;
            NameQuest = "Area1Quest";
            NameMon = "Raider";
            CFrameQuest = CFrame.new( -427, 73, 1835);
            CFrameMon = CFrame.new( -614, 90, 2240);
        elseif ((MyLevel == 725) or (MyLevel <= 774)) then
            Mon = "Mercenary";
            LevelQuest = 2;
            NameQuest = "Area1Quest";
            NameMon = "Mercenary";
            CFrameQuest = CFrame.new( -427, 73, 1835);
            CFrameMon = CFrame.new( -867, 110, 1621);
        elseif ((MyLevel == 775) or (MyLevel <= 874)) then
            Mon = "Swan Pirate";
            LevelQuest = 1;
            NameQuest = "Area2Quest";
            NameMon = "Swan Pirate";
            CFrameQuest = CFrame.new(635, 73, 919);
            CFrameMon = CFrame.new(898.23, 73.00, 1311.18);
        elseif ((MyLevel == 875) or (MyLevel <= 899)) then
            Mon = "Marine Lieutenant";
            LevelQuest = 1;
            NameQuest = "MarineQuest3";
            NameMon = "Marine Lieutenant";
            CFrameQuest = CFrame.new( -2441, 73, -3219);
            CFrameMon = CFrame.new( -2552, 110, -3050);
        elseif ((MyLevel == 900) or (MyLevel <= 949)) then
            Mon = "Marine Captain";
            LevelQuest = 2;
            NameQuest = "MarineQuest3";
            NameMon = "Marine Captain";
            CFrameQuest = CFrame.new( -2441, 73, -3219);
            CFrameMon = CFrame.new( -1695, 110, -3299);
        elseif ((MyLevel == 950) or (MyLevel <= 974)) then
            Mon = "Zombie";
            LevelQuest = 1;
            NameQuest = "ZombieQuest";
            NameMon = "Zombie";
            CFrameQuest = CFrame.new( -5495, 48, -794);
            CFrameMon = CFrame.new( -5715, 90, -917);
        elseif ((MyLevel == 975) or (MyLevel <= 999)) then
            Mon = "Vampire";
            LevelQuest = 2;
            NameQuest = "ZombieQuest";
            NameMon = "Vampire";
            CFrameQuest = CFrame.new( -5495, 48, -794);
            CFrameMon = CFrame.new( -6027, 50, -1130);
        elseif ((MyLevel == 1000) or (MyLevel <= 1049)) then
            Mon = "Snow Trooper";
            LevelQuest = 1;
            NameQuest = "SnowMountainQuest";
            NameMon = "Snow Trooper";
            CFrameQuest = CFrame.new(607, 401, -5371);
            CFrameMon = CFrame.new(445, 440, -5175);
        elseif ((MyLevel == 1050) or (MyLevel <= 1099)) then
            Mon = "Winter Warrior";
            LevelQuest = 2;
            NameQuest = "SnowMountainQuest";
            NameMon = "Winter Warrior";
            CFrameQuest = CFrame.new(607, 401, -5371);
            CFrameMon = CFrame.new(1224, 460, -5332);
        elseif ((MyLevel == 1100) or (MyLevel <= 1124)) then
            Mon = "Lab Subordinate";
            LevelQuest = 1;
            NameQuest = "IceSideQuest";
            NameMon = "Lab Subordinate";
            CFrameQuest = CFrame.new( -6061, 16, -4904);
            CFrameMon = CFrame.new( -5941, 50, -4322);
        elseif ((MyLevel == 1125) or (MyLevel <= 1174)) then
            Mon = "Horned Warrior";
            LevelQuest = 2;
            NameQuest = "IceSideQuest";
            NameMon = "Horned Warrior";
            CFrameQuest = CFrame.new( -6061, 16, -4904);
            CFrameMon = CFrame.new( -6306, 50, -5752);
        elseif ((MyLevel == 1175) or (MyLevel <= 1199)) then
            Mon = "Magma Ninja";
            LevelQuest = 1;
            NameQuest = "FireSideQuest";
            NameMon = "Magma Ninja";
            CFrameQuest = CFrame.new( -5430, 16, -5298);
            CFrameMon = CFrame.new( -5233, 60, -6227);
        elseif ((MyLevel == 1200) or (MyLevel <= 1249)) then
            Mon = "Lava Pirate";
            LevelQuest = 2;
            NameQuest = "FireSideQuest";
            NameMon = "Lava Pirate";
            CFrameQuest = CFrame.new( -5430, 16, -5298);
            CFrameMon = CFrame.new( -4955, 60, -4836);
        elseif ((MyLevel == 1250) or (MyLevel <= 1274)) then
            Mon = "Ship Deckhand";
            LevelQuest = 1;
            NameQuest = "ShipQuest1";
            NameMon = "Ship Deckhand";
            CFrameQuest = CFrame.new(1033, 125, 32909);
            CFrameMon = CFrame.new(1033, 125, 32909);
        elseif ((MyLevel == 1275) or (MyLevel <= 1299)) then
            Mon = "Ship Engineer";
            LevelQuest = 2;
            NameQuest = "ShipQuest1";
            NameMon = "Ship Engineer";
            CFrameQuest = CFrame.new(1033, 125, 32909);
            CFrameMon = CFrame.new(809, 80, 33090);
        elseif ((MyLevel == 1300) or (MyLevel <= 1324)) then
            Mon = "Ship Steward";
            LevelQuest = 1;
            NameQuest = "ShipQuest2";
            NameMon = "Ship Steward";
            CFrameQuest = CFrame.new(973, 125, 33245);
            CFrameMon = CFrame.new(838, 160, 33408);
        elseif ((MyLevel == 1325) or (MyLevel <= 1349)) then
            Mon = "Ship Officer";
            LevelQuest = 2;
            NameQuest = "ShipQuest2";
            NameMon = "Ship Officer";
            CFrameQuest = CFrame.new(973, 125, 33245);
            CFrameMon = CFrame.new(1238, 220, 33148);
        elseif ((MyLevel == 1350) or (MyLevel <= 1374)) then
            Mon = "Arctic Warrior";
            LevelQuest = 1;
            NameQuest = "FrostQuest";
            NameMon = "Arctic Warrior";
            CFrameQuest = CFrame.new(5668, 28, -6484);
            CFrameMon = CFrame.new(5836, 80, -6257);
        elseif ((MyLevel == 1375) or (MyLevel <= 1424)) then
            Mon = "Snow Lurker";
            LevelQuest = 2;
            NameQuest = "FrostQuest";
            NameMon = "Snow Lurker";
            CFrameQuest = CFrame.new(5668, 28, -6484);
            CFrameMon = CFrame.new(5700, 80, -6724);
        elseif ((MyLevel == 1425) or (MyLevel <= 1449)) then
            Mon = "Sea Soldier";
            LevelQuest = 1;
            NameQuest = "ForgottenQuest";
            NameMon = "Sea Soldier";
            CFrameQuest = CFrame.new( -3056, 240, -10145);
            CFrameMon = CFrame.new( -2583, 80, -9821);
        elseif (MyLevel >= 1450) then
            Mon = "Water Fighter";
            LevelQuest = 2;
            NameQuest = "ForgottenQuest";
            NameMon = "Water Fighter";
            CFrameQuest = CFrame.new( -3056, 240, -10145);
            CFrameMon = CFrame.new( -3339, 290, -10412);
        end
    elseif World3 then
        if ((MyLevel == 1500) or (MyLevel <= 1524)) then
            Mon = "Pirate Millionaire";
            LevelQuest = 1;
            NameQuest = "PiratePortQuest";
            NameMon = "Pirate Millionaire";
            CFrameQuest = CFrame.new( -291, 44, 5580);
            CFrameMon = CFrame.new( -44, 70, 5623);
        elseif ((MyLevel == 1525) or (MyLevel <= 1574)) then
            Mon = "Pistol Billionaire";
            LevelQuest = 2;
            NameQuest = "PiratePortQuest";
            NameMon = "Pistol Billionaire";
            CFrameQuest = CFrame.new( -291, 44, 5580);
            CFrameMon = CFrame.new(219, 105, 6018);
        elseif ((MyLevel == 1575) or (MyLevel <= 1599)) then
            Mon = "Dragon Crew Warrior";
            LevelQuest = 1;
            NameQuest = "AmazonQuest";
            NameMon = "Dragon Crew Warrior";
            CFrameQuest = CFrame.new(5834, 51, -1103);
            CFrameMon = CFrame.new(5992, 90, -1581);
        elseif ((MyLevel == 1600) or (MyLevel <= 1624)) then
            Mon = "Dragon Crew Archer";
            NameQuest = "AmazonQuest";
            LevelQuest = 2;
            NameMon = "Dragon Crew Archer";
            CFrameQuest = CFrame.new(5834, 51, -1103);
            CFrameMon = CFrame.new(6472, 370, -151);
        elseif ((MyLevel == 1625) or (MyLevel <= 1649)) then
            Mon = "Female Islander";
            NameQuest = "AmazonQuest2";
            LevelQuest = 1;
            NameMon = "Female Islander";
            CFrameQuest = CFrame.new(5448, 602, 748);
            CFrameMon = CFrame.new(4836, 740, 928);
        elseif ((MyLevel == 1650) or (MyLevel <= 1699)) then
            Mon = "Giant Islander";
            NameQuest = "AmazonQuest2";
            LevelQuest = 2;
            NameMon = "Giant Islander";
            CFrameQuest = CFrame.new(5448, 602, 748);
            CFrameMon = CFrame.new(4784, 660, 155);
        elseif ((MyLevel == 1700) or (MyLevel <= 1724)) then
            Mon = "Marine Commodore";
            LevelQuest = 1;
            NameQuest = "MarineTreeIsland";
            NameMon = "Marine Commodore";
            CFrameQuest = CFrame.new(2180, 29, -6738);
            CFrameMon = CFrame.new(3156, 120, -7837);
        elseif ((MyLevel == 1725) or (MyLevel <= 1774)) then
            Mon = "Marine Rear Admiral";
            NameMon = "Marine Rear Admiral";
            NameQuest = "MarineTreeIsland";
            LevelQuest = 2;
            CFrameQuest = CFrame.new(2180, 29, -6738);
            CFrameMon = CFrame.new(3205, 120, -6742);
        elseif ((MyLevel == 1775) or (MyLevel <= 1799)) then
            Mon = "Fishman Raider";
            LevelQuest = 1;
            NameQuest = "DeepForestIsland3";
            NameMon = "Fishman Raider";
            CFrameQuest = CFrame.new( -10581, 332, -8758);
            CFrameMon = CFrame.new( -10550, 380, -8574);
        elseif ((MyLevel == 1800) or (MyLevel <= 1824)) then
            Mon = "Fishman Captain";
            LevelQuest = 2;
            NameQuest = "DeepForestIsland3";
            NameMon = "Fishman Captain";
            CFrameQuest = CFrame.new( -10581, 332, -8758);
            CFrameMon = CFrame.new( -10764, 380, -8799);
        elseif ((MyLevel == 1825) or (MyLevel <= 1849)) then
            Mon = "Forest Pirate";
            LevelQuest = 1;
            NameQuest = "DeepForestIsland";
            NameMon = "Forest Pirate";
            CFrameQuest = CFrame.new( -13233, 332, -7626);
            CFrameMon = CFrame.new( -13335, 380, -7660);
        elseif ((MyLevel == 1850) or (MyLevel <= 1899)) then
            Mon = "Mythological Pirate";
            LevelQuest = 2;
            NameQuest = "DeepForestIsland";
            NameMon = "Mythological Pirate";
            CFrameQuest = CFrame.new( -13233, 332, -7626);
            CFrameMon = CFrame.new( -13844, 520, -7016);
        elseif ((MyLevel == 1900) or (MyLevel <= 1924)) then
            Mon = "Jungle Pirate";
            LevelQuest = 1;
            NameQuest = "DeepForestIsland2";
            NameMon = "Jungle Pirate";
            CFrameQuest = CFrame.new( -12682, 391, -9901);
            CFrameMon = CFrame.new( -12166, 380, -10375);
        elseif ((MyLevel == 1925) or (MyLevel <= 1974)) then
            Mon = "Musketeer Pirate";
            LevelQuest = 2;
            NameQuest = "DeepForestIsland2";
            NameMon = "Musketeer Pirate";
            CFrameQuest = CFrame.new( -12682, 391, -9901);
            CFrameMon = CFrame.new( -13098, 450, -9831);
        elseif ((MyLevel == 1975) or (MyLevel <= 1999)) then
            Mon = "Reborn Skeleton";
            LevelQuest = 1;
            NameQuest = "HauntedQuest1";
            NameMon = "Reborn Skeleton";
            CFrameQuest = CFrame.new( -9481, 142, 5565);
            CFrameMon = CFrame.new( -8680, 190, 5852);
        elseif ((MyLevel == 2000) or (MyLevel <= 2024)) then
            Mon = "Living Zombie";
            LevelQuest = 2;
            NameQuest = "HauntedQuest1";
            NameMon = "Living Zombie";
            CFrameQuest = CFrame.new( -9481, 142, 5565);
            CFrameMon = CFrame.new( -10144, 140, 5932);
        elseif ((MyLevel == 2025) or (MyLevel <= 2049)) then
            Mon = "Demonic Soul";
            LevelQuest = 1;
            NameQuest = "HauntedQuest2";
            NameMon = "Demonic Soul";
            CFrameQuest = CFrame.new( -9515, 172, 607);
            CFrameMon = CFrame.new( -9275, 210, 6166);
        elseif ((MyLevel == 2050) or (MyLevel <= 2074)) then
            Mon = "Posessed Mummy";
            LevelQuest = 2;
            NameQuest = "HauntedQuest2";
            NameMon = "Posessed Mummy";
            CFrameQuest = CFrame.new( -9515, 172, 607);
            CFrameMon = CFrame.new( -9442, 60, 6304);
        elseif ((MyLevel == 2075) or (MyLevel <= 2099)) then
            Mon = "Peanut Scout";
            LevelQuest = 1;
            NameQuest = "NutsIslandQuest";
            NameMon = "Peanut Scout";
            CFrameQuest = CFrame.new( -2104, 38, -10194);
            CFrameMon = CFrame.new( -1870, 100, -10225);
        elseif ((MyLevel == 2100) or (MyLevel <= 2124)) then
            Mon = "Peanut President";
            LevelQuest = 2;
            NameQuest = "NutsIslandQuest";
            NameMon = "Peanut President";
            CFrameQuest = CFrame.new( -2104, 38, -10194);
            CFrameMon = CFrame.new( -2005, 100, -10585);
        elseif ((MyLevel == 2125) or (MyLevel <= 2149)) then
            Mon = "Ice Cream Chef";
            LevelQuest = 1;
            NameQuest = "IceCreamIslandQuest";
            NameMon = "Ice Cream Chef";
            CFrameQuest = CFrame.new( -818, 66, -10964);
            CFrameMon = CFrame.new( -501, 100, -10883);
        elseif ((MyLevel == 2150) or (MyLevel <= 2199)) then
            Mon = "Ice Cream Commander";
            LevelQuest = 2;
            NameQuest = "IceCreamIslandQuest";
            NameMon = "Ice Cream Commander";
            CFrameQuest = CFrame.new( -818, 66, -10964);
            CFrameMon = CFrame.new( -690, 100, -11350);
        elseif ((MyLevel == 2200) or (MyLevel <= 2224)) then
            Mon = "Cookie Crafter";
            LevelQuest = 1;
            NameQuest = "CakeQuest1";
            NameMon = "Cookie Crafter";
            CFrameQuest = CFrame.new( -2023, 38, -12028);
            CFrameMon = CFrame.new( -2332, 90, -12049);
        elseif ((MyLevel == 2225) or (MyLevel <= 2249)) then
            Mon = "Cake Guard";
            LevelQuest = 2;
            NameQuest = "CakeQuest1";
            NameMon = "Cake Guard";
            CFrameQuest = CFrame.new( -2023, 38, -12028);
            CFrameMon = CFrame.new( -1514, 90, -12422);
        elseif ((MyLevel == 2250) or (MyLevel <= 2274)) then
            Mon = "Baking Staff";
            LevelQuest = 1;
            NameQuest = "CakeQuest2";
            NameMon = "Baking Staff";
            CFrameQuest = CFrame.new( -1931, 38, -12840);
            CFrameMon = CFrame.new( -1930, 90, -12963);
        elseif ((MyLevel == 2275) or (MyLevel <= 2299)) then
            Mon = "Head Baker";
            LevelQuest = 2;
            NameQuest = "CakeQuest2";
            NameMon = "Head Baker";
            CFrameQuest = CFrame.new( -1931, 38, -12840);
            CFrameMon = CFrame.new( -2123, 110, -12777);
        elseif ((MyLevel == 2300) or (MyLevel <= 2324)) then
            Mon = "Cocoa Warrior";
            LevelQuest = 1;
            NameQuest = "ChocQuest1";
            NameMon = "Cocoa Warrior";
            CFrameQuest = CFrame.new(235, 25, -12199);
            CFrameMon = CFrame.new(110, 80, -12245);
        elseif ((MyLevel == 2325) or (MyLevel <= 2349)) then
            Mon = "Chocolate Bar Battler";
            LevelQuest = 2;
            NameQuest = "ChocQuest1";
            NameMon = "Chocolate Bar Battler";
            CFrameQuest = CFrame.new(235, 25, -12199);
            CFrameMon = CFrame.new(579, 80, -12413);
        elseif ((MyLevel == 2350) or (MyLevel <= 2374)) then
            Mon = "Sweet Thief";
            LevelQuest = 1;
            NameQuest = "ChocQuest2";
            NameMon = "Sweet Thief";
            CFrameQuest = CFrame.new(150, 25, -12777);
            CFrameMon = CFrame.new( -68, 80, -12692);
        elseif ((MyLevel == 2375) or (MyLevel <= 2399)) then
            Mon = "Candy Rebel";
            LevelQuest = 2;
            NameQuest = "ChocQuest2";
            NameMon = "Candy Rebel";
            CFrameQuest = CFrame.new(150, 25, -12777);
            CFrameMon = CFrame.new(17, 80, -12962);
        elseif ((MyLevel == 2400) or (MyLevel <= 2424)) then
            Mon = "Candy Pirate";
            LevelQuest = 1;
            NameQuest = "CandyQuest1";
            NameMon = "Candy Pirate";
            CFrameQuest = CFrame.new( -1148, 14, -14446);
            CFrameMon = CFrame.new( -1371, 70, -14405);
        elseif ((MyLevel == 2425) or (MyLevel <= 2449)) then
            Mon = "Snow Demon";
            LevelQuest = 2;
            NameQuest = "CandyQuest1";
            NameMon = "Snow Demon";
            CFrameQuest = CFrame.new( -1148, 14, -14446);
            CFrameMon = CFrame.new( -836, 70, -14326);
        elseif ((MyLevel == 2450) or (MyLevel <= 2474)) then
            Mon = "Isle Outlaw";
            LevelQuest = 1;
            NameQuest = "TikiQuest1";
            NameMon = "Isle Outlaw";
            CFrameQuest = CFrame.new( -16547, 56, -172);
            CFrameMon = CFrame.new( -16431, 90, -223);
        elseif ((MyLevel == 2475) or (MyLevel <= 2499)) then
            Mon = "Island Boy";
            LevelQuest = 2;
            NameQuest = "TikiQuest1";
            NameMon = "Island Boy";
            CFrameQuest = CFrame.new( -16547, 56, -172);
            CFrameMon = CFrame.new( -16668, 70, -243);
        elseif ((MyLevel == 2500) or (MyLevel <= 2524)) then
            Mon = "Sun-kissed Warrior";
            LevelQuest = 1;
            NameQuest = "TikiQuest2";
            NameMon = "kissed";
            CFrameQuest = CFrame.new( -16540, 56, 1051);
            CFrameMon = CFrame.new( -16345, 80, 1004);
        elseif ((MyLevel == 2525) or (MyLevel <= 2549)) then
            Mon = "Isle Champion";
            LevelQuest = 2;
            NameQuest = "TikiQuest2";
            NameMon = "Isle Champion";
            CFrameQuest = CFrame.new( -16540, 56, 1051);
            CFrameMon = CFrame.new( -16634, 85, 1106);
        elseif ((MyLevel == 2550) or (MyLevel <= 2574)) then
            Mon = "Serpent Hunter";
            LevelQuest = 1;
            NameQuest = "TikiQuest3";
            NameMon = "Serpent Hunter";
            CFrameQuest = CFrame.new( -16665, 105, 1580);
            CFrameMon = CFrame.new( -16542.4824, 146.675156, 1529.61401, -0.999948919, 1.0729811e-8, 0.0101067368, 1.0128324e-8, 1, -5.9564663e-8, -0.0101067368, -5.9459257e-8, -0.999948919);
        elseif ((MyLevel == 2575) or (MyLevel <= 2600)) then
            Mon = "Skull Slayer";
            LevelQuest = 2;
            NameQuest = "TikiQuest3";
            NameMon = "Skull Slayer";
            CFrameQuest = CFrame.new( -16665, 105, 1580);
            CFrameMon = CFrame.new( -16849.9336, 147.005066, 1640.88354, 0.470148534, 0.491874039, -0.732816696, 1.72165e-8, 0.83030504, 0.55730921, 0.882587314, -0.262018114, 0.390366673);
        end
    end
end
function Hop()
    local v404 = game.PlaceId;
    local v405 = {};
    local v406 = "";
    local v407 = os.date("!*t").hour;
    local v408 = false;
    function TPReturner()
        local v857;
        if (v406 == "") then
            v857 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"   .. v404   .. "/servers/Public?sortOrder=Asc&limit=100" ));
        else
            v857 = game.HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"   .. v404   .. "/servers/Public?sortOrder=Asc&limit=100&cursor="   .. v406 ));
        end
        local v858 = "";
        if (v857.nextPageCursor and (v857.nextPageCursor ~= "null") and (v857.nextPageCursor ~= nil)) then
            v406 = v857.nextPageCursor;
        end
        local v859 = 0;
        for v1841, v1842 in pairs(v857.data) do
            local v1843 = true;
            v858 = tostring(v1842.id);
            if (tonumber(v1842.maxPlayers) > tonumber(v1842.playing)) then
                for v2187, v2188 in pairs(v405) do
                    if (v859 ~= 0) then
                        if (v858 == tostring(v2188)) then
                            v1843 = false;
                        end
                    elseif (tonumber(v407) ~= tonumber(v2188)) then
                        local v2702 = pcall(function()
                            v405 = {};
                            table.insert(v405, v407);
                        end);
                    end
                    v859 = v859 + 1 ;
                end
                if (v1843 == true) then
                    table.insert(v405, v858);
                    wait();
                    pcall(function()
                        wait();
                        game:GetService("TeleportService"):TeleportToPlaceInstance(v404, v858, game.Players.LocalPlayer);
                    end);
                    wait(4);
                end
            end
        end
    end
    function Teleport()
        while wait() do
            pcall(function()
                TPReturner();
                if (v406 ~= "") then
                    TPReturner();
                end
            end);
        end
    end
    Teleport();
end
function UpdateIslandESP()
    for v860, v861 in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then
                if (v861.Name ~= "Sea") then
                    if  not v861:FindFirstChild("NameEsp") then
                        local v2499 = Instance.new("BillboardGui", v861);
                        v2499.Name = "NameEsp";
                        v2499.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2499.Size = UDim2.new(1, 200, 1, 30);
                        v2499.Adornee = v861;
                        v2499.AlwaysOnTop = true;
                        local v2505 = Instance.new("TextLabel", v2499);
                        v2505.Font = "GothamBold";
                        v2505.FontSize = "Size14";
                        v2505.TextWrapped = true;
                        v2505.Size = UDim2.new(1, 0, 1, 0);
                        v2505.TextYAlignment = "Top";
                        v2505.BackgroundTransparency = 1;
                        v2505.TextStrokeTransparency = 0.5;
                        v2505.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        v861['NameEsp'].TextLabel.Text = v861.Name   .. "   \n"   .. round((game:GetService("Players").LocalPlayer.Character.Head.Position - v861.Position).Magnitude / 3 )   .. " Distance" ;
                    end
                end
            elseif v861:FindFirstChild("NameEsp") then
                v861:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function isnil(v409)
    return v409 == nil ;
end
local function v56(v410)
    return math.floor(tonumber(v410) + 0.5 );
end
Number = math.random(1, 1000000);
function UpdatePlayerChams()
    for v862, v863 in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if  not isnil(v863.Character) then
                if ESPPlayer then
                    if ( not isnil(v863.Character.Head) and  not v863.Character.Head:FindFirstChild("NameEsp"   .. Number )) then
                        local v2515 = Instance.new("BillboardGui", v863.Character.Head);
                        v2515.Name = "NameEsp"   .. Number ;
                        v2515.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2515.Size = UDim2.new(1, 200, 1, 30);
                        v2515.Adornee = v863.Character.Head;
                        v2515.AlwaysOnTop = true;
                        local v2522 = Instance.new("TextLabel", v2515);
                        v2522.Font = Enum.Font.GothamSemibold;
                        v2522.FontSize = "Size14";
                        v2522.TextWrapped = true;
                        v2522.Text = v863.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v863.Character.Head.Position).Magnitude / 3 )   .. " Distance" ;
                        v2522.Size = UDim2.new(1, 0, 1, 0);
                        v2522.TextYAlignment = "Top";
                        v2522.BackgroundTransparency = 1;
                        v2522.TextStrokeTransparency = 0.5;
                        if (v863.Team == game.Players.LocalPlayer.Team) then
                            v2522.TextColor3 = Color3.new(0, 134, 139);
                        else
                            v2522.TextColor3 = Color3.new(0, 134, 139);
                        end
                    else
                        v863.Character.Head["NameEsp" .. Number].TextLabel.Text =
    v863.Name .. " | " ..
    v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v863.Character.Head.Position).Magnitude / 3) ..
    " Distance\nHealth: " ..
    v56((v863.Character.Humanoid.Health * 100) / v863.Character.Humanoid.MaxHealth) .. "%"

                    end
                elseif v863.Character.Head:FindFirstChild("NameEsp"   .. Number ) then
                    v863.Character.Head:FindFirstChild("NameEsp"   .. Number ):Destroy();
                end
            end
        end);
    end
end
function UpdateChestChams()
    for v864, v865 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(v865.Name, "Chest") then
                if ChestESP then
                    if string.find(v865.Name, "Chest") then
                        if  not v865:FindFirstChild("NameEsp"   .. Number ) then
                            local v2840 = Instance.new("BillboardGui", v865);
                            v2840.Name = "NameEsp"   .. Number ;
                            v2840.ExtentsOffset = Vector3.new(0, 1, 0);
                            v2840.Size = UDim2.new(1, 200, 1, 30);
                            v2840.Adornee = v865;
                            v2840.AlwaysOnTop = true;
                            local v2846 = Instance.new("TextLabel", v2840);
                            v2846.Font = Enum.Font.GothamSemibold;
                            v2846.FontSize = "Size14";
                            v2846.TextWrapped = true;
                            v2846.Size = UDim2.new(1, 0, 1, 0);
                            v2846.TextYAlignment = "Top";
                            v2846.BackgroundTransparency = 1;
                            v2846.TextStrokeTransparency = 0.5;
                            if (v865.Name == "Chest1") then
                                v2846.TextColor3 = Color3.fromRGB(109, 109, 109);
                                v2846.Text = "Chest 1"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v865.Position).Magnitude / 3 )   .. " Distance" ;
                            end
                            if (v865.Name == "Chest2") then
                                v2846.TextColor3 = Color3.fromRGB(173, 158, 21);
                                v2846.Text = "Chest 2"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v865.Position).Magnitude / 3 )   .. " Distance" ;
                            end
                            if (v865.Name == "Chest3") then
                                v2846.TextColor3 = Color3.fromRGB(85, 255, 255);
                                v2846.Text = "Chest 3"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v865.Position).Magnitude / 3 )   .. " Distance" ;
                            end
                        else
                            v865["NameEsp"   .. Number ].TextLabel.Text = v865.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v865.Position).Magnitude / 3 )   .. " Distance" ;
                        end
                    end
                elseif v865:FindFirstChild("NameEsp"   .. Number ) then
                    v865:FindFirstChild("NameEsp"   .. Number ):Destroy();
                end
            end
        end);
    end
end
function UpdateDevilChams()
    for v866, v867 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(v867.Name, "Fruit") then
                    if  not v867.Handle:FindFirstChild("NameEsp"   .. Number ) then
                        local v2533 = Instance.new("BillboardGui", v867.Handle);
                        v2533.Name = "NameEsp"   .. Number ;
                        v2533.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2533.Size = UDim2.new(1, 200, 1, 30);
                        v2533.Adornee = v867.Handle;
                        v2533.AlwaysOnTop = true;
                        local v2540 = Instance.new("TextLabel", v2533);
                        v2540.Font = Enum.Font.GothamSemibold;
                        v2540.FontSize = "Size14";
                        v2540.TextWrapped = true;
                        v2540.Size = UDim2.new(1, 0, 1, 0);
                        v2540.TextYAlignment = "Top";
                        v2540.BackgroundTransparency = 1;
                        v2540.TextStrokeTransparency = 0.5;
                        v2540.TextColor3 = Color3.fromRGB(255, 255, 255);
                        v2540.Text = v867.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v867.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                    else
                        v867.Handle["NameEsp"   .. Number ].TextLabel.Text = v867.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v867.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                    end
                end
            elseif v867.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v867.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end);
    end
end
function UpdateFlowerChams()
    for v868, v869 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if ((v869.Name == "Flower2") or (v869.Name == "Flower1")) then
                if FlowerESP then
                    if  not v869:FindFirstChild("NameEsp"   .. Number ) then
                        local v2552 = Instance.new("BillboardGui", v869);
                        v2552.Name = "NameEsp"   .. Number ;
                        v2552.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2552.Size = UDim2.new(1, 200, 1, 30);
                        v2552.Adornee = v869;
                        v2552.AlwaysOnTop = true;
                        local v2558 = Instance.new("TextLabel", v2552);
                        v2558.Font = Enum.Font.GothamSemibold;
                        v2558.FontSize = "Size14";
                        v2558.TextWrapped = true;
                        v2558.Size = UDim2.new(1, 0, 1, 0);
                        v2558.TextYAlignment = "Top";
                        v2558.BackgroundTransparency = 1;
                        v2558.TextStrokeTransparency = 0.5;
                        v2558.TextColor3 = Color3.fromRGB(255, 0, 0);
                        if (v869.Name == "Flower1") then
                            v2558.Text = "Blue Flower"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v869.Position).Magnitude / 3 )   .. " Distance" ;
                            v2558.TextColor3 = Color3.fromRGB(0, 0, 255);
                        end
                        if (v869.Name == "Flower2") then
                            v2558.Text = "Red Flower"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v869.Position).Magnitude / 3 )   .. " Distance" ;
                            v2558.TextColor3 = Color3.fromRGB(255, 0, 0);
                        end
                    else
                        v869["NameEsp"   .. Number ].TextLabel.Text = v869.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v869.Position).Magnitude / 3 )   .. " Distance" ;
                    end
                elseif v869:FindFirstChild("NameEsp"   .. Number ) then
                    v869:FindFirstChild("NameEsp"   .. Number ):Destroy();
                end
            end
        end);
    end
end
function UpdateRealFruitChams()
    for v870, v871 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v871:IsA("Tool") then
            if RealFruitESP then
                if  not v871.Handle:FindFirstChild("NameEsp"   .. Number ) then
                    local v2306 = Instance.new("BillboardGui", v871.Handle);
                    v2306.Name = "NameEsp"   .. Number ;
                    v2306.ExtentsOffset = Vector3.new(0, 1, 0);
                    v2306.Size = UDim2.new(1, 200, 1, 30);
                    v2306.Adornee = v871.Handle;
                    v2306.AlwaysOnTop = true;
                    local v2313 = Instance.new("TextLabel", v2306);
                    v2313.Font = Enum.Font.GothamSemibold;
                    v2313.FontSize = "Size14";
                    v2313.TextWrapped = true;
                    v2313.Size = UDim2.new(1, 0, 1, 0);
                    v2313.TextYAlignment = "Top";
                    v2313.BackgroundTransparency = 1;
                    v2313.TextStrokeTransparency = 0.5;
                    v2313.TextColor3 = Color3.fromRGB(255, 0, 0);
                    v2313.Text = v871.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v871.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                else
                    v871.Handle["NameEsp"   .. Number ].TextLabel.Text = v871.Name   .. " "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v871.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                end
            elseif v871.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v871.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end
    end
    for v872, v873 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v873:IsA("Tool") then
            if RealFruitESP then
                if  not v873.Handle:FindFirstChild("NameEsp"   .. Number ) then
                    local v2325 = Instance.new("BillboardGui", v873.Handle);
                    v2325.Name = "NameEsp"   .. Number ;
                    v2325.ExtentsOffset = Vector3.new(0, 1, 0);
                    v2325.Size = UDim2.new(1, 200, 1, 30);
                    v2325.Adornee = v873.Handle;
                    v2325.AlwaysOnTop = true;
                    local v2332 = Instance.new("TextLabel", v2325);
                    v2332.Font = Enum.Font.GothamSemibold;
                    v2332.FontSize = "Size14";
                    v2332.TextWrapped = true;
                    v2332.Size = UDim2.new(1, 0, 1, 0);
                    v2332.TextYAlignment = "Top";
                    v2332.BackgroundTransparency = 1;
                    v2332.TextStrokeTransparency = 0.5;
                    v2332.TextColor3 = Color3.fromRGB(255, 174, 0);
                    v2332.Text = v873.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v873.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                else
                    v873.Handle["NameEsp"   .. Number ].TextLabel.Text = v873.Name   .. " "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v873.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                end
            elseif v873.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v873.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end
    end
    for v874, v875 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v875:IsA("Tool") then
            if RealFruitESP then
                if  not v875.Handle:FindFirstChild("NameEsp"   .. Number ) then
                    local v2344 = Instance.new("BillboardGui", v875.Handle);
                    v2344.Name = "NameEsp"   .. Number ;
                    v2344.ExtentsOffset = Vector3.new(0, 1, 0);
                    v2344.Size = UDim2.new(1, 200, 1, 30);
                    v2344.Adornee = v875.Handle;
                    v2344.AlwaysOnTop = true;
                    local v2351 = Instance.new("TextLabel", v2344);
                    v2351.Font = Enum.Font.GothamSemibold;
                    v2351.FontSize = "Size14";
                    v2351.TextWrapped = true;
                    v2351.Size = UDim2.new(1, 0, 1, 0);
                    v2351.TextYAlignment = "Top";
                    v2351.BackgroundTransparency = 1;
                    v2351.TextStrokeTransparency = 0.5;
                    v2351.TextColor3 = Color3.fromRGB(251, 255, 0);
                    v2351.Text = v875.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v875.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                else
                    v875.Handle["NameEsp"   .. Number ].TextLabel.Text = v875.Name   .. " "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v875.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                end
            elseif v875.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v875.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end
    end
end
function UpdateIslandESP()
    for v876, v877 in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
        pcall(function()
            if IslandESP then
                if (v877.Name ~= "Sea") then
                    if  not v877:FindFirstChild("NameEsp") then
                        local v2569 = Instance.new("BillboardGui", v877);
                        v2569.Name = "NameEsp";
                        v2569.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2569.Size = UDim2.new(1, 200, 1, 30);
                        v2569.Adornee = v877;
                        v2569.AlwaysOnTop = true;
                        local v2575 = Instance.new("TextLabel", v2569);
                        v2575.Font = "GothamBold";
                        v2575.FontSize = "Size14";
                        v2575.TextWrapped = true;
                        v2575.Size = UDim2.new(1, 0, 1, 0);
                        v2575.TextYAlignment = "Top";
                        v2575.BackgroundTransparency = 1;
                        v2575.TextStrokeTransparency = 0.5;
                        v2575.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        v877['NameEsp'].TextLabel.Text = v877.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v877.Position).Magnitude / 3 )   .. " Distance" ;
                    end
                end
            elseif v877:FindFirstChild("NameEsp") then
                v877:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function isnil(v411)
    return v411 == nil ;
end
local function v56(v412)
    return math.floor(tonumber(v412) + 0.5 );
end
Number = math.random(1, 1000000);
function UpdatePlayerChams()
    for v878, v879 in pairs(game:GetService("Players"):GetChildren()) do
        pcall(function()
            if  not isnil(v879.Character) then
                if ESPPlayer then
                    if ( not isnil(v879.Character.Head) and  not v879.Character.Head:FindFirstChild("NameEsp"   .. Number )) then
                        local v2585 = Instance.new("BillboardGui", v879.Character.Head);
                        v2585.Name = "NameEsp"   .. Number ;
                        v2585.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2585.Size = UDim2.new(1, 200, 1, 30);
                        v2585.Adornee = v879.Character.Head;
                        v2585.AlwaysOnTop = true;
                        local v2592 = Instance.new("TextLabel", v2585);
                        v2592.Font = Enum.Font.GothamSemibold;
                        v2592.FontSize = "Size14";
                        v2592.TextWrapped = true;
                        v2592.Text = v879.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v879.Character.Head.Position).Magnitude / 3 )   .. " Distance" ;
                        v2592.Size = UDim2.new(1, 0, 1, 0);
                        v2592.TextYAlignment = "Top";
                        v2592.BackgroundTransparency = 1;
                        v2592.TextStrokeTransparency = 0.5;
                        if (v879.Team == game.Players.LocalPlayer.Team) then
                            v2592.TextColor3 = Color3.new(0, 134, 139);
                        else
                            v2592.TextColor3 = Color3.new(0, 134, 139);
                        end
                    else
                        v879.Character.Head["NameEsp"   .. Number ].TextLabel.Text = v879.Name   .. " | "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v879.Character.Head.Position).Magnitude / 3 )   .. " Distance\nHealth: "   .. v56((v879.Character.Humanoid.Health * 100) / v879.Character.Humanoid.MaxHealth )   .. "%" ;
                    end
                elseif v879.Character.Head:FindFirstChild("NameEsp"   .. Number ) then
                    v879.Character.Head:FindFirstChild("NameEsp"   .. Number ):Destroy();
                end
            end
        end);
    end
end
function UpdateChestChams()
    for v880, v881 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if string.find(v881.Name, "Chest") then
                if ChestESP then
                    if string.find(v881.Name, "Chest") then
                        if  not v881:FindFirstChild("NameEsp"   .. Number ) then
                            local v2862 = Instance.new("BillboardGui", v881);
                            v2862.Name = "NameEsp"   .. Number ;
                            v2862.ExtentsOffset = Vector3.new(0, 1, 0);
                            v2862.Size = UDim2.new(1, 200, 1, 30);
                            v2862.Adornee = v881;
                            v2862.AlwaysOnTop = true;
                            local v2868 = Instance.new("TextLabel", v2862);
                            v2868.Font = Enum.Font.GothamSemibold;
                            v2868.FontSize = "Size14";
                            v2868.TextWrapped = true;
                            v2868.Size = UDim2.new(1, 0, 1, 0);
                            v2868.TextYAlignment = "Top";
                            v2868.BackgroundTransparency = 1;
                            v2868.TextStrokeTransparency = 0.5;
                            if (v881.Name == "Chest1") then
                                v2868.TextColor3 = Color3.fromRGB(109, 109, 109);
                                v2868.Text = "Chest 1"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v881.Position).Magnitude / 3 )   .. " Distance" ;
                            end
                            if (v881.Name == "Chest2") then
                                v2868.TextColor3 = Color3.fromRGB(173, 158, 21);
                                v2868.Text = "Chest 2"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v881.Position).Magnitude / 3 )   .. " Distance" ;
                            end
                            if (v881.Name == "Chest3") then
                                v2868.TextColor3 = Color3.fromRGB(85, 255, 255);
                                v2868.Text = "Chest 3"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v881.Position).Magnitude / 3 )   .. " Distance" ;
                            end
                        else
                            v881["NameEsp"   .. Number ].TextLabel.Text = v881.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v881.Position).Magnitude / 3 )   .. " Distance" ;
                        end
                    end
                elseif v881:FindFirstChild("NameEsp"   .. Number ) then
                    v881:FindFirstChild("NameEsp"   .. Number ):Destroy();
                end
            end
        end);
    end
end
function UpdateDevilChams()
    for v882, v883 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if DevilFruitESP then
                if string.find(v883.Name, "Fruit") then
                    if  not v883.Handle:FindFirstChild("NameEsp"   .. Number ) then
                        local v2603 = Instance.new("BillboardGui", v883.Handle);
                        v2603.Name = "NameEsp"   .. Number ;
                        v2603.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2603.Size = UDim2.new(1, 200, 1, 30);
                        v2603.Adornee = v883.Handle;
                        v2603.AlwaysOnTop = true;
                        local v2610 = Instance.new("TextLabel", v2603);
                        v2610.Font = Enum.Font.GothamSemibold;
                        v2610.FontSize = "Size14";
                        v2610.TextWrapped = true;
                        v2610.Size = UDim2.new(1, 0, 1, 0);
                        v2610.TextYAlignment = "Top";
                        v2610.BackgroundTransparency = 1;
                        v2610.TextStrokeTransparency = 0.5;
                        v2610.TextColor3 = Color3.fromRGB(255, 255, 255);
                        v2610.Text = v883.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v883.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                    else
                        v883.Handle["NameEsp"   .. Number ].TextLabel.Text = v883.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v883.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                    end
                end
            elseif v883.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v883.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end);
    end
end
function UpdateFlowerChams()
    for v884, v885 in pairs(game.Workspace:GetChildren()) do
        pcall(function()
            if ((v885.Name == "Flower2") or (v885.Name == "Flower1")) then
                if FlowerESP then
                    if  not v885:FindFirstChild("NameEsp"   .. Number ) then
                        local v2622 = Instance.new("BillboardGui", v885);
                        v2622.Name = "NameEsp"   .. Number ;
                        v2622.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2622.Size = UDim2.new(1, 200, 1, 30);
                        v2622.Adornee = v885;
                        v2622.AlwaysOnTop = true;
                        local v2628 = Instance.new("TextLabel", v2622);
                        v2628.Font = Enum.Font.GothamSemibold;
                        v2628.FontSize = "Size14";
                        v2628.TextWrapped = true;
                        v2628.Size = UDim2.new(1, 0, 1, 0);
                        v2628.TextYAlignment = "Top";
                        v2628.BackgroundTransparency = 1;
                        v2628.TextStrokeTransparency = 0.5;
                        v2628.TextColor3 = Color3.fromRGB(255, 0, 0);
                        if (v885.Name == "Flower1") then
                            v2628.Text = "Blue Flower"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v885.Position).Magnitude / 3 )   .. " Distance" ;
                            v2628.TextColor3 = Color3.fromRGB(0, 0, 255);
                        end
                        if (v885.Name == "Flower2") then
                            v2628.Text = "Red Flower"   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v885.Position).Magnitude / 3 )   .. " Distance" ;
                            v2628.TextColor3 = Color3.fromRGB(255, 0, 0);
                        end
                    else
                        v885["NameEsp"   .. Number ].TextLabel.Text = v885.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v885.Position).Magnitude / 3 )   .. " Distance" ;
                    end
                elseif v885:FindFirstChild("NameEsp"   .. Number ) then
                    v885:FindFirstChild("NameEsp"   .. Number ):Destroy();
                end
            end
        end);
    end
end
function UpdateRealFruitChams()
    for v886, v887 in pairs(game.Workspace.AppleSpawner:GetChildren()) do
        if v887:IsA("Tool") then
            if RealFruitESP then
                if  not v887.Handle:FindFirstChild("NameEsp"   .. Number ) then
                    local v2363 = Instance.new("BillboardGui", v887.Handle);
                    v2363.Name = "NameEsp"   .. Number ;
                    v2363.ExtentsOffset = Vector3.new(0, 1, 0);
                    v2363.Size = UDim2.new(1, 200, 1, 30);
                    v2363.Adornee = v887.Handle;
                    v2363.AlwaysOnTop = true;
                    local v2370 = Instance.new("TextLabel", v2363);
                    v2370.Font = Enum.Font.GothamSemibold;
                    v2370.FontSize = "Size14";
                    v2370.TextWrapped = true;
                    v2370.Size = UDim2.new(1, 0, 1, 0);
                    v2370.TextYAlignment = "Top";
                    v2370.BackgroundTransparency = 1;
                    v2370.TextStrokeTransparency = 0.5;
                    v2370.TextColor3 = Color3.fromRGB(255, 0, 0);
                    v2370.Text = v887.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v887.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                else
                    v887.Handle["NameEsp"   .. Number ].TextLabel.Text = v887.Name   .. " "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v887.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                end
            elseif v887.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v887.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end
    end
    for v888, v889 in pairs(game.Workspace.PineappleSpawner:GetChildren()) do
        if v889:IsA("Tool") then
            if RealFruitESP then
                if  not v889.Handle:FindFirstChild("NameEsp"   .. Number ) then
                    local v2382 = Instance.new("BillboardGui", v889.Handle);
                    v2382.Name = "NameEsp"   .. Number ;
                    v2382.ExtentsOffset = Vector3.new(0, 1, 0);
                    v2382.Size = UDim2.new(1, 200, 1, 30);
                    v2382.Adornee = v889.Handle;
                    v2382.AlwaysOnTop = true;
                    local v2389 = Instance.new("TextLabel", v2382);
                    v2389.Font = Enum.Font.GothamSemibold;
                    v2389.FontSize = "Size14";
                    v2389.TextWrapped = true;
                    v2389.Size = UDim2.new(1, 0, 1, 0);
                    v2389.TextYAlignment = "Top";
                    v2389.BackgroundTransparency = 1;
                    v2389.TextStrokeTransparency = 0.5;
                    v2389.TextColor3 = Color3.fromRGB(255, 174, 0);
                    v2389.Text = v889.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v889.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                else
                    v889.Handle["NameEsp"   .. Number ].TextLabel.Text = v889.Name   .. " "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v889.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                end
            elseif v889.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v889.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end
    end
    for v890, v891 in pairs(game.Workspace.BananaSpawner:GetChildren()) do
        if v891:IsA("Tool") then
            if RealFruitESP then
                if  not v891.Handle:FindFirstChild("NameEsp"   .. Number ) then
                    local v2401 = Instance.new("BillboardGui", v891.Handle);
                    v2401.Name = "NameEsp"   .. Number ;
                    v2401.ExtentsOffset = Vector3.new(0, 1, 0);
                    v2401.Size = UDim2.new(1, 200, 1, 30);
                    v2401.Adornee = v891.Handle;
                    v2401.AlwaysOnTop = true;
                    local v2408 = Instance.new("TextLabel", v2401);
                    v2408.Font = Enum.Font.GothamSemibold;
                    v2408.FontSize = "Size14";
                    v2408.TextWrapped = true;
                    v2408.Size = UDim2.new(1, 0, 1, 0);
                    v2408.TextYAlignment = "Top";
                    v2408.BackgroundTransparency = 1;
                    v2408.TextStrokeTransparency = 0.5;
                    v2408.TextColor3 = Color3.fromRGB(251, 255, 0);
                    v2408.Text = v891.Name   .. " \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v891.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                else
                    v891.Handle["NameEsp"   .. Number ].TextLabel.Text = v891.Name   .. " "   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v891.Handle.Position).Magnitude / 3 )   .. " Distance" ;
                end
            elseif v891.Handle:FindFirstChild("NameEsp"   .. Number ) then
                v891.Handle:FindFirstChild("NameEsp"   .. Number ):Destroy();
            end
        end
    end
end
function UpdateIslandMirageESP()
    for v892, v893 in pairs(game:GetService("Workspace")['_WorldOrigin'].Locations:GetChildren()) do
        pcall(function()
            if MirageIslandESP then
                if (v893.Name == "Mirage Island") then
                    if  not v893:FindFirstChild("NameEsp") then
                        local v2639 = Instance.new("BillboardGui", v893);
                        v2639.Name = "NameEsp";
                        v2639.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2639.Size = UDim2.new(1, 200, 1, 30);
                        v2639.Adornee = v893;
                        v2639.AlwaysOnTop = true;
                        local v2645 = Instance.new("TextLabel", v2639);
                        v2645.Font = "Code";
                        v2645.FontSize = "Size14";
                        v2645.TextWrapped = true;
                        v2645.Size = UDim2.new(1, 0, 1, 0);
                        v2645.TextYAlignment = "Top";
                        v2645.BackgroundTransparency = 1;
                        v2645.TextStrokeTransparency = 0.5;
                        v2645.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        v893['NameEsp'].TextLabel.Text = v893.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v893.Position).Magnitude / 3 )   .. " M" ;
                    end
                end
            elseif v893:FindFirstChild("NameEsp") then
                v893:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function UpdateLSDESP()
    for v894, v895 in pairs(game:GetService("Workspace").NPCs:GetChildren()) do
        pcall(function()
            if LADESP then
                if (v895.Name == "Legendary Sword Dealer") then
                    if  not v895:FindFirstChild("NameEsp") then
                        local v2655 = Instance.new("BillboardGui", v895);
                        v2655.Name = "NameEsp";
                        v2655.ExtentsOffset = Vector3.new(0, 1, 0);
                        v2655.Size = UDim2.new(1, 200, 1, 30);
                        v2655.Adornee = v895;
                        v2655.AlwaysOnTop = true;
                        local v2661 = Instance.new("TextLabel", v2655);
                        v2661.Font = "Code";
                        v2661.FontSize = "Size14";
                        v2661.TextWrapped = true;
                        v2661.Size = UDim2.new(1, 0, 1, 0);
                        v2661.TextYAlignment = "Top";
                        v2661.BackgroundTransparency = 1;
                        v2661.TextStrokeTransparency = 0.5;
                        v2661.TextColor3 = Color3.fromRGB(255, 255, 255);
                    else
                        v895['NameEsp'].TextLabel.Text = v895.Name   .. "   \n"   .. v56((game:GetService("Players").LocalPlayer.Character.Head.Position - v895.Position).Magnitude / 3 )   .. " M" ;
                    end
                end
            elseif v895:FindFirstChild("NameEsp") then
                v895:FindFirstChild("NameEsp"):Destroy();
            end
        end);
    end
end
function InfAb()
    if InfAbility then
        if  not game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
            local v2077 = Instance.new("ParticleEmitter");
            v2077.Acceleration = Vector3.new(0, 0, 0);
            v2077.Archivable = true;
            v2077.Drag = 20;
            v2077.EmissionDirection = Enum.NormalId.Top;
            v2077.Enabled = true;
            v2077.Lifetime = NumberRange.new(0, 0);
            v2077.LightInfluence = 0;
            v2077.LockedToPart = true;
            v2077.Name = "Agility";
            v2077.Rate = 500;
            local v2089 = {
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 4)
            };
            v2077.Size = NumberSequence.new(v2089);
            v2077.RotSpeed = NumberRange.new(9999, 99999);
            v2077.Rotation = NumberRange.new(0, 0);
            v2077.Speed = NumberRange.new(30, 30);
            v2077.SpreadAngle = Vector2.new(0, 0, 0, 0);
            v2077.Texture = "";
            v2077.VelocityInheritance = 0;
            v2077.ZOffset = 2;
            v2077.Transparency = NumberSequence.new(0);
            v2077.Color = ColorSequence.new(Color3.fromRGB(0, 0, 0), Color3.fromRGB(0, 0, 0));
            v2077.Parent = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
        end
    elseif game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility") then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Agility"):Destroy();
    end
end
local v25 = game:GetService("Players").LocalPlayer;
local v57 = v25.Character.Energy.Value;
function infinitestam()
    v25.Character.Energy.Changed:connect(function()
        if InfiniteEnergy then
            v25.Character.Energy.Value = v57;
        end
    end);
end
spawn(function()
    pcall(function()
        while wait(0.1) do
            if InfiniteEnergy then
                wait(0.1);
                v57 = v25.Character.Energy.Value;
                infinitestam();
            end
        end
    end);
end);
function NoDodgeCool()
    if nododgecool then
        for v1993, v1994 in next, getgc() do
            if game:GetService("Players").LocalPlayer.Character.Dodge then
                if ((typeof(v1994) == "function") and (getfenv(v1994).script == game:GetService("Players").LocalPlayer.Character.Dodge)) then
                    for v2671, v2672 in next, getupvalues(v1994) do
                        if (tostring(v2672) == "0.1") then
                            repeat
                                wait(0.1);
                                setupvalue(v1994, v2671, 0);
                            until  not nododgecool
                        end
                    end
                end
            end
        end
    end
end
function fly()
    local v413 = game:GetService("Players").LocalPlayer:GetMouse("");
    localplayer = game:GetService("Players").LocalPlayer;
    game:GetService("Players").LocalPlayer.Character:WaitForChild("HumanoidRootPart");
    local v415 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart;
    local v416 = 25;
    local v417 = {
        a = false,
        d = false,
        w = false,
        s = false
    };
    local v418;
    local v419;
    local function v420()
        local v896 = Instance.new("BodyPosition", v415);
        local v897 = Instance.new("BodyGyro", v415);
        v896.Name = "EPIXPOS";
        v896.maxForce = Vector3.new(math.huge, math.huge, math.huge);
        v896.position = v415.Position;
        v897.maxTorque = Vector3.new(8999999488, 8999999488, 8999999488);
        v897.CFrame = v415.CFrame;
        repeat
            wait();
            localplayer.Character.Humanoid.PlatformStand = true;
            local v1845 = (v897.CFrame - v897.CFrame.p) + v896.position ;
            if ( not v417.w and  not v417.s and  not v417.a and  not v417.d) then
                speed = 1;
            end
            if v417.w then
                v1845 = v1845 + (workspace.CurrentCamera.CoordinateFrame.lookVector * speed) ;
                speed = speed + v416 ;
            end
            if v417.s then
                v1845 = v1845 - (workspace.CurrentCamera.CoordinateFrame.lookVector * speed) ;
                speed = speed + v416 ;
            end
            if v417.d then
                v1845 = v1845 * CFrame.new(speed, 0, 0) ;
                speed = speed + v416 ;
            end
            if v417.a then
                v1845 = v1845 * CFrame.new( -speed, 0, 0) ;
                speed = speed + v416 ;
            end
            if (speed > v416) then
                speed = v416;
            end
            v896.position = v1845.p;
            if v417.w then
                v897.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles( -math.rad(speed * 15 ), 0, 0) ;
            elseif v417.s then
                v897.CFrame = workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(math.rad(speed * 15 ), 0, 0) ;
            else
                v897.CFrame = workspace.CurrentCamera.CoordinateFrame;
            end
        until  not Fly
        if v897 then
            v897:Destroy();
        end
        if v896 then
            v896:Destroy();
        end
        flying = false;
        localplayer.Character.Humanoid.PlatformStand = false;
        speed = 0;
    end
    v418 = v413.KeyDown:connect(function(v906)
        if ( not v415 or  not v415.Parent) then
            flying = false;
            v418:disconnect();
            v419:disconnect();
            return;
        end
        if (v906 == "w") then
            v417.w = true;
        elseif (v906 == "s") then
            v417.s = true;
        elseif (v906 == "a") then
            v417.a = true;
        elseif (v906 == "d") then
            v417.d = true;
        end
    end);
    v419 = v413.KeyUp:connect(function(v907)
        if (v907 == "w") then
            v417.w = false;
        elseif (v907 == "s") then
            v417.s = false;
        elseif (v907 == "a") then
            v417.a = false;
        elseif (v907 == "d") then
            v417.d = false;
        end
    end);
    v420();
end
function Click()
    game:GetService("VirtualUser"):CaptureController();
    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672));
end
function AutoHaki()
    if  not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso");
    end
end
function EquipWeapon(v421)
    if  not Nill then
        if game.Players.LocalPlayer.Backpack:FindFirstChild(v421) then
            Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(v421);
            wait(0.1);
            game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool);
        end
    end
end
-- Tween tới vị trí rương

function BTP(v422)
    pcall(function()
        if (((v422.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude >= 1500) and  not Auto_Raid and (game.Players.LocalPlayer.Character.Humanoid.Health > 0)) then
            repeat
                wait();
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v422;
                wait(0.05);
                game.Players.LocalPlayer.Character.Head:Destroy();
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v422;
            until ((v422.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude < 1500) and (game.Players.LocalPlayer.Character.Humanoid.Health > 0)
        end
    end);
end
-- Cờ trạng thái
local v58 = false -- Đang tween
local v59 = false -- Cho phép bypass
local distbyp = 3500
local defaultTweenSpeed = 300


-- Đợi HumanoidRootPart
function WaitHRP(player)
	if not player then return end
	return player.Character:WaitForChild("HumanoidRootPart", 9)
end

-- Tìm tele gần nhất (đã sửa logic)
function CheckNearestTeleporter(targetCF)
	local sea = game.PlaceId
	local targetPos = targetCF.Position
	local teleList = {}

	if sea == 2753915549 then -- First Sea
		teleList = {
			Sky3 = Vector3.new(-7894, 5547, -380),
			Sky3Exit = Vector3.new(-4607, 874, -1667),
			UnderWater = Vector3.new(61163, 11, 1819),
			UnderwaterExit = Vector3.new(4050, -1, -1814)
		}
	elseif sea == 4442272183 then -- Second Sea
		teleList = {
			["Swan Mansion"] = Vector3.new(-390, 332, 673),
			["Swan Room"] = Vector3.new(2285, 15, 905),
			["Cursed Ship"] = Vector3.new(923, 126, 32852),
			["Zombie Island"] = Vector3.new(-6509, 83, -133)
		}
	elseif sea == 7449423635 then -- Third Sea
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
		if minDist < 2000 and distToTarget > 2500 then
			return nearest
		end
	end
end

-- Gửi requestEntrance
function requestEntrance(pos)
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
		warn("topos: nhân vật không hợp lệ hoặc đã chết")
		return
	end

	if not target or (typeof(target) ~= "CFrame" and typeof(target) ~= "Vector3") then
		warn("topos: target không hợp lệ")
		return
	end

	local targetCFrame = typeof(target) == "Vector3" and CFrame.new(target) or target
	local distance = (targetCFrame.Position - hrp.Position).Magnitude

	-- 🔄 Kiểm tra có nên teleport không
	local nearestTele = CheckNearestTeleporter(targetCFrame)
	if nearestTele then
		requestEntrance(nearestTele)
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
			if not v58 then return end
			task.wait()
			if character and character:FindFirstChild("HumanoidRootPart") then
				local cf = part.CFrame
				hrp.CFrame = CFrame.new(cf.Position.X, targetCFrame.Position.Y, cf.Position.Z)
			end
		end)
	end

	v58 = true

	if v59 and distance > distbyp then
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
			v58 = false
		end
	end)
end

function TP1(v436)
    topos(v436);
end
function TP2(v437)
    local v438 = game.Players.LocalPlayer;
    if (v438.Character and (v438.Character.Humanoid.Health > 0) and v438.Character:FindFirstChild("HumanoidRootPart")) then
        local v1853 = (v437.Position - v438.Character.HumanoidRootPart.Position).Magnitude;
        if  not v437 then
            return;
        end
        local v1854 = CheckNearestTeleporter(v437);
        if v1854 then
            requestEntrance(v1854);
        end
        if  not v438.Character:FindFirstChild("PartTele") then
            local v2113 = Instance.new("Part", v438.Character);
            v2113.Size = Vector3.new(10, 1, 10);
            v2113.Name = "PartTele";
            v2113.Anchored = true;
            v2113.Transparency = 1;
            v2113.CanCollide = true;
            v2113.CFrame = WaitHRP(v438).CFrame;
            v2113:GetPropertyChangedSignal("CFrame"):Connect(function()
                if  not v58 then
                    return;
                end
                task.wait();
                if (v438.Character and v438.Character:FindFirstChild("HumanoidRootPart")) then
                    WaitHRP(v438).CFrame = v2113.CFrame;
                end
            end);
        end
        v58 = true;
        local v1855 = game:GetService("TweenService"):Create(v438.Character.PartTele, TweenInfo.new(v1853 / 350 , Enum.EasingStyle.Linear), {
            CFrame = v437
        });
        v1855:Play();
        v1855.Completed:Connect(function(v1998)
            if (v1998 == Enum.PlaybackState.Completed) then
                if v438.Character:FindFirstChild("PartTele") then
                    v438.Character.PartTele:Destroy();
                end
                v58 = false;
            end
        end);
    end
end
function stopTeleport()
    v58 = false;
    local v439 = game.Players.LocalPlayer;
    if v439.Character:FindFirstChild("PartTele") then
        v439.Character.PartTele:Destroy();
    end
end
spawn(function()
    while task.wait() do
        if  not v58 then
            stopTeleport();
        end
    end
end);
spawn(function()
    local v440 = game.Players.LocalPlayer;
    while task.wait() do
        pcall(function()
            if v440.Character:FindFirstChild("PartTele") then
                if ((v440.Character.HumanoidRootPart.Position - v440.Character.PartTele.Position).Magnitude >= 100) then
                    stopTeleport();
                end
            end
        end);
    end
end);
local v60 = game.Players.LocalPlayer;
local function v61(v441)
    local v442 = v441:WaitForChild("Humanoid");
    v442.Died:Connect(function()
        stopTeleport();
    end);
end
v60.CharacterAdded:Connect(v61);
if v60.Character then
    v61(v60.Character);
end
function TPB(v443)
    local v444 = game:service("TweenService");
    local v445 = TweenInfo.new((game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat.CFrame.Position - v443.Position).Magnitude / 300 , Enum.EasingStyle.Linear);
    tween = v444:Create(game:GetService("Workspace").Boats.PirateBrigade.VehicleSeat, v445, {
        CFrame = v443
    });
    tween:Play();
    local v446 = {};
    v446.Stop = function(v911)
        tween:Cancel();
    end;
    return v446;
end
Type = 1;
spawn(function()
    while wait() do
        if (Type == 1) then
            Pos = CFrame.new(0, PosY, 0);
        elseif (Type == 2) then
            Pos = CFrame.new(0, PosY, 0);
        elseif (Type == 3) then
            Pos = CFrame.new(0, PosY, 0);
        elseif (Type == 4) then
            Pos = CFrame.new( 0, PosY, 0);
        end
    end
end);
spawn(function()
    while wait(0.1) do
        Type = 1;
        wait(0.2);
        Type = 2;
        wait(0.2);
        Type = 3;
        wait(0.2);
        Type = 4;
        wait(0.2);
    end
end);
spawn(function()
    pcall(function()
        while wait() do
            if (_G.AdvanceDungeon or _G.DoughtBoss or _G.DungeonMobAura or _G.FarmChest or _G.Factory or _G.FarmBossHallow or _G.FarmSwanGlasses or _G.LongSword or _G.BlackSpikeycoat or _G.ElectricClaw or _G.FarmGunMastery or _G.HolyTorch or _G.LawRaid or _G.FarmBoss or _G.TwinHooks or _G.OpenSwanDoor or _G.Dragon_Trident or _G.Saber or _G.FarmFruitMastery or _G.FarmGunMastery or _G.TeleportIsland or _G.EvoRace or _G.FarmAllMsBypassType or _G.Observationv2 or _G.MusketeerHat or _G.Ectoplasm or _G.Rengoku or _G.Rainbow_Haki or _G.Observation or _G.DarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.BudySword or _G.OderSword or _G.AllBoss or _G.Sharkman or _G.Mastery_Fruit or _G.Mastery_Gun or _G.Dungeon or _G.Cavender or _G.Pole or _G.Kill_Ply or _G.Factory or _G.SecondSea or _G.TeleportPly or _G.Bartilo or _G.DarkBoss or _G.GrabChest or _G.Holy_Torch or _G.Level or _G.Clip or FarmBoss or _G.Elitehunter or _G.ThirdSea or _G.Bone or _G.heart or _G.doughking or _G.FarmMaterial or _G.Guitar or _G.Dragon_Trident or _G.tushita or _G.d or _G.waden or _G.gay or _G.pole or _G.saw or _G.ObservationHakiV2 or _G.FarmNearest or _G.FarmChest or _G.Carvender or _G.TwinHook or AutoMobAura or _G.Tweenfruit or _G.TeleportNPC or _G.Leather or _G.Wing or _G.Umm or _G.Makori_gay or Radioactive or Fish or Gunpowder or Dragon_Scale or Cocoafarm or Scrap or MiniHee or _G.FarmSeabaest or _G.CDK or _G.FarmMob or _G.MysticIsland or _G.FarmDungeon or _G.RaidPirate or _G.QuestRace or _G.TweenMGear or getgenv().AutoFarm or _G.PlayerHunter or _G.Factory or Grab_Chest or _G.Seabest or _G.SeaBest or _G.KillTial or _G.Saber or _G.Position_Spawn or _G.Farmfast or _G.Race or _G.RaidPirate or Open_Color_Haki or _G.Terrorshark or FarmShark or _G.farmpiranya or _G.Fish_Crew_Member or _G.AppleAutoDriveBoat or _G.bjirFishBoat or _G.KillGhostShip or _G.FrozenDimension or _G.FKitsune) then
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
spawn(function()
    pcall(function()
        while wait() do
            if (_G.AdvanceDungeon or _G.DoughtBoss or _G.DungeonMobAura or _G.FarmChest or _G.Factory or _G.FarmBossHallow or _G.FarmSwanGlasses or _G.LongSword or _G.BlackSpikeycoat or _G.ElectricClaw or _G.FarmGunMastery or _G.HolyTorch or _G.LawRaid or _G.FarmBoss or _G.TwinHooks or _G.OpenSwanDoor or _G.Dragon_Trident or _G.Saber or _G.FarmFruitMastery or _G.FarmGunMastery or _G.TeleportIsland or _G.EvoRace or _G.FarmAllMsBypassType or _G.Observationv2 or _G.MusketeerHat or _G.Ectoplasm or _G.Rengoku or _G.Rainbow_Haki or _G.Observation or _G.DarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.BudySword or _G.OderSword or _G.AllBoss or _G.Sharkman or _G.Mastery_Fruit or _G.Mastery_Gun or _G.Dungeon or _G.Cavender or _G.Pole or _G.Kill_Ply or _G.Factory or _G.SecondSea or _G.TeleportPly or _G.Bartilo or _G.DarkBoss or _G.GrabChest or _G.Holy_Torch or _G.Level or _G.Clip or FarmBoss or _G.Elitehunter or _G.ThirdSea or _G.Bone or _G.heart or _G.doughking or _G.FarmMaterial or _G.Guitar or _G.Dragon_Trident or _G.tushita or _G.d or _G.waden or _G.gay or _G.pole or _G.saw or _G.ObservationHakiV2 or _G.FarmNearest or _G.FarmChest or _G.Carvender or _G.TwinHook or AutoMobAura or _G.Tweenfruit or _G.TeleportNPC or _G.Leather or _G.Wing or _G.Umm or _G.Makori_gay or Radioactive or Fish or Gunpowder or Dragon_Scale or Cocoafarm or Scrap or MiniHee or _G.FarmSeabaest or _G.CDK or _G.FarmMob or _G.MysticIsland or _G.FarmDungeon or _G.RaidPirate or _G.QuestRace or _G.TweenMGear or getgenv().AutoFarm or _G.PlayerHunter or _G.Factory or Grab_Chest or _G.Seabest or _G.SeaBest or _G.KillTial or _G.Saber or _G.Position_Spawn or _G.Farmfast or _G.Race or _G.RaidPirate or _G.TushitaSword or Open_Color_Haki or _G.Terrorshark or FarmShark or _G.farmpiranya or _G.Fish_Crew_Member or _G.AppleAutoDriveBoat or _G.bjirFishBoat or _G.KillGhostShip) then
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
spawn(function()
    pcall(function()
        game:GetService("RunService").Stepped:Connect(function()
            if (_G.AdvanceDungeon or _G.DoughtBoss or _G.DungeonMobAura or _G.FarmChest or _G.Factory or _G.FarmBossHallow or _G.FarmSwanGlasses or _G.LongSword or _G.BlackSpikeycoat or _G.ElectricClaw or _G.FarmGunMastery or _G.HolyTorch or _G.LawRaid or _G.FarmBoss or _G.TwinHooks or _G.OpenSwanDoor or _G.Dragon_Trident or _G.Saber or _G.NoClip or _G.FarmFruitMastery or _G.FarmGunMastery or _G.TeleportIsland or _G.EvoRace or _G.FarmAllMsBypassType or _G.Observationv2 or _G.MusketeerHat or _G.Ectoplasm or _G.Rengoku or _G.Rainbow_Haki or _G.Observation or _G.DarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.BudySword or _G.OderSword or _G.AllBoss or _G.Sharkman or _G.Mastery_Fruit or _G.Mastery_Gun or _G.Dungeon or _G.Cavender or _G.Pole or _G.Kill_Ply or _G.Factory or _G.SecondSea or _G.TeleportPly or _G.Bartilo or _G.DarkBoss or _G.GrabChest or _G.Holy_Torch or _G.Level or _G.Clip or _G.Elitehunter or _G.ThirdSea or _G.Bone or _G.heart or _G.doughking or _G.FarmMaterial or _G.Guitar or _G.Dragon_Trident or _G.tushita or _G.waden or _G.pole or _G.saw or _G.ObservationHakiV2 or _G.FarmNearest or _G.Carvender or _G.TwinHook or AutoMobAura or _G.Tweenfruit or _G.TeleportNPC or _G.Kai or _G.Leather or _G.Wing or _G.Umm or _G.Makori_gay or Radioactive or Fish or Gunpowder or Dragon_Scale or Cocoafarm or Scrap or MiniHee or _G.FarmSeabaest or _G.CDK or _G.FarmMob or _G.MysticIsland or _G.FarmDungeon or _G.RaidPirate or _G.QuestRace or _G.TweenMGear or getgenv().AutoFarm or _G.PlayerHunter or _G.Factory or _G.Seabest or _G.SeaBest or _G.KillTial or _G.Saber or _G.Position_Spawn or _G.TPB or _G.Farmfast or _G.Race or _G.RaidPirate or Open_Color_Haki or _G.Terrorshark or FarmShark or _G.farmpiranya or _G.Fish_Crew_Member or _G.AppleAutoDriveBoat or _G.FrozenDimension or _G.FKitsune) then
                for v2191, v2192 in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
                    if v2192:IsA("BasePart") then
                        v2192.CanCollide = false;
                    end
                end
            end
        end);
    end);
end);
function InstancePos(v448)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v448;
end
function TP3(v450)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v450;
end
spawn(function()
    while wait() do
        if (_G.DoughtBoss or _G.DungeonMobAura or _G.FarmChest or _G.FarmBossHallow or _G.Factory or _G.FarmSwanGlasses or _G.LongSword or _G.BlackSpikeycoat or _G.ElectricClaw or _G.FarmGunMastery or _G.HolyTorch or _G.LawRaid or _G.FarmBoss or _G.TwinHooks or _G.OpenSwanDoor or _G.Dragon_Trident or _G.Saber or _G.NoClip or _G.FarmFruitMastery or _G.FarmGunMastery or _G.TeleportIsland or _G.EvoRace or _G.FarmAllMsBypassType or _G.Observationv2 or _G.MusketeerHat or _G.Ectoplasm or _G.Rengoku or _G.Rainbow_Haki or _G.Observation or _G.DarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.BudySword or _G.OderSword or _G.AllBoss or _G.Sharkman or _G.Mastery_Fruit or _G.Mastery_Gun or _G.Dungeon or _G.Cavender or _G.Pole or _G.Factory or _G.SecondSea or _G.TeleportPly or _G.Bartilo or _G.DarkBoss or _G.Level or _G.Clip or _G.Elitehunter or _G.ThirdSea or _G.Bone or _G.heart or _G.doughking or _G.d or _G.waden or _G.gay or _G.ObservationHakiV2 or _G.FarmMaterial or _G.FarmNearest or _G.Carvender or _G.TwinHook or AutoMobAura or _G.Leather or _G.Wing or _G.Umm or _G.Makori_gay or Radioactive or Fish or Gunpowder or Dragon_Scale or Cocoafarm or Scrap or MiniHee or _G.FarmSeabaest or _G.CDK or _G.RaidPirate or getgenv().AutoFarm or _G.PlayerHunter or _G.Factory or _G.AttackDummy or _G.Seabest or _G.SeaBest or _G.KillTial or _G.Saber or _G.Farmfast or _G.RaidPirate or _G.Terrorshark or FarmShark or _G.farmpiranya or _G.Fish_Crew_Member or _G.bjirFishBoat or (_G.KillGhostShip == true)) then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("Ken", true);
            end);
        end
    end
end);
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if (_G.Click or Fastattack) then
            pcall(function()
                game:GetService("VirtualUser"):CaptureController();
                game:GetService("VirtualUser"):Button1Down(Vector2.new(0, 1, 0, 1));
            end);
        end
    end);
end);

spawn(function()
    pcall(function()
        while wait() do
            for v1999, v2000 in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren()) do
                if v2000:IsA("Tool") then
                    if v2000:FindFirstChild("RemoteFunctionShoot") then
                        SelectWeaponGun = v2000.Name;
                    end
                end
            end
        end
    end);
end);
game:GetService("Players").LocalPlayer.Idled:connect(function()
    game:GetService("VirtualUser"):Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
    wait(1);
    game:GetService("VirtualUser"):Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame);
end);
spawn(function()
	while true do
		wait(60) -- Mỗi 60 giây thực hiện một hành động nhẹ
		local VirtualUser = game:service'VirtualUser'
		game:service'Players'.LocalPlayer.Idled:connect(function()
			VirtualUser:Button2Down(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
			wait(1)
			VirtualUser:Button2Up(Vector2.new(0,0), workspace.CurrentCamera.CFrame)
		end)
	end
end)


PosY = 20;
Kill_At = 28;

	local FullMoonStatus = v16.Server_Status:AddParagraph({Title = "Full Moon", Content = "", })
	task.spawn(function()
		while task.wait(1) do
			pcall(function()
				local lighting = game:GetService("Lighting")
				local moonTextureId = nil

				-- Tìm Sky hợp lệ
				for _, obj in pairs(lighting:GetChildren()) do
					if obj:IsA("Sky") then
						moonTextureId = obj.MoonTextureId
						break
					end
				end

				if not moonTextureId then
					FullMoonStatus:SetDesc("Full Moon Status: Unknown (No Sky Found)")
					return
				end

				-- Kiểm tra trạng thái trăng
				if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
					FullMoonStatus:SetDesc("Full Moon Status: 🌕 Full Moon")
				elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
					FullMoonStatus:SetDesc("Full Moon Status: 🌖 75%")
				elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
					FullMoonStatus:SetDesc("Full Moon Status: 🌓 50%")
				elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
					FullMoonStatus:SetDesc("Full Moon Status: 🌘 25%")
				elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
					FullMoonStatus:SetDesc("Full Moon Status: 🌑 15%")
				else
					FullMoonStatus:SetDesc("Full Moon Status: 🌚 0%")
				end
			end)
		end
	end)

------------Mirage Island Status-------
    local MirageIslandStatus = v16.Server_Status:AddParagraph({Title = "Mirage Island", Content = "", })
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
------------Leviathan Status-------   
    local LeviathanStatus = v16.Server_Status:AddParagraph({Title = "Leviathan", Content = "", })
    spawn(function()
        pcall(function()
            while wait(1) do
                local v811 = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1");
                if (v811 == 5) then
                    LeviathanStatus:SetDesc("Status : Leviathan Is Out There");
                elseif (v811 == -1) then
                    LeviathanStatus:SetDesc("Status : I Don't Know");
                else
                    LeviathanStatus:SetDesc("Mua: " .. tostring(v811));
                end
            end
        end);
    end);
------------Frozen Dimension Status-------
    local FrozenDimensionStatus = v16.Server_Status:AddParagraph({Title = "Frozen Dimension", Content = "", })
    spawn(function()
        pcall(function()
            while wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
                    FrozenDimensionStatus:SetDesc("Status : ✅");
                else
                    FrozenDimensionStatus:SetDesc("Status : ❌");
                end
            end
        end);
    end);
------------Kitsune Island Status-------  
    local KitsuneIslandStatus = v16.Server_Status:AddParagraph({Title = "Kitsune Island", Content = "", })
    function UpdateKitsune()
        if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
            KitsuneIslandStatus:SetDesc("Status : ✅️");
        else
            KitsuneIslandStatus:SetDesc("Status : ❌️");
        end
    end
    spawn(function()
        pcall(function()
            while wait(1) do
                UpdateKitsune();
            end
        end);
    end);
------------Volcano Island Status-------
    local PrehistoricIslandStatus = v16.Server_Status:AddParagraph({Title = "Volcano Island", Content = ""})
    spawn(function()
        pcall(function()
            while wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                    PrehistoricIslandStatus:SetDesc("Status : ✅️");
                else
                    PrehistoricIslandStatus:SetDesc("Status : ❌️");
                end
            end
        end);
    end);
------------Cake Prince Status-------
    local CakePrinceStatus = v16.Server_Status:AddParagraph({Title = "Cake Prince", Content = "", })
    spawn(function()
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

    spawn(function()
        while wait() do
            pcall(function()
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                    CakePrinceStatus:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                    CakePrinceStatus:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                    CakePrinceStatus:SetDesc("Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39).." Mobs")
                else
                    CakePrinceStatus:SetDesc("Cake Prince Is Spawning!")
                end
            end)
        end
    end)

------------Elite Hunter Status---------
    local EliteHunterStatus = v16.Server_Status:AddParagraph({Title = "Elite Hunter", Content = "", })
    spawn(function()
        while wait(1) do
            pcall(function()
                if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                    EliteHunterStatus:SetDesc("Status : ✅️");
                else
                    EliteHunterStatus:SetDesc("Status : ❌️");
                end
            end);
        end
    end);
	local FruitList = {
		"Bomb-Bomb", "Spike-Spike", "Chop-Chop", "Spring-Spring", "Kilo-Kilo", "Spin-Spin",
		"Bird: Falcon", "Smoke-Smoke", "Flame-Flame", "Ice-Ice", "Sand-Sand", "Dark-Dark",
		"Revive-Revive", "Diamond-Diamond", "Light-Light", "Love-Love", "Rubber-Rubber",
		"Barrier-Barrier", "Magma-Magma", "Door-Door", "Quake-Quake", "Human-Human: Buddha",
		"String-String", "Bird-Bird: Phoenix", "Rumble-Rumble", "Paw-Paw", "Gravity-Gravity",
		"Dough-Dough", "Venom-Venom", "Shadow-Shadow", "Control-Control", "Soul-Soul",
		"Dragon-Dragon", "Leopard-Leopard"
	}

	-- Khởi tạo bảng kiểm tra nhanh
	local FruitSet = {}
	for _, fruitName in pairs(FruitList) do
		FruitSet[fruitName] = true
	end

	local FruitStatus = v16.Server_Status:AddParagraph({
		Title = "Fruit in Server",
		Content = "",
	})

	spawn(function()
		while task.wait(1) do
			pcall(function()
				local foundFruits = {}
				for _, v in pairs(game.Workspace:GetDescendants()) do
					if v:IsA("Tool") and FruitSet[v.Name] then
						table.insert(foundFruits, v.Name)
					end
				end

				if #foundFruits > 0 then
					FruitStatus:SetDesc("Status : ✅️ Found: " .. table.concat(foundFruits, ", "))
				else
					FruitStatus:SetDesc("Status : ❌️")
				end
			end)
		end
	end)

	---------Tab Server-------------------------------------------------------------------------------
	local v105 = v16.Status:AddInput("Input", {
		Title = "Job ID",
		Default = "",
		Placeholder = "",
		Numeric = false,
		Finished = false,
		Callback = function(v301)
			_G.Job = v301;
		end
	});
	v16.Status:AddButton({
		Title = "Join Server",
		Description = "",
		Callback = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer);
		end
	});
	v16.Status:AddButton({
		Title = "Clear Job Id",
		Description = "",
		Callback = function()
			_G.JobId = nil
			v105:SetValue("") 
		end
	});
	v16.Status:AddButton({
		Title = "Copy Job ID",
		Description = "",
		Callback = function()
			setclipboard(tostring(game.JobId));
		end
	});
	local v106 = v16.Status:AddToggle("MyToggle", {
		Title = "Spam Join Server",
		Default = false
	});
	v106:OnChanged(function(v302)
		_G.Join = v302;
	end);
	spawn(function()
		while wait() do
			if _G.Join then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer);
			end
		end
	end);
	v16.Status:AddButton({
		Title = "Tham Gia Máy Chủ Lại",
		Description = "",
		Callback = function()
			game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer);
		end
	});
	v16.Status:AddButton({
		Title = "Đổi Máy Chủ",
		Description = "",
		Callback = function()
			Hop();
		end
	});
---------------Tab Framming------------------------
	local v4047 = v16.Main:AddToggle("ToggleLevel", {
    Title = "Auto Farm Level",
    Description = "",
    Default = false
	});
	v4047:OnChanged(function(v4048)
		_G.Level = v4048;
		if (v4048 == false) then
			wait()
			StopTween(_G.Level)
			wait()
		end
	end);
	spawn(function()
		while task.wait() do
			if _G.Level then
				pcall(function()
					local player = game.Players.LocalPlayer
					local char = player.Character
					local hrp = char and char:FindFirstChild("HumanoidRootPart")
					local questGui = player.PlayerGui.Main.Quest
					local questTitle = questGui.Container.QuestTitle.Title.Text

					-- Nếu nhiệm vụ hiện tại không phải quái cần farm thì bỏ nhiệm vụ
					if not string.find(questTitle, NameMon) then
						StartMagnet = false
						game.ReplicatedStorage.Remotes.CommF_:InvokeServer("AbandonQuest")
					end

					-- Nếu chưa nhận nhiệm vụ thì nhận lại
					if not questGui.Visible then
						StartMagnet = false
						CheckQuest()

						if BypassTP and hrp then
							local dist = (hrp.Position - CFrameQuest.Position).Magnitude
							if dist > 3500 then
								BTP(CFrameQuest)
							else
								TP1(CFrameQuest)
								wait(0.5)
							end
						else
							TP1(CFrameQuest)
							wait(0.5)
						end

						if hrp and (hrp.Position - CFrameQuest.Position).Magnitude <= 5 then
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
						end

					-- Nếu đã nhận nhiệm vụ và nhiệm vụ đúng tên quái
					elseif questGui.Visible and string.find(questTitle, NameMon) then
						CheckQuest()
						local enemies = workspace.Enemies
						local foundQuestMob = false

						for _, mob in pairs(enemies:GetChildren()) do
							local humanoid = mob:FindFirstChild("Humanoid")
							local hrpMob = mob:FindFirstChild("HumanoidRootPart")

							-- Chỉ xử lý đúng quái của nhiệm vụ
							if humanoid and hrpMob and humanoid.Health > 0 and mob.Name == Mon then
								foundQuestMob = true
								
								repeat
									task.wait(0.5)
									EquipWeapon(_G.SelectWeapon)
									AutoHaki()
									PosMon = hrpMob.CFrame
									TP1(hrpMob.CFrame * Pos)
									StartMagnet = true
									-- Cấu hình hỗ trợ farm
									hrpMob.CanCollide = false
									humanoid.WalkSpeed = 0
									mob.Head.CanCollide = false
									hrpMob.Size = Vector3.new(50, 50, 50)

								until not _G.Level or humanoid.Health <= 0 or not mob.Parent or not questGui.Visible
							end
						end

						-- Nếu không còn quái nhiệm vụ trong map thì quay lại vị trí spawn
						if not foundQuestMob then
							TP1(CFrameMon)
							UnEquipWeapon(_G.SelectWeapon)
							StartMagnet = false

							local mobInRep = game.ReplicatedStorage:FindFirstChild(Mon)
							if mobInRep and mobInRep:FindFirstChild("HumanoidRootPart") then
								TP1(mobInRep.HumanoidRootPart.CFrame * CFrame.new(15, 10, 2))
							end
						end
					end
				end)
			end
		end
	end)

	local v3001 = v16.Main:AddToggle("ToggleMobAura", {
		Title = "Mob Aura",
		Description = "",
		Default = false
	});
	v3001:OnChanged(function(v)
		_G.FarmNearest = v
		StopTween(_G.FarmNearest);
	end);
	spawn(function()
		while wait() do
			if _G.FarmNearest then
				for v2127, v2128 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
					if (v2128.Name and v2128:FindFirstChild("Humanoid")) then
						if (v2128.Humanoid.Health > 0) then
							repeat
								wait();
								EquipWeapon(_G.SelectWeapon);
								if  not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
									local v2907 = {
										[1] = "Buso"
									};
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v2907));
								end
								topos(v2128.HumanoidRootPart.CFrame * Pos );
								v2128.HumanoidRootPart.CanCollide = false;
								Fastattack = true;
								v2128.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
								AutoFarmNearestMagnet = true;
								PosMon = v2128.HumanoidRootPart.CFrame;
							until  not _G.FarmNearest or  not v2128.Parent or (v2128.Humanoid.Health <= 0)
							AutoFarmNearestMagnet = false;
							Fastattack = false;
						end
					end
				end
			end
		end
	end);
	
	if World1 then
		local Sea2Quest = v16.Main:AddSection("Second Sea Quests")
		local SecondSeaQuest = v16.Main:AddToggle("ToggleSecondSeaQuest", {
			Title = "Auto Second Sea",
			Description = "",
			Default = false
		})
		
		SecondSeaQuest:OnChanged(function(v)
			_G.Auto_Sea2 = v
			StopTween(_G.Auto_Sea2)
		end)
		
		-- Helper functions
		local function HasKey()
			local player = game.Players.LocalPlayer
			local char = player.Character
			return player.Backpack:FindFirstChild("Key") or (char and char:FindFirstChild("Key"))
		end
		
		local function FindIceAdmiral()
			for _, v in pairs(workspace.Enemies:GetChildren()) do
				if v.Name == "Ice Admiral" and 
				   v:FindFirstChild("Humanoid") and 
				   v:FindFirstChild("HumanoidRootPart") and 
				   v.Humanoid.Health > 0 then
					return v
				end
			end
			return nil
		end
		
		local function FightBoss(boss)
			repeat
				task.wait()
				AutoHaki()
				EquipWeapon(_G.SelectWeapon)
				
				-- Setup boss
				boss.HumanoidRootPart.CanCollide = false
				boss.Humanoid.WalkSpeed = 0
				boss.Head.CanCollide = false
				boss.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
				
				-- Attack boss
				topos(boss.HumanoidRootPart.CFrame * Pos)
				sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
				
			until not _G.Auto_Sea2 or boss.Humanoid.Health <= 0 or not boss:IsDescendantOf(workspace)
			
			-- Boss defeated - travel to Sea 2
			if boss.Humanoid.Health <= 0 and _G.Auto_Sea2 then
				print("✅ Boss defeated. Traveling to Sea 2...")
				task.wait(2)
				pcall(function()
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
				end)
			end
		end
		
		-- Main loop
		spawn(function()
			while task.wait(1) do
				if _G.Auto_Sea2 then
					local player = game.Players.LocalPlayer
					local char = player.Character or player.CharacterAdded:Wait()
					local hrp = char:WaitForChild("HumanoidRootPart", 3)
					local level = player:FindFirstChild("Data") and player.Data:FindFirstChild("Level")
					
					if hrp and level and level.Value >= 700 and World1 then
						-- Step 1: Go to quest giver
						local questCFrame = CFrame.new(4852.93603515625, 5.686506748199463, 719.44384765625)
						repeat
							topos(questCFrame)
							task.wait(0.5)
						until (hrp.Position - questCFrame.Position).Magnitude <= 3 or not _G.Auto_Sea2
						
						-- Step 2: Accept quest
						pcall(function()
							game.ReplicatedStorage.Remotes.CommF_:InvokeServer("DressrosaQuestProgress", "Detective")
						end)
						
						-- Step 3: Equip key if available
						if HasKey() then
							EquipWeapon("Key")
						end
						
						-- Step 4: Go to ice door
						local doorCFrame = CFrame.new(1347.6932373046875, 37.38442611694336, -1325.1688232421875)
						repeat
							topos(doorCFrame)
							task.wait(0.5)
						until (hrp.Position - doorCFrame.Position).Magnitude <= 3 or not _G.Auto_Sea2
						
						task.wait(0.5)
						
						-- Step 5: Find and fight Ice Admiral
						local boss = FindIceAdmiral()
						if boss then
							FightBoss(boss)
						else
							-- Boss not spawned, return to island
							game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa")
						end
					end
				end
			end
		end)
	end
	
	if World2 then 
		local Sea3Quest = v16.Main:AddSection("Third Sea Quests")
		local ThirdSeaQuest = v16.Main:AddToggle("ToggleThirdSeaQuest", {
			Title = "Auto Third Sea",
			Description = "",
			Default = false
		})
		ThirdSeaQuest:OnChanged(function(v)
			_G.ThirdSea = v;
			StopTween(_G.ThirdSea);
		end)
		spawn(function()
			while wait() do
				if _G.ThirdSea then
					pcall(function()
						if ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 1500) and World2) then
							_G.Level = false;
							if (game:GetService("ReplicatedStorage").Remotes['CommF_']:InvokeServer("ZQuestProgress", "General") == 0) then
								topos(CFrame.new( -1926.3221435547, 12.819851875305, 1738.3092041016));
								if ((CFrame.new( -1926.3221435547, 12.819851875305, 1738.3092041016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10) then
									wait(1.5);
									game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ZQuestProgress", "Begin");
								end
								wait(1.8);
								if game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") then
									for v3032, v3033 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if (v3033.Name == "rip_indra") then
											OldCFrameThird = v3033.HumanoidRootPart.CFrame;
											repeat
												task.wait();
												AutoHaki();
												EquipWeapon(_G.SelectWeapon);
												topos(v3033.HumanoidRootPart.CFrame * Pos );
												v3033.HumanoidRootPart.CFrame = OldCFrameThird;
												v3033.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
												v3033.HumanoidRootPart.CanCollide = false;
												v3033.Humanoid.WalkSpeed = 0;
												game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou");
												sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
											until (_G.ThirdSea == false) or (v3033.Humanoid.Health <= 0) or  not v3033.Parent
										end
									end
								elseif ( not game:GetService("Workspace").Enemies:FindFirstChild("rip_indra") and ((CFrame.new( -26880.93359375, 22.848554611206, 473.18951416016).Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 1000)) then
									topos(CFrame.new( -26880.93359375, 22.848554611206, 473.18951416016));
								end
							end
						end
					end);
				end
			end
		end);
		local BartlioQuest = v16.Main:AddToggle("ToggleBartlioQuest", {
			Title = "Bartlio Quest",
			Description = "",
			Default = false
		})
		BartlioQuest:OnChanged(function(v)
			_G.Bartilo = v;
		end)
		spawn(function()
			pcall(function()
				while wait(0.1) do
					if _G.Bartilo then
						if ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 800) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0)) then
							if (string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "Swan Pirates") and string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text, "50") and (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == true)) then
								if game:GetService("Workspace").Enemies:FindFirstChild("Swan Pirate") then
									Ms = "Swan Pirate";
									for v2919, v2920 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
										if (v2920.Name == Ms) then
											pcall(function()
												repeat
													task.wait();
													sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
													EquipWeapon(_G.SelectWeapon);
													AutoHaki();
													v2920.HumanoidRootPart.Transparency = 1;
													v2920.HumanoidRootPart.CanCollide = false;
													v2920.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
													topos(v2920.HumanoidRootPart.CFrame * Pos );
													PosMonBarto = v2920.HumanoidRootPart.CFrame;
													AutoBartiloBring = true;
												until  not v2920.Parent or (v2920.Humanoid.Health <= 0) or (_G.Bartilo == false) or (game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false)
												AutoBartiloBring = false;
											end);
										end
									end
								else
									repeat
										topos(CFrame.new(932.624451, 156.106079, 1180.27466, -0.973085582, 4.5513712e-8, -0.230443969, 2.6702471e-8, 1, 8.474911e-8, 0.230443969, 7.631471e-8, -0.973085582));
										wait();
									until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(932.624451, 156.106079, 1180.27466, -0.973085582, 4.5513712e-8, -0.230443969, 2.6702471e-8, 1, 8.474911e-8, 0.230443969, 7.631471e-8, -0.973085582)).Magnitude <= 10)
								end
							else
								repeat
									topos(CFrame.new( -456.28952, 73.0200958, 299.895966));
									wait();
								until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -456.28952, 73.0200958, 299.895966)).Magnitude <= 10)
								wait(1.1);
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", "BartiloQuest", 1);
							end
						elseif ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 800) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1)) then
							if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy") then
								Ms = "Jeremy";
								for v2921, v2922 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
									if (v2922.Name == Ms) then
										OldCFrameBartlio = v2922.HumanoidRootPart.CFrame;
										repeat
											task.wait();
											sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
											EquipWeapon(_G.SelectWeapon);
											AutoHaki();
											v2922.HumanoidRootPart.Transparency = 1;
											v2922.HumanoidRootPart.CanCollide = false;
											v2922.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
											v2922.HumanoidRootPart.CFrame = OldCFrameBartlio;
											topos(v2922.HumanoidRootPart.CFrame * Pos );
											sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
										until  not v2922.Parent or (v2922.Humanoid.Health <= 0) or (_G.Bartilo == false)
									end
								end
							elseif game:GetService("ReplicatedStorage"):FindFirstChild("Jeremy [Lv. 850] [Boss]") then
								repeat
									topos(CFrame.new( -456.28952, 73.0200958, 299.895966));
									wait();
								until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -456.28952, 73.0200958, 299.895966)).Magnitude <= 10)
								wait(1.1);
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo");
								wait(1);
								repeat
									topos(CFrame.new(2099.88159, 448.931, 648.997375));
									wait();
								until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10)
								wait(2);
							else
								repeat
									topos(CFrame.new(2099.88159, 448.931, 648.997375));
									wait();
								until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(2099.88159, 448.931, 648.997375)).Magnitude <= 10)
							end
						elseif ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 800) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 2)) then
							repeat
								topos(CFrame.new( -1850.49329, 13.1789551, 1750.89685));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1850.49329, 13.1789551, 1750.89685)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1858.87305, 19.3777466, 1712.01807));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1858.87305, 19.3777466, 1712.01807)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1803.94324, 16.5789185, 1750.89685));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1803.94324, 16.5789185, 1750.89685)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1858.55835, 16.8604317, 1724.79541));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1858.55835, 16.8604317, 1724.79541)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1869.54224, 15.987854, 1681.00659));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1869.54224, 15.987854, 1681.00659)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1800.0979, 16.4978027, 1684.52368));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1800.0979, 16.4978027, 1684.52368)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1819.26343, 14.795166, 1717.90625));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1819.26343, 14.795166, 1717.90625)).Magnitude <= 10)
							wait(1);
							repeat
								topos(CFrame.new( -1813.51843, 14.8604736, 1724.79541));
								wait();
							until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1813.51843, 14.8604736, 1724.79541)).Magnitude <= 10)
							v14.Notify({
								Title = "Hiu Hub",
								Content = "Bartilo Quest Done!",
								Duration = 5
							})
						end
					end
				end
			end);
		end);
	end
	
	
	-----------Tab Stats------------------------------------------------------
	_G.Point = 3
	local Kaitunstats = v16.Stats:AddToggle("ToggleKaitunStats", {
		Title = "Auto Add Stats",
		Description = "",
		Default = false
	})
	Kaitunstats:OnChanged(function(v)
		_G.Stats_Kaitun = v;
	end)
	spawn(function()
		while wait() do
			pcall(function()
				if _G.Stats_Kaitun then
					if World1 then
						local v2292 = {
							[1] = "AddPoint",
							[2] = "Melee",
							[3] = _G.Point
						};
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v2292));
					elseif World2 then
						local v2693 = {
							[1] = "AddPoint",
							[2] = "Melee",
							[3] = _G.Point
						};
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v2693));
						local v2693 = {
							[1] = "AddPoint",
							[2] = "Defense",
							[3] = _G.Point
						};
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v2693));
					end
				end
			end);
		end
	end);
	local v01 = v16.Stats:AddToggle("ToggleMelee", {
		Title = "Add Melee",
		Description = "",
		Default = false
	});
	v01:OnChanged(function(v)
		_G.Auto_Stats_Melee = v;
	end);
	v17.ToggleMelee:SetValue(false);
	local v02 = v16.Stats:AddToggle("ToggleDe", {
		Title = "Add Defense",
		Description = "",
		Default = false
	});
	v02:OnChanged(function(v)
		_G.Auto_Stats_Defense = v;
	end);
	v17.ToggleDe:SetValue(false);
	local v09 = v16.Stats:AddToggle("ToggleSword", {
		Title = "Add Sword",
		Description = "",
		Default = false
	});
	v09:OnChanged(function(v)
		_G.Auto_Stats_Sword = v;
	end);
	v17.ToggleSword:SetValue(false);
	local v010 = v16.Stats:AddToggle("ToggleGun", {
		Title = "Add Gun",
		Description = "",
		Default = false
	});
	v010:OnChanged(function(v)
		_G.Auto_Stats_Gun = v;
	end);
	v17.ToggleGun:SetValue(false);
	local v011 = v16.Stats:AddToggle("ToggleFruit", {
		Title = "Add Blox Fruit",
		Description = "",
		Default = false
	});
	v011:OnChanged(function(v)
		_G.Auto_Stats_Devil_Fruit = v;
	end);
	v17.ToggleFruit:SetValue(false);
	spawn(function()
		while wait() do
			if _G.Auto_Stats_Devil_Fruit then
				local v737 = {
					[1] = "AddPoint",
					[2] = "Demon Fruit",
					[3] = 3
				};
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v737));
			end
		end
	end);
	spawn(function()
		while wait() do
			if _G.Auto_Stats_Gun then
				local v738 = {
					[1] = "AddPoint",
					[2] = "Gun",
					[3] = 3
				};
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v738));
			end
		end
	end);
	spawn(function()
		while wait() do
			if _G.Auto_Stats_Sword then
				local v739 = {
					[1] = "AddPoint",
					[2] = "Sword",
					[3] = 3
				};
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v739));
			end
		end
	end);
	spawn(function()
		while wait() do
			if _G.Auto_Stats_Defense then
				local v740 = {
					[1] = "AddPoint",
					[2] = "Defense",
					[3] = 3
				};
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v740));
			end
		end
	end);
	spawn(function()
		while wait() do
			if _G.Auto_Stats_Melee then
				local v741 = {
					[1] = "AddPoint",
					[2] = "Melee",
					[3] = 3
				};
				game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v741));
			end
		end
	end);
	-------Tab Mic---------------------------
	local v020 = {
		"KITT_RESET",
		"Sub2UncleKizaru",
		"SUB2GAMERROBOT_RESET1",
		"Sub2Fer999",
		"Enyu_is_Pro",
		"JCWK",
		"StarcodeHEO",
		"MagicBus",
		"KittGaming",
		"Sub2CaptainMaui",
		"Sub2OfficalNoobie",
		"TheGreatAce",
		"Sub2NoobMaster123",
		"Sub2Daigrock",
		"Axiore",
		"StrawHatMaine",
		"TantaiGaming",
		"Bluxxy",
		"SUB2GAMERROBOT_EXP1",
		"Chandler",
		"NOMOREHACK",
		"BANEXPLOIT",
		"WildDares",
		"BossBuild",
		"GetPranked",
		"EARN_FRUITS",
		"FIGHT4FRUIT",
		"NOEXPLOITER",
		"NOOB2ADMIN",
		"CODESLIDE",
		"ADMINHACKED",
		"ADMINDARES",
		"fruitconcepts",
		"krazydares",
		"TRIPLEABUSE",
		"SEATROLLING",
		"24NOADMIN",
		"REWARDFUN",
		"NEWTROLL",
		"fudd10_v2",
		"Fudd10",
		"Bignews",
		"SECRET_ADMIN"
	};
	
	v16.Misc:AddButton({
		Title = "Redeem All Code",
		Description = "",
		Callback = function()
			for v559, v560 in ipairs(v020) do
				RedeemCode(v560);
			end
		end
	});
	function RedeemCode(v377)
		game:GetService("ReplicatedStorage").Remotes.Redeem:InvokeServer(v377);
	end
	local v4025 = v16.Setting:AddSection("Setting Fram")
	local v81 = {
		"Melee",
		"Sword",
		"Blox Fruit",
		"Gun"
	};
	local v4026 = v16.Setting:AddDropdown("DropdownWeapon", {
		Title = "Select Weapon",
		Description = "",
		Values = v81,
		Multi = false,
		Default = 1
	});
	v4026:SetValue("Melee")
	v4026:OnChanged(function(v4027)
		_G.SelectWeapon = v4027;
	end);
	task.spawn(function()
		while wait() do
			pcall(function()
				if (_G.SelectWeapon == "Melee") then
					for v2193, v2194 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if (v2194.ToolTip == "Melee") then
							if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v2194.Name)) then
								_G.SelectWeapon = v2194.Name;
							end
						end
					end
				elseif (_G.SelectWeapon == "Sword") then
					for v2428, v2429 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if (v2429.ToolTip == "Sword") then
							if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v2429.Name)) then
								_G.SelectWeapon = v2429.Name;
							end
						end
					end
				elseif (_G.SelectWeapon == "Gun") then
					for v2706, v2707 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if (v2707.ToolTip == "Gun") then
							if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v2707.Name)) then
								_G.SelectWeapon = v2707.Name;
							end
						end
					end
				elseif (_G.SelectWeapon == "Blox Fruit") then
					for v2903, v2904 in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
						if (v2904.ToolTip == "Blox Fruit") then
							if game.Players.LocalPlayer.Backpack:FindFirstChild(tostring(v2904.Name)) then
								_G.SelectWeapon = v2904.Name;
							end
						end
					end
				end
			end);
		end
	end);
	local v82 = {
		"Normal",
		"Fast",
		"Very Fast",
		"Super Fast"
	};

	local v4028 = v16.Setting:AddDropdown("DropdownAttackDelay", {
		Title = "Attack Delay",
		Description = "",
		Values = v82,
		Multi = false,
		Default = 1
	});
	v4028:SetValue("Fast")
	v4028:OnChanged(function(v4029)
		_G.FastAttackDelay = v4029;
	end);
	spawn(function()
		while wait(0.1) do
			if _G.FastAttackDelay then
				pcall(function()
					if (_G.FastAttackDelay == "Normal") then
						_G.FastAttackDelay = 0.15;
					elseif (_G.FastAttackDelay == "Fast") then
						_G.FastAttackDelay = 0.1;
					elseif (_G.FastAttackDelay == "Very Fast") then
						_G.FastAttackDelay = 0.01;
					elseif (_G.FastAttackDelay == "Super Fast") then
						_G.FastAttackDelay = 0;
					end
				end);
			end
		end
	end);
	_G.FastAttack = true;
	if _G.FastAttack then
		local _ENV = (getgenv or getrenv or getfenv)();
		local function v912(v1856, v1857)
			local v1858, v1859 = pcall(function()
				return v1856:WaitForChild(v1857);
			end);
			if ( not v1858 or  not v1859) then
				warn("noooooo: "   .. v1857 );
			end
			return v1859;
		end
		local function v913(v1860, ...)
			local v1861 = v1860;
			for v2001, v2002 in {
				...
			} do
				v1861 = v1861:FindFirstChild(v2002) or v912(v1861, v2002) ;
				if  not v1861 then
					break;
				end
			end
			return v1861;
		end
		local v914 = game:GetService("VirtualInputManager");
		local v915 = game:GetService("CollectionService");
		local v916 = game:GetService("ReplicatedStorage");
		local v917 = game:GetService("TeleportService");
		local v918 = game:GetService("RunService");
		local v919 = game:GetService("Players");
		local v920 = v919.LocalPlayer;
		if  not v920 then
			warn("Không tìm thấy người chơi cục bộ.");
			return;
		end
		local v921 = v912(v916, "Remotes");
		if  not v921 then
			return;
		end
		local v922 = v912(v921, "Validator");
		local v923 = v912(v921, "CommF_");
		local v924 = v912(v921, "CommE");
		local v925 = v912(workspace, "ChestModels");
		local v926 = v912(workspace, "_WorldOrigin");
		local v927 = v912(workspace, "Characters");
		local v928 = v912(workspace, "Enemies");
		local v929 = v912(workspace, "Map");
		local v930 = v912(v926, "EnemySpawns");
		local v931 = v912(v926, "Locations");
		local v932 = v918.RenderStepped;
		local v933 = v918.Heartbeat;
		local v934 = v918.Stepped;
		local v935 = v912(v916, "Modules");
		local v936 = v912(v935, "Net");
		local v937 = sethiddenproperty or function(...)
			return ...;
		end ;
		local v938 = setupvalue or (debug and debug.setupvalue) ;
		local v939 = getupvalue or (debug and debug.getupvalue) ;
		local v940 = {
			AutoClick = true,
			ClickDelay = 0
		};
		local v941 = {};
		v941.FastAttack = (function()
			if _ENV.rz_FastAttack then
				return _ENV.rz_FastAttack;
			end
			local v1862 = {
				Distance = 100,
				attackMobs = true,
				attackPlayers = true,
				Equipped = nil
			};
			local v1863 = v912(v936, "RE/RegisterAttack");
			local v1864 = v912(v936, "RE/RegisterHit");
			local function v1865(v2003)
				return v2003 and v2003:FindFirstChild("Humanoid") and (v2003.Humanoid.Health > 0) ;
			end
			local function v1866(v2004, v2005)
				local v2006 = nil;
				for v2123, v2124 in v2005:GetChildren() do
					local v2125 = v2124:FindFirstChild("Head");
					if (v2125 and v1865(v2124) and (v920:DistanceFromCharacter(v2125.Position) < v1862.Distance)) then
						if (v2124 ~= v920.Character) then
							table.insert(v2004, {
								v2124,
								v2125
							});
							v2006 = v2125;
						end
					end
				end
				return v2006;
			end
			v1862.Attack = function(v2007, v2008, v2009)
				if ( not v2008 or ( #v2009 == 0)) then
					return;
				end
				v1863:FireServer(v940.ClickDelay or 0 );
				v1864:FireServer(v2008, v2009);
			end;
			v1862.AttackNearest = function(v2010)
				local v2011 = {};
				local v2012 = v1866(v2011, v928);
				local v2013 = v1866(v2011, v927);
				if ( #v2011 > 0) then
					v2010:Attack(v2012 or v2013 , v2011);
				else
					task.wait(0);
				end
			end;
			v1862.BladeHits = function(v2014)
				local v2015 = v1865(v920.Character) and v920.Character:FindFirstChildOfClass("Tool") ;
				if (v2015 and (v2015.ToolTip ~= "Gun")) then
					v2014:AttackNearest();
				else
					task.wait(0);
				end
			end;
			task.spawn(function()
				while task.wait(v940.ClickDelay) do
					if v940.AutoClick then
						v1862:BladeHits();
					end
				end
			end);
			_ENV.rz_FastAttack = v1862;
			return v1862;
		end)();
	end
	local v4030 = v16.Setting:AddSection("Tween")
	local v91 = {
		"180",
		"250",
		"300",
		"325",
		"350"
	};
	getgenv().TweenSpeed = "300";
	local v4031 = v16.Setting:AddDropdown("DropdownTweenSpeed", {
		Title = "Tween Speed",
		Description = "",
		Values = v91,
		Multi = false,
		Default = 1
	});
	v4031:SetValue("300")
	v4031:OnChanged(function(v4032)
		getgenv().TweenSpeed = v4032;
	end);

	local v4033 = v16.Setting:AddToggle("ToggleBringMob", {
		Title = "Bring Mob",
		Description = "",
		Default = true
	});
	v4033:OnChanged(function(v4034)
		_G.BringMonster = v4034;
	end);

	spawn(function()
		while task.wait() do
			pcall(function()
				if _G.BringMonster then
					CheckQuest()

					local brought = 0 -- đếm số quái đã gom

					for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if brought >= 3 then
							break -- dừng gom nếu đủ 3 quái
						end
						if _G.Level and StartMagnet and enemy.Name == Mon 
							and enemy:FindFirstChild("Humanoid") 
							and enemy:FindFirstChild("HumanoidRootPart") 
							and enemy.Humanoid.Health > 0 then

							local distance = (enemy.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
							local isSpecial = (Mon == "Factory Staff [Lv. 800]" or Mon == "Monkey [Lv. 14]" or Mon == "Gorilla [Lv. 20]" or Mon == "Dragon Crew Warrior [Lv. 1575]" or Mon == "Dragon Crew Archer [Lv. 1600]" or Mon == "Brute [lv. 45]" or Mon == "Snow Bandit [Lv. 90]" or Mon == "Mercenary [Lv. 725]")

							if (isSpecial and distance <= 220) or (not isSpecial and distance <= _G.BringMode) then
								-- Gom quái
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
								enemy.HumanoidRootPart.CFrame = PosMon
								enemy.Humanoid:ChangeState(14)
								enemy.HumanoidRootPart.CanCollide = false
								enemy.Head.CanCollide = false
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy()
								end
								sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
								brought = brought + 1
							end
						end
					end
				end
			end)
		end
	end)

	spawn(function()
		while task.wait() do
			pcall(function()
				if _G.BringMonster then
					local brought = 0 -- đếm số quái đã gom

					for _, enemy in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
						if brought >= 3 then
							break -- chỉ cho phép tối đa 2 quái
						end
						
						-- Sử dụng enemy thay vì v2218 (biến không được định nghĩa)
						if (_G.Ectoplasm and StartEctoplasmMagnet) then
							if (string.find(enemy.Name, "Ship") and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0) and ((enemy.HumanoidRootPart.Position - EctoplasmMon.Position).Magnitude <= _G.BringMode)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.HumanoidRootPart.CFrame = EctoplasmMon;
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.Rengoku and StartRengokuMagnet) then
							if (((enemy.Name == "Snow Lurker") or (enemy.Name == "Arctic Warrior")) and ((enemy.HumanoidRootPart.Position - RengokuMon.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(1500, 1500, 1500);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = RengokuMon;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.MusketeerHat and StartMagnetMusketeerhat) then
							if ((enemy.Name == "Forest Pirate") and ((enemy.HumanoidRootPart.Position - MusketeerHatMon.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = MusketeerHatMon;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.ObservationHakiV2 and Mangnetcitzenmon) then
							if ((enemy.Name == "Forest Pirate") and ((enemy.HumanoidRootPart.Position - MusketeerHatMon.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = PosHee;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.EvoRace and StartEvoMagnet) then
							if ((enemy.Name == "Zombie") and ((enemy.HumanoidRootPart.Position - PosMonEvo.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = PosMonEvo;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.Bartilo and AutoBartiloBring) then
							if ((enemy.Name == "Swan Pirate") and ((enemy.HumanoidRootPart.Position - PosMonBarto.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = PosMonBarto;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.FarmFruitMastery and StartMasteryFruitMagnet) then
							if (enemy.Name == "Monkey") then
								if (((enemy.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
									enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
									enemy.Humanoid:ChangeState(14);
									enemy.HumanoidRootPart.CanCollide = false;
									enemy.Head.CanCollide = false;
									enemy.HumanoidRootPart.CFrame = PosMonMasteryFruit;
									if enemy.Humanoid:FindFirstChild("Animator") then
										enemy.Humanoid.Animator:Destroy();
									end
									sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
									brought = brought + 1
								end
							elseif (enemy.Name == "Factory Staff") then
								if (((enemy.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
									enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
									enemy.Humanoid:ChangeState(14);
									enemy.HumanoidRootPart.CanCollide = false;
									enemy.Head.CanCollide = false;
									enemy.HumanoidRootPart.CFrame = PosMonMasteryFruit;
									if enemy.Humanoid:FindFirstChild("Animator") then
										enemy.Humanoid.Animator:Destroy();
									end
									sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
									brought = brought + 1
								end
							elseif (enemy.Name == Mon) then
								if (((enemy.HumanoidRootPart.Position - PosMonMasteryFruit.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
									enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
									enemy.Humanoid:ChangeState(14);
									enemy.HumanoidRootPart.CanCollide = false;
									enemy.Head.CanCollide = false;
									enemy.HumanoidRootPart.CFrame = PosMonMasteryFruit;
									if enemy.Humanoid:FindFirstChild("Animator") then
										enemy.Humanoid.Animator:Destroy();
									end
									sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
									brought = brought + 1
								end
							end
						end
						
						if (_G.FarmGunMastery and StartMasteryGunMagnet) then
							if (enemy.Name == "Monkey") then
								if (((enemy.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
									enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
									enemy.Humanoid:ChangeState(14);
									enemy.HumanoidRootPart.CanCollide = false;
									enemy.Head.CanCollide = false;
									enemy.HumanoidRootPart.CFrame = PosMonMasteryGun;
									if enemy.Humanoid:FindFirstChild("Animator") then
										enemy.Humanoid.Animator:Destroy();
									end
									sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
									brought = brought + 1
								end
							elseif (enemy.Name == "Factory Staff") then
								if (((enemy.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
									enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
									enemy.Humanoid:ChangeState(14);
									enemy.HumanoidRootPart.CanCollide = false;
									enemy.Head.CanCollide = false;
									enemy.HumanoidRootPart.CFrame = PosMonMasteryGun;
									if enemy.Humanoid:FindFirstChild("Animator") then
										enemy.Humanoid.Animator:Destroy();
									end
									sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
									brought = brought + 1
								end
							elseif (enemy.Name == Mon) then
								if (((enemy.HumanoidRootPart.Position - PosMonMasteryGun.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
									enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
									enemy.Humanoid:ChangeState(14);
									enemy.HumanoidRootPart.CanCollide = false;
									enemy.Head.CanCollide = false;
									enemy.HumanoidRootPart.CFrame = PosMonMasteryGun;
									if enemy.Humanoid:FindFirstChild("Animator") then
										enemy.Humanoid.Animator:Destroy();
									end
									sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
									brought = brought + 1
								end
							end
						end
						
						if (_G.Bone and StartMagnetBoneMon) then
							if (((enemy.Name == "Reborn Skeleton") or (enemy.Name == "Living Zombie") or (enemy.Name == "Demonic Soul") or (enemy.Name == "Posessed Mummy")) and ((enemy.HumanoidRootPart.Position - PosMonBone.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = PosMonBone;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.FarmCandy and StartCandyMagnet) then
							if (((enemy.Name == "Ice Cream Chef") or (enemy.Name == "Ice Cream Commander")) and ((enemy.HumanoidRootPart.Position - CandyMon.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = CandyMon;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (StardFarm and FarmMag) then
							if (((enemy.Name == "Cocoa Warrior") or (enemy.Name == "Chocolate Bar Battler") or (enemy.Name == "Sweet Thief") or (enemy.Name == "Candy Rebel")) and ((enemy.HumanoidRootPart.Position - PosGG.Position).Magnitude <= 250) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = PosGG;
								if enemy.Humanoid:FindFirstCity("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.Farmfast and StardMag) then
							if (((enemy.Name == "Shanda") or (enemy.Name == "Shanda")) and ((enemy.HumanoidRootPart.Position - FastMon.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = FastMon;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
						
						if (_G.DoughtBoss and MagnetDought) then
							if (((enemy.Name == "Cookie Crafter") or (enemy.Name == "Cake Guard") or (enemy.Name == "Baking Staff") or (enemy.Name == "Head Baker")) and ((enemy.HumanoidRootPart.Position - PosMonDoughtOpenDoor.Position).Magnitude <= _G.BringMode) and enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and (enemy.Humanoid.Health > 0)) then
								enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50);
								enemy.Humanoid:ChangeState(14);
								enemy.HumanoidRootPart.CanCollide = false;
								enemy.Head.CanCollide = false;
								enemy.HumanoidRootPart.CFrame = PosMonDoughtOpenDoor;
								if enemy.Humanoid:FindFirstChild("Animator") then
									enemy.Humanoid.Animator:Destroy();
								end
								sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
								brought = brought + 1
							end
						end
					end
				end
			end);
		end
	end);
	-- Tối ưu hóa script gom quái
	local Players = game:GetService("Players")
	local Workspace = game:GetService("Workspace")
	local LocalPlayer = Players.LocalPlayer

	-- Thiết lập SimulationRadius một lần
	task.spawn(function()
		while true do
			wait(1) -- Giảm tần suất check xuống 1 giây
			if setscriptable then
				setscriptable(LocalPlayer, "SimulationRadius", true)
			end
			if sethiddenproperty then
				sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge)
			end
		end
	end)

	-- Tối ưu function InMyNetWork
	local function InMyNetWork(part)
		if isnetworkowner then
			return isnetworkowner(part)
		end
		-- Tính toán khoảng cách một lần
		local distance = (part.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
		return distance <= _G.BringMode
	end

	-- Function tối ưu để modify quái
	local function ModifyEnemy(enemy, targetPos)
		local humanoidRootPart = enemy.HumanoidRootPart
		local humanoid = enemy.Humanoid
		
		-- Batch modify properties
		humanoidRootPart.CFrame = targetPos
		humanoidRootPart.Size = Vector3.new(60, 60, 60)
		humanoidRootPart.Transparency = 1
		humanoidRootPart.CanCollide = false
		
		humanoid.JumpPower = 0
		humanoid.WalkSpeed = 0
		
		enemy.Head.CanCollide = false
		
		-- Remove animator if exists
		local animator = humanoid:FindFirstChild("Animator")
		if animator then
			animator:Destroy()
		end
		
		-- Change states
		humanoid:ChangeState(11)
		humanoid:ChangeState(14)
	end

	-- Function chính để bring monsters
	local function BringMonsters()
		local mobCount = 0
		local targetPos = nil
		local shouldBring = false
		
		-- Xác định target position và điều kiện
		if MakoriGayMag and _G.BringMonster then
			targetPos = PosGay
			shouldBring = true
		elseif Anchor and _G.BringMonster then
			targetPos = PosNarathiwat  
			shouldBring = true
		elseif (_G.FarmNearest and AutoFarmNearestMagnet) or (SelectMag and _G.BringMonster) then
			targetPos = PosMon
			shouldBring = true
		end
		
		if not shouldBring or not targetPos then return end
		
		-- Cache player position để tránh tính toán lặp lại
		local playerPos = LocalPlayer.Character.HumanoidRootPart.Position
		local enemies = Workspace.Enemies:GetChildren()
		
		-- Duyệt qua enemies
		for i = 1, #enemies do
			if mobCount >= 3 then break end
			
			local enemy = enemies[i]
			
			-- Kiểm tra tồn tại các components cần thiết
			if enemy.HumanoidRootPart and enemy.Humanoid and enemy.Head then
				-- Kiểm tra không phải boss
				if not string.find(enemy.Name, "Boss") then
					-- Tính khoảng cách một lần
					local distance = (enemy.HumanoidRootPart.Position - playerPos).Magnitude
					
					if distance <= _G.BringMode and InMyNetWork(enemy.HumanoidRootPart) then
						mobCount = mobCount + 1
						ModifyEnemy(enemy, targetPos)
					end
				end
			end
		end
	end

	-- Main loop tối ưu
	task.spawn(function()
		while task.wait(0.1) do -- Giảm tần suất xuống 0.1s
			pcall(BringMonsters)
		end
	end)

	local v93 = {"155", "250", "350"}
	local v4035 = v16.Setting:AddDropdown("DropdownBringMode", {
		Title = "Bring Mode distance",
		Description = "",
		Values = v93,
		Multi = false,
		Default = 1
	});
	if World1 then
		v4035:SetValue("155")
	elseif World2 or World3 then
		v4035:SetValue("250")
	end
	v4035:OnChanged(function(v4036)
		_G.BringMode = v4036;
	end);
	spawn(function()
		while wait(0.1) do
			if _G.BringMode then
				pcall(function()
					if (_G.BringMode == "155") then
						_G.BringMode = 155;
					elseif (_G.BringMode == "250") then
						_G.BringMode = 250;
					elseif (_G.BringMode == "350") then
						_G.BringMode = 350;
					end
				end);
			end
		end
	end);

	
	local v4037 = v16.Setting:AddToggle("ToggleBuso", {
		Title = "Buso Haki",
		Description = "",
		Default = true
	});
	v4037:OnChanged(function(v4038)
		_G.Haki = v4038;
	end);
	spawn(function()
		while wait(0.1) do
			if _G.Haki then
				if  not game.Players.LocalPlayer.Character:FindFirstChild("HasBuso") then
					local v2208 = {
						[1] = "Buso"
					};
					game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(v2208));
				end
			end
		end
	end);
	local v3039 = v16.Setting:AddToggle("ToggleAutoClick", {
		Title = "Auto Click",
		Description = "",
		Default = false
	});
	v3039:OnChanged(function(v3040)
		_G.AutoClick = v3040;
	end);
	local v3041 = v16.Setting:AddToggle("ToggleRemoveNotifications", {
		Title = "Remove Notifications",
		Description = "",
		Default = false
	});
	v3041:OnChanged(function(v3042)
		_G.Remove_trct = v3042;
	end);
	spawn(function()
		while wait() do
			if _G.Remove_trct then
				game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false;
			else
				game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true;
			end
		end
	end);

	spawn(function()
		while wait() do
			if _G.WhiteScreen then
				for v2141, v2142 in pairs(game.Workspace['_WorldOrigin']:GetChildren()) do
					if ((v2142.Name == "CurvedRing") or (v2142.Name == "SlashHit") or (v2142.Name == "DamageCounter") or (v2142.Name == "SwordSlash") or (v2142.Name == "SlashTail") or (v2142.Name == "Sounds")) then
						v2142:Destroy();
					end
				end
			end
		end
	end);
	local v3043 = v16.Setting:AddToggle("ToggleWhiteScreen", {
		Title = "White Screen",
		Description = "",
		Default = false
	});
	v3043:OnChanged(function(v3044)
		_G.WhiteScreen = v3044;
		if (_G.WhiteScreen == true) then
			game:GetService("RunService"):Set3dRenderingEnabled(false);
		elseif (_G.WhiteScreen == false) then
			game:GetService("RunService"):Set3dRenderingEnabled(true);
		end
	end);    
	local v3045 = v16.Setting:AddToggle("ToggleHideMob", {
		Title = "Hide Mob",
		Description = "",
		Default = false
	});
	v3045:OnChanged(function(v3046)
		_G.inv = v3046;
		while wait() do
			if _G.inv then
				pcall(function()
					for v2209, v2210 in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
						if (v2210.ClassName == "MeshPart") then
							v2210.Transparency = 1;
						end
					end    
					for v2211, v2212 in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do    
						if (v2212.Name == "Head") then        
							v2212.Transparency = 1;    
						end
					end
					for v2213, v2214 in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
						if (v2214.ClassName == "Accessory") then
							v2214.Handle.Transparency = 1;    
						end
					end
					for v2215, v2216 in pairs(game:GetService("Workspace").Enemies:GetDescendants()) do
						if (v2216.ClassName == "Decal") then
							v2216.Transparency = 1;
						end    
					end
				end);
			end
		end
	end);
end

v14:Notify({
    Title = "Hiu Hub",
    Content = "Loading Successed",
    Duration = 5
});
------------L
