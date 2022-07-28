local fn = require("functions") -- Import functions module

hs.alert.show("Config loaded")

---------------------------- Keyboard shortcuts --------------------------------

-- HammerSpoon settings
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "R", fn.reloadHs()) -- Reload HS config #2
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "Y", function() hs.reload() end) -- Reload HS config #1
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "W", fn.sayHello)
-- Text manipulation
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "D", fn.getDate)

-- Quick open applications and paths
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "T", fn.open("Terminal"))
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "E", function() hs.execute("open ~") end) -- Home folder
hs.hotkey.bind({ "alt" }, "W", fn.open("Finder"))
hs.hotkey.bind({ "alt" }, "C", fn.open("Google Chrome"))
hs.hotkey.bind({ "alt" }, "T", fn.open("Terminal"))
hs.hotkey.bind({ "alt" }, "X", fn.open("Xcode"))
hs.hotkey.bind({ "alt" }, "V", fn.open("Visual Studio Code"))

-- System control (windows management, sound)
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "F11", fn.volumeDown())
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "F12", fn.volumeUp())
hs.hotkey.bind({ "cmd", "alt", "ctrl" }, "H", fn.moveLeft())

