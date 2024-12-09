-- loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/BetaLoader.lua"))()

local GUI_NAME = "MacLib"
local SettingsFileName = "NovaHUB_Settings.json"

-- Identifier le conteneur correct (PlayerGui en Studio, CoreGui sinon)
local LocalPlayer = game:GetService("Players").LocalPlayer
local guiContainer = (game:GetService("RunService"):IsStudio() and LocalPlayer:WaitForChild("PlayerGui")) or game:GetService("CoreGui")

-- Supprimer tous les GUIs existants avec le même nom
for _, gui in ipairs(guiContainer:GetChildren()) do
    if gui.Name == GUI_NAME then
        gui:Destroy()
    end
end

local function LoadSettings()
    if isfile(SettingsFileName) then
        local data = readfile(SettingsFileName)
        return game:GetService("HttpService"):JSONDecode(data)
    end
    return {}
end

local function SaveSettings(settings)
    local data = game:GetService("HttpService"):JSONEncode(settings)
    writefile(SettingsFileName, data)
end

-- Conversions entre KeyCode et chaîne
local function KeyCodeToString(keyCode)
    return keyCode.Name -- Convertit Enum.KeyCode en une chaîne, par exemple "Q"
end

local function StringToKeyCode(keyString)
    return Enum.KeyCode[keyString] -- Convertit une chaîne, par exemple "Q", en Enum.KeyCode
end

local SavedSettings = LoadSettings()

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
    Default = SavedSettings["ModeratorJoinAlerts"] or false, -- Charger la valeur depuis les paramètres sauvegardés
    Callback = function(State)
        print("Moderator Join Alerts " .. (State and "Enabled" or "Disabled"))
        SavedSettings["ModeratorJoinAlerts"] = State -- Mettre à jour la valeur
        SaveSettings(SavedSettings) -- Sauvegarder les paramètres
    end,
})

local Global_Setting = Window:GlobalSetting({
    Name = "Background Blur",
    Default = SavedSettings["AcrylicBlur"] or false,
    Callback = function(State)
		print("Acrylic Blur -> " .. (State and "Enabled" or "Disabled"))
		SavedSettings["AcrylicBlur"] = State
		SaveSettings(SavedSettings)
		Window:SetAcrylicBlurState(State)
	end,
})

local Global_Setting = Window:GlobalSetting({
    Name = "Show User Info",
    Default = SavedSettings["ShowUserInfo"] or false,
    Callback = function(State)
		print("Show User Info -> " .. (State and "Enabled" or "Disabled"))
		SavedSettings["ShowUserInfo"] = State
		SaveSettings(SavedSettings)
		Window:SetUserInfoState(State)
	end,
})

local TabGroup = Window:TabGroup()
local Tab = TabGroup:Tab({
    Name = "Home",
    Image = "rbxassetid://6026568198" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = Tab:Section({
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

local TabGroup = Window:TabGroup()
local Tab = TabGroup:Tab({
    Name = "Player",
    Image = "rbxassetid://6034452643" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = Tab:Section({
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

local Tab = TabGroup:Tab({
    Name = "Visual",
    Image = "rbxassetid://6026568198" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = Tab:Section({
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

local TabGroup = Window:TabGroup()
local Tab = TabGroup:Tab({
    Name = "Script",
    Image = "rbxassetid://6022668882" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})

local TabGroup = Window:TabGroup()
local Tab = TabGroup:Tab({
    Name = "Settings",
    Image = "rbxassetid://6034509993" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = Tab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "UI"
		})
		Section:Keybind({
			Name = "Open Keybind",
			onBinded = function(bind)
				SavedSettings["NovaHUBOpenKeyBind"] = KeyCodeToString(bind) -- Sauvegarder sous forme de chaîne
				SaveSettings(SavedSettings) -- Sauvegarder les paramètres dans le fichier
				Window:SetKeybind(bind) -- Mettre à jour le raccourci clavier
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded Nova HUB Open Keybind to " .. tostring(bind.Name),
					Lifetime = 3
				})
			end
		})

Window:Notify({
    Title = "Nova HUB",
    Description = "Nova HUB has been loaded!",
    Lifetime = 5
})
