spawn(function()
    while wait() do
        if _G.AutoChest then
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local PlayerPosition = Character:GetPivot().Position
            local CollectionService = game:GetService("CollectionService")
            local Chests = CollectionService:GetTagged("_ChestTagged")
            
            local NearestDistance, NearestChest = math.huge, nil

            for _, Chest in pairs(Chests) do
                local ChestPosition = Chest:GetPivot().Position
                local Distance = (ChestPosition - PlayerPosition).Magnitude
                if (not Chest:GetAttribute("IsDisabled") and Distance < NearestDistance) then
                    NearestDistance, NearestChest = Distance, Chest
                end
            end

            if NearestChest then
                local TargetPosition = CFrame.new(NearestChest:GetPivot().Position)
                MoveToChest(TargetPosition)
            end
        end
    end
end)

function MoveToChest(TargetCFrame)
    local Distance = (TargetCFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local Speed = 100

    local TweenInfoData = TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear)
    local Tween = game:GetService("TweenService"):Create(
        game.Players.LocalPlayer.Character.HumanoidRootPart,
        TweenInfoData,
        { CFrame = TargetCFrame }
    )

    Tween:Play()

    if _G.CancelMove then
        Tween:Cancel()
    end

    _G.Moving = true
    wait(Distance / Speed)
    _G.Moving = false
end
