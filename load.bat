:: Author: Kodedile
:: Created: June 23, 2021
:: Updated: June 16, 2022
:: Usage: load.bat [1 | 2 | 3 | 4] [filepath] 
:: Example: load.bat 2 speedrun/daypath/start
::       will load speedrun/daypath/start.bok into save2.bok (slot 2)
:: Note: arguments allowed to be in any order, .bok extension optional
:: Note2: digits other than 1/2/3/4 will default to none and use slot 1
:: Note3: if digit is left out, attempts to parse a slot number from the filename
:: Note4: if digit is 1, uses the first save slot, which is save.bok
:: Note5: if spaces in filepath, surround filepath with double quotes: "filepath"

@ECHO OFF 
SETLOCAL EnableDelayedExpansion

:: directory for Kura5 data files
SET DataFolder=%USERPROFILE%\AppData\LocalLow\Kura5\Kura5BOTU
:: directory for storing save files
SET SaveFolder=%cd%\Save_Files
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
		IF "%FileName:~0,6%"=="slot1_" SET SlotNum=1
		IF "%FileName:~0,6%"=="slot2_" SET SlotNum=2
		IF "%FileName:~0,6%"=="slot3_" SET SlotNum=3
		IF "%FileName:~0,6%"=="slot4_" SET SlotNum=4
	)
	
	:: create the data folder in case it doesn't exist yet
	MKDIR "%DataFolder%"
	
	:: get timestamp for the backup save
	SET hours=%TIME:~0,2%
	SET minutes=%TIME:~2,3%
	SET seconds=%TIME:~6%
	SET hours=%hours::=%
	SET minutes=%minutes::=%
	SET TimeStamp=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%-%hours%-%minutes%-%seconds%
	
	:: create the save folder in case it doesn't exist yet
	MKDIR "%SaveFolder%\.backup" && (
		ECHO Creating a backup folder at "%SaveFolder%\.backup"
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		ECHO Unable to create a backup folder at "%SaveFolder%\.backup"
	)
	
	::ECHO %FileName%
	::ECHO %FilePath%
	::ECHO %File%
	::ECHO %PathToFile%
	::ECHO %SaveFile%
	:: Removes path in SaveFolder from string
	SET ShortFilePath=!SaveFile:%USERPROFILE%\=!
	SET ShortFilePath=!ShortFilePath:%SaveFolder%=!
	
	IF "%SlotNum%"=="1" GOTO BackUpSlot1
	IF "%SlotNum%"=="" GOTO BackUpSlot1
	GOTO BackUpSlotN


:StoreSlotNum
	SET SlotNum=%~1
	SHIFT
	GOTO ProcessArguments


:InvalidSlotNum
	SHIFT
	GOTO ProcessArguments


:BackUpSlot1
	ECHO Copying slot 1 to a backup file
	COPY /-Y "%DataFolder%\save.bok" "%SaveFolder%\.backup\save-%TimeStamp%.bok"
	GOTO LoadSlot1


:BackUpSlotN
	ECHO Copying slot %SlotNum% to a backup file
	COPY /-Y "%DataFolder%\save%SlotNum%.bok" "%SaveFolder%\.backup\save%SlotNum%-%TimeStamp%.bok"
	GOTO LoadSlotN


:LoadSlot1
	:: copy save file to data folder
	COPY /-Y "%SaveFile%" "%DataFolder%\save.bok"
	ECHO Loaded "%SaveFile%" into slot "%DataFolder%\save.bok"
	ECHO Loaded slot 1 with %ShortFilePath% > "%SaveFolder%\Kura5LastSaved.txt"
	GOTO :EOF


:LoadSlotN
	:: copy save file to data folder
	COPY /-Y "%SaveFile%" "%DataFolder%\save%SlotNum%.bok"
	ECHO Loaded "%SaveFile%" into slot "%DataFolder%\save%SlotNum%.bok"
	ECHO Loaded slot %SlotNum% with %ShortFilePath% > "%SaveFolder%\Kura5LastSaved.txt"
	GOTO :EOF