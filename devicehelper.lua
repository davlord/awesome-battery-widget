local math = math
local devicehelper = {}

local function time_to_string(seconds)
    local minutes = math.floor(seconds / 60 % 60)
    local hours = math.floor(seconds / 60 / 60)

    return string.format("%02d:%02d", hours, minutes)
end

function devicehelper.get_time_to_empty_string(device)
    return time_to_string(device.time_to_empty)
end

function devicehelper.get_time_to_full_string(device)
    return time_to_string(device.time_to_full)
end

function devicehelper.get_percentage_string(device)
    local percentage = math.floor(device.percentage)
    return string.format("%s%%", percentage)
end

return devicehelper