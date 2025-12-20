-- TEDDY UI - GRAY WHITE THEME FULL VERSION (2025)
-- Đã bổ sung hoàn chỉnh: Dropdown, Slider, Textbox, Paragraph, Button, Toggle...

local Library = {}

function Library:TweenInstance(obj, time, prop, value)
	game:GetService("TweenService"):Create(obj, TweenInfo.new(time, Enum.EasingStyle.Quad), {[prop] = value}):Play()
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

function Library:MakeConfig(default, custom)
	for i, v in pairs(default) do
		if custom[i] == nil then custom[i] = v end
	end
	return custom
end

function Library:MakeDraggable(topbar, object)
	local dragging, dragInput, dragStart, startPos
	topbar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = object.Position
		end
	end)
	topbar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if dragging and input == dragInput then
			local delta = input.Position - dragStart
			object.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
	topbar.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)
end

function Library:NewWindow(config)
	config = self:MakeConfig({Title = "Teddy Hub", Description = "Gray White Theme"}, config or {})

	local ScreenGui = Instance.new("ScreenGui")
	ScreenGui.Name = "TeddyUI_GrayWhite"
	ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	ScreenGui.ResetOnSpawn = false

	local DropShadowHolder = Instance.new("Frame")
	DropShadowHolder.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadowHolder.BackgroundTransparency = 1
	DropShadowHolder.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadowHolder.Size = UDim2.new(0, 580, 0, 380)
	DropShadowHolder.Parent = ScreenGui

	local DropShadow = Instance.new("ImageLabel")
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.new(0,0,0)
	DropShadow.ImageTransparency = 0.6
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49,49,450,450)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.Position = UDim2.new(0.5,0,0.5,0)
	DropShadow.AnchorPoint = Vector2.new(0.5,0.5)
	DropShadow.BackgroundTransparency = 1
	DropShadow.Parent = DropShadowHolder

	local Main = Instance.new("Frame")
	Main.Size = UDim2.new(0, 580, 0, 380)
	Main.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
	Main.Position = UDim2.new(0.5,0,0.5,0)
	Main.AnchorPoint = Vector2.new(0.5,0.5)
	Main.Parent = DropShadowHolder
	Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 10)
	Instance.new("UIStroke", Main).Color = Color3.fromRGB(70,70,70)

	local Topbar = Instance.new("Frame")
	Topbar.Size = UDim2.new(1,0,0,50)
	Topbar.BackgroundTransparency = 1
	Topbar.Parent = Main

	local AccentLine = Instance.new("Frame")
	AccentLine.Size = UDim2.new(1,0,0,1)
	AccentLine.Position = UDim2.new(0,0,1,-1)
	AccentLine.BackgroundColor3 = Color3.fromRGB(255,255,255)
	AccentLine.BackgroundTransparency = 0.7
	AccentLine.Parent = Topbar

	local Title = Instance.new("TextLabel")
	Title.Text = config.Title
	Title.Size = UDim2.new(0,200,0,30)
	Title.Position = UDim2.new(0,60,0,10)
	Title.BackgroundTransparency = 1
	Title.TextColor3 = Color3.new(1,1,1)
	Title.Font = Enum.Font.GothamBold
	Title.TextSize = 16
	Title.TextXAlignment = Enum.TextXAlignment.Left
	Title.Parent = Topbar

	local Desc = Instance.new("TextLabel")
	Desc.Text = config.Description
	Desc.Size = UDim2.new(0,400,0,20)
	Desc.Position = UDim2.new(0,60,0,30)
	Desc.BackgroundTransparency = 1
	Desc.TextColor3 = Color3.fromRGB(180,180,180)
	Desc.Font = Enum.Font.Gotham
	Desc.TextSize = 12
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.Parent = Topbar

	-- Nút mở UI
	local OpenBtn = Instance.new("ImageButton")
	OpenBtn.Size = UDim2.new(0,60,0,60)
	OpenBtn.Position = UDim2.new(0.02,0,0.8,0)
	OpenBtn.Image = "rbxassetid://136103435617044"
	OpenBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
	OpenBtn.Parent = ScreenGui
	Instance.new("UICorner", OpenBtn).CornerRadius = UDim.new(1,0)
	local s = Instance.new("UIStroke", OpenBtn)
	s.Color = Color3.new(1,1,1)
	s.Thickness = 2
	self:MakeDraggable(OpenBtn, OpenBtn)
	OpenBtn.MouseButton1Click:Connect(function()
		DropShadowHolder.Visible = not DropShadowHolder.Visible
	end)

	self:MakeDraggable(Topbar, DropShadowHolder)

	local TabContainer = Instance.new("Frame")
	TabContainer.Size = UDim2.new(0,150,1,-50)
	TabContainer.Position = UDim2.new(0,0,0,50)
	TabContainer.BackgroundTransparency = 1
	TabContainer.Parent = Main

	local TabScrolling = Instance.new("ScrollingFrame")
	TabScrolling.Size = UDim2.new(1,0,1,0)
	TabScrolling.BackgroundTransparency = 1
	TabScrolling.ScrollBarThickness = 0
	TabScrolling.Parent = TabContainer
	Instance.new("UIListLayout", TabScrolling).Padding = UDim.new(0,5)

	local ContentArea = Instance.new("Frame")
	ContentArea.Size = UDim2.new(1,-150,1,-50)
	ContentArea.Position = UDim2.new(0,150,0,50)
	ContentArea.BackgroundTransparency = 1
	ContentArea.ClipsDescendants = true
	ContentArea.Parent = Main

	local PageLayout = Instance.new("Folder", ContentArea)
	PageLayout.Name = "Pages"

	local CurrentPage = nil

	local function CreateTab(name)
		local TabBtn = Instance.new("TextButton")
		TabBtn.Size = UDim2.new(1,0,0,35)
		TabBtn.BackgroundTransparency = 1
		TabBtn.Text = "  "..name
		TabBtn.TextColor3 = Color3.fromRGB(200,200,200)
		TabBtn.Font = Enum.Font.GothamBold
		TabBtn.TextXAlignment = Enum.TextXAlignment.Left
		TabBtn.Parent = TabScrolling

		local Indicator = Instance.new("Frame")
		Indicator.Size = UDim2.new(0,4,0,20)
		Indicator.Position = UDim2.new(0,0,0.5,0)
		Indicator.AnchorPoint = Vector2.new(0,0.5)
		Indicator.BackgroundColor3 = Color3.new(1,1,1)
		Indicator.Visible = false
		Indicator.Parent = TabBtn

		local Page = Instance.new("ScrollingFrame")
		Page.Size = UDim2.new(1,0,1,0)
		Page.BackgroundTransparency = 1
		Page.ScrollBarThickness = 0
		Page.Visible = false
		Page.Parent = PageLayout
		Instance.new("UIListLayout", Page).Padding = UDim.new(0,10)
		Instance.new("UIPadding", Page).PaddingLeft = UDim.new(0,10)

		TabBtn.MouseButton1Click:Connect(function()
			if CurrentPage then CurrentPage.Visible = false end
			for _, v in pairs(TabScrolling:GetChildren()) do
				if v:IsA("TextButton") then
					v.Indicator.Visible = false
					v.TextColor3 = Color3.fromRGB(200,200,200)
				end
			end
			Indicator.Visible = true
			TabBtn.TextColor3 = Color3.new(1,1,1)
			Page.Visible = true
			CurrentPage = Page
		end)

		if not CurrentPage then
			TabBtn.MouseButton1Click:Fire()
		end

		local SectionFuncs = {}

		function SectionFuncs:AddSection(secName)
			local Section = Instance.new("Frame")
			Section.Size = UDim2.new(1,0,0,50)
			Section.BackgroundColor3 = Color3.fromRGB(28,28,28)
			Section.BackgroundTransparency = 0.95
			Section.Parent = Page
			Instance.new("UICorner", Section).CornerRadius = UDim.new(0,6)

			local SecTitle = Instance.new("TextLabel")
			SecTitle.Text = secName
			SecTitle.Size = UDim2.new(1,0,0,30)
			SecTitle.BackgroundTransparency = 1
			SecTitle.TextColor3 = Color3.new(1,1,1)
			SecTitle.Font = Enum.Font.GothamBold
			SecTitle.Parent = Section

			local SecLine = Instance.new("Frame")
			SecLine.Size = UDim2.new(1,0,0,2)
			SecLine.Position = UDim2.new(0,0,1,-2)
			SecLine.BackgroundColor3 = Color3.new(1,1,1)
			SecLine.BackgroundTransparency = 0.8
			SecLine.Parent = SecTitle

			local Content = Instance.new("Frame")
			Content.Size = UDim2.new(1,0,1,-30)
			Content.Position = UDim2.new(0,0,0,30)
			Content.BackgroundTransparency = 1
			Content.Parent = Section
			Instance.new("UIListLayout", Content).Padding = UDim.new(0,8)
			Instance.new("UIPadding", Content).PaddingLeft = UDim.new(0,8)

			local funcs = {}

			-- TOGGLE
			function funcs:AddToggle(cfg)
				cfg = Library:MakeConfig({Title="Toggle", Default=false, Callback=function()end}, cfg)
				local tog = Instance.new("Frame")
				tog.Size = UDim2.new(1,0,0,40)
				tog.BackgroundColor3 = Color3.fromRGB(35,35,35)
				tog.BackgroundTransparency = 0.95
				tog.Parent = Content
				Instance.new("UICorner", tog).CornerRadius = UDim.new(0,5)

				local title = Instance.new("TextLabel")
				title.Text = cfg.Title
				title.Size = UDim2.new(1,-70,1,0)
				title.Position = UDim2.new(0,10,0,0)
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.new(1,1,1)
				title.Font = Enum.Font.GothamBold
				title.TextXAlignment = Enum.TextXAlignment.Left
				title.Parent = tog

				local switch = Instance.new("Frame")
				switch.Size = UDim2.new(0,44,0,24)
				switch.Position = UDim2.new(1,-54,0.5,0)
				switch.AnchorPoint = Vector2.new(0,0.5)
				switch.BackgroundColor3 = Color3.fromRGB(60,60,60)
				switch.Parent = tog
				Instance.new("UICorner", switch).CornerRadius = UDim.new(1,0)

				local circle = Instance.new("Frame")
				circle.Size = UDim2.new(0,18,0,18)
				circle.Position = UDim2.new(0,4,0.5,0)
				circle.AnchorPoint = Vector2.new(0,0.5)
				circle.BackgroundColor3 = Color3.fromRGB(200,200,200)
				circle.Parent = switch
				Instance.new("UICorner", circle).CornerRadius = UDim.new(1,0)

				local click = Instance.new("TextButton")
				click.Size = UDim2.new(1,0,1,0)
				click.BackgroundTransparency = 1
				click.Text = ""
				click.Parent = tog

				local state = cfg.Default
				local function set(v)
					state = v
					if v then
						Library:TweenInstance(switch, 0.3, "BackgroundColor3", Color3.new(1,1,1))
						Library:TweenInstance(circle, 0.3, "Position", UDim2.new(1,-22,0.5,0))
						Library:TweenInstance(circle, 0.3, "BackgroundColor3", Color3.fromRGB(22,22,22))
					else
						Library:TweenInstance(switch, 0.3, "BackgroundColor3", Color3.fromRGB(60,60,60))
						Library:TweenInstance(circle, 0.3, "BackgroundColor3", Color3.fromRGB(200,200,200))
						Library:TweenInstance(circle, 0.3, "Position", UDim2.new(0,4,0.5,0))
					end
					cfg.Callback(v)
				end
				click.Activated:Connect(function() set(not state) end)
				set(state)
			end

			-- BUTTON
			function funcs:AddButton(cfg)
				cfg = Library:MakeConfig({Title="Button", Callback=function()end}, cfg)
				local btn = Instance.new("TextButton")
				btn.Size = UDim2.new(1,0,0,40)
				btn.BackgroundColor3 = Color3.fromRGB(35,35,35)
				btn.BackgroundTransparency = 0.95
				btn.Text = cfg.Title
				btn.TextColor3 = Color3.new(1,1,1)
				btn.Font = Enum.Font.GothamBold
				btn.Parent = Content
				Instance.new("UICorner", btn).CornerRadius = UDim.new(0,5)
				btn.MouseButton1Click:Connect(function()
					btn.BackgroundTransparency = 0.8
					cfg.Callback()
					Library:TweenInstance(btn, 0.2, "BackgroundTransparency", 0.95)
				end)
			end

			-- SLIDER
			function funcs:AddSlider(cfg)
				cfg = Library:MakeConfig({Title="Slider", Min=0, Max=100, Default=50, Callback=function()end}, cfg)
				local slider = Instance.new("Frame")
				slider.Size = UDim2.new(1,0,0,50)
				slider.BackgroundColor3 = Color3.fromRGB(35,35,35)
				slider.BackgroundTransparency = 0.95
				slider.Parent = Content
				Instance.new("UICorner", slider).CornerRadius = UDim.new(0,5)

				local title = Instance.new("TextLabel")
				title.Text = cfg.Title
				title.Size = UDim2.new(1,-100,0,20)
				title.Position = UDim2.new(0,10,0,5)
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.new(1,1,1)
				title.Font = Enum.Font.GothamBold
				title.TextXAlignment = Enum.TextXAlignment.Left
				title.Parent = slider

				local valueBox = Instance.new("TextBox")
				valueBox.Size = UDim2.new(0,60,0,25)
				valueBox.Position = UDim2.new(1,-70,0,5)
				valueBox.BackgroundColor3 = Color3.fromRGB(50,50,50)
				valueBox.Text = tostring(cfg.Default)
				valueBox.TextColor3 = Color3.new(1,1,1)
				valueBox.Parent = slider
				Instance.new("UICorner", valueBox).CornerRadius = UDim.new(0,4)

				local bar = Instance.new("Frame")
				bar.Size = UDim2.new(1,-20,0,8)
				bar.Position = UDim2.new(0,10,0,35)
				bar.BackgroundColor3 = Color3.fromRGB(60,60,60)
				bar.Parent = slider
				Instance.new("UICorner", bar).CornerRadius = UDim.new(1,0)

				local fill = Instance.new("Frame")
				fill.Size = UDim2.new((cfg.Default-cfg.Min)/(cfg.Max-cfg.Min),0,1,0)
				fill.BackgroundColor3 = Color3.new(1,1,1)
				fill.Parent = bar
				Instance.new("UICorner", fill).CornerRadius = UDim.new(1,0)

				local dragging = false
				bar.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end end)
				bar.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)
				game:GetService("UserInputService").InputChanged:Connect(function(i)
					if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
						local percent = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
						local val = cfg.Min + (cfg.Max - cfg.Min) * percent
						fill.Size = UDim2.new(percent,0,1,0)
						valueBox.Text = tostring(math.floor(val))
						cfg.Callback(math.floor(val))
					end
				end)
			end

			-- TEXTBOX
			function funcs:AddInput(cfg)
				cfg = Library:MakeConfig({Title="Input", Placeholder="Enter text...", Callback=function()end}, cfg)
				local input = Instance.new("Frame")
				input.Size = UDim2.new(1,0,0,50)
				input.BackgroundColor3 = Color3.fromRGB(35,35,35)
				input.BackgroundTransparency = 0.95
				input.Parent = Content
				Instance.new("UICorner", input).CornerRadius = UDim.new(0,5)

				local title = Instance.new("TextLabel")
				title.Text = cfg.Title
				title.Size = UDim2.new(1,0,0,20)
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.new(1,1,1)
				title.Font = Enum.Font.GothamBold
				title.Parent = input

				local box = Instance.new("TextBox")
				box.Size = UDim2.new(1,-20,0,30)
				box.Position = UDim2.new(0,10,0,20)
				box.BackgroundColor3 = Color3.fromRGB(50,50,50)
				box.PlaceholderText = cfg.Placeholder
				box.Text = ""
				box.TextColor3 = Color3.new(1,1,1)
				box.Parent = input
				Instance.new("UICorner", box).CornerRadius = UDim.new(0,5)
				box.FocusLost:Connect(function() cfg.Callback(box.Text) end)
			end

			-- DROPDOWN
			function funcs:AddDropdown(cfg)
				cfg = Library:MakeConfig({Title="Dropdown", Items={"Option 1","Option 2"}, Default="Option 1", Callback=function()end}, cfg)
				local drop = Instance.new("Frame")
				drop.Size = UDim2.new(1,0,0,45)
				drop.BackgroundColor3 = Color3.fromRGB(35,35,35)
				drop.BackgroundTransparency = 0.95
				drop.Parent = Content
				Instance.new("UICorner", drop).CornerRadius = UDim.new(0,5)

				local title = Instance.new("TextLabel")
				title.Text = cfg.Title
				title.Size = UDim2.new(1,-100,1,0)
				title.Position = UDim2.new(0,10,0,0)
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.new(1,1,1)
				title.Font = Enum.Font.GothamBold
				title.TextXAlignment = Enum.TextXAlignment.Left
				title.Parent = drop

				local selected = Instance.new("TextLabel")
				selected.Text = cfg.Default
				selected.Size = UDim2.new(0,120,0,30)
				selected.Position = UDim2.new(1,-130,0.5,0)
				selected.AnchorPoint = Vector2.new(0,0.5)
				selected.BackgroundColor3 = Color3.fromRGB(50,50,50)
				selected.TextColor3 = Color3.new(1,1,1)
				selected.Parent = drop
				Instance.new("UICorner", selected).CornerRadius = UDim.new(0,5)

				local arrow = Instance.new("TextLabel")
				arrow.Text = "▼"
				arrow.Size = UDim2.new(0,30,0,30)
				arrow.Position = UDim2.new(1,-30,0.5,0)
				arrow.AnchorPoint = Vector2.new(0,0.5)
				arrow.BackgroundTransparency = 1
				arrow.TextColor3 = Color3.new(1,1,1)
				arrow.Parent = drop

				local list = Instance.new("Frame")
				list.Size = UDim2.new(0,150,0,0)
				list.Position = UDim2.new(1,-150,1,5)
				list.BackgroundColor3 = Color3.fromRGB(30,30,30)
				list.Visible = false
				list.Parent = drop
				Instance.new("UICorner", list).CornerRadius = UDim.new(0,5)

				local uilist = Instance.new("UIListLayout", list)

				drop.InputBegan:Connect(function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 then
						list.Visible = not list.Visible
					end
				end)

				for _, item in ipairs(cfg.Items) do
					local opt = Instance.new("TextButton")
					opt.Size = UDim2.new(1,0,0,30)
					opt.BackgroundTransparency = 1
					opt.Text = item
					opt.TextColor3 = Color3.new(1,1,1)
					opt.Parent = list
					opt.MouseButton1Click:Connect(function()
						selected.Text = item
						list.Visible = false
						cfg.Callback(item)
					end)
				end

				list:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					list.Size = UDim2.new(0,150,0,list.AbsoluteContentSize.Y)
				end)
			end

			-- PARAGRAPH
			function funcs:AddParagraph(cfg)
				cfg = Library:MakeConfig({Title="Paragraph", Text="Description here"}, cfg)
				local para = Instance.new("Frame")
				para.Size = UDim2.new(1,0,0,70)
				para.BackgroundColor3 = Color3.fromRGB(35,35,35)
				para.BackgroundTransparency = 0.95
				para.Parent = Content
				Instance.new("UICorner", para).CornerRadius = UDim.new(0,5)

				local title = Instance.new("TextLabel")
				title.Text = cfg.Title
				title.Size = UDim2.new(1,0,0,20)
				title.Position = UDim2.new(0,10,0,5)
				title.BackgroundTransparency = 1
				title.TextColor3 = Color3.new(1,1,1)
				title.Font = Enum.Font.GothamBold
				title.Parent = para

				local text = Instance.new("TextLabel")
				text.Text = cfg.Text
				text.Size = UDim2.new(1,-20,1,-30)
				text.Position = UDim2.new(0,10,0,25)
				text.BackgroundTransparency = 1
				text.TextColor3 = Color3.fromRGB(200,200,200)
				text.TextWrapped = true
				text.Parent = para
			end

			return funcs
		end

		return SectionFuncs
	end

	return CreateTab
end

return Library
