local UserInputService = game:GetService("UserInputService")

-- Configuration
local song = [[ 
[6s] 0 [ts] e [us] t [of] u [4j] 8 [ej] q [tj] e [yh] u
[8f] w [uf] t [of] u [tf] w [5a] 9 [ra] w [ya] r [wp] 0
]] -- Mets ici ta partition
local noteDurations = {
    [""] = 15,
    [" "] = 30,
    ["-"] = 60,
    ["|"] = 240
}
local defaultDuration = 30 -- Durée par défaut entre chaque note (en millisecondes)

-- Fonction pour convertir un caractère en durée
local function getDuration(char)
    return noteDurations[char] or defaultDuration
end

-- Fonction pour jouer une note
local function playKey(note)
    local virtualInput = game:GetService("VirtualInputManager")
    virtualInput:SendKeyEvent(true, note, false, nil) -- Appuie sur la touche
    task.wait(0.1) -- Maintient la touche brièvement
    virtualInput:SendKeyEvent(false, note, false, nil) -- Relâche la touche
end

-- Fonction pour jouer une partition
local function playSong(song)
    for char in song:gmatch(".") do
        if char:match("%w") then -- Vérifie si c'est une lettre ou un chiffre
            playKey(char)
        end
        task.wait(getDuration(char) / 1000) -- Attends la durée appropriée
    end
end

-- Lancer la lecture
playSong(song)
