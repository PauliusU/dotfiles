-- Import modules
local fn = require("functions")
local wm = require("window-management")
local sound = require("sound")
require "hyper" -- Hyper key Setup
require "private" -- Not committed to Git
-- require "utils" -- Debug and development utilities (disabled by default)

-- Startup
hs.hid.capslock.set(false) -- Disable caps lock

-- Reload config on write
hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", fn.reloadHs()):start()
hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------
-- Modifier keys: https://www.hammerspoon.org/docs/hs.hotkey.html#bind
-- Key codes: https://www.hammerspoon.org/docs/hs.keycodes.html#map
-- Unicode Codes for Keyboard symbols https://www.acrobatfaq.com/atbref5/index/KeyboardShortcuts/UnicodeCodesforKeyboards.html
local mash       = { "ctrl", "alt", "cmd" }
local shift_mash = { "ctrl", "alt", "cmd", "shift" }
local opt_cmd    = { "alt", "cmd" }
local ctrl_opt   = { "ctrl", "alt" }

-- HammerSpoon settings
hs.hotkey.bind(mash, "R", fn.reloadHs()) -- Reload HS config #1 [ ⌃ + ⌥ + ⌘ + R ]
Hyper:bind({}, "R", nil, fn.reloadHs())
hs.hotkey.bind(mash, "W", fn.sayHello) -- [ ⌃ + ⌥ + ⌘ + W ]

-- Text and key manipulation
Hyper:bind({}, "J", nil, fn.getDate())
hs.hotkey.bind(mash, "D", fn.getDate()) -- [ ⌃ + ⌥ + ⌘ + G ]
-- VIM like arrow keys
hs.hotkey.bind(mash, "K", fn.press({}, "up")) -- ↑
hs.hotkey.bind(mash, "J", fn.press({}, "down")) -- ↓
hs.hotkey.bind(mash, "H", fn.press({}, "left")) -- ←
hs.hotkey.bind(mash, "L", fn.press({}, "right")) -- →
-- NON VIM like shortcuts
hs.hotkey.bind(mash, "U", fn.press({ "alt" }, "left")) -- left one word
hs.hotkey.bind(mash, "O", fn.press({ "alt" }, "right")) -- one word right
hs.hotkey.bind(mash, "G", fn.press({}, "home")) -- start of the line
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
-- Numbers in any keyboard layout
hs.hotkey.bind({ "alt" }, 18, fn.printText("1")) -- 1 Ą
hs.hotkey.bind({ "alt" }, 19, fn.printText("2")) -- 2 Č
hs.hotkey.bind({ "alt" }, 20, fn.printText("3")) -- 3 Ę
hs.hotkey.bind({ "alt" }, 21, fn.printText("4")) -- 4 Ė
hs.hotkey.bind({ "alt" }, 23, fn.printText("5")) -- 5 Į
hs.hotkey.bind({ "alt" }, 22, fn.printText("6")) -- 6 Š
hs.hotkey.bind({ "alt" }, 26, fn.printText("7")) -- 7 Ų
hs.hotkey.bind({ "alt" }, 28, fn.printText("8")) -- 8 Ū
hs.hotkey.bind({ "alt" }, 25, fn.printText("9")) -- 9
hs.hotkey.bind({ "alt" }, 29, fn.printText("0")) -- 0

-- Quick open applications, files and paths
hs.hotkey.bind("alt", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌥ + ⎋ Escape (Esc) ]
hs.hotkey.bind("ctrl", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌃ + ⎋ Escape (Esc) ]
hs.hotkey.bind(ctrl_opt, "Z", fn.open("Terminal")) -- [ ⌃ + ⌥ + Z ]
hs.hotkey.bind(mash, "E", fn.open("Finder")) -- Finder (recent files) [ ⌃ + ⌥ + ⌘ + F ]
Hyper:bind("Shift", "A", nil, fn.open("alacritty"))
Hyper:bind("Shift", "D", nil, fn.open("Postman"))
Hyper:bind("Shift", "H", nil, fn.open("VLC"))
Hyper:bind("Shift", "I", nil, fn.open("System Settings"))
Hyper:bind("Shift", "J", nil, fn.open("Ghostty"))
Hyper:bind("Shift", "K", nil, fn.open("Ferdium"))
Hyper:bind("Shift", "L", nil, fn.open("Calendar"))
Hyper:bind("Shift", "M", nil, fn.open("mpv"))
Hyper:bind("Shift", "N", nil, fn.open("Obsidian"))
Hyper:bind("Shift", "P", nil, fn.open("Music"))
Hyper:bind("Shift", "S", nil, fn.open("Marta"))
Hyper:bind("Shift", "U", nil, fn.open("Messages"))
Hyper:bind("Shift", "V", nil, fn.open("Safari"))
Hyper:bind("Shift", "X", nil, fn.open("Claude"))
Hyper:bind({}, "A", nil, fn.open("Notion"))
Hyper:bind({}, "B", nil, fn.open("MongoDB Compass"))
Hyper:bind({}, "C", nil, fn.open("DisplayLink Manager"))
Hyper:bind({}, "D", nil, fn.open("Visual Studio Code"))
Hyper:bind({}, "E", fn.exec("open ~/Downloads"))
Hyper:bind({}, "F", nil, fn.open("Google Chrome"))
Hyper:bind({}, "G", nil, fn.exec("open 'https://gmail.com'"))
Hyper:bind({}, "H", nil, fn.open("mpv"))
Hyper:bind({}, "I", nil, fn.open("Preview"))
Hyper:bind({}, "J", nil, fn.open("alacritty"))
Hyper:bind({}, "K", nil, fn.open("Slack"))
Hyper:bind({}, "L", nil, fn.exec("open 'https://calendar.google.com'"))
-- Hyper:bind({}, "M", nil, fn.hideAllWindows()) -- [ Hyper + M ]
Hyper:bind({}, "N", nil, fn.exec("open ~/Dropbox/DropsyncFiles/audiob/notes-pc.md"))
Hyper:bind({}, "O", nil, fn.exec("$HOME/bin/homebrew/bin/code $HOME/code/dotfiles"))
Hyper:bind({}, "P", nil, fn.open("Spotify"))
-- Hyper:bind({}, "R", nil, fn.reloadHs())
Hyper:bind({}, "S", fn.open("Double Commander"))
Hyper:bind({}, "T", nil, fn.open("Toggl Track"))
Hyper:bind({}, "U", fn.open("Kitty"))
Hyper:bind({}, "W", nil, fn.open("Foxit PDF Reader"))
Hyper:bind({}, "X", fn.open("ChatGPT"))
Hyper:bind({}, "V", nil, fn.open("Arc"))
Hyper:bind({}, "Y", nil, fn.open("Anki"))
Hyper:bind({}, "Z", fn.open("EasyFind"))
Hyper:bind({}, "pad7", fn.exec("open ~/Dropbox/DropsyncFiles/audiob/DBs/input.xlsx"))
hs.hotkey.bind(shift_mash, "N", fn.open("Notion"))

-- Window management
hs.hotkey.bind(mash, "pad4", wm.moveWindow(wm.screenPositions.left))
hs.hotkey.bind(mash, "pad6", wm.moveWindow(wm.screenPositions.right))
hs.hotkey.bind(mash, "pad2", wm.moveWindow(wm.screenPositions.bottom))
hs.hotkey.bind(mash, "pad8", wm.moveWindow(wm.screenPositions.top))
hs.hotkey.bind(mash, "pad7", wm.moveWindow(wm.screenPositions.topLeft))
hs.hotkey.bind(mash, "pad9", wm.moveWindow(wm.screenPositions.topRight))
hs.hotkey.bind(mash, "pad1", wm.moveWindow(wm.screenPositions.bottomLeft))
hs.hotkey.bind(mash, "pad3", wm.moveWindow(wm.screenPositions.bottomRight))
hs.hotkey.bind(mash, "pad5", hs.grid.maximizeWindow)
hs.hotkey.bind(mash, "padenter", function()
    hs.window:setFullScreen(true)
end)
-- -- 2 X 2 window grid
hs.hotkey.bind(mash, "left", wm.moveWindow(wm.screenPositions.left))
hs.hotkey.bind(mash, "right", wm.moveWindow(wm.screenPositions.right))
hs.hotkey.bind(mash, "up", wm.moveWindow(wm.screenPositions.top))
hs.hotkey.bind(mash, "down", wm.moveWindow(wm.screenPositions.bottom))

-- -- Other window management options
Hyper:bind({}, "up", nil, wm.maximizeWindow()) -- [Hyper + ▲ ]
Hyper:bind({}, "down", nil, wm.minimizeWindow()) -- [Hyper + ▼ ]
Hyper:bind("Shift", "left", nil, wm.moveWindow(wm.screenPositions.left)) -- [Hyper + ◀ ]
Hyper:bind("Shift", "right", nil, wm.moveWindow(wm.screenPositions.right)) -- [Hyper + ▶ ]
Hyper:bind({}, "Return", nil, wm.toggleMax())
Hyper:bind("Shift", "Return", nil, wm.toggleFullscreen()) -- [ Hyper + F ]
Hyper:bind("Shift", "F", nil, wm.toggleFullscreen()) -- [ Hyper + Shift + F ]
hs.hotkey.bind("alt", "F4", wm.closeWindow()) -- [ ⌥ + F4 ]
Hyper:bind({}, "M", nil, wm.hideAllWindows()) -- [ Hyper + M ]
hs.hotkey.bind(mash, "M", wm.hideAllWindows()) -- [ ⌃ + ⌥ + ⌘ + H ]
-- -- Displays
hs.hotkey.bind(mash, "A", wm.moveWindowToDisplay(2))
hs.hotkey.bind(mash, "S", wm.moveWindowToDisplay(1))
hs.hotkey.bind(mash, "D", wm.moveWindowToDisplay(3))
hs.hotkey.bind(mash, "B", wm.moveWindowToDisplay())

-- System control (sound, keyboard layout)
hs.hotkey.bind(shift_mash, "R", fn.restartOSWindow()) -- [ ⌃ + ⌥ + ⌘ + ⇧ + R ]
Hyper:bind({ "shift" }, "R", nil, fn.restartOSWindow())
hs.hotkey.bind("ctrl", "space", fn.toggleLayout()) -- Overrides system layout chooser [ ⌃ + Space ]
hs.hotkey.bind(opt_cmd, "up", sound.volumeChange(10)) -- Increase volume [ ⌥ + ⌘ + ↑ ]
hs.hotkey.bind(opt_cmd, "down", sound.volumeChange( -10)) -- Decrease volume [ ⌥ + ⌘ + ↓ ]

--  Mac keyboard
hs.hotkey.bind(mash, "F7", sound.previousSong())
hs.hotkey.bind(mash, "F8", sound.togglePlayPause())
hs.hotkey.bind(mash, "F9", sound.nextSong())
hs.hotkey.bind(mash, "F10", sound.mute())
hs.hotkey.bind(mash, "F11", sound.soundDown()) -- Decrease volume [ ⌃ + ⌥ + ⌘ + F11 ]
hs.hotkey.bind(mash, "F12", sound.soundUp()) -- Increase volume [ ⌃ + ⌥ + ⌘ + F12 ]
