--// ServerHop Module (Fixed & Safe)

local ServerHop = {}
ServerHop.__index = ServerHop

--// Services
local HttpService = game:GetService("HttpService")
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

--// Config
ServerHop.PlaceID = game.PlaceId
ServerHop.AllIDs = {}
ServerHop.Cursor = ""
ServerHop.FileName = "NotSameServers.json"

--// Init
function ServerHop.new()
    local self = setmetatable({}, ServerHop)
    self:LoadFile()
    return self
end

--// Load visited servers
function ServerHop:LoadFile()
    local ok, data = pcall(function()
        return HttpService:JSONDecode(readfile(self.FileName))
    end)

    if ok and type(data) == "table" then
        self.AllIDs = data
    else
        self.AllIDs = { os.date("!*t").hour }
        pcall(function()
            writefile(self.FileName, HttpService:JSONEncode(self.AllIDs))
        end)
    end
end

--// Reset list every hour
function ServerHop:CheckHour()
    local hour = os.date("!*t").hour
    if tonumber(self.AllIDs[1]) ~= hour then
        self.AllIDs = { hour }
        pcall(function()
            delfile(self.FileName)
            writefile(self.FileName, HttpService:JSONEncode(self.AllIDs))
        end)
    end
end

--// Fetch server list
function ServerHop:GetServerList()
    local url = "https://games.roblox.com/v1/games/"
        .. self.PlaceID
        .. "/servers/Public?sortOrder=Asc&limit=100"

    if self.Cursor ~= "" then
        url = url .. "&cursor=" .. self.Cursor
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if not success or type(result) ~= "table" or not result.data then
        return nil
    end

    if result.nextPageCursor then
        self.Cursor = result.nextPageCursor
    end

    return result.data
end

--// Get next server JobId
function ServerHop:GetNextServerJobId()
    self:CheckHour()

    local servers = self:GetServerList()
    if not servers then return nil end

    for _, server in ipairs(servers) do
        if server.id and server.playing and server.maxPlayers then
            if server.playing < server.maxPlayers then
                local used = false
                for _, id in ipairs(self.AllIDs) do
                    if tostring(id) == tostring(server.id) then
                        used = true
                        break
                    end
                end

                if not used then
                    table.insert(self.AllIDs, server.id)
                    pcall(function()
                        writefile(self.FileName, HttpService:JSONEncode(self.AllIDs))
                    end)
                    return server.id
                end
            end
        end
    end

    return nil
end

--// Teleport loop
function ServerHop:Teleport()
    while task.wait(1) do
        local jobId = self:GetNextServerJobId()
        if jobId then
            pcall(function()
                TeleportService:TeleportToPlaceInstance(
                    self.PlaceID,
                    jobId,
                    Players.LocalPlayer
                )
            end)
            task.wait(5)
        else
            task.wait(3)
        end
    end
end

return ServerHop
