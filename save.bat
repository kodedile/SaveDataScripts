:: Author: Kodedile
:: Created: June 23, 2021
:: Updated: June 16, 2022
:: Usage: save.bat [0 | 1 | 2 | 3 | 4] [filepath] 
:: Example: save.bat 2 speedrun/daypath/start
::       will save the following:
::             save2.bok into speedrun/daypath/start.bok
::             output_log.txt into speedrun/daypath/log_slot2_start.txt
:: Note: arguments allowed to be in any order, .bok extension optional
:: Note2: digits other than 0/1/2/3/4 will default to 1 (save.bok)
:: Note3: if digit is left out, it will default to 1 (save.bok)
:: Note4: if digit is 0, it only saves the output log
:: Note5: if no save file exists for 1/2/3/4, it only saves the output log
:: Note6: if spaces in filepath, surround filepath with double quotes: "filepath"

@ECHO OFF 
SETLOCAL EnableDelayedExpansion

:: directory for Kura5 data files
SET DataFolder=%USERPROFILE%\AppData\LocalLow\Kura5\Kura5BOTU
:: directory for storing save files
SET SaveFolder=%cd%\Save_Files
:: slot number for save file (default to 1)
SET SlotNum=1
:: path for save file
SET FilePath=

GOTO ProcessArguments

:ProcessArguments
	:: Start using the variables to save the file
	IF "%~1"=="" GOTO Main
	:: Store the digit as a SlotNum, then recurse
	IF "%~1"=="0" GOTO StoreSlotNum
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
	:: Store any other value as filepath, then recurse
	SET FilePath=%~1
	SHIFT
	GOTO ProcessArguments


:Main
	:: get timestamp for the log file
	SET hours=%TIME:~0,2%
	SET minutes=%TIME:~2,3%
	SET seconds=%TIME:~6%
	SET hours=%hours::=%
	SET minutes=%minutes::=%
	SET TimeStamp=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%-%hours%-%minutes%-%seconds%

	:: create the save folder in case it doesn't exist yet
	MKDIR "%SaveFolder%\.logs" && (
		ECHO Creating a log folder at "%SaveFolder%\.logs"
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		ECHO Unable to create a log folder at "%SaveFolder%\.logs"
	)

	:: set default name to timestamp
	IF [%FilePath%]==[] SET FilePath=%TimeStamp%.bok

	:: parse the filepath
	FOR /F "delims==" %%f IN ("%FilePath%") DO (
		SET FileName=%%~nf
		SET PathToFile=%%~dpf
	)
	:: make the folder path relative
	SET CurrentDir=%cd%
	CALL SET FolderPath=%%PathToFile:!CurrentDir!=%%
	SET SavePath=%SaveFolder%%FolderPath%
	
	:: create the save folder in case it doesn't exist yet
	MKDIR "%SavePath%"
	
	IF "%SlotNum%"=="0" GOTO SaveOutputOnly
	IF "%SlotNum%"=="1" GOTO SaveSlot1
	
	:: copy data file to save folder
	COPY /-Y "%DataFolder%\save%SlotNum%.bok" "%SavePath%%FileName%.bok"
	ECHO Saved "%DataFolder%\save%SlotNum%.bok" as "%SavePath%%FileName%.bok"
	
	:: copy output log file to save folder
	COPY /-Y "%DataFolder%\output_log.txt" "%SavePath%.logs/slot%SlotNum%_%FileName%.txt"
	ECHO Saved log file as "%SavePath%.logs/slot%SlotNum%_%FileName%.txt"
	
	ECHO Copied slot %SlotNum% into "%FileName%.bok" > "%SaveFolder%\Kura5LastSaved.txt"

	GOTO :EOF


:StoreSlotNum
	SET SlotNum=%~1
	SHIFT
	GOTO ProcessArguments


:InvalidSlotNum
	SHIFT
	GOTO ProcessArguments


:SaveOutputOnly 
	:: copy output log file to save folder
	COPY /-Y "%DataFolder%\output_log.txt" "%SavePath%.logs/%FileName%.txt"
	ECHO Saved log file as "%SavePath%.logs/%FileName%.txt"
	ECHO Copied output log into ".logs/%FileName%.txt" > "%SaveFolder%\Kura5LastSaved.txt"
	GOTO :EOF


:SaveSlot1
	:: copy data file to save folder
	COPY /-Y "%DataFolder%\save.bok" "%SavePath%%FileName%.bok"
	ECHO Saved "%DataFolder%\save.bok" as "%SavePath%%FileName%.bok"
	
	:: copy output log file to save folder
	COPY /-Y "%DataFolder%\output_log.txt" "%SavePath%.logs/slot%SlotNum%_%FileName%.txt"
	ECHO Saved log file as "%SavePath%.logs/slot%SlotNum%_%FileName%.txt"
	
	ECHO Copied slot %SlotNum% into "%FileName%.bok" > "%SaveFolder%\Kura5LastSaved.txt"
	
	GOTO :EOF
