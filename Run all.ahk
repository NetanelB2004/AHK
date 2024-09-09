#SingleInstance force
^!+r::RunAll()

RunAll() {
    scriptFolder := A_ScriptDir . "\scripts"
    masterScriptFile := SUPER_FILE_PATH()

    header := "#Requires AutoHotkey v1.0`n" . "#SingleInstance Force`n" . "MsgBox, Running all scripts`n"

    FileDelete, % masterScriptFile
    FileAppend, %header%, % masterScriptFile
 
    Loop, Files, %scriptFolder%\*.ahk
    {
        FileAppend, #Include %A_LoopFileFullPath%`n, % masterScriptFile
    }

    Run, % masterScriptFile
}

SUPER_FILE_PATH() {
    superFile := "Master.ahk"
    Return, A_ScriptDir . "\" . superFile
}