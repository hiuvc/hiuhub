local Library = {}
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

--// Theme Settings (Modern White/Gray)
local Theme = {
    Main = Color3.fromRGB(255, 255, 255), -- Pure White Background
    Secondary = Color3.fromRGB(246, 246, 246), -- Very Light Gray/Off-White for containers
    Stroke = Color3.fromRGB(225, 225, 225), -- Subtle Gray Borders
    Divider = Color3.fromRGB(235, 235, 235), -- Dividers
    
    Text = Color3.fromRGB(40, 40, 40), -- Dark Gray for primary text (High Contrast)
    TextDark = Color3.fromRGB(150, 150, 150), -- Lighter Gray for secondary text
    
    Accent = Color3.fromRGB(80, 80, 80), -- Dark Gray Accent
    AccentH = Color3.fromRGB(60, 60, 60), -- Darker Accent for Hover
    
    Shadow = Color3.fromRGB(0, 0, 0), -- Shadow Color
    
    Font = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold,
}

--// Utils
local function Create(class, props)
    local instance = Instance.new(class)
    for i, v in pairs(props) do
        instance[i] = v
    end
    return instance
end

function Library:Tween(instance, props, time, style, dir, repeatCount, reverse)
    local info = TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quart, dir or Enum.EasingDirection.Out, repeatCount or 0, reverse or false)
    local tween = TweenService:Create(instance, info, props)
    tween:Play()
    return tween
end

function Library:MakeDraggable(topbarobject, object)
    local Dragging, DragInput, DragStart, StartPosition
    
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
            Library:Tween(object, {Position = pos}, 0.1, Enum.EasingStyle.Sine)
        end
    end)
end

function Library:MakeConfig(Config, NewConfig)
    for i, v in next, Config do
        if NewConfig[i] == nil then NewConfig[i] = v end
    end
    return NewConfig
end

--// UI Construction
function Library:NewWindow(ConfigWindow)
    ConfigWindow = self:MakeConfig({
        Title = "Hub | Remake",
        Description = "Clean Interface",
    }, ConfigWindow or {})

    if CoreGui:FindFirstChild("OrionLikeUI_Light") then
        CoreGui:FindFirstChild("OrionLikeUI_Light"):Destroy()
    end

    local ScreenGui = Create("ScreenGui", {
        Name = "OrionLikeUI_Light",
        Parent = Players.LocalPlayer:WaitForChild("PlayerGui"),
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })

    -- Main Container
    local Main = Create("Frame", {
        Name = "Main",
        Parent = ScreenGui,
        BackgroundColor3 = Theme.Main,
        Position = UDim2.new(0.5, -300, 0.5, -200),
        Size = UDim2.new(0, 600, 0, 420),
        BorderSizePixel = 0,
        ClipsDescendants = false, -- Changed to false for shadow
        AnchorPoint = Vector2.new(0, 0)
    })
    
    local MainCorner = Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Main})
    local MainStroke = Create("UIStroke", {Color = Theme.Stroke, Thickness = 1, Parent = Main})
    
    -- DropShadow (Soft)
    local Shadow = Create("ImageLabel", {
        Parent = Main,
        BackgroundTransparency = 1,
        Position = UDim2.new(0, -30, 0, -30),
        Size = UDim2.new(1, 60, 1, 60),
        ZIndex = -1,
        Image = "rbxassetid://6015897843",
        ImageColor3 = Theme.Shadow,
        ImageTransparency = 0.85, -- Very subtle shadow
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(49, 49, 450, 450)
    })

    --// Sidebar
    local Sidebar = Create("Frame", {
        Name = "Sidebar",
        Parent = Main,
        BackgroundColor3 = Theme.Secondary,
        Size = UDim2.new(0, 180, 1, 0),
        BorderSizePixel = 0,
        ZIndex = 2
    })
    
    -- Round only left corners of Sidebar
    local SidebarCorner = Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Sidebar})
    local SidebarFix = Create("Frame", { -- Fix right corners to be square
        Parent = Sidebar,
        BackgroundColor3 = Theme.Secondary,
        BorderSizePixel = 0,
        Size = UDim2.new(0, 10, 1, 0),
        Position = UDim2.new(1, -10, 0, 0),
        ZIndex = 2
    })
    
    local Separator = Create("Frame", {
        Parent = Sidebar,
        Size = UDim2.new(0, 1, 1, 0),
        Position = UDim2.new(1, 0, 0, 0),
        BackgroundColor3 = Theme.Divider,
        BorderSizePixel = 0,
        ZIndex = 3
    })

    -- Header
    local Header = Create("Frame", {
        Parent = Sidebar,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        ZIndex = 3
    })

    local Title = Create("TextLabel", {
        Parent = Header,
        Text = ConfigWindow.Title,
        Font = Theme.FontBold,
        TextSize = 18,
        TextColor3 = Theme.Text,
        Size = UDim2.new(1, -24, 1, 0),
        Position = UDim2.new(0, 24, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    -- Tabs Container
    local TabContainer = Create("ScrollingFrame", {
        Parent = Sidebar,
        Position = UDim2.new(0, 0, 0, 70),
        Size = UDim2.new(1, 0, 1, -70),
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        ZIndex = 3
    })
    Create("UIPadding", {Parent = TabContainer, PaddingTop = UDim.new(0, 0), PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12)})
    local TabList = Create("UIListLayout", {Parent = TabContainer, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 6)})

    --// Content Area
    local Content = Create("Frame", {
        Name = "Content",
        Parent = Main,
        BackgroundColor3 = Theme.Main,
        Position = UDim2.new(0, 180, 0, 0),
        Size = UDim2.new(1, -180, 1, 0),
        BorderSizePixel = 0,
        ClipsDescendants = true -- Clip content to rounded corners
    })
    Create("UICorner", {CornerRadius = UDim.new(0, 12), Parent = Content}) -- Match Main corner

    local ContentFix = Create("Frame", { -- Fix left corners to be square (connect to sidebar)
        Parent = Content,
        BackgroundColor3 = Theme.Main,
        Size = UDim2.new(0, 10, 1, 0),
        Position = UDim2.new(0, 0, 0, 0)
    })

    local Pages = Create("Folder", {Parent = Content, Name = "Pages"})
    
    -- Topbar (Title/Close)
    local Topbar = Create("Frame", {
        Parent = Content,
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        ZIndex = 5
    })
    
    local CurrentTabLabel = Create("TextLabel", {
        Parent = Topbar,
        Text = "Welcome",
        Font = Theme.FontBold,
        TextSize = 22,
        TextColor3 = Theme.Text,
        Size = UDim2.new(0, 250, 1, 0),
        Position = UDim2.new(0, 24, 0, 0),
        BackgroundTransparency = 1,
        TextXAlignment = Enum.TextXAlignment.Left
    })
    
    local CloseBtn = Create("TextButton", {
        Parent = Topbar,
        Text = "",
        Size = UDim2.new(0, 32, 0, 32),
        Position = UDim2.new(1, -44, 0.5, -16),
        BackgroundColor3 = Theme.Main,
        AutoButtonColor = false
    })
    Create("UICorner", {Parent = CloseBtn, CornerRadius = UDim.new(0, 8)})
    local CloseStroke = Create("UIStroke", {Parent = CloseBtn, Color = Theme.Stroke, Thickness = 1.5})
    
    local CloseIcon = Create("ImageLabel", {
        Parent = CloseBtn,
        Size = UDim2.new(0, 14, 0, 14),
        Position = UDim2.new(0.5, -7, 0.5, -7),
        BackgroundTransparency = 1,
        Image = "rbxassetid://6031094678", -- Cross icon
        ImageColor3 = Theme.Text
    })

    CloseBtn.MouseEnter:Connect(function() 
        Library:Tween(CloseBtn, {BackgroundColor3 = Color3.fromRGB(255, 235, 235)}, 0.2)
        Library:Tween(CloseStroke, {Color = Color3.fromRGB(255, 100, 100)}, 0.2)
        Library:Tween(CloseIcon, {ImageColor3 = Color3.fromRGB(255, 50, 50)}, 0.2)
    end)
    CloseBtn.MouseLeave:Connect(function() 
        Library:Tween(CloseBtn, {BackgroundColor3 = Theme.Main}, 0.2)
        Library:Tween(CloseStroke, {Color = Theme.Stroke}, 0.2)
        Library:Tween(CloseIcon, {ImageColor3 = Theme.Text}, 0.2)
    end)
    CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)
    
    Library:MakeDraggable(Sidebar, Main)
    Library:MakeDraggable(Topbar, Main)

    -- Toggle UI Button (Outside)
    local ToggleBtn = Create("ImageButton", {
        Parent = ScreenGui,
        Size = UDim2.new(0, 44, 0, 44),
        Position = UDim2.new(0, 30, 0.5, -22),
        BackgroundColor3 = Theme.Main,
        Image = "rbxassetid://133979080007875", -- Change if needed
        ImageColor3 = Theme.Text
    })
    Create("UICorner", {Parent = ToggleBtn, CornerRadius = UDim.new(0, 10)})
    Create("UIStroke", {Parent = ToggleBtn, Color = Theme.Stroke, Thickness = 1.5})
    
    ToggleBtn.MouseEnter:Connect(function() Library:Tween(ToggleBtn, {ImageColor3 = Theme.Accent}, 0.2) end)
    ToggleBtn.MouseLeave:Connect(function() Library:Tween(ToggleBtn, {ImageColor3 = Theme.Text}, 0.2) end)
    ToggleBtn.MouseButton1Click:Connect(function() Main.Visible = not Main.Visible end)
    Library:MakeDraggable(ToggleBtn, ToggleBtn)

    --// Tab System
    local Tabs = {}
    local FirstPage = true
    
    function Tabs:T(Name)
        local Page = Create("ScrollingFrame", {
            Parent = Pages,
            Name = Name,
            Size = UDim2.new(1, 0, 1, -70),
            Position = UDim2.new(0, 0, 0, 70),
            BackgroundTransparency = 1,
            Visible = false,
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Theme.Stroke,
            BorderSizePixel = 0,
            CanvasSize = UDim2.new(0, 0, 0, 0)
        })
        Create("UIPadding", {Parent = Page, PaddingTop = UDim.new(0, 10), PaddingLeft = UDim.new(0, 24), PaddingRight = UDim.new(0, 24), PaddingBottom = UDim.new(0, 20)})
        local PageList = Create("UIListLayout", {
            Parent = Page,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Padding = UDim.new(0, 12)
        })
        
        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 30)
        end)

        -- Tab Button
        local TabBtn = Create("TextButton", {
            Parent = TabContainer,
            Size = UDim2.new(1, 0, 0, 36),
            BackgroundColor3 = Theme.Secondary,
            BackgroundTransparency = 1,
            Text = "",
            AutoButtonColor = false
        })
        Create("UICorner", {Parent = TabBtn, CornerRadius = UDim.new(0, 8)})
        
        local TabLabel = Create("TextLabel", {
            Parent = TabBtn,
            Text = Name,
            Font = Theme.Font,
            TextSize = 14,
            TextColor3 = Theme.TextDark,
            Size = UDim2.new(1, -20, 1, 0),
            Position = UDim2.new(0, 12, 0, 0),
            BackgroundTransparency = 1,
            TextXAlignment = Enum.TextXAlignment.Left
        })
        
        -- Active Indicator (Small dot or line)
        local TabInd = Create("Frame", {
            Parent = TabBtn,
            BackgroundColor3 = Theme.Accent,
            Size = UDim2.new(0, 4, 0, 16),
            Position = UDim2.new(0, 0, 0.5, -8),
            BackgroundTransparency = 1 
        })
        Create("UICorner", {Parent = TabInd, CornerRadius = UDim.new(0, 2)})

        local function Activate()
            for _, v in pairs(Pages:GetChildren()) do v.Visible = false end
            Page.Visible = true
            CurrentTabLabel.Text = Name
            
            for _, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    Library:Tween(v:FindFirstChild("TextLabel"), {TextColor3 = Theme.TextDark, Position = UDim2.new(0, 12, 0, 0)}, 0.2)
                    Library:Tween(v, {BackgroundTransparency = 1}, 0.2)
                end
            end
            
            -- Active State
            Library:Tween(TabLabel, {TextColor3 = Theme.Text, Position = UDim2.new(0, 16, 0, 0)}, 0.2)
            Library:Tween(TabBtn, {BackgroundTransparency = 0, BackgroundColor3 = Theme.Main}, 0.2) -- Slight contrast on active
        end
        
        TabBtn.MouseButton1Click:Connect(Activate)
        
        if FirstPage then
            Activate()
            FirstPage = false
        end
        
        --// Elements
        local Elements = {}
        
        -- Note: The original code returned Elements for adding SECTIONS to the page.
        -- But inside AddSection it returned SectionElements for adding PARAGRAPHS etc.
        -- I must preserve this structure.
        
        function Elements:AddSection(SectionTitle)
             local SectionLabel = Create("TextLabel", {
                 Parent = Page,
                 Text = string.upper(SectionTitle),
                 Font = Theme.FontBold,
                 TextSize = 11,
                 TextColor3 = Theme.TextDark,
                 Size = UDim2.new(1, 0, 0, 24),
                 BackgroundTransparency = 1,
                 TextXAlignment = Enum.TextXAlignment.Left
             })
             
             local Container = Create("Frame", {
                 Parent = Page,
                 BackgroundColor3 = Color3.new(1,1,1),
                 BackgroundTransparency = 1,
                 Size = UDim2.new(1, 0, 0, 0),
                 AutomaticSize = Enum.AutomaticSize.Y
             })
             local CList = Create("UIListLayout", {Parent = Container, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 10)})
             
             local SectionElements = {}
             
             function SectionElements:AddParagraph(Config)
                 Config = Library:MakeConfig({Title = "Title", Content = "Content"}, Config or {})
                 
                 local PFrame = Create("Frame", {
                     Parent = Container,
                     BackgroundColor3 = Theme.Secondary,
                     Size = UDim2.new(1, 0, 0, 0),
                     AutomaticSize = Enum.AutomaticSize.Y
                 })
                 Create("UICorner", {Parent = PFrame, CornerRadius = UDim.new(0, 8)})
                 Create("UIStroke", {Parent = PFrame, Color = Theme.Stroke})
                 Create("UIPadding", {Parent = PFrame, PaddingTop=UDim.new(0,12), PaddingBottom=UDim.new(0,12), PaddingLeft=UDim.new(0,14), PaddingRight=UDim.new(0,14)})
                 
                 local PTitle = Create("TextLabel", {
                     Parent = PFrame,
                     Text = Config.Title,
                     Font = Theme.FontBold,
                     TextSize = 14,
                     TextColor3 = Theme.Text,
                     Size = UDim2.new(1, 0, 0, 20),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 local PDesc = Create("TextLabel", {
                     Parent = PFrame,
                     Text = Config.Content,
                     Font = Theme.Font,
                     TextSize = 13,
                     TextColor3 = Theme.TextDark,
                     Size = UDim2.new(1, 0, 0, 0),
                     AutomaticSize = Enum.AutomaticSize.Y,
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left,
                     TextWrapped = true,
                     Position = UDim2.new(0, 0, 0, 24)
                 })
                 
                 local Funcs = {}
                 function Funcs:SetTitle(t) PTitle.Text = t end
                 function Funcs:SetDesc(d) PDesc.Text = d end
                 return Funcs
             end
             
             function SectionElements:AddButton(Config)
                 Config = Library:MakeConfig({Title = "Button", Description = "", Callback = function() end}, Config or {})
                 
                 local Btn = Create("TextButton", {
                     Parent = Container,
                     Size = UDim2.new(1, 0, 0, 44),
                     BackgroundColor3 = Theme.Secondary,
                     Text = "",
                     AutoButtonColor = false
                 })
                 Create("UICorner", {Parent = Btn, CornerRadius = UDim.new(0, 8)})
                 local Stroke = Create("UIStroke", {Parent = Btn, Color = Theme.Stroke})
                 
                 local BTitle = Create("TextLabel", {
                     Parent = Btn,
                     Text = Config.Title,
                     Font = Theme.FontBold,
                     TextSize = 14,
                     TextColor3 = Theme.Text,
                     Size = UDim2.new(1, -40, 1, 0),
                     Position = UDim2.new(0, 14, 0, 0),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 local Icon = Create("ImageLabel", {
                     Parent = Btn,
                     Size = UDim2.new(0, 18, 0, 18),
                     Position = UDim2.new(1, -32, 0.5, -9),
                     Image = "rbxassetid://6031094678", -- Generic Icon or specific
                     ImageColor3 = Theme.TextDark,
                     BackgroundTransparency = 1
                 })
                 
                 Btn.MouseEnter:Connect(function()
                     Library:Tween(Btn, {BackgroundColor3 = Color3.fromRGB(240, 240, 240)}, 0.2)
                     Library:Tween(Stroke, {Color = Theme.Accent}, 0.2)
                     Library:Tween(Icon, {ImageColor3 = Theme.Accent}, 0.2)
                 end)
                 Btn.MouseLeave:Connect(function()
                     Library:Tween(Btn, {BackgroundColor3 = Theme.Secondary}, 0.2)
                     Library:Tween(Stroke, {Color = Theme.Stroke}, 0.2)
                     Library:Tween(Icon, {ImageColor3 = Theme.TextDark}, 0.2)
                 end)
                 
                 Btn.MouseButton1Click:Connect(function()
                     Library:Tween(Btn, {Size = UDim2.new(1, -4, 0, 42)}, 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out).Completed:Wait()
                     Library:Tween(Btn, {Size = UDim2.new(1, 0, 0, 44)}, 0.05, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
                     Config.Callback()
                 end)
             end
             
             function SectionElements:AddToggle(Config)
                 Config = Library:MakeConfig({Title = "Toggle", Description = "", Default = false, Callback = function() end}, Config or {})
                 
                 local Tog = Create("TextButton", {
                     Parent = Container,
                     Size = UDim2.new(1, 0, 0, 44),
                     BackgroundColor3 = Theme.Secondary,
                     Text = "",
                     AutoButtonColor = false
                 })
                 Create("UICorner", {Parent = Tog, CornerRadius = UDim.new(0, 8)})
                 local Stroke = Create("UIStroke", {Parent = Tog, Color = Theme.Stroke})
                 
                 local TTitle = Create("TextLabel", {
                     Parent = Tog,
                     Text = Config.Title,
                     Font = Theme.FontBold,
                     TextSize = 14,
                     TextColor3 = Theme.Text,
                     Size = UDim2.new(1, -70, 1, 0),
                     Position = UDim2.new(0, 14, 0, 0),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 local Switch = Create("Frame", {
                     Parent = Tog,
                     Size = UDim2.new(0, 40, 0, 22),
                     Position = UDim2.new(1, -54, 0.5, -11),
                     BackgroundColor3 = Config.Default and Theme.Accent or Color3.fromRGB(220, 220, 220)
                 })
                 Create("UICorner", {Parent = Switch, CornerRadius = UDim.new(1, 0)})
                 
                 local Dot = Create("Frame", {
                     Parent = Switch,
                     Size = UDim2.new(0, 18, 0, 18),
                     Position = Config.Default and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 2, 0.5, -9),
                     BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                 })
                 Create("UICorner", {Parent = Dot, CornerRadius = UDim.new(1, 0)})
                 
                 local State = Config.Default
                 
                 local function Update()
                    Config.Callback(State)
                    if State then
                        Library:Tween(Switch, {BackgroundColor3 = Theme.Accent}, 0.2)
                        Library:Tween(Dot, {Position = UDim2.new(1, -20, 0.5, -9)}, 0.2)
                        Library:Tween(Stroke, {Color = Theme.Accent}, 0.2)
                    else
                        Library:Tween(Switch, {BackgroundColor3 = Color3.fromRGB(220, 220, 220)}, 0.2)
                        Library:Tween(Dot, {Position = UDim2.new(0, 2, 0.5, -9)}, 0.2)
                        Library:Tween(Stroke, {Color = Theme.Stroke}, 0.2)
                    end
                 end
                 
                 Tog.MouseButton1Click:Connect(function()
                     State = not State
                     Update()
                 end)
                 
                 local Funcs = {}
                 function Funcs:Set(val) State = val Update() end
                 return Funcs
             end
             
             function SectionElements:AddSlider(Config)
                 Config = Library:MakeConfig({Title = "Slider", Description = "", Max = 100, Min = 0, Increment = 1, Default = 50, Callback = function() end}, Config or {})

                 local SFrame = Create("Frame", {
                     Parent = Container,
                     Size = UDim2.new(1, 0, 0, 60),
                     BackgroundColor3 = Theme.Secondary
                 })
                 Create("UICorner", {Parent = SFrame, CornerRadius = UDim.new(0, 8)})
                 Create("UIStroke", {Parent = SFrame, Color = Theme.Stroke})
                 
                 local STitle = Create("TextLabel", {
                     Parent = SFrame,
                     Text = Config.Title,
                     Font = Theme.FontBold,
                     TextSize = 14,
                     TextColor3 = Theme.Text,
                     Size = UDim2.new(1, -14, 0, 30),
                     Position = UDim2.new(0, 14, 0, 4),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 local ValLab = Create("TextLabel", {
                     Parent = SFrame,
                     Text = tostring(Config.Default),
                     Font = Theme.Font,
                     TextSize = 13,
                     TextColor3 = Theme.TextDark,
                     Size = UDim2.new(0, 50, 0, 30),
                     Position = UDim2.new(1, -64, 0, 4),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Right
                 })
                 
                 local Track = Create("TextButton", {
                     Parent = SFrame,
                     Size = UDim2.new(1, -28, 0, 4),
                     Position = UDim2.new(0, 14, 0, 42),
                     BackgroundColor3 = Color3.fromRGB(220, 220, 220),
                     Text = "",
                     AutoButtonColor = false
                 })
                 Create("UICorner", {Parent = Track, CornerRadius = UDim.new(1, 0)})
                 
                 local Fill = Create("Frame", {
                     Parent = Track,
                     Size = UDim2.new((Config.Default - Config.Min)/(Config.Max - Config.Min), 0, 1, 0),
                     BackgroundColor3 = Theme.Accent
                 })
                 Create("UICorner", {Parent = Fill, CornerRadius = UDim.new(1, 0)})
                 
                 local Knob = Create("Frame", {
                     Parent = Fill,
                     Size = UDim2.new(0, 14, 0, 14),
                     Position = UDim2.new(1, -7, 0.5, -7),
                     BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                 })
                 Create("UICorner", {Parent = Knob, CornerRadius = UDim.new(1, 0)})
                 Create("UIStroke", {Parent = Knob, Color = Theme.Stroke, Thickness = 2})
                 
                 local Dragging = false
                 local Value = Config.Default
                 
                 local function Update(input)
                     local pos = UDim2.new(math.clamp((input.Position.X - Track.AbsolutePosition.X) / Track.AbsoluteSize.X, 0, 1), 0, 1, 0)
                     local scaled = math.floor(((pos.X.Scale * (Config.Max - Config.Min)) + Config.Min) / Config.Increment + 0.5) * Config.Increment
                     if scaled > Config.Max then scaled = Config.Max end
                     if scaled < Config.Min then scaled = Config.Min end
                     
                     Value = scaled
                     ValLab.Text = tostring(Value)
                     Library:Tween(Fill, {Size = UDim2.new((Value - Config.Min)/(Config.Max - Config.Min), 0, 1, 0)}, 0.05)
                     Config.Callback(Value)
                 end
                 
                 Track.InputBegan:Connect(function(i) 
                     if i.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = true Update(i) end 
                 end)
                 UserInputService.InputChanged:Connect(function(i) 
                     if Dragging and i.UserInputType == Enum.UserInputType.MouseMovement then Update(i) end 
                 end)
                 UserInputService.InputEnded:Connect(function(i) 
                     if i.UserInputType == Enum.UserInputType.MouseButton1 then Dragging = false end 
                 end)
                 
                 local Funcs = {}
                 function Funcs:Set(v) Value = v Update({Position = Vector3.new(0,0,0)}) end
                 return Funcs
             end
             
             function SectionElements:AddInput(Config)
                 Config = Library:MakeConfig({Title = "Input", Description = "", PlaceHolder = "Type...", Default = "", Callback = function() end}, Config or {})
                 
                 local IFrame = Create("Frame", {
                     Parent = Container,
                     Size = UDim2.new(1, 0, 0, 50),
                     BackgroundColor3 = Theme.Secondary
                 })
                 Create("UICorner", {Parent = IFrame, CornerRadius = UDim.new(0, 8)})
                 local Stroke = Create("UIStroke", {Parent = IFrame, Color = Theme.Stroke})
                 
                 local ITitle = Create("TextLabel", {
                     Parent = IFrame,
                     Text = Config.Title,
                     Font = Theme.FontBold,
                     TextSize = 14,
                     TextColor3 = Theme.Text,
                     Size = UDim2.new(1, -140, 1, 0),
                     Position = UDim2.new(0, 14, 0, 0),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 local BoxContainer = Create("Frame", {
                     Parent = IFrame,
                     Size = UDim2.new(0, 140, 0, 32),
                     Position = UDim2.new(1, -154, 0.5, -16),
                     BackgroundColor3 = Theme.Main
                 })
                 Create("UICorner", {Parent = BoxContainer, CornerRadius = UDim.new(0, 6)})
                 local BStroke = Create("UIStroke", {Parent = BoxContainer, Color = Theme.Stroke})
                 
                 local Box = Create("TextBox", {
                     Parent = BoxContainer,
                     Size = UDim2.new(1, -16, 1, 0),
                     Position = UDim2.new(0, 8, 0, 0),
                     BackgroundTransparency = 1,
                     Text = Config.Default,
                     PlaceholderText = Config.PlaceHolder,
                     TextColor3 = Theme.Text,
                     PlaceholderColor3 = Theme.TextDark,
                     Font = Theme.Font,
                     TextSize = 13,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 Box.Focused:Connect(function() 
                     Library:Tween(BStroke, {Color = Theme.Accent}, 0.2) 
                     Library:Tween(Stroke, {Color = Theme.Accent}, 0.2) 
                 end)
                 Box.FocusLost:Connect(function() 
                     Library:Tween(BStroke, {Color = Theme.Stroke}, 0.2) 
                     Library:Tween(Stroke, {Color = Theme.Stroke}, 0.2)
                     Config.Callback(Box.Text)
                 end)
             end
             
             function SectionElements:AddDropdown(Config)
                 Config = Library:MakeConfig({Title = "Dropdown", Description = "", Values = {}, Default = "", Multi = false, Callback = function() end}, Config or {})
                 
                 local DFrame = Create("Frame", {
                     Parent = Container,
                     Size = UDim2.new(1, 0, 0, 44),
                     BackgroundColor3 = Theme.Secondary,
                     ClipsDescendants = true
                 })
                 Create("UICorner", {Parent = DFrame, CornerRadius = UDim.new(0, 8)})
                 local Stroke = Create("UIStroke", {Parent = DFrame, Color = Theme.Stroke})
                 
                 local DTitle = Create("TextLabel", {
                     Parent = DFrame,
                     Text = Config.Title,
                     Font = Theme.FontBold,
                     TextSize = 14,
                     TextColor3 = Theme.Text,
                     Size = UDim2.new(1, -40, 0, 44),
                     Position = UDim2.new(0, 14, 0, 0),
                     BackgroundTransparency = 1,
                     TextXAlignment = Enum.TextXAlignment.Left
                 })
                 
                 local Arrow = Create("ImageLabel", {
                     Parent = DFrame,
                     Size = UDim2.new(0, 20, 0, 20),
                     Position = UDim2.new(1, -34, 0, 12),
                     Image = "rbxassetid://6031090990",
                     ImageColor3 = Theme.TextDark,
                     BackgroundTransparency = 1
                 })
                 
                 local OpenBtn = Create("TextButton", {
                     Parent = DFrame,
                     Size = UDim2.new(1, 0, 0, 44),
                     BackgroundTransparency = 1,
                     Text = ""
                 })
                 
                 local ItemScroll = Create("ScrollingFrame", {
                     Parent = DFrame,
                     Size = UDim2.new(1, 0, 0, 110),
                     Position = UDim2.new(0, 0, 0, 48),
                     BackgroundTransparency = 1,
                     BorderSizePixel = 0,
                     ScrollBarThickness = 2,
                     ScrollBarImageColor3 = Theme.Stroke
                 })
                 local IList = Create("UIListLayout", {Parent = ItemScroll, SortOrder = Enum.SortOrder.LayoutOrder, Padding = UDim.new(0, 4)})
                 Create("UIPadding", {Parent = ItemScroll, PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10)})
                 
                 local Opened = false
                 local Selection = Config.Multi and (type(Config.Default) == "table" and Config.Default or {}) or {Config.Default}
                 
                 local function Refresh()
                      for _,v in pairs(ItemScroll:GetChildren()) do if v:IsA("TextButton") then v:Destroy() end end
                      
                      for _, val in pairs(Config.Values) do
                           local Item = Create("TextButton", {
                               Parent = ItemScroll,
                               Size = UDim2.new(1, 0, 0, 30),
                               BackgroundColor3 = Theme.Main,
                               Text = "  "..val,
                               TextColor3 = Theme.TextDark,
                               Font = Theme.Font,
                               TextSize = 13,
                               TextXAlignment = Enum.TextXAlignment.Left,
                               AutoButtonColor = false
                           })
                           Create("UICorner", {Parent = Item, CornerRadius = UDim.new(0, 6)})
                           
                           local Selected = (Config.Multi and table.find(Selection, val)) or (not Config.Multi and Selection[1] == val)
                           if Selected then 
                               Item.TextColor3 = Theme.Accent 
                               Item.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
                               Item.Font = Theme.FontBold
                           end
                           
                           -- Hover effect for dropdown items
                           Item.MouseEnter:Connect(function()
                               if not Selected then
                                   Library:Tween(Item, {BackgroundColor3 = Color3.fromRGB(250, 250, 250)}, 0.1)
                               end
                           end)
                           Item.MouseLeave:Connect(function()
                               if not Selected then
                                   Library:Tween(Item, {BackgroundColor3 = Theme.Main}, 0.1)
                               end
                           end)

                           Item.MouseButton1Click:Connect(function()
                               if Config.Multi then
                                   if table.find(Selection, val) then
                                       table.remove(Selection, table.find(Selection, val))
                                   else
                                       table.insert(Selection, val)
                                   end
                               else
                                   Selection = {val}
                                   Opened = false
                                   Library:Tween(DFrame, {Size = UDim2.new(1, 0, 0, 44)}, 0.3)
                                   Library:Tween(Arrow, {Rotation = 0}, 0.3)
                                   DTitle.Text = Config.Title .. ": " .. val
                               end
                               Config.Callback(Selection)
                               Refresh()
                           end)
                      end
                      ItemScroll.CanvasSize = UDim2.new(0, 0, 0, IList.AbsoluteContentSize.Y + 10)
                 end
                 
                 OpenBtn.MouseButton1Click:Connect(function()
                     Opened = not Opened
                     Refresh()
                     if Opened then
                         Library:Tween(DFrame, {Size = UDim2.new(1, 0, 0, 160)}, 0.3)
                         Library:Tween(Arrow, {Rotation = 180}, 0.3)
                         Library:Tween(Stroke, {Color = Theme.Accent}, 0.3)
                     else
                         Library:Tween(DFrame, {Size = UDim2.new(1, 0, 0, 44)}, 0.3)
                         Library:Tween(Arrow, {Rotation = 0}, 0.3)
                         Library:Tween(Stroke, {Color = Theme.Stroke}, 0.3)
                     end
                 end)
                 
                 if not Config.Multi and Config.Default ~= "" then
                      DTitle.Text = Config.Title .. ": " .. Config.Default
                 end
                 
                 local Funcs = {}
                 function Funcs:Refresh(vals) Config.Values = vals Refresh() end
                 function Funcs:Set(v) Selection = type(v)=="table" and v or {v} Config.Callback(Selection) Refresh() end
                 return Funcs
             end
             
             return SectionElements
        end
        return Elements
    end
    return Tabs
end

return Library
