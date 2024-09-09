# AHK
this is my AHK project repository

how to use:

Set up:
Download AutoHotKey v1 from https://www.autohotkey.com/.
Run the file named "Run all.ahk". This will run all other scripts using the master script.
(Optional: Run winkey+r (#r) and write “shell:startup” to open the startup file. Add a shortcut to the “Run all” file to run it at startup, making your scripts run when you signing in).
 
Folder explanation:
Scripts: the folder with all used scripts. Any scripts here will be run when the “Run all” script is run.
Unused: the folder with all unused scripts. Any scripts here will not be run until moved to the /scripts folder.
Txt files: the folder with all txt files, used with some AHK scripts.

Useful AHKs:
(Most special AHKs are used with “!^+” combo)
!^+r – runAll(): this AHK runs all scripts.
!^+s – supersave(): this AHK saves (^s) and then runs all scripts. Useful when writing scripts.
!^+a – showAllHotkeys(): this AHK will show you all active AHK’s. It will print the output to the screen, and to a txt file in the txt folder.
#h – openAHKWithVSCode(): Creates a GUI dropdownlist (DDL) that lists all files in the /scripts folder. Select a file and press “Open” to open the script in VSCode.
#j – sendHotKey(): A script for fun. Creates a GUI dropdownlist (DDL) that lists all running hotkeys. Select one and press “Send Hotkey” to run the hotkey (does the same as pressing the hotkey yourself).

Basic syntax:
For hotkey: key combination::function
For hotstring: ::input::replace

documentation:
https://www.autohotkey.com/docs/v1/