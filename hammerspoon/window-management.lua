-- @module Hammerspoon window management functions

local windowManagement      = {}
local frameCache            = {}

-- Don't animate window changes... That's too slow
hs.window.animationDuration = 0

-- To easily layout windows on the screen, we use hs.grid to create
-- a 4x4 grid. If you want to use a more detailed grid, simply
-- change its dimension here
local GRID_SIZE             = 4
local HALF_GRID_SIZE        = GRID_SIZE / 2
-- Set the grid size and add a few pixels of margin
hs.grid.setGrid(GRID_SIZE .. 'x' .. GRID_SIZE)
hs.grid.setMargins({ 5, 5 })

local screenPositions            = {}
screenPositions.left             = {
    x = 0,
    y = 0,
    w = HALF_GRID_SIZE,
    h = GRID_SIZE
}
screenPositions.right            = {
    x = HALF_GRID_SIZE,
    y = 0,
    w = HALF_GRID_SIZE,
    h = GRID_SIZE
}
screenPositions.top              = {
    x = 0,
    y = 0,
    w = GRID_SIZE,
    h = HALF_GRID_SIZE
}
screenPositions.bottom           = {
    x = 0,
    y = HALF_GRID_SIZE,
    w = GRID_SIZE,
    h = HALF_GRID_SIZE
}
screenPositions.topLeft          = {
    x = 0,
    y = 0,
    w = HALF_GRID_SIZE,
    h = HALF_GRID_SIZE
}
screenPositions.topRight         = {
    x = HALF_GRID_SIZE,
    y = 0,
    w = HALF_GRID_SIZE,
    h = HALF_GRID_SIZE
}
screenPositions.bottomLeft       = {
    x = 0,
    y = HALF_GRID_SIZE,
    w = HALF_GRID_SIZE,
    h = HALF_GRID_SIZE
}
screenPositions.bottomRight      = {
    x = HALF_GRID_SIZE,
    y = HALF_GRID_SIZE,
    w = HALF_GRID_SIZE,
    h = HALF_GRID_SIZE
}
windowManagement.screenPositions = screenPositions

-- Toggle fullscreen of a window
function windowManagement.toggleFullscreen()
    return function()
        local window = hs.window.frontmostWindow()
        window:setFullscreen(not window:isFullscreen())
    end
end

-- Maximize either specified or focused window (a.k.a. maximize layout) by
-- moving it to the center of the sreen and let it fill up the entire screen.
function windowManagement.maximizeWindow(window)
    return function()
        if window == nil then
            window = hs.window.focusedWindow()
        end
        if window then
            -- ALternative (did the same in my tests)
            -- hs.layout.apply({ { nil, window, window:screen(), hs.layout.maximized, 0, 0 } })
            window:maximize()

            local windowName = window:application():name()
            hs.alert.show(windowName .. " maximized")
        end
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

-- Minimize active window
function windowManagement.minimizeWindow()
    return function()
        local window = hs.window.focusedWindow()
        window:minimize()

        local windowName = window:application():name()
        hs.alert.show(windowName .. " minimized")
    end
end

-- Hide all windows and show desktop
function windowManagement.hideAllWindows()
    return function()
        hs.osascript.applescriptFromFile("./AppleScripts/hideWindows.applescript")
        hs.osascript.applescript([[display dialog "Minimized"]])
    end
end

-- Move either the specified or the focused window to the requested screen
-- position
function windowManagement.moveWindow(cell, window)
    return function()
        if window == nil then
            window = hs.window.focusedWindow()
        end
        if window then
            local screen = window:screen()
            hs.grid.set(window, cell, screen)
        end
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
            window:close();             -- Close current window only
        end

        hs.alert.show(windowName .. " was closed")
    end
end

-- Move active window to display by it's number (not to other space)
-- Move active windows to previous monitor (not previous space)
-- Ref: https://stackoverflow.com/questions/54151343/how-to-move-an-application-between-monitors-in-hammerspoon
function windowManagement.moveWindowToDisplay(displayNo)
    return function()
        local window = hs.window.focusedWindow()
        
        local targetScreen
        if displayNo == nil then
            targetScreen = window:screen():next()
        else
            -- allScreens lists the displays in the same order as they are defined by the system
            local displays = hs.screen.allScreens()
            targetScreen =  displays[displayNo]
        end

        window:moveToScreen(targetScreen, false, false, 0)
    end
end

return windowManagement
