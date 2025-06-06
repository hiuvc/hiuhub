local v14 = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))();
local v15 = v14:CreateWindow({
    Title = "Hiu Hub",
    SubTitle = "By hiuvc",
    TabWidth = 160,
    Theme = "Dark",
    Acrylic = false,
    Size = UDim2.fromOffset(500, 350),
    MinimizeKey = Enum.KeyCode.LeftControl
});
local Tabs = {
    Main = v15:AddTab({ Title = "Main"}),
    Settings = v15:AddTab({ Title = "Settings"})
}


local v17 = v14.Options;
do
local v22 = Instance.new("ScreenGui");
local v23 = Instance.new("ImageButton");
local v24 = Instance.new("UICorner");
local v25 = Instance.new("ParticleEmitter");
local v26 = game:GetService("TweenService");
v22.Parent = game.CoreGui;
v22.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
v23.Parent = v22;
v23.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
v23.BorderSizePixel = 0;
v23.Position = UDim2.new(0.120833337 - 0.1, 0, 0.0952890813 + 0.01, 0);
v23.Size = UDim2.new(0, 50, 0, 50);
v23.Draggable = true;
v23.Image = "http://www.roblox.com/asset/?id=133979080007875";
v24.Parent = v23;
v24.CornerRadius = UDim.new(0, 12);
v25.Parent = v23;
v25.LightEmission = 1;
v25.Size = NumberSequence.new({
    NumberSequenceKeypoint.new(0, 0.1),
    NumberSequenceKeypoint.new(1, 0)
});
v25.Lifetime = NumberRange.new(0.5, 1);
v25.Rate = 0;
v25.Speed = NumberRange.new(5, 10);
v25.Color = ColorSequence.new(Color3.fromRGB(255, 85, 255), Color3.fromRGB(85, 255, 255));
local v47 = v26:Create(v23, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
    Rotation = 360
});
v23.MouseButton1Down:Connect(function()
    v25.Rate = 100;
    task.delay(1, function()
        v25.Rate = 0;
    end);
    v47:Play();
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game);
    v47.Completed:Connect(function()
        v23.Rotation = 0;
    end);
    local v235 = v26:Create(v23, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 60, 0, 60)
    });
    v235:Play();
    v235.Completed:Connect(function()
        local v483 = v26:Create(v23, TweenInfo.new(0.2, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 50, 0, 50)
        });
        v483:Play();
    end);
end);

	Tabs.Main:AddButton({
		Title = "🌌 Galaxy Block", -- Thêm icon hoặc đảm bảo không để trống
		Description = "Spawn a Galaxy Block",
		Callback = function()
			game:GetService("ReplicatedStorage"):WaitForChild("SpawnGalaxyBlock"):FireServer()
		end
	})
	

	Tabs.Main:AddButton({
		Title = "🌈 Rainbow Block", -- Viết đúng chính tả "Rainbow"
		Description = "Spawn a Rainbow Block",
		Callback = function()
			game:GetService("ReplicatedStorage"):WaitForChild("SpawnRainbowBlock"):FireServer()
		end
	})
	
	local ToggleRanbow = Tabs.Main:AddToggle("ToggleRanbow", {
		Title = "Spam Rainbow Block",
		Description = "",
		Default = false
	})
	ToggleRanbow:OnChanged(function(v)
		_G.Rainbow = v;
	end)
	spawn(function()
        while task.wait(0.5) do
            if _G.Rainbow then
				game:GetService("ReplicatedStorage"):WaitForChild("SpawnRainbowBlock"):FireServer()
            end
        end
    end);
	local ToggleGalaxy = Tabs.Main:AddToggle("ToggleGalaxy", {
		Title = "Spam Galaxy Block",
		Description = "",
		Default = false
	})
	ToggleGalaxy:OnChanged(function(v)
		_G.Galaxy = v;
	end)
	spawn(function()
        while task.wait(0.5) do
            if _G.Galaxy then
				game:GetService("ReplicatedStorage"):WaitForChild("SpawnGalaxyBlock"):FireServer()
            end
        end
    end);
end
