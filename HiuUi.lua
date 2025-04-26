--// Hiu Script Hub UI

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Tên script hub (cho phép tùy chỉnh ngoài file)
local hubName = _G.ScriptHubName or "📜 Hiu Script Hub"

-- Tạo UI
local ui = Instance.new("ScreenGui")
ui.Name = "HiuScriptHubUI"
ui.ResetOnSpawn = false
ui.Parent = game:GetService("CoreGui")

-- Main Frame
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 250, 0, 300)
main.Position = UDim2.new(0.05, 0, 0.1, 0)
main.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
main.Active = true
main.Draggable = true
main.Parent = ui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 8)
corner.Parent = main

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = hubName
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.Parent = main

-- Toggle UI button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 100, 0, 25)
toggleBtn.Position = UDim2.new(0.5, -50, 1, -30)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.Text = "Ẩn UI"
toggleBtn.TextColor3 = Color3.new(1, 1, 1)
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 15
toggleBtn.Parent = main

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 8)
corner2.Parent = toggleBtn

-- Toggle container
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, -20, 1, -60)
toggleFrame.Position = UDim2.new(0, 10, 0, 40)
toggleFrame.BackgroundTransparency = 1
toggleFrame.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = toggleFrame

-- Toggle UI animation
local uiVisible = true
toggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    toggleBtn.Text = uiVisible and "Ẩn UI" or "Hiện UI"
    if uiVisible then
        main:TweenSize(UDim2.new(0, 250, 0, 300), "Out", "Sine", 0.25, true)
        for _, child in ipairs(toggleFrame:GetChildren()) do
            if child:IsA("GuiObject") then child.Visible = true end
        end
    else
        for _, child in ipairs(toggleFrame:GetChildren()) do
            if child:IsA("GuiObject") then child.Visible = false end
        end
        main:TweenSize(UDim2.new(0, 250, 0, 60), "Out", "Sine", 0.25, true)
    end
end)

-- Hàm addToggle
function addToggle(text, callback)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, 0, 0, 30)
    toggle.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Font = Enum.Font.SourceSans
    toggle.TextSize = 20
    toggle.Text = text .. ": OFF"
    toggle.Parent = toggleFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = toggle

    local state = false
    toggle.MouseButton1Click:Connect(function()
        state = not state
        toggle.Text = text .. ": " .. (state and "ON" or "OFF")
        if callback then callback(state) end
    end)
end

-- Hàm addTextBox
function addTextBox(placeholderText, callback)
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1, 0, 0, 30)
    textBox.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    textBox.TextColor3 = Color3.new(1, 1, 1)
    textBox.Font = Enum.Font.SourceSans
    textBox.TextSize = 18
    textBox.Text = ""
    textBox.PlaceholderText = placeholderText
    textBox.Parent = toggleFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = textBox

    textBox.FocusLost:Connect(function(enterPressed)
        if enterPressed and callback then
            callback(textBox.Text)
        end
    end)
end

-- Hàm addDropdown
function addDropdown(options, callback)
    local dropdown = Instance.new("TextButton")
    dropdown.Size = UDim2.new(1, 0, 0, 30)
    dropdown.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    dropdown.TextColor3 = Color3.new(1, 1, 1)
    dropdown.Font = Enum.Font.SourceSans
    dropdown.TextSize = 18
    dropdown.Text = "Chọn một option"
    dropdown.Parent = toggleFrame

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = dropdown

    local menu = Instance.new("Frame")
    menu.Size = UDim2.new(1, 0, 0, 0)
    menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    menu.Visible = false
    menu.Parent = dropdown

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = menu

    for _, option in ipairs(options) do
        local optionBtn = Instance.new("TextButton")
        optionBtn.Size = UDim2.new(1, 0, 0, 30)
        optionBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        optionBtn.TextColor3 = Color3.new(1, 1, 1)
        optionBtn.Font = Enum.Font.SourceSans
        optionBtn.TextSize = 18
        optionBtn.Text = option
        optionBtn.Parent = menu

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = optionBtn

        optionBtn.MouseButton1Click:Connect(function()
            dropdown.Text = "Chọn: " .. option
            menu.Visible = false
            if callback then callback(option) end
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
    end)
end

-- Hàm addParagraph
function addParagraph(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.SourceSansItalic
    label.TextSize = 18
    label.TextWrapped = true
    label.Text = text
    label.Parent = toggleFrame
end

-- Export ra bên ngoài
getgenv().addToggle = addToggle
getgenv().addTextBox = addTextBox
getgenv().addDropdown = addDropdown
getgenv().addParagraph = addParagraph
