local fn = require("functions") -- Import functions module

hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------

-- HammerSpoon settings
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", fn.reloadHs()) -- Reload HS config #1
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Y", function() hs.reload() end) -- Reload HS config #2 (inline example)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", fn.sayHello)

-- Text manipulation
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "D", fn.getDate)

-- Quick open applications and paths
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "C", fn.open("Google Chrome"))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "T", fn.open("Terminal"))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "V", fn.open("Visual Studio Code"))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", fn.open("Finder"))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "E", fn.exec("open ~")) -- Home folder

-- System control (windows management, sound)
hs.hotkey.bind({ "alt" }, "F4", fn.closeWindow()) -- [ ⌥ + F4 ]
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "H", fn.moveLeft())
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "F11", fn.volumeChange(-10)) -- Decrease volume
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "F12", fn.volumeChange(10)) -- Increase volume
