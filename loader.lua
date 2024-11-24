print("N   N                     H  H   U   U   BBBB ")
print("NN  N                     H  H   U   U   B   B")
print("N N N   ooo   v v    aa   HHHH   U   U   BBBB ")
print("N  NN   o o   v v   a a   H  H   U   U   B   B")
print("N   N   ooo    v    aaa   H  H    UUU    BBBB ")

local Luminosity = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB.lua"))()
Luminosity:LoadingScreen()
local Window = Luminosity.new("Nova HUB", "v0.5.0", 4370345701)

local Home = Window.Tab("Home", 6026568198)
    local Folder = Home.Folder("Script", "A bunch of scripts you can use")
    Folder.Button("TOADS", "Execute", function()
        print("TOADS executed")
    Folder.Button("LuaWare", "Execute", function()
        print("LuaWare executed")
    Folder.Button("Infinity Yield", "Execute", function()
        print("Infinity Yield executed")
    end)

game:GetService("UserInputService").InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.LeftAlt then
        Window:Toggle()
    end
end)
