local Library = {}

-- Tween helper
function Library:TweenInstance(Instance, Time, Property, Value)
  local TweenService = game:GetService("TweenService")
  local tween = TweenService:Create(Instance, TweenInfo.new(Time, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {[Property] = Value})
  tween:Play()
  return tween
end

-- Update content helper
function Library:UpdateContent(Content, Title, Object)
  if Content.Text ~= "" then
    Title.Position = UDim2.new(0, 12, 0, 8)
    Title.Size = UDim2.new(1, -70, 0, 18)
    local MaxY = math.max(Content.TextBounds.Y + 18, 50)
    Object.Size = UDim2.new(1, 0, 0, MaxY)
  end
end

-- Update scrolling helper
function Library:UpdateScrolling(Scroll, List)
  List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 20)
  end)
end

-- Config helper
function Library:MakeConfig(Config, NewConfig)
  for i, v in next, Config do
    if not NewConfig[i] then
      NewConfig[i] = v
    end
  end
  return NewConfig
end

-- Draggable helper
function Library:MakeDraggable(topbar, object)
  local Dragging = nil
  local DragInput = nil
  local DragStart = nil
  local StartPosition = nil

  local function UpdatePos(input)
    local Delta = input.Position - DragStart
    local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale, StartPosition.Y.Offset + Delta.Y)
    Library:TweenInstance(object, 0.15, "Position", pos)
  end

  topbar.InputBegan:Connect(function(input)
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

  topbar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
      DragInput = input
    end
  end)

  game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == DragInput and Dragging then
      UpdatePos(input)
    end
  end)
end

function Library:NewWindow(ConfigWindow)
  local ConfigWindow = self:MakeConfig({
    Title = "Modern UI Library",
    Description = "Premium Design",
  }, ConfigWindow or {})

  -- Main ScreenGui
  local ModernUI = Instance.new("ScreenGui")
  ModernUI.Name = "ModernUI"
  ModernUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
  ModernUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
  ModernUI.ResetOnSpawn = false

  -- Shadow Container
  local ShadowContainer = Instance.new("Frame")
  ShadowContainer.Name = "ShadowContainer"
  ShadowContainer.Parent = ModernUI
  ShadowContainer.AnchorPoint = Vector2.new(0.5, 0.5)
  ShadowContainer.BackgroundTransparency = 1
  ShadowContainer.Position = UDim2.new(0.5, 0, 0.5, 0)
  ShadowContainer.Size = UDim2.new(0, 620, 0, 400)

  -- Shadow
  local Shadow = Instance.new("ImageLabel")
  Shadow.Name = "Shadow"
  Shadow.Parent = ShadowContainer
  Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
  Shadow.BackgroundTransparency = 1
  Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
  Shadow.Size = UDim2.new(1, 50, 1, 50)
  Shadow.ZIndex = 0
  Shadow.Image = "rbxassetid://6015897843"
  Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
  Shadow.ImageTransparency = 0.6
  Shadow.ScaleType = Enum.ScaleType.Slice
  Shadow.SliceCenter = Rect.new(49, 49, 450, 450)

  -- Main Window
  local MainWindow = Instance.new("Frame")
  MainWindow.Name = "MainWindow"
  MainWindow.Parent = ShadowContainer
  MainWindow.AnchorPoint = Vector2.new(0.5, 0.5)
  MainWindow.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
  MainWindow.BorderSizePixel = 0
  MainWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
  MainWindow.Size = UDim2.new(0, 620, 0, 400)

  local MainCorner = Instance.new("UICorner")
  MainCorner.CornerRadius = UDim.new(0, 16)
  MainCorner.Parent = MainWindow

  -- Gradient Background
  local BgGradient = Instance.new("UIGradient")
  BgGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 28)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 12, 18))
  }
  BgGradient.Rotation = 45
  BgGradient.Parent = MainWindow

  -- Border Stroke
  local BorderStroke = Instance.new("UIStroke")
  BorderStroke.Color = Color3.fromRGB(80, 80, 120)
  BorderStroke.Transparency = 0.5
  BorderStroke.Thickness = 1.5
  BorderStroke.Parent = MainWindow

  -- Animated gradient for stroke
  local StrokeGradient = Instance.new("UIGradient")
  StrokeGradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(138, 43, 226)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 191, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(138, 43, 226))
  }
  StrokeGradient.Rotation = 0
  StrokeGradient.Parent = BorderStroke

  -- Animate stroke gradient
  spawn(function()
    while wait() do
      for i = 0, 360, 2 do
        if not StrokeGradient.Parent then break end
        StrokeGradient.Rotation = i
        wait()
      end
    end
  end)

  -- Topbar
  local Topbar = Instance.new("Frame")
  Topbar.Name = "Topbar"
  Topbar.Parent = MainWindow
  Topbar.BackgroundTransparency = 1
  Topbar.Size = UDim2.new(1, 0, 0, 55)

  -- Logo
  local Logo = Instance.new("ImageLabel")
  Logo.Name = "Logo"
  Logo.Parent = Topbar
  Logo.BackgroundTransparency = 1
  Logo.Position = UDim2.new(0, 15, 0, 10)
  Logo.Size = UDim2.new(0, 35, 0, 35)
  Logo.Image = "rbxassetid://133979080007875"

  -- Title
  local TitleLabel = Instance.new("TextLabel")
  TitleLabel.Name = "TitleLabel"
  TitleLabel.Parent = Topbar
  TitleLabel.BackgroundTransparency = 1
  TitleLabel.Position = UDim2.new(0, 58, 0, 12)
  TitleLabel.Size = UDim2.new(0, 400, 0, 18)
  TitleLabel.Font = Enum.Font.GothamBold
  TitleLabel.Text = ConfigWindow.Title
  TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
  TitleLabel.TextSize = 16
  TitleLabel.TextXAlignment = Enum.TextXAlignment.Left

  -- Description
  local DescLabel = Instance.new("TextLabel")
  DescLabel.Name = "DescLabel"
  DescLabel.Parent = Topbar
  DescLabel.BackgroundTransparency = 1
  DescLabel.Position = UDim2.new(0, 58, 0, 30)
  DescLabel.Size = UDim2.new(0, 400, 0, 15)
  DescLabel.Font = Enum.Font.Gotham
  DescLabel.Text = ConfigWindow.Description
  DescLabel.TextColor3 = Color3.fromRGB(150, 150, 170)
  DescLabel.TextSize = 12
  DescLabel.TextXAlignment = Enum.TextXAlignment.Left

  -- Control Buttons Container
  local ControlsFrame = Instance.new("Frame")
  ControlsFrame.Name = "ControlsFrame"
  ControlsFrame.Parent = Topbar
  ControlsFrame.BackgroundTransparency = 1
  ControlsFrame.Position = UDim2.new(1, -110, 0, 12)
  ControlsFrame.Size = UDim2.new(0, 100, 0, 30)

  local ControlsList = Instance.new("UIListLayout")
  ControlsList.Parent = ControlsFrame
  ControlsList.FillDirection = Enum.FillDirection.Horizontal
  ControlsList.SortOrder = Enum.SortOrder.LayoutOrder
  ControlsList.Padding = UDim.new(0, 8)

  -- Minimize Button
  local MinButton = Instance.new("TextButton")
  MinButton.Name = "MinButton"
  MinButton.Parent = ControlsFrame
  MinButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
  MinButton.BorderSizePixel = 0
  MinButton.Size = UDim2.new(0, 30, 0, 30)
  MinButton.Text = ""
  MinButton.AutoButtonColor = false

  local MinCorner = Instance.new("UICorner")
  MinCorner.CornerRadius = UDim.new(0, 8)
  MinCorner.Parent = MinButton

  local MinIcon = Instance.new("ImageLabel")
  MinIcon.Parent = MinButton
  MinIcon.AnchorPoint = Vector2.new(0.5, 0.5)
  MinIcon.BackgroundTransparency = 1
  MinIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
  MinIcon.Size = UDim2.new(0, 18, 0, 18)
  MinIcon.Image = "rbxassetid://136452605242985"
  MinIcon.ImageRectOffset = Vector2.new(288, 672)
  MinIcon.ImageRectSize = Vector2.new(96, 96)

  -- Close Button
  local CloseButton = Instance.new("TextButton")
  CloseButton.Name = "CloseButton"
  CloseButton.Parent = ControlsFrame
  CloseButton.BackgroundColor3 = Color3.fromRGB(220, 50, 80)
  CloseButton.BorderSizePixel = 0
  CloseButton.Size = UDim2.new(0, 30, 0, 30)
  CloseButton.Text = ""
  CloseButton.AutoButtonColor = false

  local CloseCorner = Instance.new("UICorner")
  CloseCorner.CornerRadius = UDim.new(0, 8)
  CloseCorner.Parent = CloseButton

  local CloseIcon = Instance.new("ImageLabel")
  CloseIcon.Parent = CloseButton
  CloseIcon.AnchorPoint = Vector2.new(0.5, 0.5)
  CloseIcon.BackgroundTransparency = 1
  CloseIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
  CloseIcon.Size = UDim2.new(0, 18, 0, 18)
  CloseIcon.Image = "rbxassetid://105957381820378"
  CloseIcon.ImageRectOffset = Vector2.new(480, 0)
  CloseIcon.ImageRectSize = Vector2.new(96, 96)

  -- Divider Line
  local DividerLine = Instance.new("Frame")
  DividerLine.Name = "DividerLine"
  DividerLine.Parent = Topbar
  DividerLine.BackgroundColor3 = Color3.fromRGB(80, 80, 120)
  DividerLine.BackgroundTransparency = 0.7
  DividerLine.BorderSizePixel = 0
  DividerLine.Position = UDim2.new(0, 0, 1, -1)
  DividerLine.Size = UDim2.new(1, 0, 0, 1)

  -- Sidebar
  local Sidebar = Instance.new("Frame")
  Sidebar.Name = "Sidebar"
  Sidebar.Parent = MainWindow
  Sidebar.BackgroundColor3 = Color3.fromRGB(18, 18, 25)
  Sidebar.BackgroundTransparency = 0.3
  Sidebar.BorderSizePixel = 0
  Sidebar.Position = UDim2.new(0, 0, 0, 55)
  Sidebar.Size = UDim2.new(0, 170, 1, -55)

  -- Search Box
  local SearchContainer = Instance.new("Frame")
  SearchContainer.Name = "SearchContainer"
  SearchContainer.Parent = Sidebar
  SearchContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
  SearchContainer.BorderSizePixel = 0
  SearchContainer.Position = UDim2.new(0, 12, 0, 12)
  SearchContainer.Size = UDim2.new(1, -24, 0, 38)

  local SearchCorner = Instance.new("UICorner")
  SearchCorner.CornerRadius = UDim.new(0, 10)
  SearchCorner.Parent = SearchContainer

  local SearchStroke = Instance.new("UIStroke")
  SearchStroke.Color = Color3.fromRGB(80, 80, 120)
  SearchStroke.Transparency = 0.6
  SearchStroke.Thickness = 1
  SearchStroke.Parent = SearchContainer

  local SearchIcon = Instance.new("ImageLabel")
  SearchIcon.Name = "SearchIcon"
  SearchIcon.Parent = SearchContainer
  SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
  SearchIcon.BackgroundTransparency = 1
  SearchIcon.Position = UDim2.new(0, 12, 0.5, 0)
  SearchIcon.Size = UDim2.new(0, 16, 0, 16)
  SearchIcon.Image = "rbxassetid://71309835376233"

  local SearchBox = Instance.new("TextBox")
  SearchBox.Name = "SearchBox"
  SearchBox.Parent = SearchContainer
  SearchBox.BackgroundTransparency = 1
  SearchBox.Position = UDim2.new(0, 38, 0, 0)
  SearchBox.Size = UDim2.new(1, -38, 1, 0)
  SearchBox.Font = Enum.Font.GothamMedium
  SearchBox.PlaceholderText = "Search..."
  SearchBox.Text = ""
  SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
  SearchBox.TextSize = 13
  SearchBox.TextXAlignment = Enum.TextXAlignment.Left

  -- Tab Container
  local TabContainer = Instance.new("ScrollingFrame")
  TabContainer.Name = "TabContainer"
  TabContainer.Parent = Sidebar
  TabContainer.BackgroundTransparency = 1
  TabContainer.BorderSizePixel = 0
  TabContainer.Position = UDim2.new(0, 0, 0, 62)
  TabContainer.Size = UDim2.new(1, 0, 1, -62)
  TabContainer.ScrollBarThickness = 0
  TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

  local TabList = Instance.new("UIListLayout")
  TabList.Parent = TabContainer
  TabList.SortOrder = Enum.SortOrder.LayoutOrder
  TabList.Padding = UDim.new(0, 6)

  local TabPadding = Instance.new("UIPadding")
  TabPadding.Parent = TabContainer
  TabPadding.PaddingLeft = UDim.new(0, 12)
  TabPadding.PaddingRight = UDim.new(0, 12)
  TabPadding.PaddingTop = UDim.new(0, 6)
  TabPadding.PaddingBottom = UDim.new(0, 6)

  Library:UpdateScrolling(TabContainer, TabList)

  -- Content Area
  local ContentArea = Instance.new("Frame")
  ContentArea.Name = "ContentArea"
  ContentArea.Parent = MainWindow
  ContentArea.BackgroundTransparency = 1
  ContentArea.Position = UDim2.new(0, 170, 0, 55)
  ContentArea.Size = UDim2.new(1, -170, 1, -55)
  ContentArea.ClipsDescendants = true

  -- Content Header
  local ContentHeader = Instance.new("Frame")
  ContentHeader.Name = "ContentHeader"
  ContentHeader.Parent = ContentArea
  ContentHeader.BackgroundTransparency = 1
  ContentHeader.Size = UDim2.new(1, 0, 0, 45)

  local ContentTitle = Instance.new("TextLabel")
  ContentTitle.Name = "ContentTitle"
  ContentTitle.Parent = ContentHeader
  ContentTitle.BackgroundTransparency = 1
  ContentTitle.Position = UDim2.new(0, 15, 0, 0)
  ContentTitle.Size = UDim2.new(1, -15, 1, 0)
  ContentTitle.Font = Enum.Font.GothamBold
  ContentTitle.Text = ""
  ContentTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
  ContentTitle.TextSize = 14
  ContentTitle.TextXAlignment = Enum.TextXAlignment.Left

  -- Page Container
  local PageContainer = Instance.new("Frame")
  PageContainer.Name = "PageContainer"
  PageContainer.Parent = ContentArea
  PageContainer.BackgroundTransparency = 1
  PageContainer.Position = UDim2.new(0, 0, 0, 45)
  PageContainer.Size = UDim2.new(1, 0, 1, -45)

  local PageList = Instance.new("Folder")
  PageList.Name = "PageList"
  PageList.Parent = PageContainer

  local PageLayout = Instance.new("UIPageLayout")
  PageLayout.Parent = PageList
  PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
  PageLayout.EasingStyle = Enum.EasingStyle.Quint
  PageLayout.TweenTime = 0.4

  -- Overlay for dialogs
  local OverlayFrame = Instance.new("Frame")
  OverlayFrame.Name = "OverlayFrame"
  OverlayFrame.Parent = MainWindow
  OverlayFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
  OverlayFrame.BackgroundTransparency = 1
  OverlayFrame.BorderSizePixel = 0
  OverlayFrame.Size = UDim2.new(1, 0, 1, 0)
  OverlayFrame.Visible = false
  OverlayFrame.ZIndex = 10

  -- Make draggable
  Library:MakeDraggable(Topbar, ShadowContainer)

  -- Button hover effects
  for _, btn in pairs({MinButton, CloseButton}) do
    btn.MouseEnter:Connect(function()
      Library:TweenInstance(btn, 0.2, "BackgroundTransparency", 0.2)
    end)
    btn.MouseLeave:Connect(function()
      Library:TweenInstance(btn, 0.2, "BackgroundTransparency", 0)
    end)
  end

  -- Close button functionality
  CloseButton.MouseButton1Click:Connect(function()
    OverlayFrame.Visible = true
    Library:TweenInstance(OverlayFrame, 0.3, "BackgroundTransparency", 0.5)

    local ConfirmDialog = Instance.new("Frame")
    ConfirmDialog.Name = "ConfirmDialog"
    ConfirmDialog.Parent = OverlayFrame
    ConfirmDialog.AnchorPoint = Vector2.new(0.5, 0.5)
    ConfirmDialog.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
    ConfirmDialog.BorderSizePixel = 0
    ConfirmDialog.Position = UDim2.new(0.5, 0, 0.5, 0)
    ConfirmDialog.Size = UDim2.new(0, 350, 0, 180)

    local DialogCorner = Instance.new("UICorner")
    DialogCorner.CornerRadius = UDim.new(0, 12)
    DialogCorner.Parent = ConfirmDialog

    local DialogStroke = Instance.new("UIStroke")
    DialogStroke.Color = Color3.fromRGB(100, 100, 150)
    DialogStroke.Transparency = 0.5
    DialogStroke.Parent = ConfirmDialog

    local DialogTitle = Instance.new("TextLabel")
    DialogTitle.Parent = ConfirmDialog
    DialogTitle.BackgroundTransparency = 1
    DialogTitle.Size = UDim2.new(1, 0, 0, 60)
    DialogTitle.Font = Enum.Font.GothamBold
    DialogTitle.Text = "Confirm Exit"
    DialogTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    DialogTitle.TextSize = 18

    local YesButton = Instance.new("TextButton")
    YesButton.Name = "YesButton"
    YesButton.Parent = ConfirmDialog
    YesButton.BackgroundColor3 = Color3.fromRGB(220, 50, 80)
    YesButton.BorderSizePixel = 0
    YesButton.Position = UDim2.new(0, 30, 1, -60)
    YesButton.Size = UDim2.new(0, 130, 0, 40)
    YesButton.Font = Enum.Font.GothamBold
    YesButton.Text = "Yes"
    YesButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    YesButton.TextSize = 14

    local YesCorner = Instance.new("UICorner")
    YesCorner.CornerRadius = UDim.new(0, 8)
    YesCorner.Parent = YesButton

    local NoButton = Instance.new("TextButton")
    NoButton.Name = "NoButton"
    NoButton.Parent = ConfirmDialog
    NoButton.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    NoButton.BorderSizePixel = 0
    NoButton.Position = UDim2.new(1, -160, 1, -60)
    NoButton.Size = UDim2.new(0, 130, 0, 40)
    NoButton.Font = Enum.Font.GothamBold
    NoButton.Text = "No"
    NoButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    NoButton.TextSize = 14

    local NoCorner = Instance.new("UICorner")
    NoCorner.CornerRadius = UDim.new(0, 8)
    NoCorner.Parent = NoButton

    YesButton.MouseButton1Click:Connect(function()
      ModernUI:Destroy()
    end)

    NoButton.MouseButton1Click:Connect(function()
      Library:TweenInstance(OverlayFrame, 0.3, "BackgroundTransparency", 1)
      wait(0.3)
      OverlayFrame.Visible = false
      ConfirmDialog:Destroy()
    end)
  end)

  -- Minimize functionality
  MinButton.MouseButton1Click:Connect(function()
    ModernUI.Enabled = false
  end)

  -- Toggle button
  local ToggleBtn = Instance.new("ImageButton")
  ToggleBtn.Name = "ToggleBtn"
  ToggleBtn.Parent = ModernUI
  ToggleBtn.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
  ToggleBtn.BorderSizePixel = 0
  ToggleBtn.Position = UDim2.new(0, 20, 0.5, -25)
  ToggleBtn.Size = UDim2.new(0, 50, 0, 50)
  ToggleBtn.Image = "rbxassetid://133979080007875"

  local ToggleCorner = Instance.new("UICorner")
  ToggleCorner.CornerRadius = UDim.new(1, 0)
  ToggleCorner.Parent = ToggleBtn

  local ToggleStroke = Instance.new("UIStroke")
  ToggleStroke.Color = Color3.fromRGB(200, 100, 255)
  ToggleStroke.Thickness = 2
  ToggleStroke.Parent = ToggleBtn

  Library:MakeDraggable(ToggleBtn, ToggleBtn)

  ToggleBtn.MouseButton1Click:Connect(function()
    ShadowContainer.Visible = not ShadowContainer.Visible
  end)

  -- Tab System
  local AllTabs = 0
  local Tab = {}

  function Tab:T(tabName)
    local TabButton = Instance.new("TextButton")
    TabButton.Name = "TabButton"
    TabButton.Parent = TabContainer
    TabButton.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
    TabButton.BackgroundTransparency = 1
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 38)
    TabButton.Font = Enum.Font.GothamBold
    TabButton.Text = "  " .. tabName
    TabButton.TextColor3 = Color3.fromRGB(150, 150, 170)
    TabButton.TextSize = 13
    TabButton.TextXAlignment = Enum.TextXAlignment.Left
    TabButton.AutoButtonColor = false

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 10)
    TabCorner.Parent = TabButton

    local TabIndicator = Instance.new("Frame")
    TabIndicator.Name = "TabIndicator"
    TabIndicator.Parent = TabButton
    TabIndicator.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
    TabIndicator.BorderSizePixel = 0
    TabIndicator.Position = UDim2.new(0, 0, 0.5, -12)
    TabIndicator.Size = UDim2.new(0, 0, 0, 24)
    TabIndicator.Visible = false

    local IndicatorCorner = Instance.new("UICorner")
    IndicatorCorner.CornerRadius = UDim.new(0, 4)
    IndicatorCorner.Parent = TabIndicator

    -- Page
    local Page = Instance.new("ScrollingFrame")
    Page.Name = "Page"
    Page.Parent = PageList
    Page.BackgroundTransparency = 1
    Page.BorderSizePixel = 0
    Page.Size = UDim2.new(1, 0, 1, 0)
    Page.ScrollBarThickness = 4
    Page.CanvasSize = UDim2.new(0, 0, 0, 0)
    Page.LayoutOrder = AllTabs

    local PageListLayout = Instance.new("UIListLayout")
    PageListLayout.Parent = Page
    PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
    PageListLayout.Padding = UDim.new(0, 12)

    local PagePadding = Instance.new("UIPadding")
    PagePadding.Parent = Page
    PagePadding.PaddingLeft = UDim.new(0, 15)
    PagePadding.PaddingRight = UDim.new(0, 15)
    PagePadding.PaddingTop = UDim.new(0, 10)
    PagePadding.PaddingBottom = UDim.new(0, 10)

    Library:UpdateScrolling(Page, PageListLayout)

    -- First tab selected
    if AllTabs == 0 then
      TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
      TabButton.BackgroundTransparency = 0
      TabIndicator.Visible = true
      TabIndicator.Size = UDim2.new(0, 4, 0, 24)
      ContentTitle.Text = tabName
      PageLayout:JumpToIndex(0)
    end

    TabButton.MouseButton1Click:Connect(function()
      for _, btn in pairs(TabContainer:GetChildren()) do
        if btn:IsA("TextButton") then
          Library:TweenInstance(btn, 0.3, "TextColor3", Color3.fromRGB(150, 150, 170))
          Library:TweenInstance(btn, 0.3, "BackgroundTransparency", 1)
          if btn:FindFirstChild("TabIndicator") then
            btn.TabIndicator.Visible = false
          end
        end
      end
      Library:TweenInstance(TabButton, 0.3, "TextColor3", Color3.fromRGB(255, 255, 255))
      Library:TweenInstance(TabButton, 0.3, "BackgroundTransparency", 0)
      TabIndicator.Visible = true
      Library:TweenInstance(TabIndicator, 0.3, "Size", UDim2.new(0, 4, 0, 24))
      ContentTitle.Text = tabName
      PageLayout:JumpToIndex(Page.LayoutOrder)
    end)

    TabButton.MouseEnter:Connect(function()
      if TabButton.BackgroundTransparency == 1 then
        Library:TweenInstance(TabButton, 0.2, "BackgroundTransparency", 0.9)
      end
    end)

    TabButton.MouseLeave:Connect(function()
      if TabButton.BackgroundTransparency ~= 0 then
        Library:TweenInstance(TabButton, 0.2, "BackgroundTransparency", 1)
      end
    end)

    AllTabs = AllTabs + 1

    local TabFunc = {}

    function TabFunc:AddSection(sectionName)
      local Section = Instance.new("Frame")
      Section.Name = "Section"
      Section.Parent = Page
      Section.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
      Section.BackgroundTransparency = 0.4
      Section.BorderSizePixel = 0
      Section.Size = UDim2.new(1, 0, 0, 60)

      local SectionCorner = Instance.new("UICorner")
      SectionCorner.CornerRadius = UDim.new(0, 12)
      SectionCorner.Parent = Section

      local SectionStroke = Instance.new("UIStroke")
      SectionStroke.Color = Color3.fromRGB(80, 80, 120)
      SectionStroke.Transparency = 0.7
      SectionStroke.Thickness = 1.5
      SectionStroke.Parent = Section

      local SectionHeader = Instance.new("Frame")
      SectionHeader.Name = "SectionHeader"
      SectionHeader.Parent = Section
      SectionHeader.BackgroundTransparency = 1
      SectionHeader.Size = UDim2.new(1, 0, 0, 35)

      local SectionTitle = Instance.new("TextLabel")
      SectionTitle.Name = "SectionTitle"
      SectionTitle.Parent = SectionHeader
      SectionTitle.BackgroundTransparency = 1
      SectionTitle.Position = UDim2.new(0, 0, 0, 0)
      SectionTitle.Size = UDim2.new(1, 0, 1, 0)
      SectionTitle.Font = Enum.Font.GothamBold
      SectionTitle.Text = sectionName
      SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
      SectionTitle.TextSize = 15

      local SectionDivider = Instance.new("Frame")
      SectionDivider.Name = "SectionDivider"
      SectionDivider.Parent = SectionHeader
      SectionDivider.BackgroundColor3 = Color3.fromRGB(100, 100, 150)
      SectionDivider.BackgroundTransparency = 0.7
      SectionDivider.BorderSizePixel = 0
      SectionDivider.Position = UDim2.new(0, 0, 1, -1)
      SectionDivider.Size = UDim2.new(1, 0, 0, 1)

      local SectionContent = Instance.new("Frame")
      SectionContent.Name = "SectionContent"
      SectionContent.Parent = Section
      SectionContent.BackgroundTransparency = 1
      SectionContent.Position = UDim2.new(0, 0, 0, 40)
      SectionContent.Size = UDim2.new(1, 0, 1, -40)

      local ContentList = Instance.new("UIListLayout")
      ContentList.Parent = SectionContent
      ContentList.SortOrder = Enum.SortOrder.LayoutOrder
      ContentList.Padding = UDim.new(0, 8)

      local ContentPadding = Instance.new("UIPadding")
      ContentPadding.Parent = SectionContent
      ContentPadding.PaddingLeft = UDim.new(0, 10)
      ContentPadding.PaddingRight = UDim.new(0, 10)
      ContentPadding.PaddingTop = UDim.new(0, 8)
      ContentPadding.PaddingBottom = UDim.new(0, 10)

      ContentList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Section.Size = UDim2.new(1, 0, 0, ContentList.AbsoluteContentSize.Y + 60)
      end)

      local SectionFunc = {}

      function SectionFunc:AddToggle(config)
        local config = Library:MakeConfig({
          Title = "Toggle",
          Description = "",
          Default = false,
          Callback = function() end
        }, config or {})

        local Toggle = Instance.new("Frame")
        Toggle.Name = "Toggle"
        Toggle.Parent = SectionContent
        Toggle.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Toggle.BackgroundTransparency = 0.5
        Toggle.BorderSizePixel = 0
        Toggle.Size = UDim2.new(1, 0, 0, 45)

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 10)
        ToggleCorner.Parent = Toggle

        local ToggleTitle = Instance.new("TextLabel")
        ToggleTitle.Name = "ToggleTitle"
        ToggleTitle.Parent = Toggle
        ToggleTitle.BackgroundTransparency = 1
        ToggleTitle.Position = UDim2.new(0, 12, 0, 0)
        ToggleTitle.Size = UDim2.new(1, -70, 1, 0)
        ToggleTitle.Font = Enum.Font.GothamBold
        ToggleTitle.Text = config.Title
        ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ToggleTitle.TextSize = 13
        ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

        local ToggleDesc = Instance.new("TextLabel")
        ToggleDesc.Name = "ToggleDesc"
        ToggleDesc.Parent = Toggle
        ToggleDesc.BackgroundTransparency = 1
        ToggleDesc.Position = UDim2.new(0, 12, 0, 24)
        ToggleDesc.Size = UDim2.new(1, -70, 1, 0)
        ToggleDesc.Font = Enum.Font.Gotham
        ToggleDesc.Text = config.Description
        ToggleDesc.TextColor3 = Color3.fromRGB(120, 120, 140)
        ToggleDesc.TextSize = 11
        ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
        ToggleDesc.TextYAlignment = Enum.TextYAlignment.Top

        Library:UpdateContent(ToggleDesc, ToggleTitle, Toggle)

        local ToggleSwitch = Instance.new("Frame")
        ToggleSwitch.Name = "ToggleSwitch"
        ToggleSwitch.Parent = Toggle
        ToggleSwitch.AnchorPoint = Vector2.new(0, 0.5)
        ToggleSwitch.BackgroundColor3 = Color3.fromRGB(45, 45, 60)
        ToggleSwitch.BorderSizePixel = 0
        ToggleSwitch.Position = UDim2.new(1, -58, 0.5, 0)
        ToggleSwitch.Size = UDim2.new(0, 50, 0, 26)

        local SwitchCorner = Instance.new("UICorner")
        SwitchCorner.CornerRadius = UDim.new(1, 0)
        SwitchCorner.Parent = ToggleSwitch

        local SwitchButton = Instance.new("Frame")
        SwitchButton.Name = "SwitchButton"
        SwitchButton.Parent = ToggleSwitch
        SwitchButton.AnchorPoint = Vector2.new(0, 0.5)
        SwitchButton.BackgroundColor3 = Color3.fromRGB(200, 200, 210)
        SwitchButton.BorderSizePixel = 0
        SwitchButton.Position = UDim2.new(0, 3, 0.5, 0)
        SwitchButton.Size = UDim2.new(0, 20, 0, 20)

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(1, 0)
        ButtonCorner.Parent = SwitchButton

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Name = "ToggleButton"
        ToggleButton.Parent = Toggle
        ToggleButton.BackgroundTransparency = 1
        ToggleButton.Size = UDim2.new(1, 0, 1, 0)
        ToggleButton.Text = ""

        local ToggleFunc = {Value = config.Default}

        function ToggleFunc:Set(value)
          ToggleFunc.Value = value
          if value then
            Library:TweenInstance(ToggleSwitch, 0.3, "BackgroundColor3", Color3.fromRGB(138, 43, 226))
            Library:TweenInstance(SwitchButton, 0.3, "Position", UDim2.new(0, 27, 0.5, 0))
            Library:TweenInstance(SwitchButton, 0.3, "BackgroundColor3", Color3.fromRGB(255, 255, 255))
          else
            Library:TweenInstance(ToggleSwitch, 0.3, "BackgroundColor3", Color3.fromRGB(45, 45, 60))
            Library:TweenInstance(SwitchButton, 0.3, "Position", UDim2.new(0, 3, 0.5, 0))
            Library:TweenInstance(SwitchButton, 0.3, "BackgroundColor3", Color3.fromRGB(200, 200, 210))
          end
          config.Callback(value)
        end

        ToggleButton.MouseButton1Click:Connect(function()
          ToggleFunc:Set(not ToggleFunc.Value)
        end)

        ToggleFunc:Set(ToggleFunc.Value)
        return ToggleFunc
      end

      function SectionFunc:AddButton(config)
        local config = Library:MakeConfig({
          Title = "Button",
          Description = "",
          Callback = function() end
        }, config or {})

        local Button = Instance.new("Frame")
        Button.Name = "Button"
        Button.Parent = SectionContent
        Button.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Button.BackgroundTransparency = 0.5
        Button.BorderSizePixel = 0
        Button.Size = UDim2.new(1, 0, 0, 45)

        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 10)
        ButtonCorner.Parent = Button

        local ButtonTitle = Instance.new("TextLabel")
        ButtonTitle.Name = "ButtonTitle"
        ButtonTitle.Parent = Button
        ButtonTitle.BackgroundTransparency = 1
        ButtonTitle.Position = UDim2.new(0, 12, 0, 0)
        ButtonTitle.Size = UDim2.new(1, -40, 1, 0)
        ButtonTitle.Font = Enum.Font.GothamBold
        ButtonTitle.Text = config.Title
        ButtonTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        ButtonTitle.TextSize = 13
        ButtonTitle.TextXAlignment = Enum.TextXAlignment.Left

        local ButtonDesc = Instance.new("TextLabel")
        ButtonDesc.Name = "ButtonDesc"
        ButtonDesc.Parent = Button
        ButtonDesc.BackgroundTransparency = 1
        ButtonDesc.Position = UDim2.new(0, 12, 0, 24)
        ButtonDesc.Size = UDim2.new(1, -40, 1, 0)
        ButtonDesc.Font = Enum.Font.Gotham
        ButtonDesc.Text = config.Description
        ButtonDesc.TextColor3 = Color3.fromRGB(120, 120, 140)
        ButtonDesc.TextSize = 11
        ButtonDesc.TextXAlignment = Enum.TextXAlignment.Left
        ButtonDesc.TextYAlignment = Enum.TextYAlignment.Top

        Library:UpdateContent(ButtonDesc, ButtonTitle, Button)

        local ButtonIcon = Instance.new("ImageLabel")
        ButtonIcon.Name = "ButtonIcon"
        ButtonIcon.Parent = Button
        ButtonIcon.AnchorPoint = Vector2.new(0, 0.5)
        ButtonIcon.BackgroundTransparency = 1
        ButtonIcon.Position = UDim2.new(1, -32, 0.5, 0)
        ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
        ButtonIcon.Image = "rbxassetid://85905776508942"

        local ClickButton = Instance.new("TextButton")
        ClickButton.Name = "ClickButton"
        ClickButton.Parent = Button
        ClickButton.BackgroundTransparency = 1
        ClickButton.Size = UDim2.new(1, 0, 1, 0)
        ClickButton.Text = ""

        ClickButton.MouseButton1Click:Connect(function()
          Library:TweenInstance(Button, 0.1, "BackgroundTransparency", 0.2)
          wait(0.1)
          Library:TweenInstance(Button, 0.2, "BackgroundTransparency", 0.5)
          config.Callback()
        end)

        ClickButton.MouseEnter:Connect(function()
          Library:TweenInstance(Button, 0.2, "BackgroundTransparency", 0.3)
        end)

        ClickButton.MouseLeave:Connect(function()
          Library:TweenInstance(Button, 0.2, "BackgroundTransparency", 0.5)
        end)
      end

      function SectionFunc:AddSlider(config)
        local config = Library:MakeConfig({
          Title = "Slider",
          Description = "",
          Min = 0,
          Max = 100,
          Increment = 1,
          Default = 50,
          Callback = function() end
        }, config or {})

        local Slider = Instance.new("Frame")
        Slider.Name = "Slider"
        Slider.Parent = SectionContent
        Slider.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Slider.BackgroundTransparency = 0.5
        Slider.BorderSizePixel = 0
        Slider.Size = UDim2.new(1, 0, 0, 50)

        local SliderCorner = Instance.new("UICorner")
        SliderCorner.CornerRadius = UDim.new(0, 10)
        SliderCorner.Parent = Slider

        local SliderTitle = Instance.new("TextLabel")
        SliderTitle.Name = "SliderTitle"
        SliderTitle.Parent = Slider
        SliderTitle.BackgroundTransparency = 1
        SliderTitle.Position = UDim2.new(0, 12, 0, 0)
        SliderTitle.Size = UDim2.new(1, -160, 1, 0)
        SliderTitle.Font = Enum.Font.GothamBold
        SliderTitle.Text = config.Title
        SliderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderTitle.TextSize = 13
        SliderTitle.TextXAlignment = Enum.TextXAlignment.Left

        local SliderDesc = Instance.new("TextLabel")
        SliderDesc.Name = "SliderDesc"
        SliderDesc.Parent = Slider
        SliderDesc.BackgroundTransparency = 1
        SliderDesc.Position = UDim2.new(0, 12, 0, 24)
        SliderDesc.Size = UDim2.new(1, -160, 1, 0)
        SliderDesc.Font = Enum.Font.Gotham
        SliderDesc.Text = config.Description
        SliderDesc.TextColor3 = Color3.fromRGB(120, 120, 140)
        SliderDesc.TextSize = 11
        SliderDesc.TextXAlignment = Enum.TextXAlignment.Left
        SliderDesc.TextYAlignment = Enum.TextYAlignment.Top

        Library:UpdateContent(SliderDesc, SliderTitle, Slider)

        local SliderValue = Instance.new("TextBox")
        SliderValue.Name = "SliderValue"
        SliderValue.Parent = Slider
        SliderValue.AnchorPoint = Vector2.new(0, 0.5)
        SliderValue.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        SliderValue.BorderSizePixel = 0
        SliderValue.Position = UDim2.new(1, -185, 0.5, 0)
        SliderValue.Size = UDim2.new(0, 38, 0, 22)
        SliderValue.Font = Enum.Font.GothamBold
        SliderValue.Text = ""
        SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
        SliderValue.TextSize = 11

        local ValueCorner = Instance.new("UICorner")
        ValueCorner.CornerRadius = UDim.new(0, 6)
        ValueCorner.Parent = SliderValue

        local SliderTrack = Instance.new("Frame")
        SliderTrack.Name = "SliderTrack"
        SliderTrack.Parent = Slider
        SliderTrack.AnchorPoint = Vector2.new(0, 0.5)
        SliderTrack.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        SliderTrack.BorderSizePixel = 0
        SliderTrack.Position = UDim2.new(1, -137, 0.5, 0)
        SliderTrack.Size = UDim2.new(0, 127, 0, 8)

        local TrackCorner = Instance.new("UICorner")
        TrackCorner.CornerRadius = UDim.new(1, 0)
        TrackCorner.Parent = SliderTrack

        local SliderFill = Instance.new("Frame")
        SliderFill.Name = "SliderFill"
        SliderFill.Parent = SliderTrack
        SliderFill.BackgroundColor3 = Color3.fromRGB(138, 43, 226)
        SliderFill.BorderSizePixel = 0
        SliderFill.Size = UDim2.new(0.5, 0, 1, 0)

        local FillCorner = Instance.new("UICorner")
        FillCorner.CornerRadius = UDim.new(1, 0)
        FillCorner.Parent = SliderFill

        local SliderDot = Instance.new("Frame")
        SliderDot.Name = "SliderDot"
        SliderDot.Parent = SliderFill
        SliderDot.AnchorPoint = Vector2.new(0, 0.1)
        SliderDot.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        SliderDot.BorderSizePixel = 0
        SliderDot.Position = UDim2.new(1, -6, 0, 0)
        SliderDot.Size = UDim2.new(0, 12, 0, 12)

        local DotCorner = Instance.new("UICorner")
        DotCorner.CornerRadius = UDim.new(1, 0)
        DotCorner.Parent = SliderDot

        local SliderFunc = {Value = config.Default}
        local Dragging = false

        local function Round(num, factor)
          local result = math.floor(num / factor + 0.5) * factor
          if result < 0 then result = result + factor end
          return result
        end

        function SliderFunc:Set(value)
          value = math.clamp(Round(value, config.Increment), config.Min, config.Max)
          SliderFunc.Value = value
          SliderValue.Text = tostring(value)
          
          local scale = (value - config.Min) / (config.Max - config.Min)
          Library:TweenInstance(SliderFill, 0.2, "Size", UDim2.new(scale, 0, 1, 0))
        end

        SliderTrack.InputBegan:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = true
          end
        end)

        SliderTrack.InputEnded:Connect(function(input)
          if input.UserInputType == Enum.UserInputType.MouseButton1 then
            Dragging = false
            config.Callback(SliderFunc.Value)
          end
        end)

        game:GetService("UserInputService").InputChanged:Connect(function(input)
          if Dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local scale = math.clamp((input.Position.X - SliderTrack.AbsolutePosition.X) / SliderTrack.AbsoluteSize.X, 0, 1)
            SliderFunc:Set(config.Min + ((config.Max - config.Min) * scale))
          end
        end)

        SliderValue:GetPropertyChangedSignal("Text"):Connect(function()
          local valid = SliderValue.Text:gsub("[^%d]", "")
          if valid ~= "" then
            local num = math.min(tonumber(valid), config.Max)
            SliderValue.Text = tostring(num)
          else
            SliderValue.Text = valid
          end
        end)

        SliderValue.FocusLost:Connect(function()
          if SliderValue.Text ~= "" then
            SliderFunc:Set(tonumber(SliderValue.Text))
          else
            SliderFunc:Set(config.Min)
          end
        end)

        SliderFunc:Set(config.Default)
        return SliderFunc
      end

      function SectionFunc:AddDropdown(config)
        local config = Library:MakeConfig({
          Title = "Dropdown",
          Description = "",
          Values = {},
          Default = "",
          Multi = false,
          Callback = function() end
        }, config or {})

        local Dropdown = Instance.new("Frame")
        Dropdown.Name = "Dropdown"
        Dropdown.Parent = SectionContent
        Dropdown.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
        Dropdown.BackgroundTransparency = 0.5
        Dropdown.BorderSizePixel = 0
        Dropdown.Size = UDim2.new(1, 0, 0, 45)

        local DropCorner = Instance.new("UICorner")
        DropCorner.CornerRadius = UDim.new(0, 10)
        DropCorner.Parent = Dropdown

        local DropTitle = Instance.new("TextLabel")
        DropTitle.Name = "DropTitle"
        DropTitle.Parent = Dropdown
        DropTitle.BackgroundTransparency = 1
        DropTitle.Position = UDim2.new(0, 12, 0, 0)
        DropTitle.Size = UDim2.new(1, -100, 1, 0)
        DropTitle.Font = Enum.Font.GothamBold
        DropTitle.Text = config.Title
        DropTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        DropTitle.TextSize = 13
        DropTitle.TextXAlignment = Enum.TextXAlignment.Left

        local DropDesc = Instance.new("TextLabel")
        DropDesc.Name = "DropDesc"
        DropDesc.Parent = Dropdown
        DropDesc.BackgroundTransparency = 1
        DropDesc.Position = UDim2.new(0, 12, 0, 24)
        DropDesc.Size = UDim2.new(1, -100, 1, 0)
        DropDesc.Font = Enum.Font.Gotham
        DropDesc.Text = config.Description
        DropDesc.TextColor3 = Color3.fromRGB(120, 120, 140)
        DropDesc.TextSize = 11
        DropDesc.TextXAlignment = Enum.TextXAlignment.Left
        DropDesc.TextYAlignment = Enum.TextYAlignment.Top

        Library:UpdateContent(DropDesc, DropTitle, Dropdown)

        local DropSelect = Instance.new("Frame")
        DropSelect.Name = "DropSelect"
        DropSelect.Parent = Dropdown
        DropSelect.AnchorPoint = Vector2.new(0, 0.5)
        DropSelect.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
        DropSelect.BorderSizePixel = 0
        DropSelect.Position = UDim2.new(1, -88, 0.5, 0)
        DropSelect.Size = UDim2.new(0, 78, 0, 26)

        local SelectCorner = Instance.new("UICorner")
        SelectCorner.CornerRadius = UDim.new(0, 8)
        SelectCorner.Parent = DropSelect

        local SelectText = Instance.new("TextLabel")
        SelectText.Name = "SelectText"
        SelectText.Parent = DropSelect
        SelectText.BackgroundTransparency = 1
        SelectText.Position = UDim2.new(0, 8, 0, 0)
        SelectText.Size = UDim2.new(1, -28, 1, 0)
        SelectText.Font = Enum.Font.GothamBold
        SelectText.Text = ""
        SelectText.TextColor3 = Color3.fromRGB(255, 255, 255)
        SelectText.TextSize = 11
        SelectText.TextTruncate = Enum.TextTruncate.AtEnd
        SelectText.TextXAlignment = Enum.TextXAlignment.Left

        local DropIcon = Instance.new("ImageLabel")
        DropIcon.Name = "DropIcon"
        DropIcon.Parent = DropSelect
        DropIcon.AnchorPoint = Vector2.new(0, 0.5)
        DropIcon.BackgroundTransparency = 1
        DropIcon.Position = UDim2.new(1, -18, 0.5, 0)
        DropIcon.Size = UDim2.new(0, 14, 0, 14)
        DropIcon.Image = "rbxassetid://80845745785361"

        local DropButton = Instance.new("TextButton")
        DropButton.Name = "DropButton"
        DropButton.Parent = DropSelect
        DropButton.BackgroundTransparency = 1
        DropButton.Size = UDim2.new(1, 0, 1, 0)
        DropButton.Text = ""

        -- Dropdown Menu
        local DropMenu = Instance.new("Frame")
        DropMenu.Name = "DropMenu"
        DropMenu.Parent = OverlayFrame
        DropMenu.AnchorPoint = Vector2.new(0.5, 0.5)
        DropMenu.BackgroundColor3 = Color3.fromRGB(20, 20, 28)
        DropMenu.BorderSizePixel = 0
        DropMenu.Position = UDim2.new(0.5, 0, 0.5, 0)
        DropMenu.Size = UDim2.new(0, 380, 0, 280)
        DropMenu.Visible = false

        local MenuCorner = Instance.new("UICorner")
        MenuCorner.CornerRadius = UDim.new(0, 12)
        MenuCorner.Parent = DropMenu

        local MenuStroke = Instance.new("UIStroke")
        MenuStroke.Color = Color3.fromRGB(100, 100, 150)
        MenuStroke.Transparency = 0.5
        MenuStroke.Parent = DropMenu

        local MenuHeader = Instance.new("Frame")
        MenuHeader.Name = "MenuHeader"
        MenuHeader.Parent = DropMenu
        MenuHeader.BackgroundTransparency = 1
        MenuHeader.Size = UDim2.new(1, 0, 0, 50)

        local MenuTitle = Instance.new("TextLabel")
        MenuTitle.Name = "MenuTitle"
        MenuTitle.Parent = MenuHeader
        MenuTitle.BackgroundTransparency = 1
        MenuTitle.Position = UDim2.new(0, 15, 0, 0)
        MenuTitle.Size = UDim2.new(1, -170, 1, 0)
        MenuTitle.Font = Enum.Font.GothamBold
        MenuTitle.Text = config.Title
        MenuTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
        MenuTitle.TextSize = 14
        MenuTitle.TextXAlignment = Enum.TextXAlignment.Left

        local MenuSearch = Instance.new("Frame")
        MenuSearch.Name = "MenuSearch"
        MenuSearch.Parent = MenuHeader
        MenuSearch.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
        MenuSearch.BorderSizePixel = 0
        MenuSearch.Position = UDim2.new(1, -145, 0, 10)
        MenuSearch.Size = UDim2.new(0, 95, 0, 30)

        local SearchCorner2 = Instance.new("UICorner")
        SearchCorner2.CornerRadius
