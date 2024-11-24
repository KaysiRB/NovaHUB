local Luminosity = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB.lua"))()
local Window = Luminosity.new("Nova HUB", "v0.5.0", 4370345701)

local Tab1 = Window.Tab("Usefull", 6026568198)
    local Folder = Tab1.Folder("Script", "A bunch of scripts you can use")
    Folder.Button("TOADS", "Execute", function()
        print("TOADS executed")
    end)

local Tab2 = Window.Tab("Settings", 6022668945)
    local Folder = Tab2.Folder("Options", "A bunch of options you can use")
        Tab2.Folder("Lipsum Expanded", "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur eu mollis urna, quis feugiat tellus. Integer ut ligula sodales, sodales ipsum ut, imperdiet ipsum. In aliquet quam et venenatis pulvinar. Nullam fermentum porta felis sit amet interdum. Sed tristique fringilla mollis. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Nam quis tempus mauris, nec ultrices metus. Suspendisse mi urna, accumsan at nisi a, tristique porta libero. Integer lobortis elementum lacus cursus consectetur. Morbi mauris ante, posuere at malesuada et, tristique non ipsum. Proin vitae purus pretium, convallis est vitae, dignissim leo. Praesent nec felis vitae.", function())
        print("nothing")
    end)
    
game:GetService("UserInputService").InputBegan:Connect(function(Input)
    if Input.KeyCode == Enum.KeyCode.LeftAlt then
        Window:Toggle()
    end
end)
