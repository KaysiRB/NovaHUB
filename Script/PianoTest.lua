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
    [eud] | [0oh] a [qtp] | [wy] - [dz] - ]]
    
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
