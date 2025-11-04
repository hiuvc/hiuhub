
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")

-- Reliable team selection method
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        l_Remotes_0.CommF_:InvokeServer("SetTeam", getgenv().team)
        task.wait(3)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end

print("-----Loading Ui-----")
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local v15 = Fluent:CreateWindow({
    Title = "Hiu Hub",
    SubTitle = "By hiuvc",
    TabWidth = 160,
    Theme = "Darker",
    Acrylic = true,
    Size = UDim2.fromOffset(540, 350),
    MinimizeKey = Enum.KeyCode.LeftControl
});
local v16 = {
    Server_Status = v15:AddTab({
        Title = "Server"
    }),
    Main = v15:AddTab({
        Title = "Main"
    }),
    Item = v15:AddTab({
        Title = "Item"
    }),
    Setting = v15:AddTab({
        Title = "Settings Fram"
    }),
    Stats = v15:AddTab({
        Title = "Stats"
    }),
    Teleport = v15:AddTab({
        Title = "Teleport"
    }),
    Fruit_Raid = v15:AddTab({
        Title = "Fruit/Raid"
    }),
    Race = v15:AddTab({
        Title = "Race"
    }),
    Sea = v15:AddTab({
        Title = "Sea Events"
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
v15:SelectTab(1)
local v17 = Fluent.Options;
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
            CFrameMon = CFrame.new(-1692.509765625, 9.30445384979248, -2931.4755859375);
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
------------------------------------------------------------------------------------------------------------------------
--// Services
getgenv().Seriality = getgenv().Seriality or false
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")

--// Player
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

--// CameraShaker
local CameraShakerR = require(ReplicatedStorage.Util.CameraShaker)
CameraShakerR:Stop()

--// Check if entity alive
local function IsEntityAlive(entity)
    local humanoid = entity:FindFirstChildOfClass("Humanoid")
    return humanoid and humanoid.Health > 0
end

--// Get enemies and players in range
local function GetEnemiesInRange(character, range)
    local enemies = Workspace.Enemies:GetChildren()
    local players = Players:GetPlayers()
    local targets = {}
    local playerPos = character:GetPivot().Position

    for _, enemy in ipairs(enemies) do
        local rootPart = enemy:FindFirstChild("HumanoidRootPart")
        if rootPart and IsEntityAlive(enemy) then
            if (rootPart.Position - playerPos).Magnitude <= range then
                table.insert(targets, enemy)
            end
        end
    end

    for _, otherPlayer in ipairs(players) do
        if otherPlayer ~= player and otherPlayer.Character then
            local rootPart = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
            if rootPart and IsEntityAlive(otherPlayer.Character) then
                if (rootPart.Position - playerPos).Magnitude <= range then
                    table.insert(targets, otherPlayer.Character)
                end
            end
        end
    end

    return targets
end

--// Attack function no cooldown
local function AttackNoCoolDown()
    local character = player.Character
    if not character then return end

    local equippedWeapon = nil
    for _, item in ipairs(character:GetChildren()) do
        if item:IsA("Tool") then
            equippedWeapon = item
            break
        end
    end
    if not equippedWeapon then return end

    local enemiesInRange = GetEnemiesInRange(character, 60)
    if #enemiesInRange == 0 then return end

    local modules = ReplicatedStorage:FindFirstChild("Modules")
    if not modules then return end

    local attackEvent = modules:WaitForChild("Net"):WaitForChild("RE/RegisterAttack")
    local hitEvent = modules:WaitForChild("Net"):WaitForChild("RE/RegisterHit")
    if not attackEvent or not hitEvent then return end

    local targets, mainTarget = {}, nil
    for _, enemy in ipairs(enemiesInRange) do
        if not enemy:GetAttribute("IsBoat") then
            local HitboxLimbs = {"RightLowerArm","RightUpperArm","LeftLowerArm","LeftUpperArm","RightHand","LeftHand"}
            local hitPart = enemy:FindFirstChild(HitboxLimbs[math.random(#HitboxLimbs)]) or enemy.PrimaryPart
            if hitPart then
                table.insert(targets, {enemy, hitPart})
                mainTarget = hitPart
            end
        end
    end
    if not mainTarget then return end

    attackEvent:FireServer(0)

    local playerScripts = player:FindFirstChild("PlayerScripts")
    if not playerScripts then return end

    local localScript = playerScripts:FindFirstChildOfClass("LocalScript")
    while not localScript do
        playerScripts.ChildAdded:Wait()
        localScript = playerScripts:FindFirstChildOfClass("LocalScript")
    end

    local hitFunction
    if getsenv then
        local success, scriptEnv = pcall(getsenv, localScript)
        if success and scriptEnv then
            hitFunction = scriptEnv._G.SendHitsToServer
        end
    end

    local successFlags, combatRemoteThread = pcall(function()
        return require(modules.Flags).COMBAT_REMOTE_THREAD or false
    end)

    if successFlags and combatRemoteThread and hitFunction then
        hitFunction(mainTarget, targets)
    elseif successFlags and not combatRemoteThread then
        hitEvent:FireServer(mainTarget, targets)
    end
end

--// Get monster near player
local function get_Monster()
    for _, enemy in pairs(Workspace.Enemies:GetChildren()) do
        local c = enemy:FindFirstChild("UpperTorso") or enemy:FindFirstChild("Head")
        if enemy:FindFirstChild("HumanoidRootPart", true) and c then
            if (c.Position - player.Character.HumanoidRootPart.Position).Magnitude <= 50 then
                return true, c.Position
            end
        end
    end
    for _, beast in pairs(Workspace.SeaBeasts:GetChildren()) do
        if beast:FindFirstChild("HumanoidRootPart") and beast:FindFirstChild("Health") and beast.Health.Value > 0 then
            return true, beast.HumanoidRootPart.Position
        end
    end
    for _, vehicle in pairs(Workspace.Enemies:GetChildren()) do
        if vehicle:FindFirstChild("Health") and vehicle.Health.Value > 0 and vehicle:FindFirstChild("VehicleSeat") then
            return true, vehicle.Engine.Position
        end
    end
    return false, nil
end

--// Activate tool functions
local function Actived()
    local tool = player.Character:FindFirstChildOfClass("Tool")
    if tool then
        for _, c in next, getconnections(tool.Activated) do
            if typeof(c.Function) == 'function' then
                getupvalues(c.Function)
            end
        end
    end
end

--// Main loop
task.spawn(function()
    RunService.Heartbeat:Connect(function()
        pcall(function()
            if not getgenv().Seriality then return end
            AttackNoCoolDown()
            local Pretool = player.Character:FindFirstChildOfClass("Tool")
            if Pretool then
                local ToolTip = Pretool.ToolTip
                local MobAura, Mon = get_Monster()
                if ToolTip == "Blox Fruit" and MobAura then
                    local LeftClickRemote = Pretool:FindFirstChild('LeftClickRemote')
                    if LeftClickRemote then
                        Actived()
                        LeftClickRemote:FireServer(Vector3.new(0.01, -500, 0.01), 1, true)
                        LeftClickRemote:FireServer(false)
                    end
                end
            end
        end)
    end)
end)



----------------Save Config--------------------------------
local player = game.Players.LocalPlayer
local HttpService = game:GetService("HttpService")
local StarterGui = game:GetService("StarterGui")

-- Đặt tên file theo tên người chơi
local configFileName = player.Name .. "_Config.json"
local Config = {}

-- Load config from file
local function LoadConfig()
    if isfile(configFileName) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(configFileName))
        end)
        if success and type(result) == "table" then
            Config = result
        end
    end
end

-- Save config to file
local function SaveConfig()
    writefile(configFileName, HttpService:JSONEncode(Config))
end

-- Set value and save
local function SetConfig(key, value)
    Config[key] = value
    SaveConfig()
end

-- Get value or default
local function GetConfig(key, default)
    return Config[key] ~= nil and Config[key] or default
end

-- Reset configuration
local function ResetConfig()
    Config = {}
    SaveConfig()
end


-- Run
LoadConfig()



local Player = game.Players.LocalPlayer    
local Http = game:GetService("HttpService")
local TPS = game:GetService("TeleportService")
local Api = "https://games.roblox.com/v1/games/"

local _place = game.PlaceId
local _id = game.JobId
local _servers = Api .. _place .. "/servers/Public?sortOrder=Desc&limit=100"

local function ListServers(cursor)
    local Raw = game:HttpGet(_servers .. ((cursor and "&cursor="..cursor) or ""))
    return Http:JSONDecode(Raw)
end

function Hop()
    local PlaceID = game.PlaceId
    local AllIDs = {}
    local foundAnything = ""
    local actualHour = os.date("!*t").hour
    local Deleted = false
    function TPReturner()
        local Site;
        if foundAnything == "" then
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
        else
            Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
        end        
        local ID = ""
        if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
            foundAnything = Site.nextPageCursor
        end        
        local num = 0
        for i,v in pairs(Site.data) do
            local Possible = true
            ID = tostring(v.id)            
            if tonumber(v.maxPlayers) > tonumber(v.playing) then
                for _,Existing in pairs(AllIDs) do
                    if num ~= 0 then
                        if ID == tostring(Existing) then
                            Possible = false
                        end
                    else
                        if tonumber(actualHour) ~= tonumber(Existing) then
                            local delFile = pcall(function()
                                AllIDs = {}
                                table.insert(AllIDs, actualHour)
                            end)
                        end
                    end
                    num = num + 1
                end
                if Possible == true then
                    table.insert(AllIDs, ID)
                    wait(0.1)
                    pcall(function()
                        game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                    end)
                    wait(1)
                    break
                end
            end
        end
    end
    function Teleport() 
        while true do
            pcall(function()
                TPReturner()
                if foundAnything ~= "" then
                    TPReturner()
                end
            end)
            wait(2)
        end
    end
    Teleport()
end



local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false

local last

local File = pcall(function()
   AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
   table.insert(AllIDs, actualHour)
   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
   local Site;
   if foundAnything == "" then
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
   else
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
   end
   local ID = ""
   if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
       foundAnything = Site.nextPageCursor
   end
   local num = 0;
   local extranum = 0
   for i,v in pairs(Site.data) do
       extranum += 1
       local Possible = true
       ID = tostring(v.id)
       if tonumber(v.maxPlayers) > tonumber(v.playing) then
           if extranum ~= 1 and tonumber(v.playing) < last or extranum == 1 then
               last = tonumber(v.playing)
           elseif extranum ~= 1 then
               continue
           end
           for _,Existing in pairs(AllIDs) do
               if num ~= 0 then
                   if ID == tostring(Existing) then
                       Possible = false
                   end
               else
                   if tonumber(actualHour) ~= tonumber(Existing) then
                       local delFile = pcall(function()
                           delfile("NotSameServers.json")
                           AllIDs = {}
                           table.insert(AllIDs, actualHour)
                       end)
                   end
               end
               num = num + 1
           end
           if Possible == true then
               table.insert(AllIDs, ID)
               wait()
               pcall(function()
                   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                   wait()
                   game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
               end)
               wait(4)
           end
       end
   end
end

function HopLessPeople()
   while wait() do
       pcall(function()
           TPReturner()
           if foundAnything ~= "" then
               TPReturner()
           end
       end)
   end
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
        if minDist < 2000 and distToTarget > 3500 then
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
        task.wait(0.5)
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
function TweenToPosition(targetCFrame)
    local char = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = char:WaitForChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    local distance = (targetCFrame.Position - humanoidRootPart.Position).Magnitude
    if humanoid then
        humanoid.WalkSpeed = 0
        humanoid.JumpPower = 50
    end
        -- Đảm bảo nhân vật không ngồi
    if humanoid.Sit == true then
        humanoid.Sit = false
    end
    local bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    bodyVelocity.Name = "ChestBodyVel"
    bodyVelocity.Parent = humanoidRootPart
    local tween = game:GetService("TweenService"):Create(humanoidRootPart, TweenInfo.new(distance / getgenv().TweenSpeed, Enum.EasingStyle.Linear), { CFrame = targetCFrame })
    tween:Play()
    tween.Completed:Wait()
    if humanoidRootPart:FindFirstChild("ChestBodyVel") then 
        humanoidRootPart.ChestBodyVel:Destroy() 
    end
    if humanoid then
        humanoid.WalkSpeed = 16
        humanoid.JumpPower = 50
    end
end

function CancelTween(doCancel)
    if not doCancel then
        _G.StopTween = true
        wait()
        -- Không tween lại vị trí hiện tại nữa
        wait()
        _G.StopTween = false
    end
end
-- Hàm chống rơi và NoClip
function EnableNoClipAndAntiGravity()
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if not character then return end
        
        -- NoClip cho tất cả các part
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        -- Anti-gravity
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- Xóa BodyVelocity cũ nếu có
            for _, child in pairs(hrp:GetChildren()) do
                if child:IsA("BodyVelocity") and child.Name == "ChestFarmAntiGravity" then
                    child:Destroy()
                end
            end
            
            -- Tạo BodyVelocity mới
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.Name = "ChestFarmAntiGravity"
            bodyVel.MaxForce = Vector3.new(0, 9999, 0)
            bodyVel.Velocity = Vector3.new(0, 0.5, 0) -- Đẩy nhẹ lên trên
            bodyVel.P = 1500 -- Lực mạnh để chống rơi tốt hơn
            bodyVel.Parent = hrp
            
            -- Chống trạng thái Stun
            if character:FindFirstChild("Stun") then
                character.Stun.Value = 0
            end
            
            -- Chống rơi
            if character:FindFirstChild("Humanoid") then
                character.Humanoid:ChangeState(11)
                character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
        end
    end)
end

-- Biến người chơi
local plr = game:GetService("Players").LocalPlayer
local IsTweening = false
-- Hàm chống rơi và NoClip
function EnableNoClipAndAntiGravity()
    pcall(function()
        local character = game.Players.LocalPlayer.Character
        if not character then return end
        
        -- NoClip cho tất cả các part
        for _, part in pairs(character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = false
            end
        end
        
        -- Anti-gravity
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if hrp then
            -- Xóa BodyVelocity cũ nếu có
            for _, child in pairs(hrp:GetChildren()) do
                if child:IsA("BodyVelocity") and child.Name == "ChestFarmAntiGravity" then
                    child:Destroy()
                end
            end
            
            -- Tạo BodyVelocity mới
            local bodyVel = Instance.new("BodyVelocity")
            bodyVel.Name = "ChestFarmAntiGravity"
            bodyVel.MaxForce = Vector3.new(0, 9999, 0)
            bodyVel.Velocity = Vector3.new(0, 0.5, 0) -- Đẩy nhẹ lên trên
            bodyVel.P = 1500 -- Lực mạnh để chống rơi tốt hơn
            bodyVel.Parent = hrp
            
            -- Chống trạng thái Stun
            if character:FindFirstChild("Stun") then
                character.Stun.Value = 0
            end
            
            -- Chống rơi
            if character:FindFirstChild("Humanoid") then
                character.Humanoid:ChangeState(11)
                character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
                character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
            end
        end
    end)
end

-- Chờ nhân vật hồi sinh
function WaitForRespawn()
    repeat
        task.wait()
    until plr and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") 
        and plr.Character:FindFirstChild("Humanoid") and plr.Character.Humanoid.Health > 0
    print("Character respawned successfully!")
end

-- Tween đến vị trí Pos (CFrame)
function Tween(Pos)
    EnableNoClipAndAntiGravity()
    -- Kiểm tra nếu biến plr chưa sẵn sàng
    if not plr then
        warn("Player (plr) is nil!")
        return
    end

    -- Nếu nhân vật chưa tồn tại hoặc đã chết → chờ hồi sinh
    if not plr.Character or not plr.Character:FindFirstChild("HumanoidRootPart") or 
       not plr.Character:FindFirstChild("Humanoid") or 
       plr.Character.Humanoid.Health <= 0 then
        print("Character is dead, waiting for respawn...")
        WaitForRespawn()
    end

    -- Kiểm tra lại sau khi hồi sinh
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and 
       plr.Character:FindFirstChild("Humanoid") and 
       plr.Character.Humanoid.Health > 0 then

        local char = plr.Character
        local hrp = char:FindFirstChild("HumanoidRootPart")
        local hum = char:FindFirstChild("Humanoid")

        -- Tính khoảng cách
        local Distance = (Pos.Position - hrp.Position).Magnitude

        -- Đảm bảo nhân vật không ngồi
        if hum.Sit == true then
            hum.Sit = false
        end

        -- Tạo tween
        local Tweeb
        pcall(function()
            Tweeb = game:GetService("TweenService"):Create(
                hrp,
                TweenInfo.new(Distance / (getgenv().TweenSpeed or 100), Enum.EasingStyle.Linear),
                {CFrame = Pos}
            )
        end)

        if Tweeb then
            IsTweening = true
            Tweeb:Play()

            Tweeb.Completed:Connect(function()
                IsTweening = false
                EnableNoClipAndAntiGravity()
            end)
        else
            warn("Failed to create Tween.")
        end
    else
        warn("Character not ready for tweening.")
    end
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
            if (_G.AdvanceDungeon or _G.DoughtBoss or _G.DungeonMobAura or _G.FarmChest or _G.Factory or _G.FarmBossHallow or _G.FarmSwanGlasses or _G.LongSword or _G.BlackSpikeycoat or _G.ElectricClaw or _G.FarmGunMastery or _G.HolyTorch or _G.LawRaid or _G.FarmBoss or _G.TwinHooks or _G.OpenSwanDoor or _G.Dragon_Trident or _G.Saber or _G.NoClip or _G.FarmFruitMastery or _G.FarmGunMastery or _G.TeleportIsland or _G.EvoRace or _G.FarmAllMsBypassType or _G.Observationv2 or _G.MusketeerHat or _G.Ectoplasm or _G.Rengoku or _G.Rainbow_Haki or _G.Observation or _G.DarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.BudySword or _G.OderSword or _G.AllBoss or _G.Sharkman or _G.Mastery_Fruit or _G.Mastery_Gun or _G.Dungeon or _G.Cavender or _G.Pole or _G.Kill_Ply or _G.Factory or _G.SecondSea or _G.TeleportPly or _G.Bartilo or _G.DarkBoss or _G.GrabChest or _G.Holy_Torch or _G.Level or _G.Clip or _G.Elitehunter or _G.ThirdSea or _G.Bone or _G.heart or _G.doughking or _G.FarmMaterial or _G.Guitar or _G.Dragon_Trident or _G.tushita or _G.waden or _G.pole or _G.saw or _G.ObservationHakiV2 or _G.FarmNearest or _G.Carvender or _G.TwinHook or AutoMobAura or _G.Tweenfruit or _G.TeleportNPC or _G.Kai or _G.Leather or _G.Wing or _G.Umm or _G.Makori_gay or Radioactive or Fish or Gunpowder or Dragon_Scale or Cocoafarm or Scrap or MiniHee or _G.FarmSeabaest or _G.CDK or _G.FarmMob or _G.MysticIsland or _G.FarmDungeon or _G.RaidPirate or _G.QuestRace or _G.TweenMGear or getgenv().AutoFarm or _G.PlayerHunter or _G.Factory or _G.Seabest or _G.SeaBest or _G.KillTial or _G.Saber or _G.Position_Spawn or _G.TPB or _G.Farmfast or _G.Race or _G.RaidPirate or Open_Color_Haki or _G.Terrorshark or FarmShark or _G.farmpiranya or _G.Fish_Crew_Member or _G.AppleAutoDriveBoat or _G.FrozenDimension or _G.FKitsune or _G.AutoCollectChest) then
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
        if (_G.DoughtBoss or _G.DungeonMobAura or _G.FarmChest or _G.AutoCollectChest or _G.FarmBossHallow or _G.Factory or _G.FarmSwanGlasses or _G.LongSword or _G.BlackSpikeycoat or _G.ElectricClaw or _G.FarmGunMastery or _G.HolyTorch or _G.LawRaid or _G.FarmBoss or _G.TwinHooks or _G.OpenSwanDoor or _G.Dragon_Trident or _G.Saber or _G.NoClip or _G.FarmFruitMastery or _G.FarmGunMastery or _G.TeleportIsland or _G.EvoRace or _G.FarmAllMsBypassType or _G.Observationv2 or _G.MusketeerHat or _G.Ectoplasm or _G.Rengoku or _G.Rainbow_Haki or _G.Observation or _G.DarkDagger or _G.Safe_Mode or _G.MasteryFruit or _G.BudySword or _G.OderSword or _G.AllBoss or _G.Sharkman or _G.Mastery_Fruit or _G.Mastery_Gun or _G.Dungeon or _G.Cavender or _G.Pole or _G.Factory or _G.SecondSea or _G.TeleportPly or _G.Bartilo or _G.DarkBoss or _G.Level or _G.Clip or _G.Elitehunter or _G.ThirdSea or _G.Bone or _G.heart or _G.doughking or _G.d or _G.waden or _G.gay or _G.ObservationHakiV2 or _G.FarmMaterial or _G.FarmNearest or _G.Carvender or _G.TwinHook or AutoMobAura or _G.Leather or _G.Wing or _G.Umm or _G.Makori_gay or Radioactive or Fish or Gunpowder or Dragon_Scale or Cocoafarm or Scrap or MiniHee or _G.FarmSeabaest or _G.CDK or _G.RaidPirate or getgenv().AutoFarm or _G.PlayerHunter or _G.Factory or _G.AttackDummy or _G.Seabest or _G.SeaBest or _G.KillTial or _G.Saber or _G.Farmfast or _G.RaidPirate or _G.Terrorshark or FarmShark or _G.farmpiranya or _G.Fish_Crew_Member or _G.bjirFishBoat or (_G.KillGhostShip == true)) then
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

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local EffectContainer = ReplicatedStorage:FindFirstChild("Effect") and ReplicatedStorage.Effect:FindFirstChild("Container")

if EffectContainer then
    for _, name in ipairs({"Death", "Respawn"}) do
        local module = EffectContainer:FindFirstChild(name)
        if module then
            local success, func = pcall(require, module)
            if success and type(func) == "function" then
                hookfunction(func, function(...) end)
            end
        end
    end
end


PosY = 20;
Kill_At = 28;
local ServerStatusLabel = v16.Server_Status:AddSection("Server Status")
local FullMoonStatus = v16.Server_Status:AddParagraph({Title = "Moon", Content = "", })
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
                FullMoonStatus:SetDesc("Status: 🌕 Full Moon")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                FullMoonStatus:SetDesc("Status: 🌖 75%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                FullMoonStatus:SetDesc("Status: 🌓 50%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                FullMoonStatus:SetDesc("Status: 🌘 25%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                FullMoonStatus:SetDesc("Status: 🌑 15%")
            else
                FullMoonStatus:SetDesc("Moon Status: 🌚 0%")
            end
        end)
    end
end)

if World1 then
    -- The Saw
    local TheSawStatus = v16.Server_Status:AddParagraph({Title = "The Saw", Content = "", })
    spawn(function()
        while wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") or game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                    TheSawStatus:SetDesc("Status : ✅️");
                else
                    TheSawStatus:SetDesc("Status : ❌️");
                end
            end);
        end
    end);

    -- Greybeard
    local GreyBeardStatus = v16.Server_Status:AddParagraph({Title = "Grey Beard", Content = "", })
    spawn(function()
        while wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") or game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                    GreyBeardStatus:SetDesc("Status : ✅️");
                else
                    GreyBeardStatus:SetDesc("Status : ❌️");
                end
            end);
        end
    end);
end
if World2 then 
    local CursedCaptainStatus = v16.Server_Status:AddParagraph({Title = "Cursed Captain", Content = "", })
    spawn(function()
        while wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Captain") then
                    CursedCaptainStatus:SetDesc("Status : ✅️");
                else
                    CursedCaptainStatus:SetDesc("Status : ❌️");
                end
            end);
        end
    end);
    local LegendarySword = v16.Server_Status:AddParagraph({Title = "Legendary Sword", Content = "", })
    spawn(function()
        local previousStatus = ""
        while wait(1) do
            local swordStatus = "Status : ❌"
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                swordStatus = "Status: Shisui"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
                swordStatus = "Status: Wando"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
                swordStatus = "Status: Saddi"
            end
            LegendarySword:SetDesc(swordStatus)
        end
    end)
end

if World3 then
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
end
local FruitList = {
    "Bomb Fruit", "Spike Fruit", "Spring Fruit", "Spin Fruit",
    "Eagle Fruit", "Smoke Fruit", "Flame Fruit", "Ice Fruit", "Sand Fruit", "Dark Fruit",
    "Diamond Fruit", "Light Fruit", "Love Fruit", "Rubber Fruit", "Rocket Fruit",
    "Creation Fruit", "Magma Fruit", "Portal Fruit", "Quake Fruit", "Buddha Fruit",
    "String Fruit", "Phoenix Fruit", "Rumble Fruit", "Pain Fruit", "Gravity Fruit",
    "Dough Fruit", "Venom Fruit", "Shadow Fruit", "Control Fruit", "Spirit Fruit",
    "Dragon Fruit", "Leopard Fruit", "Blizzard Fruit", "Sound Fruit", "Spider Fruit",
    "T-Rex Fruit", "Ghost Fruit", "Gas Fruit", "Yeti Fruit", "Kitsune Fruit", "Mammoth Fruit"
}

-- Tạo Paragraph hiển thị trạng thái
local FruitStatus = v16.Server_Status:AddParagraph({
    Title = "Fruit in Server",
    Content = "",
})

-- Vòng lặp tự động kiểm tra trái cây mỗi giây
spawn(function()
    while task.wait(0.2) do
        pcall(function()
            local foundFruits = {}

            for i, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                    table.insert(foundFruits, v.Name)
                end
            end

            if #foundFruits > 0 then
                FruitStatus:SetDesc("✅ Found (" .. #foundFruits .. "): " .. table.concat(foundFruits, ", "))
            else
                FruitStatus:SetDesc("❌ Not found")
            end
        end)
    end
end)

local StocksStatus = v16.Server_Status:AddParagraph({
    Title = "Current Fruits Stock:",
    Content = "",
})
local HttpService = game:GetService("HttpService")

local function fetchFruitsStock()
    local url = "https://www.gamersberg.com/api/blox-fruits/stock"

    local success, response = pcall(function()
        return HttpService:GetAsync(url)
    end)
    if not success then
        warn("[API ERROR]", response)
        return nil, nil
    end

    local decodeSuccess, data = pcall(function()
        return HttpService:JSONDecode(response)
    end)
    if not decodeSuccess then
        warn("[JSON ERROR]", data)
        return nil, nil
    end

    if not data.success or not data.data then
        warn("[INVALID DATA STRUCTURE]")
        return nil, nil
    end

    local stock = data.data[1]
    local normalStock = stock.normalStock or {}
    local mirageStock = stock.mirageStock or {}

    return normalStock, mirageStock
end


task.spawn(function()
    while true do
        local normalStock, mirageStock = fetchFruitsStock()
        if normalStock and mirageStock then
            for _, fruit in ipairs(normalStock) do
                StocksStatus:SetDesc(" -", fruit.name)
            end

            for _, fruit in ipairs(mirageStock) do
                StocksStatus:SetDesc(" -", fruit.name)
            end
            task.wait(1)
        end
    end
end)
-----------------Server-------------------------------------------------------------------------------
local ServerLabel = v16.Server_Status:AddSection("Server")
local JobId = v16.Server_Status:AddParagraph({Title = "Job ID", Content = "", })
JobId:SetDesc(game.JobId)
v16.Server_Status:AddButton({
    Title = "Copy Job ID Server",
    Description = "",
    Callback = function()
        setclipboard(tostring(game.JobId));
    end
});
local v105 = v16.Server_Status:AddInput("Input", {
    Title = "Job ID",
    Default = "",
    Placeholder = "",
    Numeric = false,
    Finished = false,
    Callback = function(v301)
        _G.Job = v301;
    end
});
v16.Server_Status:AddButton({
    Title = "Join Server",
    Description = "",
    Callback = function()
        game:GetService("TeleportService"):TeleportToPlaceInstance(game.placeId, _G.Job, game.Players.LocalPlayer);
    end
});
v16.Server_Status:AddButton({
    Title = "Clear Job Id",
    Description = "",
    Callback = function()
        _G.JobId = nil
        v105:SetValue("") 
    end
});
local v106 = v16.Server_Status:AddToggle("MyToggle", {
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
v16.Server_Status:AddButton({
    Title = "Rejoin",
    Description = "",
    Callback = function()
        game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer);
    end
});
v16.Server_Status:AddButton({
    Title = "Hop Server",
    Description = "",
    Callback = function()
        Hop()
    end
});
v16.Server_Status:AddButton({
    Title = "Hop Server Less Player",
    Description = "",
    Callback = function()
        HopLessPeople()
    end
})
---------------Tab Main------------------------
local AutoLevel = v16.Main:AddToggle("ToggleLevel", {
    Title = "Auto Farm Level",
    Description = "",
    Default = GetConfig("ToggleLevel", false)
});
AutoLevel:OnChanged(function(v)
    _G.Level = v;
    SetConfig("ToggleLevel", v)
    if (v == false) then
        wait()
        StopTween(_G.Level)
        wait()
    end
end);
_G.Level = GetConfig("ToggleLevel", false)
AutoLevel:SetValue(_G.Level)

spawn(function()
    while wait() do
        if _G.Level then
            pcall(function()
                local player = game:GetService("Players").LocalPlayer
                local questUI = player.PlayerGui.Main.Quest
                local questTitle = questUI.Container.QuestTitle.Title.Text

                if not string.find(questTitle, NameMon) then
                    StartMagnet = false
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                end

                if not questUI.Visible then
                    StartMagnet = false
                    CheckQuest()

                    -- Bỏ BypassTP: Chỉ dùng TP1
                    TP1(CFrameQuest)

                    if (player.Character.HumanoidRootPart.Position - CFrameQuest.Position).Magnitude <= 5 then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest", NameQuest, LevelQuest)
                    end

                elseif questUI.Visible then
                    CheckQuest()
                    local foundEnemy = false

                    for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                        if enemy.Name == Mon and enemy:FindFirstChild("HumanoidRootPart") and enemy:FindFirstChild("Humanoid") and enemy.Humanoid.Health > 0 then
                            if string.find(questTitle, NameMon) then
                                foundEnemy = true
                                repeat
                                    task.wait()
                                    EquipWeapon(_G.SelectWeapon)
                                    AutoHaki()
                                    getgenv().Seriality = true
                                    PosMon = enemy.HumanoidRootPart.CFrame
                                    TP1(enemy.HumanoidRootPart.CFrame * Pos)
                                    enemy.HumanoidRootPart.CanCollide = false
                                    enemy.Humanoid.WalkSpeed = 0
                                    enemy.Head.CanCollide = false
                                    enemy.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                    StartMagnet = true
                                until not _G.Level or enemy.Humanoid.Health <= 0 or not enemy.Parent or not questUI.Visible
                            else
                                StartMagnet = false
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("AbandonQuest")
                            end
                        end
                    end

                    if not foundEnemy then
                        -- Nếu không có quái -> Tween về vị trí farm
                        TP1(CFrameMon)
                        StartMagnet = false

                        -- Optional: nếu có trong ReplicatedStorage (chưa spawn), chuẩn bị sẵn vị trí
                        local futureEnemy = game:GetService("ReplicatedStorage"):FindFirstChild(Mon)
                        if futureEnemy and futureEnemy:FindFirstChild("HumanoidRootPart") then
                            TP1(futureEnemy.HumanoidRootPart.CFrame * CFrame.new(15, 10, 2))
                        end
                    end
                end
            end)
        end
    end
end)



local FramNear = v16.Main:AddToggle("ToggleMobAura", {
    Title = "Mob Aura",
    Description = "",
    Default = GetConfig("ToggleMobAura", false)
});
FramNear:OnChanged(function(v)
    _G.FarmNearest = v
    StopTween(_G.FarmNearest);
    SetConfig("ToggleMobAura", v)
end);
_G.FarmNearest = GetConfig("ToggleMobAura", false)
FramNear:SetValue(_G.FarmNearest)

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
                            getgenv().Seriality = true
                            v2128.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                            AutoFarmNearestMagnet = true;
                            PosMonNear = v2128.HumanoidRootPart.CFrame;
                        until  not _G.FarmNearest or  not v2128.Parent or (v2128.Humanoid.Health <= 0)
                        AutoFarmNearestMagnet = false;
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
                                            getgenv().Seriality = true
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
    local BartiloQuestLabel = v16.Main:AddSection("Bartlio Quest")
    local BartlioQuest = v16.Main:AddToggle("ToggleBartlioQuest", {
        Title = "Auto Bartlio Quest",
        Description = "",
        Default = false
    })
    BartlioQuest:OnChanged(function(v)
        _G.Bartilo = v;
        StopTween(_G.Bartilo)
    end)
    spawn(function()
        pcall(function()
            while wait(0.1) do
                if _G.Bartilo then
                    if ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 850) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 0)) then
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
                                                getgenv().Seriality = true
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
                    elseif ((game:GetService("Players").LocalPlayer.Data.Level.Value >= 850) and (game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BartiloQuestProgress", "Bartilo") == 1)) then
                        if game:GetService("Workspace").Enemies:FindFirstChild("Jeremy") then
                            Ms = "Jeremy";
                            for v2921, v2922 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                                if (v2922.Name == Ms) then
                                    OldCFrameBartlio = v2922.HumanoidRootPart.CFrame;
                                    repeat
                                        task.wait();
                                        sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
                                        EquipWeapon(_G.SelectWeapon);
                                        getgenv().Seriality = true
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
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1858.87305, 19.3777466, 1712.01807)).Magnitude <= 10)
                        wait(1);
                        repeat
                            topos(CFrame.new( -1803.94324, 16.5789185, 1750.89685));
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1803.94324, 16.5789185, 1750.89685)).Magnitude <= 10)
                        wait(1);
                        repeat
                            topos(CFrame.new( -1858.55835, 16.8604317, 1724.79541));
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1858.55835, 16.8604317, 1724.79541)).Magnitude <= 10)
                        wait(1);
                        repeat
                            topos(CFrame.new( -1869.54224, 15.987854, 1681.00659));
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1869.54224, 15.987854, 1681.00659)).Magnitude <= 10)
                        wait(1);
                        repeat
                            topos(CFrame.new( -1800.0979, 16.4978027, 1684.52368));
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1800.0979, 16.4978027, 1684.52368)).Magnitude <= 10)
                        wait(1);
                        repeat
                            topos(CFrame.new( -1819.26343, 14.795166, 1717.90625));
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1819.26343, 14.795166, 1717.90625)).Magnitude <= 10)
                        wait(1);
                        repeat
                            topos(CFrame.new( -1813.51843, 14.8604736, 1724.79541));
                            wait(0.5);
                        until  not _G.Bartilo or ((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new( -1813.51843, 14.8604736, 1724.79541)).Magnitude <= 10)
                    end
                end
            end
        end);
    end);
    local FactoryLabel = v16.Main:AddSection("Factory")
    local Factory = v16.Main:AddToggle("ToggleFactory", {
        Title = "Auto Factory",
        Description = "",
        Default = false
    })
    Factory:OnChanged(function(v)
        _G.Factory = v
        StopTween(_G.Factory)
    end)
    spawn(function()
        while wait() do
            pcall(function()
                if _G.Factory then
                    if game:GetService("Workspace").Enemies:FindFirstChild("Core") then
                        for v2721, v2722 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                            if ((v2722.Name == "Core") and (v2722.Humanoid.Health > 0)) then
                                repeat
                                    task.wait();
                                    AutoHaki();
                                    EquipWeapon(_G.SelectWeapon);
                                    getgenv().Seriality = true
                                    topos(CFrame.new(448.46756, 199.356781, -441.389252));
                                until (v2722.Humanoid.Health <= 0) or (_G.Factory == false)
                            end
                        end
                    else
                        topos(CFrame.new(448.46756, 199.356781, -441.389252));
                    end
                end
            end);
        end
    end);
end

local ChestLabel = v16.Main:AddSection("Chest")
_G.ChestLimit = GetConfig("ChestLimit", 30)
local ChestLimitInput = v16.Main:AddInput("ChestLimitInput", {
    Title = "Value Collect Chest to Hop",
    Description = "",
    Default = tostring(_G.ChestLimit),
    Placeholder = "Enter Value Collect Chest",
    Numeric = true,
    Finished = true,
    Callback = function(value)
        local num = tonumber(value)
        if num and num >= 1 and num <= 100 and math.floor(num) == num then
            _G.ChestLimit = num
            SetConfig("ChestLimit", num)
        end
    end
})

_G.CollectedChestCount = 0
_G.AutoCollectChest = GetConfig("AutoChest", false)

-- Auto Chest
local AutoChest = v16.Main:AddToggle("AutoChest", {
    Title = "Auto Chest",
    Default = _G.AutoCollectChest
})
AutoChest:SetValue(_G.AutoCollectChest)
AutoChest:OnChanged(function(v)
    _G.AutoCollectChest = v
    SetConfig("AutoChest", v)
end)
spawn(function()
    local failCount = 0
    while task.wait(0.2) do
        if _G.AutoCollectChest then
            local char = player.Character or player.CharacterAdded:Wait()
            local pos = char:GetPivot().Position
            local tagged = game:GetService("CollectionService"):GetTagged("_ChestTagged")
            local nearestDist, nearestChest = math.huge

            for _, chest in ipairs(tagged) do
                local chestPos = chest:GetPivot().Position
                local dist = (chestPos - pos).Magnitude
                if not chest:GetAttribute("IsDisabled") and dist < nearestDist then
                    nearestDist = dist
                    nearestChest = chest
                end
            end

            if nearestChest then
                TweenToPosition(CFrame.new(nearestChest:GetPivot().Position))
                local timeout = 3
                repeat
                    task.wait(0.2)
                    timeout = timeout - 0.2
                until nearestChest:GetAttribute("IsDisabled") == true or timeout <= 0

                if nearestChest:GetAttribute("IsDisabled") == true then
                    _G.CollectedChestCount = _G.CollectedChestCount + 1
                    failCount = 0
                    print("✅ Đã nhặt: " .. _G.CollectedChestCount .. " rương")

                    if _G.CollectedChestCount >= (_G.ChestLimit or 30) then
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Fluent:Notify({
                            Title = "Hiu Hub",
                            Content = "Hop Server...",
                            Duration = 5
                        })
                        Hop()
                        return
                    end
                else
                    failCount = failCount + 1
                    if failCount >= 3 then
                        _G.AutoCollectChest = false
                        _G.CollectedChestCount = 0
                        Hop()
                        return
                    end
                end
            else
                failCount = failCount +1
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

if (World2 or World3) then 
    -- Stop  If Found Item
    _G.StopRareItem = GetConfig("StopRareItem", false)
    local StopRareItem = v16.Main:AddToggle("StopRareItem", {
        Title = "Stop If Found Item",
        Default = _G.StopRareItem
    })
    StopRareItem:SetValue(_G.StopRareItem)
    StopRareItem:OnChanged(function(v)
        _G.StopRareItem = v
        SetConfig("StopRareItem", v)
    end)
    spawn(function()
        while task.wait(2) do
            if _G.AutoCollectChest and _G.StopRareItem then
                local backpack = player:FindFirstChild("Backpack")
                if backpack then
                    local chalice = backpack:FindFirstChild("God's Chalice")
                    local fist = backpack:FindFirstChild("Fist of Darkness")
                    if chalice or fist then
                        _G.AutoCollectChest = false

                        local foundItem = chalice and "God's Chalice" or "Fist of Darkness"
                        Fluent:Notify({
                            Title = "Binini Hub",
                            Content = "Found:  ".. foundItem .. " Stopping Chest Collection!",
                            Duration = 5
                        })

                        -- Teleport về vị trí an toàn
                        local placeId = game.PlaceId
                        if World2 then -- Sea 2
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-281.93, 306.13, 609.28))
                            wait()
                            TP1(CFrame.new(-380.47, 77.22, 255.82))
                        elseif World3 then -- Sea 3
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-12468.53, 375.00, -7554.62))
                            wait()
                            TP1(CFrame.new(-12468.53, 375.00, -7554.62))
                        end

                        return
                    end
                end
            end
        end
    end)
end

function MaterialMon()
    if (SelectMaterial == "Radioactive Material") then
        MMon = { "Factory Staff" }
        MPos = CFrame.new(295, 73, -56)
        SP = "Default"

    elseif (SelectMaterial == "Mystic Droplet") then
        MMon = { "Water Fighter" }
        MPos = CFrame.new(-3385, 239, -10542)
        SP = "Default"

    elseif (SelectMaterial == "Magma Ore") then
        if World1 then
            MMon = { "Military Spy" }
            MPos = CFrame.new(-5815, 84, 8820)
            SP = "Default"
        elseif World2 then
            MMon = { "Magma Ninja" }
            MPos = CFrame.new(-5428, 78, -5959)
            SP = "Default"
        end

    elseif (SelectMaterial == "Angel Wings") then
        MMon = { "God's Guard" }
        MPos = CFrame.new(-4698, 845, -1912)
        SP = "Default"
        if ((game.Players.LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(-7859.09814, 5544.19043, -381.476196)).Magnitude >= 5000) then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(-7859.09814, 5544.19043, -381.476196))
        end

    elseif (SelectMaterial == "Leather") then
        if World1 then
            MMon = { "Brute" }
            MPos = CFrame.new(-1145, 15, 4350)
            SP = "Default"
        elseif World2 then
            MMon = { "Marine Captain" }
            MPos = CFrame.new(-2010.5, 73, -3326.6)
            SP = "Default"
        elseif World3 then
            MMon = { "Jungle Pirate" }
            MPos = CFrame.new(-11975.78, 331.77, -10620.03)
            SP = "Default"
        end

    elseif (SelectMaterial == "Scrap Metal") then
        if World1 then
            MMon = { "Brute" }
            MPos = CFrame.new(-1145, 15, 4350)
            SP = "Default"
        elseif World2 then
            MMon = { "Swan Pirate" }
            MPos = CFrame.new(878, 122, 1235)
            SP = "Default"
        elseif World3 then
            MMon = { "Jungle Pirate" }
            MPos = CFrame.new(-12107, 332, -10549)
            SP = "Default"
        end

    elseif (SelectMaterial == "Fish Tail") then
        if World3 then
            MMon = { "Fishman Raider" }
            MPos = CFrame.new(-10993, 332, -8940)
            SP = "Default"
        elseif World1 then
            MMon = { "Fishman Warrior" }
            MPos = CFrame.new(61123, 19, 1569)
            SP = "Default"
        end

    elseif (SelectMaterial == "Demonic Wisp") then
        MMon = { "Demonic Soul" }
        MPos = CFrame.new(-9507, 172, 6158)
        SP = "Default"

    elseif (SelectMaterial == "Vampire Fang") then
        MMon = { "Vampire" }
        MPos = CFrame.new(-6033, 7, -1317)
        SP = "Default"

    elseif (SelectMaterial == "Conjured Cocoa") then
        MMon = { "Chocolate Bar Battler" }
        MPos = CFrame.new(620.63, 78.93, -12581.36)
        SP = "Default"

    elseif (SelectMaterial == "Dragon Scale") then
        MMon = { "Dragon Crew Archer" }
        MPos = CFrame.new(6827.91, 609.41, 252.35)
        SP = "Default"

    elseif (SelectMaterial == "Gunpowder") then
        MMon = { "Pistol Billionaire" }
        MPos = CFrame.new(-469, 74, 5904)
        SP = "Default"

    elseif (SelectMaterial == "Hydra Enforcer") then
        MMon = { "Hydra Enforcer" }
        MPos = CFrame.new(4581.51, 1001.55, 704.93)
        SP = "Default"

    elseif (SelectMaterial == "Venomous Assailant") then
        MMon = { "Venomous Assailant" }
        MPos = CFrame.new(4879.92, 1089.46, 1104.00)
        SP = "Default"

    elseif (SelectMaterial == "Mini Tusk") then
        MMon = { "Mythological Pirate" }
        MPos = CFrame.new(-13516.0458984375, 469.8182373046875, -6899.16064453125) -- cần cập nhật tọa độ nếu có
        SP = "Default"

    elseif (SelectMaterial == "Ectoplasm") then
        MMon = { "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer" }
        MPos = CFrame.new(911.36, 125.96, 33159.53)
        SP = "Default"
    end
end


local MaterialLabel = v16.Main:AddSection("Material")
if World1 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Angel Wings",
        "Magma Ore",
        "Fish Tail"
    };
elseif World2 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Radioactive Material",
        "Mystic Droplet",
        "Magma Ore",
        "Vampire Fang",
        "Ectoplasm"
    };
elseif World3 then
    MaterialList = {
        "Scrap Metal",
        "Leather",
        "Demonic Wisp",
        "Conjured Cocoa",
        "Dragon Scale",
        "Gunpowder",
        "Fish Tail",
        "Mini Tusk",
        "Hydra Enforcer",
        "Venomous Assailant"
    };
end
local DropDownMaterial = v16.Main:AddDropdown("DropDownMaterialList", {
    Title = "Select Material",
    Description = "",
    Values = MaterialList,
    Multi = false,
    Default = 1
})
DropDownMaterial:OnChanged(function(v)
    SelectMaterial = v
end)

local FramMaterial = v16.Main:AddToggle("ToggleFramMaterial", {
    Title = "Start Fram Material",
    Description = "",
    Default = false
})
FramMaterial:OnChanged(function(v)
    _G.AutoMaterial = v
    StopTween(_G.AutoMaterial)
end)
spawn(function()
    while task.wait() do
        if _G.AutoMaterial then
            pcall(function()
                MaterialMon(SelectMaterial)
                TP1(MPos)
                
                if game:GetService("Workspace").Enemies:FindFirstChild(MMon[1]) then
                    for _, enemy in pairs(game.Workspace.Enemies:GetChildren()) do
                        if (enemy:FindFirstChild("Humanoid") and enemy:FindFirstChild("HumanoidRootPart") and enemy.Humanoid.Health > 0) then
                            if table.find(MMon, enemy.Name) then
                                repeat
                                    task.wait()
                                    AutoHaki()
                                    StartMaterialMagnet = true
                                    EquipWeapon(_G.SelectWeapon)
                                    getgenv().Seriality = true
                                    TP1(enemy.HumanoidRootPart.CFrame * Pos)
                                    enemy.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                    enemy.HumanoidRootPart.Transparency = 1
                                    enemy.Humanoid.JumpPower = 0
                                    enemy.Humanoid.WalkSpeed = 0
                                    enemy.HumanoidRootPart.CanCollide = false
                                    PosMonMaterial = enemy.HumanoidRootPart.CFrame
                                    MonFarm = enemy.Name
                                until not _G.AutoMaterial or not enemy.Parent or enemy.Humanoid.Health <= 0
                                StartMaterialMagnet = false
                            end
                        end
                    end
                else
                    for _, spawnPoint in pairs(game:GetService("Workspace")['_WorldOrigin'].EnemySpawns:GetChildren()) do
                        if string.find(spawnPoint.Name, MMon[1]) then
                            if (game.Players.LocalPlayer.Character.HumanoidRootPart.Position - spawnPoint.Position).Magnitude >= 10 then
                                TP1(spawnPoint.HumanoidRootPart.CFrame * Pos)
                            end
                        end
                    end
                end
            end)
        end
    end
end)
local BossLabel = v16.Main:AddSection("Boss")
function CheckBossQuest()
    if World1 then
        if (SelectBoss == "The Gorilla King") then
            BossMon = "The Gorilla King";
            NameBoss = "The Gorrila King";
            NameQuestBoss = "JungleQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$2,000\n7,000 Exp.";
            CFrameQBoss = CFrame.new(- 1601.6553955078, 36.85213470459, 153.38809204102);
            CFrameBoss = CFrame.new(- 1088.75977, 8.13463783, - 488.559906, - 0.707134247, 0, 0.707079291, 0, 1, 0, - 0.707079291, 0, - 0.707134247);
        elseif (SelectBoss == "Bobby") then
            BossMon = "Bobby";
            NameBoss = "Bobby";
            NameQuestBoss = "BuggyQuest1";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$8,000\n35,000 Exp.";
            CFrameQBoss = CFrame.new(- 1140.1761474609, 4.752049446106, 3827.4057617188);
            CFrameBoss = CFrame.new(- 1087.3760986328, 46.949409484863, 4040.1462402344);
        elseif (SelectBoss == "The Saw") then
            BossMon = "The Saw";
            NameBoss = "The Saw";
            CFrameBoss = CFrame.new(- 784.89715576172, 72.427383422852, 1603.5822753906);
        elseif (SelectBoss == "Yeti") then
            BossMon = "Yeti";
            NameBoss = "Yeti";
            NameQuestBoss = "SnowQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$10,000\n180,000 Exp.";
            CFrameQBoss = CFrame.new(1386.8073730469, 87.272789001465, - 1298.3576660156);
            CFrameBoss = CFrame.new(1218.7956542969, 138.01184082031, - 1488.0262451172);
        elseif (SelectBoss == "Mob Leader") then
            BossMon = "Mob Leader";
            NameBoss = "Mob Leader";
            CFrameBoss = CFrame.new(- 2844.7307128906, 7.4180502891541, 5356.6723632813);
        elseif (SelectBoss == "Vice Admiral") then
            BossMon = "Vice Admiral";
            NameBoss = "Vice Admiral";
            NameQuestBoss = "MarineQuest2";
            QuestLvBoss = 2;
            RewardBoss = "Reward:\n$10,000\n180,000 Exp.";
            CFrameQBoss = CFrame.new(- 5036.2465820313, 28.677835464478, 4324.56640625);
            CFrameBoss = CFrame.new(- 5006.5454101563, 88.032081604004, 4353.162109375);
        elseif (SelectBoss == "Saber Expert") then
            NameBoss = "Saber Expert";
            BossMon = "Saber Expert";
            CFrameBoss = CFrame.new(- 1458.89502, 29.8870335, - 50.633564);
        elseif (SelectBoss == "Warden") then
            BossMon = "Warden";
            NameBoss = "Warden";
            NameQuestBoss = "ImpelQuest";
            QuestLvBoss = 1;
            RewardBoss = "Reward:\n$6,000\n850,000 Exp.";
            CFrameBoss = CFrame.new(5278.04932, 2.15167475, 944.101929, 0.220546961, - 0.000004499464, 0.975376427, - 0.000019541258, 1, 0.000009031621, - 0.975376427, - 0.000021051976, 0.220546961);
            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635);
        elseif (SelectBoss == "Chief Warden") then
            BossMon = "Chief Warden";
            NameBoss = "Chief Warden";
            NameQuestBoss = "ImpelQuest";
            QuestLvBoss = 2;
            RewardBoss = "Reward:\n$10,000\n1,000,000 Exp.";
            CFrameBoss = CFrame.new(5206.92578, 0.997753382, 814.976746, 0.342041343, - 0.00062915677, 0.939684749, 0.00191645394, 0.999998152, - 0.000028042234, - 0.939682961, 0.00181045406, 0.342041939);
            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635);
        elseif (SelectBoss == "Swan") then
            BossMon = "Swan";
            NameBoss = "Swan";
            NameQuestBoss = "ImpelQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$15,000\n1,600,000 Exp.";
            CFrameBoss = CFrame.new(5325.09619, 7.03906584, 719.570679, - 0.309060812, 0, 0.951042235, 0, 1, 0, - 0.951042235, 0, - 0.309060812);
            CFrameQBoss = CFrame.new(5191.86133, 2.84020686, 686.438721, - 0.731384635, 0, 0.681965172, 0, 1, 0, - 0.681965172, 0, - 0.731384635);
        elseif (SelectBoss == "Magma Admiral") then
            BossMon = "Magma Admiral";
            NameBoss = "Magma Admiral";
            NameQuestBoss = "MagmaQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$15,000\n2,800,000 Exp.";
            CFrameQBoss = CFrame.new(- 5314.6220703125, 12.262420654297, 8517.279296875);
            CFrameBoss = CFrame.new(- 5765.8969726563, 82.92064666748, 8718.3046875);
        elseif (SelectBoss == "Fishman Lord") then
            BossMon = "Fishman Lord";
            NameBoss = "Fishman Lord";
            NameQuestBoss = "FishmanQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$15,000\n4,000,000 Exp.";
            CFrameQBoss = CFrame.new(61122.65234375, 18.497442245483, 1569.3997802734);
            CFrameBoss = CFrame.new(61260.15234375, 30.950881958008, 1193.4329833984);
        elseif (SelectBoss == "Wysper") then
            BossMon = "Wysper";
            NameBoss = "Wysper";
            NameQuestBoss = "SkyExp1Quest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$15,000\n4,800,000 Exp.";
            CFrameQBoss = CFrame.new(- 7861.947265625, 5545.517578125, - 379.85974121094);
            CFrameBoss = CFrame.new(- 7866.1333007813, 5576.4311523438, - 546.74816894531);
        elseif (SelectBoss == "Thunder God") then
            BossMon = "Thunder God";
            NameBoss = "Thunder God";
            NameQuestBoss = "SkyExp2Quest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$20,000\n5,800,000 Exp.";
            CFrameQBoss = CFrame.new(- 7903.3828125, 5635.9897460938, - 1410.923828125);
            CFrameBoss = CFrame.new(- 7994.984375, 5761.025390625, - 2088.6479492188);
        elseif (SelectBoss == "Cyborg") then
            BossMon = "Cyborg";
            NameBoss = "Cyborg";
            NameQuestBoss = "FountainQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$20,000\n7,500,000 Exp.";
            CFrameQBoss = CFrame.new(5258.2788085938, 38.526931762695, 4050.044921875);
            CFrameBoss = CFrame.new(6094.0249023438, 73.770050048828, 3825.7348632813);
        elseif (SelectBoss == "Ice Admiral") then
            BossMon = "Ice Admiral";
            NameBoss = "Ice Admiral";
            CFrameBoss = CFrame.new(1266.08948, 26.1757946, - 1399.57678, - 0.573599219, 0, - 0.81913656, 0, 1, 0, 0.81913656, 0, - 0.573599219);
        elseif (SelectBoss == "Greybeard") then
            BossMon = "Greybeard";
            NameBoss = "Greybeard";
            CFrameBoss = CFrame.new(- 5081.3452148438, 85.221641540527, 4257.3588867188);
        end
    end
    if World2 then
        if (SelectBoss == "Diamond") then
            BossMon = "Diamond";
            NameBoss = "Diamond";
            NameQuestBoss = "Area1Quest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$25,000\n9,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 427.5666809082, 73.313781738281, 1835.4208984375);
            CFrameBoss = CFrame.new(- 1576.7166748047, 198.59265136719, 13.724286079407);
        elseif (SelectBoss == "Jeremy") then
            BossMon = "Jeremy";
            NameBoss = "Jeremy";
            NameQuestBoss = "Area2Quest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$25,000\n11,500,000 Exp.";
            CFrameQBoss = CFrame.new(636.79943847656, 73.413787841797, 918.00415039063);
            CFrameBoss = CFrame.new(2006.9261474609, 448.95666503906, 853.98284912109);
        elseif (SelectBoss == "Fajita") then
            BossMon = "Fajita";
            NameBoss = "Fajita";
            NameQuestBoss = "MarineQuest3";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$25,000\n15,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 2441.986328125, 73.359344482422, - 3217.5324707031);
            CFrameBoss = CFrame.new(- 2172.7399902344, 103.32216644287, - 4015.025390625);
        elseif (SelectBoss == "Don Swan") then
            BossMon = "Don Swan";
            NameBoss = "Don Swan";
            CFrameBoss = CFrame.new(2286.2004394531, 15.177839279175, 863.8388671875);
        elseif (SelectBoss == "Smoke Admiral") then
            BossMon = "Smoke Admiral";
            NameBoss = "Smoke Admiral";
            NameQuestBoss = "IceSideQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$20,000\n25,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 5429.0473632813, 15.977565765381, - 5297.9614257813);
            CFrameBoss = CFrame.new(- 5275.1987304688, 20.757257461548, - 5260.6669921875);
        elseif (SelectBoss == "Awakened Ice Admiral") then
            BossMon = "Awakened Ice Admiral";
            NameBoss = "Awakened Ice Admiral";
            NameQuestBoss = "FrostQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$20,000\n36,000,000 Exp.";
            CFrameQBoss = CFrame.new(5668.9780273438, 28.519989013672, - 6483.3520507813);
            CFrameBoss = CFrame.new(6403.5439453125, 340.29766845703, - 6894.5595703125);
        elseif (SelectBoss == "Tide Keeper") then
            BossMon = "Tide Keeper";
            NameBoss = "Tide Keeper";
            NameQuestBoss = "ForgottenQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$12,500\n38,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 3053.9814453125, 237.18954467773, - 10145.0390625);
            CFrameBoss = CFrame.new(- 3795.6423339844, 105.88877105713, - 11421.307617188);
        elseif (SelectBoss == "Darkbeard") then
            BossMon = "Darkbeard";
            NameBoss = "Darkbeard";
            CFrameMon = CFrame.new(3677.08203125, 62.751937866211, - 3144.8332519531);
        elseif (SelectBoss == "Cursed Captain") then
            BossMon = "Cursed Captain";
            NameBoss = "Cursed Captain";
            CFrameBoss = CFrame.new(916.928589, 181.092773, 33422);
        elseif (SelectBoss == "Order") then
            BossMon = "Order";
            NameBoss = "Order";
            CFrameBoss = CFrame.new(- 6217.2021484375, 28.047645568848, - 5053.1357421875);
        end
    end
    if World3 then
        if (SelectBoss == "Stone") then
            BossMon = "Stone";
            NameBoss = "Stone";
            NameQuestBoss = "PiratePortQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$25,000\n40,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 289.76705932617, 43.819011688232, 5579.9384765625);
            CFrameBoss = CFrame.new(- 1027.6512451172, 92.404174804688, 6578.8530273438);
        elseif (SelectBoss == "Hydra Leader") then
            BossMon = "Hydra Leader";
            NameBoss = "Hydra Leader";
            NameQuestBoss = "VenomCrewQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$30,000\n52,000,000 Exp.";
            CFrameQBoss = CFrame.new(5445.9541015625, 601.62945556641, 751.43792724609);
            CFrameBoss = CFrame.new(5543.86328125, 668.97399902344, 199.0341796875);
        elseif (SelectBoss == "Kilo Admiral") then
            BossMon = "Kilo Admiral";
            NameBoss = "Kilo Admiral";
            NameQuestBoss = "MarineTreeIsland";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$35,000\n56,000,000 Exp.";
            CFrameQBoss = CFrame.new(2179.3010253906, 28.731239318848, - 6739.9741210938);
            CFrameBoss = CFrame.new(2764.2233886719, 432.46154785156, - 7144.4580078125);
        elseif (SelectBoss == "Captain Elephant") then
            BossMon = "Captain Elephant";
            NameBoss = "Captain Elephant";
            NameQuestBoss = "DeepForestIsland";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$40,000\n67,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 13232.682617188, 332.40396118164, - 7626.01171875);
            CFrameBoss = CFrame.new(- 13376.7578125, 433.28689575195, - 8071.392578125);
        elseif (SelectBoss == "Beautiful Pirate") then
            BossMon = "Beautiful Pirate";
            NameBoss = "Beautiful Pirate";
            NameQuestBoss = "DeepForestIsland2";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$50,000\n70,000,000 Exp.";
            CFrameQBoss = CFrame.new(- 12682.096679688, 390.88653564453, - 9902.1240234375);
            CFrameBoss = CFrame.new(5283.609375, 22.56223487854, - 110.78285217285);
        elseif (SelectBoss == "Cake Queen") then
            BossMon = "Cake Queen";
            NameBoss = "Cake Queen";
            NameQuestBoss = "IceCreamIslandQuest";
            QuestLvBoss = 3;
            RewardBoss = "Reward:\n$30,000\n112,500,000 Exp.";
            CFrameQBoss = CFrame.new(- 819.376709, 64.9259796, - 10967.2832, - 0.766061664, 0, 0.642767608, 0, 1, 0, - 0.642767608, 0, - 0.766061664);
            CFrameBoss = CFrame.new(- 678.648804, 381.353943, - 11114.2012, - 0.908641815, 0.00149294338, 0.41757378, 0.00837114919, 0.999857843, 0.0146408929, - 0.417492568, 0.0167988986, - 0.90852499);
        elseif (SelectBoss == "Longma") then
            BossMon = "Longma";
            NameBoss = "Longma";
            CFrameBoss = CFrame.new(- 10238.875976563, 389.7912902832, - 9549.7939453125);
        elseif (SelectBoss == "Soul Reaper") then
            BossMon = "Soul Reaper";
            NameBoss = "Soul Reaper";
            CFrameBoss = CFrame.new(- 9524.7890625, 315.80429077148, 6655.7192382813);
        elseif (SelectBoss == "rip_indra True Form") then
            BossMon = "rip_indra True Form";
            NameBoss = "rip_indra True Form";
            CFrameBoss = CFrame.new(- 5415.3920898438, 505.74133300781, - 2814.0166015625);
        elseif (SelectBoss == "Tyrant of the  Skies") then
            BossMon = "Tyrant of the Skies"
            NameBoss = "Tyrant of the Skies"
            CFrameBoss = CFrame.new(-16263.4854, 150.167999, 1393.90002);
        end
    end
end
local BossStatus = v16.Main:AddParagraph({Title = "Selected Boss", Content = "", })
spawn(function()
    while wait() do
        pcall(function()
            if (game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) or game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss)) then
                BossStatus:SetDesc("Status : ✅");
            else
                BossStatus:SetDesc("Status : ❌️");
            end
        end);
    end
end);
local tableBoss = {}
if World1 then
    tableBoss = {
        "The Gorilla King", "Bobby", "Yeti", "Mob Leader", "Vice Admiral", "Warden",
        "Chief Warden", "Swan", "Magma Admiral", "Fishman Lord", "Wysper", "Thunder God",
        "Cyborg", "Saber Expert"
    }
elseif World2 then
    tableBoss = {
        "Diamond", "Jeremy", "Fajita", "Don Swan", "Smoke Admiral", "Cursed Captain",
        "Darkbeard", "Order", "Awakened Ice Admiral", "Tide Keeper"
    }
elseif World3 then
    tableBoss = {
        "Stone", "Hydra Leader", "Kilo Admiral", "Captain Elephant", "Beautiful Pirate",
        "rip_indra True Form", "Soul Reaper", "Cake Queen", "Tyrant Of The Skies"
    }
end

local BossList = v16.Main:AddDropdown("DropdownBoss", {
    Title = "Select Boss",
    Description = "",
    Values = tableBoss,
    Multi = false,
    Default = 1
})
BossList:OnChanged(function(v)
    _G.SelectBoss = v
end)

local KillBoss = v16.Main:AddToggle("ToggleAutoFarmBoss", {
    Title = "Start Attack Boss",
    Description = "",
    Default = false
})
KillBoss:OnChanged(function(v)
    _G.AutoBoss = v
    if (v == false) then
        StopTween(_G.AutoBoss)
    end
end)


spawn(function()
    while wait() do
        if _G.AutoBoss then
            pcall(function()
                if game:GetService("Workspace").Enemies:FindFirstChild(_G.SelectBoss) then
                    for v1034, v1035 in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                        if (v1035.Name == _G.SelectBoss) then
                            if (v1035:FindFirstChild("Humanoid") and v1035:FindFirstChild("HumanoidRootPart") and (v1035.Humanoid.Health > 0)) then
                                repeat
                                    task.wait()
                                    AutoHaki();
                                    EquipWeapon(_G.SelectWeapon)
                                    getgenv().Seriality = true
                                    v1035.HumanoidRootPart.CanCollide = false;
                                    v1035.Humanoid.WalkSpeed = 0;
                                    v1035.HumanoidRootPart.Size = Vector3.new(60, 60, 60);
                                    TP1(v1035.HumanoidRootPart.CFrame * Pos);
                                    if v1035.Humanoid:FindFirstChild("Animator") then
                                        v1035.Humanoid.Animator:Destroy();
                                    end
                                    sethiddenproperty(game:GetService("Players").LocalPlayer, "SimulationRadius", math.huge);
                                until not _G.AutoBoss or not v1035.Parent or (v1035.Humanoid.Health <= 0)
                            end
                        end
                    end
                elseif game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss) then
                    TP1(game:GetService("ReplicatedStorage"):FindFirstChild(_G.SelectBoss).HumanoidRootPart.CFrame * CFrame.new(5, 10, 7));
                end
            end);
        end
    end
end);

-----------Tab Item-----------------------------------------------------------------------------------------------------------
if World1 then
    local AutoSaber = v16.Item:AddToggle("AutoSaber", {
        Title = "Auto Saber",
        Description = "",
        Default = GetConfig("AutoSaber", false)
    })
    AutoSaber:OnChanged(function(v)
        getgenv().AutoSaber = v
        if (v == false) then 
            StopTween()
        end
        SetConfig("AutoSaber", v)
    end)
    getgenv().AutoSaber = GetConfig("AutoSaber", false)
    AutoSaber:SetValue(getgenv().AutoSaber)

    spawn(function()
        while task.wait(0.5) do
            if getgenv().AutoSaber and game.Players.LocalPlayer.Data.Level.Value >= 200 then
                pcall(function()
                    local player = game.Players.LocalPlayer
                    local char = player.Character
                    local hrp = char and char:FindFirstChild("HumanoidRootPart")
                    if not hrp then return end
                    local jungle = game:GetService("Workspace").Map.Jungle
                    local desert = game:GetService("Workspace").Map.Desert
                    local relicPos = CFrame.new(-1405.881591796875, 29.887041091918945, 4.8968329429626465)                
                    if jungle.Final.Part.Transparency == 0 then
                        if jungle.QuestPlates.Door.Transparency == 0 then
                            local saberPos = CFrame.new(-1612.55, 36.97, 148.71)
                            if (saberPos.Position - hrp.Position).Magnitude <= 100 then
                                for i = 1, 5 do
                                    local plate = jungle.QuestPlates:FindFirstChild("Plate" .. i)
                                    if plate and plate:FindFirstChild("Button") then
                                        hrp.CFrame = plate.Button.CFrame
                                        task.wait(0.5)
                                    end
                                end
                            else
                                topos(saberPos)
                            end
                        else
                            if desert.Burn.Part.Transparency == 0 then
                                if player.Backpack:FindFirstChild("Torch") or char:FindFirstChild("Torch") then
                                    EquipWeapon("Torch")
                                    topos(CFrame.new(1112.432373046875, 4.956541061401367, 4353.4033203125))
                                else
                                    topos(CFrame.new(-1610.00, 11.50, 164.00))
                                end
                            else
                                local commF = game:GetService("ReplicatedStorage").Remotes.CommF_
                                if commF:InvokeServer("ProQuestProgress", "SickMan") ~= 0 then
                                    commF:InvokeServer("ProQuestProgress", "GetCup")
                                    task.wait(0.1)
                                    EquipWeapon("Cup")
                                    task.wait(0.1)
                                    commF:InvokeServer("ProQuestProgress", "FillCup", char:FindFirstChild("Cup"))
                                    task.wait(0.1)
                                    commF:InvokeServer("ProQuestProgress", "SickMan")
                                else
                                    if commF:InvokeServer("ProQuestProgress", "RichSon") == nil then
                                        commF:InvokeServer("ProQuestProgress", "RichSon")
                                    elseif commF:InvokeServer("ProQuestProgress", "RichSon") == 0 then
                                        local mobLeader = game:GetService("Workspace").Enemies:FindFirstChild("Mob Leader")
                                        if not mobLeader then
                                            mobLeader = game:GetService("ReplicatedStorage"):FindFirstChild("Mob Leader")
                                        end                                    
                                        if mobLeader then
                                            topos(mobLeader.HumanoidRootPart.CFrame)
                                            repeat
                                                task.wait()
                                                AutoHaki()
                                                EquipWeapon(_G.SelectWeapon)
                                                getgenv().Seriality = true
                                                mobLeader.HumanoidRootPart.CanCollide = false
                                                mobLeader.Humanoid.WalkSpeed = 0
                                                topos(mobLeader.HumanoidRootPart.CFrame * Pos)
                                                game:GetService("VirtualUser"):CaptureController()
                                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                                                sethiddenproperty(player, "SimulationRadius", math.huge)
                                            until mobLeader.Humanoid.Health <= 0 or not getgenv().AutoSaber
                                        end
                                    elseif commF:InvokeServer("ProQuestProgress", "RichSon") == 1 then
                                        commF:InvokeServer("ProQuestProgress", "RichSon")
                                        task.wait(0.1)
                                        EquipWeapon("Relic")
                                        task.wait(0.1)
                                        topos(relicPos)
                                    end
                                end
                            end
                        end
                    else
                        local saberExpert = game:GetService("Workspace").Enemies:FindFirstChild("Saber Expert")
                        if not saberExpert then
                            saberExpert = game:GetService("ReplicatedStorage"):FindFirstChild("Saber Expert")
                            Fluent:Notify({
                                Title = 'Hiu Hub',
                                Content = "Saber Expert not found",
                                Duration = 5,
                            })
                            task.wait(2)
                        end                    
                        if saberExpert then
                            repeat
                                task.wait()
                                EquipWeapon(_G.SelectWeapon)
                                getgenv().Seriality = true
                                topos(saberExpert.HumanoidRootPart.CFrame * Pos)
                                saberExpert.HumanoidRootPart.Size = Vector3.new(60, 60, 60)
                                saberExpert.HumanoidRootPart.Transparency = 1
                                saberExpert.Humanoid.JumpPower = 0
                                saberExpert.Humanoid.WalkSpeed = 0
                                saberExpert.HumanoidRootPart.CanCollide = false
                                game:GetService("VirtualUser"):CaptureController()
                                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                            until saberExpert.Humanoid.Health <= 0 or not getgenv().AutoSaber                       
                            if saberExpert.Humanoid.Health <= 0 then
                                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("ProQuestProgress", "PlaceRelic")
                            end
                        end
                    end
                end)
            end
        end
    end)

    local AutoSawSword = v16.Item:AddToggle("AutoSawSword", {
        Title = "Auto Saw Sword",
        Description = "",
        Default = GetConfig("AutoSawSword", false)
    })
    AutoSawSword:OnChanged(function(v)
        getgenv().saw = v
        if (v == false) then 
            StopTween()
        end
        SetConfig("AutoSawSword", v)
    end)
    getgenv().saw = GetConfig("AutoSawSword", false)
    AutoSawSword:SetValue(getgenv().saw)

    local TheSawPos = CFrame.new(-690.33081054688, 15.09425163269, 1582.2380371094)

    spawn(function()
        while task.wait() do
            if getgenv().saw and World1 then
                pcall(function()
                    local enemies = game:GetService("Workspace").Enemies
                    local replicated = game:GetService("ReplicatedStorage")

                    -- Kiểm tra The Saw có tồn tại trong server không
                    local sawExists = replicated:FindFirstChild("The Saw") or enemies:FindFirstChild("The Saw")

                    if sawExists then
                        local saw = enemies:FindFirstChild("The Saw")
                        if saw and saw:FindFirstChild("Humanoid") and saw:FindFirstChild("HumanoidRootPart") and saw.Humanoid.Health > 0 then
                            repeat
                                task.wait()
                                AutoHaki()
                                EquipWeapon(_G.SelectWeapon)
                                getgenv().Seriality = true
                                saw.HumanoidRootPart.CanCollide = false
                                saw.Humanoid.WalkSpeed = 0
                                saw.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                                topos(saw.HumanoidRootPart.CFrame * Pos)
                                sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                            until not getgenv().saw or not saw.Parent or saw.Humanoid.Health <= 0
                        else
                            -- Đang có boss nhưng chưa spawn vào Workspace → chờ hoặc teleport đến vị trí
                            topos(TheSawPos)
                        end
                    else
                        -- Không có boss trong server → hop
                        topos(TheSawPos)
                    end
                end)
            end
        end
    end)

    local AutoPolev1 = v16.Item:AddToggle("AutoPolev1", {
        Title = "Auto Pole V1",
        Description = "",
        Default = GetConfig("AutoPolev1", false)
    })
    AutoPolev1:OnChanged(function(v)
        _G.pole = v
        if (v == false) then 
            StopTween()
        end
        SetConfig("AutoPolev1", v)
    end)
    _G.pole = GetConfig("AutoPolev1", false)
    AutoPolev1:SetValue(_G.pole)

    local v97 = CFrame.new(-7748.0185546875, 5606.80615234375, -2305.898681640625)
    spawn(function()
        while task.wait() do
            if _G.pole and World1 then
                pcall(function()
                    local enemies = game:GetService("Workspace").Enemies
                    local replicated = game:GetService("ReplicatedStorage")
                    local thunderGod = enemies:FindFirstChild("Thunder God")

                    if thunderGod and thunderGod:FindFirstChild("Humanoid") and thunderGod:FindFirstChild("HumanoidRootPart") and thunderGod.Humanoid.Health > 0 then
                        repeat
                            task.wait()
                            AutoHaki()
                            EquipWeapon(_G.SelectWeapon)
                            getgenv().Seriality = true
                            thunderGod.HumanoidRootPart.CanCollide = false
                            thunderGod.Humanoid.WalkSpeed = 0
                            thunderGod.HumanoidRootPart.Size = Vector3.new(50, 50, 50)
                            topos(thunderGod.HumanoidRootPart.CFrame * Pos)
                            sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        until not _G.pole or not thunderGod.Parent or thunderGod.Humanoid.Health <= 0
                    else
                        -- Không có Thunder God trong Workspace, dịch đến vị trí chờ
                        topos(v97)

                        -- Nếu boss đang trong ReplicatedStorage thì teleport tới gần chờ spawn
                        local thunderInReplicated = replicated:FindFirstChild("Thunder God")
                        if thunderInReplicated and thunderInReplicated:FindFirstChild("HumanoidRootPart") then
                            topos(thunderInReplicated.HumanoidRootPart.CFrame * CFrame.new(2, 20, 2))
                        end
                        -- Không Hop server nữa
                    end
                end)
            end
        end
    end)
    
end
local BerryLabel = v16.Item:AddSection("Berry")
local AutoBerry = v16.Item:AddToggle("AutoBerry", {
    Title = "Auto Collect Berry",
    Description = "",
    Default = GetConfig("AutoBerry", false)
})
AutoBerry:OnChanged(function(v)
    getgenv().CollectBerry = v
    if (v == false) then 
        StopTween()
    end
    SetConfig("AutoBerry", v)
end)
getgenv().CollectBerry = GetConfig("AutoBerry", false)
AutoBerry:SetValue(getgenv().CollectBerry)

spawn(function()
    local lastNotify = 0  -- thời gian lần thông báo cuối cùng
    while task.wait() do
        if getgenv().CollectBerry then
            local Players = game:GetService("Players")
            local Player = Players.LocalPlayer
            local Character = Player.Character or Player.CharacterAdded:Wait()
            local Position = Character:GetPivot().Position
            local CollectionService = game:GetService("CollectionService")
            local BerryBushes = CollectionService:GetTagged("BerryBush")
            local Distance, NearestBush, NearestBerryName = math.huge, nil, nil

            for _, Bush in ipairs(BerryBushes) do
                for AttributeName, _ in pairs(Bush:GetAttributes()) do
                    local Magnitude = (Bush.Parent:GetPivot().Position - Position).Magnitude
                    if Magnitude < Distance then
                        Distance = Magnitude
                        NearestBush = Bush
                        NearestBerryName = AttributeName
                    end
                end
            end

            if NearestBush and NearestBerryName then
                local BushModel = NearestBush.Parent
                local BushCenter = BushModel:GetPivot().Position

                TP1(CFrame.new(BushCenter + Vector3.new(0, 2, 0)))
                task.wait(1)

                local BerriesConfig = BushModel:FindFirstChild("Berries")
                if BerriesConfig and BerriesConfig:IsA("Configuration") then
                    for _, berryModel in pairs(BerriesConfig:GetChildren()) do
                        if berryModel:IsA("Model") then
                            local targetCFrame = berryModel.PrimaryPart and berryModel.PrimaryPart.CFrame or berryModel:GetPivot()
                            TP1(targetCFrame + Vector3.new(0, 1, 0))
                            task.wait(1)

                            local VirtualInput = game:GetService("VirtualInputManager")
                            VirtualInput:SendKeyEvent(true, Enum.KeyCode.E, false, game)
                            task.wait()
                            VirtualInput:SendKeyEvent(false, Enum.KeyCode.E, false, game)
                            break
                        end
                    end
                end
            else
                local now = tick()
                if now - lastNotify > 5 then  -- cách nhau ít nhất 5 giây mới notify tiếp
                    lastNotify = now
                    if getgenv().CollectBerryHop then
                        Fluent:Notify({
                            Title = "Hiu Hub",
                            Content = "Berry Not Found, Hop Server...",
                            Duration = 5
                        })
                        task.wait(1)
                        Hop()
                    else
                        Fluent:Notify({
                            Title = "Hiu Hub",
                            Content = "Berry Not Found.",
                            Duration = 5
                        })
                    end
                end
            end
        end
    end
end)


local AutoBerryHop = v16.Item:AddToggle("AutoBerryHop", {
    Title = "Auto Collect Berry Hop",
    Description = "",
    Default = GetConfig("AutoBerryHop", false)
})
AutoBerryHop:OnChanged(function(v)
    getgenv().CollectBerryHop = v
    SetConfig("AutoBerryHop", v)
end)
getgenv().CollectBerryHop = GetConfig("AutoBerryHop", false)
AutoBerryHop:SetValue(getgenv().CollectBerryHop)

-----------Tab Stats------------------------------------------------------
_G.Point = 3
local Kaitunstats = v16.Stats:AddToggle("ToggleKaitunStats", {
    Title = "Auto Add Stats",
    Description = "",
    Default = GetConfig("ToggleKaitunStats", false)
})
Kaitunstats:OnChanged(function(v)
    _G.Stats_Kaitun = v;
    SetConfig("ToggleKaitunStats", v)
end)
_G.Stats_Kaitun = GetConfig("ToggleKaitunStats", false)
Kaitunstats:SetValue(_G.Stats_Kaitun)
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
    Default = GetConfig("ToggleMelee", false)
});
v01:OnChanged(function(v)
    _G.Auto_Stats_Melee = v;
    SetConfig("ToggleMelee", v)
end);
_G.Auto_Stats_Melee = GetConfig("ToggleMelee", false)
v01:SetValue(_G.Auto_Stats_Melee)

local v02 = v16.Stats:AddToggle("ToggleDe", {
    Title = "Add Defense",
    Description = "",
    Default = GetConfig("ToggleDe", false)
});
v02:OnChanged(function(v)
    _G.Auto_Stats_Defense = v;
    SetConfig("ToggleDe", v)
end);
_G.Auto_Stats_Defense = GetConfig("ToggleDe", false)
v02:SetValue(_G.Auto_Stats_Defense)

local v09 = v16.Stats:AddToggle("ToggleSword", {
    Title = "Add Sword",
    Description = "",
    Default = GetConfig("ToggleSword", false)
});
v09:OnChanged(function(v)
    _G.Auto_Stats_Sword = v;
    SetConfig("ToggleSword", v)
end);
_G.Auto_Stats_Sword = GetConfig("ToggleSword", false)
v09:SetValue(_G.Auto_Stats_Sword)

local v010 = v16.Stats:AddToggle("ToggleGun", {
    Title = "Add Gun",
    Description = "",
    Default = GetConfig("ToggleGun", false)
});
v010:OnChanged(function(v)
    _G.Auto_Stats_Gun = v;
    SetConfig("ToggleGun", v)
end);
_G.Auto_Stats_Gun = GetConfig("ToggleGun", false)
v010:SetValue(_G.Auto_Stats_Gun)

local v011 = v16.Stats:AddToggle("ToggleFruit", {
    Title = "Add Blox Fruit",
    Description = "",
    Default = GetConfig("ToggleFruit", false)
});
v011:OnChanged(function(v)
    _G.Auto_Stats_Devil_Fruit = v;
    SetConfig("ToggleFruit", v)
end);
_G.Auto_Stats_Devil_Fruit = GetConfig("ToggleFruit", false)
v011:SetValue(_G.Auto_Stats_Devil_Fruit)

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
-------Tab Fruit/Raid-----------------------------------------------
local FruitLabel = v16.Fruit_Raid:AddSection("Fruit")
local TweenToFruit = v16.Fruit_Raid:AddToggle("TweenToFruit", {
    Title = "Tween To Fruit",
    Description = "",
    Default = GetConfig("TweenToFruit", false)
})
TweenToFruit:OnChanged(function(v)
    getgenv().TweenToFruit = v
    SetConfig("TweenToFruit", v)
end)
getgenv().TweenToFruit = GetConfig("TweenToFruit", false)
TweenToFruit:SetValue(getgenv().TweenToFruit)

spawn(function()
    while wait(0.2) do
        if getgenv().TweenToFruit then
            for i, v in pairs(game.Workspace:GetChildren()) do
                if string.find(v.Name, "Fruit") then
                    TweenToPosition(v.Handle.CFrame);
                end;
            end;
        end;
    end;
end);


local AutoStoreFruit = v16.Fruit_Raid:AddToggle("AutoStoreFruit", {
    Title = "Auto Store Fruit",
    Description = "",
    Default = GetConfig("AutoStoreFruit", false)
})

AutoStoreFruit:OnChanged(function(v)
    getgenv().AutoStoreFruit = v
    SetConfig("AutoStoreFruit", v)
end)

getgenv().AutoStoreFruit = GetConfig("AutoStoreFruit", false)
AutoStoreFruit:SetValue(getgenv().AutoStoreFruit)

spawn(function()
    while task.wait() do
        if getgenv().AutoStoreFruit then
            pcall(function()
                if getgenv().AutoStoreFruit then
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rocket Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rocket Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rocket-Rocket", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rocket Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spin-Spin", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spike Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spike-Spike", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spike Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Blade Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Blade Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Blade-Blade", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Blade Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spring Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spring-Spring", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spring Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rocket Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rocket-Rocket", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kilo Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Smoke Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Smoke-Smoke", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Smoke Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spin Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spin-Spin", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spin Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Flame Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Flame-Flame", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Flame Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Falcon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Falcon Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Falcon", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("alcon Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ice Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Ice-Ice", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Ice Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Sand Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Sand-Sand", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Sand Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dark Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dark-Dark", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dark Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Ghost Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Ghost-Ghost", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Revive Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Diamond Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Diamond-Diamond", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Diamond Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Light Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Light-Light", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Light Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Love Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Love-Love", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Love Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rubber Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rubber-Rubber", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rubber Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Barrier Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Barrier-Barrier", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Barrier Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Magma Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Magma-Magma", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Magma Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Portal Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Portal Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Door-Door", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Portal Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Quake Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Quake-Quake", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Quake Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Buddha Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Buddha Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buddha", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Buddha Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spider Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spider Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Spider-Spider", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spider Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Bird: Phoenix Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Phoenix Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Phoenix", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Phoenix Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Rumble Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Rumble-Rumble", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Rumble Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Pain Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pain Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Pain-Pain", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Pain Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gravity Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Gravity-Gravity", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gravity Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dough Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dough-Dough", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dough Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Shadow Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Shadow-Shadow", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Shadow Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Venom Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Venom-Venom", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Venom Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Control Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Control-Control", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Control Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Spirit Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spirit Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Soul-Soul", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Spirit Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Gas Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gas Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Gas-Gas", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Gas Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("T-Rex Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("T-Rex Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "T-Rex-T-Rex", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("T-Rex Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Yeti Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yeti Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Yeti-Yeti", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Yeti Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Kitsune Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kitsune Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Kitsune-Kitsune", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Kitsune Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Mammoth Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Mammoth Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Mammoth-Mammoth", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Mammoth Fruit"));
                    end
                    if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Dragon Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit")) then
                        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Dragon-Dragon", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Dragon Fruit"));
                        if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("Leopard Fruit") or game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit")) then
                            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StoreFruit", "Leopard-Leopard", game:GetService("Players").LocalPlayer.Backpack:FindFirstChild("Leopard Fruit"));
                        end
                    end
                end
            end);
        end
        wait();
    end
end);


local RandomFruit = v16.Fruit_Raid:AddToggle("RandomFruit", {
    Title = "Random Fruit",
    Description = "",
    Default = GetConfig("RandomFruit", false)
})
RandomFruit:OnChanged(function(v)
    _G.RandomFruit = v
    SetConfig("RandomFruit", v)
end)
_G.RandomFruit = GetConfig("RandomFruit", false)
RandomFruit:SetValue(_G.RandomFruit)
spawn(function()
    pcall(function()
        while wait(0.2) do
            if _G.RandomFruit then
                (game:GetService("ReplicatedStorage")).Remotes.CommF_:InvokeServer("Cousin", "Buy");
            end;
        end;
    end);
end);
if World1 then
    local RaidLabelSea_1 = v16.Fruit_Raid:AddSection("Raid")
    local RaidLabelSea1 = v16.Fruit_Raid:AddSection("Function Only Sea 2 And Sea 3")
end
if World2 or World3 then 
    local RaidLabel = v16.Fruit_Raid:AddSection("Raid")
end
-------------Tab Teleport--------------------------------------------------------------
local TravelLabel = v16.Teleport:AddSection("Travel")
v16.Teleport:AddButton({
    Title = "World 1",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelMain");
    end
});
v16.Teleport:AddButton({
    Title = "World 2",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelDressrosa");
    end
});
v16.Teleport:AddButton({
    Title = "World 3",
    Description = "",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("TravelZou");
    end
});
local IslandLabel = v16.Teleport:AddSection("Islands");
if World1 then
    IslandList = {
        "WindMill",
        "Marine",
        "Middle Town",
        "Jungle",
        "Pirate Village",
        "Desert",
        "Snow Island",
        "MarineFord",
        "Colosseum",
        "Sky Island 1",
        "Sky Island 2",
        "Sky Island 3",
        "Prison",
        "Magma Village",
        "Under Water Island",
        "Fountain City",
        "Shank Room",
        "Mob Island"
    };
elseif World2 then
    IslandList = {
        "The Cafe",
        "Frist Spot",
        "Dark Area",
        "Flamingo Mansion",
        "Flamingo Room",
        "Green Zone",
        "Factory",
        "Colossuim",
        "Zombie Island",
        "Two Snow Mountain",
        "Punk Hazard",
        "Cursed Ship",
        "Ice Castle",
        "Forgotten Island",
        "Ussop Island",
        "Mini Sky Island"
    };
elseif World3 then
    IslandList = {
        "Mansion",
        "Port Town",
        "Great Tree",
        "Castle On The Sea",
        "MiniSky",
        "Hydra Island",
        "Floating Turtle",
        "Haunted Castle",
        "Ice Cream Island",
        "Peanut Island",
        "Cake Island",
        "Cocoa Island",
        "Candy Island",
        "Tiki Outpost"
    };
end
local DropDownIsland = v16.Teleport:AddDropdown("DropdownIsland", {
    Title = "Select Island",
    Description = "",
    Values = IslandList,
    Multi = false,
    Default = 1
});
DropDownIsland:SetValue(_G.SelectIsland);
DropDownIsland:OnChanged(function(v)
    _G.SelectIsland = v;
end);
v16.Teleport:AddButton({
    Title = "Start Tween To Island",
    Description = "",
    Callback = function()
        if (_G.SelectIsland == "WindMill") then
            TP1(CFrame.new(979.79895019531, 16.516613006592, 1429.0466308594));
        elseif (_G.SelectIsland == "Marine") then
            TP1(CFrame.new(- 2566.4296875, 6.8556680679321, 2045.2561035156));
        elseif (_G.SelectIsland == "Middle Town") then
            TP1(CFrame.new(- 690.33081054688, 15.09425163269, 1582.2380371094));
        elseif (_G.SelectIsland == "Jungle") then
            TP1(CFrame.new(- 1612.7957763672, 36.852081298828, 149.12843322754));
        elseif (_G.SelectIsland == "Pirate Village") then
            TP1(CFrame.new(- 1181.3093261719, 4.7514905929565, 3803.5456542969));
        elseif (_G.SelectIsland == "Desert") then
            TP1(CFrame.new(944.15789794922, 20.919729232788, 4373.3002929688));
        elseif (_G.SelectIsland == "Snow Island") then
            TP1(CFrame.new(1347.8067626953, 104.66806030273, - 1319.7370605469));
        elseif (_G.SelectIsland == "MarineFord") then
            TP1(CFrame.new(- 4914.8212890625, 50.963626861572, 4281.0278320313));
        elseif (_G.SelectIsland == "Colosseum") then
            TP1(CFrame.new(- 1427.6203613281, 7.2881078720093, - 2792.7722167969));
        elseif (_G.SelectIsland == "Sky Island 1") then
            TP1(CFrame.new(- 4869.1025390625, 733.46051025391, - 2667.0180664063));
        elseif (_G.SelectIsland == "Sky Island 2") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 4607.82275, 872.54248, - 1667.55688));
        elseif (_G.SelectIsland == "Sky Island 3") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 7894.6176757813, 5547.1416015625, - 380.29119873047));
        elseif (_G.SelectIsland == "Prison") then
            TP1(CFrame.new(4875.330078125, 5.6519818305969, 734.85021972656));
        elseif (_G.SelectIsland == "Magma Village") then
            TP1(CFrame.new(- 5247.7163085938, 12.883934020996, 8504.96875));
        elseif (_G.SelectIsland == "Under Water Island") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(61163.8515625, 11.6796875, 1819.7841796875));
        elseif (_G.SelectIsland == "Fountain City") then
            TP1(CFrame.new(5127.1284179688, 59.501365661621, 4105.4458007813));
        elseif (_G.SelectIsland == "Shank Room") then
            TP1(CFrame.new(- 1442.16553, 29.8788261, - 28.3547478));
        elseif (_G.SelectIsland == "Mob Island") then
            TP1(CFrame.new(- 2850.20068, 7.39224768, 5354.99268));
        elseif (_G.SelectIsland == "The Cafe") then
            TP1(CFrame.new(- 380.47927856445, 77.220390319824, 255.82550048828));
        elseif (_G.SelectIsland == "Frist Spot") then
            TP1(CFrame.new(- 11.311455726624, 29.276733398438, 2771.5224609375));
        elseif (_G.SelectIsland == "Dark Area") then
            TP1(CFrame.new(3780.0302734375, 22.652164459229, - 3498.5859375));
        elseif (_G.SelectIsland == "Flamingo Mansion") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 281.93707275390625, 306.130615234375, 609.280029296875));
        elseif (_G.SelectIsland == "Flamingo Room") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(2284.912109375, 15.152034759521484, 905.48291015625));
        elseif (_G.SelectIsland == "Green Zone") then
            TP1(CFrame.new(- 2448.5300292969, 73.016105651855, - 3210.6306152344));
        elseif (_G.SelectIsland == "Factory") then
            TP1(CFrame.new(424.12698364258, 211.16171264648, - 427.54049682617));
        elseif (_G.SelectIsland == "Colossuim") then
            TP1(CFrame.new(- 1503.6224365234, 219.7956237793, 1369.3101806641));
        elseif (_G.SelectIsland == "Zombie Island") then
            TP1(CFrame.new(- 5622.033203125, 492.19604492188, - 781.78552246094));
        elseif (_G.SelectIsland == "Two Snow Mountain") then
            TP1(CFrame.new(753.14288330078, 408.23559570313, - 5274.6147460938));
        elseif (_G.SelectIsland == "Punk Hazard") then
            TP1(CFrame.new(- 6127.654296875, 15.951762199402, - 5040.2861328125));
        elseif (_G.SelectIsland == "Cursed Ship") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(923.40197753906, 125.05712890625, 32885.875));
        elseif (_G.SelectIsland == "Ice Castle") then
            TP1(CFrame.new(6148.4116210938, 294.38687133789, - 6741.1166992188));
        elseif (_G.SelectIsland == "Forgotten Island") then
            TP1(CFrame.new(- 3032.7641601563, 317.89672851563, - 10075.373046875));
        elseif (_G.SelectIsland == "Ussop Island") then
            TP1(CFrame.new(4816.8618164063, 8.4599885940552, 2863.8195800781));
        elseif (_G.SelectIsland == "Mini Sky Island") then
            TP1(CFrame.new(- 288.74060058594, 49326.31640625, - 35248.59375));
        elseif (_G.SelectIsland == "Great Tree") then
            TP1(CFrame.new(2681.2736816406, 1682.8092041016, - 7190.9853515625));
        elseif (_G.SelectIsland == "Castle On The Sea") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375));
        elseif (_G.SelectIsland == "MiniSky") then
            TP1(CFrame.new(- 260.65557861328, 49325.8046875, - 35253.5703125));
        elseif (_G.SelectIsland == "Port Town") then
            TP1(CFrame.new(- 290.7376708984375, 6.729952812194824, 5343.5537109375));
        elseif (_G.SelectIsland == "Hydra Island") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(5661.5322265625, 1013.0907592773438, - 334.9649963378906));
        elseif (_G.SelectIsland == "Floating Turtle") then
            TP1(CFrame.new(- 13274.528320313, 531.82073974609, - 7579.22265625));
        elseif (_G.SelectIsland == "Mansion") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 12468.5380859375, 375.0094299316406, - 7554.62548828125));
        elseif (_G.SelectIsland == "Castle On The Sea") then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("requestEntrance", Vector3.new(- 5075.50927734375, 314.5155029296875, - 3150.0224609375));
        elseif (_G.SelectIsland == "Haunted Castle") then
            TP1(CFrame.new(- 9515.3720703125, 164.00624084473, 5786.0610351562));
        elseif (_G.SelectIsland == "Ice Cream Island") then
            TP1(CFrame.new(- 902.56817626953, 79.93204498291, - 10988.84765625));
        elseif (_G.SelectIsland == "Peanut Island") then
            TP1(CFrame.new(- 2062.7475585938, 50.473892211914, - 10232.568359375));
        elseif (_G.SelectIsland == "Cake Island") then
            TP1(CFrame.new(- 1884.7747802734375, 19.327526092529297, - 11666.8974609375));
        elseif (_G.SelectIsland == "Cocoa Island") then
            TP1(CFrame.new(87.94276428222656, 73.55451202392578, - 12319.46484375));
        elseif (_G.SelectIsland == "Candy Island") then
            TP1(CFrame.new(- 1014.4241943359375, 149.11068725585938, - 14555.962890625));
        elseif (_G.SelectIsland == "Tiki Outpost") then
            TP1(CFrame.new(- 16542.447265625, 55.68632888793945, 1044.41650390625));
        end
    end
});

local NpcList = {};
if World1 then
    NpcList = {
        "Random Devil Fruit",
        "Blox Fruits Dealer",
        "Remove Devil Fruit",
        "Ability Teacher",
        "Dark Step",
        "Electro",
        "Fishman Karate"
    };
elseif World2 then
    NpcList = {
        "Dargon Berath",
        "Mtsterious Man",
        "Mysterious Scientist",
        "Awakening Expert",
        "Nerd",
        "Bar Manager",
        "Barista",
        "Blox Fruits Dealer",
        "Trevor",
        "Enhancement Editor",
        "Pirate Recruiter",
        "Marines Recruiter",
        "Chemist",
        "Cyborg",
        "Ghoul Mark",
        "Guashiem",
        "El Admin",
        "El Rodolfo",
        "Arowe"
    };
elseif World3 then
    NpcList = {
        "Blox Fruits Dealer",
        "Remove Devil Fruit",
        "Horned Man",
        "Hungey Man",
        "Previous Hero",
        "Butler",
        "Lunoven",
        "Trevor",
        "Elite Hunter",
        "Player Hunter",
        "Uzoth"
    };
end;
local NPCLabel = v16.Teleport:AddSection("NPC")
local DropDownNPC = v16.Teleport:AddDropdown("DropDownNPC", {
    Title = "Select NPC",
    Description = "",
    Values = NpcList,
    Multi = false,
    Default = 1
});
DropDownNPC:SetValue(_G.SelectNPC);
DropDownNPC:OnChanged(function(v)
    _G.SelectNPC = v;
end);
v16.Teleport:AddButton({
    Title = "Start Tween To NPC",
    Description = "",
    Callback = function()   
        if _G.SelectNPC == "Dargon Berath" then
            TP1(CFrame.new(703.372986, 186.985519, 654.522034, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Barista" then 
            TP1(CFrame.new(-380.80633544921875, 73.09506225585938, 262.6371154785156))
        elseif _G.SelectNPC == "Mtsterious Man" then
            TP1(CFrame.new(-2574.43335, 1627.92371, -3739.35767, 0.378697902, -0.00000000906400288, 0.92552036, -0.00000000895582009, 1, 0.0000000134578926, -0.92552036, -0.0000000133852689, 0.378697902));
        elseif _G.SelectNPC == "Mysterious Scientist" then
            TP1(CFrame.new(-6437.87793, 250.645355, -4498.92773, 0.502376854, -0.0000000101223634, -0.864648759, 0.0000000234106086, 1, 0.00000000189508653, 0.864648759, -0.0000000211940012, 0.502376854));
        elseif _G.SelectNPC == "Awakening Expert" then
            TP1(CFrame.new(-408.098846, 16.0459061, 247.432846, 0.028394036, 0.000000000617599138, 0.999596894, -0.00000000557905944, 1, -0.000000000459372484, -0.999596894, -0.00000000556376767, 0.028394036));
        elseif _G.SelectNPC == "Nerd" then
            TP1(CFrame.new(-401.783722, 73.0859299, 262.306702, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Bar Manager" then
            TP1(CFrame.new(-385.84726, 73.0458984, 316.088806, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Blox Fruits Dealer" then
            TP1(CFrame.new(-450.725464, 73.0458984, 355.636902, -0.780352175, -0.000000027266168, 0.625340283, 0.00000000978516468, 1, 0.0000000558128797, -0.625340283, 0.0000000496727601, -0.780352175));
        elseif _G.SelectNPC == "Trevor" then
            TP1(CFrame.new(-341.498322, 331.886444, 643.024963, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Plokster" then
            TP1(CFrame.new(-1885.16016, 88.3838196, -1912.28723, -0.513468027, 0, 0.858108759, 0, 1, 0, -0.858108759, 0, -0.513468027));
        elseif _G.SelectNPC == "Enhancement Editor" then
            TP1(CFrame.new(-346.820221, 72.9856339, 1194.36218, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Pirate Recruiter" then
           TP1(CFrame.new(-428.072998, 72.9495239, 1445.32422, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Marines Recruiter" then
            TP1(CFrame.new(-1349.77295, 72.9853363, -1045.12964, 0.866493046, 0, -0.499189168, 0, 1, 0, 0.499189168, 0, 0.866493046));
        elseif _G.SelectNPC == "Chemist" then
            TP1(CFrame.new(-2777.45288, 72.9919434, -3572.25732, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Ghoul Mark" then
            TP1(CFrame.new(635.172546, 125.976357, 33219.832, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Cyborg" then
            TP1(CFrame.new(629.146851, 312.307373, -531.624146, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Guashiem" then
            TP1(CFrame.new(937.953003, 181.083359, 33277.9297, 1, -0.0000000860126406, 0.0000000000000000381773896, 0.0000000860126406, 1, -0.000000000000000189969598, -0.000000000000000038177373, 0.000000000000000189969598, 1));
        elseif _G.SelectNPC == "El Admin" then
            TP1(CFrame.new(1322.80835, 126.345039, 33135.8789, 0.988783717, -0.0000000869797603, -0.149354503, 0.0000000862223786, 1, -0.0000000115461916, 0.149354503, -0.00000000146101409, 0.988783717));
        elseif _G.SelectNPC == "El Rodolfo" then
            TP1(CFrame.new(941.228699, 40.4686775, 32778.9922, -0.818029106, -0.0000000119524382, 0.575176775, -0.0000000128741648, 1, 0.00000000247053866, -0.575176775, -0.00000000538394795, -0.818029106));
        elseif _G.SelectNPC == "Arowe" then
            TP1(CFrame.new(-1994.51038, 125.519142, -72.2622986, -0.16715166, -0.0000000655417338, -0.985931218, -0.0000000713315558, 1, -0.0000000543836585, 0.985931218, 0.0000000612376851, -0.16715166));
        elseif _G.SelectNPC == "Random Devil Fruit" then
            TP1(CFrame.new(-1436.19727, 61.8777695, 4.75247526, -0.557794094, 0.0000000274216543, 0.829979479, 0.0000000583273234, 1, 0.00000000616037932, -0.829979479, 0.0000000518467118, -0.557794094));
        elseif _G.SelectNPC == "Blox Fruits Dealer" then
            TP1(CFrame.new(-923.255066, 7.67800522, 1608.61011, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Remove Devil Fruit" then
           TP1(CFrame.new(5664.80469, 64.677681, 867.85907, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Ability Teacher" then
            TP1(CFrame.new(-1057.67822, 9.65220833, 1799.49146, -0.865874112, -0.0000000926330159, 0.500262439, -0.0000000733759435, 1, 0.00000005816689, -0.500262439, 0.0000000136579752, -0.865874112));
        elseif _G.SelectNPC == "Dark Step" then
            TP1(CFrame.new(-987.873047, 13.7778397, 3989.4978, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Electro" then
            TP1(CFrame.new(-5389.49561, 13.283, -2149.80151, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Fishman Karate" then
            TP1(CFrame.new(61581.8047, 18.8965912, 987.832703, 1, 0, 0, 0, 1, 0, 0, 0, 1));
        elseif _G.SelectNPC == "Random Devil Fruit" then
            TP1(CFrame.new(-12491, 337, -7449));
        elseif _G.SelectNPC == "Blox Fruits Dealer" then
            TP1(CFrame.new(-12511, 337, -7448));
        elseif _G.SelectNPC == "Remove Devil Fruit" then
            TP1(CFrame.new(-5571, 1089, -2661));
        elseif _G.SelectNPC == "Horned Man" then
            TP1(CFrame.new(-11890, 931, -8760));
        elseif _G.SelectNPC == "Hungey Man" then
           TP1(CFrame.new(-10919, 624, -10268));
        elseif _G.SelectNPC == "Previous Hero" then
            TP1(CFrame.new(-10368, 332, -10128));
        elseif _G.SelectNPC == "Butler" then
            TP1(CFrame.new(-5125, 316, -3130));
        elseif _G.SelectNPC == "Lunoven" then
            TP1(CFrame.new(-5117, 316, -3093));
        elseif _G.SelectNPC == "Elite Hunter" then
           TP1(CFrame.new(-5420, 314, -2828));
        elseif _G.SelectNPC == "Player Hunter" then
            TP1(CFrame.new(-5559, 314, -2840));
        elseif _G.SelectNPC == "Uzoth" then
            TP1(CFrame.new(-9785, 852, 6667));
        end;
    end
})

-------Tab Shop--------------------------
v16.Shop:AddParagraph({
    Title = "Fighting Shop",
    Content = string.rep("-", 21)
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF_Remote = Remotes:WaitForChild("CommF_")
v16.Shop:AddButton({
    Title = "Black Leg",
    Callback = function()
        local success, result = pcall(function()
            return CommF_Remote:InvokeServer("BuyBlackLeg")
        end)
        if not success then            
        end
    end
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF_Remote = Remotes:WaitForChild("CommF_")
v16.Shop:AddButton({
    Title = "Fishman Karate",
    Callback = function()
        local success, result = pcall(function()
            return CommF_Remote:InvokeServer("BuyFishmanKarate")
        end)
        if not success then            
        end
    end
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF_Remote = Remotes:WaitForChild("CommF_")
v16.Shop:AddButton({
    Title = "Electro",
    Callback = function()
        local success, result = pcall(function()
            return CommF_Remote:InvokeServer("BuyElectro")
        end)
        if not success then            
        end
    end
})
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local CommF_Remote = Remotes:WaitForChild("CommF_")
v16.Shop:AddButton({
    Title = "Dragon Breath",
    Callback = function()
        local success1, result1 = pcall(function()
            return CommF_Remote:InvokeServer("BlackbeardReward", "DragonClaw", "1")
        end)
        if not success1 then
            return
        end
        local success2, result2 = pcall(function()
            return CommF_Remote:InvokeServer("BlackbeardReward", "DragonClaw", "2")
        end)
        if not success2 then
            return
        end
    end
})
v16.Shop:AddButton({
    Title = "SuperHuman",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuySuperhuman")
    end
})
v16.Shop:AddButton({
    Title = "Death Step",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuyDeathStep")
    end
})
v16.Shop:AddButton({
    Title = "Sharkman Karate",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuySharkmanKarate", true)
        wait(0.2)
        CommF_:InvokeServer("BuySharkmanKarate")
    end
})
v16.Shop:AddButton({
    Title = "Electric Claw",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuyElectricClaw")
    end
})
v16.Shop:AddButton({
    Title = "Dragon Talon",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuyDragonTalon")
    end
})
v16.Shop:AddButton({
    Title = "God Human",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuyGodhuman")
    end
})
v16.Shop:AddButton({
    Title = "Sanguine Art",
    Callback = function()
        local ReplicatedStorage = game:GetService("ReplicatedStorage")
        local CommF_ = ReplicatedStorage.Remotes.CommF_
        CommF_:InvokeServer("BuySanguineArt", true)
        wait(0.2)
        CommF_:InvokeServer("BuySanguineArt")
    end
})
v16.Shop:AddParagraph({
    Title = "Abilities Shop",
    Content = string.rep("-", 21)
})
v16.Shop:AddButton({
    Title = "Skyjump [ $10,000 Beli ]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Geppo")
    end
})
v16.Shop:AddButton({
    Title = "Buso Haki [ $25,000 Beli ]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Buso")
    end
})
v16.Shop:AddButton({
    Title = "Observation haki [ $750,000 Beli ]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("KenTalk","Buy")
    end
})
v16.Shop:AddButton({
    Title = "Soru [ $100,000 Beli ]",
    Callback = function()
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyHaki","Soru")
    end
})
v16.Shop:AddParagraph({
    Title = "Misc Shop",
    Content = string.rep("-", 21)
})
v16.Shop:AddButton({
     Title = "Buy Refund Stat (2500F)",
     Callback = function()            
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","1")
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Refund","2")
     end
})
v16.Shop:AddButton({
     Title = "Buy Reroll Race (3000F)",
     Callback = function()            
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","1")
         game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BlackbeardReward","Reroll","2")
     end
})
v16.Shop:AddButton({
    Title = "Buy Ghoul Race",
    Callback = function()
        local args1 = {[1] = "Ectoplasm", [2] = "BuyCheck", [3] = 4}
        local args2 = {[1] = "Ectoplasm", [2] = "Change", [3] = 4}
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args1))        
        wait(0.5)
        game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args2))
    end
})
v16.Shop:AddButton({
    Title = "Buy Cyborg Race (2500F)",
    Callback = function()
        if not isBuying then
            isBuying = true
            local args = {[1] = "CyborgTrainer", [2] = "Buy"}
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer(unpack(args))                        
            wait(0.5)
            isBuying = false
        end
    end
})
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

local SettingLabel = v16.Setting:AddSection("Setting Fram")

local WeaponList = { "Melee", "Sword", "Blox Fruit" }

local WeaponListSelect = v16.Setting:AddDropdown("Weapon", {
    Title = "Select Weapon",
    Description = "",
    Values = WeaponList,
    Multi = false,
    Default = GetConfig("Weapon", "Melee") 
})

WeaponListSelect:OnChanged(function(v)
    _G.SelectWeaponType = v
    SetConfig("Weapon", v)
end)

_G.SelectWeaponType = GetConfig("Weapon", "Melee")
WeaponListSelect:SetValue(_G.SelectWeaponType)

-- Lưu tên Weapon
_G.SelectWeapon = nil

-- Tự động chọn Weapon
task.spawn(function()
    while wait(0.2) do
        pcall(function()
            for _, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
                if v.ToolTip == _G.SelectWeaponType then
                    _G.SelectWeapon = v.Name
                    break
                end
            end
        end)
    end
end)

local SpeedList = {
    "180", "250", "300", "325", "350"
}

local DropDownTween = v16.Setting:AddDropdown("TweenSpeed", {
    Title = "Tween Speed",
    Description = "",
    Values = SpeedList,
    Multi = false,
    Default = GetConfig("TweenSpeed", "325")
})

local savedSpeed = GetConfig("TweenSpeed", "325")
DropDownTween:SetValue(savedSpeed)
getgenv().TweenSpeed = tonumber(savedSpeed)

DropDownTween:OnChanged(function(v)
    getgenv().TweenSpeed = tonumber(v)     
    SetConfig("TweenSpeed", v)
end)

local BringDistanceList = {"200", "250", "350"}

local BringDistance = v16.Setting:AddDropdown("BringDistance", {
    Title = "Bring Mode Distance",
    Description = "",
    Values = BringDistanceList,
    Multi = false,
    Default = GetConfig("BringDistance", nil)
})

-- Phát hiện thiết bị
local isMobile = game:GetService("UserInputService").TouchEnabled
local defaultBring = isMobile and "200" or "200"

-- Ưu tiên giá trị đã lưu, nếu chưa có thì dùng mặc định theo thiết bị
local savedBring = GetConfig("BringDistance", nil)
if savedBring then
    BringDistance:SetValue(savedBring)
else
    BringDistance:SetValue(defaultBring)
    SetConfig("BringDistance", defaultBring)
end

-- Khi người dùng chọn giá trị mới
BringDistance:OnChanged(function(v)
    _G.BringMode = tonumber(v)
    SetConfig("BringDistance", v)
end)

-- Gán giá trị ban đầu
_G.BringMode = tonumber(BringDistance.Value)


local v4033 = v16.Setting:AddToggle("ToggleBringMob", {
    Title = "Bring Mob",
    Description = "",
    Default = true
});
v4033:OnChanged(function(v4034)
    _G.BringMonster = v4034;
end);

function TweenEnemyToTarget(enemy, targetCFrame, size)
    pcall(function()
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        local hum = enemy:FindFirstChild("Humanoid")
        if not hrp or not hum or hum.Health <= 0 then return end

        -- Cấu hình cơ bản
        hrp.Size = size or Vector3.new(50, 50, 50)
        hrp.CanCollide = false
        if enemy:FindFirstChild("Head") then
            enemy.Head.CanCollide = false
        end
        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)

        -- Tween quái đến vị trí trước người chơi
        local player = game.Players.LocalPlayer
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end

        local posBelowPlayer = root.CFrame * CFrame.new(0, -21, 0)
        local tweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Linear)
        local tween = game:GetService("TweenService"):Create(hrp, tweenInfo, {CFrame = posBelowPlayer})

        tween:Play()

        -- Khi tween kết thúc, giữ quái cố định tại vị trí cuối
        tween.Completed:Connect(function()
            if not hrp.Parent or hum.Health <= 0 then return end
            hrp.CFrame = CFrame.new(posBelowPlayer.Position)
            hrp.Velocity = Vector3.zero
            hrp.RotVelocity = Vector3.zero

            -- Tạo kết nối để giữ mob anchored nếu cần trong thời gian dài
            local RunService = game:GetService("RunService")
            local conn
            conn = RunService.Stepped:Connect(function()
                if not hrp.Parent or hum.Health <= 0 then
                    conn:Disconnect()
                    return
                end
                hrp.CFrame = CFrame.new(posBelowPlayer.Position)
                hrp.Velocity = Vector3.zero
                hrp.RotVelocity = Vector3.zero
            end)
        end)
    end)
end


spawn(function()
    while task.wait() do
        pcall(function()
            if _G.BringMonster then
                CheckQuest()
                local brought = 0

                for _, enemy in pairs(workspace.Enemies:GetChildren()) do
                    if brought >= 2 then break end

                    local hrp = enemy:FindFirstChild("HumanoidRootPart")
                    local hum = enemy:FindFirstChild("Humanoid")
                    if not hrp or not hum or hum.Health <= 0 then continue end

                    local distanceToPlayer = (hrp.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude

                    -- Ectoplasm (Ship)
                    if _G.Ectoplasm and StartEctoplasmMagnet and string.find(enemy.Name, "Ship") then
                        if (hrp.Position - EctoplasmMon.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, EctoplasmMon)
                            brought += 1
                        end

                    -- Rengoku (Snow Lurker / Arctic Warrior)
                    elseif _G.Rengoku and StartRengokuMagnet and (enemy.Name == "Snow Lurker" or enemy.Name == "Arctic Warrior") then
                        if (hrp.Position - RengokuMon.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, RengokuMon, Vector3.new(1500, 1500, 1500))
                            brought += 1
                        end

                    -- Musketeer Hat
                    elseif _G.MusketeerHat and StartMagnetMusketeerhat and enemy.Name == "Forest Pirate" then
                        if (hrp.Position - MusketeerHatMon.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, MusketeerHatMon)
                            brought += 1
                        end

                    -- Observation Haki V2
                    elseif _G.ObservationHakiV2 and Mangnetcitzenmon and enemy.Name == "Forest Pirate" then
                        if (hrp.Position - PosHee.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosHee)
                            brought += 1
                        end

                    -- EvoRace (Zombie)
                    elseif _G.EvoRace and StartEvoMagnet and enemy.Name == "Zombie" then
                        if (hrp.Position - PosMonEvo.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonEvo)
                            brought += 1
                        end

                    -- Bartilo Quest (Swan Pirate)
                    elseif _G.Bartilo and AutoBartiloBring and enemy.Name == "Swan Pirate" then
                        if (hrp.Position - PosMonBarto.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonBarto)
                            brought += 1
                        end

                    -- Auto Material
                    elseif _G.AutoMaterial and StartMaterialMagnet and table.find({
                        "Factory Staff", "Water Fighter", "Military Spy", "Magma Ninja",
                        "God's Guard", "Brute", "Marine Captain", "Jungle Pirate",
                        "Swan Pirate", "Fishman Raider", "Fishman Warrior",
                        "Demonic Soul", "Vampire", "Chocolate Bar Battler",
                        "Dragon Crew Archer", "Pistol Billionaire", "Hydra Enforcer",
                        "Venomous Assailant", "Mythological Pirate",
                        "Ship Deckhand", "Ship Engineer", "Ship Steward", "Ship Officer"
                    }, enemy.Name) then
                        if (hrp.Position - PosMonMaterial.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonMaterial)
                            brought += 1
                        end

                    -- Mastery Fruit
                    elseif _G.FarmFruitMastery and StartMasteryFruitMagnet and ((enemy.Name == "Monkey") or (enemy.Name == "Factory Staff") or (enemy.Name == Mon)) then
                        if (hrp.Position - PosMonMasteryFruit.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonMasteryFruit)
                            brought += 1
                        end

                    -- Mastery Gun
                    elseif _G.FarmGunMastery and StartMasteryGunMagnet and ((enemy.Name == "Monkey") or (enemy.Name == "Factory Staff") or (enemy.Name == Mon)) then
                        if (hrp.Position - PosMonMasteryGun.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonMasteryGun)
                            brought += 1
                        end

                    -- Bone Farm
                    elseif _G.Bone and StartMagnetBoneMon and table.find({
                        "Reborn Skeleton", "Living Zombie", "Demonic Soul", "Posessed Mummy"
                    }, enemy.Name) then
                        if (hrp.Position - PosMonBone.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonBone)
                            brought += 1
                        end

                    -- DoughtBoss
                    elseif _G.DoughtBoss and MagnetDought and table.find({
                        "Cookie Crafter", "Cake Guard", "Baking Staff", "Head Baker"
                    }, enemy.Name) then
                        if (hrp.Position - PosMonDoughtOpenDoor.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonDoughtOpenDoor)
                            brought += 1
                        end

                    -- Nearest Mode
                    elseif _G.FarmNearest and AutoFarmNearestMagnet then
                        if (hrp.Position - PosMonNear.Position).Magnitude <= _G.BringMode then
                            TweenEnemyToTarget(enemy, PosMonNear)
                            brought += 1
                        end

                    -- Default BringMonster by Level & Mon
                    elseif _G.Level and StartMagnet and enemy.Name == Mon then
                        local isSpecial = table.find({
                            "Factory Staff [Lv. 800]", "Monkey [Lv. 14]", "Gorilla [Lv. 20]",
                            "Dragon Crew Warrior [Lv. 1575]", "Dragon Crew Archer [Lv. 1600]",
                            "Mercenary [Lv. 725]"
                        }, Mon)
                        local dist = (hrp.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
                        if (isSpecial and dist <= 220) or (not isSpecial and dist <= _G.BringMode) then
                            TweenEnemyToTarget(enemy, PosMon)
                            brought += 1
                        end
                    end
                end
            end
        end)
    end
end)


local AutoBuso = v16.Setting:AddToggle("AutoBuso", {
    Title = "Buso Haki",
    Description = "",
    Default = GetConfig("AutoBuso", true)
});
AutoBuso:OnChanged(function(v)
    _G.Haki = v;
    SetConfig("AutoBuso", v)
end);
_G.Haki = GetConfig("AutoBuso", true)
AutoBuso:SetValue(_G.Haki)
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

local NoClip = v16.Setting:AddToggle("NoClip", {
    Title = "NoClip",
    Description = "",
    Default = GetConfig("NoClip", true)
})
NoClip:OnChanged(function(v)
    _G.Noclip = v;
    SetConfig("NoClip", v)
end);
_G.Noclip = GetConfig("NoClip", true)
NoClip:SetValue(_G.Noclip)

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

local AutoObservation = v16.Setting:AddToggle("AutoObservation", {
    Title = "Auto Turn On Observation",
    Description = "",
    Default = GetConfig("AutoObservation", false)
})
AutoObservation:OnChanged(function()
    _G.Observation = v
    SetConfig("AutoObservation", v)
end)
_G.Observation = GetConfig("AutoObservation", false)
AutoObservation:SetValue(_G.Observation)

spawn(function()
    while wait(0.2) do
        if _G.Observation then
            if not (game:GetService("Players")).LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
                (game:GetService("VirtualUser")):CaptureController();
                (game:GetService("VirtualUser")):SetKeyDown("0x65");
                task.wait();
                (game:GetService("VirtualUser")):SetKeyUp("0x65");
            end;
        end;
    end;
end);

local TurnOnV3 = v16.Setting:AddToggle("TurnOnV3", {
    Title = "Auto Turn On V3",
    Description = "",
    Default = GetConfig("TurnOnV3", false)
})
TurnOnV3:OnChanged(function(v)
    _G.AutoTurnOnV3 = v;
    SetConfig("TurnOnV3", v)
end)
_G.AutoTurnOnV3 = GetConfig("TurnOnV3", false)
TurnOnV3:SetValue(_G.AutoTurnOnV3)

task.spawn(function()
    local prevState = false    
    while true do
        task.wait(0.1)        
        pcall(function()
            if _G.AutoTurnOnV3 ~= prevState then
                if _G.AutoTurnOnV3 then
                    game:GetService("ReplicatedStorage").Remotes.CommE:FireServer("ActivateAbility")
                end
                prevState = _G.AutoTurnOnV3
            end
        end)
    end
end)

local TurnOnV4 = v16.Setting:AddToggle("TurnOnV4", {
    Title = "Auto Turn On V4",
    Description = "",
    Default = GetConfig("TurnOnV4", false)
})
TurnOnV4:OnChanged(function(v)
    _G.AutoTurnOnV4 = v;
    SetConfig("TurnOnV4", v)
end)
_G.AutoTurnOnV4 = GetConfig("TurnOnV4", false)
TurnOnV4:SetValue(_G.AutoTurnOnV4)

task.spawn(function()
    local lastCheckTime = 0
    while true do
        task.wait(0.1)
        if _G.AutoTurnOnV4 then
            local currentTime = tick()
            if currentTime - lastCheckTime >= 0.5 then
                lastCheckTime = currentTime
                local character = game.Players.LocalPlayer.Character
                if character and character:FindFirstChild("RaceEnergy") and
                   character.RaceEnergy.Value >= 1 and
                   not character.RaceTransformed.Value then
                    local be = game:GetService("VirtualInputManager")
                    be:SendKeyEvent(true, "Y", false, game)
                    task.wait(0.1)
                    be:SendKeyEvent(false, "Y", false, game)
                end
            end
        end
    end
end)
local AutoSetSpawn = v16.Setting:AddToggle("AutoSetSpawn", {
    Title = "Auto Set Spawn Point",
    Description = "",
    Default = GetConfig("AutoSetSpawn", false)
})
local lastSetState = false
AutoSetSpawn:OnChanged(function(v)
    _G.Set = v
    SetConfig("AutoSetSpawn", v)
    if Value ~= lastSetState then
        lastSetState = Value
        if v then
            pcall(function()
                game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetSpawnPoint")
            end)
        end
    end
end)
_G.Set = GetConfig("AutoSetSpawn", false)
AutoSetSpawn:SetValue(_G.Set)

local AutoRejoin = v16.Setting:AddToggle("AutoRejoin", {
    Title = "Auto Rejoin if Kicked",
    Description = "",
    Default = GetConfig("AutoRejoin", false)
})
AutoRejoin:OnChanged(function(v)
    _G.AutoRejoin = v
    SetConfig("AutoRejoin", v)
end)
_G.AutoRejoin = GetConfig("AutoRejoin", false)
AutoRejoin:SetValue(_G.AutoRejoin)

spawn(function()
    while task.wait(0.2) do
        if _G.AutoRejoin then
            getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                end
            end)
        end
    end
end)
local SettingGrapficLabel = v16.Setting:AddSection("Graphics Settings")

local RVNF = v16.Setting:AddToggle("RVNF", {
    Title = "Remove Notifications",
    Description = "",
    Default = GetConfig("RVNF", false)
});

RVNF:OnChanged(function(v)
    _G.Remove_trct = v;
    SetConfig("RVNF", v)
end);
_G.Remove_trct = GetConfig("RVNF", false)
RVNF:SetValue(_G.Remove_trct)

spawn(function()
    while task.wait(0.2) do
        if _G.Remove_trct then
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = false;
        else
            game.Players.LocalPlayer.PlayerGui.Notifications.Enabled = true;
        end
    end
end);


local WhiteScreen = v16.Setting:AddToggle("WhiteScreen", {
    Title = "White Screen",
    Description = "",
    Default = GetConfig("WhiteScreen", false)
});
WhiteScreen:OnChanged(function(v)
    _G.WhiteScreen = v;
    SetConfig("WhiteScreen", v)
    if (_G.WhiteScreen == true) then
        game:GetService("RunService"):Set3dRenderingEnabled(false);
    elseif (_G.WhiteScreen == false) then
        game:GetService("RunService"):Set3dRenderingEnabled(true);
    end
end);   
_G.WhiteScreen = GetConfig("WhiteScreen", false)
WhiteScreen:SetValue(_G.WhiteScreen)

spawn(function()
    while task.wait(0.2) do
        if _G.WhiteScreen then
            for v2141, v2142 in pairs(game.Workspace['_WorldOrigin']:GetChildren()) do
                if ((v2142.Name == "CurvedRing") or (v2142.Name == "SlashHit") or (v2142.Name == "DamageCounter") or (v2142.Name == "SwordSlash") or (v2142.Name == "SlashTail") or (v2142.Name == "Sounds")) then
                    v2142:Destroy();
                end
            end
        end
    end
end); 

local HideMob = v16.Setting:AddToggle("HideMob", {
    Title = "Hide Mob",
    Description = "",
    Default = GetConfig("HideMob", false)
});
HideMob:OnChanged(function(v)
    _G.inv = v
    SetConfig("HideMob", v)
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
_G.inv = GetConfig("HideMob", false)
HideMob:SetValue(_G.inv)
