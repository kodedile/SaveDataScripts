About:

These are utility files I made to make it easier to save and load from checkpoints in my playthroughs of Kura5 (see https://chickenhat.itch.io/kura5-bonds-of-the-undying).

////////////////////////////////////////////////////////////////
Setup: 

Extract or move the whole "SaveDataScripts" folder into the directory of your Kura5.exe game 
(for example, "C:\Users\USERNAME\Downloads\Kura5_version")

////////////////////////////////////////////////////////////////
Note: Please do not change the folder structure. 
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
	    
Note 2: You may copy and rename SaveDataScripts to keep save files separate for each playthrough.
For example:

Kura5_version/
    Kura5.exe
    UnityPlayer.dll
    Kura5_Data/
        save.bok
    FirstRun/
        save.bat
        load.bat
        README.txt
        Save_Files/
            dragnload.bat
            purified-lalupe.bok
	    assimilated-vinnel.bok
    SpeedRunAnnie/
        save.bat
        load.bat
        README.txt
        Save_Files/
            dragnload.bat
            purified-lalupe.bok
	    purified-vinnel.bok
    SpeedRunEmil/
        save.bat
        load.bat
        README.txt
        Save_Files/
            dragnload.bat
            assimilated-lalupe.bok
	    assimilated-vinnel.bok

////////////////////////////////////////////////////////////////
How to save data:

1.  Play "Kura5.exe"

2.  Talk to Nero the Cat

3.  Run "save.bat" and type a descriptive name for your save data

////////////////////////////////////////////////////////////////
How to load data:

1.  If playing "Kura5.exe", return to the [Main Menu] or [Quit Game]

2.  Drag and drop a single "Save_Files/filename.bok" onto "Save_Files/dropnload.bat"

3.  Play "Kura5.exe" and [Load] your saved game!

/////////////////////////////////////////////////////////////////
Command Prompt mode:

1.  Search for "cmd.exe" on Windows

2.  Run "cmd.exe"

3.  Change to this directory, for example:
	cd "C:\Users\USERNAME\Downloads\Kura5_version\SaveDataScripts"

4.  To save, type "save.bat NameToSave" and press ENTER to save to "NameToSave.bok"

5.  To load, type "load.bat NameToLoad" and press ENTER to load the save file "NameToLoad.bok"

/////////////////////////////////////////////////////////////////

Questions, comments, complaints about SaveDataScripts?
Contact @Kodedile on Twitter or Github
