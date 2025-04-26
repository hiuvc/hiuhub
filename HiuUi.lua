-- ⚙️ CONFIG: Người dùng đổi tên script hub tại đây
_G.ScriptHubName = _G.ScriptHubName or "🔥 My Script Hub 🔥"

--// UI HUB SCRIPT

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

-- Tạo ScreenGui
local ui = Instance.new("ScreenGui")
ui.Name = _G.ScriptHubName
ui.Parent = game.CoreGui

-- Tạo Frame chính
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

-- Tiêu đề
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.Text = _G.ScriptHubName
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 22
title.Parent = main

-- Nút Ẩn/Hiện UI
local toggleBtn = Instance.new("TextButton")
toggleBtn.Size = UDim2.new(0, 100, 0, 25)
toggleBtn.Position = UDim2.new(0.5, -50, 1, -30)
toggleBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
toggleBtn.Text = "Ẩn UI"
toggleBtn.TextColor3 = Color3.new(1,1,1)
toggleBtn.Font = Enum.Font.SourceSans
toggleBtn.TextSize = 15
toggleBtn.Parent = main

local corner2 = Instance.new("UICorner")
corner2.CornerRadius = UDim.new(0, 8)
corner2.Parent = toggleBtn

-- Khung chứa các phần tử
local toggleFrame = Instance.new("Frame")
toggleFrame.Size = UDim2.new(1, -20, 1, -60)
toggleFrame.Position = UDim2.new(0, 10, 0, 40)
toggleFrame.BackgroundTransparency = 1
toggleFrame.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 5)
layout.Parent = toggleFrame

local uiVisible = true

local TweenService = game:GetService("TweenService")
local sizeShown = UDim2.new(0, 250, 0, 300)
local sizeHidden = UDim2.new(0, 250, 0, 60)

local function tweenSize(frame, newSize)
    local tween = TweenService:Create(frame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Size = newSize})
    tween:Play()
end

toggleBtn.MouseButton1Click:Connect(function()
    uiVisible = not uiVisible
    if uiVisible then
        toggleBtn.Text = "Ẩn UI"
        tweenSize(main, sizeShown)
        task.wait(0.25)
        for _, child in ipairs(toggleFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = true
            end
        end
    else
        toggleBtn.Text = "Hiện UI"
        for _, child in ipairs(toggleFrame:GetChildren()) do
            if child:IsA("GuiObject") then
                child.Visible = false
            end
        end
        tweenSize(main, sizeHidden)
    end
end)

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
        if callback then
            callback(state)
        end
    end)
end

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
    menu.Size = UDim2.new(1, 0, 0, #options * 30)
    menu.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    menu.Visible = false
    menu.Parent = dropdown

    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = menu

    for _, option in ipairs(options) do
        local optionButton = Instance.new("TextButton")
        optionButton.Size = UDim2.new(1, 0, 0, 30)
        optionButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        optionButton.TextColor3 = Color3.new(1, 1, 1)
        optionButton.Font = Enum.Font.SourceSans
        optionButton.TextSize = 18
        optionButton.Text = option
        optionButton.Parent = menu

        local corner = Instance.new("UICorner")
        corner.CornerRadius = UDim.new(0, 8)
        corner.Parent = optionButton

        optionButton.MouseButton1Click:Connect(function()
            dropdown.Text = "Chọn: " .. option
            menu.Visible = false
            if callback then
                callback(option)
            end
        end)
    end

    dropdown.MouseButton1Click:Connect(function()
        menu.Visible = not menu.Visible
    end)
end

function addParagraph(text)
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 0, 30)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextWrapped = true
    label.TextColor3 = Color3.fromRGB(200, 200, 200)
    label.Font = Enum.Font.SourceSansItalic
    label.TextSize = 16
    label.Parent = toggleFrame
end
