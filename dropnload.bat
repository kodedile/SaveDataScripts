:: Author: Kodedile
:: Created: June 23, 2021
:: Updated: June 23, 2021
:: Usage: drop your file onto this batch file, and it will load into a save slot
:: Alternative: load.bat [1|2|3|4] [filepath] 
:: Example: dropnload.bat 2 speedrun/daypath/start
::       will load speedrun/daypath/start.bok into save2.bok (slot 2)
:: Note: arguments allowed to be in any order, .bok extension optional
:: Note2: digits other than 1/2/3/4 will default to none and use slot 1
:: Note3: if digit is left out, looks for "slotN_" in the filename (N=1|2|3|4)
:: Note4: if digit is 1, uses the first save slot, which is save.bok
:: Note5: if spaces in filepath, surround filepath with double quotes: "filepath"

@ECHO OFF 
SETLOCAL EnableDelayedExpansion

:: location of this script
SET ScriptPath=%~dp0
:: directory for Kura5 data files relative to this script
SET DataFolder=%ScriptPath:~0,-1%\Kura5_Data
:: directory for storing save files
SET SaveFolder=%cd%\..\Debug_Saves\x86_0621_dev
:: slot number for save file (default to no number)
SET SlotNum=
:: path for save file
SET FilePath=

GOTO ProcessArguments

:ProcessArguments
	:: Start using the variables to load the file
	IF "%~1"=="" GOTO Main
	:: Store the digit as a SlotNum, then recurse
	IF "%~1"=="1" GOTO StoreSlotNum
	IF "%~1"=="2" GOTO StoreSlotNum
	IF "%~1"=="3" GOTO StoreSlotNum
	IF "%~1"=="4" GOTO StoreSlotNum
	:: Ignore arg if any other digit is provided
	IF "%~1"=="5" GOTO InvalidSlotNum
	IF "%~1"=="6" GOTO InvalidSlotNum
	IF "%~1"=="7" GOTO InvalidSlotNum
	IF "%~1"=="8" GOTO InvalidSlotNum
	IF "%~1"=="9" GOTO InvalidSlotNum
	IF "%~1"=="0" GOTO InvalidSlotNum
	:: Store any other value as filepath, then recurse
	SET FilePath=%~1
	SHIFT
	GOTO ProcessArguments


:Main
	::parse the filepath
	FOR /F "delims==" %%f IN ("%FilePath%") DO (
		SET File=%%~f
		SET FileName=%%~nf
		SET PathToFile=%%~dpf
	)
	:: make the folder path relative
	SET CurrentDir=%cd%
	CALL SET FolderPath=%%PathToFile:!CurrentDir!=%%
	
	SET SaveFile=%File%
	
	:: if no drive letter in provided path, use relative
	IF NOT "%FilePath:~1,1%"==":" (
		SET SaveFile=%SaveFolder%%FolderPath%%FileName%.bok
	)

	::check the slot number
	IF "%SlotNum%"=="" (
		IF "%FileName:~0,6%"=="save1_" SET SlotNum=1
		IF "%FileName:~0,6%"=="save2_" SET SlotNum=2
		IF "%FileName:~0,6%"=="save3_" SET SlotNum=3
		IF "%FileName:~0,6%"=="save4_" SET SlotNum=4
	)
	IF "%SlotNum%"=="1" GOTO LoadSlot1
	
	:: create the data folder in case it doesn't exist yet
	MKDIR "%DataFolder%"
	
	:: copy save file to data folder
	COPY /-Y "%SaveFile%" "%DataFolder%\save%SlotNum%.bok"
	ECHO Loaded "%SaveFile%" into slot "%DataFolder%\save%SlotNum%.bok"
	
	GOTO EndWithPause


:StoreSlotNum
	SET SlotNum=%~1
	SHIFT
	GOTO ProcessArguments


:InvalidSlotNum
	SHIFT
	GOTO ProcessArguments


:LoadSlot1
	:: copy save file to data folder
	COPY /-Y "%SaveFile%" "%DataFolder%\save.bok"
	ECHO Loaded "%SaveFile%" into slot "%DataFolder%\save.bok"
	GOTO EndWithPause


:EndWithPause
@PAUSE
