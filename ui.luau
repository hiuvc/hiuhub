-- Gravity Hub Easy UI Wrapper (Preview)

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- cleanup
if CoreGui:FindFirstChild("GravityHubPreview") then
    CoreGui.GravityHubPreview:Destroy()
end

-- colors
local BG = Color3.fromRGB(12,12,12)
local PANEL = Color3.fromRGB(22,22,22)
local PANEL_ALT = Color3.fromRGB(28,28,28)
local ACCENT = Color3.fromRGB(255,165,0)
local TXT = Color3.fromRGB(230,230,230)
local TOGGLE_OFF = Color3.fromRGB(80,80,80)

-- helper
local function new(class, props)
    local inst = Instance.new(class)
    if props then
        for k,v in pairs(props) do
            if k == "Parent" then inst.Parent = v else inst[k] = v end
        end
    end
    return inst
end

-- root gui
local screenGui = new("ScreenGui",{Name="GravityHubPreview",Parent=CoreGui,ResetOnSpawn=false})
screenGui.IgnoreGuiInset = true

-- window
local window = new("Frame",{
    Parent=screenGui,
    Size=UDim2.fromOffset(500,320),
    Position=UDim2.new(0.5,-250,0.5,-160),
    BackgroundColor3=BG,
    BorderSizePixel=0,
    ClipsDescendants=true
})
new("UICorner",{Parent=window,CornerRadius=UDim.new(0,12)})

-- header
local header = new("Frame",{
    Parent=window,
    Size=UDim2.new(1,0,0,48),
    BackgroundColor3=PANEL_ALT,
    BorderSizePixel=0
})
new("UICorner",{Parent=header,CornerRadius=UDim.new(0,12)})

new("TextLabel",{
    Parent=header,
    Text="Gravity Hub",
    Font=Enum.Font.GothamBold,
    TextSize=18,
    TextColor3=ACCENT,
    BackgroundTransparency=1,
    Position=UDim2.new(0,12,0,6),
    Size=UDim2.new(0.7,0,0,20),
    TextXAlignment=Enum.TextXAlignment.Left
})
new("TextLabel",{
    Parent=header,
    Text="Vision 1.3",
    Font=Enum.Font.Gotham,
    TextSize=12,
    TextColor3=Color3.fromRGB(160,160,160),
    BackgroundTransparency=1,
    Position=UDim2.new(0,12,0,26),
    Size=UDim2.new(0.7,0,0,16),
    TextXAlignment=Enum.TextXAlignment.Left
})

-- collapse button
local btnCollapse = new("TextButton",{
    Parent=header,
    Size=UDim2.new(0,44,0,30),
    Position=UDim2.new(1,-56,0.5,-15),
    BackgroundColor3=PANEL,
    Text="-",
    Font=Enum.Font.GothamBold,
    TextSize=20,
    TextColor3=TXT,
    AutoButtonColor=false
})
new("UICorner",{Parent=btnCollapse,CornerRadius=UDim.new(0,8)})

-- tab bar
local tabBar = new("Frame",{Parent=window,Size=UDim2.new(1,0,0,44),Position=UDim2.new(0,0,0,48),BackgroundColor3=PANEL,BorderSizePixel=0})
new("UICorner",{Parent=tabBar,CornerRadius=UDim.new(0,8)})

local tabScroller = new("ScrollingFrame",{Parent=tabBar,Size=UDim2.new(1,-24,1,0),Position=UDim2.new(0,12,0,0),BackgroundTransparency=1,ScrollBarThickness=6,CanvasSize=UDim2.new(0,0,0,0),AutomaticCanvasSize=Enum.AutomaticSize.X,HorizontalScrollBarInset=Enum.ScrollBarInset.Always})
local tabListLayout = new("UIListLayout",{Parent=tabScroller,FillDirection=Enum.FillDirection.Horizontal,Padding=UDim.new(0,8),HorizontalAlignment=Enum.HorizontalAlignment.Left})

-- content area
local content = new("Frame",{Parent=window,Size=UDim2.new(1,0,1,-(48+44)),Position=UDim2.new(0,0,0,48+44),BackgroundTransparency=1})

-- helper panel creator
local function makePanel(parent,x)
    local panel = new("Frame",{Parent=parent,Size=UDim2.new(0.5,-12,1,-24),Position=UDim2.new(x,x==0 and 12 or 6,0,12),BackgroundColor3=PANEL,BorderSizePixel=0})
    new("UICorner",{Parent=panel,CornerRadius=UDim.new(0,10)})
    local scroll = new("ScrollingFrame",{Parent=panel,Size=UDim2.new(1,-24,1,-46),Position=UDim2.new(0,12,0,40),BackgroundTransparency=1,ScrollBarThickness=6,AutomaticCanvasSize=Enum.AutomaticSize.Y})
    local layout = new("UIListLayout",{Parent=scroll,SortOrder=Enum.SortOrder.LayoutOrder,Padding=UDim.new(0,10)})
    return {Panel=panel,Scroll=scroll,Layout=layout}
end

-- Row factory
local function makeRow(parent,height)
    local row = new("TextButton",{Parent=parent,Size=UDim2.new(1,0,0,height or 46),BackgroundColor3=Color3.fromRGB(38,38,38),Text="",AutoButtonColor=false})
    new("UICorner",{Parent=row,CornerRadius=UDim.new(0,8)})
    return row
end

-- Toggle factory
local function makeToggle(parent,text,default,callback)
    local row = makeRow(parent,48)
    local label = new("TextLabel",{Parent=row,Text=text,Font=Enum.Font.Gotham,TextSize=14,TextColor3=TXT,BackgroundTransparency=1,Position=UDim2.new(0,12,0,0),Size=UDim2.new(1,-96,1,0),TextXAlignment=Enum.TextXAlignment.Left,TextYAlignment=Enum.TextYAlignment.Center})
    local sw = new("Frame",{Parent=row,Size=UDim2.new(0,44,0,24),Position=UDim2.new(1,-56,0.5,-12),BackgroundColor3=default and ACCENT or TOGGLE_OFF})
    new("UICorner",{Parent=sw,CornerRadius=UDim.new(1,0)})
    local knob = new("Frame",{Parent=sw,Size=UDim2.new(0,18,0,18),Position=default and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,4,0.5,-9),BackgroundColor3=Color3.fromRGB(245,245,245)})
    new("UICorner",{Parent=knob,CornerRadius=UDim.new(1,0)})
    local toggled = default or false
    local function setState(v,animate)
        toggled=v
        local color = toggled and ACCENT or TOGGLE_OFF
        local pos = toggled and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,4,0.5,-9)
        if animate then
            TweenService:Create(sw,TweenInfo.new(0.14),{BackgroundColor3=color}):Play()
            TweenService:Create(knob,TweenInfo.new(0.14),{Position=pos}):Play()
        else
            sw.BackgroundColor3=color
            knob.Position=pos
        end
        if callback then pcall(callback,toggled) end
    end
    row.MouseButton1Click:Connect(function() setState(not toggled,true) end)
    return {Row=row,Set=setState,Get=function() return toggled end}
end

-- Slider factory
local function makeSlider(parent,text,minv,maxv,default,callback)
    local row = makeRow(parent,64)
    local label = new("TextLabel",{Parent=row,Text=text,Font=Enum.Font.Gotham,TextSize=14,TextColor3=TXT,BackgroundTransparency=1,Position=UDim2.new(0,12,0,6),Size=UDim2.new(1,-24,0,18),TextXAlignment=Enum.TextXAlignment.Left})
    local bar = new("Frame",{Parent=row,Size=UDim2.new(1,-120,0,12),Position=UDim2.new(0,12,0,34),BackgroundColor3=Color3.fromRGB(60,60,60)})
    new("UICorner",{Parent=bar,CornerRadius=UDim.new(0,6)})
    local frac = math.clamp((default-minv)/(maxv-minv),0,1)
    local fill = new("Frame",{Parent=bar,Size=UDim2.new(frac,0,1,0),BackgroundColor3=ACCENT})
    new("UICorner",{Parent=fill,CornerRadius=UDim.new(0,6)})
    local knob = new("Frame",{Parent=bar,Size=UDim2.new(0,14,0,14),Position=UDim2.new(frac,-7,0.5,-7),BackgroundColor3=Color3.fromRGB(245,245,245)})
    new("UICorner",{Parent=knob,CornerRadius=UDim.new(1,0)})
    local display = new("TextLabel",{Parent=row,Text=tostring(default),Font=Enum.Font.GothamBold,TextSize=13,TextColor3=TXT,BackgroundTransparency=1,Size=UDim2.new(0,72,0,20),Position=UDim2.new(1,-92,0,22)})
    local dragging=false
    local function updateFromX(x)
        local absX=math.clamp(x-bar.AbsolutePosition.X,0,bar.AbsoluteSize.X)
        local frac2=absX/bar.AbsoluteSize.X
        local val=math.floor(minv+(maxv-minv)*frac2+0.5)
        fill.Size=UDim2.new(frac2,0,1,0)
        knob.Position=UDim2.new(frac2,-7,0.5,-7)
        display.Text=tostring(val)
        if callback then pcall(callback,val) end
    end
    knob.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=true end end)
    knob.InputEnded:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then dragging=false end end)
    bar.InputBegan:Connect(function(i) if i.UserInputType==Enum.UserInputType.MouseButton1 then updateFromX(i.Position.X); dragging=true end end)
    UserInputService.InputChanged:Connect(function(i) if dragging and i.UserInputType==Enum.UserInputType.MouseMovement then updateFromX(i.Position.X) end end)
    return {Row=row}
end

-- Dropdown factory
local function makeDropdown(parent,text,options,default,callback)
    local row = makeRow(parent,56)
    local label = new("TextLabel",{Parent=row,Text=text,Font=Enum.Font.Gotham,TextSize=14,TextColor3=TXT,BackgroundTransparency=1,Position=UDim2.new(0,12,0,8),Size=UDim2.new(1,-24,0,18),TextXAlignment=Enum.TextXAlignment.Left})
    local btn = new("TextButton",{Parent=row,Size=UDim2.new(1,-24,0,30),Position=UDim2.new(0,12,0,24),BackgroundColor3=Color3.fromRGB(55,55,55),Text=default or options[1],Font=Enum.Font.Gotham,TextColor3=TXT,AutoButtonColor=false})
    new("UICorner",{Parent=btn,CornerRadius=UDim.new(0,8)})
    local menu = new("Frame",{Parent=row,Size=UDim2.new(1,-24,0,#options*30),Position=UDim2.new(0,12,0,54),BackgroundColor3=Color3.fromRGB(45,45,45),Visible=false})
    new("UICorner",{Parent=menu,CornerRadius=UDim.new(0,8)})
    for i,opt in ipairs(options) do
        local optBtn = new("TextButton",{Parent=menu,Size=UDim2.new(1,-12,0,26),Position=UDim2.new(0,6,0,(i-1)*30),BackgroundTransparency=1,Text=opt,Font=Enum.Font.Gotham,TextColor3=TXT,AutoButtonColor=false})
        optBtn.MouseButton1Click:Connect(function()
            btn.Text=opt
            menu.Visible=false
            if callback then pcall(callback,opt) end
        end)
    end
    btn.MouseButton1Click:Connect(function() menu.Visible=not menu.Visible end)
    return {Row=row}
end

-- ========================
-- UI Wrapper
-- ========================
local UI = {Tabs={}}

function UI:AddTab(name)
    local tab = makePanel(content,0)
    local tabObj = {Left=tab,Right=makePanel(content,0.5)}
    self.Tabs[name] = tabObj
    local btn = new("TextButton",{Parent=tabScroller,Size=UDim2.new(0,120,0,32),Text=name,BackgroundColor3=Color3.fromRGB(35,35,35),TextColor3=TXT,Font=Enum.Font.GothamSemibold,TextSize=14,AutoButtonColor=false})
    new("UICorner",{Parent=btn,CornerRadius=UDim.new(0,8)})
    btn.MouseButton1Click:Connect(function() UI:SetTab(name) end)

    local wrapper = {}

    function wrapper:AddToggle(text,default,callback)
        return makeToggle(tabObj.Left.Scroll,text,default,callback)
    end
    function wrapper:AddSlider(text,minv,maxv,default,callback)
        return makeSlider(tabObj.Right.Scroll,text,minv,maxv,default,callback)
    end
    function wrapper:AddDropdown(text,options,default,callback)
        return makeDropdown(tabObj.Right.Scroll,text,options,default,callback)
    end

    return wrapper
end

function UI:SetTab(name)
    for k,v in pairs(self.Tabs) do
        v.Left.Panel.Visible = (k==name)
        v.Right.Panel.Visible = (k==name)
    end
end

UI:SetTab("Main") -- default tab

-- collapse toggle
btnCollapse.MouseButton1Click:Connect(function()
    window.Size = window.Size == UDim2.fromOffset(500,320) and UDim2.fromOffset(500,48+44) or UDim2.fromOffset(500,320)
end)

-- drag window
local dragging=false
local dragInput
local dragStart
local startPos
local function update(input)
    local delta=input.Position-dragStart
    window.Position=UDim2.new(startPos.X.Scale, startPos.X.Offset+delta.X,startPos.Y.Scale, startPos.Y.Offset+delta.Y)
end
header.InputBegan:Connect(function(input)
    if input.UserInputType==Enum.UserInputType.MouseButton1 then
        dragging=true
        dragStart=input.Position
        startPos=window.Position
        input.Changed:Connect(function()
            if input.UserInputState==Enum.UserInputState.End then dragging=false end
        end)
    end
end)
header.InputChanged:Connect(function(input) if input.UserInputType==Enum.UserInputType.MouseMovement then dragInput=input end end)
UserInputService.InputChanged:Connect(function(input)
    if input==dragInput and dragging then update(input) end
end)

return UI

local UI = require(path_to_wrapper)

local Main = UI:AddTab("Main")
Main:AddToggle("Auto Farm",false,function(v) print("Auto Farm:",v) end)
Main:AddSlider("Distance",1,50,20,function(v) print("Distance:",v) end)
Main:AddDropdown("Weapon",{"Melee","Sword","Fruit"},"Melee",function(v) print("Weapon:",v) end)
