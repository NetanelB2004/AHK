^!+a::showAllHotKeys()

showAllHotKeys() {
    #NoEnv
    #Persistent

    scriptDir := A_ScriptDir . "\scripts"
    outputFile := "hotkeys list.txt"

    regexKey := "^\s*([\^\!\+\#]?[^\:\s]+)::(.+)"
    regexString := "^\s*::([^:]+)::(.+)"

    hotkeys := ""
    hotstrings := ""

    ; Loop through all .ahk files in the specified directory
    Loop, Files, %scriptDir%\*.ahk
    {
        currentFile := SubStr(A_LoopFileName, 1, StrLen(A_LoopFileName) - 4)

        ; Read the content of the AHK file
        FileRead, fileContent, % A_LoopFileFullPath

        ; Use a regular expression to find hotkey definitions and hotstrings
        Loop, Parse, fileContent, `n, `r
        {
            line := A_LoopField

            if (SubStr(line, 1, 1) = ";" || line = "")
            {
                continue
            }

            isHotkey := RegExMatch(line, regexKey, hotkeyMatch)
            isHotString := RegExMatch(line, regexString, hotstringMatch)

            if (!isHotkey and !isHotString)
            { 
                continue
            }

            if (isHotkey)
            {
                hotkeys := ExractHotObjects(currentFile, hotkeys ,hotkeyMatch1, hotkeyMatch2)
            }
            if (isHotString)
            {
                hotstrings := ExractHotObjects(currentFile, Hotstrings ,hotstringMatch1, hotstringMatch2)
            }

            currentFile := false
        }
    }

    if (hotkeys != "" || hotstrings != "")
    {
        FileDelete, % outputFile
        FileAppend, % "Modifier Keys:`nctrl = ^`nalt = !`nshift = +`nwinkey = #`n", % outputFile

        addHotObjectList("hotkeys", hotkeys, outputFile)
        addHotObjectList("hotstrings", hotstrings, outputFile)

        FileRead, finalContent, % outputFile
        MsgBox, % "Active Hotkeys and Hotstrings:`n`n" finalContent
    }
    else
    {
        MsgBox, No hotkeys or hotstrings found in the specified directory.
    }
}

addHotObjectList(hotObjectList, hotObjectListValue, outputFile) {
    if (hotObjectListValue != "")
        {
            FileAppend, % "`n=== Active " hotObjectList " ===`n", % outputFile
            FileAppend, %hotObjectListValue%, %outputFile%
        }
}

ExractHotObjects(currentFile, hotObjectList, key, action) {
    if (currentFile)
        {
            hotObjectList .= "`n" . currentFile . "`n"
        }

        hotObjectList .=  key . " -- " . action . "`n"
        
    Return hotObjectList
}