local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Piano V1 - By NovaOT (Beta Version)", "Ocean")

local Tab = Window:NewTab("Auto Piano")
local Section = Tab:NewSection("Auto Piano")

local PressureTime = {
    [""] = 15,  -- 0.15 seconds
    [' '] = 30, -- 0.30 seconds
    ['-'] = 60, -- 0.60 seconds
    ['|'] = 240 -- 2.40 seconds
}

Section:NewButton("Play Piano", "Start autoplay", function()
    shared.stop = false
    shared.ftime = 120
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
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/BASE/Module/PlayerTest.lua"))()
end)

local StopTab = Window:NewTab("Stop Piano")
local StopSection = StopTab:NewSection("Stop Piano")
StopSection:NewButton("Stop", "Stop the autoplay", function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/BASE/Module/PlayerTest.lua"))()
    shared.stop = true
end)

local AdjustTab = Window:NewTab("Adjust Pressure Time")
local AdjustSection = AdjustTab:NewSection("Adjust Settings")

AdjustSection:NewSlider("Space Delay", "Adjust delay for space", 300, 0, function(val)
    PressureTime[" "] = val
end)

AdjustSection:NewSlider("Dash Delay", "Adjust delay for dash", 600, 0, function(val)
    PressureTime["-"] = val
end)

AdjustSection:NewSlider("Pipe Delay", "Adjust delay for pipe", 2400, 0, function(val)
    PressureTime["|"] = val
end)

AdjustSection:NewSlider("Empty Delay", "Adjust delay for empty", 150, 0, function(val)
    PressureTime[""] = val
end)
