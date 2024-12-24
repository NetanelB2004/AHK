Global LINUX_DISTRIBUTION
Global DistroChoice
Global DID_CANCEL
^!k::mobax()

mobax() {
    ;---- Set all constants ----
    DID_CANCEL := False
    DEFAULT_IP_NETWORK := "None"
    DEFAULT_DISTRIBUTION := "Default (AlmaLinux/9)"
    VM_NAME_PROMPT := "VM name"
    VM_NUMBER_PROMPT := "number of VMs"
    VM_IP_NETWORK_PROMPT := "IP network address"
    VM_SSH_PORT_PROMPT := "first SSH port"
    IP_NETWORK_ASK := "Do you want an IP address?"
    LINUX_DISTRIBUTION_ASK := "Do you want a different linux distribution (AlmaLinux/9)?"
    
    ;---- Get VM name, amount and ssh port ----
    vmName := getInput(VM_NAME_PROMPT)
    VmNumber := getInput(VM_NUMBER_PROMPT, "number")
    VmSSHPort := getInput(VM_SSH_PORT_PROMPT, "number")
    
    ;---- Get IP network address ----
    IPAddress := DEFAULT_IP_NETWORK
    if (DID_CANCEL) {
        Return
    }
    
    MsgBox, 260,, %IP_NETWORK_ASK%
    IfMsgBox, yes
        IPAddress := getInput(VM_IP_NETWORK_PROMPT)
    ;---- Get Linux distribution ----
    DistroChoice := DEFAULT_DISTRIBUTION
    if (DID_CANCEL) {
        Return
    }

    MsgBox, 260,, %LINUX_DISTRIBUTION_ASK%
    IfMsgBox, yes
        getLinuxDistro()
    ;---- Verify all choises ----
    message := "
    (
        Please confirm your input values:
        VM Name: " vmName "
        Number of VMs: " VmNumber "
        First SSH Port: " VmSSHPort "
        ip VLAN Address: " IPAddress "
        distribution: " DistroChoice "
        `nAre these values correct?
    )"

    if (DID_CANCEL) {
        Return
    }

    MsgBox, 4,, %message%
    IfMsgBox No
        Return

    ;---- Set mxtsession file ----
    MXTSESSONS_PATH := "C:\Users\Netanel\SSH\SSH_sessions.mxtsessions"
    BOOKBARK_PRETEXT := "`n[Bookmarks]`nSubRep=" vmName "`nImgNum=57`n"
    FileAppend, %BOOKBARK_PRETEXT%, %MXTSESSONS_PATH%
    
    Loop, % VmNumber
        {
            currentVM := vmName . A_Index
            sshPort := VmSSHPort + A_Index - 1
            sessionEntry := currentVM "=#109#0%localhost%" sshPort "%vagrant%%-1%-1%%%%%0%0%0%_ProfileDir_\.vagrant\machines\" currentVM "\virtualbox\private_key"
            FileAppend, %sessionEntry%`n, %MXTSESSONS_PATH%
        }

    ;---- Set vagrantfile ----
    VAGRANTFILE_PATH := "C:\Users\Netanel\Vagrantfile"

    FileRead, vagrantFileContents, %VAGRANTFILE_PATH%
    lines := StrSplit(vagrantFileContents, "`n")
    lines.RemoveAt(lines.MaxIndex())
        
    updatedVagrantFileContents := ""
    for index, line in lines
    {
        updatedVagrantFileContents .= line "`n"
    }

    vagrantCall := "`t(1.." VmNumber ").each do |i|`n`tconfig.vm.define """ vmName "#{i}"" do |vm_config|`n" . "`t`tconfigure_vm(vm_config, vm_name: """ vmName "#{i}"", ssh_port: ""#{" VmSSHPort " -1 + i}"""
    if (IPAddress != DEFAULT_IP_NETWORK) {
        vagrantCall .= ", ip: """ IPAddress . ".#{i + 1}"""
    }

    if (DistroChoice != DEFAULT_DISTRIBUTION) {
        vagrantCall .= ", box_name: """ DistroChoice . """"
    }
    vagrantCall .= ")`n`t`tend`n`tend"
        
    updatedVagrantFileContents .= vagrantCall . "`nend"
    
    FileDelete, %VAGRANTFILE_PATH%
    FileAppend, %updatedVagrantFileContents%, %VAGRANTFILE_PATH%

    ;---- Run vagrant up and Oracle ----
    Run, cmd.exe /k "vagrant up", C:\Users\%A_UserName%
    Oracle()
}

getInput(text, type := "") {
    NUMBER_REGEX := "^([0-9]+)$"
    Global DID_CANCEL
    if (DID_CANCEL) {
        Return
    }
    ;---- Get user input ----
    InputBox, var, VM Setup, Enter the %text%, , 250, 125, , , HIDE
    if (ErrorLevel) {
        DID_CANCEL := True
        return
    }
    var := Trim(var)

    ;---- Check input isn't empty ----
    if (!var) {
        Return getInput(text, type)
    }
    
    ;---- Check if number ----
    if (type = "number") {
        if (!RegExMatch(var, NUMBER_REGEX)) {
            MsgBox, Please enter a valid number.
            return getInput(text, type)
        }
    }
    
    return var
}

getLinuxDistro() {
    DONT_EXIT_CODE := 999
    Global DistroChoice := DONT_EXIT_CODE
    LinuxDistributionGUI()
    while (DistroChoice == DONT_EXIT_CODE) {
    }
}

LinuxDistributionGUI() {
    distributions := AllDistributions()

    Gui, New,, Pick linux distribution
    Gui, Font, s15
    Gui, Add, Text, Center, Select a Linux distribution
    Gui, Add, DropDownList, w325 choose1 vLINUX_DISTRIBUTION, %distributions%
    Gui, Add, Button, w150 gSetDistro +Default, Select
    Gui, Add, Button, w150 x+25 gExit, Exit

    Gui, Show
    Gui, Submit, NoHide
}

AllDistributions() {
    distributions := "
    (
        almalinux/9
        centos/7
        centos/8
        centos/9
        ubuntu/20.04
        ubuntu/22.04
        debian/10
        debian/11
        fedora/34
        fedora/35
        arch/rolling
        manjaro/21
        opensuse/leap/15.3
        opensuse/tumbleweed
        linuxmint/20
        rocky/8
    )"
    
    result := ""
    Loop, parse, distributions, `n, `r
    {
        if (A_LoopField != "")
        {
            result .= A_LoopField "|"
        }
    }
    return result
}

SetDistro() {
    Global DistroChoice
    Global LINUX_DISTRIBUTION
    Gui, Submit, Hide
    DistroChoice := Trim(LINUX_DISTRIBUTION)
    Return
}

Exit:
    Gui, Destroy
    DEFAULT_DISTRIBUTION := "Default (AlmaLinux/9)"
    DistroChoice := DEFAULT_DISTRIBUTION
    Return