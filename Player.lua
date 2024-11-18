local vim = game:GetService("VirtualInputManager")

-- Special mapping for characters that might not be handled well by string.byte()
local specialKeyMappings = {
    [' '] = 32,  -- Space
    ['\n'] = 13, -- Enter
    ['|'] = 124, -- Pipe (|)
    ['-'] = 45,  -- Hyphen
}

-- Function to get the key code from a character
local function getKeyCode(key)
    -- Check if it's a special character and return the mapped key code
    if specialKeyMappings[key] then
        return specialKeyMappings[key]
    end

    -- For regular characters, use string.byte() and ensure it's a valid ASCII value
    local keyCode = string.byte(key:lower())
    if keyCode and keyCode >= 32 and keyCode <= 126 then
        return keyCode
    else
        -- If invalid, print a warning and return nil
        warn("Invalid key: " .. key)
        return nil
    end
end

-- Function to simulate holding a key
local function holdKey(key, holdDuration)
    local keyCode = getKeyCode(key)
    
    if not keyCode then return end  -- If invalid key code, stop the function

    -- Simulate pressing the key down (true means key is pressed)
    vim:SendKeyEvent(true, keyCode, false, nil)

    -- Hold the key for the specified duration by repeatedly sending the key press
    local holdTime = tick() + holdDuration
    while tick() < holdTime do
        wait(0.1)  -- Small delay between "hold" cycles
    end

    -- Simulate releasing the key (false means key is released)
    vim:SendKeyEvent(false, keyCode, false, nil)
end

-- PressureTime dictionary (times in milliseconds)
local PressureTime = shared.PressureTime or {
    [""] = 15,   -- 0.15 seconds
    [' '] = 30,  -- 0.30 seconds
    ['-'] = 60,  -- 0.60 seconds
    ['|'] = 240  -- 2.40 seconds
}

-- Main script to simulate key presses
local str = shared.scr or "qw[er]ty"  -- The string with the notes to press
local delay = 0.1  -- Default delay (in seconds) between key presses

for i = 1, #str do
    local c = str:sub(i, i)

    -- Get the hold duration from the PressureTime dictionary (in milliseconds)
    local holdDuration = PressureTime[c] and PressureTime[c] / 100 or delay

    -- Call holdKey function to simulate pressing and holding the key
    holdKey(c, holdDuration)

    -- Wait before the next key press
    wait(delay)
end
