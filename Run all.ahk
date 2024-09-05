^!+r:: RunAll()

RunAll() {
    superFile := "Master.ahk"
    scriptFolder := A_ScriptDir . "\scripts"
    masterScriptFile := A_ScriptDir . "\" . superFile

    header := "#Requires AutoHotkey v1.0`n" . "#SingleInstance Force`n" . "MsgBox Running all scripts`n"

    FileDelete, % masterScriptFile
    FileAppend, %header%, % masterScriptFile

    Loop, Files, %scriptFolder%\*.ahk
    {
        FileAppend, #Include %A_LoopFileFullPath%`n, % masterScriptFile
    }

    Run, % superFile
}