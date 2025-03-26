local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

local Window = OrionLib:MakeWindow({
    Name = "Hiunocry x Hub",
    HidePremium = false,
    SaveConfig = true,
    ConfigFolder = "OrionTest"
})

local Tab = Window:MakeTab({
    Name = "Test",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})

-- Hàm đảm bảo game đã load
local function waitForGameLoad()
    if not game:IsLoaded() then
        game.Loaded:Wait()
    end
end

-- Nút kích hoạt Keyboard
Tab:AddButton({
    Name = "Keyboard",
    Callback = function()
        print("Keyboard button clicked!") -- Debug
        waitForGameLoad()
        print("Game loaded!") -- Debug

        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", true))()
        end)

        if not success then
            warn("Error loading Keyboard script: " .. err)
        else
            print("Keyboard script loaded successfully!")
        end
    end
})

-- Nút kích hoạt Infinite Yield
Tab:AddButton({
    Name = "Infiniteyield",
    Callback = function()
        print("InfiniteYield button clicked!") -- Debug
        local success, err = pcall(function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        end)

        if not success then
            warn("Error loading InfiniteYield script: " .. err)
        else
            print("InfiniteYield script loaded successfully!")
        end
    end
})

-- Khởi chạy OrionLib
OrionLib:Init()
