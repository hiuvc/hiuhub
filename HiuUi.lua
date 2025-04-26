-- HiuUi.lua

-- Tạo UI cơ bản
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "HiuHub"
ScreenGui.Parent = game.CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Size = UDim2.new(0, 300, 0, 400)
MainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Name = "ScrollingFrame"
ScrollingFrame.Parent = MainFrame
ScrollingFrame.Size = UDim2.new(1, 0, 1, -50)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
ScrollingFrame.CanvasSize = UDim2.new(0, 0, 5, 0)
ScrollingFrame.ScrollBarThickness = 5
ScrollingFrame.BackgroundTransparency = 1

local HideButton = Instance.new("TextButton")
HideButton.Parent = MainFrame
HideButton.Size = UDim2.new(0.6, 0, 0, 30)
HideButton.Position = UDim2.new(0.2, 0, 1, -40)
HideButton.Text = "Ẩn UI"
HideButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
HideButton.TextColor3 = Color3.fromRGB(255, 255, 255)

local isVisible = true
HideButton.MouseButton1Click:Connect(function()
    isVisible = not isVisible
    ScrollingFrame.Visible = isVisible
    HideButton.Text = isVisible and "Ẩn UI" or "Hiện UI"
end)

-- Các hàm thêm thành phần vào UI
local Main = ScrollingFrame

function addToggle(text, callback)
    local Toggle = Instance.new("TextButton")
    Toggle.Size = UDim2.new(1, -20, 0, 40)
    Toggle.Position = UDim2.new(0, 10, 0, #Main:GetChildren() * 45)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    Toggle.Text = text
    Toggle.Font = Enum.Font.SourceSans
    Toggle.TextSize = 20
    Toggle.Parent = Main

    local toggled = false
    Toggle.MouseButton1Click:Connect(function()
        toggled = not toggled
        Toggle.BackgroundColor3 = toggled and Color3.fromRGB(80, 120, 80) or Color3.fromRGB(40, 40, 40)
        callback(toggled)
    end)
end

function addTextBox(placeholder, callback)
    local Box = Instance.new("TextBox")
    Box.Size = UDim2.new(1, -20, 0, 40)
    Box.Position = UDim2.new(0, 10, 0, #Main:GetChildren() * 45)
    Box.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Box.PlaceholderText = placeholder
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Font = Enum.Font.SourceSans
    Box.TextSize = 20
    Box.Parent = Main

    Box.FocusLost:Connect(function()
        callback(Box.Text)
    end)
end

function addDropdown(list, callback)
    local Dropdown = Instance.new("TextButton")
    Dropdown.Size = UDim2.new(1, -20, 0, 40)
    Dropdown.Position = UDim2.new(0, 10, 0, #Main:GetChildren() * 45)
    Dropdown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Dropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    Dropdown.Text = "Chọn tùy chọn"
    Dropdown.Font = Enum.Font.SourceSans
    Dropdown.TextSize = 20
    Dropdown.Parent = Main

    -- Tạo một frame để chứa các tùy chọn Dropdown
    local OptionsFrame = Instance.new("Frame")
    OptionsFrame.Size = UDim2.new(1, 0, 0, 0)
    OptionsFrame.Position = UDim2.new(0, 10, 0, 40)
    OptionsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OptionsFrame.Visible = false
    OptionsFrame.Parent = Dropdown

    -- Thêm các tùy chọn vào Dropdown
    for _, option in ipairs(list) do
        local OptionButton = Instance.new("TextButton")
        OptionButton.Size = UDim2.new(1, 0, 0, 40)
        OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        OptionButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        OptionButton.Text = option
        OptionButton.Font = Enum.Font.SourceSans
        OptionButton.TextSize = 18
        OptionButton.Parent = OptionsFrame

        -- Hiệu ứng hover cho từng tùy chọn
        OptionButton.MouseEnter:Connect(function()
            OptionButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        end)
        OptionButton.MouseLeave:Connect(function()
            OptionButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        end)

        -- Khi người dùng chọn một tùy chọn
        OptionButton.MouseButton1Click:Connect(function()
            Dropdown.Text = option
            OptionsFrame.Visible = false
            callback(option)
        end)
    end

    -- Hiển thị/ẩn các tùy chọn khi nhấn vào Dropdown
    Dropdown.MouseButton1Click:Connect(function()
        OptionsFrame.Visible = not OptionsFrame.Visible
    end)
end

function addParagraph(text)
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 100)
    Label.Position = UDim2.new(0, 10, 0, #Main:GetChildren() * 45)
    Label.BackgroundTransparency = 1
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.TextWrapped = true
    Label.Text = text
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 18
    Label.Parent = Main
end

-- Khi tải xong UI, báo hiệu Ready
_G.HiuHubReady = true
