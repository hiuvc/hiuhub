--// QUEUE ON TELEPORT
if queue_on_teleport then
    queue_on_teleport([[
        loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/FullMoonFinder.lua"))()
    ]])
end
local HopServerModule = (loadstring(game:HttpGet("https://raw.githubusercontent.com/hiuvc/hiuhub/refs/heads/main/HopServerModule.lua")))()
--// SERVICES
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local LocalPlayer = Players.LocalPlayer

--// WEBHOOK
local LinkHook = "https://discord.com/api/webhooks/1464531093863665766/GVkjs4gAiRuoarqOPQGFQe1zZL1vkjSmnl0pdV19eBASJr1IGbUyRYv70VuBN4lskYBj"

--// MOON DATA (ORDER MATTERS)
local MoonOrder = {
    [1] = {icon="🌔", id="9709149680", name="Waxing Crescent"},
    [2] = {icon="🌓", id="9709150086", name="First Quarter"},
    [3] = {icon="🌒", id="9709139597", name="Waxing Gibbous"},
    [4] = {icon="🌑", id="9709135895", name="New Moon"},
    [5] = {icon="🌘", id="9709150401", name="Waning Crescent"},
    [6] = {icon="🌗", id="9709143733", name="Last Quarter"},
    [7] = {icon="🌖", id="9709149052", name="Waxing Gibbous"},
    [8] = {icon="🌕", id="9709149431", name="FULL MOON"},
}

--// GET CURRENT MOON INDEX
local function GetMoonIndex()
    local Sky = Lighting:FindFirstChildOfClass("Sky")
    if not Sky then return nil end

    for i,v in pairs(MoonOrder) do
        if Sky.MoonTextureId:find(v.id) then
            return i, v
        end
    end
    return nil
end

--// PREDICT FULL MOON TIME
local function PredictMinutes(index)
    -- 1 phase ≈ 7.5 phút
    local phasesLeft = 8 - index
    local minutes = math.floor(phasesLeft * 7.5)
    return minutes
end

--// SEND WEBHOOK
local function SendWebhook(moonData, minutes)
    local players = #Players:GetPlayers()

    local JoinCode =
        'game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId,"'..
        game.JobId..'")'

    local statusText
    if minutes <= 0 then
        statusText = "🌕 FULL MOON NOW"
    else
        statusText = "⏳ Full Moon in ~"..minutes.." minutes"
    end

    local Embed = {
        ["username"] = "🌕 Full Moon Predictor",
        ["embeds"] = {{
            ["title"] = statusText,
            ["color"] = minutes <= 0 and 16776960 or 16753920,
            ["fields"] = {
                {
                    ["name"] = "🌙 Current Phase",
                    ["value"] = "```"..moonData.icon.." "..moonData.name.."```",
                    ["inline"] = true
                },
                {
                    ["name"] = "👥 Players",
                    ["value"] = "```"..players.."/12```",
                    ["inline"] = true
                },
                {
                    ["name"] = "🚪 Script ",
                    ["value"] = "```"..JoinCode.."```",
                    ["inline"] = false
                },
                {
                    ["name"] = "🆔 Job ID",
                    ["value"] = "```"..game.JobId.."```",
                    ["inline"] = false
                }
            },
            ["footer"] = {
                ["text"] = "Auto Moon Prediction | Blox Fruits"
            },
            ["timestamp"] = DateTime.now():ToIsoDate()
        }}
    }

    local Request = http_request or request or syn.request
    Request({
        Url = LinkHook,
        Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(Embed)
    })
end

--// SERVER HOP
local Visited = {}
local PlaceID = game.PlaceId

local function Hop()
    HopServerModule:Teleport()
end

--// MAIN
local index, moonData = GetMoonIndex()
if not index then
        Hop()
    return
end

local minutesLeft = PredictMinutes(index)

if minutesLeft <= 20 then
    SendWebhook(moonData, minutesLeft)
    wait(1)
    Hop()
else
    Hop()
end
