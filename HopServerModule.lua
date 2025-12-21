--// SERVICES
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local LocalPlayer = Players.LocalPlayer
local FILE_NAME = "server-hop-temp.json"

--// VARIABLES
local VisitedServers = {}
local Cursor = nil
local CurrentHour = os.date("!*t").hour

--// LOAD FILE
pcall(function()
    VisitedServers = HttpService:JSONDecode(readfile(FILE_NAME))
    if VisitedServers.hour ~= CurrentHour then
        VisitedServers = { hour = CurrentHour, servers = {} }
        delfile(FILE_NAME)
    end
end)

--// INIT FILE IF EMPTY
if not VisitedServers.hour then
    VisitedServers = { hour = CurrentHour, servers = {} }
end

--// SAVE FILE
local function Save()
    writefile(FILE_NAME, HttpService:JSONEncode(VisitedServers))
end

--// CHECK VISITED
local function IsVisited(id)
    return table.find(VisitedServers.servers, id)
end

--// GET SERVERS
local function GetServers(placeId)
    local url = "https://games.roblox.com/v1/games/" .. placeId .. "/servers/Public?limit=100&sortOrder=Asc"
    if Cursor then
        url ..= "&cursor=" .. Cursor
    end

    local success, result = pcall(function()
        return HttpService:JSONDecode(game:HttpGet(url))
    end)

    if success and result then
        Cursor = result.nextPageCursor
        return result.data
    end
end

--// TELEPORT LOGIC
local function Hop(placeId)
    local servers = GetServers(placeId)
    if not servers then return end

    for _, server in ipairs(servers) do
        if server.playing < server.maxPlayers then
            local id = tostring(server.id)

            if not IsVisited(id) then
                table.insert(VisitedServers.servers, id)
                Save()

                TeleportService:TeleportToPlaceInstance(placeId, id, LocalPlayer)
                task.wait(5)
                return
            end
        end
    end
end

--// MODULE
local ServerHop = {}

function ServerHop:Teleport(placeId)
    while task.wait(1) do
        pcall(function()
            Hop(placeId)
        end)
    end
end

return ServerHop
