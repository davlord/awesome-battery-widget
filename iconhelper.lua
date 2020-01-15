local lgi = require 'lgi'

local icon_theme = lgi.Gtk.IconTheme.get_default()
local IconLookupFlags = lgi.Gtk.IconLookupFlags

local BATTERY_EMPTY = 5
local BATTERY_CAUTION = 20
local BATTERY_LOW = 40
local BATTERY_GOOD = 60
local BATTERY_FULL = 80

local iconhelper = {}

local function lookup_icon(name)
    return icon_theme:lookup_icon(name, 64, {IconLookupFlags.GENERIC_FALLBACK})
end

local icon = {
    unknown = lookup_icon("battery-missing-symbolic"),
    battery_empty = lookup_icon("battery-empty-symbolic"),
    battery_empty_charging = lookup_icon("battery-empty-charging-symbolic"),
    battery_caution = lookup_icon("battery-caution-symbolic"),
    battery_caution_charging = lookup_icon("battery-caution-charging-symbolic"),
    battery_low = lookup_icon("battery-low-symbolic"),
    battery_low_charging = lookup_icon("battery-low-charging-symbolic"),
    battery_good = lookup_icon("battery-good-symbolic"),
    battery_good_charging = lookup_icon("battery-good-charging-symbolic"),
    battery_full = lookup_icon("battery-full-symbolic"),
    battery_full_charging = lookup_icon("battery-full-charging-symbolic"),
}

function iconhelper.get_power_icon(on_battery, device)

    local battery_level = device.percentage
    
    if battery_level <= BATTERY_EMPTY then
        if on_battery == false then return icon.battery_empty_charging else return icon.battery_empty end
    elseif battery_level <= BATTERY_CAUTION then
        if on_battery == false then return icon.battery_caution_charging else return icon.battery_caution end
    elseif battery_level <= BATTERY_LOW then
        if on_battery == false then return icon.battery_low_charging else return icon.battery_low end
    elseif battery_level <= BATTERY_GOOD then
        if on_battery == false then return icon.battery_good_charging else return icon.battery_good end
    elseif battery_level <= BATTERY_FULL then
        if on_battery == false then return icon.battery_full_charging else return icon.battery_full end
    end

end

return iconhelper