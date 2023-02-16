/*
Window management (wm) functions
*/

; Window tiling

FullScreen() {
    ; Maximizes window even over taskbar (taskbar is not visible)
    WinRestore('A') ; active window
    WinMove(0, 0, A_ScreenWidth, A_ScreenHeight, 'A')
    return
}

LeftHalf() {
    ; Moves active window to left half of the screen
    WinMove(0, 0, (A_ScreenWidth/2), A_ScreenHeight, 'A')
    return
}

RightHalf() {
    ; Moves active window to right half of the screen
    WinMove((A_ScreenWidth/2), 0, (A_ScreenWidth/2), A_ScreenHeight, 'A')
    return
}

MaximizeActiveWindow() {
    ; Maximizes windows but keeps taksbar visible
    WinMaximize('A') ; A stands for active window
    return
}

; Window switching

NextWindow() {
    ; Switch to next window by sending Alt-Esc
    Send('!{Esc}')
    return
}

PreviousWindow() {
    ; Switch to previous window by sending Alt-Shift-Esc
    Send('!+{Esc}')
    return
}

TaskbarToggle(action) {
    ; Show or hide the taskbar. Allows other windows to become truly fullscreen.
    ; ref: https://www.autohotkey.com/boards/viewtopic.php?t=60866

    ; static ABM_SETSTATE := 0xA, ABS_AUTOHIDE := 0x1, ABS_ALWAYSONTOP := 0x2
    ; VarSetCapacity(APPBARDATA, size := 2*A_PtrSize + 2*4 + 16 + A_PtrSize, 0)
    ; NumPut(size, APPBARDATA), NumPut(WinExist('ahk_class Shell_TrayWnd'), APPBARDATA, A_PtrSize)
    ; NumPut(action ? ABS_AUTOHIDE : ABS_ALWAYSONTOP, APPBARDATA, size - A_PtrSize)
    ; DllCall('Shell32\SHAppBarMessage', UInt, ABM_SETSTATE, Ptr, &APPBARDATA)
}
