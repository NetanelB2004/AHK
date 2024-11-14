^!h::Run, %A_WorkingDir%
^!z::Run, ms-settings:
^!x::Run, explorer.exe
^!c::Run, cmd, c:\Users\%A_UserName%
;!^+c::cmd()

cmd() {
    send, ^l
    send, cmd
    send, {enter}
}