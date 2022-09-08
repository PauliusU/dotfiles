local fn = require("functions") -- Import functions module
require "hyper"
require "private" -- not commited to Git
-- require "utils" -- debug and development utilites (disabled by default)

hs.hid.capslock.set(false) -- Disable capslock

--------------------------------------------------------------------------------
-- Reload config on write
--------------------------------------------------------------------------------
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
Hyper:bind({}, "H", nil, fn.getDate())
Hyper:bind({}, "J", nil, fn.getDate())
hs.hotkey.bind(mash, "D", fn.getDate()) -- [ ⌃ + ⌥ + ⌘ + D ]
-- VIM like arrow keys
hs.hotkey.bind(mash, "I", fn.press({}, "up")) -- ↑
hs.hotkey.bind(mash, "K", fn.press({}, "down")) -- ↓
hs.hotkey.bind(mash, "J", fn.press({}, "left")) -- ← ◀
hs.hotkey.bind(mash, "L", fn.press({}, "right")) -- →
-- NON VIM like shortcuts
hs.hotkey.bind(mash, "U", fn.press({ "alt" }, "left")) -- left one word
hs.hotkey.bind(mash, "O", fn.press({ "alt" }, "right")) -- one word right
hs.hotkey.bind(mash, "H", fn.press({}, "home")) -- start of the line
hs.hotkey.bind(mash, ";", fn.press({}, "end")) -- end of the line
-- Programming keys in any keyboard layout
hs.hotkey.bind({ "alt", "shift" }, 18, fn.printText("!")) -- 1 Ą
hs.hotkey.bind({ "alt", "shift" }, 19, fn.printText("@")) -- 2 Č
hs.hotkey.bind({ "alt", "shift" }, 20, fn.printText("#")) -- 3 Ę
hs.hotkey.bind({ "alt", "shift" }, 21, fn.printText("$")) -- 4 Ė
hs.hotkey.bind({ "alt", "shift" }, 23, fn.printText("%")) -- 5 Į
hs.hotkey.bind({ "alt", "shift" }, 22, fn.printText("^")) -- 6 Š
hs.hotkey.bind({ "alt", "shift" }, 26, fn.printText("&")) -- 7 Ų
hs.hotkey.bind({ "alt", "shift" }, 28, fn.printText("*")) -- 8 Ū
hs.hotkey.bind({ "alt", "shift" }, 24, fn.printText("=")) -- =+ Ž
-- Numbers in any keyboard layou
hs.hotkey.bind({"alt"}, 18, fn.printText("1")) -- 1 Ą
hs.hotkey.bind({"alt"}, 19, fn.printText("2")) -- 2 Č
hs.hotkey.bind({"alt"}, 20, fn.printText("3")) -- 3 Ę
hs.hotkey.bind({"alt"}, 21, fn.printText("4")) -- 4 Ė
hs.hotkey.bind({"alt"}, 23, fn.printText("5")) -- 5 Į
hs.hotkey.bind({"alt"}, 22, fn.printText("6")) -- 6 Š
hs.hotkey.bind({"alt"}, 26, fn.printText("7")) -- 7 Ų
hs.hotkey.bind({"alt"}, 28, fn.printText("8")) -- 8 Ū
hs.hotkey.bind({"alt"}, 25, fn.printText("9")) -- 9
hs.hotkey.bind({"alt"}, 29, fn.printText("0")) -- 0

-- Quick open applications, files and paths
Hyper:bind({}, "Z", nil, fn.open("Google Chrome"))
Hyper:bind({}, "G", nil, fn.exec("open 'https://gmail.com'"))
Hyper:bind({}, "L", nil, fn.exec("open 'https://calendar.google.com'"))
Hyper:bind({"Shift"}, "L", nil, fn.open("Calendar"))
hs.hotkey.bind(mash, "V", fn.open("Google Chrome")) -- [ ⌃ + ⌥ + ⌘ + C ]
hs.hotkey.bind("ctrl", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌃ + ⎋ Escape (Esc) ]
hs.hotkey.bind("alt", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌥ + ⎋ Escape (Esc) ]
Hyper:bind({}, "A", nil, fn.open("Terminal"))
Hyper:bind({}, "T", nil, fn.open("Terminal"))
hs.hotkey.bind(mash, "T", fn.open("Terminal")) -- [ ⌃ + ⌥ + ⌘ + T ]
hs.hotkey.bind(ctrl_opt, "Z", fn.open("Terminal")) -- [ ⌃ + ⌥ + Z ]
Hyper:bind({}, "S", fn.open("Marta"))
Hyper:bind({}, "D", fn.open("EasyFind"))
Hyper:bind({}, "Q", nil, fn.open("Visual Studio Code"))
hs.hotkey.bind(mash, "C", fn.open("Visual Studio Code")) -- [ ⌃ + ⌥ + ⌘ + V ]
Hyper:bind({}, "O", nil, fn.exec("code ~/Dropbox/code/dotfiles-macOs"))
Hyper:bind({}, "B", nil, fn.open("MongoDB Compass"))
Hyper:bind({}, "P", nil, fn.open("MPV"))
Hyper:bind("Shift", "P", nil, fn.open("Spotify"))
Hyper:bind({}, "E", fn.open("Finder"))
hs.hotkey.bind(mash, "F", fn.open("Finder")) -- Finder (recent files) [ ⌃ + ⌥ + ⌘ + F ]
hs.hotkey.bind(mash, "E", fn.exec("open ~/Downloads")) -- Downloads folder [ ⌃ + ⌥ + ⌘ + E ]
hs.hotkey.bind(shift_mash, "F5", fn.exec("open ~/Dropbox/DropsyncFiles/audiob/notes_PC.md")) -- notes_PC [ ⌃ + ⌥ + ⇧ + ⌘ + F5 ]
Hyper:bind({}, "N", nil, fn.exec("open ~/Dropbox/DropsyncFiles/audiob/notes_PC.md"))
Hyper:bind({}, "K", nil, fn.open("Ferdi"))
Hyper:bind("Shift", "K", nil, fn.open("Slack"))
Hyper:bind({}, "I", nil, fn.open("Preview"))

-- Window management
-- -- Seature spectacle/another window sizing apps
hs.hotkey.bind(mash, "pad4", fn.baseMove(0, 0, 0.5, 1))
hs.hotkey.bind(mash, "pad6", fn.baseMove(0.5, 0, 0.5, 1))
hs.hotkey.bind(mash, "pad2", fn.baseMove(0, 0.5, 1, 0.5))
hs.hotkey.bind(mash, "pad8", fn.baseMove(0, 0, 1, 0.5))
hs.hotkey.bind(mash, "pad7", fn.baseMove(0, 0, 0.5, 0.5))
hs.hotkey.bind(mash, "pad9", fn.baseMove(0.5, 0, 0.5, 0.5))
hs.hotkey.bind(mash, "pad1", fn.baseMove(0, 0.5, 0.5, 0.5))
hs.hotkey.bind(mash, "pad3", fn.baseMove(0.5, 0.5, 0.5, 0.5))
hs.hotkey.bind(mash, "pad5", hs.grid.maximizeWindow)
hs.hotkey.bind(mash, "padenter", function()
    hs.window:setFullScreen(true)
end)
-- -- Other window management options
Hyper:bind({}, "up", nil, fn.maximizeWindow())
Hyper:bind({}, "down", nil, fn.minimizeWindow())
Hyper:bind({}, "right", nil, fn.baseMove(0.5, 0, 0.5, 1))
Hyper:bind({}, "left", nil, fn.baseMove(0, 0, 0.5, 1))
Hyper:bind({}, "return", nil, fn.toggleMax()) -- [ Hyper + ↩ ]
hs.hotkey.bind(mash, "up", fn.maximizeWindow()) -- [ ⌃ + ⌥ + ⌘ + Up ]
Hyper:bind({}, "F", nil, fn.toggleFullscreen()) -- [ Hyper + F ]
hs.hotkey.bind("alt", "F4", fn.closeWindow()) -- [ ⌥ + F4 ]
Hyper:bind({}, "M", nil, fn.hideAllWindows()) -- [ Hyper + M ]
hs.hotkey.bind(mash, "M", fn.hideAllWindows()) -- [ ⌃ + ⌥ + ⌘ + H ]
hs.hotkey.bind(mash, "G", fn.moveLeft()) -- [ ⌃ + ⌥ + ⌘ + J ]
Hyper:bind({ "cmd" }, "left", fn.prevMonitor()) -- [Hyper + ⌘ + ◀ ]
Hyper:bind({ "cmd" }, "right", fn.nextMonitor()) -- [Hyper + ⌘ + ▶ ]

-- System control (sound, keyboar layout)
hs.hotkey.bind(shift_mash, "R", fn.restartOSWindow()) -- [ ⌃ + ⌥ + ⌘ + ⇧ + R ]
Hyper:bind({ "shift" }, "R", nil, fn.restartOSWindow())
hs.hotkey.bind("ctrl", "space", fn.toggleLayout()) -- Overrides system layout chooser [ ⌃ + Space ]
hs.hotkey.bind(opt_cmd, "up", fn.volumeChange(10)) -- Increase volume [ ⌥ + ⌘ + ↑ ]
hs.hotkey.bind(opt_cmd, "down", fn.volumeChange(-10)) -- Decrease volume [ ⌥ + ⌘ + ↓ ]

--  Mac keyboard
hs.hotkey.bind(mash, "F11", fn.volumeChange(-10)) -- Decrease volume [ ⌃ + ⌥ + ⌘ + F11 ]
hs.hotkey.bind(mash, "F12", fn.volumeChange(10)) -- Increase volume [ ⌃ + ⌥ + ⌘ + F12 ]
