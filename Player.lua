-- Définir les durées de pression des notes
local noteDurations = {
    [""] = 0.15,   -- 0,15 seconde
    [' '] = 0.30,  -- 0,30 seconde
    ['-'] = 0.60,  -- 0,60 seconde
    ['|'] = 2.40   -- 2,4 secondes
}

-- Fonction pour obtenir la durée de pression d'une note
local function getDuration(char)
    return noteDurations[char] or 0.15  -- Retourne la durée définie pour la note, sinon 0.15 seconde par défaut
end

-- Fonction pour envoyer la pression d'une touche (en maintenant)
local function pressKey(key)
    vim:SendKeyEvent(true, string.byte(key), false, nil)
end

-- Fonction pour relâcher une touche
local function releaseKey(key)
    vim:SendKeyEvent(false, string.byte(key), false, nil)
end

local queue = ""
local rem = true

-- Fonction pour jouer les notes en fonction de la partition
for i = 1, #str do
    if shared.stop == true then return end  -- Vérifie si on doit arrêter

    local c = str:sub(i, i)  -- Obtient chaque caractère dans la partition

    -- Gestion des crochets pour regrouper des notes
    if c == "[" then
        rem = false
        continue
    elseif c == "]" then
        rem = true
        -- Traitement de la queue de notes
        for ii = 1, #queue do
            local cc = queue:sub(ii, ii)
            pcall(function()
                pressKey(cc)
                wait(getDuration(cc))  -- Attente selon la durée de pression
                releaseKey(cc)
            end)
        end
        queue = ""
        continue
    end

    -- Si la touche n'est pas dans la zone de suppression, on l'ajoute à la queue
    if not rem then
        queue = queue .. c
        continue
    end

    -- Si la touche est valide, on la presse et la maintient pendant la durée définie
    pcall(function()
        pressKey(c)
        wait(getDuration(c))  -- Maintien la touche pendant la durée de pression
        releaseKey(c)
    end)

    -- Attente avant de passer à la prochaine note
    wait(getDuration(c))
end
