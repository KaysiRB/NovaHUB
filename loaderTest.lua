local LocalPlayer = game:GetService("Players").LocalPlayer
local guiContainer = (game:GetService("RunService"):IsStudio() and LocalPlayer:WaitForChild("PlayerGui")) or game:GetService("CoreGui")
local GUI_NAME = "MacLib"

-- Supprimer tous les GUIs existants avec le même nom
for _, gui in ipairs(guiContainer:GetChildren()) do
    if gui.Name == GUI_NAME then
        Window:Unload()
		gui:Destroy()
    end
end

local FlyModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadeFly.lua"))()
local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB-BETA.lua"))()

local Window = MacLib:Window({
    Title = "Nova HUB",
    Subtitle = "Beta | V0.50",
    Size = UDim2.fromOffset(868, 650),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = SavedSettings["ShowUserInfo"] or false,
    AcrylicBlur = SavedSettings["AcrylicBlur"] or false,
    Keybind = SavedSettings["NovaHUBOpenKeyBind"] and StringToKeyCode(SavedSettings["NovaHUBOpenKeyBind"]) or Enum.KeyCode.RightControl -- Charger correctement le bind
})

local Global_Setting = Window:GlobalSetting({
    Name = "Moderator Join Alerts",
    Default = false, -- Charger la valeur depuis les paramètres sauvegardés
    Callback = function(State)
        print("Moderator Join Alerts " .. (State and "Enabled" or "Disabled"))
    end,
})

local Global_Setting = Window:GlobalSetting({
    Name = "Background Blur",
    Default = false,
    Callback = function(State)
		print("Acrylic Blur -> " .. (State and "Enabled" or "Disabled"))
		Window:SetAcrylicBlurState(State)
	end,
})

local Global_Setting = Window:GlobalSetting({
    Name = "Show User Info",
    Default = false,
    Callback = function(State)
		print("Show User Info -> " .. (State and "Enabled" or "Disabled"))
		Window:SetUserInfoState(State)
	end,
})

local TabGroup1 = Window:TabGroup()
local HomeTab = TabGroup1:Tab({
    Name = "Home",
    Image = "rbxassetid://6026568198" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = HomeTab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "Credits"
		})
		Section:Paragraph({
			Header = "UI",
			Body = "MacLib"
		})
		Section:Divider()
		Section:Paragraph({
			Header = "Script",
			Body = "NovaOT"
		})
		Section:Divider()
		Section:Paragraph({
			Header = "External Script",
			Body = "?"
		})

local TabGroup2 = Window:TabGroup()
local PlayerTab = TabGroup2:Tab({
    Name = "Player",
    Image = "rbxassetid://6034452643" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = PlayerTab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "Fly"
		})
		Section:Keybind({
			Name = "Fly KeyBind",
			Callback = function(binded)
				FlyModule:toggleFly()
				Window:Notify({
					Title = "Nova HUB",
					Description = "Fly enabled/disabled",
					Lifetime = 3
				})
			end,
			onBinded = function(bind)
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded Nova HUB Fly Keybind to " .. tostring(bind.Name),
					Lifetime = 3
				})
			end,
		})
		Section:Slider({
			Name = "Fly speed",
			Default = 50,
			Minimum = 0,
			Maximum = 500,
			DisplayMethod = "Value",
			Precision = 0,
			Callback = function(Value)
				print("Changed to ".. Value)
			end,
		})

-- Mettre à jour le vol à chaque frame
game:GetService("RunService").RenderStepped:Connect(function()
    FlyModule:updateFlight()  -- Met à jour la position et l'orientation du joueur en vol
end)


local VisualTab = TabGroup2:Tab({
    Name = "Visual",
    Image = "rbxassetid://73762068715433" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = VisualTab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "ESP"
		})
		Section:Keybind({
			Name = "ESP",
			Callback = function(binded)
				Window:Notify({
					Title = "Nova HUB",
					Description = "ESP enabled/disabled",
					Lifetime = 3
				})
			end,
			onBinded = function(bind)
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded ESP to "..tostring(bind.Name),
					Lifetime = 3
				})
			end,
		})

local TabGroup3 = Window:TabGroup()
local ScriptTab = TabGroup3:Tab({
    Name = "Script",
    Image = "rbxassetid://6022668882" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})

local TabGroup4 = Window:TabGroup()
local SettingsTab = TabGroup4:Tab({
    Name = "Settings",
    Image = "rbxassetid://6034509993" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = SettingsTab:Section({
		Side = "Right"
	})
		Section:Header({
			Text = "UI"
		})
		Section:Keybind({
			Name = "Open Keybind",
			onBinded = function(bind)
				Window:SetKeybind(bind) -- Mettre à jour le raccourci clavier
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded Nova HUB Open Keybind to " .. tostring(bind.Name),
					Lifetime = 3
				})
			end
		})
	SettingsTab:InsertConfigSection("Left")

MacLib:SetFolder("NovaHUB")
MacLib:LoadAutoLoadConfig()
Window:Notify({
    Title = "Nova HUB",
    Description = "Nova HUB has been loaded!",
    Lifetime = 5
})
