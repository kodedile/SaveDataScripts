Setup: 

Extract or move the whole "SaveDataScripts" folder into the directory of your Kura5.exe game 
(for example, "C:\Users\USERNAME\Downloads\Kura5_version")

////////////////////////////////////////////////////////////////
Note: Please do not change the folder names or change the folder structure.
These scripts assume the following structure:

Kura5_version/
    Kura5.exe
    UnityPlayer.dll
    Kura5_Data/
        save.bok
    SaveDataScripts/
        save.bat
        load.bat
        README.txt
        Save_Files/
            dragnload.bat
            example.bok

////////////////////////////////////////////////////////////////
How to save data:

1.  Play "Kura5.exe"

2.  Talk to Nero the Cat

3.  Run "save.bat" and type a descriptive name for your save data

////////////////////////////////////////////////////////////////
How to load data:

1.  If playing "Kura5.exe", return to the [Main Menu] or [Quit Game]

2.  
    Option A:  Drag and drop a single "Save_Files/filename.bok" onto "Save_Files/dropnload.bat"
    Option B:  Run "load.bat" and type the name of an existing save data file
    Option C:  Run "load.bat" and drag-and-drop a save data file onto the command prompt

3.  Play "Kura5.exe" and [Load] your saved game!

/////////////////////////////////////////////////////////////////
Command Prompt mode:

1.  Search for cmd.exe on Windows

2.  Run cmd.exe

3.  Change to this directory, for example:
	cd "C:\Users\USERNAME\Downloads\Kura5_version\SaveDataScripts"

4.  To save, type "save.bat" and press ENTER, then type a name, and press ENTER

5.  To load, type "load.bat" and press ENTER, then type or drag-n-drop a filename, and press ENTER

/////////////////////////////////////////////////////////////////

Questions, comments, complaints about SaveDataScripts?
Contact @Kodedile on Twitter or itch.io