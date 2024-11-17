-- Player.lua

-- Vérifie si la partition existe, sinon définit une partition vide
shared.scr = shared.scr or [[ e ]] 

local vim = game:GetService("VirtualInputManager")
local delay = shared.delay or 1  -- Utilise le délai configuré ou 1 seconde par défaut

-- Fonction pour appuyer sur une touche
local function pressKey(key)
    vim:SendKeyEvent(true, string.byte(key:lower()), false, nil)
end

-- Fonction pour relâcher une touche
local function releaseKey(key)
    vim:SendKeyEvent(false, string.byte(key:lower()), false, nil)
end

-- Fonction pour jouer la partition
local function playMusic()
    for i = 1, #shared.scr do
        if shared.stop then
            return
        end
        
        local note = shared.scr:sub(i, i)
        
        -- Gérer les symboles spéciaux et les délais
        if note == " " then
            wait(delay)
        elseif note == "|" then
            wait(delay * 2)  -- Double délai pour la barre de séparation
        elseif note == "-" then
            wait(delay * 3)  -- Plus long délai pour la pause
        else
            pressKey(note)  -- Appuie sur la touche
            wait(delay)  -- Délai de la note
            releaseKey(note)  -- Relâche la touche
        end
    end
end

-- Lancer la musique dès que ce script est chargé
playMusic()
