local fn = require("functions") -- Import functions module
require "hyper"

hs.hid.capslock.set(false) -- Disable capslock

-----------------------------------------------
-- Reload config on write
-----------------------------------------------
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", fn.reloadHs()):start()
hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------
-- modifier keys: https://www.hammerspoon.org/docs/hs.hotkey.html#bind
-- key codes: https://www.hammerspoon.org/docs/hs.keycodes.html#map
-- Unicode Codes for Keyboard symbols https://www.acrobatfaq.com/atbref5/index/KeyboardShortcuts/UnicodeCodesforKeyboards.html
local mash       = { "ctrl", "alt", "cmd" }
local shift_mash = { "ctrl", "alt", "cmd", "shift" }
local opt_cmd    = { "alt", "cmd" }
local ctrl_opt   = { "ctrl", "alt" }

-- HammerSpoon settings
hs.hotkey.bind(mash, "R", fn.reloadHs()) -- Reload HS config #1 [ ⌃ + ⌥ + ⌘ + R ]
Hyper:bind({}, "R", nil, fn.reloadHs())
hs.hotkey.bind(mash, "Y", function() hs.reload() end) -- Reload HS config #2 (inline example) [ ⌃ + ⌥ + ⌘ + Y ]
hs.hotkey.bind(mash, "W", fn.sayHello) -- [ ⌃ + ⌥ + ⌘ + W ]

-- Text and key manipulation
Hyper:bind({}, "J", nil, fn.getDate)
hs.hotkey.bind(mash, "D", fn.getDate) -- [ ⌃ + ⌥ + ⌘ + D ]
-- VIM like arrow keys
hs.hotkey.bind(mash, "I", fn.press({}, "up")) -- ↑
hs.hotkey.bind(mash, "K", fn.press({}, "down")) -- ↓
hs.hotkey.bind(mash, "J", fn.press({}, "left")) -- ←
hs.hotkey.bind(mash, "L", fn.press({}, "right")) -- →
-- NON VIM like shortcuts
hs.hotkey.bind(mash, "U", fn.press({ "alt" }, "left")) -- left one word
hs.hotkey.bind(mash, "O", fn.press({ "alt" }, "end")) -- one word right
hs.hotkey.bind(mash, "H", fn.press({}, "home")) -- start of the line
hs.hotkey.bind(mash, ";", fn.press({}, "end")) -- end of the line

-- Quick open applications, files and paths
Hyper:bind({}, "V", nil, fn.open("Google Chrome"))
hs.hotkey.bind(mash, "V", fn.open("Google Chrome")) -- [ ⌃ + ⌥ + ⌘ + C ]
Hyper:bind({}, "T", nil, fn.open("Terminal"))
hs.hotkey.bind(mash, "T", fn.open("Terminal")) -- [ ⌃ + ⌥ + ⌘ + T ]
hs.hotkey.bind("alt", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌥ + ⎋ Escape (Esc) ]
hs.hotkey.bind(ctrl_opt, "Z", fn.open("Terminal")) -- [ ⌃ + ⌥ + Z ]
Hyper:bind({}, "C", nil, fn.open("Visual Studio Code"))
hs.hotkey.bind(mash, "C", fn.open("Visual Studio Code")) -- [ ⌃ + ⌥ + ⌘ + V ]
hs.hotkey.bind(mash, "F", fn.open("Finder")) -- Finder (recent files) [ ⌃ + ⌥ + ⌘ + F ]
Hyper:bind({}, "L", nil, fn.open("Marta"))
hs.hotkey.bind(mash, "E", fn.exec("open ~/Downloads")) -- Downloads folder [ ⌃ + ⌥ + ⌘ + E ]
hs.hotkey.bind(shift_mash, "F5", fn.exec("open ~/Dropbox/DropsyncFiles/audiob/notes_PC.md")) -- notes_PC [ ⌃ + ⌥ + ⇧ + ⌘ + F5 ]
Hyper:bind({}, "S", nil, fn.open("Slack"))

-- Window management
Hyper:bind({}, "return", nil, fn.maximizeWindow()) -- [ Hyper + ↩ ]
hs.hotkey.bind(mash, "up", fn.maximizeWindow()) -- [ ⌃ + ⌥ + ⌘ + Up ]
Hyper:bind({}, "F", nil, fn.toggleFullscreen()) -- [ Hyper + F ]
hs.hotkey.bind("alt", "F4", fn.closeWindow()) -- [ ⌥ + F4 ]
hs.hotkey.bind(mash, "M", fn.hideAllWindows()) -- [ ⌃ + ⌥ + ⌘ + H ]
hs.hotkey.bind(mash, "G", fn.moveLeft()) -- [ ⌃ + ⌥ + ⌘ + J ]
Hyper:bind({ "cmd" }, "left", fn.prevMonitor())
Hyper:bind({ "cmd" }, "right", fn.nextMonitor())

-- System control (sound, keyboar layout)
hs.hotkey.bind(shift_mash, "R", fn.restartOSWindow()) -- [ ⌃ + ⌥ + ⌘ + ⇧ + R ]
Hyper:bind({ "shift" }, "R", nil, fn.restartOSWindow())
hs.hotkey.bind("ctrl", "space", fn.toggleLayout()) -- Overrides system layout chooser [ ⌃ + Space ]
hs.hotkey.bind(opt_cmd, "up", fn.volumeChange(10)) -- Increase volume [ ⌥ + ⌘ + ↑ ]
hs.hotkey.bind(opt_cmd, "down", fn.volumeChange(-10)) -- Decrease volume [ ⌥ + ⌘ + ↓ ]

--  mac keyboard
hs.hotkey.bind(mash, "F11", fn.volumeChange(-10)) -- Decrease volume [ ⌃ + ⌥ + ⌘ + F11 ]
hs.hotkey.bind(mash, "F12", fn.volumeChange(10)) -- Increase volume [ ⌃ + ⌥ + ⌘ + F12 ]
