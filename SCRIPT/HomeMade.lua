-- Variables
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local flying = false
local speed = 50 -- Vitesse de vol
local bodyVelocity, bodyGyro

-- Fonction pour activer/désactiver le vol
local function toggleFly()
    if flying then
        -- Désactiver le vol
        flying = false
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
    else
        -- Activer le vol
        flying = true
        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.Parent = humanoidRootPart

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
        bodyGyro.CFrame = humanoidRootPart.CFrame
        bodyGyro.Parent = humanoidRootPart
    end
end

-- Contrôle des mouvements
game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.F then -- Touche F pour activer/désactiver le vol
        toggleFly()
    end
end)

-- Mettre à jour la position pendant le vol
game:GetService("RunService").RenderStepped:Connect(function()
    if flying then
        local moveDirection = Vector3.zero
        local camera = workspace.CurrentCamera

        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.W) then
            moveDirection = moveDirection + camera.CFrame.LookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.S) then
            moveDirection = moveDirection - camera.CFrame.LookVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.A) then
            moveDirection = moveDirection - camera.CFrame.RightVector
        end
        if game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.D) then
            moveDirection = moveDirection + camera.CFrame.RightVector
        end

        bodyVelocity.Velocity = moveDirection * speed
        bodyGyro.CFrame = camera.CFrame
    end
end)
