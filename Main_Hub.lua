local Id = game.PlaceId

-- Tạo bảng chứa các ID game hợp lệ
local validGameBFIds = {
    [2753915549] = true,
    [4442272183] = true,
    [7449423635] = true
}
local validGameLBIds = {
    [662417684] = true
}

-- Kiểm tra nếu ID game hợp lệ
if validGameBFIds[Id] then
    -- Tải script nếu game hợp lệ Blox Fruits
    repeat wait() until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")
    getgenv().team = "Marines"
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/Binini.lua"))()
elseif validGameLBIds[Id] then
    -- Tải script nếu game hợp lệ Lucky Block
    loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/LuckyBlockKid.lua"))()
else
    -- Nếu game không hợp lệ, kick người chơi
    game.Players.LocalPlayer:Kick("NOT SUPPORT!")
end
