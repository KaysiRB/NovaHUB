local NovaGui = {}

function NovaGui:CreateGui()
    local player = game.Players.LocalPlayer

    -- Parent ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = player:WaitForChild("PlayerGui")
    ScreenGui.Enabled = true -- Start hidden
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

        -- Main Container
        local ImageLabel = Instance.new("ImageLabel", ScreenGui)
        ImageLabel.BorderSizePixel = 0
        ImageLabel.BackgroundTransparency = 1
        ImageLabel.Image = "rbxassetid://86881258910484"
        ImageLabel.Size = UDim2.new(0, 809, 0, 540)
        ImageLabel.Position = UDim2.new(0.286, 0, 0.3, 0)
        ImageLabel.ImageTransparency = 0.2
    
            -- Header
            local Header = Instance.new("Frame", ImageLabel)
            Header.Size = UDim2.new(0, 809, 0, 54)
            Header.BackgroundColor3 = Color3.new(0.454, 0.454, 0.454)
        
                local Middle = Instance.new("TextLabel", Header)
                Middle.Text = "-"
                Middle.TextColor3 = Color3.new(1, 1, 1)
                Middle.Font = Enum.Font.SourceSansBold
                Middle.TextScaled = true
                Middle.Size = UDim2.new(0, 40, 0, 50)
                Middle.Position = UDim2.new(0.474, 0, 0.037, 0)
                Middle.BackgroundTransparency = 1
            
                local Version = Instance.new("TextLabel", Header)
                Version.Text = "BETA Version"
                Version.TextColor3 = Color3.new(0.956, 0.82, 0.682)
                Version.Font = Enum.Font.SourceSansBold
                Version.TextScaled = true
                Version.Size = UDim2.new(0, 270, 0, 50)
                Version.Position = UDim2.new(0.665, 0, 0.037, 0)
                Version.BackgroundTransparency = 1
            
                local Name = Instance.new("TextLabel", Header)
                Name.Text = "Nova Hub"
                Name.TextColor3 = Color3.new(0.956, 0.82, 0.682)
                Name.Font = Enum.Font.SourceSansBold
                Name.TextScaled = true
                Name.Size = UDim2.new(0, 270, 0, 50)
                Name.Position = UDim2.new(0, 0, 0, 0)
                Name.BackgroundTransparency = 1
        
            -- Main Frame
            local Main = Instance.new("Frame", ImageLabel)
            Main.Size = UDim2.new(0, 809, 0, 486)
            Main.Position = UDim2.new(0, 0, 0.1, 0)
            Main.BackgroundColor3 = Color3.new(0.07, 0.15, 0.23)
            Main.BackgroundTransparency = 0.3
        
                -- Sidebar Buttons
                local LeftSide = Instance.new("Frame", Main)
                LeftSide.Size = UDim2.new(0, 187, 0, 457)
                LeftSide.Position = UDim2.new(0.012, 0, 0.032, 0)
                LeftSide.BackgroundTransparency = 1
            
                    local UIGridLayout = Instance.new("UIGridLayout", LeftSide)
                    UIGridLayout.CellSize = UDim2.new(0, 185, 0, 50)
                    UIGridLayout.CellPadding = UDim2.new(0, 5, 0, 30)
                
                    local buttonTexts = {"Home", "WIP", "WIP", "WIP", "WIP", "Settings"}
                    for _, text in ipairs(buttonTexts) do
                        local Button = Instance.new("TextButton", LeftSide)
                        Button.Text = text
                        Button.TextColor3 = Color3.new(1, 1, 1)
                        Button.Font = Enum.Font.SourceSans
                        Button.TextScaled = true
                        Button.BackgroundColor3 = Color3.new(0.956, 0.82, 0.682)
                
                            local UICorner = Instance.new("UICorner", Button)
                            UICorner.CornerRadius = UDim.new(0, 15)
                    end
    
            local MiddleLine = Instance.new("Frame")
            MiddleLine.Size = UDim2.new({0, 2}, {0, 470})
            MiddleLine.LayoutOrder = 1
            MiddleLine.BorderColor3 = Color3.new(0, 0, 0)
            MiddleLine.BorderSizePixel = 0
            MiddleLine.Name = "MiddleLine"
            MiddleLine.Position = UDim2.new({0.251485169, 0}, {0.0164609049, 0})
            MiddleLine.BackgroundColor3 = Color3.new(1, 1, 1)
            MiddleLine.Parent = Main

            local RightSide = Instance.new("Frame")
            RightSide.LayoutOrder = 1
            RightSide.Size = UDim2.new({0, 572}, {0, 455})
            RightSide.BorderColor3 = Color3.new(0, 0, 0)
            RightSide.BorderSizePixel = 0
            RightSide.BackgroundTransparency = 0.8999999761581421
            RightSide.Transparency = 0.8999999761581421
            RightSide.Name = "RightSide"
            RightSide.Position = UDim2.new({0.27308163, 0}, {0.0319010429, 0})
            RightSide.BackgroundColor3 = Color3.new(1, 1, 1)
            RightSide.Parent = Main
                        -- Settings Frame
                    local SettingsFrame = Instance.new("Frame")
                    SettingsFrame.Size = UDim2.new(0.6, 0, 0.8, 0)
                    SettingsFrame.Position = UDim2.new(0.2, 0, 0.1, 0)
                    SettingsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    SettingsFrame.Visible = false
                    SettingsFrame.Parent = RightSide
                
                    local SettingsLabel = Instance.new("TextLabel")
                    SettingsLabel.Size = UDim2.new(1, 0, 0.1, 0)
                    SettingsLabel.Position = UDim2.new(0, 0, 0, 0)
                    SettingsLabel.Text = "Settings"
                    SettingsLabel.Font = Enum.Font.SourceSansBold
                    SettingsLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    SettingsLabel.TextSize = 24
                    SettingsLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
                    SettingsLabel.Parent = SettingsFrame

                    --Toggle Settings Logic
            SettingsButton.MouseButton1Click:Connect(function()
                SettingsFrame.Visible = not SettingsFrame.Visible
            end)

    self:MakeDraggable(Header, ImageLabel)
    
    return ScreenGui
end

function NovaGui:MakeDraggable(dragHandle, target)
    local UserInputService = game:GetService("UserInputService")
    local isDragging = false
    local dragStart = nil
    local startPos = nil

    dragHandle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            dragStart = input.Position
            startPos = target.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    isDragging = false
                end
            end)
        end
    end)

    dragHandle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and isDragging then
            local delta = input.Position - dragStart
            target.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

function NovaGui:ToggleGui(gui)
    local UserInputService = game:GetService("UserInputService")

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then return end
        if input.KeyCode == Enum.KeyCode.LeftAlt then
            gui.Enabled = not gui.Enabled
        end
    end)
end

return NovaGui
