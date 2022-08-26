local fn = require("functions") -- Import functions module
require "hyper"
-- require "utils" -- debug and development utilites

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
-- Programming keys in any keyboard layout
hs.hotkey.bind({ "alt" }, 18, fn.printText("!")) -- 1 Ą
hs.hotkey.bind({ "alt" }, 19, fn.printText("@")) -- 2 Č
hs.hotkey.bind({ "alt" }, 20, fn.printText("#")) -- 3 Ę
hs.hotkey.bind({ "alt" }, 21, fn.printText("$")) -- 4 Ė
hs.hotkey.bind({ "alt" }, 23, fn.printText("%")) -- 5 Į
hs.hotkey.bind({ "alt" }, 22, fn.printText("^")) -- 6 Š
hs.hotkey.bind({ "alt" }, 26, fn.printText("&")) -- 7 Ų
hs.hotkey.bind({ "alt" }, 28, fn.printText("*")) -- 8 Ū
hs.hotkey.bind({ "alt" }, 24, fn.printText("=")) -- =+ Ž
-- Numbers in any keyboard layout
hs.hotkey.bind(ctrl_opt, 18, fn.printText("1")) -- 1 Ą
hs.hotkey.bind(ctrl_opt, 19, fn.printText("2")) -- 2 Č
hs.hotkey.bind(ctrl_opt, 20, fn.printText("3")) -- 3 Ę
hs.hotkey.bind(ctrl_opt, 21, fn.printText("4")) -- 4 Ė
hs.hotkey.bind(ctrl_opt, 23, fn.printText("5")) -- 5 Į
hs.hotkey.bind(ctrl_opt, 22, fn.printText("6")) -- 6 Š
hs.hotkey.bind(ctrl_opt, 26, fn.printText("7")) -- 7 Ų
hs.hotkey.bind(ctrl_opt, 28, fn.printText("8")) -- 8 Ū
hs.hotkey.bind(ctrl_opt, 25, fn.printText("9")) -- 9
hs.hotkey.bind(ctrl_opt, 29, fn.printText("0")) -- 0

-- Quick open applications, files and paths
Hyper:bind({}, "V", nil, fn.open("Google Chrome"))
Hyper:bind({}, "B", nil, fn.open("MongoDB Compass"))
Hyper:bind({}, "G", nil, fn.exec("open 'https://gmail.com'"))
Hyper:bind({}, "L", nil, fn.exec("open 'https://calendar.google.com'"))
hs.hotkey.bind(mash, "V", fn.open("Google Chrome")) -- [ ⌃ + ⌥ + ⌘ + C ]
Hyper:bind({}, "T", nil, fn.open("Terminal"))
hs.hotkey.bind(mash, "T", fn.open("Terminal")) -- [ ⌃ + ⌥ + ⌘ + T ]
hs.hotkey.bind("ctrl", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌃ + ⎋ Escape (Esc) ]
hs.hotkey.bind("alt", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌥ + ⎋ Escape (Esc) ]
hs.hotkey.bind(ctrl_opt, "Z", fn.open("Terminal")) -- [ ⌃ + ⌥ + Z ]
Hyper:bind({}, "C", nil, fn.open("Visual Studio Code"))
hs.hotkey.bind(mash, "C", fn.open("Visual Studio Code")) -- [ ⌃ + ⌥ + ⌘ + V ]
hs.hotkey.bind(mash, "F", fn.open("Finder")) -- Finder (recent files) [ ⌃ + ⌥ + ⌘ + F ]
Hyper:bind({}, "A", fn.open("Marta"))
hs.hotkey.bind(mash, "E", fn.exec("open ~/Downloads")) -- Downloads folder [ ⌃ + ⌥ + ⌘ + E ]
hs.hotkey.bind(shift_mash, "F5", fn.exec("open ~/Dropbox/DropsyncFiles/audiob/notes_PC.md")) -- notes_PC [ ⌃ + ⌥ + ⇧ + ⌘ + F5 ]
Hyper:bind({}, "S", nil, fn.open("Slack"))

-- Window management
-- feature spectacle/another window sizing apps
hs.hotkey.bind(mash, 'pad4', fn.baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(mash, 'pad6', fn.baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind(mash, 'pad2', fn.baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(mash, 'pad8', fn.baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(mash, 'pad7', fn.baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind(mash, 'pad9', fn.baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind(mash, 'pad1', fn.baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind(mash, 'pad3', fn.baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind(mash, 'pad5', hs.grid.maximizeWindow)
hs.hotkey.bind(mash, 'padenter', function()
    hs.window:setFullScreen(true)
end)
-- Other
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
