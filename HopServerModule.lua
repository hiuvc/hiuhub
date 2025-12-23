local ServerHop = {}
ServerHop.__index = ServerHop

local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

-- Cấu hình
ServerHop.PlaceID = game.PlaceId
ServerHop.AllIDs = {}
ServerHop.FoundAnything = ""
ServerHop.Deleted = false

-- Load file server đã từng join
local success, err = pcall(function()
    ServerHop.AllIDs = HttpService:JSONDecode(readfile("NotSameServers.json"))
end)
if not success then
    table.insert(ServerHop.AllIDs, os.date("!*t").hour)
    writefile("NotSameServers.json", HttpService:JSONEncode(ServerHop.AllIDs))
end

-- Hàm lấy server tiếp theo
function ServerHop:GetNextServerJobId()
    local Site
    if self.FoundAnything == "" then
        Site = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. self.PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. self.PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. self.FoundAnything))
    end

    if Site.nextPageCursor and Site.nextPageCursor ~= "null" then
        self.FoundAnything = Site.nextPageCursor
    end

    local actualHour = os.date("!*t").hour
    local num = 0

    for _, v in pairs(Site.data) do
        local possible = true
        local ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _, existing in pairs(self.AllIDs) do
                if num ~= 0 then
                    if ID == tostring(existing) then
                        possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(existing) then
                        local ok, _ = pcall(function()
                            delfile("NotSameServers.json")
                            self.AllIDs = {}
                            table.insert(self.AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end

            if possible then
                table.insert(self.AllIDs, ID)
                pcall(function()
                    writefile("NotSameServers.json", HttpService:JSONEncode(self.AllIDs))
                end)
                return ID
            end
        end
    end

    return nil
end

function ServerHop:Teleport()
    while wait() do
        local jobId = self:GetNextServerJobId()
        if jobId then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(self.PlaceID, jobId, Players.LocalPlayer)
            end)
            wait(4)
        else
            wait(5) 
        end
    end
end

return ServerHop
