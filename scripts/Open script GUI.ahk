Global AHKChoise
Global newFile

#h::openAHKWithVSCode()


openAHKWithVSCode() {
    Global newFile := "-- CREATE NEW AHK FILE --"
    scripts := getAllScripts() . "|" . newFile

    Gui, Destroy
    Gui, New,,Open AHK script with VScode
    Gui, Font, s15
    Gui, Add, Text, Center, Select AHK file to open
    Gui, Add, DropDownList, w325 choose1 vAHKChoise, %scripts%
    Gui, Add, Button, w150 gGetSelection +Default, Open
    Gui, Add, Button, w150 x+25 , Cancel

    Gui, show
   }

   GetSelection() {
    Global AHKChoise
    Global newFile

    Gui, submit, Hide
    
    if (AHKChoise == newFile) {
        createAHK()
        return
    }

    scriptLocation := A_ScriptDir "\scripts\" AHKChoise ".ahk"
    Run, C:\Program Files\Microsoft VS Code\Code.exe "%scriptLocation%"
   } 
    
    ButtonCancel:
    GuiClose:
        Gui, Destroy
return

getAllScripts() {
    scriptDir := A_ScriptDir . "\scripts"

    Loop, Files, %scriptDir%\*.ahk
        {
            scripts .= SubStr(A_LoopFileName, 1, StrLen(A_LoopFileName) - 4) "|"
        }

    Return, Scripts 
}

createAHK() {
	scriptDir := A_ScriptDir . "\scripts"

	; send imputBox
	InputBox, userInput, new AHK file, Please enter a new file name, , 250, 125
	if (ErrorLevel) {
		return
	}

	; get input without spaces
	input := Trim(userInput, " ")
	if (StrLen(input) == 0) {
		msgbox, invalid input

		createAHK()
		return
	}
		
	; check if file name exists
	Loop, Files, %scriptDir%\*.ahk
	{
		currentFileName := SubStr(A_LoopFileName, 1, StrLen(A_LoopFileName) - 4)
		if (input == currentFileName) {
			msgbox, this name already exits
			return
		}
	}

	; create and open script file
	location := scriptDir "\" input ".ahk"
	FileAppend, #SingleInstance Force, %location%
	Run, C:\Program Files\Microsoft VS Code\Code.exe "%location%"
}