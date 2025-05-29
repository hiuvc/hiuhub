-- Orion UI Clone - Modular API style
-- Supports: Tab:AddLabel, Tab:AddButton, Tab:AddToggle, Tab:AddSlider, Tab:AddDropdown, Tab:AddTextbox

local OrionLib = {}
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "OrionUI"
ScreenGui.Parent = game:GetService("CoreGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
MainFrame.ClipsDescendants = true

local TabsHolder = Instance.new("Frame")
TabsHolder.Size = UDim2.new(0, 140, 1, 0)
TabsHolder.Position = UDim2.new(0, 0, 0, 0)
TabsHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabsHolder.BorderSizePixel = 0
TabsHolder.Parent = MainFrame

local TabsList = Instance.new("UIListLayout")
TabsList.SortOrder = Enum.SortOrder.LayoutOrder
TabsList.Padding = UDim.new(0, 5)
TabsList.Parent = TabsHolder

local Pages = Instance.new("Frame")
Pages.Size = UDim2.new(1, -140, 1, 0)
Pages.Position = UDim2.new(0, 140, 0, 0)
Pages.BackgroundTransparency = 1
Pages.Parent = MainFrame

local function createPage()
    local Page = Instance.new("ScrollingFrame")
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.ScrollBarThickness = 4
    Page.Visible = false
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.AutomaticCanvasSize = Enum.AutomaticSize.Y
    Page.Parent = Pages

    local List = Instance.new("UIListLayout")
    List.SortOrder = Enum.SortOrder.LayoutOrder
    List.Padding = UDim.new(0, 6)
    List.Parent = Page

    return Page
end

function OrionLib:MakeWindow(config)
    local Window = {}

    function Window:MakeTab(tabConfig)
        local Tab = {}

        local Button = Instance.new("TextButton")
        Button.Text = tabConfig.Name
        Button.Size = UDim2.new(1, -10, 0, 30)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.BorderSizePixel = 0
        Button.Parent = TabsHolder

        local Page = createPage()

        Button.MouseButton1Click:Connect(function()
            for _, p in pairs(Pages:GetChildren()) do
                if p:IsA("ScrollingFrame") then p.Visible = false end
            end
            Page.Visible = true
        end)

        function Tab:AddLabel(text)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 25)
            Label.Text = text
            Label.BackgroundTransparency = 1
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.Font = Enum.Font.SourceSans
            Label.TextSize = 16
            Label.Parent = Page
        end

        function Tab:AddButton(opt)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 30)
            Btn.Text = opt.Name
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.BorderSizePixel = 0
            Btn.Parent = Page
            Btn.MouseButton1Click:Connect(opt.Callback)
        end

        function Tab:AddToggle(opt)
            local Toggle = Instance.new("TextButton")
            Toggle.Size = UDim2.new(1, -10, 0, 30)
            Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            Toggle.Text = opt.Name .. ": Off"
            Toggle.Parent = Page

            local toggled = false
            Toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                Toggle.Text = opt.Name .. (toggled and ": On" or ": Off")
                opt.Callback(toggled)
            end)
        end

        function Tab:AddSlider(opt)
            local Label = Instance.new("TextLabel")
            Label.Size = UDim2.new(1, -10, 0, 20)
            Label.Text = opt.Name .. ": " .. opt.Default
            Label.BackgroundTransparency = 1
            Label.TextColor3 = Color3.fromRGB(200, 200, 200)
            Label.TextSize = 16
            Label.Parent = Page

            local Slider = Instance.new("TextButton")
            Slider.Size = UDim2.new(1, -10, 0, 20)
            Slider.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
            Slider.Text = ""
            Slider.Parent = Page

            Slider.MouseButton1Click:Connect(function()
                local value = math.random(opt.Min, opt.Max) -- dummy for simplicity
                Label.Text = opt.Name .. ": " .. value
                opt.Callback(value)
            end)
        end

        function Tab:AddDropdown(opt)
            local Btn = Instance.new("TextButton")
            Btn.Size = UDim2.new(1, -10, 0, 30)
            Btn.Text = opt.Name
            Btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
            Btn.Parent = Page

            Btn.MouseButton1Click:Connect(function()
                if #opt.Options > 0 then
                    local pick = opt.Options[math.random(1, #opt.Options)]
                    Btn.Text = opt.Name .. ": " .. pick
                    opt.Callback(pick)
                end
            end)
        end

        function Tab:AddTextbox(opt)
            local Box = Instance.new("TextBox")
            Box.Size = UDim2.new(1, -10, 0, 30)
            Box.PlaceholderText = opt.Name
            Box.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
            Box.TextColor3 = Color3.fromRGB(255, 255, 255)
            Box.ClearTextOnFocus = false
            Box.Text = ""
            Box.Parent = Page

            Box.FocusLost:Connect(function()
                opt.Callback(Box.Text)
            end)
        end

        Page.Visible = true
        return Tab
    end

    return Window
end

return OrionLib
