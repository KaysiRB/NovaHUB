local NovaHUBFolder = "NovaHUB"
local SettingsFolder = "NovaHUB/settings" -- Chemin du dossier pour les paramètres
local SettingsFileName = NovaHUBFolder .. "/NovaHUB_Settings.json" -- Chemin complet du fichier

-- Fonction pour vérifier et créer un dossier si nécessaire
local function EnsureFolderExists(folder)
    if not isfolder(folder) then
        makefolder(folder)
    end
end

-- S'assurer que les dossiers existent
EnsureFolderExists("NovaHUB")
EnsureFolderExists(SettingsFolder)

-- Fonction pour charger les paramètres
local function LoadSettings()
    if isfile(SettingsFileName) then
        local data = readfile(SettingsFileName)
        return game:GetService("HttpService"):JSONDecode(data)
    end
    return {}
end

-- Fonction pour sauvegarder les paramètres
local function SaveSettings(settings)
    local data = game:GetService("HttpService"):JSONEncode(settings)
    writefile(SettingsFileName, data)
end

-- Script principal (reste inchangé sauf pour les appels à `LoadSettings` et `SaveSettings`)
local SavedSettings = LoadSettings()

local FlyModule = loadstring(game:HttpGet("https://nova-hub.vercel.app/SCRIPT/HomeMadeFly.lua"))()
local GUI_NAME = "MacLib"
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
local function KeyCodeToString(keyCode)
    return keyCode.Name -- Convertit Enum.KeyCode en une chaîne, par exemple "Q"
end
local function StringToKeyCode(keyString)
    return Enum.KeyCode[keyString] -- Convertit une chaîne, par exemple "Q", en Enum.KeyCode
end



local SavedSettings = LoadSettings()
local MacLib = loadstring(game:HttpGet("https://nova-hub.vercel.app/MODULE/Nova-UI-LIB-BETA.lua"))()

local Window = MacLib:Window({
    Title = "Nova HUB",
    Subtitle = "Beta | V0.50",
    Size = UDim2.fromOffset(868, 650),
    DragStyle = 1,
    DisabledWindowControls = {},
    ShowUserInfo = SavedSettings["ShowUserInfo"] or false,
    AcrylicBlur = SavedSettings["AcrylicBlur"] or false,
    Keybind = SavedSettings["NovaHUBOpenKeyBind"] and StringToKeyCode(SavedSettings["NovaHUBOpenKeyBind"]) -- Charger correctement le bind
})

local Global_Setting = Window:GlobalSetting({
    Name = "Moderator Join Alerts",
    Default = SavedSettings["ModeratorJoinAlerts"] or false, -- Charger la valeur depuis les paramètres sauvegardés 
    Callback = function(State)
        print("Moderator Join Alerts " .. (State and "Enabled" or "Disabled"))
        SavedSettings["ModeratorJoinAlerts"] = State -- Mettre à jour la valeur
        SaveSettings(SavedSettings) -- Sauvegarder les paramètres
    end,
}, "Moderator Join Alerts")

local Global_Setting = Window:GlobalSetting({
    Name = "Background Blur",
    Default = SavedSettings["AcrylicBlur"] or false,  
    Callback = function(State)
		print("Acrylic Blur -> " .. (State and "Enabled" or "Disabled"))
		SavedSettings["AcrylicBlur"] = State
		SaveSettings(SavedSettings)
		Window:SetAcrylicBlurState(State)
	end,
}, "Background Blur")

local Global_Setting = Window:GlobalSetting({
    Name = "Show User Info",
    Default = SavedSettings["ShowUserInfo"] or false, 
    Callback = function(State)
		print("Show User Info -> " .. (State and "Enabled" or "Disabled"))
		SavedSettings["ShowUserInfo"] = State
		SaveSettings(SavedSettings)
		Window:SetUserInfoState(State)
	end,
}, "Show User Info")

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
		-- Section:Keybind({
            -- Name = "Fly KeyBind",
            -- Callback = function(binded)
            -- 		FlyModule:toggleFly()
            -- 		Window:Notify({
            -- 			Title = "Nova HUB",
            -- 			Description = "Fly enabled/disabled",
            -- 			Lifetime = 3
            -- 		})
            -- 	end,
            -- 	onBinded = function(flyBind)
            -- 		Window:SetKeybind(flyBind) -- Mettre à jour le raccourci clavier
            -- 		Window:Notify({
            -- 			Title = "Nova HUB",
            -- 			Description = "Rebinded Nova HUB Fly Keybind to " .. tostring(bind.Name),
            -- 			Lifetime = 3
            -- 		})
            -- 	end,
		-- }, "Fly KeyBind")
		Section:Slider({
			Name = "Fly Speed",
			Default = 50,
			Minimum = 0,
			Maximum = 500,
			DisplayMethod = "Value",
			Precision = 0,
			Callback = function(Value)
				print("Changed to ".. Value)
			end,
		}, "Fly Speed")

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
			Name = "ESP Keybind",
			Callback = function(binded)
				Window:Notify({
					Title = "Nova HUB",
					Description = "ESP enabled/disabled",
					Lifetime = 3
				})
			end,
			onBinded = function(espBind)
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded ESP to "..tostring(espBind.Name),
					Lifetime = 3
				})
			end,
		}, "ESP Keybind")

local TabGroup3 = Window:TabGroup()
local ScriptTab = TabGroup3:Tab({
    Name = "Script",
    Image = "rbxassetid://6022668882" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = ScriptTab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "LT2"
		})
local PianoTab = TabGroup3:Tab({
    Name = "Piano",
    Image = "rbxassetid://87561873406045" -- Image can be at maximum 16 pixels wide and 16 pixels tall.
})
	local Section = PianoTab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "Piano"
		})
        Section:Paragraph({
			Header = "Stop Piano Bind -> F8",
			Body = "[Changable Stop Piano Keybind (WIP)]"
		})
        Section:Divider()
        -- Section:Keybind({
		-- 	Name = "Stop Piano Keybind",
        --     Callback = function(binded)
		-- 		shared.stop = true -- stops the player at any time if true
        --         -- CONFIG:
        --         shared.delay = nil -- delay overides the ftime
        --         shared.tempo = nil -- tempo overides the delay

        --         shared.scr = [[ e ]]

        --         loadstring(game:HttpGet("https://nova-hub.vercel.app/SCRIPT/HomeMadePiano.lua"))()
		-- 		Window:Notify({
		-- 			Title = "Nova HUB",
		-- 			Description = "Piano song has been stoped",
		-- 			Lifetime = 3
		-- 		})
		-- 	end,
		-- 	onBinded = function(stopPiano)
		-- 		Window:SetKeybind(stopPiano) -- Mettre à jour le raccourci clavier
		-- 		Window:Notify({
		-- 			Title = "Nova HUB",
		-- 			Description = "Rebinded Nova HUB Stop Piano to " .. tostring(stopPiano.Name),
		-- 			Lifetime = 3
		-- 		})
		-- 	end
		-- }, "Stop Piano Keybind")
		Section:Button({
		    Name = "Stop Piano",
		    Callback = function()
		    Window:Notify({
			Title = "Nova HUB",
			Description = "Piano song has been stoped.",
			Lifetime = 3
		    })
			shared.stop = true -- stops the player at any time if true
			-- CONFIG:
			shared.delay = nil -- delay overides the ftime
			shared.tempo = nil -- tempo overides the delay
	
			shared.scr = [[ e ]]
	
			loadstring(game:HttpGet("https://nova-hub.vercel.app/SCRIPT/HomeMadePiano.lua"))()
		    end,
			})
    local Section = PianoTab:Section({
		Side = "Left"
	})
        Section:Header({
			Text = "Custom Song"
        })
        Section:Input({
            Name = "Sheet",
            Placeholder = "Custom Sheet",
            AcceptedCharacters = "All",
            Callback = function(input)
                shared.scr = "[[" .. input .. "]]" -- Enregistre l'entrée avec les crochets pour le script
                print("Custom sheet set: " .. shared.scr)
            end
        }, "CustomSheetsInput")
        Section:Button({
            Name = "Play Custom Sheet",
            Callback = function()
                if not shared.scr then
                    Window:Notify({
                        Title = "Nova HUB",
                        Description = "No sheet set. Please input a sheet first.",
                        Lifetime = 3
                    })
                    return
                end

                Window:Notify({
                    Title = "Nova HUB",
                    Description = "Playing custom song.",
                    Lifetime = 3
                })
                
                shared.stop = true -- stops the player at any time if true

                -- CONFIG:
                shared.ftime = 2 * 60 + 00 -- time in seconds for the song to finish (extended by |)
                shared.delay = nil -- delay overides the ftime
                shared.tempo = nil -- tempo overides the delay

                print("Playing custom sheet: " .. shared.scr)

                -- Charger le script pour jouer la musique
                loadstring(game:HttpGet("https://nova-hub.vercel.app/SCRIPT/HomeMadePiano.lua"))()
                
                Window:Notify({
                    Title = "Nova HUB",
                    Description = "Custom song has been finished.",
                    Lifetime = 3
                })
            end,
        })

    local Section = PianoTab:Section({
		Side = "Left"
	})
		Section:Header({
			Text = "Credits"
		})
		Section:Paragraph({
			Header = "Script",
			Body = "JxcExploit"
		})
		Section:Paragraph({
			Header = "Modication",
			Body = "NovaOT"
		})

	local Section = PianoTab:Section({
		Side = "Right"
	})
		Section:Header({
			Text = "Play Music"
		})

local Songs = loadstring(game:HttpGet("https://nova-hub.vercel.app/MODULE/Songs.lua"))()
for songName, data in pairs(Songs) do
    -- Ajouter un espace entre chaque bouton
    Section:Spacer()
    
    -- Création d'un bouton pour chaque chanson
    Section:Button({
        Name = songName,
        Callback = function()
            -- Stopper la chanson en cours si nécessaire
            shared.stop = true
            -- Définir les variables nécessaires pour le script
            shared.ftime = data.ftime
            shared.scr = data.scr
            -- Charger le script pour jouer la chanson
            loadstring(game:HttpGet("https://nova-hub.vercel.app/SCRIPT/HomeMadePiano.lua"))()
			-- print(shared.scr)

            -- Afficher une notification après le lancement de la chanson
            Window:Notify({
                Title = "NovaHUB - Song Started",
                Description = "Playing: " .. songName,
                Lifetime = 3 -- Durée d'affichage de la notification (en secondes)
            })
        end
    })
end

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
			onBinded = function(openBind)
				SavedSettings["NovaHUBOpenKeyBind"] = KeyCodeToString(openBind) -- Sauvegarder sous forme de chaîne
				SaveSettings(SavedSettings) -- Sauvegarder les paramètres dans le fichier
				Window:SetKeybind(openBind) -- Mettre à jour le raccourci clavier
				Window:Notify({
					Title = "Nova HUB",
					Description = "Rebinded Nova HUB Open Keybind to " .. tostring(openBind.Name),
					Lifetime = 3
				})
			end
		}, "Open Keybind")
        Section:Header({
			Text = "Script Workspace"
		})
        Section:Button({
			Name = "Delete",
	        Callback = function()
                Window:Dialog({
                Title = "Nova HUB",
                Description = "Are you sure? This is not reversable (delete is permanent).",
                Buttons = {
                    {
                        Name = "Confirm",
                        Callback = function()
                            print("Confirmed!")
                        end,
                    },
                    {
                        Name = "Cancel"
                    }
                }
            })
			end
		})
    MacLib:SetFolder("NovaHUB")
    local Section = SettingsTab:InsertConfigSection("Left")
    MacLib:LoadAutoLoadConfig()

Window:Notify({
    Title = "Nova HUB",
    Description = "Nova HUB has been loaded!",
    Lifetime = 5
})

-- Mettre à jour le vol à chaque frame
game:GetService("RunService").RenderStepped:Connect(function()
    FlyModule:updateFlight()  -- Met à jour la position et l'orientation du joueur en vol
end)
