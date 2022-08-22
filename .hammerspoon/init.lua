local fn = require("functions") -- Import functions module

hs.hid.capslock.set(false) -- Disable capslock
hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------
-- modifier keys: https://www.hammerspoon.org/docs/hs.hotkey.html#bind
-- key codes: https://www.hammerspoon.org/docs/hs.keycodes.html#map
-- Unicode Codes for Keyboard symbols https://www.acrobatfaq.com/atbref5/index/KeyboardShortcuts/UnicodeCodesforKeyboards.html%EF%A3%BF%EF%A3%BF%EF%A3%BF%EF%A3%BF%EF%A3%BF%EF%A3%BF%EF%A3%BF%EF%A3%BF%EF%A3%BF
local hyper       = { "ctrl", "alt", "cmd" }
local shift_hyper = { "ctrl", "alt", "cmd", "shift" }
local opt_cmd     = { "alt", "cmd" }

-- HammerSpoon settings
hs.hotkey.bind(hyper, "R", fn.reloadHs()) -- Reload HS config #1 [ ⌃ + ⌥ + ⌘ + R ]
hs.hotkey.bind(hyper, "Y", function() hs.reload() end) -- Reload HS config #2 (inline example) [ ⌃ + ⌥ + ⌘ + Y ]
hs.hotkey.bind(hyper, "W", fn.sayHello) -- [ ⌃ + ⌥ + ⌘ + W ]

-- Text manipulation
hs.hotkey.bind(hyper, "D", fn.getDate) -- [ ⌃ + ⌥ + ⌘ + D ]

-- Quick open applications, files and paths
hs.hotkey.bind(hyper, "C", fn.open("Google Chrome")) -- [ ⌃ + ⌥ + ⌘ + C ]
hs.hotkey.bind(hyper, "T", fn.open("Terminal")) -- [ ⌃ + ⌥ + ⌘ + T ]
hs.hotkey.bind(hyper, "V", fn.open("Visual Studio Code")) -- [ ⌃ + ⌥ + ⌘ + V ]
hs.hotkey.bind(hyper, "F", fn.open("Finder")) -- Finder (recent files) [ ⌃ + ⌥ + ⌘ + F ]
hs.hotkey.bind(hyper, "E", fn.exec("open ~/Downloads")) -- Downloads folder [ ⌃ + ⌥ + ⌘ + E ]
hs.hotkey.bind(shift_hyper, "F5", fn.exec("open ~/Dropbox/DropsyncFiles/audiob/notes_PC.md")) -- notes_PC [ ⌃ + ⌥ + ⇧ + ⌘ + F5 ]
hs.hotkey.bind("alt", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌥ + ⎋ Escape (Esc) ]

-- System control (windows management, sound)
hs.hotkey.bind("ctrl", "space", fn.toggleLayout()) -- Overrides system layout chooser [ ⌃ + Space ]
hs.hotkey.bind(hyper, "up", fn.maximizeWindow()) -- [ ⌃ + ⌥ + ⌘ + Up ]
hs.hotkey.bind(shift_hyper, "R", fn.restartOSWindow()) -- [ ⌃ + ⌥ + ⌘ + ⇧ + R ]
hs.hotkey.bind("alt", "F4", fn.closeWindow()) -- [ ⌥ + F4 ]
hs.hotkey.bind(hyper, "H", fn.hideAllWindows()) -- [ ⌃ + ⌥ + ⌘ + H ]
hs.hotkey.bind(hyper, "J", fn.moveLeft()) -- [ ⌃ + ⌥ + ⌘ + J ]
hs.hotkey.bind(opt_cmd, "up", fn.volumeChange(10)) -- Increase volume [ ⌥ + ⌘ + ↑ ]
hs.hotkey.bind(opt_cmd, "down", fn.volumeChange(-10)) -- Decrease volume [ ⌥ + ⌘ + ↓ ]
--  mac keyboard
hs.hotkey.bind(hyper, "F11", fn.volumeChange(-10)) -- Decrease volume [ ⌃ + ⌥ + ⌘ + F11 ]
hs.hotkey.bind(hyper, "F12", fn.volumeChange(10)) -- Increase volume [ ⌃ + ⌥ + ⌘ + F12 ]
