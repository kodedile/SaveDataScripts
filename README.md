# Quick Links

- [About](#about)
- [Known Limitations](#known-limitations)
- [Set Up](#set-up)
    - [Recommended Directory Structure](#recommended-directory-structure)
    - [File Paths](#file-paths)
        - [Local Variable: SaveFolder](#local-variable-savefolder)
        - [Local Variable: DataFolder](#local-variable-datafolder)
        - [Local Variable: LogFolder](#local-variable-logfolder)
- [How To Use](#how-to-use)
    - [Save Data](#save-data)
    - [Load Data](#load-data)
        - [Easy Load Method](#easy-load-method)
        - [Alternative Load Method](#alternative-load-method)

# About

These are utility files I made to make it easier to save and load from checkpoints in my playthroughs of [Kura5](https://chickenhat.itch.io/kura5-bonds-of-the-undying). If you have any questions, comments, or complaints, contact @kodedile on [Twitter](https://twitter.com/kodedile) or [Github](https://github.com/kodedile)

# Known Limitations

- developed for Windows systems
- does not prompt user when arguments are missing
- if you save a file with `save 3 file` then to load it you need to do `load slot3_file`

# Set Up 

Extract the files from the [master zip archive](https://github.com/kodedile/SaveDataScripts/archive/refs/heads/master.zip) or download the specific files you want.

I recommend putting the three scripts in the Kura5 root directory. If you have more than one Kura5 directory (for different versions), make copies of the scripts for each of those root directories.  Then you will need to adjust the file paths variables accordingly (see [File Paths](#file-paths)).

If you just want to use one of my sample saves, you can put the save file anywhere and use the `load.bat` script to load it into a Kura5 game. See [Load Data](#load-data) for more information.

## Recommended Directory Structure

```
Kura5_Builds/
    Kura5_version/
        Kura5_Data/
            save.bok
	    ...
        Kura5.exe
        load.bat
        save.bat
        UnityPlayer.dll
        ...
    Save_Files/
        version/
	    first run/
	        slot1_start.bok
	        slot1_end.bok
		...
	    second run/
	        slot2_start.bok
	        slot2_end.bok
		...
	    ...
	sample.bok
	...
```

## File Paths

To get these scripts to work with your filesystem, open them in a plain text editor (notepad, notepad++, etc.) and change the following:

### Local Variable: SaveFolder

**Default**: `SET SaveFolder=%cd%\..\Save_Files\VERSION` (save.bat and load.bat)

Used in `save.bat` and `load.bat` to find your save folder.  You will want to modify these so that `VERSION` is the Kura5 version from which your save file was created.

If you do not follow the [Recommended Directory Structure](#recommended-directory-structure), then you will need to change the `\..\Save_Files\VERSION` so that the path matches your structure.

### Local Variable: DataFolder

**Default**: `SET DataFolder=%cd%\Kura5_Data` (save.bat and load.bat)

Used to find the `Kura5_Data` folder where the game keeps `save.bok`.  You can leave this unchanged unless you are not following the [Recommended Directory Structure](#recommended-directory-structure).

### Local Variable: LogFolder

**Default**: `Set LogFolder=C:\Users\USERNAME\AppData\LocalLow\Kura5 Devs\Kura5` (save.bat)

Used in `save.bat` to find the `output_log.txt` needed for debugging. You should only need to change `USERNAME` to your system username, unless your path is different.

# How To Use

## Save Data

1.  Open a command prompt. If you don't know where it is, type `cmd` in the Windows search bar.
2.  In the command prompt window, type `cd C:\Users\USERNAME\path\to\Kura5_VERSION` to change into the directory containing your Kura5.exe and save.bat script.
3.  Type `kura5` to run Kura5.exe
4.  Start the game and choose a save slot to play (make sure you remember which number it is!)
5.  Talk to Nero the cat to save your play
6.  Back in the command prompt window, Type `save N folder/filename` where `N` is the save slot (1, 2, 3, or 4) and `folder/name` is where you want to save your file (assumes the files match the paths specified in the local variable, see [Set Up](#set-up))
    1.  If you are asked to confirm a file overwrite, you may have forgotten to change the filename for your new save.
    2.  Type `n` and press `ENTER` to cancel.
    3.  You may also be asked about overwriting the log file of the same name, in which case type `n` and press `ENTER` to cancel again.
    4.  After canceling, try running `save N folder/new-filename` where `N` is the save slot (1, 2, 3, or 4)

### Examples
- `save 3 daylight/wadjet`
    - saves the data from Slot 3 (`Kura5_Data/save3.bok`) into the location `Save_Files/VERSION/daylight/slot3_wadjet.bok`
    - saves the output log into the location `Save_Files/VERSION/daylight/log_slot3_wadjet.bok`
- `save "daylight run/first attempt/wadjet"`
    - saves the data from Slot 1 (`Kura5_Data/save.bok`) into the location `Save_Files/VERSION/daylight run/first attempt/slot1_wadjet.bok`
    - saves the output log into the location `Save_Files/VERSION/daylight run/first attempt/slot1_wadjet.bok`
    - if N is not specified, it assumes you want Slot 1
    - if your folder names have spaces, use "double quotes" to capture your path
- `save 0 test`
    - saves the output log into the location `Save_Files/VERSION/daylight/log_test.bok`
    - if you put 0, then only the output log is saved

## Load Data

### Easy Load Method

NOTE: This method will overwrite Game Slot 1 if your filename doesn't start with `slotN_` (ex: `slot2_file.bok` will use Game Slot 2)

1.  If playing Kura5, return to the `Main Menu` or `Quit Game`
2.  Drag and drop a single `Save_Files/VERSION/filename.bok` onto `load.bat`
    1.  If overwriting an existing file (like `Kura5_Data/save.bok`) you will be asked to confirm the overwrite. 
    2.  Type `y` and press `ENTER` to confirm if you no longer need the data in the game slot. Otherwise, type `n` and press `ENTER` to cancel.
3.  Back in Kura5, start the game and choose the same slot N (1, 2, 3, or 4) that you loaded your game into. 

### Examples
- Drag and drop the file `C:\Users\USERNAME\Games\Save_Files\VERSION\slot3_file.bok`
    - loads the file `Save_Files/VERSION/slot3_file.bok` into Game Slot 3 (`Kura5_Data/save3.bok`)
    - Game Slot 3 was chosen because the filename starts with `slot3_`
- Drag and drop the file `C:\Users\USERNAME\Games\Save_Files\VERSION\file.bok`
    - loads the file `Save_Files/VERSION/file.bok` into Game Slot 1 (`Kura5_Data/save.bok`)
    - Game Slot 1 is chosen by default if the filename doesn't start with `slotN_`

### Alternative Load Method

1.  Open a command prompt, if you haven't opened one already. If you don't know where it is, type `cmd` in the Windows search bar.
2.  In the command prompt window, type `cd C:\Users\USERNAME\path\to\Kura5_VERSION` to change into the directory containing your Kura5.exe and load.bat script.
3.  Type `kura5` to run Kura5.exe if it isn't running yet. If playing Kura5, return to the `Main Menu` or `Quit Game`
4.  Back in the command prompt window, Type `load N folder/filename` where `N` is the save slot (1, 2, 3, or 4) and `folder/name` is where you saved your file (assumes the files match the paths specified in the local variable, see [Set Up](#set-up))
    1.  If you are asked to confirm a file overwrite, check that you're loading into the correct slot
    2.  Type `n` and press `ENTER` to cancel if the slot is wrong, otherwise type `y` and press `ENTER` to continue.
5.  Back in Kura5, start the game and choose the same slot N (1, 2, 3, or 4) that you loaded your game into.  

### Examples
- `load 3 daylight/file`
    - loads the file `Save_Files/VERSION/daylight/file.bok` into Game Slot 3 (`Kura5_Data/save3.bok`)
    - if the file can't be found and you know you previously used `save 3 daylight/file`, try `load daylight/slot3_file` 
- `load daylight/slot3_file`
    - loads the file `Save_Files/VERSION/daylight run/first attempt/file.bok` into Game Slot 3 (`Kura5_Data/save3.bok`)
    - if `N` is not specified, it looks for `slotN_` in the filename. In this case, `N` is 3
- `load 2 slot3_file`
    - loads the file `Save_Files/VERSION/slot3_file.bok` into Game Slot 2 (`Kura5_Data/save2.bok`)
    - if your file starts with `slotN_` you can change which slot it will load into by providing the argument `N` (1, 2, 3, or 4)
- `load "daylight run/first attempt/wadjet"`
    - loads the file `Save_Files/VERSION/daylight run/first attempt/wadjet.bok` into Game Slot 1 (`Kura5_Data/save.bok`)
    - if N is not specified and the filename doesn't start with `slotN_`, it assumes you want Game Slot 1 (`Kura5_Data/save.bok`)
    - if your folder names have spaces, use "double quotes" to capture your path
- `load 2 "C:\Users\USERNAME\Games\Save_Files\VERSION\file.bok"`
    - loads the file into Game Slot 2 (`Kura5_Data/save2.bok`)

