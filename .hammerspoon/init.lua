local fn = require("functions") -- Import functions module

hs.hid.capslock.set(false) -- Disable capslock
hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------

-- HammerSpoon settings
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", fn.reloadHs()) -- Reload HS config #1 [ ⌃ + ⌥ + ⌘ + R ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Y", function() hs.reload() end) -- Reload HS config #2 (inline example) [ ⌃ + ⌥ + ⌘ + Y ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", fn.sayHello) -- [ ⌃ + ⌥ + ⌘ + W ]

-- Text manipulation
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "D", fn.getDate) -- [ ⌃ + ⌥ + ⌘ + D ]

-- Quick open applications and paths
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "C", fn.open("Google Chrome")) -- [ ⌃ + ⌥ + ⌘ + C ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "T", fn.open("Terminal")) -- [ ⌃ + ⌥ + ⌘ + T ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "V", fn.open("Visual Studio Code")) -- [ ⌃ + ⌥ + ⌘ + V ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "F", fn.open("Finder")) -- [ ⌃ + ⌥ + ⌘ + F ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "E", fn.exec("open ~")) -- Home folder [ ⌃ + ⌥ + ⌘ + E ]

-- System control (windows management, sound)
hs.hotkey.bind({ "ctrl" }, "space", fn.toggleLayout()) -- Overrides system layout chooser [ ⌃ + Space ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "up", fn.maximizeWindow()) -- [ ⌃ + ⌥ + ⌘ + Up ]
hs.hotkey.bind({ "cmd", "alt", "ctrl", "shift"}, "R", fn.restartOSWindow()) -- [ ⌃ + ⌥ + ⌘ + ⇧ + R ]
hs.hotkey.bind({ "alt" }, "F4", fn.closeWindow()) -- [ ⌥ + F4 ]
hs.hotkey.bind({ "alt", "cmd" }, "up", fn.volumeChange(-10)) -- Decrease volume [ ⌥ + ⌘ + ↑ ]
hs.hotkey.bind({ "alt", "cmd" }, "down", fn.volumeChange(10)) -- Increase volume [ ⌥ + ⌘ + ↓ ]
