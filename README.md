- [About](#about)
- [How To Use](#how-to-use)
    - [Save Data](#save-data)
    - [Load Data](#load-data)
        - [Easy Load Method](#easy-load-method)
        - [Alternative Load Method](#alternative-load-method)
    - [Command Prompt Mode](#command-prompt-mode)
- [Set Up](#set-up)
    - [File Paths](#file-paths)
        - [Local Variable: SaveFolder](#local-variable-savefolder)
        - [Local Variable: DataFolder](#local-variable-datafolder)
        - [Local Variable: LogFolder](#local-variable-logfolder)
    - [Recommended Directory Structure](#recommended-directory-structure)
- [Known Limitations](#known-limitations)

# About

These are utility files I made to make it easier to save and load from checkpoints in my playthroughs of [Kura5](https://chickenhat.itch.io/kura5-bonds-of-the-undying). If you have any questions, comments, or complaints, contact @kodedile on [Twitter](https://twitter.com/kodedile) or [Github](https://github.com/kodedile)

# How To Use

## Save Data

UPDATE: Saving now also saves a copy of the current `output_log.txt` to your save folder in case you want to review any recent errors or debug logs.

1.  Play "Kura5.exe"
2.  Talk to Nero the Cat
3.  Double-click or Run `save.bat` and type a descriptive name for your save data (assumes the files match the paths specified in the local variable, see [Set Up](#set-up))
    1.  If you are asked to confirm a file overwrite, you may have forgotten to change the filename for your new save.
    2.  Type `n` and press `ENTER` to cancel.
    3.  You may also be asked about overwriting the log file of the same name, in which case type `n` and press `ENTER` to cancel again.
    4.  After canceling, try running `save.bat NewFileName`

## Load Data

### Easy Load Method

1.  If playing "Kura5.exe", return to the `Main Menu` or `Quit Game`
2.  Drag and drop a single `Kura5_Builds/Save_Files/filename.bok` onto `Kura5_Builds/Kura5_version/dropnload.bat`
    1.  If overwriting an existing file (like `Kura5_Data/save.bok`) you will be asked to confirm the overwrite. 
    2.  Type `y` and press `ENTER` to confirm if you no longer need the data in `Kura5_Data/save.bok`. Otherwise, type `n` and press `ENTER` to cancel.
3.  Play "Kura5.exe" and `Load` your saved game!

NOTE: the file can be anywhere, but the folder names can't include spaces because I haven't figured out how to get the path to work with spaces.

### Alternative Load Method

Double-click or run `load.bat` and type in the name of the save file you wish to load (assumes the files match the paths specified in the local variable, see [Set Up](#set=up))

## Command Prompt Mode

This method is good for when you want to quickly save files in succession, or show the current path and commands on stream.

1.  Search for "cmd.exe" on Windows
2.  Run "cmd.exe"
3.  Change to the working directory. For example: `cd "C:\Users\USERNAME\Downloads\Kura5_Builds\Kura5_version"`
4.  To save, type `save.bat NameToSave` and press ENTER to save to `NameToSave.bok` and `log-NameToSave.txt`
    1.  If you are asked to confirm a file overwrite, you may have forgotten to change the filename for your new save.
    2.  Type `n` and press `ENTER` to cancel.
    3.  You may also be asked about overwriting the log file of the same name, in which case type `n` and press `ENTER` to cancel again.
    4.  After canceling, try running `save.bat NewFileName`
6.  To load, type `load.bat NameToLoad` and press ENTER to load the save file `NameToLoad.bok`
    1.  If overwriting an existing file (like `Kura5_Data/save.bok`) you will be asked to confirm the overwrite. 
    2.  Type `y` and press `ENTER` to confirm that you no longer need the data in `Kura5_Data/save.bok`. Otherwise, type `n` and press `ENTER` to cancel.
7.  To reuse a previous command or see the previous filename you typed, use the `Up` and `Down` arrow keys to scroll through previous commands.

# Set Up 

Extract the files from the [master zip archive](https://github.com/kodedile/SaveDataScripts/archive/refs/heads/master.zip) or download the specific files you want.

I recommend putting the three scripts in the Kura5 root directory. If you have more than one Kura5 directory (for different versions), make copies of the scripts for each of those root directories.  Then you will need to adjust the file paths variables accordingly (see [File Paths](#file-paths)).

If you just want to use one of my sample saves, you can put the save file anywhere and use the `dropnload.bat` script to load it into a Kura5 game. NOTE: the current `dropnload.bat` won't accept spaces in the filepath... I need to fix that somehow. See [Load Data](#load-data) for more information.

## File Paths

To get these scripts to work with your filesystem, you should change the following:

### Local Variable: SaveFolder

**Default**: `SET SaveFolder=%cd%\..\Save_Files\VERSION` (save.bat and load.bat)

Used in `save.bat` and `load.bat` to find your save folder.  You will want to modify these so that `VERSION` is the Kura5 version from which your save file was created.

If you do not follow the [Recommended Directory Structure](#recommended-directory-structure), then you will need to change the `\..\Save_Files\VERSION` so that the path matches your structure.

### Local Variable: DataFolder

**Default**: `SET DataFolder=%cd%\Kura5_Data` (save.bat and load.bat)  
**Default**: `SET %ScriptPath:~0,-1%\Kura5_Data` (dropnload.bat)

Used to find the `Kura5_Data` folder where the game keeps `save.bok`.  You can leave this unchanged unless you are not following the [Recommended Directory Structure](#recommended-directory-structure).

### Local Variable: LogFolder

**Default**: `Set LogFolder=C:\Users\USERNAME\AppData\LocalLow\Kura5 Devs\Kura5` (save.bat)

Used in `save.bat` to find the `output-log.txt` needed for debugging. You should only need to change `USERNAME` to your system username, unless your path is different.

## Recommended Directory Structure

```
Kura5_Builds/
    Kura5_version/
        Kura5_Data/
            save.bok
	    ...
        dropnload.bat
        Kura5.exe
        load.bat
        save.bat
        UnityPlayer.dll
        ...
    Save_Files/
        version/
	    tagged-example-01.bok
	    tagged-example-02.bok
	    ...
	example-01.bok
	...
```

# Known Limitations

- developed for Windows systems
- `save.bat` will only use the filename you specify.  When running `save.bat NestedFolder/FileToSave`, the script will ignore `NestedFolder/`
- `dropnload.bat` will not work if the file you are trying to load has spaces in its path
    - This will work: `C:\Users\USERNAME\Kura5_Builds\Save_Files\x86_0306_dev\FileToLoad.bok`
    - This will not work: `C:\Users\USERNAME\Kura5 Builds\Save Files\x86_0306_dev\FileToLoad.bok`
