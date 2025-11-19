local HiuUi =  loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/main/LoadUi.lua"))()
local ServerHop = loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/main/HopServerModule.lua"))()
local HttpService = game:GetService("HttpService")

if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
        local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes")
        l_Remotes_0.CommF_:InvokeServer("SetTeam", getgenv().team or "Marines")
        task.wait(3)
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end

local Window = HiuUi:Window({
	Title = "Vex Hub",
	SubTitle = "Blox Kid",
	Theme = "rbxassetid://84435441882847",
	UiTransparency = 0.75,
	Size = UDim2.new(0, 550, 0, 350),
    TabWidth = 120
})

if (game.PlaceId == 2753915549) then
    World1 = true
elseif (game.PlaceId == 4442272183) then
    World2 = true
elseif (game.PlaceId == 7449423635) then
    World3 = true
end

local StockFruitTab = Window:Tab("Fruits Stock","")

local StockSeperator = StockFruitTab:Seperator("Current Fruits Stock")
local StockLine = StockFruitTab:Line()
local StocksStatus = StockFruitTab:Label("Current Fruits Stock: Unknown")

local function fetchFruitsStock()
    local url = "https://fruitsstockapi.onrender.com/fruitstock"
    local response
    local success, err = pcall(function()
        response = game:HttpGet(url)
    end)
    if not success then
        warn("[HTTP ERROR]:", err)
        return nil, nil
    end

    local data
    local decodeSuccess, decodeErr = pcall(function()
        data = HttpService:JSONDecode(response)
    end)
    if not decodeSuccess then
        warn("[JSON ERROR]:", decodeErr)
        return nil, nil
    end

    if data.status ~= "success" then
        warn("[INVALID DATA]: Failed to Get DATA")
        return nil, nil
    end

    local normalStock = data.normalStock or {}
    local mirageStock = data.mirageStock or {}

    return normalStock, mirageStock
end

task.spawn(function()
    while task.wait(0.5) do 
        local normalStock, mirageStock = fetchFruitsStock()
        if normalStock and mirageStock then
            local ignoreList = {
                ["Rocket-Rocket"] = true,
                ["Spin-Spin"] = true
            }

            local lines = {}

            for _ = 1, 10 do table.insert(lines, "") end

            table.insert(lines, "🌍 Normal Stock:")
            for _, fruit in ipairs(normalStock) do
                if not ignoreList[fruit.name] then
                    table.insert(lines, " - " .. fruit.name)
                end
            end
            for _ = 1, 1 do table.insert(lines, "") end

            table.insert(lines, "🏝 Mirage Stock:")
            for _, fruit in ipairs(mirageStock) do
                if not ignoreList[fruit.name] then
                    table.insert(lines, " - " .. fruit.name)
                end
            end

            StocksStatus:Set(table.concat(lines, "\n"))
        else
            StocksStatus:Set("⚠️ Failed to fetch data. Retrying...")
        end
    end
end)

----------------------------------Server Tab---------------------------------------------------------------------------------------------
local ServerTab = Window:Tab("Server","")
local ServerStatus_Se = ServerTab:Seperator("Server Status")
local ServerStatus_Ln = ServerTab:Line()
local MoonStatus_La = ServerTab:Label("Moon Status: Unknown")
task.spawn(function()
    while task.wait(0.5) do
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
                MoonStatus_La:Set("Moon Status: Unknown")
                return
            end

            if moonTextureId == "http://www.roblox.com/asset/?id=9709149431" then
                MoonStatus_La:Set("Moon Status: 🌕 Full Moon")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149052" then
                MoonStatus_La:Set("Moon Status: 🌖 75%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709143733" then
                MoonStatus_La:Set("Moon Status: 🌓 50%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709150401" then
                MoonStatus_La:Set("Moon Status: 🌘 25%")
            elseif moonTextureId == "http://www.roblox.com/asset/?id=9709149680" then
                MoonStatus_La:Set("Moon Status: 🌑 15%")
            else
                MoonStatus_La:Set("Moon Status: 🌚 0%")
            end
        end)
    end
end)
if World1 then
    local TheSawStatus_La = ServerTab:Label("The Saw Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("The Saw") or game:GetService("Workspace").Enemies:FindFirstChild("The Saw") then
                    TheSawStatus_La:Set("The Saw Status : ✅️")
                else
                    TheSawStatus_La:Set("The Saw Status : ❌️")
                end
            end)
        end
    end)

    local GreyBeardStatus_La = ServerTab:Label("Grey Beard Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Greybeard") or game:GetService("Workspace").Enemies:FindFirstChild("Greybeard") then
                    GreyBeardStatus_La:Set("Grey Beard Status : ✅️")
                else
                    GreyBeardStatus_La:Set("Grey Beard Status : ❌️")
                end
            end)
        end
    end)
end
if World2 then
    local CursedCaptainStatus_La = ServerTab:Label("Cursed Captain Status: Unknown")
    task.spawn(function()
        while wait(1) do
            pcall(function()
                if game:GetService("ReplicatedStorage"):FindFirstChild("Cursed Captain") or game:GetService("Workspace").Enemies:FindFirstChild("Cursed Captain") then
                    CursedCaptainStatus_La:Set("Cursed Captain Status : ✅️")
                else
                    CursedCaptainStatus_La:Set("Cursed Captain Status : ❌️")
                end
            end)
        end
    end)
    local LegendarySwordStatus = ServerTab:Label("Legendary Sword Status: Unknown")
    task.spawn(function()
        local previousStatus = ""
        while task.wait(0.5) do
            local swordStatus = "Legendary Sword Status : ❌"
            if game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1") then
                swordStatus = "Legendary Sword Status: Shisui"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "2") then
                swordStatus = "Legendary Sword Status: Wando"
            elseif game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("LegendarySwordDealer", "3") then
                swordStatus = "Legendary Sword Status: Saddi"
            end
            LegendarySwordStatus:Set(swordStatus)
        end
    end)
end

if World3 then

    local MirageIslandStatus = ServerTab:Label("Mirage Island Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if game.Workspace.Map:FindFirstChild("MysticIsland") then
                    MirageIslandStatus:Set("Mirage Island Status : ✅")
                else
                    MirageIslandStatus:Set("Mirage Island Status : ❌")
                end
            end)
        end
    end)

    local LeviathanStatus = ServerTab:Label("Spy Status: Unknown")
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                local SpyStatus = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("InfoLeviathan", "1")
                if (SpyStatus == 5) then
                    LeviathanStatus:Set("Spy Status : Leviathan Is Out There")
                elseif (SpyStatus == -1) then
                    LeviathanStatus:Set("Spy Status : I Don't Know")
                else
                    LeviathanStatus:Set("Buy: " .. tostring(SpyStatus))
                end
            end
        end)
    end)

    local FrozenDimensionStatus = ServerTab:Label("Frozen Dimension Status: Unknown")
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("FrozenDimension") then
                    FrozenDimensionStatus:Set("Frozen Dimension Status : ✅")
                else
                    FrozenDimensionStatus:Set("Frozen Dimension Status : ❌")
                end
            end
        end)
    end)

    local KitsuneIslandStatus = ServerTab:Label("Kitsune Island Status: Unknown")
    function UpdateKitsune()
        if game:GetService("Workspace").Map:FindFirstChild("KitsuneIsland") then
            KitsuneIslandStatus:Set("Kitsune Island Status : ✅️")
        else
            KitsuneIslandStatus:Set("Kitsune Island Status : ❌️")
        end
    end
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                UpdateKitsune()
            end
        end)
    end)

    local PrehistoricIslandStatus = ServerTab:Label("Volcano Island: Unknown")
    task.spawn(function()
        pcall(function()
            while task.wait(1) do
                if game:GetService("Workspace").Map:FindFirstChild("PrehistoricIsland") then
                    PrehistoricIslandStatus:Set("Volcano Island : ✅️")
                else
                    PrehistoricIslandStatus:Set("Volcano Island : ❌️")
                end
            end
        end)
    end)

    local CakePrinceStatus = ServerTab:Label("Cake Prince Status: ")
    task.spawn(function()
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

    task.spawn(function()
        while task.wait() do
            pcall(function()
                if string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 88 then
                    CakePrinceStatus:Set("Cake Prince Status Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,41).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 87 then
                    CakePrinceStatus:Set("Cake Prince Status Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,40).." Mobs")
                elseif string.len(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner")) == 86 then
                    CakePrinceStatus:Set("Cake Prince Status Defeat : "..string.sub(game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("CakePrinceSpawner"),39,39).." Mobs")
                else
                    CakePrinceStatus:Set("Cake Prince Status : Cake Prince Is Spawning!")
                end
            end)
        end
    end)

    local EliteHunterStatus = ServerTab:Label("Elite Hunter Status: Unknown")
    task.spawn(function()
        while task.wait(1) do
            pcall(function()
                if (game:GetService("ReplicatedStorage"):FindFirstChild("Diablo") or game:GetService("ReplicatedStorage"):FindFirstChild("Deandre") or game:GetService("ReplicatedStorage"):FindFirstChild("Urban") or game:GetService("Workspace").Enemies:FindFirstChild("Diablo") or game:GetService("Workspace").Enemies:FindFirstChild("Deandre") or game:GetService("Workspace").Enemies:FindFirstChild("Urban")) then
                    EliteHunterStatus:Set("Elite Hunter : ✅️")
                else
                    EliteHunterStatus:Set("Elite Hunter : ❌️")
                end
            end)
        end
    end)
end
local FruitStatus = ServerTab:Label("Fruit in Server: Unknown")
local FruitList = {
    "Bomb Fruit", "Spike Fruit", "Spring Fruit", "Spin Fruit",
    "Eagle Fruit", "Smoke Fruit", "Flame Fruit", "Ice Fruit", "Sand Fruit", "Dark Fruit",
    "Diamond Fruit", "Light Fruit", "Love Fruit", "Rubber Fruit", "Rocket Fruit",
    "Creation Fruit", "Magma Fruit", "Portal Fruit", "Quake Fruit", "Buddha Fruit",
    "String Fruit", "Phoenix Fruit", "Rumble Fruit", "Pain Fruit", "Gravity Fruit",
    "Dough Fruit", "Venom Fruit", "Shadow Fruit", "Control Fruit", "Spirit Fruit",
    "Dragon Fruit", "Leopard Fruit", "Blizzard Fruit", "Sound Fruit", "Spider Fruit",
    "T-Rex Fruit", "Ghost Fruit", "Gas Fruit", "Yeti Fruit", "Kitsune Fruit", "Mammoth Fruit","Tiger Fruit"
}
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            local foundFruits = {}

            for i, v in pairs(game.Workspace:GetChildren()) do
                if v:IsA("Tool") and string.find(v.Name, "Fruit") and v:FindFirstChild("Handle") then
                    table.insert(foundFruits, v.Name)
                end
            end

            if #foundFruits > 0 then
                FruitStatus:Set("Fruit in Server: (" .. #foundFruits .. "): " .. table.concat(foundFruits, ", "))
            else
                FruitStatus:Set("Fruit in Server: ❌")
            end
        end)
    end
end)

local ServerSeperator = ServerTab:Seperator("Server")
local SeverLine = ServerTab:Line()

local ShowJobId = ServerTab:Label("JobId: Unknown")
ShowJobId:Set("JobId: "..game.JobId)

local CopyJobId = ServerTab:Button("Copy JobId", function()
    setclipboard(tostring(game.JobId))
    HiuUi:Notify("Copied JobId Server!")
end)

local JobIdText = ServerTab:Textbox("Enter JobId Here",false, function(n)
    getgenv().JobId = n
end)

local JoinButton = ServerTab:Button("Join Server With JobId", function()
    if getgenv().JobId == "PV" then
        HiuUi:Notify("Teleporting to Vip Server, and Hello Boss: "..game.Players.LocalPlayer.Name)
        task.wait(1.5)
        loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FREE-PRIVATE-SERVER-V2-59627"))()

    elseif getgenv().JobId and getgenv().JobId ~= "" then
        HiuUi:Notify("Teleporting to JobId: "..getgenv().JobId)
        task.wait(1.5)
        game:GetService("TeleportService"):TeleportToPlaceInstance(
            game.PlaceId,
            getgenv().JobId,
            game.Players.LocalPlayer
        )

    else
        HiuUi:Notify("Please Enter JobId First!")
    end
end)


local ClearJobId = ServerTab:Button("Clear JobId", function()
    if not getgenv().JobId or getgenv().JobId == "" then
        return
    end
    getgenv().JobId = nil
    JobIdText:SetValue("")
    HiuUi:Notify("JobId has been cleared!")
end)

local HopServerButton = ServerTab:Button("Hop Server", function ()
    HiuUi:Notify("Teleporting to server: "..ServerHop:GetNextServerJobId())
    task.wait(1.5)
    ServerHop:Teleport()
end)
local HopLowPlayer = ServerTab:Button("Hop Server Less Player",function()
    HiuUi:Notify("Teleporting to server")
    task.wait(1.5)
    loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-FREE-PRIVATE-SERVER-V2-59627"))()
end)
