/*
Sound management functions
*/

; Variables
CLI_TOOL_NIR_CMD := 'd:\Dropbox\soft\cli-tools\nircmd-x64\nircmd.exe'
soundToggle := true

; Sound playback device functions

SetSoundDevice(device) {
    ; global - variable that was previously given a value somewhere outside this function
    global CLI_TOOL_NIR_CMD
    Run(CLI_TOOL_NIR_CMD . ' setdefaultsounddevice ' . device)
    MsgBox(device, , 'T0.3')
    return
}

ToggleSoundDevice(device1, device2) {
    global soundToggle := !soundToggle    ; toggle the variable between true/false
    if soundToggle {
        setSoundDevice(device1)
    } else {
        setSoundDevice(device2)
    }
    return
}
