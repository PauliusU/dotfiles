-- @module Hammerspoon functions

local functions = {}
local frameCache = {}

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

-------- System settings (window management, spaces and monitors) --------------

-- Toggle fullscreen of a window
function functions.toggleFullscreen()
    return function()
        local window = hs.window.frontmostWindow()
        window:setFullscreen(not window:isFullscreen())
    end
end

-- Maximize active window (a.k.a. maximize layout)
function functions.maximizeWindow()
    return function()
        local window = hs.window.focusedWindow()
        -- ALternative (did the same in my tests)
        -- hs.layout.apply({ { nil, window, window:screen(), hs.layout.maximized, 0, 0 } })
        window:maximize()

        local windowName = window:application():name()
        hs.alert.show(windowName .. " maximized")
    end
end

-- Minimize active window
function functions.minimizeWindow()
    return function()
        local window = hs.window.focusedWindow()
        window:minimize()

        local windowName = window:application():name()
        hs.alert.show(windowName .. " minimized")
    end
end

-- Toggle a window between its normal size, and being maximized
function functions.toggleMax()
    return function()
        local window = hs.window.focusedWindow()
        if frameCache[window:id()] then
            window:setFrame(frameCache[window:id()])
            frameCache[window:id()] = nil
        else
            frameCache[window:id()] = window:frame()
            window:maximize()
        end
    end
end

-- Hide all windows and show desktop
function functions.hideAllWindows()
    return function()
        hs.osascript.applescriptFromFile("./AppleScripts/hideWindows.applescript")
        hs.osascript.applescript([[display dialog "Minimized"]])
    end
end

--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function functions.baseMove(x, y, w, h)
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()

        -- add max.x so it stays on the same screen, works with my second screen
        f.x = max.w * x + max.x
        f.y = max.h * y
        f.w = max.w * w
        f.h = max.h * h
        win:setFrame(f, 0)
    end
end

-- Move active window left
function functions.moveLeft()
    return function()
        local window = hs.window.focusedWindow()
        local f = window:frame()

        f.x = f.x - 10
        window:setFrame(f)
    end
end

-- Close focused window (and kill application if it is the last window of app) ]]
function functions.closeWindow()
    return function()
        local window = hs.window.focusedWindow()
        local windowName = window:application():name()
        local allWindows = window:application():allWindows()
        local numOfWindows = #allWindows

        if (numOfWindows == 1) then
            window:application():kill() -- Close whole application
        else
            window:close(); -- Close current window only
        end

        hs.alert.show(windowName .. " was closed")
    end
end

-- Move active windows to previous monitor (not previous space)
function functions.prevMonitor()
    return function()
        local window = hs.window.focusedWindow()
        local nextScreen = window:screen():previous()
        window:moveToScreen(nextScreen)
    end
end

-- Move active windows to next monitor (not previous space)
function functions.nextMonitor()
    return function()
        local window = hs.window.focusedWindow()
        hs.alert.show(window:screen())
        local nextScreen = window:screen():next()
        window:moveToScreen(nextScreen)
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

-- Change volume (both increase and decrease sound level)
-- @param difference number from -100 to 100
function functions.volumeChange(difference)
    return function()
        local output = hs.audiodevice.defaultOutputDevice()
        local newSoundLevel = output:volume() + difference
        output:setVolume(newSoundLevel) -- Set sound level

        -- Display alert with new and rounded sound level
        hs.alert.closeAll() -- Closes all alerts currently open on the screen
        local roundedLevel = math.floor(output:volume() / 10 + 0.5) * 10
        -- hs.alert.show("Volume " .. new .. "%", {}, 0.5)
        hs.alert.show("Volume: " .. roundedLevel .. "%")
    end
end

return functions