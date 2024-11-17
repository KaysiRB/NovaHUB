-- Module d'autoplay pour piano
local shared = {}

-- Variables globales et paramètres de configuration
shared.stop = false
shared.scr = ""  -- Partition musicale
shared.ftime = 0  -- Temps de lecture total
shared.delay = nil  -- Délai entre les notes
shared.tempo = nil  -- Tempo (vitesse)

-- Durée des touches dans la partition
local noteDurations = {
    [""] = 0.15,    -- Durée par défaut
    [' '] = 0.30,   -- Pauses
    ['-'] = 0.60,   -- Croche
    ['|'] = 2.40    -- Pause longue
}

-- Fonction pour obtenir la durée de pression d'une note
local function getDuration(char)
    return noteDurations[char] or 0.15  -- Retourne la durée associée ou la valeur par défaut
end

-- Fonction pour envoyer la pression d'une touche (simule l'appui)
local function pressKey(key)
    -- Implémentation de la fonction qui envoie un événement de pression de touche
    vim:SendKeyEvent(true, string.byte(key), false, nil)
end

-- Fonction pour relâcher une touche (simule la relâche)
local function releaseKey(key)
    -- Implémentation de la fonction qui envoie un événement de relâche de touche
    vim:SendKeyEvent(false, string.byte(key), false, nil)
end

-- Fonction de gestion de la partition musicale
local function playMusic()
    for i = 1, #shared.scr do
        if shared.stop then
            return  -- Si l'arrêt est activé, on termine
        end
        
        local c = shared.scr:sub(i, i)  -- Chaque caractère de la partition
        if c == "[" then
            -- Gère les groupes de notes (crochets)
            local group = ""
            while shared.scr:sub(i, i) ~= "]" and i <= #shared.scr do
                group = group .. shared.scr:sub(i, i)
                i = i + 1
            end
            -- Traite chaque note dans le groupe
            for j = 1, #group do
                local note = group:sub(j, j)
                pressKey(note)
                wait(getDuration(note))  -- Attente pour respecter la durée de chaque note
                releaseKey(note)
            end
        else
            -- Gère les autres notes
            pressKey(c)
            wait(getDuration(c))  -- Attente pour respecter la durée de chaque note
            releaseKey(c)
        end
    end
end

-- Fonction pour gérer l'arrêt du piano
local function stopMusic()
    shared.stop = true  -- Arrête la lecture
    shared.scr = ""  -- Réinitialise la partition
end

-- Fonction pour démarrer l'autoplay
local function startAutoPlay()
    shared.stop = false  -- L'autoplay commence
    playMusic()  -- Lancer la lecture de la partition
end

-- Fonction pour gérer les entrées et commandes dans l'UI
local function handleUICommands()
    -- Assurez-vous que le module `GUI.lua` fournit ces fonctions pour arrêter et démarrer le piano
    game:GetService("UserInputService").InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.LeftAlt then
            Library:ToggleUI()  -- Basculer l'interface utilisateur
        end
    end)
end

-- Fonction pour démarrer l'interface utilisateur
local function startUI()
    local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
    local Window = Library.CreateLib("Auto Play Piano V1 - Made By NovaOT (Beta Version)", "BloodTheme")

    -- Création des tabs et boutons pour l'interface utilisateur
    local Tab = Window:NewTab("Auto Piano")
    local Section = Tab:NewSection("Auto Piano")

    -- Bouton pour jouer "AOT"
    Section:NewButton("AOT", "Autoplayf", function()
        -- Charger et démarrer l'autoplay
        shared.scr = [[ 6 | p s [quf] | [wy] - [ak] [sl]
        [eud] | [0oh] a [qtp] | [wy] - [dz] -
        [euoh] | [0tp] a [qof] | [wy] - [ak] [sl]
        [eod] - s | [0oah] d [qt] s | [0r] - [pj] [dz]
        [eu] [sl] | 6 - 6-e 0 6 - 6-[epj] f
        [qtyf] | f-k-[wry] | j-l-[eu] | j f
        [qwtf] | f-k-[wty] | l-f-[eu] | i - [uj] f
        [qtif] | f-[ak]-[wyo] | [sl]-[oh]-[eu] | y - [uoh] f-[oh]-
        [qe] | [wt] - [dz] l-[dz]-[eu] | [fl]-j |
        [eua] - [quip] | [9sh] - [8af] | {ghjhjf} -
        [Epd] | {flkjflkjflkjflkj} [eos] - {zhzlkl}-h-z-j-l-h-k-f-
        [9rp] a [0ps] [dz] f - j - [wpd] - [Qaf] k l z -
        [0p]-[ed]-[ys]-a-[0p]-[ed]-[rs]-a-[0p]-[ed]-[ts]-a-[0p]-[ed]-[ts]-a-
        [0p]-[ed]-[ts]-a-[ep]-[rd]-[0s]-[ta]-p-[yd]-[ts]-a-p-[ed]-[rs]-a-[0p]-[ed]-[ts] |
        f [dz] [4djz] [8sl] [qsl] [8h] [4sfl] 8 [wak] [8sl]
        6 0 e 0 e 0 [6f] [0dz] [4dfz] [8sl] [qoh] [8f] [4dhz] 8 [wf] [8sl]
        6 0 e 0 e 0 [6f] [0dz] [4dz] [8sl] [qsl] [8h] [4h] 8 [wdz] [8sl]
        6 0 e 0 r 0 [tpj] [0sl] [4dz] 8 [qdz] [8sl] [4dz] [8f] [wdz] [8dz]
        6 [0sl] e 0 6 l k f-j-4 8 q 8 5 [9l] [wk] [9f]-[sl]-
        6 0 e 0 e [0l] [6k] [0f]-j-4 8 q [8j]-k-5 9 w [9z]-l-
        6 0 e 0 e [0l] [6k] [0f]-j-4 8 q 8 5 [9l] [wk] [9f]-[sl]-
        6 0 e 0 r [0l] [tk] [0l]-z-4 8 q [8fx]-[fx]-5 9 w [9l]-k-
        6-p-[0d]-s-[ea]-p-[0d]-s-[ea]-p-[0d]-s [ep] [0a]-s-6 ]]  -- Ajoutez ici la partition réelle
        startAutoPlay()  -- Démarrer l'autoplay avec la partition définie
    end)

    -- Bouton pour arrêter le piano
    Section:NewButton("Stop piano", "Auto", function()
        stopMusic()  -- Arrêter la lecture du piano
    end)

    -- Keybind pour afficher/masquer l'interface
    Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.LeftAlt, function()
        Library:ToggleUI()
    end)

    -- Section de réglage de la vitesse
    local TabSpeed = Window:NewTab("Speed")
    local SectionSpeed = TabSpeed:NewSection("Speed")
    SectionSpeed:NewSlider("Speed", "SliderInfo", 500, 0, function(s)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s  -- Modifier la vitesse de marche
    end)
end

-- Lancer l'interface utilisateur
startUI()

-- Gérer les commandes d'entrée utilisateur pour l'UI
handleUICommands()
