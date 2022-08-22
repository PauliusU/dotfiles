local fn = require("functions") -- Import functions module

hs.hid.capslock.set(false) -- Disable capslock
hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------

-- HammerSpoon settings
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "R", fn.reloadHs()) -- Reload HS config #1 [ ⌃ + ⌥ + ⌘ + R ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "Y", function() hs.reload() end) -- Reload HS config #2 (inline example) [ ⌃ + ⌥ + ⌘ + Y ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "W", fn.sayHello) -- [ ⌃ + ⌥ + ⌘ + W ]

-- Text manipulation
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "D", fn.getDate) -- [ ⌃ + ⌥ + ⌘ + D ]

hs.hotkey.bind("alt", "escape", fn.openTab()) -- Open Google Chrome tab [ ⌥ + ⎋ Escape (Esc) ]

-- System control (windows management, sound)
hs.hotkey.bind({ "ctrl" }, "space", fn.toggleLayout()) -- Overrides system layout chooser [ ⌃ + Space ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "up", fn.maximizeWindow()) -- [ ⌃ + ⌥ + ⌘ + Up ]
hs.hotkey.bind({ "ctrl", "alt", "cmd", "shift"}, "R", fn.restartOSWindow()) -- [ ⌃ + ⌥ + ⌘ + ⇧ + R ]
hs.hotkey.bind({ "alt" }, "F4", fn.closeWindow()) -- [ ⌥ + F4 ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "H", fn.hideAllWindows()) -- [ ⌃ + ⌥ + ⌘ + H ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "J", fn.moveLeft()) -- [ ⌃ + ⌥ + ⌘ + J ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "F11", fn.volumeChange(-10)) -- Decrease volume [ ⌃ + ⌥ + ⌘ + F11 ]
hs.hotkey.bind({ "ctrl", "alt", "cmd" }, "F12", fn.volumeChange(10)) -- Increase volume [ ⌃ + ⌥ + ⌘ + F12 ]
hs.hotkey.bind({ "alt", "cmd" }, "up", fn.volumeChange(-10)) -- Decrease volume [ ⌥ + ⌘ + ↑ ]
hs.hotkey.bind({ "alt", "cmd" }, "down", fn.volumeChange(10)) -- Increase volume [ ⌥ + ⌘ + ↓ ]
