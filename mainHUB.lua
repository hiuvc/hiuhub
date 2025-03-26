local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/jensonhirst/Orion/main/source')))()

if not OrionLib then
    warn("Không thể tải OrionLib!")
    return
end

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

-- Kiểm tra kết nối Internet
local function isInternetAvailable()
    local success, response = pcall(function()
        return game:HttpGet("http://www.google.com", false)
    end)
    return success and response ~= nil
end

-- Hàm tải script an toàn
local function safeLoadScript(url, name)
    print("Trying to load: " .. name) -- Debug Log
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
        local scriptContent = game:HttpGet(url, true)
        assert(scriptContent, "Script không có dữ liệu!")
        loadstring(scriptContent)()
    end)

    if not success then
        OrionLib:MakeNotification({
            Name = "Lỗi!",
            Content = "Không thể tải " .. name .. ": " .. tostring(err),
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

-- Kiểm tra OrionLib có hoạt động không
if not Tab then
    warn("Không thể tạo Tab!")
    return
end

-- Nút kích hoạt Keyboard
Tab:AddButton({
    Name = "Keyboard",
    Callback = function()
        print("Keyboard button clicked!") -- Debug
        safeLoadScript("https://raw.githubusercontent.com/advxzivhsjjdhxhsidifvsh/mobkeyboard/main/main.txt", "Keyboard")
    end
})

-- Nút kích hoạt Infinite Yield
Tab:AddButton({
    Name = "Infinite Yield",
    Callback = function()
        print("Infinite Yield button clicked!") -- Debug
        safeLoadScript("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", "Infinite Yield")
    end
})

Tab:AddButton({
    Name = "Chim bay",
    Callback = function()
        print("Bay cao nào! :))") -- Debug
        safeLoadScript("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/hiufly.lua")
    end
})

-- Kiểm tra OrionLib có hiển thị không
OrionLib:MakeNotification({
    Name = "Khởi động!",
    Content = "Made by Hiunocry",
    Time = 5
})

OrionLib:Init()
print("Tải thư viện thành công") -- Debug
