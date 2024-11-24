print(" _   _                      _   _  _   _  ____  ")
print("| \ | |  ___ __   __ __ _  | | | || | | || __ ) ")
print("|  \| | / _ \\ \ / // _` | | |_| || | | ||  _ \ ")
print("| |\  || (_) |\ V /| (_| | |  _  || |_| || |_) |")
print("|_| \_| \___/  \_/  \__,_| |_| |_| \___/ |____/ ")

local Luminosity = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB.lua"))()
local Window = Luminosity.new("Nova HUB", "v0.5.0", 4370345701)

local Tab1 = Window.Tab("Usefull", 6026568198)
    local Folder = Tab1.Folder("Script", "A bunch of scripts you can use")
    Folder.Button("TOADS", "Execute", function()
        print("TOADS executed")
    end)

game:GetService("UserInputService").InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.LeftAlt then
        Window:Toggle()
    end
end)
