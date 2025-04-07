local playerId = game.Players.LocalPlayer.UserId
local allowedUserIds = {
    988512137, -- Thay thế bằng ID người chơi hợp lệ
    987654321, -- Thêm các ID người chơi khác nếu cần
}

-- Kiểm tra nếu người chơi có ID hợp lệ
if table.find(allowedUserIds, playerId) then
    local Id = game.PlaceId

    -- Tạo bảng chứa các ID game hợp lệ
    local validGameIds = {
        [2753915549] = true,
        [4442272183] = true,
        [7449423635] = true
    }

    -- Kiểm tra nếu ID game hợp lệ
    if validGameIds[Id] then
        -- Tải script nếu game hợp lệ
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/Royal.lua"))()
    else
        -- Nếu game không hợp lệ, kick người chơi
        game.Players.LocalPlayer:kick("NOT SUPPORT!")
    end
else
    -- Nếu người chơi không có ID hợp lệ, kick người chơi
    game.Players.LocalPlayer:kick("You are not authorized to run this script.")
end
