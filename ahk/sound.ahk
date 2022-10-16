/*
Sound management functions
*/
#NoEnv
#SingleInstance, Force ; Replace the old instance
SendMode, Input
SetBatchLines, -1
SetWorkingDir, %A_ScriptDir%

; Variables
CLI_TOOL_NIR_CMD := "d:\Dropbox\soft\CLI-tools\nircmd-x64\nircmd.exe"
soundToggle := true

; Sound playback device functions

setSoundDevice(device) {
    ; global - variable that was previously given a value somewhere outside this function
    global CLI_TOOL_NIR_CMD
    Run, %CLI_TOOL_NIR_CMD% setdefaultsounddevice "%device%
    MsgBox, , , %device%, 0.3
    return
}

toggleSoundDevice(device1, device2) {
    global soundToggle := !soundToggle ; toggle the variable between true/false
    if soundToggle {
        setSoundDevice(device1)
    } else {
        setSoundDevice(device2)
    }
    return
}
