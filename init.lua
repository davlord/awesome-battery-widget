local setmetatable = setmetatable
local lgi = require 'lgi'
local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local iconhelper = require("awesome-battery-widget.iconhelper")
local devicehelper = require("awesome-battery-widget.devicehelper")

local UPowerGlib = lgi.UPowerGlib

local battery_widget = { mt = {} }

local upower = nil

function battery_widget:update_icon(on_battery, device)
    local icon = iconhelper.get_power_icon(on_battery, device)
    self.imageboxcontainer.imagebox:set_image(icon:load_surface())
end

function battery_widget:update_text(on_battery, device)
    local percentage_text = math.floor(device.percentage)
    self.textbox:set_text(string.format("%d%%", device.percentage))
end

function battery_widget:update_tooltip(on_battery, device)
    local time_text = ""
    if on_battery == true then time_text = "empty in "..devicehelper.get_time_to_empty_string(device) end
    if on_battery == false then time_text = "full in "..devicehelper.get_time_to_full_string(device) end
    self.tooltip:set_text(string.format("%s", time_text))
end

function battery_widget:update(device)
    local on_battery = upower:get_on_battery()
    self:update_icon(on_battery, device)
    self:update_text(on_battery, device)
    self:update_tooltip(on_battery, device)
end

local function new(args)
    local w = wibox.widget {
        layout = wibox.layout.fixed.horizontal,
        spacing = 2,
        {
            top    = 4,
            bottom = 4,
            layout = wibox.container.margin,
            id = "imageboxcontainer",
            {
                id = "imagebox",
                widget = wibox.widget.imagebox,
                resize = true,
            },
        },
        {
            id = "textbox",
            widget = wibox.widget.textbox,
        }        
    }

    w.tooltip = awful.tooltip({ objects = { w },})

    upower = UPowerGlib.Client()

    gears.table.crush(w, battery_widget, true)

    local device = upower:get_display_device()
    device.on_notify = function() w:update(device) end
    upower.on_notify = function() w:update(device) end

    w:update(device)

    return w
end

function battery_widget.mt:__call(...)
    return new(...)
end

return setmetatable(battery_widget, battery_widget.mt)