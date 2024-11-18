local vim = game:GetService("VirtualInputManager")

-- Function to simulate holding down a key
local function holdKey(key, holdDuration)
    -- Press the key
    vim:SendKeyEvent(true, string.byte(key:lower()), false, nil)

    -- Wait for the specified hold duration
    wait(holdDuration)

    -- Release the key
    vim:SendKeyEvent(false, string.byte(key:lower()), false, nil)
end

-- Example of how you would use the function in your script:
local PressureTime = shared.PressureTime or {
    [""] = 15,  -- 0.15 seconds
    [' '] = 30, -- 0.30 seconds
    ['-'] = 60, -- 0.60 seconds
    ['|'] = 240 -- 2.40 seconds
}

local str = shared.scr or "qw[er]ty"
local delay = 0.1 -- Default delay (in seconds)

for i = 1, #str do
    local c = str:sub(i, i)

    -- Check if the character has a specified pressure time
    local holdDuration = PressureTime[c] and PressureTime[c] / 100 or delay

    -- Simulate holding the key down for the specified duration
    holdKey(c, holdDuration)
    
    -- Wait before moving to the next key
    wait(delay)
end
