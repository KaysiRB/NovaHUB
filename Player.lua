shared.stop = true
wait(1)
shared.stop = false

shared.nospacedelay = shared.nospacedelay or false

local str = shared.scr or "qw[er]ty"
local FinishTime = shared.ftime or 10  -- Durée de la simulation de frappe (en secondes)

local vim = game:GetService("VirtualInputManager")

local nstr = string.gsub(str, "[[\\]\n]", "")

-- Calculer le délai entre chaque touche pour que la simulation dure 2 secondes
local delay = FinishTime / #nstr

print("Finishing in", math.floor(delay * #nstr / 60), "minute/s", tostring(tonumber(tostring((delay * #nstr) / 60):sub(3, 8)) * 60):sub(1, 2), "second/s")

local shifting = false

local function doshift(key)
    if key:upper() ~= key then return end
    if tonumber(key) then return end
    
    vim:SendKeyEvent(true, 304, false, nil)  -- Appuie sur Shift
    shifting = true
end

local function endshift()
    if not shifting then return end
    
    vim:SendKeyEvent(false, 304, false, nil)  -- Relâche Shift
    shifting = false
end

local queue = ""
local rem = true

-- Délais pour des caractères spécifiques (ajouter des délais personnalisés ici)
local PressureTime = shared.PressureTime or {
    [""] = 15,   -- 0.15 secondes
    [' '] = 60,  -- 0.60 secondes (plus long pour l'espace)
    ['-'] = 100, -- 1.00 seconde (plus long pour les tirets)
    ['|'] = 240  -- 2.40 secondes
}

local function getPressureDelay(c)
    -- Si un délai spécifique est défini pour cette touche, on l'utilise, sinon on utilise le délai par défaut
    local pressure = PressureTime[c]
    if pressure then
        return pressure / 100  -- Convertir le délai en secondes
    else
        return delay  -- Utiliser le délai par défaut si la touche n'a pas de délai spécifique
    end
end


-- Boucle pour envoyer les frappes de texte
for i = 1, #str do
    if shared.stop == true then return end

    local c = str:sub(i, i)

    if c == "[" then
        rem = false
        continue
    elseif c == "]" then
        rem = true
        if string.find(queue, " ") then
            -- Traitement des caractères espacés
            for ii = 1, #queue do
                local cc = queue:sub(ii, ii)
                pcall(function()
                    doshift(cc)
                    vim:SendKeyEvent(true, string.byte(cc:lower()), false, nil)
                    wait(getPressureDelay(cc))  -- Attendre le délai de pression
                    vim:SendKeyEvent(false, string.byte(cc:lower()), false, nil)
                    endshift()
                end)
            end
        else
            -- Traitement des caractères sans espace
            for ii = 1, #queue do
                local cc = queue:sub(ii, ii)
                pcall(function()
                    doshift(cc)
                    vim:SendKeyEvent(true, string.byte(cc:lower()), false, nil)
                    endshift()
                end)
                wait()
            end
            wait()
            for ii = 1, #queue do
                local cc = queue:sub(ii, ii)
                pcall(function()
                    doshift(cc)
                    vim:SendKeyEvent(false, string.byte(cc:lower()), false, nil)
                    endshift()
                end)
                wait()
            end
        end
        queue = ""
        continue
    elseif c == " " or string.byte(c) == 10 then
        if shared.nospacedelay then continue end
        wait(getPressureDelay(" "))  -- Attendre le délai pour l'espace
        continue
    elseif c == "|" or c == "-" then
        wait(getPressureDelay(c))  -- Gérer les caractères spéciaux (plus long pour '-' et '|')
        continue
    end
    
    if not rem then
        queue = queue .. c
        continue
    end

    pcall(function()
        doshift(c)
        vim:SendKeyEvent(true, string.byte(c:lower()), false, nil)
        wait(getPressureDelay(c))  -- Délai de pression pour chaque caractère
        vim:SendKeyEvent(false, string.byte(c:lower()), false, nil)
        endshift()
    end)

    wait(delay)  -- Attendre le délai défini entre les frappes de touche
end
