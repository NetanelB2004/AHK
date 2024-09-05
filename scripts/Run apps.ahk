^!h::Run, %A_WorkingDir%
^!z::Run, ms-settings:
^!x::Run, explorer.exe
^!c::Run, cmd, c:\Users\%A_UserName%
;^!v::Moba()
^!l::luz()
!^+c::cmd()

cmd() {
    send, ^l
    send, cmd
    send, {enter}
}

luz() {
	Loop, Files, C:\Users\NetanelBoleg\Pictures\luz\*.png
	Run, %A_LoopFileLongPath%
}

;Moba() {
;    Run, C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MobaXterm\MobaXterm.lnk
;}