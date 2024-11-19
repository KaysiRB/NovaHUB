shared.stop = true
wait(1)
shared.stop = false

shared.nospacedelay = shared.nospacedelay or false

local str = shared.scr or "qw[er]ty"
local FinishTime = shared.ftime or 10

local vim = game:GetService("VirtualInputManager")

local nstr = string.gsub(str, "[[\]\n]", "")

local delay = shared.tempo and (6 / shared.tempo) or shared.delay or FinishTime / (string.len(nstr) / 1.05)

print("Finishing in", math.floor((delay * #nstr) / 60), "minute/s", tostring(tonumber(tostring((delay * #nstr) / 60):sub(3, 8)) * 60):sub(1, 2), "second/s")

local shifting = false

local function doshift(key)
    if key:upper() ~= key then return end
    if tonumber(key) then return end
    
    vim:SendKeyEvent(true, 304, false, nil)  -- Shift key press
    shifting = true
end

local function endshift()
    if not shifting then return end

    vim:SendKeyEvent(false, 304, false, nil)  -- Shift key release
    shifting = false
end

local queue = ""
local rem = true

-- Use PressureTime from shared or set defaults
local PressureTime = shared.PressureTime or {
    [""] = 15,   -- 0.15 seconds
    [' '] = 30,  -- 0.30 seconds
    ['-'] = 60,  -- 0.60 seconds
    ['|'] = 240  -- 2.40 seconds
}

-- Helper function to get the delay from PressureTime or fall back to default delay
local function getPressureDelay(c)
    return PressureTime[c] and PressureTime[c] / 100 or delay
end

for i = 1, #str do
    if shared.stop == true then 
        print("Stopping script due to shared.stop being true.")
        return  -- Exit the loop when stop is true
    end

    local c = str:sub(i, i)
    
    if c == "[" then
        rem = false
        continue
    elseif c == "]" then
        rem = true
        for ii = 1, #queue do
            local cc = queue:sub(ii, ii)
            pcall(function()
                doshift(cc)
                vim:SendKeyEvent(true, string.byte(cc:lower()), false, nil)
                wait(getPressureDelay(cc))
                vim:SendKeyEvent(false, string.byte(cc:lower()), false, nil)
                endshift()
            end)
        end
        queue = ""
        continue
    elseif c == " " or string.byte(c) == 10 then
        if shared.nospacedelay then continue end
        wait(getPressureDelay(' '))
        continue
    elseif c == "|" or c == "-" then
        wait(getPressureDelay(c))
        continue
    end
    
    if not rem then
        queue = queue .. c
        continue
    end

    pcall(function()
        doshift(c)
        vim:SendKeyEvent(true, string.byte(c:lower()), false, nil)
        wait(getPressureDelay(c))
        vim:SendKeyEvent(false, string.byte(c:lower()), false, nil)
        endshift()
    end)
end
