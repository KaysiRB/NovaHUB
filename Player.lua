local vim = game:GetService("VirtualInputManager")

-- Function to simulate holding a key
local function holdKey(key, holdDuration)
    local keyCode = string.byte(key:lower())

    -- Ensure the keyCode is valid (check for a valid ASCII character)
    if not keyCode or keyCode < 32 or keyCode > 126 then
        warn("Invalid key: " .. key)
        return
    end

    -- Press the key down (True means key is pressed)
    vim:SendKeyEvent(true, keyCode, false, nil)

    -- Wait for the specified duration (hold time)
    wait(holdDuration)

    -- Release the key (False means key is released)
    vim:SendKeyEvent(false, keyCode, false, nil)
end

-- Your PressureTime dictionary (times in milliseconds)
local PressureTime = shared.PressureTime or {
    [""] = 15,  -- 0.15 seconds
    [' '] = 30, -- 0.30 seconds
    ['-'] = 60, -- 0.60 seconds
    ['|'] = 240 -- 2.40 seconds
}

-- Main script for key press simulation
local str = shared.scr or "qw[er]ty"
local delay = 0.1 -- Default delay (in seconds) between key presses

for i = 1, #str do
    local c = str:sub(i, i)

    -- Determine how long to hold the key (based on PressureTime or default delay)
    local holdDuration = PressureTime[c] and PressureTime[c] / 100 or delay

    -- Simulate pressing and holding the key
    holdKey(c, holdDuration)

    -- Wait before simulating the next key press (if desired)
    wait(delay)
end
