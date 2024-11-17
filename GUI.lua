local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Play Piano V1 - Made By NovaOT (Beta Version)", "BloodTheme")

-- Tab Auto Piano
local Tab = Window:NewTab("Auto Piano")
local Section = Tab:NewSection("Auto Piano")

-- Bouton pour jouer "AOT"
Section:NewButton("AOT", "Autoplayf", function()
    -- Démarre l'autoplay du piano avec la partition définie dans Player.lua
    shared.stop = true  -- Permet d'arrêter à tout moment si true
    -- CONFIG
    shared.ftime = 2*60 + 00 -- temps en secondes pour finir la chanson
    shared.delay = nil -- délai surclasse le ftime
    shared.tempo = nil -- tempo surclasse le délai

    -- Définir la partition
    shared.scr = [[ 
        6 | p s [quf] | [wy] - [ak] [sl] [eud] | [0oh] a [qtp] | ...
        [9rp] a [0ps] [dz] f - j - [wpd] - [Qaf] k l z -
        ]] -- Remplacer par la partition réelle

    -- Charger Player.lua pour jouer la partition
    loadstring(game:HttpGet("https://github.com/KaysiRB/SMTHNG/raw/refs/heads/main/Player.lua"))()
end)

local Tab = Window:NewTab("Stop Piano")
local Section = Tab:NewSection("Stop Piano")
Section:NewButton("Stop piano", "Auto", function()  
 -- Sheet for Rondo Alla Turca by Wolfgang Amadeus Mozart

shared.stop = true -- stops the player at any time if true
-- CONFIG:
shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
shared.delay = nil -- delay overides the ftime
shared.tempo = nil -- tempo overides the delay

shared.scr = [[ e ]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/AutoPlayPianoScript/main/NewAutoPlayPiano"))()

end)
Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()

end)
local Tab = Window:NewTab("Speed")
local Section = Tab:NewSection("Speed")
Section:NewSlider("Speed", "SliderInfo", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)
local Tab = Window:NewTab("Custom Sheets")
local Section = Tab:NewSection("Create your own Auto Play")
Section:NewButton("WIP!", "Auto", function()
    -- À personnaliser si nécessaire
end)
