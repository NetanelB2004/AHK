Global AHK_CHOICE
Global NEW_FILE_CHOICE
global VS_CODE
Global AHK_FUNCTION

#h::openAHKWithVSCode()
#j::sendHotKey()


openAHKWithVSCode() {
    global VS_CODE := VS_CODE_PATH()
    Global NEW_FILE_CHOICE := "-- CREATE NEW AHK FILE --"
    scripts := getAllScripts() . "|" . NEW_FILE_CHOICE

    Gui, Destroy
    Gui, New,,Open AHK script with VS_CODE
    Gui, Font, s15
    Gui, Add, Text, Center, Select AHK file to open
    Gui, Add, DropDownList, w325 choose1 vAHK_CHOICE, %scripts%
    Gui, Add, Button, w150 gGetSelection +Default, Open
    Gui, Add, Button, w150 x+25 , Cancel

    Gui, show
   }

   GetSelection() {
    Global AHK_CHOICE
    Global NEW_FILE_CHOICE

    Gui, submit, Hide
    
    if (AHK_CHOICE == NEW_FILE_CHOICE) {
        createAHK()
        return
    }

    scriptLocation := SCRIPT_DIR() . "\" . AHK_CHOICE . ".ahk"
    Run, %VS_CODE% "%scriptLocation%"
   } 
    
    ButtonCancel:
    GuiClose:
        Gui, Destroy
return

getAllScripts() {
    scriptDir := SCRIPT_DIR()

    Loop, Files, %scriptDir%\*.ahk
        {
            scripts .= SubStr(A_LoopFileName, 1, StrLen(A_LoopFileName) - 4) "|"
        }

    Return, Scripts 
}

createAHK() {
	scriptDir := SCRIPT_DIR()

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
    global VS_CODE
    location := scriptDir "\" input ".ahk"
	FileAppend, #SingleInstance Force, %location%
	Run, %VS_CODE% "%location%"
}

sendHotKey() {
    AHKs := getAllHotKeys()

    Gui, Destroy
    Gui, New,,Open AHK script with VS_CODE
    Gui, Font, s15
    Gui, Add, Text, Center, Select AHK file to open
    Gui, Add, DropDownList, w325 choose1 vAHK_FUNCTION, %AHKs%
    Gui, Add, Button, w150 gAHK +Default, Open
    Gui, Add, Button, w150 x+25 , Cancel

    Gui, show
    return
   }

AHK() {
    Global AHK_FUNCTION

    Gui, submit, Hide
    hotKey := StrSplit(AHK_FUNCTION," -- ")[1]
    Send, %hotKey%
    return
}   

getAllHotKeys() {
    regexKey := "^\s*([\^\!\+\#]+[^\:\s]+)"
    FileRead, fileContent, txt files/hotkeys list.txt
    strings := ""

    Loop, Parse, fileContent, `n, `r
        {
            line := A_LoopField
            if (RegExMatch(line, regexKey)) {
                strings .= line . "|"
            }
        }
    return strings 
}    

