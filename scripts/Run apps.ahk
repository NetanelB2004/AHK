^!h::Run, %A_WorkingDir%
^!z::Run, ms-settings:
^!x::Run, explorer.exe
^!c::Run, cmd, c:\Users\%A_UserName%
^!v::Moba()
^!o::Oracle()
;!^+c::cmd()

cmd() {
    send, ^l
    send, cmd
    send, {enter}
}

Moba() {
    Run, % MOBA_PATH()
}

Oracle() {
    Run, % ORACLE_PATH()
}