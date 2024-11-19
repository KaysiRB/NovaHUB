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
    shared.scr = [[ q w [er] t y | [ak] [sl] ]]
    
    loadstring(game:HttpGet("https://raw.githubusercontent.com/KaysiRB/SMTHNG/refs/heads/BASE/Module/Player.lua"))()
end)

local StopTab = Window:NewTab("Stop Piano")
local StopSection = StopTab:NewSection("Stop Piano")
StopSection:NewButton("Stop", "Stop the autoplay", function()
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
