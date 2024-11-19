local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Piano V1 - By NovaOT (Beta Version)", "Ocean")

local Tab = Window:NewTab("Auto Piano")
local Section = Tab:NewSection("Auto Piano")

local PressureTime = {
    [""] = 15,   -- 0.15 seconds
    [' '] = 30,  -- 0.30 seconds
    ['-'] = 60,  -- 0.60 seconds
    ['|'] = 240  -- 2.40 seconds
}

Section:NewButton("Start AutoPlay", "Start playing the sheet", function()
    shared.stop = true
    shared.ftime = 2 * 60 + 00
    shared.delay = nil
    shared.tempo = nil
    
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
Section:NewButton("Stop Piano", "Stops current playback", function()
    shared.stop = true
    shared.scr = ""
end)

local Tab = Window:NewTab("Pressure Time Settings")
local Section = Tab:NewSection("Adjust Pressure Time")

Section:NewSlider("Space Delay", "Delay for space", 300, 0, function(value)
    PressureTime[' '] = value
end)

Section:NewSlider("Dash Delay", "Delay for dash (-)", 600, 0, function(value)
    PressureTime['-'] = value
end)

Section:NewSlider("Pipe Delay", "Delay for pipe (|)", 2400, 0, function(value)
    PressureTime['|'] = value
end)

Section:NewSlider("Empty Delay", "Delay for empty key", 150, 0, function(value)
    PressureTime[''] = value
end)

local Tab = Window:NewTab("Custom Sheets")
local Section = Tab:NewSection("Create Your Sheet")
Section:NewButton("Work In Progress", "Custom sheet functionality is coming", function() end)
