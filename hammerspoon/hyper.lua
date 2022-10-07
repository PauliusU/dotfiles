-- REF: https://www.kumariyer.com/post/hyper-key/

-- A global variable for the Hyper Mode. Previously "keyModal"
Hyper = hs.hotkey.modal.new({}, nil)

-- Enter Hyper Mode when F18 (Hyper/Capslock) is pressed
Hyper.pressed = function()
    Hyper:enter()
end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed
Hyper.released = function()
    Hyper:exit()
end

-- Bind the Hyper key
hs.hotkey.bind({}, "F18", Hyper.pressed, Hyper.released)