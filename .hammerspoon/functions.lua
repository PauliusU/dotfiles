local functions = {}

----------------- Hammerspoon utilities (reload configuration) -----------------

function functions.reloadHs()
    return function()
        hs.reload()
    end
end

function functions.sayHello()
    hs.alert.show("Hello World!")
end

---------------------- Text manipulation (date, time, etc) ---------------------

function functions.getDate()
    local dateString = os.date('%Y-%m-%d')
    hs.eventtap.keyStrokes(dateString)
end

---------------------- Quick open applications and paths -----------------------

-- A closure function (will not work without it)
function functions.open(name)
    return function()
        hs.application.launchOrFocus(name)
        if name == 'Finder' then
            hs.appfinder.appFromName(name):activate()
        end
    end
end

---------------- System settings (window management, sound ---------------------
function functions.volumeDown()
    return function()
        hs.alert.show("Volume -10")
        local output = hs.audiodevice.defaultOutputDevice()
        output:setVolume(output:volume() - 10)
    end
end

function functions.volumeUp()
    return function()
        hs.alert.show("Volume +10")
        local output = hs.audiodevice.defaultOutputDevice()
        output:setVolume(output:volume() + 10)
    end
end

function functions.moveLeft()
    return function()
        local win = hs.window.focusedWindow()
        local f = win:frame()

        f.x = f.x - 10
        win:setFrame(f)
    end
end

return functions
