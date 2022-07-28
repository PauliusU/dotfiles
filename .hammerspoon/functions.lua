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

-- Get date in YYYY-MM-DD format
function functions.getDate()
    local dateString = os.date('%Y-%m-%d')
    hs.eventtap.keyStrokes(dateString)
end

---------------------- Quick open applications and paths -----------------------

-- Open program
-- A closure function (will not work without it)
function functions.open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
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

---------------- System settings (window management, sound ---------------------

-- Change volume (both increase and decrease sound level)
-- @param difference number from -100 to 100
function functions.volumeChange(difference)
    return function()
        local output = hs.audiodevice.defaultOutputDevice()
        local newSoundLevel = output:volume() + difference
        output:setVolume(newSoundLevel)
        hs.alert.closeAll() -- Closes all alerts currently open on the screen
        
        -- Display alert with new and rounded sound level
        local roundedLevel = math.floor(output:volume() / 10 + 0.5) * 10
        hs.alert.show("Volume: " .. roundedLevel)
    end
end

-- Move active window left
function functions.moveLeft()
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()

        f.x = f.x - 10
        win:setFrame(f)
    end
end

return functions
