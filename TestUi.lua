local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

--// Theme Settings
local Theme = {
    Main = Color3.fromRGB(25, 25, 30), -- Nền chính
    Sidebar = Color3.fromRGB(30, 30, 35), -- Nền sidebar
    Content = Color3.fromRGB(35, 35, 40), -- Nền các element
    Stroke = Color3.fromRGB(50, 50, 55), -- Viền
    Text = Color3.fromRGB(240, 240, 240), -- Chữ chính
    TextDark = Color3.fromRGB(150, 150, 150), -- Chữ phụ
    Accent = Color3.fromRGB(0, 120, 255), -- Màu chủ đạo (Xanh dương hiện đại)
    Red = Color3.fromRGB(255, 80, 80)
}

--// Utility Functions
function Library:Tween(instance, time, properties)
    local tweenInfo = TweenInfo.new(time or 0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    local tween = TweenService:Create(instance, tweenInfo, properties)
    tween:Play()
    return tween
end

function Library:MakeDraggable(topbarobject, object)
    local Dragging = nil
    local DragInput = nil
    local DragStart = nil
    local StartPosition = nil

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
            local Delta = input.Position - DragStart
            local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
            TweenService:Create(object, TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Position = pos }):Play()
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

--// Main UI Creation
function Library:NewWindow(ConfigWindow)
    ConfigWindow = self:MakeConfig({
        Title = "Hub Name",
        Description = "UI Remake by Gemini",
    }, ConfigWindow or {})

    local ScreenGui = Instance.new("ScreenGui")
    
    -- Protect GUI if possible
    if syn and syn.protect_gui then
        syn.protect_gui(ScreenGui)
        ScreenGui.Parent = CoreGui
    elseif gethui then
        ScreenGui.Parent = gethui()
    else
        ScreenGui.Parent = Players.LocalPlayer:WaitForChild("PlayerGui")
    end

    ScreenGui.Name = "TobiiHubRemake"
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    -- Dropdown Overlay Zone (High ZIndex)
    local DropdownZone = Instance.new("Frame")
    DropdownZone.Name = "DropdownZone"
    DropdownZone.Parent = ScreenGui
    DropdownZone.BackgroundTransparency = 1
    DropdownZone.Size = UDim2.new(1, 0, 1, 0)
    DropdownZone.ZIndex = 100
    DropdownZone.Visible = false
    
    local DropdownBackground = Instance.new("Frame")
    DropdownBackground.Parent = DropdownZone
    DropdownBackground.BackgroundColor3 = Color3.new(0,0,0)
    DropdownBackground.BackgroundTransparency = 1
    DropdownBackground.Size = UDim2.new(1,0,1,0)
    
    DropdownBackground.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            -- Click outside to close logic is handled inside Dropdown function
        end
    end)

    -- Main Container
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = Theme.Main
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(0.5, -300, 0.5, -200)
    Main.Size = UDim2.new(0, 600, 0, 400)
    Main.ClipsDescendants = true -- Important for nice rounded corners

    local MainCorner = Instance.new("UICorner")
    MainCorner.CornerRadius = UDim.new(0, 10)
    MainCorner.Parent = Main

    local MainStroke = Instance.new("UIStroke")
    MainStroke.Parent = Main
    MainStroke.Color = Theme.Stroke
    MainStroke.Thickness = 1
    MainStroke.Transparency = 0.5

    -- Sidebar
    local Sidebar = Instance.new("Frame")
    Sidebar.Name = "Sidebar"
    Sidebar.Parent = Main
    Sidebar.BackgroundColor3 = Theme.Sidebar
    Sidebar.BorderSizePixel = 0
    Sidebar.Size = UDim2.new(0, 160, 1, 0)

    local SidebarLine = Instance.new("Frame")
    SidebarLine.Parent = Sidebar
    SidebarLine.BackgroundColor3 = Theme.Stroke
    SidebarLine.BorderSizePixel = 0
    SidebarLine.Position = UDim2.new(1, -1, 0, 0)
    SidebarLine.Size = UDim2.new(0, 1, 1, 0)

    -- Logo / Title Header
    local Header = Instance.new("Frame")
    Header.Name = "Header"
    Header.Parent = Sidebar
    Header.BackgroundTransparency = 1
    Header.Size = UDim2.new(1, 0, 0, 60)
    
    local Logo = Instance.new("ImageLabel")
    Logo.Parent = Header
    Logo.BackgroundTransparency = 1
    Logo.Position = UDim2.new(0, 12, 0.5, -12)
    Logo.Size = UDim2.new(0, 24, 0, 24)
    Logo.Image = "rbxassetid://133979080007875" -- Giữ logo cũ

    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Parent = Header
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Position = UDim2.new(0, 45, 0, 12)
    TitleLabel.Size = UDim2.new(0, 110, 0, 16)
    TitleLabel.Font = Enum.Font.GothamBold
    TitleLabel.Text = ConfigWindow.Title
    TitleLabel.TextColor3 = Theme.Text
    TitleLabel.TextSize = 14
    TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

    local DescLabel = Instance.new("TextLabel")
    DescLabel.Parent = Header
    DescLabel.BackgroundTransparency = 1
    DescLabel.Position = UDim2.new(0, 45, 0, 30)
    DescLabel.Size = UDim2.new(0, 110, 0, 14)
    DescLabel.Font = Enum.Font.Gotham
    DescLabel.Text = ConfigWindow.Description
    DescLabel.TextColor3 = Theme.TextDark
    DescLabel.TextSize = 11
    DescLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Tab Container
    local TabContainer = Instance.new("ScrollingFrame")
    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Sidebar
    TabContainer.BackgroundTransparency = 1
    TabContainer.BorderSizePixel = 0
    TabContainer.Position = UDim2.new(0, 0, 0, 70)
    TabContainer.Size = UDim2.new(1, 0, 1, -70)
    TabContainer.ScrollBarThickness = 0
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = TabContainer
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 5)

    local TabPadding = Instance.new("UIPadding")
    TabPadding.Parent = TabContainer
    TabPadding.PaddingLeft = UDim.new(0, 10)
    TabPadding.PaddingRight = UDim.new(0, 10)

    -- Page Container (Right Side)
    local PageContainer = Instance.new("Frame")
    PageContainer.Name = "PageContainer"
    PageContainer.Parent = Main
    PageContainer.BackgroundTransparency = 1
    PageContainer.Position = UDim2.new(0, 160, 0, 0)
    PageContainer.Size = UDim2.new(1, -160, 1, 0)
    
    local PageLayout = Instance.new("UIPageLayout")
    PageLayout.Parent = PageContainer
    PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageLayout.EasingStyle = Enum.EasingStyle.Exponential
    PageLayout.EasingDirection = Enum.EasingDirection.Out
    PageLayout.TweenTime = 0.4
    PageLayout.ScrollWheelInputEnabled = false

    -- Dragging
    self:MakeDraggable(Sidebar, Main)
    self:MakeDraggable(PageContainer, Main) -- Allow dragging from main area too

    -- Close Button (Custom)
    local CloseButton = Instance.new("TextButton")
    CloseButton.Parent = PageContainer
    CloseButton.BackgroundColor3 = Theme.Red
    CloseButton.BackgroundTransparency = 1 -- Visible on hover maybe?
    CloseButton.Position = UDim2.new(1, -30, 0, 10)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Text = "X"
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.TextColor3 = Theme.TextDark
    CloseButton.TextSize = 14
    CloseButton.AutoButtonColor = false
    
    CloseButton.MouseEnter:Connect(function() Library:Tween(CloseButton, 0.2, {TextColor3 = Theme.Red}) end)
    CloseButton.MouseLeave:Connect(function() Library:Tween(CloseButton, 0.2, {TextColor3 = Theme.TextDark}) end)
    CloseButton.MouseButton1Click:Connect(function()
        -- Animation close
        Library:Tween(Main, 0.2, {Size = UDim2.new(0,600,0,0)})
        wait(0.2)
        ScreenGui:Destroy()
    end)

    local Tabs = {}
    local FirstTab = true

    function Tabs:T(TabName)
        local TabFunctions = {}
        
        -- Tab Button
        local TabBtn = Instance.new("TextButton")
        TabBtn.Name = "TabBtn"
        TabBtn.Parent = TabContainer
        TabBtn.BackgroundColor3 = Theme.Content
        TabBtn.BackgroundTransparency = 1
        TabBtn.Size = UDim2.new(1, 0, 0, 32)
        TabBtn.Font = Enum.Font.GothamMedium
        TabBtn.Text = TabName
        TabBtn.TextColor3 = Theme.TextDark
        TabBtn.TextSize = 13
        TabBtn.TextXAlignment = Enum.TextXAlignment.Left
        TabBtn.AutoButtonColor = false
        
        local TabBtnPadding = Instance.new("UIPadding")
        TabBtnPadding.Parent = TabBtn
        TabBtnPadding.PaddingLeft = UDim.new(0, 12)
        
        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 6)
        TabCorner.Parent = TabBtn
        
        local TabIndicator = Instance.new("Frame")
        TabIndicator.Parent = TabBtn
        TabIndicator.BackgroundColor3 = Theme.Accent
        TabIndicator.Position = UDim2.new(0, -10, 0.5, -8) -- Hidden initially
        TabIndicator.Size = UDim2.new(0, 3, 0, 16)
        TabIndicator.BackgroundTransparency = 1
        
        local TabCornerInd = Instance.new("UICorner")
        TabCornerInd.CornerRadius = UDim.new(1,0)
        TabCornerInd.Parent = TabIndicator

        -- Page Content
        local Page = Instance.new("ScrollingFrame")
        Page.Name = TabName .. "_Page"
        Page.Parent = PageContainer
        Page.BackgroundTransparency = 1
        Page.BorderSizePixel = 0
        Page.Size = UDim2.new(1, 0, 1, 0)
        Page.ScrollBarThickness = 2
        Page.ScrollBarImageColor3 = Theme.Accent
        Page.CanvasSize = UDim2.new(0,0,0,0)
        
        local PageList = Instance.new("UIListLayout")
        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 8)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = Page
        PagePadding.PaddingTop = UDim.new(0, 45) -- Space for search/topbar
        PagePadding.PaddingLeft = UDim.new(0, 15)
        PagePadding.PaddingRight = UDim.new(0, 15)
        PagePadding.PaddingBottom = UDim.new(0, 15)

        -- Update Canvas Size
        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 60)
        end)

        -- Active/Inactive Logic
        local function Activate()
            -- Reset all tabs
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    Library:Tween(v, 0.3, {BackgroundTransparency = 1, TextColor3 = Theme.TextDark})
                    Library:Tween(v.Frame, 0.3, {BackgroundTransparency = 1, Position = UDim2.new(0, -10, 0.5, -8)})
                end
            end
            -- Activate this
            Library:Tween(TabBtn, 0.3, {BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(40,40,45), TextColor3 = Theme.Text})
            Library:Tween(TabIndicator, 0.3, {BackgroundTransparency = 0, Position = UDim2.new(0, 0, 0.5, -8)})
            PageLayout:JumpTo(Page)
        end

        TabBtn.MouseButton1Click:Connect(Activate)

        if FirstTab then
            FirstTab = false
            Activate()
        end

        -- SECTIONS
        function TabFunctions:AddSection(SectionName)
            local SectionFunctions = {}
            
            local Section = Instance.new("Frame")
            Section.Name = "Section"
            Section.Parent = Page
            Section.BackgroundColor3 = Theme.Content
            Section.BackgroundTransparency = 1 -- Transparent container for grouping
            Section.Size = UDim2.new(1, 0, 0, 30) -- Auto resized
            
            local SectionTitle = Instance.new("TextLabel")
            SectionTitle.Parent = Section
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, 0, 0, 25)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = SectionName
            SectionTitle.TextColor3 = Theme.Text
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left
            
            local SectionContainer = Instance.new("Frame")
            SectionContainer.Parent = Section
            SectionContainer.BackgroundTransparency = 1
            SectionContainer.Position = UDim2.new(0, 0, 0, 30)
            SectionContainer.Size = UDim2.new(1, 0, 0, 0)
            
            local SectionList = Instance.new("UIListLayout")
            SectionList.Parent = SectionContainer
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 8)

            SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionContainer.Size = UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y)
                Section.Size = UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 35)
            end)
            
            --// ELEMENTS
            
            function SectionFunctions:AddParagraph(Config)
                local Paragraph = Instance.new("Frame")
                Paragraph.Parent = SectionContainer
                Paragraph.BackgroundColor3 = Theme.Content
                Paragraph.Size = UDim2.new(1, 0, 0, 0)
                
                local PCorner = Instance.new("UICorner")
                PCorner.Parent = Paragraph
                PCorner.CornerRadius = UDim.new(0, 6)
                
                local PTitle = Instance.new("TextLabel")
                PTitle.Parent = Paragraph
                PTitle.BackgroundTransparency = 1
                PTitle.Position = UDim2.new(0, 10, 0, 8)
                PTitle.Size = UDim2.new(1, -20, 0, 15)
                PTitle.Font = Enum.Font.GothamBold
                PTitle.Text = Config.Title or "Paragraph"
                PTitle.TextColor3 = Theme.Text
                PTitle.TextSize = 13
                PTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local PContent = Instance.new("TextLabel")
                PContent.Parent = Paragraph
                PContent.BackgroundTransparency = 1
                PContent.Position = UDim2.new(0, 10, 0, 25)
                PContent.Size = UDim2.new(1, -20, 0, 0)
                PContent.Font = Enum.Font.Gotham
                PContent.Text = Config.Content or ""
                PContent.TextColor3 = Theme.TextDark
                PContent.TextSize = 12
                PContent.TextXAlignment = Enum.TextXAlignment.Left
                PContent.TextWrapped = true
                PContent.TextYAlignment = Enum.TextYAlignment.Top
                
                -- Auto resize logic
                local function Resize()
                    PContent.Size = UDim2.new(1, -20, 0, PContent.TextBounds.Y + 5)
                    Paragraph.Size = UDim2.new(1, 0, 0, PContent.TextBounds.Y + 35)
                end
                PContent:GetPropertyChangedSignal("TextBounds"):Connect(Resize)
                Resize()
                
                local ParaFunc = {}
                function ParaFunc:SetTitle(t) PTitle.Text = t end
                function ParaFunc:SetDesc(d) PContent.Text = d Resize() end
                return ParaFunc
            end

            function SectionFunctions:AddSeperator(Text)
                local Sep = Instance.new("Frame")
                Sep.Parent = SectionContainer
                Sep.BackgroundTransparency = 1
                Sep.Size = UDim2.new(1, 0, 0, 20)
                
                local SepText = Instance.new("TextLabel")
                SepText.Parent = Sep
                SepText.BackgroundTransparency = 1
                SepText.Size = UDim2.new(1, 0, 1, 0)
                SepText.Font = Enum.Font.GothamBold
                SepText.Text = Text
                SepText.TextColor3 = Theme.TextDark
                SepText.TextSize = 12
                SepText.TextXAlignment = Enum.TextXAlignment.Left
            end

            function SectionFunctions:AddButton(Config)
                Config = Library:MakeConfig({Title="Button", Description="", Callback=function() end}, Config)
                
                local Button = Instance.new("TextButton")
                Button.Parent = SectionContainer
                Button.BackgroundColor3 = Theme.Content
                Button.Size = UDim2.new(1, 0, 0, 40)
                Button.AutoButtonColor = false
                Button.Text = ""
                
                local BCorner = Instance.new("UICorner")
                BCorner.CornerRadius = UDim.new(0, 6)
                BCorner.Parent = Button
                
                local BStroke = Instance.new("UIStroke")
                BStroke.Color = Theme.Stroke
                BStroke.Thickness = 1
                BStroke.Parent = Button
                
                local BTitle = Instance.new("TextLabel")
                BTitle.Parent = Button
                BTitle.BackgroundTransparency = 1
                BTitle.Position = UDim2.new(0, 10, 0, 0)
                BTitle.Size = UDim2.new(1, -40, 1, 0)
                BTitle.Font = Enum.Font.GothamMedium
                BTitle.Text = Config.Title
                BTitle.TextColor3 = Theme.Text
                BTitle.TextSize = 13
                BTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local BIcon = Instance.new("ImageLabel")
                BIcon.Parent = Button
                BIcon.BackgroundTransparency = 1
                BIcon.Position = UDim2.new(1, -30, 0.5, -10)
                BIcon.Size = UDim2.new(0, 20, 0, 20)
                BIcon.Image = "rbxassetid://10709791437" -- Pointer icon
                BIcon.ImageColor3 = Theme.TextDark

                Button.MouseEnter:Connect(function()
                    Library:Tween(Button, 0.2, {BackgroundColor3 = Color3.fromRGB(45, 45, 50)})
                    Library:Tween(BIcon, 0.2, {ImageColor3 = Theme.Accent})
                end)
                
                Button.MouseLeave:Connect(function()
                    Library:Tween(Button, 0.2, {BackgroundColor3 = Theme.Content})
                    Library:Tween(BIcon, 0.2, {ImageColor3 = Theme.TextDark})
                end)
                
                Button.MouseButton1Click:Connect(function()
                    -- Click effect
                    Library:Tween(Button, 0.1, {Size = UDim2.new(1, -4, 0, 38)})
                    wait(0.1)
                    Library:Tween(Button, 0.1, {Size = UDim2.new(1, 0, 0, 40)})
                    Config.Callback()
                end)
            end

            function SectionFunctions:AddToggle(Config)
                Config = Library:MakeConfig({Title="Toggle", Description="", Default=false, Callback=function() end}, Config)
                
                local Toggle = Instance.new("Frame")
                Toggle.Parent = SectionContainer
                Toggle.BackgroundColor3 = Theme.Content
                Toggle.Size = UDim2.new(1, 0, 0, 40)
                
                local TCorner = Instance.new("UICorner")
                TCorner.CornerRadius = UDim.new(0, 6)
                TCorner.Parent = Toggle
                
                local TTitle = Instance.new("TextLabel")
                TTitle.Parent = Toggle
                TTitle.BackgroundTransparency = 1
                TTitle.Position = UDim2.new(0, 10, 0, 0)
                TTitle.Size = UDim2.new(1, -70, 1, 0)
                TTitle.Font = Enum.Font.GothamMedium
                TTitle.Text = Config.Title
                TTitle.TextColor3 = Theme.Text
                TTitle.TextSize = 13
                TTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                -- Switch UI
                local SwitchBg = Instance.new("Frame")
                SwitchBg.Parent = Toggle
                SwitchBg.BackgroundColor3 = Color3.fromRGB(50,50,55)
                SwitchBg.Position = UDim2.new(1, -50, 0.5, -10)
                SwitchBg.Size = UDim2.new(0, 40, 0, 20)
                
                local SwitchCorner = Instance.new("UICorner")
                SwitchCorner.CornerRadius = UDim.new(1, 0)
                SwitchCorner.Parent = SwitchBg
                
                local SwitchCircle = Instance.new("Frame")
                SwitchCircle.Parent = SwitchBg
                SwitchCircle.BackgroundColor3 = Color3.fromRGB(200,200,200)
                SwitchCircle.Position = UDim2.new(0, 2, 0.5, -8)
                SwitchCircle.Size = UDim2.new(0, 16, 0, 16)
                
                local CircleCorner = Instance.new("UICorner")
                CircleCorner.CornerRadius = UDim.new(1, 0)
                CircleCorner.Parent = SwitchCircle
                
                local Trigger = Instance.new("TextButton")
                Trigger.Parent = Toggle
                Trigger.BackgroundTransparency = 1
                Trigger.Size = UDim2.new(1, 0, 1, 0)
                Trigger.Text = ""
                
                local State = Config.Default
                
                local function UpdateState()
                    if State then
                        Library:Tween(SwitchBg, 0.2, {BackgroundColor3 = Theme.Accent})
                        Library:Tween(SwitchCircle, 0.2, {Position = UDim2.new(1, -18, 0.5, -8), BackgroundColor3 = Color3.fromRGB(255,255,255)})
                    else
                        Library:Tween(SwitchBg, 0.2, {BackgroundColor3 = Color3.fromRGB(50,50,55)})
                        Library:Tween(SwitchCircle, 0.2, {Position = UDim2.new(0, 2, 0.5, -8), BackgroundColor3 = Color3.fromRGB(200,200,200)})
                    end
                    Config.Callback(State)
                end
                
                UpdateState()
                
                Trigger.MouseButton1Click:Connect(function()
                    State = not State
                    UpdateState()
                end)
                
                local ToggleFunc = {}
                function ToggleFunc:Set(val)
                    State = val
                    UpdateState()
                end
                return ToggleFunc
            end
            
            function SectionFunctions:AddSlider(Config)
                Config = Library:MakeConfig({Title="Slider", Min=0, Max=100, Default=50, Increment=1, Callback=function() end}, Config)
                
                local Slider = Instance.new("Frame")
                Slider.Parent = SectionContainer
                Slider.BackgroundColor3 = Theme.Content
                Slider.Size = UDim2.new(1, 0, 0, 50)
                
                local SCorner = Instance.new("UICorner")
                SCorner.CornerRadius = UDim.new(0, 6)
                SCorner.Parent = Slider
                
                local STitle = Instance.new("TextLabel")
                STitle.Parent = Slider
                STitle.BackgroundTransparency = 1
                STitle.Position = UDim2.new(0, 10, 0, 8)
                STitle.Size = UDim2.new(1, -60, 0, 15)
                STitle.Font = Enum.Font.GothamMedium
                STitle.Text = Config.Title
                STitle.TextColor3 = Theme.Text
                STitle.TextSize = 13
                STitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local SValue = Instance.new("TextLabel")
                SValue.Parent = Slider
                SValue.BackgroundTransparency = 1
                SValue.Position = UDim2.new(1, -50, 0, 8)
                SValue.Size = UDim2.new(0, 40, 0, 15)
                SValue.Font = Enum.Font.GothamBold
                SValue.Text = tostring(Config.Default)
                SValue.TextColor3 = Theme.Accent
                SValue.TextSize = 13
                SValue.TextXAlignment = Enum.TextXAlignment.Right
                
                local SliderBar = Instance.new("Frame")
                SliderBar.Parent = Slider
                SliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 55)
                SliderBar.Position = UDim2.new(0, 10, 0, 32)
                SliderBar.Size = UDim2.new(1, -20, 0, 4)
                
                local BarCorner = Instance.new("UICorner")
                BarCorner.CornerRadius = UDim.new(1, 0)
                BarCorner.Parent = SliderBar
                
                local Fill = Instance.new("Frame")
                Fill.Parent = SliderBar
                Fill.BackgroundColor3 = Theme.Accent
                Fill.Size = UDim2.new(0, 0, 1, 0)
                
                local FillCorner = Instance.new("UICorner")
                FillCorner.CornerRadius = UDim.new(1, 0)
                FillCorner.Parent = Fill
                
                local Circle = Instance.new("Frame")
                Circle.Parent = Fill
                Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Circle.Position = UDim2.new(1, -5, 0.5, -5)
                Circle.Size = UDim2.new(0, 10, 0, 10)
                
                local CCorner = Instance.new("UICorner")
                CCorner.CornerRadius = UDim.new(1, 0)
                CCorner.Parent = Circle
                
                -- Logic
                local Dragging = false
                local Value = Config.Default
                
                local function Set(val)
                    val = math.clamp(val, Config.Min, Config.Max)
                    if Config.Increment > 0 then
                        val = math.floor(val / Config.Increment + 0.5) * Config.Increment
                    end
                    Value = val
                    SValue.Text = tostring(Value)
                    
                    local Percent = (Value - Config.Min) / (Config.Max - Config.Min)
                    Library:Tween(Fill, 0.1, {Size = UDim2.new(Percent, 0, 1, 0)})
                    Config.Callback(Value)
                end
                
                Set(Value)
                
                local SliderInput = Instance.new("TextButton")
                SliderInput.Parent = Slider
                SliderInput.BackgroundTransparency = 1
                SliderInput.Size = UDim2.new(1, 0, 1, 0)
                SliderInput.Text = ""
                
                SliderInput.MouseButton1Down:Connect(function() Dragging = true end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end
                end)
                
                UserInputService.InputChanged:Connect(function(input)
                    if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                        local SizeScale = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                        Set(Config.Min + ((Config.Max - Config.Min) * SizeScale))
                    end
                end)
                
                local SliderFunc = {}
                function SliderFunc:Set(v) Set(v) end
                return SliderFunc
            end

            function SectionFunctions:AddInput(Config)
                Config = Library:MakeConfig({Title="Input", PlaceHolder="Type here...", Default="", Callback=function() end}, Config)
                
                local InputFrame = Instance.new("Frame")
                InputFrame.Parent = SectionContainer
                InputFrame.BackgroundColor3 = Theme.Content
                InputFrame.Size = UDim2.new(1, 0, 0, 45)
                
                local ICorner = Instance.new("UICorner")
                ICorner.CornerRadius = UDim.new(0, 6)
                ICorner.Parent = InputFrame
                
                local ITitle = Instance.new("TextLabel")
                ITitle.Parent = InputFrame
                ITitle.BackgroundTransparency = 1
                ITitle.Position = UDim2.new(0, 10, 0, 0)
                ITitle.Size = UDim2.new(1, -20, 0, 20)
                ITitle.Font = Enum.Font.GothamMedium
                ITitle.Text = Config.Title
                ITitle.TextColor3 = Theme.Text
                ITitle.TextSize = 13
                ITitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local TextBoxBg = Instance.new("Frame")
                TextBoxBg.Parent = InputFrame
                TextBoxBg.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
                TextBoxBg.Position = UDim2.new(0, 10, 0, 20)
                TextBoxBg.Size = UDim2.new(1, -20, 0, 20)
                
                local TbCorner = Instance.new("UICorner")
                TbCorner.CornerRadius = UDim.new(0, 4)
                TbCorner.Parent = TextBoxBg
                
                local TbStroke = Instance.new("UIStroke")
                TbStroke.Color = Theme.Stroke
                TbStroke.Parent = TextBoxBg
                
                local Box = Instance.new("TextBox")
                Box.Parent = TextBoxBg
                Box.BackgroundTransparency = 1
                Box.Position = UDim2.new(0, 5, 0, 0)
                Box.Size = UDim2.new(1, -10, 1, 0)
                Box.Font = Enum.Font.Gotham
                Box.PlaceholderText = Config.PlaceHolder
                Box.Text = Config.Default
                Box.TextColor3 = Theme.Text
                Box.TextSize = 12
                Box.TextXAlignment = Enum.TextXAlignment.Left
                
                Box.FocusLost:Connect(function()
                    Library:Tween(TbStroke, 0.2, {Color = Theme.Stroke})
                    Config.Callback(Box.Text)
                end)
                
                Box.Focused:Connect(function()
                    Library:Tween(TbStroke, 0.2, {Color = Theme.Accent})
                end)
            end

            function SectionFunctions:AddDropdown(Config)
                Config = Library:MakeConfig({Title="Dropdown", Values={}, Default="", Multi=false, Callback=function() end}, Config)
                
                local Dropdown = Instance.new("Frame")
                Dropdown.Parent = SectionContainer
                Dropdown.BackgroundColor3 = Theme.Content
                Dropdown.Size = UDim2.new(1, 0, 0, 40)
                
                local DCorner = Instance.new("UICorner")
                DCorner.CornerRadius = UDim.new(0, 6)
                DCorner.Parent = Dropdown
                
                local DTitle = Instance.new("TextLabel")
                DTitle.Parent = Dropdown
                DTitle.BackgroundTransparency = 1
                DTitle.Position = UDim2.new(0, 10, 0, 0)
                DTitle.Size = UDim2.new(0.6, 0, 1, 0)
                DTitle.Font = Enum.Font.GothamMedium
                DTitle.Text = Config.Title
                DTitle.TextColor3 = Theme.Text
                DTitle.TextSize = 13
                DTitle.TextXAlignment = Enum.TextXAlignment.Left
                
                local SelectedText = Instance.new("TextLabel")
                SelectedText.Parent = Dropdown
                SelectedText.BackgroundTransparency = 1
                SelectedText.Position = UDim2.new(0.5, 0, 0, 0)
                SelectedText.Size = UDim2.new(0.5, -30, 1, 0)
                SelectedText.Font = Enum.Font.Gotham
                SelectedText.Text = (type(Config.Default)=="table" and table.concat(Config.Default, ", ")) or tostring(Config.Default)
                SelectedText.TextColor3 = Theme.TextDark
                SelectedText.TextSize = 12
                SelectedText.TextXAlignment = Enum.TextXAlignment.Right
                SelectedText.TextTruncate = Enum.TextTruncate.AtEnd

                local Icon = Instance.new("ImageLabel")
                Icon.Parent = Dropdown
                Icon.BackgroundTransparency = 1
                Icon.Position = UDim2.new(1, -25, 0.5, -8)
                Icon.Size = UDim2.new(0, 16, 0, 16)
                Icon.Image = "rbxassetid://10709790948" -- Chevron Down
                Icon.ImageColor3 = Theme.TextDark
                
                local Trigger = Instance.new("TextButton")
                Trigger.Parent = Dropdown
                Trigger.BackgroundTransparency = 1
                Trigger.Size = UDim2.new(1, 0, 1, 0)
                Trigger.Text = ""

                -- Logic to open overlay
                Trigger.MouseButton1Click:Connect(function()
                    DropdownZone.Visible = true
                    DropdownBackground.BackgroundTransparency = 1
                    Library:Tween(DropdownBackground, 0.3, {BackgroundTransparency = 0.5})
                    
                    -- Create List Frame
                    local ListFrame = Instance.new("Frame")
                    ListFrame.Parent = DropdownZone
                    ListFrame.BackgroundColor3 = Theme.Main
                    ListFrame.Size = UDim2.new(0, 300, 0, 300)
                    ListFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
                    ListFrame.AnchorPoint = Vector2.new(0,0) -- Managed manually
                    ListFrame.BackgroundTransparency = 1 -- Animate in
                    
                    local ListCorner = Instance.new("UICorner")
                    ListCorner.CornerRadius = UDim.new(0, 8)
                    ListCorner.Parent = ListFrame
                    
                    local ListStroke = Instance.new("UIStroke")
                    ListStroke.Color = Theme.Accent
                    ListStroke.Thickness = 1
                    ListStroke.Parent = ListFrame
                    
                    local SearchBox = Instance.new("TextBox")
                    SearchBox.Parent = ListFrame
                    SearchBox.BackgroundColor3 = Theme.Content
                    SearchBox.Position = UDim2.new(0, 10, 0, 10)
                    SearchBox.Size = UDim2.new(1, -20, 0, 30)
                    SearchBox.Font = Enum.Font.Gotham
                    SearchBox.PlaceholderText = "Search..."
                    SearchBox.Text = ""
                    SearchBox.TextColor3 = Theme.Text
                    SearchBox.TextSize = 13
                    
                    local SearchCorner = Instance.new("UICorner")
                    SearchCorner.CornerRadius = UDim.new(0, 6)
                    SearchCorner.Parent = SearchBox
                    
                    local ItemScroll = Instance.new("ScrollingFrame")
                    ItemScroll.Parent = ListFrame
                    ItemScroll.BackgroundTransparency = 1
                    ItemScroll.Position = UDim2.new(0, 0, 0, 50)
                    ItemScroll.Size = UDim2.new(1, 0, 1, -50)
                    ItemScroll.ScrollBarThickness = 2
                    
                    local ItemLayout = Instance.new("UIListLayout")
                    ItemLayout.Parent = ItemScroll
                    ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    ItemLayout.Padding = UDim.new(0, 2)
                    
                    -- Populate items
                    local CurrentSelection = (type(Config.Default) == "table" and Config.Default) or {Config.Default}
                    
                    local function RefreshItems(search)
                        for _,v in pairs(ItemScroll:GetChildren()) do 
                            if v:IsA("TextButton") then v:Destroy() end 
                        end
                        
                        for _, val in pairs(Config.Values) do
                            if search == "" or string.find(string.lower(val), string.lower(search)) then
                                local Item = Instance.new("TextButton")
                                Item.Parent = ItemScroll
                                Item.BackgroundColor3 = Theme.Sidebar
                                Item.BackgroundTransparency = 0.5
                                Item.Size = UDim2.new(1, 0, 0, 30)
                                Item.Font = Enum.Font.Gotham
                                Item.Text = "   " .. val
                                Item.TextColor3 = Theme.TextDark
                                Item.TextSize = 13
                                Item.TextXAlignment = Enum.TextXAlignment.Left
                                Item.AutoButtonColor = false
                                
                                -- Check if selected
                                if table.find(CurrentSelection, val) then
                                    Item.TextColor3 = Theme.Accent
                                    Item.Text = "   " .. val .. "  ✓"
                                end
                                
                                Item.MouseButton1Click:Connect(function()
                                    if Config.Multi then
                                        if table.find(CurrentSelection, val) then
                                            for i,v in pairs(CurrentSelection) do if v == val then table.remove(CurrentSelection, i) end end
                                        else
                                            table.insert(CurrentSelection, val)
                                        end
                                        -- Refresh Text
                                        if #CurrentSelection == 0 then SelectedText.Text = "..." else SelectedText.Text = table.concat(CurrentSelection, ", ") end
                                        Config.Callback(CurrentSelection)
                                    else
                                        CurrentSelection = {val}
                                        SelectedText.Text = val
                                        Config.Callback(val)
                                        -- Close
                                        DropdownZone.Visible = false
                                        ListFrame:Destroy()
                                    end
                                    RefreshItems(SearchBox.Text)
                                end)
                            end
                        end
                        ItemScroll.CanvasSize = UDim2.new(0,0,0, ItemLayout.AbsoluteContentSize.Y)
                    end
                    
                    RefreshItems("")
                    
                    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
                        RefreshItems(SearchBox.Text)
                    end)
                    
                    -- Animate In
                    Library:Tween(ListFrame, 0.2, {BackgroundTransparency = 0})
                    
                    -- Close logic (click background)
                    local Connection
                    Connection = DropdownBackground.InputBegan:Connect(function(inp)
                        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
                            DropdownZone.Visible = false
                            ListFrame:Destroy()
                            Connection:Disconnect()
                        end
                    end)
                end)
                
                local DropFunc = {}
                function DropFunc:Refresh(NewVal)
                    Config.Values = NewVal
                end
                return DropFunc
            end

            return SectionFunctions
        end
        return TabFunctions
    end

    -- Floating UI Toggle Button (Small icon to toggle UI)
    local ToggleGui = Instance.new("ImageButton")
    ToggleGui.Name = "ToggleGui"
    ToggleGui.Parent = ScreenGui
    ToggleGui.BackgroundColor3 = Theme.Main
    ToggleGui.Position = UDim2.new(0, 10, 0.5, 0)
    ToggleGui.Size = UDim2.new(0, 40, 0, 40)
    ToggleGui.Image = "rbxassetid://133979080007875" -- Logo
    ToggleGui.BorderSizePixel = 0
    
    local ToggleCorner = Instance.new("UICorner")
    ToggleCorner.CornerRadius = UDim.new(0, 8)
    ToggleCorner.Parent = ToggleGui
    
    local ToggleStroke = Instance.new("UIStroke")
    ToggleStroke.Color = Theme.Accent
    ToggleStroke.Thickness = 1
    ToggleStroke.Parent = ToggleGui
    
    ToggleGui.MouseButton1Click:Connect(function()
        Main.Visible = not Main.Visible
    end)
    self:MakeDraggable(ToggleGui, ToggleGui)

    return Tabs
end

return Library
