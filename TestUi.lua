local Library = {}
function Library:TweenInstance(Instance, Time, OldValue, NewValue)
	local rz_Tween = game:GetService("TweenService"):Create(Instance, TweenInfo.new(Time, Enum.EasingStyle.Quad),
		{ [OldValue] = NewValue })
	rz_Tween:Play()
	return rz_Tween
end

function Library:UpdateContent(Content, Title, Object)
	if Content.Text ~= "" then
		Title.Position = UDim2.new(0, 10, 0, 7)
		Title.Size = UDim2.new(1, -60, 0, 16)
		local MaxY = math.max(Content.TextBounds.Y + 15, 45)
		Object.Size = UDim2.new(1, 0, 0, MaxY)
	end
end

function Library:UpdateScrolling(Scroll, List)
	List:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		Scroll.CanvasSize = UDim2.new(0, 0, 0, List.AbsoluteContentSize.Y + 15)
	end)
end

function Library:MouseEvent(Skibidi, ...)
	local Args = { ... }
	Skibidi.MouseEnter:Connect(Args[1])
	Skibidi.MouseLeave:Connect(Args[2])
end

function Library:MakeConfig(Config, NewConfig)
	for i, v in next, Config do
		if not NewConfig[i] then
			NewConfig[i] = v
		end
	end
	return NewConfig
end

function Library:MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function UpdatePos(input)
		local Delta = input.Position - DragStart
		local pos = UDim2.new(StartPosition.X.Scale, StartPosition.X.Offset + Delta.X, StartPosition.Y.Scale,
			StartPosition.Y.Offset + Delta.Y)
		local Tween = game:GetService("TweenService"):Create(object, TweenInfo.new(0.2), { Position = pos })
		Tween:Play()
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
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == DragInput and Dragging then
			UpdatePos(input)
		end
	end)
end

function Library:NewWindow(ConfigWindow)
	local ConfigWindow = self:MakeConfig({
		Title = "Teddy Hub",
		Description = "By Ho Van Hai",
		AccentColor = Color3.fromRGB(179, 0, 255),
		BackgroundColor = Color3.fromRGB(9, 9, 9),
		SecondaryColor = Color3.fromRGB(15, 15, 15)
	}, ConfigWindow or {})
	
	local TeddyUI_Premium = Instance.new("ScreenGui")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Top = Instance.new("Frame")
	local Line = Instance.new("Frame")
	local Left = Instance.new("Folder")
	local NameHub = Instance.new("TextLabel")
	local LogoHub = Instance.new("ImageLabel")
	local Desc = Instance.new("TextLabel")
	local Right = Instance.new("Folder")
	local Frame = Instance.new("Frame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local Minize = Instance.new("TextButton")
	local Icon = Instance.new("ImageLabel")
	local Large = Instance.new("TextButton")
	local Icon_2 = Instance.new("ImageLabel")
	local Close = Instance.new("TextButton")
	local Icon_3 = Instance.new("ImageLabel")
	local UIStroke = Instance.new("UIStroke")
	local TabFrame = Instance.new("Frame")
	local Line_2 = Instance.new("Frame")
	local SearchFrame = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local IconSearch = Instance.new("ImageLabel")
	local SearchBox = Instance.new("TextBox")
	local ScrollingTab = Instance.new("ScrollingFrame")
	local UIPadding_2 = Instance.new("UIPadding")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local LayoutFrame = Instance.new("Frame")
	local RealLayout = Instance.new("Frame")
	local LayoutList = Instance.new("Folder")
	local UIPageLayout = Instance.new("UIPageLayout")
	local LayoutName = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")
	local DropdownZone = Instance.new("Frame")
	
	TeddyUI_Premium.Name = "TeddyUI_Premium"
	TeddyUI_Premium.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	TeddyUI_Premium.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	TeddyUI_Premium.ResetOnSpawn = false

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = TeddyUI_Premium
	DropShadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadowHolder.Size = UDim2.new(0, 600, 0, 400) -- Increased size
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	Main.Name = "Main"
	Main.Parent = DropShadowHolder
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = ConfigWindow.BackgroundColor
	Main.BackgroundTransparency = 0.050 -- Reduced transparency
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 600, 0, 400) -- Increased size

	UICorner.CornerRadius = UDim.new(0, 8) -- Rounded corners
	UICorner.Parent = Main

	Top.Name = "Top"
	Top.Parent = Main
	Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Top.BackgroundTransparency = 1.000
	Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Top.BorderSizePixel = 0
	Top.Size = UDim2.new(1, 0, 0, 55) -- Slightly taller

	Line.Name = "Line"
	Line.Parent = Top
	Line.BackgroundColor3 = ConfigWindow.AccentColor
	Line.BackgroundTransparency = 0.300 -- Less transparent
	Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 1, -2) -- Thicker line
	Line.Size = UDim2.new(1, 0, 0, 2) -- Thicker line

	Left.Name = "Left"
	Left.Parent = Top

	NameHub.Name = "NameHub"
	NameHub.Parent = Left
	NameHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.BackgroundTransparency = 1.000
	NameHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NameHub.BorderSizePixel = 0
	NameHub.Position = UDim2.new(0, 60, 0, 10)
	NameHub.Size = UDim2.new(0, 470, 0, 24) -- Taller for better typography
	NameHub.Font = Enum.Font.GothamBold
	NameHub.Text = ConfigWindow.Title
	NameHub.TextColor3 = Color3.fromRGB(255, 255, 255)
	NameHub.TextSize = 16.000 -- Larger text
	NameHub.TextXAlignment = Enum.TextXAlignment.Left
	NameHub.TextStrokeTransparency = 0.7 -- Text outline effect

	LogoHub.Name = "LogoHub"
	LogoHub.Parent = Left
	LogoHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoHub.BackgroundTransparency = 1.000
	LogoHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoHub.BorderSizePixel = 0
	LogoHub.Position = UDim2.new(0, 10, 0, 8)
	LogoHub.Size = UDim2.new(0, 40, 0, 40) -- Square logo
	LogoHub.Image = "rbxassetid://89646749075297"

	Desc.Name = "Desc"
	Desc.Parent = Left
	Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Desc.BackgroundTransparency = 1.000
	Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Desc.BorderSizePixel = 0
	Desc.Position = UDim2.new(0, 60, 0, 32)
	Desc.Size = UDim2.new(0, 470, 1, -35)
	Desc.Font = Enum.Font.Gotham
	Desc.Text = ConfigWindow.Description
	Desc.TextColor3 = Color3.fromRGB(180, 180, 180) -- Brighter gray
	Desc.TextSize = 12.000
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.TextYAlignment = Enum.TextYAlignment.Top

	Right.Name = "Right"
	Right.Parent = Top

	Frame.Parent = Right
	Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Frame.BackgroundTransparency = 1.000
	Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Frame.BorderSizePixel = 0
	Frame.Position = UDim2.new(1, -115, 0, 0)
	Frame.Size = UDim2.new(0, 115, 1, 0)

	UIListLayout.Parent = Frame
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 8) -- More spacing

	UIPadding.Parent = Frame
	UIPadding.PaddingTop = UDim.new(0, 12)

	Minize.Name = "Minize"
	Minize.Parent = Frame
	Minize.Active = false
	Minize.AnchorPoint = Vector2.new(0, 0.5)
	Minize.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Minize.BackgroundTransparency = 1.000
	Minize.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Minize.BorderSizePixel = 0
	Minize.Selectable = false
	Minize.Size = UDim2.new(0, 32, 0, 32)
	Minize.Text = ""

	Icon.Name = "Icon"
	Icon.Parent = Minize
	Icon.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon.BackgroundTransparency = 1.000
	Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon.BorderSizePixel = 0
	Icon.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon.Size = UDim2.new(0, 22, 0, 22)
	Icon.Image = "rbxassetid://136452605242985"
	Icon.ImageRectOffset = Vector2.new(288, 672)
	Icon.ImageRectSize = Vector2.new(96, 96)
	Icon.ImageColor3 = Color3.fromRGB(200, 200, 200) -- Gray icons

	Large.Name = "Large"
	Large.Parent = Frame
	Large.Active = false
	Large.AnchorPoint = Vector2.new(0, 0.5)
	Large.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Large.BackgroundTransparency = 1.000
	Large.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Large.BorderSizePixel = 0
	Large.Selectable = false
	Large.Size = UDim2.new(0, 32, 0, 32)
	Large.Text = ""

	Icon_2.Name = "Icon"
	Icon_2.Parent = Large
	Icon_2.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_2.BackgroundTransparency = 1.000
	Icon_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon_2.BorderSizePixel = 0
	Icon_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon_2.Size = UDim2.new(0, 20, 0, 20)
	Icon_2.Image = "rbxassetid://136452605242985"
	Icon_2.ImageRectOffset = Vector2.new(580, 194)
	Icon_2.ImageRectSize = Vector2.new(96, 96)
	Icon_2.ImageColor3 = Color3.fromRGB(200, 200, 200)

	Close.Name = "Close"
	Close.Parent = Frame
	Close.Active = false
	Close.AnchorPoint = Vector2.new(0, 0.5)
	Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Close.BackgroundTransparency = 1.000
	Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Close.BorderSizePixel = 0
	Close.Selectable = false
	Close.Size = UDim2.new(0, 32, 0, 32)
	Close.Text = ""
	
	-- Close button hover effects
	Close.MouseEnter:Connect(function()
		Library:TweenInstance(Icon_3, 0.2, "ImageColor3", Color3.fromRGB(255, 100, 100))
	end)
	
	Close.MouseLeave:Connect(function()
		Library:TweenInstance(Icon_3, 0.2, "ImageColor3", Color3.fromRGB(200, 200, 200))
	end)
	
	Close.MouseButton1Down:Connect(function()
		DropdownZone.Visible = true
		local tat_ = Instance.new("Frame", DropdownZone);
		tat_["BorderSizePixel"] = 0;
		tat_["BackgroundColor3"] = Color3.fromRGB(20, 20, 20);
		tat_["AnchorPoint"] = Vector2.new(0.5, 0.5);
		tat_["Size"] = UDim2.new(0, 400, 0, 180); -- Taller
		tat_["Position"] = UDim2.new(0.5, 0, 0.5, 0);
		tat_["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		tat_["Name"] = [[Tat]];

		local suacc = Instance.new("UIStroke", tat_);
		suacc["Thickness"] = 2;
		suacc["Transparency"] = 0.3;
		suacc["Color"] = ConfigWindow.AccentColor;

		local suacc = Instance.new("UICorner", tat_);
		suacc["CornerRadius"] = UDim.new(0, 8);

		local suacc2 = Instance.new("TextLabel", tat_);
		suacc2["BorderSizePixel"] = 0;
		suacc2["TextSize"] = 20;
		suacc2["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		suacc2["FontFace"] = Font.new("rbxasset://fonts/families/GothamBold.json");
		suacc2["TextColor3"] = Color3.fromRGB(255, 255, 255);
		suacc2["BackgroundTransparency"] = 1;
		suacc2["Size"] = UDim2.new(0, 400, 0, 60);
		suacc2["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		suacc2["Text"] = "Are you sure?";
		suacc2["Position"] = UDim2.new(0, 0, 0, 10);

		local descLabel = Instance.new("TextLabel", tat_);
		descLabel["BorderSizePixel"] = 0;
		descLabel["TextSize"] = 14;
		descLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		descLabel["FontFace"] = Font.new("rbxasset://fonts/families/Gotham.json");
		descLabel["TextColor3"] = Color3.fromRGB(180, 180, 180);
		descLabel["BackgroundTransparency"] = 1;
		descLabel["Size"] = UDim2.new(0, 360, 0, 40);
		descLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		descLabel["Text"] = "This will close the entire interface.";
		descLabel["Position"] = UDim2.new(0, 20, 0, 60);
		descLabel["TextXAlignment"] = Enum.TextXAlignment.Center;

		local buttonContainer = Instance.new("Frame", tat_);
		buttonContainer["BorderSizePixel"] = 0;
		buttonContainer["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		buttonContainer["BackgroundTransparency"] = 1;
		buttonContainer["Size"] = UDim2.new(1, 0, 0, 60);
		buttonContainer["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		buttonContainer["Position"] = UDim2.new(0, 0, 1, -70);

		local btnno = Instance.new("TextButton", buttonContainer);
		btnno["BorderSizePixel"] = 0;
		btnno["TextSize"] = 14;
		btnno["TextColor3"] = Color3.fromRGB(255, 255, 255);
		btnno["BackgroundColor3"] = ConfigWindow.SecondaryColor;
		btnno["FontFace"] = Font.new("rbxasset://fonts/families/GothamBold.json");
		btnno["AnchorPoint"] = Vector2.new(0.5, 0.5);
		btnno["Size"] = UDim2.new(0, 140, 0, 40);
		btnno["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		btnno["Text"] = "No";
		btnno["Position"] = UDim2.new(0.3, 0, 0.5, 0);
		
		btnno.MouseEnter:Connect(function()
			Library:TweenInstance(btnno, 0.2, "BackgroundColor3", Color3.fromRGB(30, 30, 30))
		end)
		
		btnno.MouseLeave:Connect(function()
			Library:TweenInstance(btnno, 0.2, "BackgroundColor3", ConfigWindow.SecondaryColor)
		end)
		
		btnno.MouseButton1Down:Connect(function()
			tat_:Destroy()
			DropdownZone.Visible = false
		end)
		
		local btnyes = Instance.new("TextButton", buttonContainer);
		btnyes["BorderSizePixel"] = 0;
		btnyes["TextSize"] = 14;
		btnyes["TextColor3"] = Color3.fromRGB(255, 255, 255);
		btnyes["BackgroundColor3"] = ConfigWindow.AccentColor;
		btnyes["FontFace"] = Font.new("rbxasset://fonts/families/GothamBold.json");
		btnyes["AnchorPoint"] = Vector2.new(0.5, 0.5);
		btnyes["Size"] = UDim2.new(0, 140, 0, 40);
		btnyes["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		btnyes["Text"] = "Yes";
		btnyes["Position"] = UDim2.new(0.7, 0, 0.5, 0);
		
		btnyes.MouseEnter:Connect(function()
			Library:TweenInstance(btnyes, 0.2, "BackgroundTransparency", 0.1)
		end)
		
		btnyes.MouseLeave:Connect(function()
			Library:TweenInstance(btnyes, 0.2, "BackgroundTransparency", 0)
		end)

		btnyes.MouseButton1Down:Connect(function()
			TeddyUI_Premium:Destroy()
		end)

		local thuaaa = Instance.new("UICorner", btnyes);
		thuaaa["CornerRadius"] = UDim.new(0, 6);

		local thuaaa = Instance.new("UIStroke", btnyes);
		thuaaa["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
		thuaaa["Color"] = ConfigWindow.AccentColor;
		thuaaa["Transparency"] = 0.5;

		local thuaa = Instance.new("UICorner", btnno);
		thuaa["CornerRadius"] = UDim.new(0, 6);

		local thuaa = Instance.new("UIStroke", btnno);
		thuaa["ApplyStrokeMode"] = Enum.ApplyStrokeMode.Border;
		thuaa["Color"] = Color3.fromRGB(60, 60, 60);
	end)
	
	Icon_3.Name = "Icon"
	Icon_3.Parent = Close
	Icon_3.AnchorPoint = Vector2.new(0.5, 0.5)
	Icon_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Icon_3.BackgroundTransparency = 1.000
	Icon_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Icon_3.BorderSizePixel = 0
	Icon_3.Position = UDim2.new(0.5, 0, 0.5, 0)
	Icon_3.Size = UDim2.new(0, 22, 0, 22)
	Icon_3.Image = "rbxassetid://105957381820378"
	Icon_3.ImageRectOffset = Vector2.new(480, 0)
	Icon_3.ImageRectSize = Vector2.new(96, 96)
	Icon_3.ImageColor3 = Color3.fromRGB(200, 200, 200)

	UIStroke.Color = ConfigWindow.AccentColor
	UIStroke.Thickness = 2 -- Thicker stroke
	UIStroke.Transparency = 0.3
	UIStroke.Parent = Main

	TabFrame.Name = "TabFrame"
	TabFrame.Parent = Main
	TabFrame.BackgroundColor3 = ConfigWindow.SecondaryColor
	TabFrame.BackgroundTransparency = 0 -- Solid background
	TabFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabFrame.BorderSizePixel = 0
	TabFrame.Position = UDim2.new(0, 0, 0, 55)
	TabFrame.Size = UDim2.new(0, 160, 1, -55) -- Wider tab panel

	Line_2.Name = "Line"
	Line_2.Parent = TabFrame
	Line_2.BackgroundColor3 = ConfigWindow.AccentColor
	Line_2.BackgroundTransparency = 0.3
	Line_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Line_2.BorderSizePixel = 0
	Line_2.Position = UDim2.new(1, -1, 0, 0)
	Line_2.Size = UDim2.new(0, 1, 1, 0)

	SearchFrame.Name = "SearchFrame"
	SearchFrame.Parent = TabFrame
	SearchFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25) -- Darker search box
	SearchFrame.BackgroundTransparency = 0
	SearchFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchFrame.BorderSizePixel = 0
	SearchFrame.Position = UDim2.new(0, 10, 0, 10)
	SearchFrame.Size = UDim2.new(1, -20, 0, 35) -- Taller

	UICorner_2.CornerRadius = UDim.new(0, 6) -- More rounded
	UICorner_2.Parent = SearchFrame

	IconSearch.Name = "IconSearch"
	IconSearch.Parent = SearchFrame
	IconSearch.AnchorPoint = Vector2.new(0, 0.5)
	IconSearch.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	IconSearch.BackgroundTransparency = 1.000
	IconSearch.BorderColor3 = Color3.fromRGB(0, 0, 0)
	IconSearch.BorderSizePixel = 0
	IconSearch.Position = UDim2.new(0, 10, 0.5, 0)
	IconSearch.Size = UDim2.new(0, 18, 0, 18)
	IconSearch.Image = "rbxassetid://71309835376233"
	IconSearch.ImageColor3 = Color3.fromRGB(150, 150, 150)

	SearchBox.Name = "SearchBox"
	SearchBox.Parent = SearchFrame
	SearchBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.BackgroundTransparency = 1.000
	SearchBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SearchBox.BorderSizePixel = 0
	SearchBox.ClipsDescendants = true
	SearchBox.Position = UDim2.new(0, 40, 0, 0)
	SearchBox.Size = UDim2.new(1, -40, 1, 0)
	SearchBox.Font = Enum.Font.Gotham
	SearchBox.PlaceholderText = "Search section or function"
	SearchBox.PlaceholderColor3 = Color3.fromRGB(120, 120, 120)
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
	SearchBox.TextSize = 13.000
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left

	ScrollingTab.Name = "ScrollingTab"
	ScrollingTab.Parent = TabFrame
	ScrollingTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ScrollingTab.BackgroundTransparency = 1.000
	ScrollingTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ScrollingTab.BorderSizePixel = 0
	ScrollingTab.Position = UDim2.new(0, 0, 0, 55)
	ScrollingTab.Selectable = false
	ScrollingTab.Size = UDim2.new(1, 0, 1, -55)
	ScrollingTab.ScrollBarThickness = 0
	ScrollingTab.ScrollBarImageColor3 = ConfigWindow.AccentColor
	ScrollingTab.ScrollBarImageTransparency = 0.7
	
	-- Add subtle gradient to tabs
	local gradient = Instance.new("UIGradient", ScrollingTab)
	gradient.Rotation = 90
	gradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0),
		NumberSequenceKeypoint.new(0.1, 0),
		NumberSequenceKeypoint.new(0.9, 0.3),
		NumberSequenceKeypoint.new(1, 0.5)
	})
	
	self:UpdateScrolling(ScrollingTab, UIListLayout_2)
	UIPadding_2.Parent = ScrollingTab
	UIPadding_2.PaddingBottom = UDim.new(0, 5)
	UIPadding_2.PaddingLeft = UDim.new(0, 10)
	UIPadding_2.PaddingRight = UDim.new(0, 10)
	UIPadding_2.PaddingTop = UDim.new(0, 5)

	UIListLayout_2.Parent = ScrollingTab
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_2.Padding = UDim.new(0, 8) -- More spacing between tabs

	LayoutFrame.Name = "LayoutFrame"
	LayoutFrame.Parent = Main
	LayoutFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LayoutFrame.BackgroundTransparency = 1.000
	LayoutFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LayoutFrame.BorderSizePixel = 0
	LayoutFrame.Position = UDim2.new(0, 160, 0, 55)
	LayoutFrame.Size = UDim2.new(1, -160, 1, -55)
	LayoutFrame.ClipsDescendants = true

	RealLayout.Name = "RealLayout"
	RealLayout.Parent = LayoutFrame
	RealLayout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RealLayout.BackgroundTransparency = 1.000
	RealLayout.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RealLayout.BorderSizePixel = 0
	RealLayout.Position = UDim2.new(0, 0, 0, 45)
	RealLayout.Size = UDim2.new(1, 0, 1, -45)

	LayoutList.Name = "Layout List"
	LayoutList.Parent = RealLayout

	UIPageLayout.Parent = LayoutList
	UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIPageLayout.EasingStyle = Enum.EasingStyle.Quad
	UIPageLayout.TweenTime = 0.300

	LayoutName.Name = "LayoutName"
	LayoutName.Parent = LayoutFrame
	LayoutName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LayoutName.BackgroundTransparency = 1.000
	LayoutName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LayoutName.BorderSizePixel = 0
	LayoutName.Size = UDim2.new(1, 0, 0, 45)

	TextLabel.Parent = LayoutName
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0, 15, 0, 0)
	TextLabel.Size = UDim2.new(1, -15, 1, 0)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = ""
	TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.TextSize = 16.000 -- Larger text
	TextLabel.TextXAlignment = Enum.TextXAlignment.Left
	TextLabel.TextStrokeTransparency = 0.7

	DropdownZone.Name = "DropdownZone"
	DropdownZone.Parent = Main
	DropdownZone.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	DropdownZone.BackgroundTransparency = 1
	DropdownZone.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DropdownZone.BorderSizePixel = 0
	DropdownZone.Size = UDim2.new(1, 0, 1, 0)
	DropdownZone.Visible = false
	DropdownZone.ZIndex = 10
	
	self:MakeDraggable(Top, DropShadowHolder)
	
	-- Add window control button hover effects
	local function setupButtonHover(button, icon)
		button.MouseEnter:Connect(function()
			Library:TweenInstance(button, 0.2, "BackgroundTransparency", 0.9)
			Library:TweenInstance(icon, 0.2, "ImageColor3", Color3.fromRGB(255, 255, 255))
		end)
		
		button.MouseLeave:Connect(function()
			Library:TweenInstance(button, 0.2, "BackgroundTransparency", 1)
			Library:TweenInstance(icon, 0.2, "ImageColor3", Color3.fromRGB(200, 200, 200))
		end)
	end
	
	setupButtonHover(Minize, Icon)
	setupButtonHover(Large, Icon_2)
	setupButtonHover(Close, Icon_3)
	
	-- Add minimize functionality
	local isMinimized = false
	local originalSize = DropShadowHolder.Size
	local minimizedSize = UDim2.new(0, 600, 0, 55) -- Only show title bar
	
	Minize.MouseButton1Click:Connect(function()
		isMinimized = not isMinimized
		if isMinimized then
			Library:TweenInstance(DropShadowHolder, 0.3, "Size", minimizedSize)
			Icon.ImageRectOffset = Vector2.new(384, 672) -- Change to restore icon
		else
			Library:TweenInstance(DropShadowHolder, 0.3, "Size", originalSize)
			Icon.ImageRectOffset = Vector2.new(288, 672) -- Change to minimize icon
		end
	end)
	
	-- Add maximize functionality
	local isMaximized = false
	local originalPosition = DropShadowHolder.Position
	local originalSize = DropShadowHolder.Size
	
	Large.MouseButton1Click:Connect(function()
		isMaximized = not isMaximized
		if isMaximized then
			Library:TweenInstance(DropShadowHolder, 0.3, "Size", UDim2.new(0, 800, 0, 500))
			Icon_2.ImageRectOffset = Vector2.new(676, 194) -- Change to restore icon
		else
			Library:TweenInstance(DropShadowHolder, 0.3, "Size", originalSize)
			Icon_2.ImageRectOffset = Vector2.new(580, 194) -- Change to maximize icon
		end
	end)
	
	local AllLayouts = 0
	local Tab = {}
	
	function Tab:T(t)
		local TabDisable = Instance.new("Frame")
		local Choose_2 = Instance.new("Frame")
		local UICorner_4 = Instance.new("UICorner")
		local NameTab_2 = Instance.new("TextLabel")
		local Click_Tab_2 = Instance.new("TextButton")
		local Layout = Instance.new("ScrollingFrame")
		local UIPadding_3 = Instance.new("UIPadding")
		local UIListLayout_3 = Instance.new("UIListLayout")
		
		TabDisable.Name = "TabDisable"
		TabDisable.Parent = ScrollingTab
		TabDisable.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabDisable.BackgroundTransparency = 1.000
		TabDisable.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabDisable.BorderSizePixel = 0
		TabDisable.Size = UDim2.new(1, 0, 0, 32) -- Taller tab buttons

		Choose_2.Name = "Choose"
		Choose_2.Parent = TabDisable
		Choose_2.BackgroundColor3 = ConfigWindow.AccentColor
		Choose_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Choose_2.BorderSizePixel = 0
		Choose_2.Position = UDim2.new(0, 0, 0, 8)
		Choose_2.Size = UDim2.new(0, 4, 0, 16)
		Choose_2.Visible = false

		UICorner_4.CornerRadius = UDim.new(1, 0)
		UICorner_4.Parent = Choose_2

		NameTab_2.Name = "NameTab"
		NameTab_2.Parent = TabDisable
		NameTab_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NameTab_2.BackgroundTransparency = 1.000
		NameTab_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NameTab_2.BorderSizePixel = 0
		NameTab_2.Position = UDim2.new(0, 15, 0, 0)
		NameTab_2.Size = UDim2.new(1, -15, 1, 0)
		NameTab_2.Font = Enum.Font.GothamBold
		NameTab_2.Text = t
		NameTab_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		NameTab_2.TextSize = 13.000
		NameTab_2.TextTransparency = 0.500
		NameTab_2.TextXAlignment = Enum.TextXAlignment.Left

		Click_Tab_2.Name = "Click_Tab"
		Click_Tab_2.Parent = TabDisable
		Click_Tab_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click_Tab_2.BackgroundTransparency = 1.000
		Click_Tab_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click_Tab_2.BorderSizePixel = 0
		Click_Tab_2.Size = UDim2.new(1, 0, 1, 0)
		Click_Tab_2.Font = Enum.Font.SourceSans
		Click_Tab_2.Text = ""
		Click_Tab_2.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click_Tab_2.TextSize = 14.000
		
		-- Tab button hover effect
		Click_Tab_2.MouseEnter:Connect(function()
			if not Choose_2.Visible then
				Library:TweenInstance(NameTab_2, 0.2, "TextTransparency", 0.3)
				Library:TweenInstance(TabDisable, 0.2, "BackgroundTransparency", 0.95)
			end
		end)
		
		Click_Tab_2.MouseLeave:Connect(function()
			if not Choose_2.Visible then
				Library:TweenInstance(NameTab_2, 0.2, "TextTransparency", 0.5)
				Library:TweenInstance(TabDisable, 0.2, "BackgroundTransparency", 1)
			end
		end)

		Layout.Name = "Layout"
		Layout.Parent = LayoutList
		Layout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Layout.BackgroundTransparency = 1.000
		Layout.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Layout.BorderSizePixel = 0
		Layout.Selectable = false
		Layout.Size = UDim2.new(1, 0, 1, 0)
		Layout.CanvasSize = UDim2.new(0, 0, 1, 0)
		Layout.ScrollBarThickness = 3
		Layout.ScrollBarImageColor3 = ConfigWindow.AccentColor
		Layout.ScrollBarImageTransparency = 0.7
		Layout.LayoutOrder = AllLayouts
		Library:UpdateScrolling(Layout, UIListLayout_3)
		
		UIPadding_3.Parent = Layout
		UIPadding_3.PaddingBottom = UDim.new(0, 10)
		UIPadding_3.PaddingLeft = UDim.new(0, 15)
		UIPadding_3.PaddingRight = UDim.new(0, 10)
		UIPadding_3.PaddingTop = UDim.new(0, 10)

		UIListLayout_3.Parent = Layout
		UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_3.Padding = UDim.new(0, 12) -- More spacing between elements
		
		if AllLayouts == 0 then
			NameTab_2.TextTransparency = 0
			Choose_2.Visible = true
			UIPageLayout:JumpToIndex(0)
			TextLabel.Text = t
		end
		
		Click_Tab_2.Activated:Connect(function()
			TextLabel.Text = t
			for i, v in next, ScrollingTab:GetChildren() do
				if v:IsA("Frame") then
					Library:TweenInstance(v.NameTab, 0.3, "TextTransparency", 0.5)
					v.Choose.Visible = false
					Library:TweenInstance(v, 0.2, "BackgroundTransparency", 1)
				end
			end
			Library:TweenInstance(NameTab_2, 0.2, "TextTransparency", 0)
			UIPageLayout:JumpToIndex(Layout.LayoutOrder)
			Choose_2.Visible = true
			Library:TweenInstance(TabDisable, 0.2, "BackgroundTransparency", 0.9)
		end)
		
		AllLayouts = AllLayouts + 1
		local TabFunc = {}
		
		function TabFunc:AddSection(RealNameSection)
			local Section = Instance.new("Frame")
			local UICorner_5 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local NameSection = Instance.new("Frame")
			local Title = Instance.new("TextLabel")
			local Line_3 = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("Frame")
			local UIPadding_4 = Instance.new("UIPadding")
			local UIListLayout_4 = Instance.new("UIListLayout")
			
			Section.Name = "Section"
			Section.Parent = Layout
			Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Section.BackgroundTransparency = 0.970 -- More transparent
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Position = UDim2.new(1.36775815, 0, 0.545454562, 0)
			Section.Size = UDim2.new(1, 0, 0, 60) -- Taller

			UICorner_5.CornerRadius = UDim.new(0, 8) -- More rounded
			UICorner_5.Parent = Section

			UIStroke_2.Color = ConfigWindow.AccentColor -- Use accent color
			UIStroke_2.Thickness = 1.5
			UIStroke_2.Transparency = 0.8000000166893005
			UIStroke_2.Parent = Section

			NameSection.Name = "NameSection"
			NameSection.Parent = Section
			NameSection.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NameSection.BackgroundTransparency = 1.000
			NameSection.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NameSection.BorderSizePixel = 0
			NameSection.Size = UDim2.new(1, 0, 0, 35)

			Title.Name = "Title"
			Title.Parent = NameSection
			Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1.000
			Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 1, 0)
			Title.Font = Enum.Font.GothamBold
			Title.Text = RealNameSection
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.TextSize = 14.000
			Title.TextStrokeTransparency = 0.8

			Line_3.Name = "Line"
			Line_3.Parent = NameSection
			Line_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Line_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line_3.BorderSizePixel = 0
			Line_3.Position = UDim2.new(0, 0, 1, -2)
			Line_3.Size = UDim2.new(1, 0, 0, 1) -- Thinner line

			UIGradient.Color = ColorSequence.new { 
				ColorSequenceKeypoint.new(0.00, Color3.fromRGB(24, 24, 25)), 
				ColorSequenceKeypoint.new(0.52, ConfigWindow.AccentColor), 
				ColorSequenceKeypoint.new(1.00, Color3.fromRGB(24, 24, 25)) 
			}
			UIGradient.Transparency = NumberSequence.new { 
				NumberSequenceKeypoint.new(0.00, 0.53), 
				NumberSequenceKeypoint.new(0.51, 0.00), 
				NumberSequenceKeypoint.new(1.00, 0.51) 
			}
			UIGradient.Parent = Line_3

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionList.BackgroundTransparency = 1.000
			SectionList.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionList.BorderSizePixel = 0
			SectionList.Position = UDim2.new(0, 0, 0, 40)
			SectionList.Size = UDim2.new(1, 0, 1, -40)

			UIPadding_4.Parent = SectionList
			UIPadding_4.PaddingBottom = UDim.new(0, 10)
			UIPadding_4.PaddingLeft = UDim.new(0, 10)
			UIPadding_4.PaddingRight = UDim.new(0, 10)
			UIPadding_4.PaddingTop = UDim.new(0, 10)

			UIListLayout_4.Parent = SectionList
			UIListLayout_4.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_4.Padding = UDim.new(0, 8)
			UIListLayout_4:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				Section.Size = UDim2.new(1, 0, 0, UIListLayout_4.AbsoluteContentSize.Y + 60)
			end)
			
			local SectionFunc = {}
			
			-- Add hover effects function for elements
			local function addHoverEffect(frame, normalTransparency, hoverTransparency)
				frame.MouseEnter:Connect(function()
					if frame.BackgroundTransparency ~= 1 then
						Library:TweenInstance(frame, 0.2, "BackgroundTransparency", hoverTransparency)
					end
				end)
				
				frame.MouseLeave:Connect(function()
					if frame.BackgroundTransparency ~= 1 then
						Library:TweenInstance(frame, 0.2, "BackgroundTransparency", normalTransparency)
					end
				end)
			end
			
			function SectionFunc:AddToggle(cftoggle)
				local cftoggle = Library:MakeConfig({
					Title = "Toggle < Missing Title >",
					Description = "",
					Default = false,
					Callback = function() end
				}, cftoggle or {})
				
				local Toggle = Instance.new("Frame")
				local UICorner_6 = Instance.new("UICorner")
				local Title_2 = Instance.new("TextLabel")
				local ToggleCheck = Instance.new("Frame")
				local UICorner_7 = Instance.new("UICorner")
				local Check = Instance.new("Frame")
				local UICorner_8 = Instance.new("UICorner")
				local Toggle_Click = Instance.new("TextButton")
				local Content = Instance.new("TextLabel")
				
				Toggle.Name = "Toggle"
				Toggle.Parent = SectionList
				Toggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle.BackgroundTransparency = 0.950
				Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle.BorderSizePixel = 0
				Toggle.Size = UDim2.new(1, 0, 0, 40) -- Taller

				UICorner_6.CornerRadius = UDim.new(0, 6) -- More rounded
				UICorner_6.Parent = Toggle

				Title_2.Name = "Title"
				Title_2.Parent = Toggle
				Title_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_2.BackgroundTransparency = 1.000
				Title_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_2.BorderSizePixel = 0
				Title_2.Position = UDim2.new(0, 12, 0, 0)
				Title_2.Size = UDim2.new(1, -70, 1, 0)
				Title_2.Font = Enum.Font.GothamBold
				Title_2.Text = cftoggle.Title
				Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_2.TextSize = 13.000
				Title_2.TextXAlignment = Enum.TextXAlignment.Left

				ToggleCheck.Name = "ToggleCheck"
				ToggleCheck.Parent = Toggle
				ToggleCheck.AnchorPoint = Vector2.new(0, 0.5)
				ToggleCheck.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
				ToggleCheck.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ToggleCheck.BorderSizePixel = 0
				ToggleCheck.Position = UDim2.new(1, -55, 0.5, 0)
				ToggleCheck.Size = UDim2.new(0, 45, 0, 24) -- Larger toggle

				UICorner_7.CornerRadius = UDim.new(1, 0)
				UICorner_7.Parent = ToggleCheck

				Check.Name = "Check"
				Check.Parent = ToggleCheck
				Check.AnchorPoint = Vector2.new(0, 0.5)
				Check.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
				Check.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Check.BorderSizePixel = 0
				Check.Position = UDim2.new(0, 4, 0.5, 0)
				Check.Size = UDim2.new(0, 16, 0, 16)

				UICorner_8.CornerRadius = UDim.new(1, 0)
				UICorner_8.Parent = Check

				Toggle_Click.Name = "Toggle_Click"
				Toggle_Click.Parent = Toggle
				Toggle_Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Toggle_Click.BackgroundTransparency = 1.000
				Toggle_Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle_Click.BorderSizePixel = 0
				Toggle_Click.Size = UDim2.new(1, 0, 1, 0)
				Toggle_Click.Font = Enum.Font.SourceSans
				Toggle_Click.Text = ""
				Toggle_Click.TextColor3 = Color3.fromRGB(0, 0, 0)
				Toggle_Click.TextSize = 14.000

				Content.Name = "Content"
				Content.Parent = Toggle
				Content.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Content.BackgroundTransparency = 1.000
				Content.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Content.BorderSizePixel = 0
				Content.Position = UDim2.new(0, 12, 0, 22)
				Content.Size = UDim2.new(1, -70, 1, 0)
				Content.Font = Enum.Font.Gotham
				Content.Text = cftoggle.Description
				Content.TextColor3 = Color3.fromRGB(180, 180, 180)
				Content.TextSize = 12.000
				Content.TextXAlignment = Enum.TextXAlignment.Left
				Content.TextYAlignment = Enum.TextYAlignment.Top
				
				Library:UpdateContent(Content, Title_2, Toggle)
				addHoverEffect(Toggle, 0.95, 0.93)
				
				local ToggleFunc = { Value = cftoggle.Default }
				
				function ToggleFunc:Set(Boolean)
					if Boolean then
						Library:TweenInstance(ToggleCheck, 0.3, "BackgroundColor3", ConfigWindow.AccentColor)
						Library:TweenInstance(Check, 0.3, "Position", UDim2.new(0, 26, 0.5, 0))
						Library:TweenInstance(Check, 0.3, "BackgroundColor3", Color3.fromRGB(255, 255, 255))
					else
						Library:TweenInstance(ToggleCheck, 0.3, "BackgroundColor3", Color3.fromRGB(60, 60, 60))
						Library:TweenInstance(Check, 0.3, "BackgroundColor3", Color3.fromRGB(200, 200, 200))
						Library:TweenInstance(Check, 0.3, "Position", UDim2.new(0, 4, 0.5, 0))
					end
					self.Value = Boolean
					cftoggle.Callback(Boolean)
				end

				ToggleFunc:Set(ToggleFunc.Value)
				Toggle_Click.Activated:Connect(function()
					Toggle.BackgroundTransparency = 0.93
					ToggleFunc:Set(not ToggleFunc.Value)
					task.wait(0.1)
					Library:TweenInstance(Toggle, 0.2, "BackgroundTransparency", 0.95)
				end)
				
				return ToggleFunc
			end
			
			-- Continue with other functions (Button, Dropdown, Input, Slider, etc.)
			-- Make similar improvements to all other UI elements
			
			function SectionFunc:AddButton(cfbutton)
				local cfbutton = Library:MakeConfig({
					Title = "Button < Missing Title >",
					Description = "",
					Callback = function() end
				}, cfbutton or {})
				
				local Button = Instance.new("Frame")
				local UICorner_9 = Instance.new("UICorner")
				local Title_3 = Instance.new("TextLabel")
				local Button_Click = Instance.new("TextButton")
				local Content_2 = Instance.new("TextLabel")
				local ImageLabel = Instance.new("ImageLabel")
				
				Button.Name = "Button"
				Button.Parent = SectionList
				Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button.BackgroundTransparency = 0.950
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(1, 0, 0, 40)

				UICorner_9.CornerRadius = UDim.new(0, 6)
				UICorner_9.Parent = Button

				Title_3.Name = "Title"
				Title_3.Parent = Button
				Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_3.BackgroundTransparency = 1.000
				Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_3.BorderSizePixel = 0
				Title_3.Position = UDim2.new(0, 12, 0, 0)
				Title_3.Size = UDim2.new(1, -70, 1, 0)
				Title_3.Font = Enum.Font.GothamBold
				Title_3.Text = cfbutton.Title
				Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_3.TextSize = 13.000
				Title_3.TextXAlignment = Enum.TextXAlignment.Left

				Button_Click.Name = "Button_Click"
				Button_Click.Parent = Button
				Button_Click.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Button_Click.BackgroundTransparency = 1.000
				Button_Click.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button_Click.BorderSizePixel = 0
				Button_Click.Size = UDim2.new(1, 0, 1, 0)
				Button_Click.Font = Enum.Font.SourceSans
				Button_Click.Text = ""
				Button_Click.TextColor3 = Color3.fromRGB(0, 0, 0)
				Button_Click.TextSize = 14.000

				Content_2.Name = "Content"
				Content_2.Parent = Button
				Content_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Content_2.BackgroundTransparency = 1.000
				Content_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Content_2.BorderSizePixel = 0
				Content_2.Position = UDim2.new(0, 12, 0, 22)
				Content_2.Size = UDim2.new(1, -70, 1, 0)
				Content_2.Font = Enum.Font.Gotham
				Content_2.Text = cfbutton.Description
				Content_2.TextColor3 = Color3.fromRGB(180, 180, 180)
				Content_2.TextSize = 12.000
				Content_2.TextXAlignment = Enum.TextXAlignment.Left
				Content_2.TextYAlignment = Enum.TextYAlignment.Top

				ImageLabel.Parent = Button
				ImageLabel.AnchorPoint = Vector2.new(0, 0.5)
				ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ImageLabel.BackgroundTransparency = 1.000
				ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ImageLabel.BorderSizePixel = 0
				ImageLabel.Position = UDim2.new(1, -35, 0.5, 0)
				ImageLabel.Size = UDim2.new(0, 24, 0, 24)
				ImageLabel.Image = "rbxassetid://85905776508942"
				ImageLabel.ImageColor3 = ConfigWindow.AccentColor
				
				Library:UpdateContent(Content_2, Title_3, Button)
				addHoverEffect(Button, 0.95, 0.93)
				
				Button_Click.Activated:Connect(function()
					Button.BackgroundTransparency = 0.93
					Button.BackgroundColor3 = ConfigWindow.AccentColor
					cfbutton.Callback()
					task.wait(0.1)
					Library:TweenInstance(Button, 0.2, "BackgroundTransparency", 0.95)
					Library:TweenInstance(Button, 0.2, "BackgroundColor3", Color3.fromRGB(255, 255, 255))
				end)
			end
			
			-- Continue with improved versions of other functions...
			
			return SectionFunc
		end
		
		return TabFunc
	end
	
	-- Create toggle button for UI
	local G2L = {};

	G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
	G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;
	G2L["1"]["ResetOnSpawn"] = false;

	G2L["2"] = Instance.new("ImageButton", G2L["1"]);
	G2L["2"]["BorderSizePixel"] = 0;
	G2L["2"].Visible = true
	self:MakeDraggable(G2L["2"],G2L["2"])
	G2L["2"]["BackgroundColor3"] = ConfigWindow.AccentColor;
	G2L["2"]["Image"] = "rbxassetid://136103435617044";
	G2L["2"]["Size"] = UDim2.new(0, 55, 0, 55);
	G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	G2L["2"]["Position"] = UDim2.new(0.95, -60, 0.05, 0);
	G2L["2"]["ZIndex"] = 100;

	local corner = Instance.new("UICorner", G2L["2"]);
	corner["CornerRadius"] = UDim.new(1, 0);

	local stroke = Instance.new("UIStroke", G2L["2"]);
	stroke["Thickness"] = 2;
	stroke["Color"] = Color3.fromRGB(255, 255, 255);
	stroke["Transparency"] = 0.5;
	
	-- Add glow effect
	local glow = Instance.new("ImageLabel", G2L["2"])
	glow.Name = "Glow"
	glow.BackgroundTransparency = 1
	glow.Size = UDim2.new(1.5, 0, 1.5, 0)
	glow.Position = UDim2.new(-0.25, 0, -0.25, 0)
	glow.Image = "rbxassetid://4996891970"
	glow.ImageColor3 = ConfigWindow.AccentColor
	glow.ImageTransparency = 0.8
	glow.ZIndex = -1
	
	G2L["2"].MouseButton1Click:Connect(function()
		TeddyUI_Premium.Enabled = not TeddyUI_Premium.Enabled
	end)
	
	Minize.MouseButton1Click:Connect(function()
		TeddyUI_Premium.Enabled = false
	end)
	
	return Tab
end

return Library

