-- @module Hammerspoon functions

local functions = {}

----------------- Hammerspoon utilities (reload configuration) -----------------

-- Reload Hammerspoon configuraion
function functions.reloadHs()
    return function()
        hs.reload()
    end
end

-- Show hello world alert to see if script is running
function functions.sayHello()
    hs.alert.show("Hello World!")
end

---------------------- Text manipulation (date, time, etc) ---------------------

-- Send keystrokes text
function functions.printText(text)
    return function()
        hs.eventtap.keyStrokes(text)
    end
end

-- Send keystroke (imitate printint with keyboard)
function functions.press(modifier, key)
    return function()
        local delayInMicroseconds = 0
        hs.eventtap.keyStroke(modifier, key, delayInMicroseconds)
    end
end

-- Get date in YYYY-MM-DD format
function functions.getDate()
    return function()
        local dateString = os.date("%Y-%m-%d")
        hs.eventtap.keyStrokes(dateString)
    end
end

------------------- Quick open applications, files and paths -------------------

-- Open program
-- A closure function (will not work without it)
function functions.open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == "Finder" then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

-- Excecute shell commands
-- @param command to be executed
function functions.exec(command)
    return function()
        hs.execute(command)
    end
end

-- Open Chrome tab
function functions.openTab()
    return function()
        hs.osascript.applescriptFromFile("./AppleScripts/openNewChromeTab.applescript")
    end
end

----------------- System settings (sound, keyboard layouts) --------------------

-- Show window to restart macOS
function functions.restartOSWindow()
    return function()
        -- terminal alternative: osascript -e 'tell app "loginwindow" to «event aevtrrst»'
        hs.osascript.applescript([[tell app "loginwindow" to «event aevtrrst»]])
        hs.hid.capslock.set(false) -- Disable capslock
    end
end

-- Toggle between LT and US keyboard layouts
function functions.toggleLayout()
    return function()
        if (hs.keycodes.currentLayout() == "U.S.") then
            hs.keycodes.setLayout("Lithuanian")
        else
            hs.keycodes.setLayout("U.S.")
        end

        hs.alert.closeAll() -- Closes all alerts currently open on the screen
        hs.alert.show(hs.keycodes.currentLayout() .. " layout")
    end
end

return functions
