-- @module Hammerspoon window management functions

local windowManagement = {}
local frameCache = {}

-- Toggle fullscreen of a window
function windowManagement.toggleFullscreen()
    return function()
        local window = hs.window.frontmostWindow()
        window:setFullscreen(not window:isFullscreen())
    end
end

-- Maximize active window (a.k.a. maximize layout)
function windowManagement.maximizeWindow()
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
function windowManagement.minimizeWindow()
    return function()
        local window = hs.window.focusedWindow()
        window:minimize()

        local windowName = window:application():name()
        hs.alert.show(windowName .. " minimized")
    end
end

-- Toggle a window between its normal size, and being maximized
function windowManagement.toggleMax()
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
function windowManagement.hideAllWindows()
    return function()
        hs.osascript.applescriptFromFile("./AppleScripts/hideWindows.applescript")
        hs.osascript.applescript([[display dialog "Minimized"]])
    end
end

--[[ function factory that takes the multipliers of screen width
and height to produce the window's x pos, y pos, width, and height ]]
function windowManagement.baseMove(x, y, w, h)
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
function windowManagement.moveLeft()
    return function()
        local window = hs.window.focusedWindow()
        local f = window:frame()

        f.x = f.x - 10
        window:setFrame(f)
    end
end

-- Close focused window (and kill application if it is the last window of app) ]]
function windowManagement.closeWindow()
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
function windowManagement.prevMonitor()
    return function()
        local window = hs.window.focusedWindow()
        local nextScreen = window:screen():previous()
        window:moveToScreen(nextScreen, false, false, 0)
    end
end

-- Move active windows to next monitor (not previous space)
function windowManagement.nextMonitor()
    return function()
        local window = hs.window.focusedWindow()
        local nextScreen = window:screen():next()
        window:moveToScreen(nextScreen, false, false, 0)
    end
end

-- Move active window to next display
-- Ref: https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
function windowManagement.moveToNextDisplay()
    return function()
        -- get the focused window
        local win = hs.window.focusedWindow()
        -- get the screen where the focused window is displayed, a.k.a. current screen
        local screen = win:screen()
        -- compute the unitRect of the focused window relative to the current screen
        -- and move the window to the next screen setting the same unitRect
        win:move(win:frame():toUnitRect(screen:frame()), screen:next(), true, 0)
    end
end

-- Move active window to display by it's number
-- Ref: https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
function windowManagement.moveWindowToDisplay(d)
    return function()
        -- allScreens lists the displays in the same order as they are defined by the system
        local displays = hs.screen.allScreens()
        local win = hs.window.focusedWindow()
        win:moveToScreen(displays[d], false, true, 0)
    end
end

return windowManagement
