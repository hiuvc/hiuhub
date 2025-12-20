local Library = {}

-- Services
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

-- Utility Functions
function Library:Tween(Instance, Info, Goal)
    return TweenService:Create(Instance, Info, Goal)
end

function Library:MakeDraggable(Object, Handle)
    local Dragging = false
    local DragStart = nil
    local StartPosition = nil

    Handle.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
            DragStart = Input.Position
            StartPosition = Object.Position
            
            Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
            local Delta = Input.Position - DragStart
            local NewPosition = UDim2.new(
                StartPosition.X.Scale,
                StartPosition.X.Offset + Delta.X,
                StartPosition.Y.Scale,
                StartPosition.Y.Offset + Delta.Y
            )
            
            Library:Tween(Object, TweenInfo.new(0.15), {Position = NewPosition}):Play()
        end
    end)
end

function Library:CreateCorner(Parent, Radius)
    local Corner = Instance.new("UICorner")
    Corner.CornerRadius = UDim.new(0, Radius)
    Corner.Parent = Parent
    return Corner
end

function Library:CreateStroke(Parent, Color, Transparency, Thickness)
    local Stroke = Instance.new("UIStroke")
    Stroke.Color = Color or Color3.fromRGB(200, 200, 200)
    Stroke.Transparency = Transparency or 0.5
    Stroke.Thickness = Thickness or 1
    Stroke.Parent = Parent
    return Stroke
end

function Library:Round(Number, Increment)
    return math.floor(Number / Increment + 0.5) * Increment
end

-- Main Window Creation
function Library:New(Config)
    Config = Config or {}
    
    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "ModernUI"
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.IgnoreGuiInset = true
    
    -- Background Frame
    local Background = Instance.new("Frame")
    Background.Name = "Background"
    Background.Parent = ScreenGui
    Background.Size = UDim2.new(1, 0, 1, 0)
    Background.BackgroundColor3 = Config.BackgroundColor or Color3.fromRGB(240, 240, 240)
    Background.BorderSizePixel = 0
    
    -- Toggle Button
    local ToggleButton = Instance.new("TextButton")
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ScreenGui
    ToggleButton.Size = UDim2.new(0, 50, 0, 50)
    ToggleButton.Position = UDim2.new(0, 20, 0, 20)
    ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = "☰"
    ToggleButton.TextColor3 = Color3.fromRGB(100, 100, 100)
    ToggleButton.TextSize = 24
    Library:CreateCorner(ToggleButton, 12)
    Library:CreateStroke(ToggleButton, Color3.fromRGB(200, 200, 200), 0.3, 1)
    
    -- Main Frame
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main.BorderSizePixel = 0
    Main.Visible = false
    Library:CreateCorner(Main, 15)
    Library:CreateStroke(Main, Color3.fromRGB(200, 200, 200), 0.3, 1)
    
    -- Top Bar
    local TopBar = Instance.new("Frame")
    TopBar.Name = "TopBar"
    TopBar.Parent = Main
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.Position = UDim2.new(0, 0, 0, 0)
    TopBar.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
    TopBar.BorderSizePixel = 0
    Library:CreateCorner(TopBar, 15)
    
    -- Title
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.Size = UDim2.new(1, -100, 1, 0)
    Title.Position = UDim2.new(0, 20, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.Text = Config.Title or "Modern Hub"
    Title.TextColor3 = Color3.fromRGB(80, 80, 80)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    -- Close Button
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Parent = TopBar
    CloseButton.Size = UDim2.new(0, 35, 0, 35)
    CloseButton.Position = UDim2.new(1, -45, 0, 7.5)
    CloseButton.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
    CloseButton.BorderSizePixel = 0
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.Text = "×"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 20
    Library:CreateCorner(CloseButton, 8)
    
    -- Minimize Button
    local MinimizeButton = Instance.new("TextButton")
    MinimizeButton.Name = "MinimizeButton"
    MinimizeButton.Parent = TopBar
    MinimizeButton.Size = UDim2.new(0, 35, 0, 35)
    MinimizeButton.Position = UDim2.new(1, -85, 0, 7.5)
    MinimizeButton.BackgroundColor3 = Color3.fromRGB(255, 200, 100)
    MinimizeButton.BorderSizePixel = 0
    MinimizeButton.Font = Enum.Font.GothamBold
    MinimizeButton.Text = "−"
    MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeButton.TextSize = 20
    Library:CreateCorner(MinimizeButton, 8)
    
    -- Tab Frame
    local TabFrame = Instance.new("Frame")
    TabFrame.Name = "TabFrame"
    TabFrame.Parent = Main
    TabFrame.Size = UDim2.new(0, 150, 1, -50)
    TabFrame.Position = UDim2.new(0, 0, 0, 50)
    TabFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
    TabFrame.BorderSizePixel = 0
    Library:CreateCorner(TabFrame, 15)
    
    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = Main
    ContentFrame.Size = UDim2.new(1, -150, 1, -50)
    ContentFrame.Position = UDim2.new(0, 150, 0, 50)
    ContentFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ContentFrame.BorderSizePixel = 0
    Library:CreateCorner(ContentFrame, 15)
    
    -- Tab List Layout
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabFrame
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)
    
    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabFrame
    TabPadding.PaddingTop = UDim.new(0, 10)
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)
    TabPadding.PaddingBottom = UDim.new(0, 10)
    
    -- Content List Layout
    local ContentListLayout = Instance.new("UIListLayout")
    ContentListLayout.Parent = ContentFrame
    ContentListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ContentListLayout.Padding = UDim.new(0, 10)
    
    local ContentPadding = Instance.new("UIPadding")
    ContentPadding.Parent = ContentFrame
    ContentPadding.PaddingTop = UDim.new(0, 10)
    ContentPadding.PaddingLeft = UDim.new(0, 10)
    ContentPadding.PaddingRight = UDim.new(0, 10)
    ContentPadding.PaddingBottom = UDim.new(0, 10)
    
    -- Make draggable
    Library:MakeDraggable(Main, TopBar)
    Library:MakeDraggable(ToggleButton, ToggleButton)
    
    -- Toggle functionality
    ToggleButton.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
        if Main.Visible then
            Library:Tween(Main, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 400)}):Play()
        end
    end)
    
    CloseButton.MouseButton1Click:Connect(function()
        Main.Visible = false
    end)
    
    MinimizeButton.MouseButton1Click:Connect(function()
        Main.Visible = false
    end)
    
    -- Tab system
    local Tabs = {}
    local CurrentTab = nil
    
    function Tabs:CreateTab(Name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = "TabButton"
        TabButton.Parent = TabFrame
        TabButton.Size = UDim2.new(1, -20, 0, 35)
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BorderSizePixel = 0
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = Name
        TabButton.TextColor3 = Color3.fromRGB(100, 100, 100)
        TabButton.TextSize = 14
        TabButton.LayoutOrder = #Tabs + 1
        Library:CreateCorner(TabButton, 8)
        
        local TabContent = Instance.new("ScrollingFrame")
        TabContent.Name = "TabContent"
        TabContent.Parent = ContentFrame
        TabContent.Size = UDim2.new(1, -20, 1, -20)
        TabContent.Position = UDim2.new(0, 10, 0, 10)
        TabContent.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabContent.BorderSizePixel = 0
        TabContent.Visible = false
        TabContent.ScrollBarThickness = 8
        TabContent.ScrollBarImageColor3 = Color3.fromRGB(200, 200, 200)
        
        local SectionLayout = Instance.new("UIListLayout")
        SectionLayout.Parent = TabContent
        SectionLayout.SortOrder = Enum.SortOrder.LayoutOrder
        SectionLayout.Padding = UDim.new(0, 10)
        
        TabContent:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, SectionLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab functionality
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, Tab in pairs(Tabs) do
                if Tab.Content then
                    Tab.Content.Visible = false
                end
                if Tab.Button then
                    Library:Tween(Tab.Button, TweenInfo.new(0.2), {
                        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                        TextColor3 = Color3.fromRGB(100, 100, 100)
                    }):Play()
                end
            end
            
            -- Show selected tab
            TabContent.Visible = true
            Library:Tween(TabButton, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(100, 150, 255),
                TextColor3 = Color3.fromRGB(255, 255, 255)
            }):Play()
            
            CurrentTab = TabContent
        end)
        
        -- Auto-select first tab
        if #Tabs == 0 then
            TabButton.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
            TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            TabContent.Visible = true
            CurrentTab = TabContent
        end
        
        local Tab = {
            Button = TabButton,
            Content = TabContent
        }
        
        function Tab:CreateSection(Title)
            local Section = Instance.new("Frame")
            Section.Name = "Section"
            Section.Parent = TabContent
            Section.Size = UDim2.new(1, 0, 0, 30)
            Section.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
            Section.BorderSizePixel = 0
            Section.LayoutOrder = #TabContent:GetChildren()
            Library:CreateCorner(Section, 8)
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = Section
            SectionTitle.Size = UDim2.new(1, -20, 1, 0)
            SectionTitle.Position = UDim2.new(0, 10, 0, 0)
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = Title
            SectionTitle.TextColor3 = Color3.fromRGB(80, 80, 80)
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContent = Instance.new("Frame")
            SectionContent.Name = "SectionContent"
            SectionContent.Parent = TabContent
            SectionContent.Size = UDim2.new(1, 0, 0, 0)
            SectionContent.BackgroundTransparency = 1
            SectionContent.LayoutOrder = #TabContent:GetChildren()
            
            local ItemLayout = Instance.new("UIListLayout")
            ItemLayout.Parent = SectionContent
            ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
            ItemLayout.Padding = UDim.new(0, 5)
            
            SectionContent:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Section.Size = UDim2.new(1, 0, 0, ItemLayout.AbsoluteContentSize.Y + 30)
            end)
            
            return {
                AddToggle = function(Config)
                    Config = Config or {}
                    
                    local ToggleFrame = Instance.new("Frame")
                    ToggleFrame.Name = "ToggleFrame"
                    ToggleFrame.Parent = SectionContent
                    ToggleFrame.Size = UDim2.new(1, 0, 0, 35)
                    ToggleFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ToggleFrame.BorderSizePixel = 0
                    Library:CreateCorner(ToggleFrame, 8)
                    Library:CreateStroke(ToggleFrame, Color3.fromRGB(200, 200, 200), 0.5, 1)
                    
                    local ToggleLabel = Instance.new("TextLabel")
                    ToggleLabel.Name = "ToggleLabel"
                    ToggleLabel.Parent = ToggleFrame
                    ToggleLabel.Size = UDim2.new(1, -60, 1, 0)
                    ToggleLabel.Position = UDim2.new(0, 10, 0, 0)
                    ToggleLabel.BackgroundTransparency = 1
                    ToggleLabel.Font = Enum.Font.Gotham
                    ToggleLabel.Text = Config.Title or "Toggle"
                    ToggleLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
                    ToggleLabel.TextSize = 14
                    ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local ToggleButton = Instance.new("TextButton")
                    ToggleButton.Name = "ToggleButton"
                    ToggleButton.Parent = ToggleFrame
                    ToggleButton.Size = UDim2.new(0, 45, 0, 25)
                    ToggleButton.Position = UDim2.new(1, -55, 0, 5)
                    ToggleButton.BackgroundColor3 = Config.Default and Color3.fromRGB(100, 200, 100) or Color3.fromRGB(200, 200, 200)
                    ToggleButton.BorderSizePixel = 0
                    ToggleButton.Font = Enum.Font.GothamBold
                    ToggleButton.Text = Config.Default and "ON" or "OFF"
                    ToggleButton.TextColor3 = Config.Default and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(100, 100, 100)
                    ToggleButton.TextSize = 12
                    Library:CreateCorner(ToggleButton, 12)
                    
                    local IsToggled = Config.Default or false
                    
                    ToggleButton.MouseButton1Click:Connect(function()
                        IsToggled = not IsToggled
                        
                        if IsToggled then
                            Library:Tween(ToggleButton, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3.fromRGB(100, 200, 100),
                                TextColor3 = Color3.fromRGB(255, 255, 255),
                                Text = "ON"
                            }):Play()
                        else
                            Library:Tween(ToggleButton, TweenInfo.new(0.2), {
                                BackgroundColor3 = Color3.fromRGB(200, 200, 200),
                                TextColor3 = Color3.fromRGB(100, 100, 100),
                                Text = "OFF"
                            }):Play()
                        end
                        
                        if Config.Callback then
                            Config.Callback(IsToggled)
                        end
                    end)
                    
                    return {
                        SetState = function(State)
                            IsToggled = State
                            if IsToggled then
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
                                ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                                ToggleButton.Text = "ON"
                            else
                                ToggleButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                                ToggleButton.TextColor3 = Color3.fromRGB(100, 100, 100)
                                ToggleButton.Text = "OFF"
                            end
                        end
                    }
                end,
                
                AddButton = function(Config)
                    Config = Config or {}
                    
                    local Button = Instance.new("TextButton")
                    Button.Name = "Button"
                    Button.Parent = SectionContent
                    Button.Size = UDim2.new(1, 0, 0, 35)
                    Button.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                    Button.BorderSizePixel = 0
                    Button.Font = Enum.Font.GothamBold
                    Button.Text = Config.Title or "Button"
                    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
                    Button.TextSize = 14
                    Library:CreateCorner(Button, 8)
                    
                    Button.MouseButton1Click:Connect(function()
                        Library:Tween(Button, TweenInfo.new(0.1), {
                            BackgroundColor3 = Color3.fromRGB(80, 130, 235)
                        }):Play()
                        
                        wait(0.1)
                        
                        Library:Tween(Button, TweenInfo.new(0.1), {
                            BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                        }):Play()
                        
                        if Config.Callback then
                            Config.Callback()
                        end
                    end)
                    
                    return Button
                end,
                
                AddSlider = function(Config)
                    Config = Config or {}
                    
                    local SliderFrame = Instance.new("Frame")
                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = SectionContent
                    SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderFrame.BorderSizePixel = 0
                    Library:CreateCorner(SliderFrame, 8)
                    Library:CreateStroke(SliderFrame, Color3.fromRGB(200, 200, 200), 0.5, 1)
                    
                    local SliderLabel = Instance.new("TextLabel")
                    SliderLabel.Name = "SliderLabel"
                    SliderLabel.Parent = SliderFrame
                    SliderLabel.Size = UDim2.new(1, -100, 0, 20)
                    SliderLabel.Position = UDim2.new(0, 10, 0, 5)
                    SliderLabel.BackgroundTransparency = 1
                    SliderLabel.Font = Enum.Font.Gotham
                    SliderLabel.Text = Config.Title or "Slider"
                    SliderLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
                    SliderLabel.TextSize = 14
                    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local SliderValue = Instance.new("TextLabel")
                    SliderValue.Name = "SliderValue"
                    SliderValue.Parent = SliderFrame
                    SliderValue.Size = UDim2.new(0, 80, 0, 20)
                    SliderValue.Position = UDim2.new(1, -90, 0, 5)
                    SliderValue.BackgroundTransparency = 1
                    SliderValue.Font = Enum.Font.GothamBold
                    SliderValue.Text = tostring(Config.Default or Config.Min or 0)
                    SliderValue.TextColor3 = Color3.fromRGB(100, 150, 255)
                    SliderValue.TextSize = 14
                    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
                    
                    local SliderBar = Instance.new("Frame")
                    SliderBar.Name = "SliderBar"
                    SliderBar.Parent = SliderFrame
                    SliderBar.Size = UDim2.new(1, -20, 0, 6)
                    SliderBar.Position = UDim2.new(0, 10, 0, 30)
                    SliderBar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
                    SliderBar.BorderSizePixel = 0
                    Library:CreateCorner(SliderBar, 3)
                    
                    local SliderFill = Instance.new("Frame")
                    SliderFill.Name = "SliderFill"
                    SliderFill.Parent = SliderBar
                    SliderFill.Size = UDim2.new(0, 0, 1, 0)
                    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 150, 255)
                    SliderFill.BorderSizePixel = 0
                    Library:CreateCorner(SliderFill, 3)
                    
                    local SliderButton = Instance.new("TextButton")
                    SliderButton.Name = "SliderButton"
                    SliderButton.Parent = SliderBar
                    SliderButton.Size = UDim2.new(0, 16, 0, 16)
                    SliderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    SliderButton.BorderSizePixel = 0
                    SliderButton.Text = ""
                    Library:CreateCorner(SliderButton, 8)
                    Library:CreateStroke(SliderButton, Color3.fromRGB(100, 150, 255), 0, 2)
                    
                    local Min = Config.Min or 0
                    local Max = Config.Max or 100
                    local Increment = Config.Increment or 1
                    local Value = Config.Default or Min
                    
                    local function UpdateSlider(NewValue)
                        NewValue = math.clamp(Library:Round(NewValue, Increment), Min, Max)
                        Value = NewValue
                        
                        local Percentage = (Value - Min) / (Max - Min)
                        SliderFill.Size = UDim2.new(Percentage, 0, 1, 0)
                        SliderButton.Position = UDim2.new(Percentage, -8, 0, -5)
                        SliderValue.Text = tostring(Value)
                        
                        if Config.Callback then
                            Config.Callback(Value)
                        end
                    end
                    
                    local Dragging = false
                    
                    SliderButton.MouseButton1Down:Connect(function()
                        Dragging = true
                    end)
                    
                    UserInputService.InputEnded:Connect(function(Input)
                        if Input.UserInputType == Enum.UserInputType.MouseButton1 then
                            Dragging = false
                        end
                    end)
                    
                    UserInputService.InputChanged:Connect(function(Input)
                        if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then
                            local MousePos = Input.Position
                            local BarPos = SliderBar.AbsolutePosition
                            local BarSize = SliderBar.AbsoluteSize
                            
                            local Percentage = math.clamp((MousePos.X - BarPos.X) / BarSize.X, 0, 1)
                            local NewValue = Min + (Max - Min) * Percentage
                            
                            UpdateSlider(NewValue)
                        end
                    end)
                    
                    UpdateSlider(Value)
                    
                    return {
                        SetValue = UpdateSlider
                    }
                end,
                
                AddDropdown = function(Config)
                    Config = Config or {}
                    
                    local DropdownFrame = Instance.new("Frame")
                    DropdownFrame.Name = "DropdownFrame"
                    DropdownFrame.Parent = SectionContent
                    DropdownFrame.Size = UDim2.new(1, 0, 0, 35)
                    DropdownFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownFrame.BorderSizePixel = 0
                    Library:CreateCorner(DropdownFrame, 8)
                    Library:CreateStroke(DropdownFrame, Color3.fromRGB(200, 200, 200), 0.5, 1)
                    
                    local DropdownLabel = Instance.new("TextLabel")
                    DropdownLabel.Name = "DropdownLabel"
                    DropdownLabel.Parent = DropdownFrame
                    DropdownLabel.Size = UDim2.new(1, -100, 1, 0)
                    DropdownLabel.Position = UDim2.new(0, 10, 0, 0)
                    DropdownLabel.BackgroundTransparency = 1
                    DropdownLabel.Font = Enum.Font.Gotham
                    DropdownLabel.Text = Config.Title or "Dropdown"
                    DropdownLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
                    DropdownLabel.TextSize = 14
                    DropdownLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local DropdownButton = Instance.new("TextButton")
                    DropdownButton.Name = "DropdownButton"
                    DropdownButton.Parent = DropdownFrame
                    DropdownButton.Size = UDim2.new(0, 80, 0, 25)
                    DropdownButton.Position = UDim2.new(1, -90, 0, 5)
                    DropdownButton.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
                    DropdownButton.BorderSizePixel = 0
                    DropdownButton.Font = Enum.Font.Gotham
                    DropdownButton.Text = Config.Default or "Select"
                    DropdownButton.TextColor3 = Color3.fromRGB(80, 80, 80)
                    DropdownButton.TextSize = 12
                    Library:CreateCorner(DropdownButton, 6)
                    
                    local DropdownList = Instance.new("Frame")
                    DropdownList.Name = "DropdownList"
                    DropdownList.Parent = DropdownFrame
                    DropdownList.Size = UDim2.new(0, 150, 0, 0)
                    DropdownList.Position = UDim2.new(1, -160, 1, 5)
                    DropdownList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    DropdownList.BorderSizePixel = 0
                    DropdownList.Visible = false
                    DropdownList.ZIndex = 10
                    Library:CreateCorner(DropdownList, 8)
                    Library:CreateStroke(DropdownList, Color3.fromRGB(200, 200, 200), 0.3, 1)
                    
                    local OptionLayout = Instance.new("UIListLayout")
                    OptionLayout.Parent = DropdownList
                    OptionLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    
                    local IsOpen = false
                    local SelectedValue = Config.Default
                    
                    local function ToggleDropdown()
                        IsOpen = not IsOpen
                        DropdownList.Visible = IsOpen
                        
                        if IsOpen then
                            local OptionsHeight = #Config.Options * 25
                            Library:Tween(DropdownList, TweenInfo.new(0.2), {
                                Size = UDim2.new(0, 150, 0, math.min(OptionsHeight, 200))
                            }):Play()
                        else
                            Library:Tween(DropdownList, TweenInfo.new(0.2), {
                                Size = UDim2.new(0, 150, 0, 0)
                            }):Play()
                        end
                    end
                    
                    DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
                    
                    -- Create options
                    for i, Option in ipairs(Config.Options or {}) do
                        local OptionButton = Instance.new("TextButton")
                        OptionButton.Name = "OptionButton"
                        OptionButton.Parent = DropdownList
                        OptionButton.Size = UDim2.new(1, -10, 0, 25)
                        OptionButton.Position = UDim2.new(0, 5, 0, 0)
                        OptionButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                        OptionButton.BorderSizePixel = 0
                        OptionButton.Font = Enum.Font.Gotham
                        OptionButton.Text = Option
                        OptionButton.TextColor3 = Color3.fromRGB(80, 80, 80)
                        OptionButton.TextSize = 12
                        OptionButton.LayoutOrder = i
                        OptionButton.TextXAlignment = Enum.TextXAlignment.Left
                        
                        OptionButton.MouseButton1Click:Connect(function()
                            SelectedValue = Option
                            DropdownButton.Text = Option
                            ToggleDropdown()
                            
                            if Config.Callback then
                                Config.Callback(Option)
                            end
                        end)
                        
                        OptionButton.MouseEnter:Connect(function()
                            Library:Tween(OptionButton, TweenInfo.new(0.1), {
                                BackgroundColor3 = Color3.fromRGB(245, 245, 245)
                            }):Play()
                        end)
                        
                        OptionButton.MouseLeave:Connect(function()
                            Library:Tween(OptionButton, TweenInfo.new(0.1), {
                                BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                            }):Play()
                        end)
                    end
                    
                    return {
                        SetValue = function(Value)
                            SelectedValue = Value
                            DropdownButton.Text = Value
                        end
                    }
                end,
                
                AddTextBox = function(Config)
                    Config = Config or {}
                    
                    local TextBoxFrame = Instance.new("Frame")
                    TextBoxFrame.Name = "TextBoxFrame"
                    TextBoxFrame.Parent = SectionContent
                    TextBoxFrame.Size = UDim2.new(1, 0, 0, 35)
                    TextBoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextBoxFrame.BorderSizePixel = 0
                    Library:CreateCorner(TextBoxFrame, 8)
                    Library:CreateStroke(TextBoxFrame, Color3.fromRGB(200, 200, 200), 0.5, 1)
                    
                    local TextBoxLabel = Instance.new("TextLabel")
                    TextBoxLabel.Name = "TextBoxLabel"
                    TextBoxLabel.Parent = TextBoxFrame
                    TextBoxLabel.Size = UDim2.new(1, -100, 1, 0)
                    TextBoxLabel.Position = UDim2.new(0, 10, 0, 0)
                    TextBoxLabel.BackgroundTransparency = 1
                    TextBoxLabel.Font = Enum.Font.Gotham
                    TextBoxLabel.Text = Config.Title or "TextBox"
                    TextBoxLabel.TextColor3 = Color3.fromRGB(80, 80, 80)
                    TextBoxLabel.TextSize = 14
                    TextBoxLabel.TextXAlignment = Enum.TextXAlignment.Left
                    
                    local TextBox = Instance.new("TextBox")
                    TextBox.Name = "TextBox"
                    TextBox.Parent = TextBoxFrame
                    TextBox.Size = UDim2.new(0, 80, 0, 25)
                    TextBox.Position = UDim2.new(1, -90, 0, 5)
                    TextBox.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
                    TextBox.BorderSizePixel = 0
                    TextBox.Font = Enum.Font.Gotham
                    TextBox.PlaceholderText = Config.Placeholder or "Type here..."
                    TextBox.Text = Config.Default or ""
                    TextBox.TextColor3 = Color3.fromRGB(80, 80, 80)
                    TextBox.TextSize = 12
                    Library:CreateCorner(TextBox, 6)
                    
                    TextBox.FocusLost:Connect(function()
                        if Config.Callback then
                            Config.Callback(TextBox.Text)
                        end
                    end)
                    
                    return {
                        SetValue = function(Text)
                            TextBox.Text = Text
                        end,
                        GetValue = function()
                            return TextBox.Text
                        end
                    }
                end,
                
                AddLabel = function(Config)
                    Config = Config or {}
                    
                    local LabelFrame = Instance.new("Frame")
                    LabelFrame.Name = "LabelFrame"
                    LabelFrame.Parent = SectionContent
                    LabelFrame.Size = UDim2.new(1, 0, 0, 30)
                    LabelFrame.BackgroundColor3 = Color3.fromRGB(245, 245, 245)
                    LabelFrame.BorderSizePixel = 0
                    Library:CreateCorner(LabelFrame, 8)
                    
                    local Label = Instance.new("TextLabel")
                    Label.Name = "Label"
                    Label.Parent = LabelFrame
                    Label.Size = UDim2.new(1, -20, 1, 0)
                    Label.Position = UDim2.new(0, 10, 0, 0)
                    Label.BackgroundTransparency = 1
                    Label.Font = Enum.Font.Gotham
                    Label.Text = Config.Text or "Label"
                    Label.TextColor3 = Color3.fromRGB(80, 80, 80)
                    Label.TextSize = 14
                    Label.TextXAlignment = Enum.TextXAlignment.Left
                    Label.TextWrapped = true
                    
                    return {
                        SetText = function(Text)
                            Label.Text = Text
                        end
                    }
                end
            }
        end
        
        table.insert(Tabs, Tab)
        return Tab
    end
    
    -- Background customization
    function Tabs:SetBackground(Color)
        Background.BackgroundColor3 = Color or Color3.fromRGB(240, 240, 240)
    end
    
    return Tabs
end

return Library
