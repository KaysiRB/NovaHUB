local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Play Piano V8 - Made By JxcExploits (Last Version)", "BloodTheme")

local Tab = Window:NewTab("Auto Piano")
local Section = Tab:NewSection("Auto Piano")

Section:NewButton("AOT", "Autoplayf", function()
    -- Sheet for Rondo Alla Turca by Wolfgang Amadeus Mozart
    shared.stop = true -- stops the player at any time if true
    -- CONFIG:
    shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
    shared.delay = nil -- delay overides the ftime
    shared.tempo = nil -- tempo overides the delay
    
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
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/main/Player.lua"))()
end)

local Tab = Window:NewTab("Stop Piano")
local Section = Tab:NewSection("Stop Piano")
Section:NewButton("Stop piano", "Auto", function()  
    shared.stop = true -- stops the player at any time if true
    -- CONFIG:
    shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
    shared.delay = nil -- delay overides the ftime
    shared.tempo = nil -- tempo overides the delay
    shared.scr = [[ e ]]
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/main/Player.lua"))()
end)

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.RightControl, function()
    Library:ToggleUI()
end)

local Tab = Window:NewTab("Speed")
local Section = Tab:NewSection("Speed")
Section:NewSlider("Speed", "SliderInfo", 500, 0, function(s) -- 500 (MaxValue) | 0 (MinValue)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

local Tab = Window:NewTab("Custom Sheets")
local Section = Tab:NewSection("Click It If you want to make your own Auto Play")
Section:NewButton("WIP!", "Auto", function()  
    
end)
