#NoTrayIcon
#Requires AutoHotkey v2.0
ListLines False
ProcessSetPriority "High"
SetNumLockState "On"
DetectHiddenWindows True

global HiddenWindowsStack := []
global LastSuspendedPID := 0

^#h:: {
    if (HiddenWindowsStack.Length > 0) {
        lastHwnd := HiddenWindowsStack.Pop()
        if WinExist("ahk_id " lastHwnd) {
            WinShow("ahk_id " lastHwnd)
            WinActivate("ahk_id " lastHwnd)
        }
    } 
    else {
        activeHwnd := WinExist("A")
        if !activeHwnd
            return
            
        processName := WinGetProcessName("ahk_id " activeHwnd)
        if (StrLower(processName) != "brave.exe")
            return
            
        WinHide("ahk_id " activeHwnd)
        HiddenWindowsStack.Push(activeHwnd)
    }
}

^enter:: RunAsAdminFast()

^+k:: {
    PurgeGui := Gui("+AlwaysOnTop -MinimizeBox -MaximizeBox", "Performance Purge")
    PurgeGui.Add("Text", "w280", "Are you sure you want to terminate all unnecessary apps?")
    BraveCheck := PurgeGui.Add("Checkbox", "vCloseBrave y+10", "Include Brave Browser")
    BtnYes := PurgeGui.Add("Button", "w80 x50 y+15", "Yes")
    BtnNo := PurgeGui.Add("Button", "w80 x+20", "No")
    BtnYes.OnEvent("Click", (*) => ProcessPurge(PurgeGui, BraveCheck.Value))
    BtnNo.OnEvent("Click", (*) => PurgeGui.Destroy())
    PurgeGui.Show()
}

#f:: {
    if WinExist("ahk_class #32770 ahk_exe sndvol.exe")
        WinClose "ahk_class #32770 ahk_exe sndvol.exe"
    else {
        try Run "sndvol.exe"
        if WinWait("ahk_class #32770 ahk_exe sndvol.exe", , 1)
            WinActivate "ahk_class #32770 ahk_exe sndvol.exe"
    }
}
#j:: try run("shell:Downloads")

#+Pause:: {
    if WinActive("A") {
        try {
            if (WinGetExStyle("A") & 0x8) {
                WinSetAlwaysOnTop 0, "A"
                SoundPlay "C:\Windows\Media\Windows11_sounds_b22000\sounds\Speech sleep.wav"
            } else {
                WinSetAlwaysOnTop 1, "A"
                SoundPlay "C:\Windows\Media\Windows11_sounds_b22000\sounds\Speech On.wav"
            }
        }
    }
}

^#z:: {
    activeHWND := WinActive("A")
    if activeHWND {
        WinRestore "ahk_id " activeHWND
        Sleep 50
        WinMove(0, 0, 1574, 780, "ahk_id " activeHWND)
    }
}

^+a:: {
    clipSaved := ClipboardAll()
    A_Clipboard := ""
    SendInput "^c"
    if ClipWait(0.5) {
        A_Clipboard := StrUpper(A_Clipboard)
        SendInput "^v"
        Sleep 100
    }
    A_Clipboard := clipSaved
}

Pause:: try Run("C:\Users\pc\Desktop\idk2")

F10:: try Run('"C:\Users\pc\Desktop\idk2\nircmd.exe" muteappvolume Mechvibes.exe 2', , "Hide")
#+b:: try Run("brave.exe")
#+n:: try Run("notepad++.exe")
#n:: try run ("notepad.exe")
#+a:: try Run("C:\Users\pc\Desktop\idk2\AutoWall\AutoWall.exe")
#+q:: try Run("C:\Users\pc\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\AutoWall.lnk")
#+d:: try Run('"C:\Program Files\BraveSoftware\Brave-Browser\Application\chrome_proxy.exe"  --profile-directory=Default --app-id=magkoliahgffibhgfkmoealggombgknl"')
#+f:: try Run("C:\Users\pc\AppData\Roaming\Spotify\Spotify.exe")
#+e:: try Run('*RunAs "C:\Users\pc\Desktop\idk2\Everything\Everything.exe"')
#g:: try Run("brave.exe https://gemini.google.com/app")
CapsLock & y:: try run("brave.exe https://www.youtube.com")
CapsLock & t:: try run("https://search.brave.com/search?q=%D9%85%D8%AA%D8%B1%D8%AC%D9%85")
#+w:: try Run("c:\Users\pc\Desktop\idk2\ShareX-19.0.2-portable\ShareX.exe")
^+NumpadAdd::
{
    if ProcessExist("bongo-cat.exe")
    {
        ProcessClose("bongo-cat.exe")
    }
    else
    {
        try 
        {
            Run("C:\Program Files\BongoCat\bongo-cat.exe")
        }
        catch
        {

        }
    }
}
^#+t:: {
    try {
        local pid
        Run("C:\Users\pc\Desktop\idk2\no tray.lnk",,, &pid)
        ProcessSetPriority("High", pid)
    }
}

^#t:: {
    try {
        local pid
        Run("C:\Users\pc\Desktop\idk2\TaskbarX task.lnk",,, &pid)
        ProcessSetPriority("High", pid)
    }
}

+NumpadAdd:: {
    if PID := ProcessExist("Rainmeter.exe") {
        try ProcessClose(PID)
    }
    else {
        RainmeterPath := A_ProgramFiles "\Rainmeter\Rainmeter.exe"
        AlternativePath := EnvGet("ProgramFiles(x86)") "\Rainmeter\Rainmeter.exe"
        
        if FileExist(RainmeterPath)
            Run(RainmeterPath)
        else if FileExist(AlternativePath)
            Run(AlternativePath)
    }
}

^NumpadDot::
^NumpadDel:: {
    if PID := ProcessExist("mpv.exe")
        try ProcessClose(PID)
}

^-::
^NumpadSub:: {
    if PID := ProcessExist("ExplorerWatcher.exe") {
        try ProcessClose(PID)
    }
    else {
        try Run('"C:\Users\pc\Desktop\idk2\ExplorerWatcher\publish\ExplorerWatcher.exe"')
    }
}

^NumpadDiv:: {
    try {
        Run 'C:\Program Files\Mechvibes\Mechvibes.exe',,, &MechPID
        if ProcessWait(MechPID, 2)
            ProcessSetPriority "High", MechPID
    }
}

^NumpadMult:: try Run 'C:\Users\pc\Desktop\idk2\QuickLook.lnk'

path1 := "C:\Users\pc\Desktop\idk2\wallpapers\"
path2 := "C:\Users\pc\Desktop\idk2\wallpaperss\"

^Numpad0::Run(path1 . "AutoWall.lnk")
^Numpad1::Run(path1 . "AutoWall1.lnk")
^Numpad2::Run(path1 . "AutoWall2.lnk")
^Numpad3::Run(path1 . "AutoWall3.lnk")
^Numpad4::Run(path1 . "AutoWall4.lnk")
^Numpad5::Run(path1 . "AutoWall5.lnk")
^Numpad6::Run(path1 . "AutoWall6.lnk")
^Numpad7::Run(path1 . "AutoWall7.lnk")
^Numpad8::Run(path1 . "AutoWall8.lnk")
^Numpad9::Run(path1 . "AutoWall9.lnk")

^!Numpad0::Run(path2 . "AutoWall.lnk")
^!Numpad1::Run(path2 . "AutoWall1.lnk")
^!Numpad2::Run(path2 . "AutoWall2.lnk")
^!Numpad3::Run(path2 . "AutoWall3.lnk")
^!Numpad4::Run(path2 . "AutoWall4.lnk")
^!Numpad5::Run(path2 . "AutoWall5.lnk")
^!Numpad6::Run(path2 . "AutoWall6.lnk")
^!Numpad7::Run(path2 . "AutoWall7.lnk")
^!Numpad8::Run(path2 . "AutoWall8.lnk")
^!Numpad9::Run(path2 . "AutoWall9.lnk")

^!p:: {
    global LastSuspendedPID
    
    if (LastSuspendedPID != 0) {
        if ProcessResume(LastSuspendedPID) {
            LastSuspendedPID := 0
        }
        return
    }
    
    activeHWND := WinExist("A")
    if !activeHWND
        return
        
    activePID := WinGetPID("ahk_id " activeHWND)
    processName := WinGetProcessName("ahk_id " activeHWND)
    
    if (processName == "explorer.exe" || processName == "AutoHotkey64.exe")
        return
        
    if ProcessSuspend(activePID) {
        LastSuspendedPID := activePID
    }
}

#HotIf WinActive("ahk_class CabinetWClass") || WinActive("ahk_class ExploreWClass")

^F2:: ToggleSystemHiddenFiles()

#HotIf WinActive("ahk_class CabinetWClass") || WinActive("ahk_class Progman") || WinActive("ahk_class WorkerW")

^+Del:: DllCall("shell32\SHEmptyRecycleBin", "Ptr", 0, "Ptr", 0, "UInt", 7)

!m:: {
    dirPath := ""
    activeHWND := WinExist("A")
    activeClass := WinGetClass("ahk_id " activeHWND)
    
    if (activeClass == "CabinetWClass") {
        for window in ComObject("Shell.Application").Windows {
            if (window.HWND == activeHWND) {
                try dirPath := window.Document.Folder.Self.Path
                break
            }
        }
    } else {
        dirPath := A_Desktop
    }
        
    if (dirPath == "")
        return
        
    filePath := dirPath "\New Text Document.txt"
    if FileExist(filePath) {
        count := 2
        while FileExist(dirPath "\New Text Document (" count ").txt")
             count++
        filePath := dirPath "\New Text Document (" count ").txt"
    }
    
    FileAppend("", filePath, "UTF-8")
    
    if (activeClass == "Progman" || activeClass == "WorkerW" || activeClass != "CabinetWClass") {
        DllCall("shell32\SHChangeNotify", "Int", 0x08000000, "UInt", 0, "Ptr", 0, "Ptr", 0)
    } else {
        for window in ComObject("Shell.Application").Windows {
            if (window.HWND == activeHWND) {
                try window.Refresh()
                break
            }
        }
    }
}

!n:: Send "^+n"

^+c:: {
    filePath := GetSelectedFilePath()
    if (filePath != "") {
        A_Clipboard := '"' filePath '"'
    }
}

^o:: {
    filePath := GetSelectedFilePath()
    if (filePath != "") {
        try {
            Run('notepad.exe "' filePath '"')
            if WinWait("ahk_exe notepad.exe", , 5)
                WinActivate("ahk_exe notepad.exe")
        }
    }
}

^+o:: {
    filePath := GetSelectedFilePath()
    if (filePath != "") {
         try {
            Run('notepad++.exe "' filePath '"')
            if WinWait("ahk_exe notepad++.exe", , 5)
                WinActivate("ahk_exe notepad++.exe")
        }
    }
}

#HotIf

RunAsAdminFast() {
    filePath := GetSelectedFilePath()
    if (filePath != "") {
         try Run('*RunAs "' filePath '"')
    }
}

GetSelectedFilePath() {
    activeHWND := WinExist("A")
    if !activeHWND
        return ""
        
    activeClass := WinGetClass("ahk_id " activeHWND)
    
    if (activeClass == "CabinetWClass" || activeClass == "ExploreWClass") {
        for window in ComObject("Shell.Application").Windows {
            if (window.HWND == activeHWND) {
                try {
                    selectedItems := window.Document.SelectedItems
                    for item in selectedItems {
                       return item.Path
                    }
                }
                break
            }
        }
    }
    else if (activeClass == "Progman" || activeClass == "WorkerW") {
        clipSaved := ClipboardAll()
        A_Clipboard := ""
        SendInput "^c"
        if ClipWait(0.3) {
            filePath := A_Clipboard
            A_Clipboard := clipSaved
            return filePath
        }
        A_Clipboard := clipSaved
    }
    return ""
}

ToggleSystemHiddenFiles() {
    RootKey := "HKEY_CURRENT_USER"
    SubKey  := "Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced"
    ValueName := "ShowSuperHidden"

    try {
        currentStatus := RegRead(RootKey "\" SubKey, ValueName)
        newStatus := (currentStatus == 0) ? 1 : 0
        RegWrite(newStatus, "REG_DWORD", RootKey "\" SubKey, ValueName)
        
        activeID := WinExist("A")
        PostMessage(0x111, 41504, 0, , "ahk_id " activeID)
    } catch Error as err {
        MsgBox("error: " err.Message)
    }
}

ProcessPurge(GuiObj, CloseBraveFlag) {
    GuiObj.Destroy()
    
    if (CloseBraveFlag = 1) {
        global HiddenWindowsStack
        HiddenWindowsStack := []
    }
    
    UnnecessaryApps := ["Spotify.exe", "MSIAfterburner.exe", "rtss.exe",
                        "RuntimeBroker.exe", "quicklook.exe", "autopause.exe",
                        "startmenu.exe", "everything.exe", "discord.exe",
                        "epicgameslauncher.exe", "GalaxyClient.exe", "Mechvibes.exe", 
                        "mpv.exe", "autopause.exe", "explorerwatcher.exe", 
                        "Steam.exe", "neatdm.exe", "PowerToys.exe",
                        "Encoderserver.exe", "RTSSHooksLoader64.exe", "wmiprvse.exe",
                        "notepad.exe", "RtkNGUI64.exe", "WavesSvc64.exe", 
                        "autowall.exe" ]
                        
    if (CloseBraveFlag = 1) {
        UnnecessaryApps.Push("brave.exe")
    }
    
    for app in UnnecessaryApps {
        if PID := ProcessExist(app) {
            try ProcessClose(PID)
        }
    }
    
    if PID := ProcessExist("dllhost.exe") {
        try ProcessClose(PID)
    }
}

ProcessSuspend(PID_or_Name) {
    PID := IsInteger(PID_or_Name) ? PID_or_Name : ProcessExist(PID_or_Name)
    if !PID
        return false
    hProcess := DllCall("OpenProcess", "UInt", 0x0800, "Int", false, "UInt", PID, "Ptr")
    if !hProcess
        return false
    status := DllCall("ntdll\NtSuspendProcess", "Ptr", hProcess)
    DllCall("CloseHandle", "Ptr", hProcess)
    return status == 0
}

ProcessResume(PID_or_Name) {
    PID := IsInteger(PID_or_Name) ? PID_or_Name : ProcessExist(PID_or_Name)
    if !PID
        return false
    hProcess := DllCall("OpenProcess", "UInt", 0x0800, "Int", false, "UInt", PID, "Ptr")
    if !hProcess
        return false
    status := DllCall("ntdll\NtResumeProcess", "Ptr", hProcess)
    DllCall("CloseHandle", "Ptr", hProcess)
    return status == 0
}
GetCurrentPath() {
    if WinActive("ahk_class Progman") or WinActive("ahk_class WorkerW")
        return A_Desktop
    if WinActive("ahk_class CabinetWClass") {
        for window in ComObject("Shell.Application").Windows {
            if window.HWND == WinExist("A")
                try return window.Document.Folder.Self.Path
        }
    }
    return ""
}

^+d:: {
    path := GetCurrentPath()
    if (path != "") {
        output := ""
        Loop Files, path "\*", "FD"
        {
            output .= A_LoopFileName "`n"
        }
        FileOpen(A_Desktop "\file.txt", "w", "UTF-8").Write(output)
    }
}

^+!d:: {
    path := GetCurrentPath()
    if (path != "")
        Run(A_ComSpec ' /k "chcp 65001 >nul && dir /b"', path)
}

#HotIf

^+q:: {
    selectedPath := GetSelectedPathWithClipboard()
    if (selectedPath != "" && SubStr(selectedPath, -4) = ".lnk") {
        try {
            wsh := ComObject("WScript.Shell")
            shortcut := wsh.CreateShortcut(selectedPath)
            targetPath := shortcut.TargetPath
            
            if (targetPath != "") {
                if FileExist(targetPath) {
                    Run('explorer.exe /select, "' . targetPath . '"')
                } else {
                    Run(targetPath)
                }
            }
        } catch as e {

        }
    }
    return
}

GetSelectedPathWithClipboard() {
    if !WinActive("ahk_class CabinetWClass") && !WinActive("ahk_class ExploreWClass") && !WinActive("ahk_class Progman") && !WinActive("ahk_class WorkerW")
        return ""
    clipSaved := ClipboardAll()
    A_Clipboard := ""
    Send("^c")
    if ClipWait(0.2, 1) {
        path := Trim(A_Clipboard, "`r`n`t ")
        A_Clipboard := clipSaved
        return path
    }
    A_Clipboard := clipSaved
    return ""
}
global HiddenWindowsGroup := []

global HiddenWindowsGroup := []

^#g:: {
    global HiddenWindowsGroup
    if (HiddenWindowsGroup.Length > 0) {
        for hwnd in HiddenWindowsGroup {
            if WinExist("ahk_id " hwnd)
                WinShow("ahk_id " hwnd)
        }
        HiddenWindowsGroup := []
    } else {
        windowList := WinGetList()
        for hwnd in windowList {
            if !WinExist("ahk_id " hwnd)
                continue
                
            try {
                style := WinGetStyle("ahk_id " hwnd)
                title := WinGetTitle("ahk_id " hwnd)
                process := WinGetProcessName("ahk_id " hwnd)
                
                if (style & 0x10000000) && (title != "") && (process != "explorer.exe") {
                    WinHide("ahk_id " hwnd)
                    HiddenWindowsGroup.Push(hwnd)
                }
            }
        }
    }
}
remainingText := ""
lastClipboard := ""

^+!t:: {
    global remainingText, lastClipboard
    
    if (GetKeyState("ScrollLock", "T")) {
        SetScrollLockState(false)
        return
    }
    
    currentClipboard := A_Clipboard
    
    if (currentClipboard != lastClipboard) {
        remainingText := currentClipboard
        lastClipboard := currentClipboard
    }
    
    if (remainingText != "") {
        SetScrollLockState(true)
        Sleep(100)
        
        Loop Parse, remainingText {
            if (!GetKeyState("ScrollLock", "T")) {
                remainingText := SubStr(remainingText, A_Index)
                return
            }
            
            if (A_Clipboard != lastClipboard) {
                remainingText := A_Clipboard
                lastClipboard := A_Clipboard
                return
            }
            
            if (A_LoopField == "`n" || A_LoopField == "`r") {
                SendInput("{Raw}" . A_LoopField)
            } else {
                SendInput(A_LoopField)
            }
            Sleep(30)
        }
        
        remainingText := ""
        lastClipboard := ""
        SetScrollLockState(false)
    }
}