-- Assurer que les variables sont bien initialisées
shared.stop = true
wait(1)
shared.stop = false

shared.nospacedelay = shared.nospacedelay or false

local str = shared.scr or "qw[er]ty"
local FinishTime = shared.ftime or 10

local vim = game:GetService("VirtualInputManager")

-- Nettoyer les crochets et les nouvelles lignes dans le texte à simuler
local nstr = string.gsub(str, "[[%]\n]", "")

-- Calculer le délai, en s'assurant qu'il n'est pas nil
local delay = shared.tempo and (6 / shared.tempo) or shared.delay or FinishTime / (string.len(nstr) / 1.05)

-- S'assurer que delay n'est pas nil et donner une valeur par défaut
if not delay then
    delay = 0.5  -- Valeur par défaut pour éviter les erreurs
end

print("Finishing in", math.floor((delay * #nstr) / 60), "minute/s", tostring(tonumber(tostring((delay * #nstr) / 60):sub(3, 8)) * 60):sub(1, 2), "second/s")

local shifting = false

-- Fonction pour activer la touche Shift (si nécessaire)
local function doshift(key)
    if key:upper() ~= key then return end  -- Si c'est une lettre minuscule, ne pas activer Shift
    if tonumber(key) then return end  -- Si c'est un nombre, ne pas activer Shift
    
    vim:SendKeyEvent(true, 304, false, nil)  -- Envoyer un événement de pression de la touche Shift
    shifting = true
end

-- Fonction pour désactiver la touche Shift
local function endshift()
    if not shifting then return end
    
    vim:SendKeyEvent(false, 304, false, nil)  -- Envoyer un événement de relâchement de la touche Shift
    shifting = false
end

local queue = ""
local rem = true

-- S'assurer que PressureTime est défini correctement, sinon définir des valeurs par défaut
local PressureTime = shared.PressureTime or {
    [""] = 15,  -- 0.15 secondes
    [' '] = 30, -- 0.30 secondes
    ['-'] = 60, -- 0.60 secondes
    ['|'] = 240 -- 2.40 secondes
}

-- Fonction pour obtenir le délai de pression d'une touche
local function getPressureDelay(c)
    local pressure = PressureTime[c]
    
    -- Si PressureTime[c] est défini, le retourner, sinon utiliser le délai global
    if pressure then
        return pressure / 100  -- Convertir en secondes
    else
        return delay  -- Utiliser la valeur de delay si non défini
    end
end

-- Boucle pour simuler la frappe de texte
for i = 1, #str do
    if shared.stop == true then return end

    local c = str:sub(i, i)
    
    -- Gestion des crochets et du texte entre eux
    if c == "[" then
        rem = false
        continue
    elseif c == "]" then
        rem = true
        if string.find(queue, " ") then
            for ii = 1, #queue do
                local cc = queue:sub(ii, ii)
                pcall(function()
                    doshift(cc)
                    vim:SendKeyEvent(true, string.byte(cc:lower()), false, nil)
                    wait(getPressureDelay(cc))  -- Attendre la durée de pression
                    vim:SendKeyEvent(false, string.byte(cc:lower()), false, nil)
                    endshift()
                end)
            end
        else
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
        wait(getPressureDelay(' '))  -- Ajuster le délai pour l'espace
        continue
    elseif c == "|" or c == "-" then
        wait(getPressureDelay(c))  -- Ajuster le délai pour '|' ou '-'
        continue
    end
    
    -- Si ce n'est pas un caractère spécial, l'ajouter à la file d'attente
    if not rem then
        queue = queue .. c
        continue
    end

    -- Simuler la frappe pour chaque caractère
    pcall(function()
        doshift(c)
        vim:SendKeyEvent(true, string.byte(c:lower()), false, nil)
        wait(getPressureDelay(c))  -- Attendre le délai de pression pour cette touche
        vim:SendKeyEvent(false, string.byte(c:lower()), false, nil)
        endshift()
    end)
    
    wait()  -- Pas d'attente supplémentaire, le délai est déjà appliqué
end
