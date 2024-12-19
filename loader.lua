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

local FlyModule = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadeFly.lua"))()
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
local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Nova-UI-LIB-BETA.lua"))()

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

        --         loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
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

                loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
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
                loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
                
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




                        --------[[ FADED ]]--------
                        
		Section:Button({
			Name = "Faded",
	        Callback = function()
shared.stop = true -- stops the player at any time if true
-- CONFIG:
shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
shared.delay = nil -- delay overides the ftime
shared.tempo = nil -- tempo overides the delay
Window:Notify({
    Title = "Nova HUB",
    Description = "Playing Faded by Alan Walker.",
    Lifetime = 3
})
shared.scr = [[ [6s] 0 [ts] e [us] t [of] u [4j] 8 [ej] q [tj] e [yh] u
[8f] w [uf] t [of] u [tf] w [5a] 9 [ra] w [ya] r [wp] 0

[6e] s [es] p [us] p [es] d [4f] 8 [qs] s [qo] f q
[8t] w t w t [ws] [ts] [ws] [5a] 9 w [ra] [wa] [rp] [ws] u
[6t] s [es] p [us] p [es] d [4f] u [qs] s [qoh] f q
[8t] t t s [tus] d [5w] [wy] [wy] f f f
[6us] 0 [ts] e [us] t [of] u [4sj] 8 [ej] q [tj] [ef] [fh] f
[8of] w [uf] t [of] u [tf] w [5oa] 9 [ra] w [ya] [rf] [wf] [rf]
[6us] 0 t e [ud] [td] [od] f [4d] [8s] [es] q t [ef] [yf] f
[8of] w u t o [us] s [ts] [5oa] [9a] [ra] [ws] u t e w
f f f [6f] u [ps] e 6 p e s [4qp] o q q
s [ish] [osh] [f8] u o u 8 [us] [8oh] [uh] [of] 5 d 5
5 [of] [of] [of] [6f] u [ps] e 6 [es] [us] [ep] [4g] q u q 4 q u
h [8sf] h [osf] [8h] [osf] h [8of] d g 5 9 w p g w [of] w

[6us] 0 [ts] e [us] [tf] [sfl] [adk] [4sj] 8 [ej] [qp]
[tj] f [th] d [8of] w [uf] t [oh] [ug] [tf] d [5oa] 9 r [wo]
[oag] r [wof] d [6us] 0 [ts] e [us] [tf] [sfl] [adk] [4sj] 8 [ej] [qp]
[tj] [ef] [yh] d [8of] w [uf] t [oh] [ug] [tf] d [5od] 9 r [wo]
[oag] r [wof] d 6 0 e t o ]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
Window:Notify({
    Title = "Nova HUB",
    Description = "Faded by Alan Walker has been finished.",
    Lifetime = 3
})
        	end,
		})




                        --------[[ RUSH E ]]--------

        Section:Spacer()
		Section:Button({
			Name = "Rush E",
	        Callback = function()
shared.stop = true -- stops the player at any time if true
-- CONFIG:
shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
shared.delay = nil -- delay overides the ftime
shared.tempo = nil -- tempo overides the delay
Window:Notify({
    Title = "Nova HUB",
    Description = "Playing Rush E by Sheet Music Boss.",
    Lifetime = 3
})
shared.scr = [[ u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u 6 [80] 3 [80] 3 $ % [6] [80] 3 [80] [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [%d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(ea] a [$I] [(ea] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [6] 7 * [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] 6 [0es] [0a] [Wr] P [7a] [Wrs] [0d] [Wrs] [7a] [Wrd] [6s] [6p] [8s] [0f] [ej] [0f] [8s] [6p] [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9WH] k [6j] f [8es] p [7g] f d s [30a] p O a [6ep] [6] [80] 3 [80] 3 $ % [6] [80] 3 [80] [6] [80e] 3 [80e] 3 $ % [6] [80e] 3 [80e] [6] [0et] 3 [0et] [6] [etu] 3 [etu] [6] [tup] 3 [ups] [6] [psf] 3 [sfj] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] g [80f] D [6f] [80j] [3l] [80] [7fH] z [90fH] z [3fH] z [90fH] z [6fj] l [80fj] l [3fj] l [80fj] l [7DG] k [(QDG] k [$G] [(Qk] [0fWH] [3] $ % [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] g [80f] D [3f] [80j] l [6x] [80b] [3m] [80] [9] m [qen] [8m] n [0eb] m [7n] b [9WV] n [6b] x [80l] j [7c] x z l [30k] j H k [6ej] 6 [yd] [ip] S d [ipf] g [ipf] [yd] [ipg] [tf] [up] d s [upd] f [up] t [ups] [ra] [ru] P a [rus] d [rus] [ra] [rud] [es] [ep] [ts] [uf] [epj] [0uf] [8ts] [6ep] [9d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] i [80u] Y [6u] [80p] [3s] [80] [7uO] d [90uO] d [3uO] d [90uO] d [6up] s [80up] s [3up] s [80up] s [7YI] a [(QYI] a [$I] [(Qa] [0uWO] [3] $ % [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9qz] l [ek] z [80l] k [ej] l [79k] j [0H] k [68j] f [0s] p [%0g] f d s [30a] p O a [6ep] [6] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] I [*qi] u [^i] [q*P] [4S] [*q] [8ip] D [(qip] D [4ip] D [(qip] D [i^P] S [qi*P] S [4iP] S [qi*P] S [8uo] s [0wuo] s [5o] [0ws] [qeip] [4] 5 6 [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] I [*qi] u [4i] [q*P] S [^g] [q*J] [4L] [*q] [(Z] L [QEl] Z [*L] l [qEJ] L [8l] J [(ej] l [^J] g [q*S] P [8G] g D S [4qs] P p s [^EP] [^] [(Q] m [q*] m B [(8m] B b m [^*B] c L J [68C] c Z L [4ql] J j l [^EJ] [^JLB] ]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
Window:Notify({
    Title = "Nova HUB",
    Description = "Rush E by Sheet Music Boss has been finished.",
    Lifetime = 3
})
        	end,
		})




                        --------[[ TEST ]]--------

        Section:Spacer()
local Songs = loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/MODULE/Songs.lua"))()

for songName, data in pairs(Songs) do
    Section:NewButton(songName, "Play " .. songName, function()
        shared.stop = true
        shared.ftime = data.ftime
        shared.scr = data.scr
        loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/AutoPlayPianoScript/main/NewAutoPlayPiano"))()
    end)
end





--                         --------[[ RUSH E ]]--------

--         Section:Spacer()
-- 		Section:Button({
-- 			Name = "Rush E",
-- 	        Callback = function()
-- shared.stop = true -- stops the player at any time if true
-- -- CONFIG:
-- shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
-- shared.delay = nil -- delay overides the ftime
-- shared.tempo = nil -- tempo overides the delay
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Playing Rush E by Sheet Music Boss.",
--     Lifetime = 3
-- })
-- shared.scr = [[ u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u 6 [80] 3 [80] 3 $ % [6] [80] 3 [80] [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [%d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(ea] a [$I] [(ea] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [6] 7 * [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] 6 [0es] [0a] [Wr] P [7a] [Wrs] [0d] [Wrs] [7a] [Wrd] [6s] [6p] [8s] [0f] [ej] [0f] [8s] [6p] [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9WH] k [6j] f [8es] p [7g] f d s [30a] p O a [6ep] [6] [80] 3 [80] 3 $ % [6] [80] 3 [80] [6] [80e] 3 [80e] 3 $ % [6] [80e] 3 [80e] [6] [0et] 3 [0et] [6] [etu] 3 [etu] [6] [tup] 3 [ups] [6] [psf] 3 [sfj] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] g [80f] D [6f] [80j] [3l] [80] [7fH] z [90fH] z [3fH] z [90fH] z [6fj] l [80fj] l [3fj] l [80fj] l [7DG] k [(QDG] k [$G] [(Qk] [0fWH] [3] $ % [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] g [80f] D [3f] [80j] l [6x] [80b] [3m] [80] [9] m [qen] [8m] n [0eb] m [7n] b [9WV] n [6b] x [80l] j [7c] x z l [30k] j H k [6ej] 6 [yd] [ip] S d [ipf] g [ipf] [yd] [ipg] [tf] [up] d s [upd] f [up] t [ups] [ra] [ru] P a [rus] d [rus] [ra] [rud] [es] [ep] [ts] [uf] [epj] [0uf] [8ts] [6ep] [9d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] i [80u] Y [6u] [80p] [3s] [80] [7uO] d [90uO] d [3uO] d [90uO] d [6up] s [80up] s [3up] s [80up] s [7YI] a [(QYI] a [$I] [(Qa] [0uWO] [3] $ % [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9qz] l [ek] z [80l] k [ej] l [79k] j [0H] k [68j] f [0s] p [%0g] f d s [30a] p O a [6ep] [6] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] I [*qi] u [^i] [q*P] [4S] [*q] [8ip] D [(qip] D [4ip] D [(qip] D [i^P] S [qi*P] S [4iP] S [qi*P] S [8uo] s [0wuo] s [5o] [0ws] [qeip] [4] 5 6 [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] I [*qi] u [4i] [q*P] S [^g] [q*J] [4L] [*q] [(Z] L [QEl] Z [*L] l [qEJ] L [8l] J [(ej] l [^J] g [q*S] P [8G] g D S [4qs] P p s [^EP] [^] [(Q] m [q*] m B [(8m] B b m [^*B] c L J [68C] c Z L [4ql] J j l [^EJ] [^JLB] ]]

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Rush E by Sheet Music Boss has been finished.",
--     Lifetime = 3
-- })
--         	end,
-- 		})




--                         --------[[ RUSH E ]]--------

--         Section:Spacer()
-- 		Section:Button({
-- 			Name = "Rush E",
-- 	        Callback = function()
-- shared.stop = true -- stops the player at any time if true
-- -- CONFIG:
-- shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
-- shared.delay = nil -- delay overides the ftime
-- shared.tempo = nil -- tempo overides the delay
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Playing Rush E by Sheet Music Boss.",
--     Lifetime = 3
-- })
-- shared.scr = [[ u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u 6 [80] 3 [80] 3 $ % [6] [80] 3 [80] [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [%d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(ea] a [$I] [(ea] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [6] 7 * [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] 6 [0es] [0a] [Wr] P [7a] [Wrs] [0d] [Wrs] [7a] [Wrd] [6s] [6p] [8s] [0f] [ej] [0f] [8s] [6p] [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9WH] k [6j] f [8es] p [7g] f d s [30a] p O a [6ep] [6] [80] 3 [80] 3 $ % [6] [80] 3 [80] [6] [80e] 3 [80e] 3 $ % [6] [80e] 3 [80e] [6] [0et] 3 [0et] [6] [etu] 3 [etu] [6] [tup] 3 [ups] [6] [psf] 3 [sfj] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] g [80f] D [6f] [80j] [3l] [80] [7fH] z [90fH] z [3fH] z [90fH] z [6fj] l [80fj] l [3fj] l [80fj] l [7DG] k [(QDG] k [$G] [(Qk] [0fWH] [3] $ % [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] g [80f] D [3f] [80j] l [6x] [80b] [3m] [80] [9] m [qen] [8m] n [0eb] m [7n] b [9WV] n [6b] x [80l] j [7c] x z l [30k] j H k [6ej] 6 [yd] [ip] S d [ipf] g [ipf] [yd] [ipg] [tf] [up] d s [upd] f [up] t [ups] [ra] [ru] P a [rus] d [rus] [ra] [rud] [es] [ep] [ts] [uf] [epj] [0uf] [8ts] [6ep] [9d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] i [80u] Y [6u] [80p] [3s] [80] [7uO] d [90uO] d [3uO] d [90uO] d [6up] s [80up] s [3up] s [80up] s [7YI] a [(QYI] a [$I] [(Qa] [0uWO] [3] $ % [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9qz] l [ek] z [80l] k [ej] l [79k] j [0H] k [68j] f [0s] p [%0g] f d s [30a] p O a [6ep] [6] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] I [*qi] u [^i] [q*P] [4S] [*q] [8ip] D [(qip] D [4ip] D [(qip] D [i^P] S [qi*P] S [4iP] S [qi*P] S [8uo] s [0wuo] s [5o] [0ws] [qeip] [4] 5 6 [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] I [*qi] u [4i] [q*P] S [^g] [q*J] [4L] [*q] [(Z] L [QEl] Z [*L] l [qEJ] L [8l] J [(ej] l [^J] g [q*S] P [8G] g D S [4qs] P p s [^EP] [^] [(Q] m [q*] m B [(8m] B b m [^*B] c L J [68C] c Z L [4ql] J j l [^EJ] [^JLB] ]]

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Rush E by Sheet Music Boss has been finished.",
--     Lifetime = 3
-- })
--         	end,
-- 		})




--                         --------[[ RUSH E ]]--------

--         Section:Spacer()
-- 		Section:Button({
-- 			Name = "Rush E",
-- 	        Callback = function()
-- shared.stop = true -- stops the player at any time if true
-- -- CONFIG:
-- shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
-- shared.delay = nil -- delay overides the ftime
-- shared.tempo = nil -- tempo overides the delay
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Playing Rush E by Sheet Music Boss.",
--     Lifetime = 3
-- })
-- shared.scr = [[ u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u 6 [80] 3 [80] 3 $ % [6] [80] 3 [80] [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [%d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(ea] a [$I] [(ea] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [6] 7 * [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] 6 [0es] [0a] [Wr] P [7a] [Wrs] [0d] [Wrs] [7a] [Wrd] [6s] [6p] [8s] [0f] [ej] [0f] [8s] [6p] [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9WH] k [6j] f [8es] p [7g] f d s [30a] p O a [6ep] [6] [80] 3 [80] 3 $ % [6] [80] 3 [80] [6] [80e] 3 [80e] 3 $ % [6] [80e] 3 [80e] [6] [0et] 3 [0et] [6] [etu] 3 [etu] [6] [tup] 3 [ups] [6] [psf] 3 [sfj] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] g [80f] D [6f] [80j] [3l] [80] [7fH] z [90fH] z [3fH] z [90fH] z [6fj] l [80fj] l [3fj] l [80fj] l [7DG] k [(QDG] k [$G] [(Qk] [0fWH] [3] $ % [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] g [80f] D [3f] [80j] l [6x] [80b] [3m] [80] [9] m [qen] [8m] n [0eb] m [7n] b [9WV] n [6b] x [80l] j [7c] x z l [30k] j H k [6ej] 6 [yd] [ip] S d [ipf] g [ipf] [yd] [ipg] [tf] [up] d s [upd] f [up] t [ups] [ra] [ru] P a [rus] d [rus] [ra] [rud] [es] [ep] [ts] [uf] [epj] [0uf] [8ts] [6ep] [9d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] i [80u] Y [6u] [80p] [3s] [80] [7uO] d [90uO] d [3uO] d [90uO] d [6up] s [80up] s [3up] s [80up] s [7YI] a [(QYI] a [$I] [(Qa] [0uWO] [3] $ % [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9qz] l [ek] z [80l] k [ej] l [79k] j [0H] k [68j] f [0s] p [%0g] f d s [30a] p O a [6ep] [6] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] I [*qi] u [^i] [q*P] [4S] [*q] [8ip] D [(qip] D [4ip] D [(qip] D [i^P] S [qi*P] S [4iP] S [qi*P] S [8uo] s [0wuo] s [5o] [0ws] [qeip] [4] 5 6 [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] I [*qi] u [4i] [q*P] S [^g] [q*J] [4L] [*q] [(Z] L [QEl] Z [*L] l [qEJ] L [8l] J [(ej] l [^J] g [q*S] P [8G] g D S [4qs] P p s [^EP] [^] [(Q] m [q*] m B [(8m] B b m [^*B] c L J [68C] c Z L [4ql] J j l [^EJ] [^JLB] ]]

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Rush E by Sheet Music Boss has been finished.",
--     Lifetime = 3
-- })
--         	end,
-- 		})




--                         --------[[ RUSH E ]]--------

--         Section:Spacer()
-- 		Section:Button({
-- 			Name = "Rush E",
-- 	        Callback = function()
-- shared.stop = true -- stops the player at any time if true
-- -- CONFIG:
-- shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
-- shared.delay = nil -- delay overides the ftime
-- shared.tempo = nil -- tempo overides the delay
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Playing Rush E by Sheet Music Boss.",
--     Lifetime = 3
-- })
-- shared.scr = [[ u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u 6 [80] 3 [80] 3 $ % [6] [80] 3 [80] [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [%d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(ea] a [$I] [(ea] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [6] 7 * [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] 6 [0es] [0a] [Wr] P [7a] [Wrs] [0d] [Wrs] [7a] [Wrd] [6s] [6p] [8s] [0f] [ej] [0f] [8s] [6p] [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9WH] k [6j] f [8es] p [7g] f d s [30a] p O a [6ep] [6] [80] 3 [80] 3 $ % [6] [80] 3 [80] [6] [80e] 3 [80e] 3 $ % [6] [80e] 3 [80e] [6] [0et] 3 [0et] [6] [etu] 3 [etu] [6] [tup] 3 [ups] [6] [psf] 3 [sfj] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] g [80f] D [6f] [80j] [3l] [80] [7fH] z [90fH] z [3fH] z [90fH] z [6fj] l [80fj] l [3fj] l [80fj] l [7DG] k [(QDG] k [$G] [(Qk] [0fWH] [3] $ % [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] g [80f] D [3f] [80j] l [6x] [80b] [3m] [80] [9] m [qen] [8m] n [0eb] m [7n] b [9WV] n [6b] x [80l] j [7c] x z l [30k] j H k [6ej] 6 [yd] [ip] S d [ipf] g [ipf] [yd] [ipg] [tf] [up] d s [upd] f [up] t [ups] [ra] [ru] P a [rus] d [rus] [ra] [rud] [es] [ep] [ts] [uf] [epj] [0uf] [8ts] [6ep] [9d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] i [80u] Y [6u] [80p] [3s] [80] [7uO] d [90uO] d [3uO] d [90uO] d [6up] s [80up] s [3up] s [80up] s [7YI] a [(QYI] a [$I] [(Qa] [0uWO] [3] $ % [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9qz] l [ek] z [80l] k [ej] l [79k] j [0H] k [68j] f [0s] p [%0g] f d s [30a] p O a [6ep] [6] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] I [*qi] u [^i] [q*P] [4S] [*q] [8ip] D [(qip] D [4ip] D [(qip] D [i^P] S [qi*P] S [4iP] S [qi*P] S [8uo] s [0wuo] s [5o] [0ws] [qeip] [4] 5 6 [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] I [*qi] u [4i] [q*P] S [^g] [q*J] [4L] [*q] [(Z] L [QEl] Z [*L] l [qEJ] L [8l] J [(ej] l [^J] g [q*S] P [8G] g D S [4qs] P p s [^EP] [^] [(Q] m [q*] m B [(8m] B b m [^*B] c L J [68C] c Z L [4ql] J j l [^EJ] [^JLB] ]]

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Rush E by Sheet Music Boss has been finished.",
--     Lifetime = 3
-- })
--         	end,
-- 		})




--                         --------[[ RUSH E ]]--------

--         Section:Spacer()
-- 		Section:Button({
-- 			Name = "Rush E",
-- 	        Callback = function()
-- shared.stop = true -- stops the player at any time if true
-- -- CONFIG:
-- shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
-- shared.delay = nil -- delay overides the ftime
-- shared.tempo = nil -- tempo overides the delay
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Playing Rush E by Sheet Music Boss.",
--     Lifetime = 3
-- })
-- shared.scr = [[ u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u u 6 [80] 3 [80] 3 $ % [6] [80] 3 [80] [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [%d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(ea] a [$I] [(ea] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9qH] k [6j] f [80s] p [30g] f [$Qd] s [%Wa] p [30O] a [6ep] [6] 7 * [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] 6 [0es] [0a] [Wr] P [7a] [Wrs] [0d] [Wrs] [7a] [Wrd] [6s] [6p] [8s] [0f] [ej] [0f] [8s] [6p] [29d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] i [80u] Y [6u] [80p] [3s] [80] [7d] d [90d] d [3d] s [90a] d [6s] s [80s] s [3s] a [80p] s [7a] a [(Qa] a [$I] [(Qa] [0WO] [3] $ % [6u] u [80u] u [3u] u [80u] u [6u] u [80u] u [3u] u [80u] u [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9z] l [qek] z [8l] k [0ej] l [7k] j [9WH] k [6j] f [8es] p [7g] f d s [30a] p O a [6ep] [6] [80] 3 [80] 3 $ % [6] [80] 3 [80] [6] [80e] 3 [80e] 3 $ % [6] [80e] 3 [80e] [6] [0et] 3 [0et] [6] [etu] 3 [etu] [6] [tup] 3 [ups] [6] [psf] 3 [sfj] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] g [80f] D [6f] [80j] [3l] [80] [7fH] z [90fH] z [3fH] z [90fH] z [6fj] l [80fj] l [3fj] l [80fj] l [7DG] k [(QDG] k [$G] [(Qk] [0fWH] [3] $ % [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] [ps] [80f] [ps] [3f] [ps] [80f] [ps] [6f] g [80f] D [3f] [80j] l [6x] [80b] [3m] [80] [9] m [qen] [8m] n [0eb] m [7n] b [9WV] n [6b] x [80l] j [7c] x z l [30k] j H k [6ej] 6 [yd] [ip] S d [ipf] g [ipf] [yd] [ipg] [tf] [up] d s [upd] f [up] t [ups] [ra] [ru] P a [rus] d [rus] [ra] [rud] [es] [ep] [ts] [uf] [epj] [0uf] [8ts] [6ep] [9d] [qe] S [6d] [qef] [9g] [qef] [6d] [qeg] [8f] [0e] d [6s] [0ed] [8f] [0e] [6j] [0e] 9 [qed] 7 [qeg] [30f] [18s] [29d] [7a] [6p] [O3uf] [6psj] [3] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] i [80u] Y [6u] [80p] [3s] [80] [7uO] d [90uO] d [3uO] d [90uO] d [6up] s [80up] s [3up] s [80up] s [7YI] a [(QYI] a [$I] [(Qa] [0uWO] [3] $ % [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] [et] [80u] [et] [3u] [et] [80u] [et] [6u] i [80u] Y [3u] [80p] s [6f] [80j] [3l] [80] [9qz] l [ek] z [80l] k [ej] l [79k] j [0H] k [68j] f [0s] p [%0g] f d s [30a] p O a [6ep] [6] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] I [*qi] u [^i] [q*P] [4S] [*q] [8ip] D [(qip] D [4ip] D [(qip] D [i^P] S [qi*P] S [4iP] S [qi*P] S [8uo] s [0wuo] s [5o] [0ws] [qeip] [4] 5 6 [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] [ET] [*qi] [ET] [4i] [ET] [*qi] [ET] [^i] I [*qi] u [4i] [q*P] S [^g] [q*J] [4L] [*q] [(Z] L [QEl] Z [*L] l [qEJ] L [8l] J [(ej] l [^J] g [q*S] P [8G] g D S [4qs] P p s [^EP] [^] [(Q] m [q*] m B [(8m] B b m [^*B] c L J [68C] c Z L [4ql] J j l [^EJ] [^JLB] ]]

-- loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/NovaHUB/refs/heads/main/SCRIPT/HomeMadePiano.lua"))()
-- Window:Notify({
--     Title = "Nova HUB",
--     Description = "Rush E by Sheet Music Boss has been finished.",
--     Lifetime = 3
-- })
--         	end,
-- 		})

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
