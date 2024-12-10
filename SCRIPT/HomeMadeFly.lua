-- HomeMadeFly.lua

local FlyModule = {}

local flying = false
local bodyVelocity, bodyGyro
local speed = 50 -- Vitesse de vol

function FlyModule:toggleFly()
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

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

function FlyModule:updateFlight()
    if flying then
        local player = game.Players.LocalPlayer
        local character = player.Character or player.CharacterAdded:Wait()
        local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera
        local moveDirection = Vector3.zero

        -- Vérifier les entrées utilisateur pour déplacer le personnage
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

        -- Appliquer les mouvements et l'orientation
        bodyVelocity.Velocity = moveDirection * speed
        bodyGyro.CFrame = camera.CFrame
    end
end

return FlyModule
