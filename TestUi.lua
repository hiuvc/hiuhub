local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

--// Theme Settings (Modern Dark)
local Theme = {
    Main = Color3.fromRGB(25, 25, 25),
    Secondary = Color3.fromRGB(35, 35, 35),
    Stroke = Color3.fromRGB(50, 50, 50),
    Accent = Color3.fromRGB(0, 140, 255),
    Text = Color3.fromRGB(240, 240, 240),
    TextDark = Color3.fromRGB(150, 150, 150),
    Font = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold,
}

--// Utility Functions
function Library:Tween(instance, properties, time, style, direction)
    local info = TweenInfo.new(time or 0.3, style or Enum.EasingStyle.Quart, direction or Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, info, properties)
    tween:Play()
    return tween
end

function Library:MakeDraggable(topbarobject, object)
    local Dragging, DragInput, DragStart, StartPosition

    local function Update(input)
        local Delta = input.Position - DragStart
        local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
        Library:Tween(object, {Position = pos}, 0.1, Enum.EasingStyle.Sine)
    end

    topbarobject.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = input.Position
            StartPosition = object.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                end
            end)
        end
    end)

    topbarobject.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            DragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == DragInput and Dragging then
            Update(input)
        end
    end)
end

function Library:MakeConfig(Config, NewConfig)
    for i, v in next, Config do
        if NewConfig[i] == nil then
            NewConfig[i] = v
        end
    end
    return NewConfig
end

--// Main Window Function
function Library:NewWindow(ConfigWindow)
    ConfigWindow = self:MakeConfig({
        Title = "Tobii Hub | Remake",
        Description = "Modern UI by Gemini",
    }, ConfigWindow or {})

    local TeddyUI = Instance.new("ScreenGui")
    TeddyUI.Name = "TeddyUI_Remake"
    TeddyUI.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    TeddyUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = TeddyUI
    MainFrame.BackgroundColor3 = Theme.Main
    MainFrame.Position = UDim2.new(0.5, -300, 0.5, -175)
    MainFrame.Size = UDim2.new(0, 600, 0, 350)
    MainFrame.BorderSizePixel = 0
    MainFrame.ClipsDescendants = true

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = MainFrame

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Color = Theme.Stroke
    MainStroke.Thickness = 1
    MainStroke.Parent = MainFrame

    --// Sidebar (Left)
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = MainFrame
    Sidebar.BackgroundColor3 = Theme.Secondary
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.BorderSizePixel = 0

    local SidebarCorner = Instance.new("UICorner")
    SidebarCorner.CornerRadius = UDim.new(0, 10)
    SidebarCorner.Parent = Sidebar
    
    local SidebarFix = Instance.new("Frame")
    SidebarFix.Parent = Sidebar
    SidebarFix.BackgroundColor3 = Theme.Secondary
    SidebarFix.BorderSizePixel = 0
    SidebarFix.Size = UDim2.new(0, 10, 1, 0)
    SidebarFix.Position = UDim2.new(1, -10, 0, 0)
    SidebarFix.ZIndex = 0

    local AppIcon = Instance.new("ImageLabel")
    AppIcon.Parent = Sidebar
    AppIcon.Size = UDim2.new(0, 30, 0, 30)
    AppIcon.Position = UDim2.new(0, 15, 0, 15)
    AppIcon.BackgroundTransparency = 1
    AppIcon.Image = "rbxassetid://133979080007875"

    local AppTitle = Instance.new("TextLabel")
    AppTitle.Parent = Sidebar
    AppTitle.Text = ConfigWindow.Title
    AppTitle.Size = UDim2.new(1, -60, 0, 30)
    AppTitle.Position = UDim2.new(0, 55, 0, 15)
    AppTitle.BackgroundTransparency = 1
    AppTitle.TextColor3 = Theme.Text
    AppTitle.Font = Theme.FontBold
    AppTitle.TextSize = 14
    AppTitle.TextXAlignment = Enum.TextXAlignment.Left

    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Parent = Sidebar
    TabContainer.Position = UDim2.new(0, 0, 0, 60)
    TabContainer.Size = UDim2.new(1, 0, 1, -60)
    TabContainer.BackgroundTransparency = 1
    TabContainer.ScrollBarThickness = 2
    TabContainer.BorderSizePixel = 0

    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabContainer
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingTop = UDim.new(0, 10)

    --// Content Area (Right)
    local ContentArea = Instance.new("Frame")
    ContentArea.Parent = MainFrame
    ContentArea.BackgroundColor3 = Theme.Main
    ContentArea.Position = UDim2.new(0, 160, 0, 0)
    ContentArea.Size = UDim2.new(1, -160, 1, 0)
    ContentArea.BorderSizePixel = 0

    local TopBar = Instance.new("Frame")
    TopBar.Parent = ContentArea
    TopBar.Size = UDim2.new(1, 0, 0, 50)
    TopBar.BackgroundTransparency = 1
    
    local CurrentTabTitle = Instance.new("TextLabel")
    CurrentTabTitle.Parent = TopBar
    CurrentTabTitle.Text = "Welcome"
    CurrentTabTitle.Size = UDim2.new(1, -20, 1, 0)
    CurrentTabTitle.Position = UDim2.new(0, 20, 0, 0)
    CurrentTabTitle.BackgroundTransparency = 1
    CurrentTabTitle.TextColor3 = Theme.Text
    CurrentTabTitle.Font = Theme.FontBold
    CurrentTabTitle.TextSize = 18
    CurrentTabTitle.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Parent = TopBar
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -40, 0, 10)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    CloseBtn.Text = "X"
    CloseBtn.TextColor3 = Color3.new(1,1,1)
    CloseBtn.Font = Theme.FontBold
    CloseBtn.TextSize = 14
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 6)
    CloseCorner.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        local ConfirmFrame = Instance.new("Frame")
        ConfirmFrame.Parent = MainFrame
        ConfirmFrame.Size = UDim2.new(1, 0, 1, 0)
        ConfirmFrame.BackgroundColor3 = Color3.new(0,0,0)
        ConfirmFrame.BackgroundTransparency = 0.5
        ConfirmFrame.ZIndex = 10
        
        local Popup = Instance.new("Frame")
        Popup.Parent = ConfirmFrame
        Popup.Size = UDim2.new(0, 300, 0, 120)
        Popup.Position = UDim2.new(0.5, -150, 0.5, -60)
        Popup.BackgroundColor3 = Theme.Secondary
        
        Instance.new("UICorner", Popup).CornerRadius = UDim.new(0, 8)
        
        local Title = Instance.new("TextLabel", Popup)
        Title.Size = UDim2.new(1,0,0,40)
        Title.Text = "Close Interface?"
        Title.TextColor3 = Theme.Text
        Title.BackgroundTransparency = 1
        Title.Font = Theme.FontBold
        Title.TextSize = 16
        
        local Yes = Instance.new("TextButton", Popup)
        Yes.Size = UDim2.new(0, 100, 0, 30)
        Yes.Position = UDim2.new(0, 20, 1, -40)
        Yes.Text = "Yes"
        Yes.BackgroundColor3 = Theme.Accent
        Yes.TextColor3 = Color3.new(1,1,1)
        Instance.new("UICorner", Yes).CornerRadius = UDim.new(0, 6)
        
        local No = Instance.new("TextButton", Popup)
        No.Size = UDim2.new(0, 100, 0, 30)
        No.Position = UDim2.new(1, -120, 1, -40)
        No.Text = "No"
        No.BackgroundColor3 = Theme.Main
        No.TextColor3 = Theme.Text
        Instance.new("UICorner", No).CornerRadius = UDim.new(0, 6)
        
        Yes.MouseButton1Click:Connect(function() TeddyUI:Destroy() end)
        No.MouseButton1Click:Connect(function() ConfirmFrame:Destroy() end)
    end)

    local Pages = Instance.new("Frame")
    Pages.Parent = ContentArea
    Pages.Position = UDim2.new(0, 20, 0, 50)
    Pages.Size = UDim2.new(1, -40, 1, -60)
    Pages.BackgroundTransparency = 1
    
    local PageFolder = Instance.new("Folder")
    PageFolder.Name = "PageFolder"
    PageFolder.Parent = Pages

    local UIPageLayout = Instance.new("UIPageLayout")
    UIPageLayout.Parent = PageFolder
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quart
    UIPageLayout.EasingDirection = Enum.EasingDirection.Out
    UIPageLayout.TweenTime = 0.4
    UIPageLayout.ScrollWheelInputEnabled = false

    Library:MakeDraggable(Sidebar, MainFrame)
    Library:MakeDraggable(TopBar, MainFrame)

    --// Floating Toggle Button
    local FloatingToggle = Instance.new("ImageButton")
    FloatingToggle.Parent = TeddyUI
    FloatingToggle.Name = "FloatingToggle"
    FloatingToggle.Size = UDim2.new(0, 50, 0, 50)
    FloatingToggle.Position = UDim2.new(0, 30, 0.5, -25)
    FloatingToggle.BackgroundColor3 = Theme.Secondary
    FloatingToggle.Image = "rbxassetid://133979080007875"
    FloatingToggle.BorderSizePixel = 0
    Instance.new("UICorner", FloatingToggle).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", FloatingToggle).Color = Theme.Accent
    
    Library:MakeDraggable(FloatingToggle, FloatingToggle)
    
    FloatingToggle.MouseButton1Click:Connect(function()
        MainFrame.Visible = not MainFrame.Visible
    end)

    --// Tabs Functionality
    local Tabs = {}
    local FirstTab = true

    function Tabs:T(TabName)
        local TabBtn = Instance.new("TextButton")
        TabBtn.Parent = TabContainer
        TabBtn.Size = UDim2.new(0, 140, 0, 35)
        TabBtn.BackgroundColor3 = Theme.Main
        TabBtn.BackgroundTransparency = 1
        TabBtn.Text = ""
        TabBtn.AutoButtonColor = false

        local TabLabel = Instance.new("TextLabel")
        TabLabel.Parent = TabBtn
        TabLabel.Text = TabName
        TabLabel.Size = UDim2.new(1, -30, 1, 0)
        TabLabel.Position = UDim2.new(0, 10, 0, 0)
        TabLabel.BackgroundTransparency = 1
        TabLabel.TextColor3 = Theme.TextDark
        TabLabel.Font = Theme.Font
        TabLabel.TextSize = 13
        TabLabel.TextXAlignment = Enum.TextXAlignment.Left

        local TabIndicator = Instance.new("Frame")
        TabIndicator.Parent = TabBtn
        TabIndicator.Size = UDim2.new(0, 4, 0, 16)
        TabIndicator.Position = UDim2.new(0, 0, 0.5, -8)
        TabIndicator.BackgroundColor3 = Theme.Accent
        TabIndicator.BackgroundTransparency = 1
        Instance.new("UICorner", TabIndicator).CornerRadius = UDim.new(0, 2)

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn

        local PageScroll = Instance.new("ScrollingFrame")
        PageScroll.Parent = PageFolder
        PageScroll.Size = UDim2.new(1, 0, 1, 0)
        PageScroll.BackgroundTransparency = 1
        PageScroll.ScrollBarThickness = 3
        PageScroll.ScrollBarImageColor3 = Theme.Accent
        PageScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
        PageScroll.Visible = false

        local PageList = Instance.new("UIListLayout")
        PageList.Parent = PageScroll
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 8)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = PageScroll
        PagePadding.PaddingTop = UDim.new(0, 5)
        PagePadding.PaddingBottom = UDim.new(0, 5)

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            PageScroll.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 20)
        end)

        local function Activate()
            CurrentTabTitle.Text = TabName
            
            -- Hide all pages first
            for _, page in pairs(PageFolder:GetChildren()) do
                if page:IsA("ScrollingFrame") then
                    page.Visible = false
                end
            end
            
            -- Show current page
            PageScroll.Visible = true
            UIPageLayout:JumpTo(PageScroll)
            
            -- Reset all tabs
            for _, btn in pairs(TabContainer:GetChildren()) do
                if btn:IsA("TextButton") then
                    Library:Tween(btn.TextLabel, {TextColor3 = Theme.TextDark}, 0.2)
                    Library:Tween(btn, {BackgroundTransparency = 1}, 0.2)
                    if btn:FindFirstChild("Frame") then
                        Library:Tween(btn.Frame, {BackgroundTransparency = 1}, 0.2)
                    end
                end
            end
            
            -- Active this tab
            Library:Tween(TabLabel, {TextColor3 = Theme.Text}, 0.3)
            Library:Tween(TabBtn, {BackgroundTransparency = 0.8}, 0.3)
            Library:Tween(TabBtn, {BackgroundColor3 = Theme.Accent}, 0.3)
            Library:Tween(TabIndicator, {BackgroundTransparency = 0}, 0.3)
        end

        TabBtn.MouseButton1Click:Connect(Activate)

        if FirstTab then
            Activate()
            FirstTab = false
        end

        --// Sections
        local Sections = {}
        function Sections:AddSection(SectionName)
            local SectionLabel = Instance.new("TextLabel")
            SectionLabel.Parent = PageScroll
            SectionLabel.Text = SectionName
            SectionLabel.Size = UDim2.new(1, 0, 0, 25)
            SectionLabel.BackgroundTransparency = 1
            SectionLabel.TextColor3 = Theme.Accent
            SectionLabel.Font = Theme.FontBold
            SectionLabel.TextSize = 12
            SectionLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Container = Instance.new("Frame")
            Container.Parent = PageScroll
            Container.BackgroundColor3 = Theme.Secondary
            Container.Size = UDim2.new(1, 0, 0, 0)
            Container.BorderSizePixel = 0
            
            local ContainerCorner = Instance.new("UICorner")
            ContainerCorner.CornerRadius = UDim.new(0, 6)
            ContainerCorner.Parent = Container

            local ContainerList = Instance.new("UIListLayout")
            ContainerList.Parent = Container
            ContainerList.SortOrder = Enum.SortOrder.LayoutOrder
            ContainerList.Padding = UDim.new(0, 5)

            local ContainerPadding = Instance.new("UIPadding")
            ContainerPadding.Parent = Container
            ContainerPadding.PaddingTop = UDim.new(0, 8)
            ContainerPadding.PaddingBottom = UDim.new(0, 8)
            ContainerPadding.PaddingLeft = UDim.new(0, 8)
            ContainerPadding.PaddingRight = UDim.new(0, 8)

            ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Container.Size = UDim2.new(1, 0, 0, ContainerList.AbsoluteContentSize.Y + 16)
            end)

            local Elements = {}

            function Elements:AddParagraph(Config)
                Config = Library:MakeConfig({Title = "Title", Content = "Content"}, Config or {})
                
                local ParaFrame = Instance.new("Frame")
                ParaFrame.Parent = Container
                ParaFrame.BackgroundColor3 = Theme.Main
                ParaFrame.Size = UDim2.new(1, 0, 0, 0)
                Instance.new("UICorner", ParaFrame).CornerRadius = UDim.new(0, 4)
                
                local PTitle = Instance.new("TextLabel")
                PTitle.Parent = ParaFrame
                PTitle.Text = Config.Title
                PTitle.Size = UDim2.new(1, -10, 0, 20)
                PTitle.Position = UDim2.new(0, 5, 0, 2)
                PTitle.BackgroundTransparency = 1
                PTitle.TextColor3 = Theme.Text
                PTitle.Font = Theme.FontBold
                PTitle.TextSize = 13
                PTitle.TextXAlignment = Enum.TextXAlignment.Left

                local PContent = Instance.new("TextLabel")
                PContent.Parent = ParaFrame
                PContent.Text = Config.Content
                PContent.Size = UDim2.new(1, -10, 0, 0)
                PContent.Position = UDim2.new(0, 5, 0, 22)
                PContent.BackgroundTransparency = 1
                PContent.TextColor3 = Theme.TextDark
                PContent.Font = Theme.Font
                PContent.TextSize = 12
                PContent.TextXAlignment = Enum.TextXAlignment.Left
                PContent.TextWrapped = true
                
                PContent.AutomaticSize = Enum.AutomaticSize.Y
                PContent:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                    ParaFrame.Size = UDim2.new(1, 0, 0, PContent.AbsoluteSize.Y + 30)
                end)
                
                local Funcs = {}
                function Funcs:SetTitle(t) PTitle.Text = t end
                function Funcs:SetDesc(d) PContent.Text = d end
                return Funcs
            end

            function Elements:AddButton(Config)
                Config = Library:MakeConfig({Title = "Button", Description = "", Callback = function() end}, Config or {})

                local BtnFrame = Instance.new("TextButton")
                BtnFrame.Parent = Container
                BtnFrame.BackgroundColor3 = Theme.Main
                BtnFrame.Size = UDim2.new(1, 0, 0, 35)
                BtnFrame.AutoButtonColor = false
                BtnFrame.Text = ""
                Instance.new("UICorner", BtnFrame).CornerRadius = UDim.new(0, 4)

                local BtnTitle = Instance.new("TextLabel")
                BtnTitle.Parent = BtnFrame
                BtnTitle.Text = Config.Title
                BtnTitle.Size = UDim2.new(1, -30, 1, 0)
                BtnTitle.Position = UDim2.new(0, 10, 0, 0)
                BtnTitle.BackgroundTransparency = 1
                BtnTitle.TextColor3 = Theme.Text
                BtnTitle.Font = Theme.FontBold
                BtnTitle.TextSize = 13
                BtnTitle.TextXAlignment = Enum.TextXAlignment.Left

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = BtnFrame
                Icon.Size = UDim2.new(0, 16, 0, 16)
                Icon.Position = UDim2.new(1, -26, 0.5, -8)
                Icon.BackgroundTransparency = 1
                Icon.Image = "rbxassetid://6031094678"
                Icon.ImageColor3 = Theme.TextDark

                BtnFrame.MouseEnter:Connect(function()
                    Library:Tween(BtnFrame, {BackgroundColor3 = Color3.fromRGB(45,45,45)}, 0.2)
                end)
                BtnFrame.MouseLeave:Connect(function()
                    Library:Tween(BtnFrame, {BackgroundColor3 = Theme.Main}, 0.2)
                end)
                BtnFrame.MouseButton1Click:Connect(function()
                    Library:Tween(BtnFrame, {Size = UDim2.new(1, -4, 0, 31)}, 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out).Completed:Wait()
                    Library:Tween(BtnFrame, {Size = UDim2.new(1, 0, 0, 35)}, 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                    Config.Callback()
                end)
            end

            function Elements:AddToggle(Config)
                Config = Library:MakeConfig({Title = "Toggle", Description = "", Default = false, Callback = function() end}, Config or {})

                local TogFrame = Instance.new("Frame")
                TogFrame.Parent = Container
                TogFrame.BackgroundColor3 = Theme.Main
                TogFrame.Size = UDim2.new(1, 0, 0, 35)
                Instance.new("UICorner", TogFrame).CornerRadius = UDim.new(0, 4)

                local TogTitle = Instance.new("TextLabel")
                TogTitle.Parent = TogFrame
                TogTitle.Text = Config.Title
                TogTitle.Size = UDim2.new(1, -50, 1, 0)
                TogTitle.Position = UDim2.new(0, 10, 0, 0)
                TogTitle.BackgroundTransparency = 1
                TogTitle.TextColor3 = Theme.Text
                TogTitle.Font = Theme.FontBold
                TogTitle.TextSize = 13
                TogTitle.TextXAlignment = Enum.TextXAlignment.Left

                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Parent = TogFrame
                ToggleBtn.Size = UDim2.new(0, 36, 0, 20)
                ToggleBtn.Position = UDim2.new(1, -46, 0.5, -10)
                ToggleBtn.BackgroundColor3 = Config.Default and Theme.Accent or Color3.fromRGB(60,60,60)
                ToggleBtn.Text = ""
                Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)

                local Circle = Instance.new("Frame")
                Circle.Parent = ToggleBtn
                Circle.Size = UDim2.new(0, 16, 0, 16)
                Circle.Position = Config.Default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

                local State = Config.Default
                
                local function Update()
                    Config.Callback(State)
                    if State then
                        Library:Tween(ToggleBtn, {BackgroundColor3 = Theme.Accent}, 0.2)
                        Library:Tween(Circle, {Position = UDim2.new(1, -18, 0.5, -8)}, 0.2)
                    else
                        Library:Tween(ToggleBtn, {BackgroundColor3 = Color3.fromRGB(60,60,60)}, 0.2)
                        Library:Tween(Circle, {Position = UDim2.new(0, 2, 0.5, -8)}, 0.2)
                    end
                end

                ToggleBtn.MouseButton1Click:Connect(function()
                    State = not State
                    Update()
                end)
                
                local Funcs = {}
                function Funcs:Set(bool)
                    State = bool
                    Update()
                end
                return Funcs
            end

            function Elements:AddSlider(Config)
                Config = Library:MakeConfig({Title = "Slider", Description = "", Max = 100, Min = 0, Increment = 1, Default = 50, Callback = function() end}, Config or {})
                
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Parent = Container
                SliderFrame.BackgroundColor3 = Theme.Main
                SliderFrame.Size = UDim2.new(1, 0, 0, 50)
                Instance.new("UICorner", SliderFrame).CornerRadius = UDim.new(0, 4)

                local SliderTitle = Instance.new("TextLabel")
                SliderTitle.Parent = SliderFrame
                SliderTitle.Text = Config.Title
                SliderTitle.Size = UDim2.new(1, 0, 0, 25)
                SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                SliderTitle.BackgroundTransparency = 1
                SliderTitle.TextColor3 = Theme.Text
                SliderTitle.Font = Theme.FontBold
                SliderTitle.TextSize = 13
                SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

                local ValueLabel = Instance.new("TextLabel")
                ValueLabel.Parent = SliderFrame
                ValueLabel.Text = tostring(Config.Default)
                ValueLabel.Size = UDim2.new(0, 50, 0, 25)
                ValueLabel.Position = UDim2.new(1, -60, 0, 0)
                ValueLabel.BackgroundTransparency = 1
                ValueLabel.TextColor3 = Theme.TextDark
                ValueLabel.Font = Theme.Font
                ValueLabel.TextSize = 12
                ValueLabel.TextXAlignment = Enum.TextXAlignment.Right

                local Track = Instance.new("TextButton")
                Track.Parent = SliderFrame
                Track.Size = UDim2.new(1, -20, 0, 4)
                Track.Position = UDim2.new(0, 10, 0, 35)
                Track.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                Track.Text = ""
                Track.AutoButtonColor = false
                Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)

                local Fill = Instance.new("Frame")
                Fill.Parent = Track
                Fill.Size = UDim2.new(0, 0, 1, 0)
                Fill.BackgroundColor3 = Theme.Accent
                Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
                
                local Knob = Instance.new("Frame")
                Knob.Parent = Fill
                Knob.Size = UDim2.new(0, 12, 0, 12)
                Knob.Position = UDim2.new(1, -6, 0.5, -6)
                Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Instance.new("UICorner", Knob).CornerRadius = UDim.new(1, 0)

                local Dragging = false
                local Value = Config.Default

                local function UpdateValue(input)
                    local pos = UDim2.new(math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1), 0, 1, 0)
                    local scaled = math.floor(((pos.X.Scale * (Config.Max - Config.Min)) + Config.Min) / Config.Increment + 0.5) * Config.Increment
                    if scaled > Config.Max then scaled = Config.Max end
                    if scaled < Config.Min then scaled = Config.Min end
                    
                    Value = scaled
                    ValueLabel.Text = tostring(Value)
                    
                    local p = (Value - Config.Min) / (Config.Max - Config.Min)
                    Library:Tween(Fill, {Size = UDim2.new(p, 0, 1, 0)}, 0.05)
                    Config.Callback(Value)
                end

                Track.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = true
                        UpdateValue(input)
                    end
                end)

                UserInputService.InputChanged:Connect(function(input)
                    if Dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                        UpdateValue(input)
                    end
                end)

                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                        Dragging = false
                    end
                end)

                local p = (Config.Default - Config.Min) / (Config.Max - Config.Min)
                Fill.Size = UDim2.new(p, 0, 1, 0)
                
                local Funcs = {}
                function Funcs:Set(v)
                     Value = v
                     ValueLabel.Text = tostring(Value)
                     local p = (Value - Config.Min) / (Config.Max - Config.Min)
                     Library:Tween(Fill, {Size = UDim2.new(p, 0, 1, 0)}, 0.2)
                     Config.Callback(Value)
                end
                return Funcs
            end

            function Elements:AddInput(Config)
                Config = Library:MakeConfig({Title = "Input", Description = "", PlaceHolder = "Type here...", Default = "", Callback = function() end}, Config or {})

                local InputFrame = Instance.new("Frame")
                InputFrame.Parent = Container
                InputFrame.BackgroundColor3 = Theme.Main
                InputFrame.Size = UDim2.new(1, 0, 0, 50)
                Instance.new("UICorner", InputFrame).CornerRadius = UDim.new(0, 4)

                local InputTitle = Instance.new("TextLabel")
                InputTitle.Parent = InputFrame
                InputTitle.Text = Config.Title
                InputTitle.Size = UDim2.new(1, -130, 1, 0)
                InputTitle.Position = UDim2.new(0, 10, 0, 0)
                InputTitle.BackgroundTransparency = 1
                InputTitle.TextColor3 = Theme.Text
                InputTitle.Font = Theme.FontBold
                InputTitle.TextSize = 13
                InputTitle.TextXAlignment = Enum.TextXAlignment.Left

                local BoxContainer = Instance.new("Frame")
                BoxContainer.Parent = InputFrame
                BoxContainer.Size = UDim2.new(0, 120, 0, 30)
                BoxContainer.Position = UDim2.new(1, -130, 0.5, -15)
                BoxContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                Instance.new("UICorner", BoxContainer).CornerRadius = UDim.new(0, 4)
                
                local TextBox = Instance.new("TextBox")
                TextBox.Parent = BoxContainer
                TextBox.Size = UDim2.new(1, -10, 1, 0)
                TextBox.Position = UDim2.new(0, 5, 0, 0)
                TextBox.BackgroundTransparency = 1
                TextBox.Text = Config.Default
                TextBox.PlaceholderText = Config.PlaceHolder
                TextBox.TextColor3 = Theme.Text
                TextBox.PlaceholderColor3 = Color3.fromRGB(100, 100, 100)
                TextBox.Font = Theme.Font
                TextBox.TextSize = 12

                TextBox.FocusLost:Connect(function()
                    Config.Callback(TextBox.Text)
                end)
            end

            function Elements:AddDropdown(Config)
                Config = Library:MakeConfig({Title = "Dropdown", Description = "", Values = {}, Default = "", Multi = false, Callback = function() end}, Config or {})
                
                local DropFrame = Instance.new("Frame")
                DropFrame.Parent = Container
                DropFrame.BackgroundColor3 = Theme.Main
                DropFrame.Size = UDim2.new(1, 0, 0, 40)
                DropFrame.ClipsDescendants = true
                Instance.new("UICorner", DropFrame).CornerRadius = UDim.new(0, 4)

                local DropTitle = Instance.new("TextLabel")
                DropTitle.Parent = DropFrame
                DropTitle.Text = Config.Title
                DropTitle.Size = UDim2.new(1, -30, 0, 40)
                DropTitle.Position = UDim2.new(0, 10, 0, 0)
                DropTitle.BackgroundTransparency = 1
                DropTitle.TextColor3 = Theme.Text
                DropTitle.Font = Theme.FontBold
                DropTitle.TextSize = 13
                DropTitle.TextXAlignment = Enum.TextXAlignment.Left

                local OpenBtn = Instance.new("ImageButton")
                OpenBtn.Parent = DropFrame
                OpenBtn.Size = UDim2.new(0, 20, 0, 20)
                OpenBtn.Position = UDim2.new(1, -30, 0, 10)
                OpenBtn.BackgroundTransparency = 1
                OpenBtn.Image = "rbxassetid://6031090990"
                OpenBtn.ImageColor3 = Theme.TextDark

                local ItemContainer = Instance.new("ScrollingFrame")
                ItemContainer.Parent = DropFrame
                ItemContainer.Position = UDim2.new(0, 0, 0, 45)
                ItemContainer.Size = UDim2.new(1, 0, 0, 100)
                ItemContainer.BackgroundTransparency = 1
                ItemContainer.BorderSizePixel = 0
                ItemContainer.ScrollBarThickness = 2
                
                local ItemList = Instance.new("UIListLayout")
                ItemList.Parent = ItemContainer
                ItemList.SortOrder = Enum.SortOrder.LayoutOrder
                ItemList.Padding = UDim.new(0, 2)
                
                local SearchBox = Instance.new("TextBox")
                SearchBox.Parent = DropFrame
                SearchBox.PlaceholderText = "Search..."
                SearchBox.Size = UDim2.new(1, -20, 0, 20)
                SearchBox.Position = UDim2.new(0, 10, 0, 45)
                SearchBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
                SearchBox.TextColor3 = Theme.Text
                SearchBox.Font = Theme.Font
                SearchBox.TextSize = 12
                SearchBox.Visible = false
                Instance.new("UICorner", SearchBox).CornerRadius = UDim.new(0,4)

                local Opened = false
                local Selection = Config.Multi and (type(Config.Default) == "table" and Config.Default or {}) or {Config.Default}

                local function RefreshList()
                    for _, v in pairs(ItemContainer:GetChildren()) do
                        if v:IsA("TextButton") then v:Destroy() end
                    end
                    
                    for _, val in pairs(Config.Values) do
                        if SearchBox.Text == "" or string.find(string.lower(val), string.lower(SearchBox.Text)) then
                            local Item = Instance.new("TextButton")
                            Item.Parent = ItemContainer
                            Item.Size = UDim2.new(1, -10, 0, 25)
                            Item.Position = UDim2.new(0, 5, 0, 0)
                            Item.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
                            Item.Text = "  " .. val
                            Item.TextColor3 = Theme.TextDark
                            Item.Font = Theme.Font
                            Item.TextSize = 12
                            Item.TextXAlignment = Enum.TextXAlignment.Left
                            Instance.new("UICorner", Item).CornerRadius = UDim.new(0, 4)

                            if (Config.Multi and table.find(Selection, val)) or (not Config.Multi and Selection[1] == val) then
                                Item.TextColor3 = Theme.Accent
                            end

                            Item.MouseButton1Click:Connect(function()
                                if Config.Multi then
                                    if table.find(Selection, val) then
                                        table.remove(Selection, table.find(Selection, val))
                                        Item.TextColor3 = Theme.TextDark
                                    else
                                        table.insert(Selection, val)
                                        Item.TextColor3 = Theme.Accent
                                    end
                                    Config.Callback(Selection)
                                else
                                    Selection = {val}
                                    Config.Callback(val)
                                    DropTitle.Text = Config.Title .. ": " .. val
                                    Opened = false
                                    Library:Tween(DropFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.3)
                                    Library:Tween(OpenBtn, {Rotation = 0}, 0.3)
                                    SearchBox.Visible = false
                                    ItemContainer.Visible = false
                                    RefreshList()
                                end
                            end)
                        end
                    end
                    ItemContainer.CanvasSize = UDim2.new(0, 0, 0, ItemList.AbsoluteContentSize.Y)
                end

                OpenBtn.MouseButton1Click:Connect(function()
                    Opened = not Opened
                    if Opened then
                        SearchBox.Visible = true
                        SearchBox.Position = UDim2.new(0, 10, 0, 45)
                        ItemContainer.Visible = true
                        ItemContainer.Position = UDim2.new(0, 0, 0, 70)
                        ItemContainer.Size = UDim2.new(1, 0, 0, 100)
                        
                        RefreshList()
                        Library:Tween(DropFrame, {Size = UDim2.new(1, 0, 0, 175)}, 0.3)
                        Library:Tween(OpenBtn, {Rotation = 180}, 0.3)
                    else
                        Library:Tween(DropFrame, {Size = UDim2.new(1, 0, 0, 40)}, 0.3)
                        Library:Tween(OpenBtn, {Rotation = 0}, 0.3)
                        SearchBox.Visible = false
                        ItemContainer.Visible = false
                    end
                end)
                
                SearchBox:GetPropertyChangedSignal("Text"):Connect(RefreshList)
                
                if not Config.Multi and Config.Default ~= "" then
                     DropTitle.Text = Config.Title .. ": " .. Config.Default
                end

                local Funcs = {}
                function Funcs:Refresh(vals)
                    Config.Values = vals
                    RefreshList()
                end
                function Funcs:Set(val)
                     Selection = type(val) == "table" and val or {val}
                     if not Config.Multi then
                         DropTitle.Text = Config.Title .. ": " .. tostring(val)
                     end
                     Config.Callback(val)
                     RefreshList()
                end
                return Funcs
            end
            
            function Elements:AddSeperator(Text)
                local Sep = Instance.new("Frame")
                Sep.Parent = Container
                Sep.BackgroundTransparency = 1
                Sep.Size = UDim2.new(1, 0, 0, 20)
                
                local Line = Instance.new("Frame")
                Line.Parent = Sep
                Line.BackgroundColor3 = Theme.Stroke
                Line.Size = UDim2.new(1, -20, 0, 1)
                Line.Position = UDim2.new(0, 10, 0.5, 0)
                
                if Text then
                    local Lab = Instance.new("TextLabel")
                    Lab.Parent = Sep
                    Lab.Text = Text
                    Lab.TextColor3 = Theme.TextDark
                    Lab.BackgroundColor3 = Theme.Secondary
                    Lab.BorderSizePixel = 0
                    Lab.Size = UDim2.new(0, 0, 1, 0)
                    Lab.AutomaticSize = Enum.AutomaticSize.X
                    Lab.Position = UDim2.new(0.5, 0, 0, 0)
                    Lab.AnchorPoint = Vector2.new(0.5, 0)
                    Lab.Font = Theme.FontBold
                    Lab.TextSize = 11
                end
            end

            return Elements
        end
        return Sections
    end
    return Tabs
end

return Library
