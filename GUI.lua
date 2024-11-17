local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Auto Play Piano V1 - Made By NovaOT (Beta Version)", "BloodTheme")

local Tab = Window:NewTab("Auto Piano")
local Section = Tab:NewSection("Auto Piano")
Section:NewButton("AOT", "Autoplayf", function()
shared.stop = true -- stops the player at any time if true
-- CONFIG:
shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
shared.delay = nil -- delay overides the ftime
shared.tempo = nil -- tempo overides the delay

shared.scr = [[ [6s] 0 [ts] e [us] t [of] u [4j] 8 [ej] q [tj] e [yh] u
[8f] w [uf] t [of] u [tf] w [5a] 9 [ra] w [ya] r [wp] 0

[6e] s [es] p [us] p [es] d [4f] 8 [qs] s [qo] f q
[8t] w t w t [ws] [ts] [ws] [5a] 9 w [ra] [wa] [rp] [ws] u
[6t] s [es] p [us] p [es] d [4f] u [qs] s [qoh] f q
[8t] t t s [tus] d [5w] [wy] [wy] f f f
[6us] 0 [ts] e [us] t [of] u [4sj] 8 [ej] q [tj] [ef] [fh] f
[8of] w [uf] t [of] u [tf] w [5oa] 9 [ra] w [ya] [rf] [wf] [rf]
[6us] 0 t e [ud] [td] [od] f [4d] [8s] [es] q t [ef] [yf] f
[8of] w u t o [us] s [ts] [5oa] [9a] [ra] [ws] u t e w
f f f [6f] u [ps] e 6 p e s [4qp] o q q
s [ish] [osh] [f8] u o u 8 [us] [8oh] [uh] [of] 5 d 5
5 [of] [of] [of] [6f] u [ps] e 6 [es] [us] [ep] [4g] q u q 4 q u
h [8sf] h [osf] [8h] [osf] h [8of] d g 5 9 w p g w [of] w

[6us] 0 [ts] e [us] [tf] [sfl] [adk] [4sj] 8 [ej] [qp]
[tj] f [th] d [8of] w [uf] t [oh] [ug] [tf] d [5oa] 9 r [wo]
[oag] r [wof] d [6us] 0 [ts] e [us] [tf] [sfl] [adk] [4sj] 8 [ej] [qp]
[tj] [ef] [yh] d [8of] w [uf] t [oh] [ug] [tf] d [5od] 9 r [wo]
[oag] r [wof] d 6 0 e t o ]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/AutoPlayPianoScript/main/NewAutoPlayPiano"))()
end)

local Tab = Window:NewTab("Stop Piano")
local Section = Tab:NewSection("Stop Piano")
Section:NewButton("Stop piano", "Auto", function()  
 -- Sheet for Rondo Alla Turca by Wolfgang Amadeus Mozart

shared.stop = true -- stops the player at any time if true
-- CONFIG:
shared.ftime = 2*60 + 00 -- time in seconds for the song to finish (extended by |)
shared.delay = nil -- delay overides the ftime
shared.tempo = nil -- tempo overides the delay

shared.scr = [[ e ]]

loadstring(game:HttpGet("https://raw.githubusercontent.com/JxcExploit/AutoPlayPianoScript/main/NewAutoPlayPiano"))()

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
local Section = Tab:NewSection("Create your own Auto Play")
Section:NewButton("WIP!", "Auto", function()
    -- À personnaliser si nécessaire
end)
