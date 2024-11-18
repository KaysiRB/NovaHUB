local vim = game:GetService("VirtualInputManager")

-- Function to simulate holding a key
local function holdKey(key, holdDuration)
    -- Get the key code for the key (lowercase version to avoid case sensitivity)
    local keyCode = string.byte(key:lower())

    -- Check if the keyCode is valid (ASCII printable characters 32 to 126)
    if not keyCode or keyCode < 32 or keyCode > 126 then
        warn("Invalid key: " .. key)
        return
    end

    -- Simulate pressing the key down (true means key is pressed)
    vim:SendKeyEvent(true, keyCode, false, nil)

    -- Wait for the specified duration (hold time)
    wait(holdDuration)

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
