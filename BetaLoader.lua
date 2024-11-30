local SettingsFileName = "NovaHUB_Settings.json"
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
local SavedSettings = LoadSettings()

local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB-BETA.lua"))()

local Window = MacLib:Window({
    Title = "Nova HUB",
    Subtitle = "Beta | V0.50",
    Size = UDim2.fromOffset(868, 650),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = true,
    Keybind = savedSettings["ModeratorJoinAlerts"] or Enum.KeyCode.RightControl
    AcrylicBlur = true
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


local TabGroup = Window:TabGroup()
    local Tab = TabGroup:Tab({
        Name = "Home",
        Image = "rbxassetid://6026568198" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
    })
    local Section = Tab:Section({
        Side = "Left"
    })
        Section:Paragraph({
            Header = "Credits",
            Body = "UI - MacLib"
        })
		Section:Keybind({
			Name = "Open Keybind",
			Callback = function()
				Window:Notify({
					Title = "Nova HUB",
					Description = "Successfully Pressed",
					Lifetime = 3
				})
			end,
			onBinded = function(bind)
				Window:SetKeybind(bind)
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded Open Keybind to " .. tostring(bind.Name),
					Lifetime = 3
				})
			end,
		})

Window:Notify({
    Title = "Nova HUB",
    Description = "Nova HUB has been loaded!",
    Lifetime = 5
})
