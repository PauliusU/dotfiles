-- HammerSpoon development utilities

-- Print keyCode of pressed button
local events = hs.eventtap.event.types
KeyboardTracker = hs.eventtap.new({ events.keyDown }, function(e)
    local keyCode = e:getKeyCode()
    hs.alert.show(keyCode)
end)
KeyboardTracker:start()


-- Mouse scroll watcher
ScrollWather = hs.eventtap.new({ hs.eventtap.event.types.scrollWheel }, function(event)
    if event:getFlags():containExactly({ "ctrl" }) then
        hs.alert.show("Ctrl only scroll")
    end

    if event:getFlags():containExactly({ "ctrl", "cmd" }) then
        hs.alert.show("Ctrl + Cmd scroll")
    end
end):start()


-- Test keybinding to be falled
Hyper:bind({}, "D", nil, function()
    
end)
