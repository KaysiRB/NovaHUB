local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Piano V1 - By NovaOT (Beta Version)", "Ocean")

local Tab = Window:NewTab("Auto Piano")
local Section = Tab:NewSection("Auto Piano")

-- Define PressureTime initially
local PressureTime = {
    [""] = 15,  -- 0.15 seconds
    [' '] = 30, -- 0.30 seconds
    ['-'] = 60, -- 0.60 seconds
    ['|'] = 240 -- 2.40 seconds
}

Section:NewButton("AOT", "Autoplayf", function()
    -- Set up necessary parameters for Player.lua
    shared.stop = true -- stops the player at any time if true
    shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
    shared.delay = nil -- delay overrides the ftime
    shared.tempo = nil -- tempo overrides the delay
    
    -- Pass PressureTime to Player.lua
    shared.PressureTime = PressureTime
    
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
    6-p-[0d]-s-[ea]-p-[0d]-s-[ea]-p-[0d]-s [ep] [0a]-s-6 ]]
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/BASE/Module/Player.lua"))()
end)

local Tab = Window:NewTab("Stop Piano")
local Section = Tab:NewSection("Stop Piano")
Section:NewButton("Stop piano", "Auto", function()  
    shared.stop = true -- stops the player at any time if true
    shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
    shared.delay = nil -- delay overrides the ftime
    shared.scr = [[ e ]]
    
    -- Load Player.lua to stop
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/BASE/Module/Player.lua"))()
end)

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.LeftAlt, function()
    Library:ToggleUI()
end)

local Tab = Window:NewTab("Speed")
local Section = Tab:NewSection("Speed")
Section:NewSlider("Speed", "SliderInfo", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

local Tab = Window:NewTab("Custom Sheets")
local Section = Tab:NewSection("Click It If you want to make your own Auto Play")
local CustomSheet = ""

Section:NewTextBox("Piano Sheet", "Paste your custom piano sheet here", function(input)
    CustomSheet = input -- Save user input into the CustomSheet variable
end)

-- Play button to execute the custom sheet
Section:NewButton("Play", "Play your custom sheet", function()
    if CustomSheet == "" then
        print("No sheet music provided!")
        return
    end
    
    -- Pass the custom sheet to shared variables
    shared.stop = true -- Stops any ongoing music
    shared.scr = CustomSheet -- Assign the custom sheet to the shared.scr variable
    shared.ftime = 2 * 60 + 00 -- Set a default finish time for the music
    shared.delay = nil -- Optional: custom delay
    shared.tempo = nil -- Optional: custom tempo
    
    -- Execute Player.lua to play the custom sheet
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/BASE/Module/Player.lua"))()
end)

-- New tab to adjust Pressure Time settings
local Tab = Window:NewTab("Pressure Time Settings")
local Section = Tab:NewSection("Adjust Pressure Time")

-- Sliders to adjust Pressure Time for special characters
Section:NewSlider("Space Delay", "Adjust delay for space (default: 0.30s)", 300, 0, function(s)
    PressureTime[' '] = s -- Adjust the space delay
end)

Section:NewSlider("Dash Delay", "Adjust delay for dash (-) (default: 0.60s)", 600, 0, function(s)
    PressureTime['-'] = s -- Adjust the dash delay
end)

Section:NewSlider("Pipe Delay", "Adjust delay for pipe (|) (default: 2.40s)", 2400, 0, function(s)
    PressureTime['|'] = s -- Adjust the pipe delay
end)

Section:NewSlider("Empty Delay", "Adjust delay for empty key (default: 0.15s)", 150, 0, function(s)
    PressureTime[''] = s -- Adjust the empty key delay
end)
