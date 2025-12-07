-- VexHub UI Library - Optimized Version
-- Cleanup existing instances
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("VexHub") and CoreGui:FindFirstChild("ScreenGui") then
    CoreGui.VexHub:Destroy()
    CoreGui.ScreenGui:Destroy()
end

-- Global color scheme
_G.Primary = Color3.fromRGB(100, 100, 100)
_G.Dark = Color3.fromRGB(22, 22, 26)
_G.Third = Color3.fromRGB(255, 255, 255)

-- Services
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local Player = Players.LocalPlayer

-- Utility Functions
local function CreateRounded(parent, size)
    local corner = Instance.new("UICorner")
    corner.Name = "Rounded"
    corner.CornerRadius = UDim.new(0, size)
    corner.Parent = parent
    return corner
end

local function CreateTween(object, info, properties)
    return TweenService:Create(object, info, properties)
end

local function MakeDraggable(topbar, object)
    local dragging, dragInput, dragStart, startPos
    
    local function update(input)
        local delta = input.Position - dragStart
        local pos = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
        CreateTween(object, TweenInfo.new(0.15), {Position = pos}):Play()
    end
    
    topbar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = object.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topbar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or 
           input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end

-- Config System
local Folder = "VexHub"
local SubFolder = "VexHub/Config"
local FilePath = SubFolder .. "/" .. Player.Name .. ".json"

local SettingsLib = {
    SaveSettings = true,
    LoadAnimation = true
}

getgenv().LoadConfig = function()
    if not (readfile and writefile and isfile and isfolder) then
        return warn("VexHub: Unsupported Executor")
    end
    
    if not isfolder(Folder) then makefolder(Folder) end
    if not isfolder(SubFolder) then makefolder(SubFolder) end
    
    if not isfile(FilePath) then
        writefile(FilePath, HttpService:JSONEncode(SettingsLib))
        print("VexHub: Config file created")
        return
    end
    
    local success, decoded = pcall(function()
        return HttpService:JSONDecode(readfile(FilePath))
    end)
    
    if success and decoded then
        for k, v in pairs(decoded) do
            SettingsLib[k] = v
        end
        print("VexHub: Config Loaded!")
    else
        warn("VexHub: Failed to decode config")
    end
end

getgenv().SaveConfig = function()
    if not (readfile and writefile and isfile and isfolder) then
        return warn("VexHub: Unsupported Executor")
    end
    
    if not isfolder(Folder) then makefolder(Folder) end
    if not isfolder(SubFolder) then makefolder(SubFolder) end
    
    writefile(FilePath, HttpService:JSONEncode(SettingsLib))
    print("VexHub: Config Saved!")
end

getgenv().LoadConfig()

-- Toggle Button
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local OutlineButton = Instance.new("Frame")
OutlineButton.Name = "OutlineButton"
OutlineButton.Parent = ScreenGui
OutlineButton.BackgroundColor3 = _G.Dark
OutlineButton.Position = UDim2.new(0, 10, 0, 10)
OutlineButton.Size = UDim2.new(0, 50, 0, 50)
CreateRounded(OutlineButton, 12)

local ImageButton = Instance.new("ImageButton")
ImageButton.Parent = OutlineButton
ImageButton.Position = UDim2.new(0.5, 0, 0.5, 0)
ImageButton.Size = UDim2.new(0, 40, 0, 40)
ImageButton.AnchorPoint = Vector2.new(0.5, 0.5)
ImageButton.BackgroundColor3 = _G.Dark
ImageButton.ImageColor3 = Color3.fromRGB(250, 250, 250)
ImageButton.Image = "rbxassetid://133979080007875"
ImageButton.AutoButtonColor = false
CreateRounded(ImageButton, 10)

MakeDraggable(ImageButton, OutlineButton)

ImageButton.MouseButton1Click:Connect(function()
    local vexHub = CoreGui:FindFirstChild("VexHub")
    if vexHub then
        vexHub.Enabled = not vexHub.Enabled
    end
end)

-- Notification System
local NotificationFrame = Instance.new("ScreenGui")
NotificationFrame.Name = "NotificationFrame"
NotificationFrame.Parent = CoreGui
NotificationFrame.ZIndexBehavior = Enum.ZIndexBehavior.Global

local NotificationList = {}
local MAX_NOTIFICATIONS = 5
local NOTIFY_COOLDOWN = 1.5
local lastNotifyTime = 0

local function RemoveOldestNotification()
    if #NotificationList > 0 then
        local removed = table.remove(NotificationList, 1)
        removed[1]:TweenPosition(
            UDim2.new(0.5, 0, -0.2, 0), 
            "Out", "Quad", 0.4, true, 
            function() removed[1]:Destroy() end
        )
    end
end

-- Main Library
local VexHub = {}

function VexHub:Notify(desc, duration)
    duration = duration or 1.5
    
    if tick() - lastNotifyTime < NOTIFY_COOLDOWN then return end
    lastNotifyTime = tick()
    
    -- Check for duplicates
    for _, v in ipairs(NotificationList) do
        if v[2] == desc then return end
    end
    
    if #NotificationList >= MAX_NOTIFICATIONS then
        RemoveOldestNotification()
    end
    
    spawn(function()
        wait(duration)
        RemoveOldestNotification()
    end)
    
    local OutlineFrame = Instance.new("Frame")
    OutlineFrame.Name = "OutlineFrame"
    OutlineFrame.Parent = NotificationFrame
    OutlineFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OutlineFrame.AnchorPoint = Vector2.new(0.5, 1)
    OutlineFrame.BackgroundTransparency = 0.4
    OutlineFrame.Position = UDim2.new(0.5, 0, -0.2, 0)
    OutlineFrame.Size = UDim2.new(0, 412, 0, 72)
    CreateRounded(OutlineFrame, 12)
    
    local Frame = Instance.new("Frame")
    Frame.Parent = OutlineFrame
    Frame.AnchorPoint = Vector2.new(0.5, 0.5)
    Frame.BackgroundColor3 = _G.Dark
    Frame.BackgroundTransparency = 0.1
    Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    Frame.Size = UDim2.new(0, 400, 0, 60)
    CreateRounded(Frame, 10)
    
    local Icon = Instance.new("ImageLabel")
    Icon.Parent = Frame
    Icon.BackgroundTransparency = 1
    Icon.Position = UDim2.new(0, 8, 0, 8)
    Icon.Size = UDim2.new(0, 45, 0, 45)
    Icon.Image = "rbxassetid://133979080007875"
    
    local Title = Instance.new("TextLabel")
    Title.Parent = Frame
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0, 55, 0, 14)
    Title.Size = UDim2.new(0, 10, 0, 20)
    Title.Font = Enum.Font.GothamBold
    Title.Text = "VexHub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    
    local Desc = Instance.new("TextLabel")
    Desc.Parent = Frame
    Desc.BackgroundTransparency = 1
    Desc.Position = UDim2.new(0, 55, 0, 33)
    Desc.Size = UDim2.new(0, 10, 0, 10)
    Desc.Font = Enum.Font.GothamSemibold
    Desc.TextTransparency = 0.3
    Desc.Text = desc
    Desc.TextColor3 = Color3.fromRGB(200, 200, 200)
    Desc.TextSize = 12
    Desc.TextXAlignment = Enum.TextXAlignment.Left
    
    OutlineFrame:TweenPosition(
        UDim2.new(0.5, 0, 0.1 + (#NotificationList) * 0.1, 0), 
        "Out", "Quad", 0.4, true
    )
    
    table.insert(NotificationList, {OutlineFrame, desc})
end

function VexHub:StartLoad()
    local Loader = Instance.new("ScreenGui")
    Loader.Parent = CoreGui
    Loader.ZIndexBehavior = Enum.ZIndexBehavior.Global
    Loader.DisplayOrder = 1000
    
    local LoaderFrame = Instance.new("Frame")
    LoaderFrame.Parent = Loader
    LoaderFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    LoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    LoaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    LoaderFrame.Size = UDim2.new(1.5, 0, 1.5, 0)
    LoaderFrame.BorderSizePixel = 0
    
    local MainLoaderFrame = Instance.new("Frame")
    MainLoaderFrame.Parent = LoaderFrame
    MainLoaderFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
    MainLoaderFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainLoaderFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainLoaderFrame.Size = UDim2.new(0.5, 0, 0.5, 0)
    MainLoaderFrame.BorderSizePixel = 0
    
    local TitleLoader = Instance.new("TextLabel")
    TitleLoader.Parent = MainLoaderFrame
    TitleLoader.Text = "VexHub"
    TitleLoader.Font = Enum.Font.FredokaOne
    TitleLoader.TextSize = 50
    TitleLoader.TextColor3 = Color3.fromRGB(255, 255, 255)
    TitleLoader.BackgroundTransparency = 1
    TitleLoader.AnchorPoint = Vector2.new(0.5, 0.5)
    TitleLoader.Position = UDim2.new(0.5, 0, 0.3, 0)
    TitleLoader.Size = UDim2.new(0.8, 0, 0.2, 0)
    
    local DescriptionLoader = Instance.new("TextLabel")
    DescriptionLoader.Parent = MainLoaderFrame
    DescriptionLoader.Text = "Loading.."
    DescriptionLoader.Font = Enum.Font.Gotham
    DescriptionLoader.TextSize = 15
    DescriptionLoader.TextColor3 = Color3.fromRGB(255, 255, 255)
    DescriptionLoader.BackgroundTransparency = 1
    DescriptionLoader.AnchorPoint = Vector2.new(0.5, 0.5)
    DescriptionLoader.Position = UDim2.new(0.5, 0, 0.6, 0)
    DescriptionLoader.Size = UDim2.new(0.8, 0, 0.2, 0)
    
    local LoadingBarBackground = Instance.new("Frame")
    LoadingBarBackground.Parent = MainLoaderFrame
    LoadingBarBackground.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    LoadingBarBackground.AnchorPoint = Vector2.new(0.5, 0.5)
    LoadingBarBackground.Position = UDim2.new(0.5, 0, 0.7, 0)
    LoadingBarBackground.Size = UDim2.new(0.7, 0, 0.05, 0)
    LoadingBarBackground.BorderSizePixel = 0
    LoadingBarBackground.ZIndex = 2
    CreateRounded(LoadingBarBackground, 20)
    
    local LoadingBar = Instance.new("Frame")
    LoadingBar.Parent = LoadingBarBackground
    LoadingBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    LoadingBar.Size = UDim2.new(0, 0, 1, 0)
    LoadingBar.ZIndex = 3
    CreateRounded(LoadingBar, 20)
    
    local running = true
    local barTween1 = CreateTween(LoadingBar, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0.25, 0, 1, 0)
    })
    
    local barTween2 = CreateTween(LoadingBar, TweenInfo.new(1, Enum.EasingStyle.Linear), {
        Size = UDim2.new(1, 0, 1, 0)
    })
    
    barTween1:Play()
    
    function VexHub:Loaded()
        barTween2:Play()
    end
    
    barTween1.Completed:Connect(function()
        barTween2.Completed:Connect(function()
            wait(1)
            running = false
            DescriptionLoader.Text = "Loaded!"
            wait(0.5)
            Loader:Destroy()
        end)
    end)
    
    spawn(function()
        local dotCount = 0
        while running do
            dotCount = (dotCount + 1) % 4
            DescriptionLoader.Text = "Please wait" .. string.rep(".", dotCount)
            wait(0.5)
        end
    end)
end

function VexHub:SaveSettings()
    return SettingsLib.SaveSettings
end

function VexHub:LoadAnimation()
    return SettingsLib.LoadAnimation
end

function VexHub:Window(Config)
    assert(Config.SubTitle, "SubTitle is required")
    assert(Config.Title, "Title is required")
    assert(Config.Theme, "Theme is required")
    assert(Config.UiTransparency, "UiTransparency is required")
    
    local WindowConfig = {
        Size = Config.Size or UDim2.new(0, 600, 0, 400),
        TabWidth = Config.TabWidth or 150
    }
    
    -- Create main UI
    local VexHubGui = Instance.new("ScreenGui")
    VexHubGui.Name = "VexHub"
    VexHubGui.Parent = CoreGui
    VexHubGui.DisplayOrder = 999
    
    local OutlineMain = Instance.new("Frame")
    OutlineMain.Name = "OutlineMain"
    OutlineMain.Parent = VexHubGui
    OutlineMain.AnchorPoint = Vector2.new(0.5, 0.5)
    OutlineMain.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    OutlineMain.BackgroundTransparency = 0.6
    OutlineMain.Position = UDim2.new(0.5, 0, 0.45, 0)
    OutlineMain.Size = UDim2.new(0, 0, 0, 0)
    CreateRounded(OutlineMain, 15)
    
    local Main = Instance.new("Frame")
    Main.Name = "Main"
    Main.Parent = OutlineMain
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
    Main.BackgroundTransparency = Config.UiTransparency
    Main.Position = UDim2.new(0.5, 0, 0.5, 0)
    Main.Size = WindowConfig.Size
    CreateRounded(Main, 12)
    
    OutlineMain:TweenSize(
        UDim2.new(0, WindowConfig.Size.X.Offset + 15, 0, WindowConfig.Size.Y.Offset + 15),
        "Out", "Quad", 0.4, true
    )
    
    -- Theme background
    local BackgroundImage = Instance.new("ImageLabel")
    BackgroundImage.Parent = Main
    BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
    BackgroundImage.BackgroundTransparency = 1
    BackgroundImage.Image = Config.Theme
    BackgroundImage.ScaleType = Enum.ScaleType.Stretch
    BackgroundImage.ZIndex = 0
    CreateRounded(BackgroundImage, 12)
    
    -- Top bar
    local Top = Instance.new("Frame")
    Top.Name = "Top"
    Top.Parent = Main
    Top.BackgroundTransparency = 1
    Top.Size = UDim2.new(1, 0, 0, 40)
    
    local NameHub = Instance.new("TextLabel")
    NameHub.Parent = Top
    NameHub.BackgroundTransparency = 1
    NameHub.Position = UDim2.new(0, 15, 0.5, 0)
    NameHub.AnchorPoint = Vector2.new(0, 0.5)
    NameHub.Font = Enum.Font.GothamBold
    NameHub.Text = Config.Title
    NameHub.TextSize = 20
    NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
    NameHub.TextXAlignment = Enum.TextXAlignment.Left
    
    local nameSize = TextService:GetTextSize(
        NameHub.Text, NameHub.TextSize, NameHub.Font, 
        Vector2.new(math.huge, math.huge)
    )
    NameHub.Size = UDim2.new(0, nameSize.X, 0, 25)
    
    local SubTitle = Instance.new("TextLabel")
    SubTitle.Parent = NameHub
    SubTitle.BackgroundTransparency = 1
    SubTitle.Position = UDim2.new(0, nameSize.X + 8, 0.5, 0)
    SubTitle.AnchorPoint = Vector2.new(0, 0.5)
    SubTitle.Font = Enum.Font.Cartoon
    SubTitle.Text = Config.SubTitle
    SubTitle.TextSize = 15
    SubTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
    
    local subSize = TextService:GetTextSize(
        SubTitle.Text, SubTitle.TextSize, SubTitle.Font,
        Vector2.new(math.huge, math.huge)
    )
    SubTitle.Size = UDim2.new(0, subSize.X, 0, 25)
    
    -- Close button
    local CloseButton = Instance.new("ImageButton")
    CloseButton.Parent = Top
    CloseButton.BackgroundTransparency = 1
    CloseButton.AnchorPoint = Vector2.new(1, 0.5)
    CloseButton.Position = UDim2.new(1, -15, 0.5, 0)
    CloseButton.Size = UDim2.new(0, 20, 0, 20)
    CloseButton.Image = "rbxassetid://7743878857"
    CloseButton.ImageColor3 = Color3.fromRGB(245, 245, 245)
    
    CloseButton.MouseButton1Click:Connect(function()
        VexHubGui.Enabled = not VexHubGui.Enabled
    end)
    
    -- Tab container
    local Tab = Instance.new("Frame")
    Tab.Name = "Tab"
    Tab.Parent = Main
    Tab.BackgroundTransparency = 1
    Tab.Position = UDim2.new(0, 8, 0, Top.Size.Y.Offset)
    Tab.Size = UDim2.new(
        0, WindowConfig.TabWidth, 
        0, WindowConfig.Size.Y.Offset - Top.Size.Y.Offset - 8
    )
    
    local ScrollTab = Instance.new("ScrollingFrame")
    ScrollTab.Parent = Tab
    ScrollTab.Active = true
    ScrollTab.BackgroundTransparency = 1
    ScrollTab.Size = UDim2.new(1, 0, 1, 0)
    ScrollTab.ScrollBarThickness = 0
    
    local TabListLayout = Instance.new("UIListLayout")
    TabListLayout.Parent = ScrollTab
    TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    TabListLayout.Padding = UDim.new(0, 2)
    
    -- Page container
    local Page = Instance.new("Frame")
    Page.Name = "Page"
    Page.Parent = Main
    Page.BackgroundTransparency = 1
    Page.Position = UDim2.new(0, Tab.Size.X.Offset + 18, 0, Top.Size.Y.Offset)
    Page.Size = UDim2.new(
        0, WindowConfig.Size.X.Offset - Tab.Size.X.Offset - 25,
        0, WindowConfig.Size.Y.Offset - Top.Size.Y.Offset - 8
    )
    
    local MainPage = Instance.new("Frame")
    MainPage.Parent = Page
    MainPage.BackgroundTransparency = 1
    MainPage.Size = UDim2.new(1, 0, 1, 0)
    
    local PageList = Instance.new("Folder")
    PageList.Parent = MainPage
    
    local UIPageLayout = Instance.new("UIPageLayout")
    UIPageLayout.Parent = PageList
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.EasingDirection = Enum.EasingDirection.InOut
    UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
    UIPageLayout.TweenTime = 0
    UIPageLayout.GamepadInputEnabled = false
    UIPageLayout.ScrollWheelInputEnabled = false
    UIPageLayout.TouchInputEnabled = false
    
    MakeDraggable(Top, OutlineMain)
    
    -- Toggle with Insert key
    UserInputService.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Insert then
            VexHubGui.Enabled = not VexHubGui.Enabled
        end
    end)
    
    -- Auto-update canvas sizes
    RunService.Stepped:Connect(function()
        pcall(function()
            ScrollTab.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
        end)
    end)
    
    local WindowAPI = {}
    local firstTab = true
    
    function WindowAPI:Tab(text, icon)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = text .. "Unique"
        TabButton.Parent = ScrollTab
        TabButton.Text = ""
        TabButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        TabButton.BackgroundTransparency = 1
        TabButton.Size = UDim2.new(1, 0, 0, 35)
        CreateRounded(TabButton, 6)
        
        local SelectedTab = Instance.new("Frame")
        SelectedTab.Parent = TabButton
        SelectedTab.BackgroundColor3 = _G.Third
        SelectedTab.BackgroundTransparency = Config.UiTransparency
        SelectedTab.Size = UDim2.new(0, 3, 0, 0)
        SelectedTab.Position = UDim2.new(0, 0, 0.5, 0)
        SelectedTab.AnchorPoint = Vector2.new(0, 0.5)
        CreateRounded(SelectedTab, 100)
        
        local Title = Instance.new("TextLabel")
        Title.Parent = TabButton
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0, 30, 0.5, 0)
        Title.Size = UDim2.new(0, 100, 0, 30)
        Title.Font = Enum.Font.Roboto
        Title.Text = text
        Title.AnchorPoint = Vector2.new(0, 0.5)
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextTransparency = 0.4
        Title.TextSize = 14
        Title.TextXAlignment = Enum.TextXAlignment.Left
        
        local Icon = Instance.new("ImageLabel")
        Icon.Parent = TabButton
        Icon.BackgroundTransparency = 1
        Icon.ImageTransparency = 0.3
        Icon.Position = UDim2.new(0, 7, 0.5, 0)
        Icon.Size = UDim2.new(0, 15, 0, 15)
        Icon.AnchorPoint = Vector2.new(0, 0.5)
        Icon.Image = icon
        
        -- Page for this tab
        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Name = text .. "_Page"
        TabPage.Parent = PageList
        TabPage.Active = true
        TabPage.BackgroundTransparency = 1
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.ScrollBarThickness = 0
        
        local PageLayout = Instance.new("UIListLayout")
        PageLayout.Parent = TabPage
        PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
        PageLayout.Padding = UDim.new(0, 3)
        
        local PagePadding = Instance.new("UIPadding")
        PagePadding.Parent = TabPage
        
        -- Tab click handler
        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(ScrollTab:GetChildren()) do
                if v:IsA("TextButton") then
                    CreateTween(v, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
                    CreateTween(v.SelectedTab, TweenInfo.new(0.3), {Size = UDim2.new(0, 3, 0, 0)}):Play()
                    CreateTween(v:FindFirstChild("Icon") or v, TweenInfo.new(0.3), {ImageTransparency = 0.4}):Play()
                    CreateTween(v.Title, TweenInfo.new(0.3), {TextTransparency = 0.4}):Play()
                end
            end
            
            CreateTween(TabButton, TweenInfo.new(0.3), {BackgroundTransparency = Config.UiTransparency}):Play()
            CreateTween(SelectedTab, TweenInfo.new(0.3), {Size = UDim2.new(0, 3, 0, 15)}):Play()
            CreateTween(Icon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
            CreateTween(Title, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
            
            UIPageLayout:JumpTo(TabPage)
        end)
        
        -- Auto-select first tab
        if firstTab then
            firstTab = false
            task.wait()
            TabButton.MouseButton1Click:Fire()
        end
        
        -- Update canvas size
        RunService.Stepped:Connect(function()
            pcall(function()
                TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y)
            end)
        end)
        
        local TabAPI = {}
        
        function TabAPI:Button(text, callback)
            local Button = Instance.new("Frame")
            Button.Parent = TabPage
            Button.BackgroundTransparency = 1
            Button.Size = UDim2.new(1, 0, 0, 36)
            CreateRounded(Button, 5)
            
            local TextButton = Instance.new("TextButton")
            TextButton.Parent = Button
            TextButton.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            TextButton.BackgroundTransparency = Config.UiTransparency
            TextButton.AnchorPoint = Vector2.new(1, 0.5)
            TextButton.Position = UDim2.new(1, -1, 0.5, 0)
            TextButton.Size = UDim2.new(0, 25, 0, 25)
            TextButton.Text = ""
            CreateRounded(TextButton, 4)
            
            local Icon = Instance.new("ImageLabel")
            Icon.Parent = TextButton
            Icon.BackgroundTransparency = 1
            Icon.AnchorPoint = Vector2.new(0.5, 0.5)
            Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
            Icon.Size = UDim2.new(0, 15, 0, 15)
            Icon.Image = "rbxassetid://10734898355"
            Icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Button
            Label.BackgroundTransparency = 1
            Label.AnchorPoint = Vector2.new(0, 0.5)
            Label.Position = UDim2.new(0, 20, 0.5, 0)
            Label.Size = UDim2.new(1, -50, 1, 0)
            Label.Font = Enum.Font.Cartoon
            Label.Text = text
            Label.TextXAlignment = Enum.TextXAlignment.Left
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 15
            
            local Arrow = Instance.new("ImageLabel")
            Arrow.Parent = Button
            Arrow.BackgroundTransparency = 1
            Arrow.Position = UDim2.new(0, 0, 0.5, 0)
            Arrow.Size = UDim2.new(0, 15, 0, 15)
            Arrow.AnchorPoint = Vector2.new(0, 0.5)
            Arrow.Image = "rbxassetid://10709768347"
            Arrow.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            TextButton.MouseButton1Click:Connect(function()
                pcall(callback)
            end)
        end
        
        function TabAPI:Toggle(text, default, desc, callback)
            default = default or false
            local toggled = default
            
            local Button = Instance.new("TextButton")
            Button.Parent = TabPage
            Button.BackgroundColor3 = _G.Primary
            Button.BackgroundTransparency = Config.UiTransparency
            Button.Text = ""
            Button.AutoButtonColor = false
            CreateRounded(Button, 5)
            
            local Title = Instance.new("TextLabel")
            Title.Parent = Button
            Title.BackgroundTransparency = 1
            Title.Font = Enum.Font.Cartoon
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 15
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local Desc = Instance.new("TextLabel")
            Desc.Parent = Title
            Desc.BackgroundTransparency = 1
            Desc.Position = UDim2.new(0, 0, 0, 22)
            Desc.Size = UDim2.new(0, 280, 0, 16)
            Desc.Font = Enum.Font.Gotham
            Desc.Text = desc or ""
            Desc.TextColor3 = Color3.fromRGB(150, 150, 150)
            Desc.TextSize = 10
            Desc.TextXAlignment = Enum.TextXAlignment.Left
            
            if desc then
                Title.Position = UDim2.new(0, 15, 0.5, -5)
                Button.Size = UDim2.new(1, 0, 0, 46)
            else
                Title.Position = UDim2.new(0, 15, 0.5, 0)
                Title.Size = UDim2.new(1, 0, 0, 35)
                Desc.Visible = false
                Button.Size = UDim2.new(1, 0, 0, 36)
            end
            
            local ToggleFrame = Instance.new("Frame")
            ToggleFrame.Parent = Button
            ToggleFrame.BackgroundTransparency = 1
            ToggleFrame.Position = UDim2.new(1, -10, 0.5, 0)
            ToggleFrame.Size = UDim2.new(0, 35, 0, 20)
            ToggleFrame.AnchorPoint = Vector2.new(1, 0.5)
            CreateRounded(ToggleFrame, 10)
            
            local ToggleBg = Instance.new("TextButton")
            ToggleBg.Parent = ToggleFrame
            ToggleBg.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            ToggleBg.BackgroundTransparency = Config.UiTransparency
            ToggleBg.Size = UDim2.new(1, 0, 1, 0)
            ToggleBg.Text = ""
            ToggleBg.AutoButtonColor = false
            CreateRounded(ToggleBg, 10)
            
            local Circle = Instance.new("Frame")
            Circle.Parent = ToggleBg
            Circle.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Circle.BackgroundTransparency = Config.UiTransparency
            Circle.Position = UDim2.new(0, 3, 0.5, 0)
            Circle.Size = UDim2.new(0, 14, 0, 14)
            Circle.AnchorPoint = Vector2.new(0, 0.5)
            CreateRounded(Circle, 10)
            
            local function updateToggle(state)
                toggled = state
                if toggled then
                    Circle:TweenPosition(UDim2.new(0, 17, 0.5, 0), "Out", "Sine", 0.2, true)
                    CreateTween(ToggleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = _G.Third,
                        BackgroundTransparency = Config.UiTransparency
                    }):Play()
                else
                    Circle:TweenPosition(UDim2.new(0, 3, 0.5, 0), "Out", "Sine", 0.2, true)
                    CreateTween(ToggleBg, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
                        BackgroundColor3 = Color3.fromRGB(200, 200, 200),
                        BackgroundTransparency = Config.UiTransparency
                    }):Play()
                end
                pcall(callback, toggled)
            end
            
            ToggleBg.MouseButton1Click:Connect(function()
                updateToggle(not toggled)
            end)
            
            if default then
                updateToggle(true)
            end
        end
        
        function TabAPI:Dropdown(text, options, default, callback)
            local isDropping = false
            local activeItem = default
            
            local Dropdown = Instance.new("Frame")
            Dropdown.Parent = TabPage
            Dropdown.BackgroundColor3 = _G.Primary
            Dropdown.BackgroundTransparency = Config.UiTransparency
            Dropdown.Size = UDim2.new(1, 0, 0, 40)
            CreateRounded(Dropdown, 5)
            
            local Title = Instance.new("TextLabel")
            Title.Parent = Dropdown
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 15, 0, 5)
            Title.Size = UDim2.new(1, 0, 0, 30)
            Title.Font = Enum.Font.Cartoon
            Title.Text = text
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 15
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local SelectButton = Instance.new("TextButton")
            SelectButton.Parent = Dropdown
            SelectButton.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
            SelectButton.BackgroundTransparency = Config.UiTransparency
            SelectButton.Position = UDim2.new(1, -5, 0, 5)
            SelectButton.Size = UDim2.new(0, 100, 0, 30)
            SelectButton.AnchorPoint = Vector2.new(1, 0)
            SelectButton.Font = Enum.Font.GothamMedium
            SelectButton.Text = "   " .. (default or "Select")
            SelectButton.TextSize = 9
            SelectButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            SelectButton.TextXAlignment = Enum.TextXAlignment.Left
            SelectButton.AutoButtonColor = false
            CreateRounded(SelectButton, 5)
            
            local Arrow = Instance.new("ImageLabel")
            Arrow.Parent = Dropdown
            Arrow.BackgroundTransparency = 1
            Arrow.AnchorPoint = Vector2.new(1, 0)
            Arrow.Position = UDim2.new(1, -110, 0, 10)
            Arrow.Size = UDim2.new(0, 20, 0, 20)
            Arrow.Image = "rbxassetid://10709790948"
            Arrow.ImageColor3 = Color3.fromRGB(255, 255, 255)
            
            local DropFrame = Instance.new("Frame")
            DropFrame.Parent = Dropdown
            DropFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 26)
            DropFrame.BackgroundTransparency = Config.UiTransparency
            DropFrame.Position = UDim2.new(0, 5, 0, 40)
            DropFrame.Size = UDim2.new(1, -10, 0, 0)
            DropFrame.Visible = false
            DropFrame.ClipsDescendants = true
            CreateRounded(DropFrame, 5)
            
            local DropScroll = Instance.new("ScrollingFrame")
            DropScroll.Parent = DropFrame
            DropScroll.Active = true
            DropScroll.BackgroundTransparency = 1
            DropScroll.Position = UDim2.new(0, 0, 0, 10)
            DropScroll.Size = UDim2.new(1, 0, 0, 80)
            DropScroll.ScrollBarThickness = 3
            
            local DropLayout = Instance.new("UIListLayout")
            DropLayout.Parent = DropScroll
            DropLayout.SortOrder = Enum.SortOrder.LayoutOrder
            DropLayout.Padding = UDim.new(0, 1)
            
            local DropPadding = Instance.new("UIPadding")
            DropPadding.Parent = DropScroll
            DropPadding.PaddingLeft = UDim.new(0, 10)
            DropPadding.PaddingRight = UDim.new(0, 10)
            
            local function createItem(itemText)
                local Item = Instance.new("TextButton")
                Item.Parent = DropScroll
                Item.BackgroundColor3 = _G.Primary
                Item.BackgroundTransparency = 1
                Item.Size = UDim2.new(1, 0, 0, 30)
                Item.Font = Enum.Font.Nunito
                Item.Text = itemText
                Item.TextColor3 = Color3.fromRGB(255, 255, 255)
                Item.TextSize = 13
                Item.TextTransparency = 0.5
                Item.TextXAlignment = Enum.TextXAlignment.Left
                CreateRounded(Item, 5)
                
                local ItemPadding = Instance.new("UIPadding")
                ItemPadding.Parent = Item
                ItemPadding.PaddingLeft = UDim.new(0, 8)
                
                local Selected = Instance.new("Frame")
                Selected.Name = "Selected"
                Selected.Parent = Item
                Selected.BackgroundColor3 = _G.Third
                Selected.BackgroundTransparency = 1
                Selected.Size = UDim2.new(0, 3, 0.4, 0)
                Selected.Position = UDim2.new(0, -8, 0.5, 0)
                Selected.AnchorPoint = Vector2.new(0, 0.5)
                CreateRounded(Selected, 999)
                
                if itemText == activeItem then
                    Item.BackgroundTransparency = Config.UiTransparency
                    Item.TextTransparency = 0
                    Selected.BackgroundTransparency = Config.UiTransparency
                end
                
                Item.MouseButton1Click:Connect(function()
                    activeItem = itemText
                    SelectButton.Text = "   " .. itemText
                    
                    for _, v in pairs(DropScroll:GetChildren()) do
                        if v:IsA("TextButton") then
                            local sel = v:FindFirstChild("Selected")
                            if v.Text == activeItem then
                                v.BackgroundTransparency = Config.UiTransparency
                                v.TextTransparency = 0
                                if sel then sel.BackgroundTransparency = Config.UiTransparency end
                            else
                                v.BackgroundTransparency = 1
                                v.TextTransparency = 0.5
                                if sel then sel.BackgroundTransparency = 1 end
                            end
                        end
                    end
                    
                    pcall(callback, itemText)
                end)
            end
            
            for _, option in ipairs(options) do
                createItem(tostring(option))
            end
            
            if default then
                pcall(callback, default)
            end
            
            SelectButton.MouseButton1Click:Connect(function()
                isDropping = not isDropping
                
                if isDropping then
                    DropFrame.Visible = true
                    CreateTween(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 100)}):Play()
                    CreateTween(Dropdown, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 145)}):Play()
                    CreateTween(Arrow, TweenInfo.new(0.3), {Rotation = 180}):Play()
                else
                    CreateTween(DropFrame, TweenInfo.new(0.3), {Size = UDim2.new(1, -10, 0, 0)}):Play()
                    CreateTween(Dropdown, TweenInfo.new(0.3), {Size = UDim2.new(1, 0, 0, 40)}):Play()
                    CreateTween(Arrow, TweenInfo.new(0.3), {Rotation = 0}):Play()
                    task.wait(0.3)
                    DropFrame.Visible = false
                end
            end)
            
            RunService.Stepped:Connect(function()
                pcall(function()
                    DropScroll.CanvasSize = UDim2.new(0, 0, 0, DropLayout.AbsoluteContentSize.Y)
                end)
            end)
            
            local DropdownAPI = {}
            
            function DropdownAPI:Add(item)
                createItem(tostring(item))
            end
            
            function DropdownAPI:Clear()
                SelectButton.Text = "   Select"
                isDropping = false
                DropFrame.Visible = false
                activeItem = nil
                
                for _, v in pairs(DropScroll:GetChildren()) do
                    if v:IsA("TextButton") then
                        v:Destroy()
                    end
                end
            end
            
            return DropdownAPI
        end
        
        function TabAPI:Slider(text, min, max, default, callback)
            local value = default or min
            
            local Slider = Instance.new("Frame")
            Slider.Parent = TabPage
            Slider.BackgroundTransparency = 1
            Slider.Size = UDim2.new(1, 0, 0, 35)
            CreateRounded(Slider, 5)
            
            local SliderBg = Instance.new("Frame")
            SliderBg.Parent = Slider
            SliderBg.BackgroundColor3 = _G.Primary
            SliderBg.BackgroundTransparency = Config.UiTransparency
            SliderBg.Size = UDim2.new(1, 0, 0, 35)
            CreateRounded(SliderBg, 5)
            
            local Title = Instance.new("TextLabel")
            Title.Parent = SliderBg
            Title.BackgroundTransparency = 1
            Title.Position = UDim2.new(0, 15, 0.5, 0)
            Title.Size = UDim2.new(1, 0, 0, 30)
            Title.Font = Enum.Font.Cartoon
            Title.Text = text
            Title.AnchorPoint = Vector2.new(0, 0.5)
            Title.TextColor3 = Color3.fromRGB(255, 255, 255)
            Title.TextSize = 15
            Title.TextXAlignment = Enum.TextXAlignment.Left
            
            local Bar = Instance.new("Frame")
            Bar.Parent = SliderBg
            Bar.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            Bar.BackgroundTransparency = Config.UiTransparency
            Bar.Size = UDim2.new(0, 100, 0, 4)
            Bar.Position = UDim2.new(1, -10, 0.5, 0)
            Bar.AnchorPoint = Vector2.new(1, 0.5)
            CreateRounded(Bar, 5)
            
            local Fill = Instance.new("Frame")
            Fill.Parent = Bar
            Fill.BackgroundColor3 = _G.Third
            Fill.BackgroundTransparency = Config.UiTransparency
            Fill.Size = UDim2.new((value - min) / (max - min), 0, 0, 4)
            CreateRounded(Fill, 5)
            
            local Circle = Instance.new("Frame")
            Circle.Parent = Fill
            Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Circle.Position = UDim2.new(1, 0, 0, -5)
            Circle.AnchorPoint = Vector2.new(0.5, 0)
            Circle.Size = UDim2.new(0, 13, 0, 13)
            CreateRounded(Circle, 100)
            
            local ValueLabel = Instance.new("TextLabel")
            ValueLabel.Parent = Bar
            ValueLabel.BackgroundTransparency = 1
            ValueLabel.Position = UDim2.new(0, -38, 0.5, 0)
            ValueLabel.Size = UDim2.new(0, 30, 0, 30)
            ValueLabel.Font = Enum.Font.GothamMedium
            ValueLabel.Text = tostring(value)
            ValueLabel.AnchorPoint = Vector2.new(0, 0.5)
            ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            ValueLabel.TextSize = 12
            ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
            
            local dragging = false
            
            local function updateSlider(input)
                local percent = math.clamp((input.Position.X - Bar.AbsolutePosition.X) / Bar.AbsoluteSize.X, 0, 1)
                value = math.floor(min + (max - min) * percent)
                ValueLabel.Text = tostring(value)
                Fill.Size = UDim2.new(percent, 0, 0, 4)
                pcall(callback, value)
            end
            
            Circle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            Bar.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                    updateSlider(input)
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or 
                   input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or 
                   input.UserInputType == Enum.UserInputType.Touch) then
                    updateSlider(input)
                end
            end)
            
            if default then
                pcall(callback, value)
            end
        end
        
        function TabAPI:Textbox(text, disappear, callback)
            local Textbox = Instance.new("Frame")
            Textbox.Parent = TabPage
            Textbox.BackgroundColor3 = _G.Primary
            Textbox.BackgroundTransparency = Config.UiTransparency
            Textbox.Size = UDim2.new(1, 0, 0, 35)
            CreateRounded(Textbox, 5)
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Textbox
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 15, 0.5, 0)
            Label.Size = UDim2.new(1, 0, 0, 35)
            Label.Font = Enum.Font.Nunito
            Label.Text = text
            Label.AnchorPoint = Vector2.new(0, 0.5)
            Label.TextColor3 = Color3.fromRGB(255, 255, 255)
            Label.TextSize = 15
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local Input = Instance.new("TextBox")
            Input.Parent = Textbox
            Input.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
            Input.BackgroundTransparency = Config.UiTransparency
            Input.Position = UDim2.new(1, -5, 0.5, 0)
            Input.AnchorPoint = Vector2.new(1, 0.5)
            Input.Size = UDim2.new(0, 80, 0, 25)
            Input.Font = Enum.Font.Gotham
            Input.Text = ""
            Input.TextColor3 = Color3.fromRGB(225, 225, 225)
            Input.TextSize = 11
            Input.ClearTextOnFocus = false
            CreateRounded(Input, 5)
            
            Input.FocusLost:Connect(function()
                pcall(callback, Input.Text)
                if disappear then
                    Input.Text = ""
                end
            end)
            
            local TextboxAPI = {}
            
            function TextboxAPI:SetValue(txt)
                Input.Text = tostring(txt)
            end
            
            function TextboxAPI:GetValue()
                return Input.Text
            end
            
            return TextboxAPI
        end
        
        function TabAPI:Label(text)
            local Frame = Instance.new("Frame")
            Frame.Parent = TabPage
            Frame.BackgroundTransparency = 1
            Frame.Size = UDim2.new(1, 0, 0, 30)
            
            local Label = Instance.new("TextLabel")
            Label.Parent = Frame
            Label.BackgroundTransparency = 1
            Label.Position = UDim2.new(0, 30, 0.5, 0)
            Label.Size = UDim2.new(1, -30, 0, 30)
            Label.Font = Enum.Font.Nunito
            Label.Text = text
            Label.AnchorPoint = Vector2.new(0, 0.5)
            Label.TextColor3 = Color3.fromRGB(225, 225, 225)
            Label.TextSize = 15
            Label.TextXAlignment = Enum.TextXAlignment.Left
            
            local Icon = Instance.new("ImageLabel")
            Icon.Parent = Frame
            Icon.BackgroundTransparency = 1
            Icon.Position = UDim2.new(0, 10, 0.5, 0)
            Icon.Size = UDim2.new(0, 14, 0, 14)
            Icon.AnchorPoint = Vector2.new(0, 0.5)
            Icon.Image = "rbxassetid://10723415903"
            Icon.ImageColor3 = Color3.fromRGB(200, 200, 200)
            
            local LabelAPI = {}
            
            function LabelAPI:Set(newText)
                Label.Text = newText
            end
            
            return LabelAPI
        end
        
        function TabAPI:Separator(text)
            local Separator = Instance.new("Frame")
            Separator.Parent = TabPage
            Separator.BackgroundTransparency = 1
            Separator.Size = UDim2.new(1, 0, 0, 36)
            
            local Left = Instance.new("TextLabel")
            Left.Parent = Separator
            Left.BackgroundTransparency = 1
            Left.AnchorPoint = Vector2.new(0, 0.5)
            Left.Position = UDim2.new(0, 0, 0.5, 0)
            Left.Size = UDim2.new(0, 20, 0, 36)
            Left.Font = Enum.Font.GothamBold
            Left.RichText = true
            Left.Text = "〉<font color=\"rgb(255, 255, 255)\">〉</font>"
            Left.TextColor3 = Color3.fromRGB(255, 255, 255)
            Left.TextSize = 14
            
            local Center = Instance.new("TextLabel")
            Center.Parent = Separator
            Center.BackgroundTransparency = 1
            Center.AnchorPoint = Vector2.new(0.5, 0.5)
            Center.Position = UDim2.new(0.5, 0, 0.5, 0)
            Center.Size = UDim2.new(1, 0, 0, 36)
            Center.Font = Enum.Font.GothamBold
            Center.Text = text
            Center.TextColor3 = Color3.fromRGB(255, 255, 255)
            Center.TextSize = 14
            
            local Right = Instance.new("TextLabel")
            Right.Parent = Separator
            Right.BackgroundTransparency = 1
            Right.AnchorPoint = Vector2.new(1, 0.5)
            Right.Position = UDim2.new(1, 0, 0.5, 0)
            Right.Size = UDim2.new(0, 20, 0, 36)
            Right.Font = Enum.Font.GothamBold
            Right.RichText = true
            Right.Text = "<font color=\"rgb(255, 255, 255)\">〈</font>〈"
            Right.TextColor3 = Color3.fromRGB(255, 255, 255)
            Right.TextSize = 14
        end
        
        function TabAPI:Line()
            local LineFrame = Instance.new("Frame")
            LineFrame.Parent = TabPage
            LineFrame.BackgroundTransparency = 1
            LineFrame.Size = UDim2.new(1, 0, 0, 20)
            
            local Line = Instance.new("Frame")
            Line.Parent = LineFrame
            Line.BackgroundColor3 = Color3.fromRGB(125, 125, 125)
            Line.BorderSizePixel = 0
            Line.Position = UDim2.new(0, 0, 0, 10)
            Line.Size = UDim2.new(1, 0, 0, 1)
            
            local Gradient = Instance.new("UIGradient")
            Gradient.Color = ColorSequence.new({
                ColorSequenceKeypoint.new(0, _G.Dark),
                ColorSequenceKeypoint.new(0.4, _G.Primary),
                ColorSequenceKeypoint.new(0.5, _G.Primary),
                ColorSequenceKeypoint.new(0.6, _G.Primary),
                ColorSequenceKeypoint.new(1, _G.Dark)
            })
            Gradient.Parent = Line
        end
        
        return TabAPI
    end
    
    return WindowAPI
end

return VexHub
