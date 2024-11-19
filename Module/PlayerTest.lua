shared.stop = true
wait(1)
shared.stop = false

shared.nospacedelay = shared.nospacedelay or false

local str = shared.scr or "qw[er]ty"
local FinishTime = shared.ftime or 10

local vim = game:GetService("VirtualInputManager")

local nstr = string.gsub(str, "[[\]\n]", "")
local delay = shared.tempo and (6 / shared.tempo) or shared.delay or FinishTime / (string.len(nstr) / 1.05)

local shifting = false

-- Use PressureTime from shared or set defaults
local PressureTime = shared.PressureTime or {
    [""] = 15,   -- 0.15 seconds
    [' '] = 30,  -- 0.30 seconds
    ['-'] = 60,  -- 0.60 seconds
    ['|'] = 240  -- 2.40 seconds
}

-- Get delay for a specific character
local function getPressureDelay(c)
    return PressureTime[c] and PressureTime[c] / 100 or delay
end

-- Press and release a key
local function pressKey(key, pressDelay)
    vim:SendKeyEvent(true, string.byte(key), false, nil) -- Key down
    wait(pressDelay or 0.01) -- Small press time
    vim:SendKeyEvent(false, string.byte(key), false, nil) -- Key up
end

-- Handle shift key
local function handleShift(key)
    if key:upper() == key and not tonumber(key) then
        vim:SendKeyEvent(true, 304, false, nil) -- Shift down
        return true
    end
    return false
end

for i = 1, #str do
    if shared.stop then
        print("Stopping script.")
        return
    end

    local char = str:sub(i, i)

    if char == "[" then
        -- Collect sequence inside brackets
        local sequence = str:sub(i + 1, str:find("]", i) - 1)
        for j = 1, #sequence do
            local seqChar = sequence:sub(j, j)
            pressKey(seqChar, getPressureDelay(seqChar))
        end
        i = str:find("]", i) -- Skip to end of sequence
    elseif char == " " then
        if not shared.nospacedelay then wait(getPressureDelay(' ')) end
    elseif char == "|" or char == "-" then
        wait(getPressureDelay(char))
    else
        -- Handle single characters
        local shiftNeeded = handleShift(char)
        pressKey(char:lower(), getPressureDelay(char))
        if shiftNeeded then
            vim:SendKeyEvent(false, 304, false, nil) -- Shift up
        end
    end
end
