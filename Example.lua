-- Đặt tên UI hub
_G.ScriptHubName = "🔥 Hiu Script Hub 🔥"

-- Tải và chạy UI từ GitHub
loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/main/HiuUi.lua"))()

-- Chờ UI tải xong
repeat task.wait() until _G.HiuHubReady

-- Thêm Toggle
addToggle("Auto Chest", function(state)
    print("Auto Chest:", state)
end)

-- Thêm TextBox
addTextBox("Nhập ID", function(text)
    print("ID:", text)
end)

-- Thêm Dropdown
addDropdown({"Option 1", "Option 2", "Option 3"}, function(selected)
    print("Bạn chọn:", selected)
end)

-- Thêm một đoạn mô tả
addParagraph("📝 Hướng dẫn sử dụng:\nBật các tính năng bằng toggle phía trên.\nChọn option nếu cần.")
