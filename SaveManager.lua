local SaveManager = {}

SaveManager.Folder = "MyToolConfig"
SaveManager.FileName = game.Players.LocalPlayer.Name .. ".json"
SaveManager.Ignore = {}
SaveManager.Options = {}
SaveManager.Library = nil

local HttpService = game:GetService("HttpService")
local SavePath = SaveManager.Folder .. "/" .. SaveManager.FileName

-- Tạo thư mục nếu chưa có
function SaveManager:EnsureFolder()
    if not isfolder(self.Folder) then
        makefolder(self.Folder)
    end
end

-- Đăng ký option để lưu
function SaveManager:SetLibrary(lib)
    self.Library = lib
end

function SaveManager:SetIgnore(list)
    self.Ignore = list or {}
end

function SaveManager:Save()
    self:EnsureFolder()
    local data = {}

    for idx, option in pairs(self.Options) do
        if not table.find(self.Ignore, idx) then
            data[idx] = option.Value
        end
    end

    writefile(SavePath, HttpService:JSONEncode(data))
end

function SaveManager:Load()
    self:EnsureFolder()
    if isfile(SavePath) then
        local success, result = pcall(function()
            return HttpService:JSONDecode(readfile(SavePath))
        end)

        if success then
            for idx, val in pairs(result) do
                if self.Options[idx] then
                    self.Options[idx]:SetValue(val)
                end
            end
        end
    end
end

function SaveManager:BindToOption(option)
    self.Options[option.Flag] = option
end

function SaveManager:Init(lib)
    self:SetLibrary(lib)

    -- Tự động theo dõi tất cả options
    for _, tab in pairs(lib.Tabs) do
        for _, section in pairs(tab.Sections) do
            for _, option in pairs(section.Options) do
                if option.Flag then
                    self:BindToOption(option)
                    -- Ghi file mỗi khi thay đổi
                    option:SetCallback(function()
                        self:Save()
                    end)
                end
            end
        end
    end

    -- Tự động load lại
    task.defer(function()
        self:Load()
    end)
end

return SaveManager
