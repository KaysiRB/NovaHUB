local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB-BETA.lua"))()

local Window = MacLib:Window({
    Title = "Nova HUB",
    Subtitle = "Beta | V0.50",
    Size = UDim2.fromOffset(868, 650),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = Enum.KeyCode.LeftAlt,
    AcrylicBlur = true,
})
local Global_Setting = Window:GlobalSetting({
    Name = "Moderator Join Alerts",
    Default = false,
    Callback = function(State)
        print("Moderator Join Alerts " .. (State and "Enabled" or "Disabled"))
    end,
})

local TabGroup = Window:TabGroup()
    local Tab = TabGroup:Tab({
        Name = "Home"
        Image = "6026568198" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
    })
    local Section = Tab:Section({
        Side = "Left"
    })
        Section:Paragraph({
            Header = "Credits"
            Body = "UI - MacLib"
        })
        sections.MainSection1:Keybind({
        	Name = "Reset Inventory",
        	Callback = function(binded)
        		Window:Notify({
        			Title = "Kuzu Hub",
        			Description = "Successfully Reset Inventory",
        			Lifetime = 3
        		})
        	end,
        	onBinded = function(bind)
        		Window:Notify({
        			Title = "Kuzu Hub",
        			Description = "Rebinded Reset Inventory to "..tostring(bind.Name),
        			Lifetime = 3
        		})
        	end,
        }, "ResetInventoryBind")

Window:Notify({
    Title = "Nova HUB",
    Description = "Nova HUB has been loaded!",
    Lifetime = 5
})
