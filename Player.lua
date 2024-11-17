-- Assure-toi que les temps de pression sont respectés dans ce script
local noteDurations = {
    [""] = 15,   -- 0,15 seconde
    [' '] = 30,  -- 0,30 seconde
    ['-'] = 60,  -- 0,60 seconde
    ['|'] = 240  -- 2,4 secondes
}

local function getDuration(char)
    return (noteDurations[char] or 0.15) / 100  -- Utilise la durée définie en secondes
end

local function doshift(key)
    -- Applique le décalage pour les lettres majuscules
    if key:upper() ~= key then return end
    if tonumber(key) then return end
    
    vim:SendKeyEvent(true, 304, false, nil)  -- Shift appuyé
    shifting = true
end

local function endshift()
    -- Relâche le décalage
    if not shifting then return end
    
    vim:SendKeyEvent(false, 304, false, nil)  -- Shift relâché
    shifting = false
end

local queue = ""
local rem = true

for i=1, #str do
    if shared.stop == true then return end

    local c = str:sub(i, i)

    -- Traitement des notes spéciales (comme les crochets pour les espaces et autres)
    if c == "[" then
        rem = false
        continue
    elseif c == "]" then
        rem = true
        -- Exécution des notes dans la queue
        for ii = 1, #queue do
            local cc = queue:sub(ii, ii)
            pcall(function()
                doshift(cc)
                vim:SendKeyEvent(true, string.byte(cc:lower()), false, nil)
                wait(getDuration(cc))  -- Durée de pression ici
                vim:SendKeyEvent(false, string.byte(cc:lower()), false, nil)
                endshift()
            end)
        end
        queue = ""
        continue
    end

    -- Ajout des notes dans la queue
    if not rem then
        queue = queue .. c
        continue
    end

    -- Envoi de la touche avec la durée de pression
    pcall(function()
        doshift(c)
        vim:SendKeyEvent(true, string.byte(c:lower()), false, nil)
        wait(getDuration(c))  -- Durée de pression ici
        vim:SendKeyEvent(false, string.byte(c:lower()), false, nil)
        endshift()
    end)

    wait(getDuration(c))  -- Attente après chaque note selon sa durée
end
