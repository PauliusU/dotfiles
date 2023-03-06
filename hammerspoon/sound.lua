-- @module Hammerspoon sound and media control functions

local sound = {}

-- Change volume (both increase and decrease sound level)
-- @param difference number from -100 to 100
function sound.volumeChange(difference)
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


-- Toggle sound mute
function sound.mute()
    return function()
        hs.eventtap.event.newSystemKeyEvent('MUTE', true):post()
        hs.eventtap.event.newSystemKeyEvent('MUTE', false):post()
    end
end

-- Send play/pause
function sound.togglePlayPause()
    return function()
        hs.eventtap.event.newSystemKeyEvent('PLAY', true):post()
        hs.eventtap.event.newSystemKeyEvent('PLAY', false):post()
    end
end

-- Switch to previous song
function sound.previousSong()
    return function()
        hs.eventtap.event.newSystemKeyEvent('PREVIOUS', true):post()
        hs.eventtap.event.newSystemKeyEvent('PREVIOUS', false):post()
    end
end

-- Switch to next song
function sound.nextSong()
    return function()
        hs.eventtap.event.newSystemKeyEvent('NEXT', true):post()
        hs.eventtap.event.newSystemKeyEvent('NEXT', false):post()
    end
end

-- Decrease volume
function sound.soundDown()
    return function()
        hs.eventtap.event.newSystemKeyEvent('SOUND_DOWN', true):post()
        hs.eventtap.event.newSystemKeyEvent('SOUND_DOWN', false):post()
    end
end

-- Increase volume
function sound.soundUp()
    return function()
        hs.eventtap.event.newSystemKeyEvent('SOUND_UP', true):post()
        hs.eventtap.event.newSystemKeyEvent('SOUND_UP', false):post()
    end
end

return sound
