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

-- Hàm kiểm tra kết nối mạng
local function isInternetAvailable()
    local success = pcall(function()
        game:HttpGet("http://www.google.com", false)
    end)
    return success
end

-- Hàm tải script an toàn
local function safeLoadScript(url, name)
    OrionLib:MakeNotification({
        Name = "Đang tải " .. name,
        Content = "Vui lòng chờ...",
        Time = 3
    })

    if not isInternetAvailable() then
        OrionLib:MakeNotification({
            Name = "Lỗi!",
            Content = "Không có kết nối mạng!",
            Time = 5
        })
        return
    end

    local success, err = pcall(function()
        loadstring(game:HttpGet(url, true))()
    end)

    if not success then
        OrionLib:MakeNotification({
            Name = "Lỗi!",
            Content = "Không thể tải " .. name .. ": " .. err,
            Time = 5
        })
    else
        OrionLib:MakeNotification({
            Name = "Thành công!",
            Content = name .. " đã tải thành công!",
            Time = 5
        })
    end
end

-- Nút kích hoạt Keyboard
Tab:AddButton({
    Name = "Keyboard",
    Callback = function()
        safeLoadScript("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", "Keyboard")
    end
})

-- Nút kích hoạt Infinite Yield
Tab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        safeLoadScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "Infinite Yield")
    end
})

-- Khởi chạy OrionLib
OrionLib:Init()
