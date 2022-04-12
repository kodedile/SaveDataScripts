:: Author: Kodedile
:: Created: March 25, 2022
:: Updated: April 12, 2022
:: Usage: k5
:: Put this file next to "Kura5.exe"
:: Double-click on k5.bat  OR  open command prompt and type k5
:: Makes a copy of the last output log and save files before starting the game.
:: TimeStamp code from https://stackoverflow.com/a/1064648
:: Conditional ErrorLevel checks from https://stackoverflow.com/a/17085933

@ECHO OFF 
SETLOCAL EnableDelayedExpansion

:: directory for data files
SET DataFolder=%USERPROFILE%\AppData\LocalLow\Kura5\Kura5BOTU

:: directory for storing save files
SET SaveFolder=%cd%\Save_Files

:: start by making a snapshot and then prompt to start the game
SET IsInitialSnapshot=true
GOTO Snapshot


:StartGameInitial
	:: start the game for the first time
	SET IsInitialSnapshot=false
	GOTO StartGame

:StartGame
	:: start the game
	ECHO ========================================================================
	TASKLIST /FI "imagename eq Kura5.exe" |find "Kura5.exe" > nul && (
		ECHO Kura5 is already running...
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		ECHO Starting up Kura5...
		START "" "Kura5.exe" && (
			ECHO Kura5 now running... TAIYOOOOOU^!
			:: NOP to ensure success "CALL "
			CALL 
		) || (
			ECHO Unable to start Kura5... 
			ECHO Check that this file is in the same folder as Kura5.exe, and then try again.
			GOTO :EOF
		)
	)
	GOTO RequestCommand


:: Ask user to SAVE, LOAD, or QUIT
:RequestCommand
	ECHO ========================================================================
	ECHO ^>^> What would you like to do? [START^|SAVE^|LOAD^|HELP^|QUIT]
	SET /P ChosenCommand=^>^>^>^>  
	IF /I "%ChosenCommand:~0,5%"=="START" GOTO StartGame
	IF /I "%ChosenCommand:~0,4%"=="SAVE" GOTO ProcessSave
	IF /I "%ChosenCommand:~0,4%"=="LOAD" GOTO ProcessLoad
	IF /I "%ChosenCommand:~0,4%"=="HELP" GOTO ProcessHelp
	IF /I "%ChosenCommand:~0,4%"=="QUIT" GOTO ProcessQuit
	GOTO RequestCommand
	
	
:: =================================================
::     SAVE PROCEDURES
:: =================================================

:: TODO catch errors
:ProcessSave
	ECHO ========================================================================
  ECHO Processing the command: SAVE %ChosenCommand:~5%
	ECHO ------------------------------------------------------------------------
  CALL save.bat %ChosenCommand:~5%
  GOTO RequestCommand

:: -------------------------------------------------
::     Save Snapshot
:: -------------------------------------------------
:Snapshot
	ECHO ========================================================================
	
	:: get timestamp for the save
	SET hours=%TIME:~0,2%
	SET minutes=%TIME:~2,3%
	SET seconds=%TIME:~6%
	SET hours=%hours::=%
	SET minutes=%minutes::=%
	SET TimeStamp=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%-%hours%-%minutes%-%seconds%
	
	:: create the save folder in case it doesn't exist yet
	MKDIR "%SaveFolder%\%TimeStamp%" && (
		ECHO Created a folder at "%SaveFolder%\%TimeStamp%"
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		ECHO Unable to create a folder at "%SaveFolder%\%TimeStamp%"
	)
	
	ECHO Saving a snapshot...
	ECHO ------------------------------------------------------------------------
	
	:: copy log file to save folder
	ECHO Saving "%DataFolder%\output_log.txt" 
	ECHO as "%SaveFolder%\%TimeStamp%\output_log.txt"
	COPY /-Y "%DataFolder%\output_log.txt" "%SaveFolder%\%TimeStamp%\output_log.txt"
	ECHO ------------------------------------------------------------------------
	
	:: copy save file to save folder
	ECHO Saving... "%DataFolder%\save.bok" 
	ECHO as "%SaveFolder%\%TimeStamp%\save.bok"
	COPY /-Y "%DataFolder%\save.bok" "%SaveFolder%\%TimeStamp%\save.bok"
	ECHO ------------------------------------------------------------------------

	ECHO Saving... "%DataFolder%\save2.bok" 
	ECHO as "%SaveFolder%\%TimeStamp%\save2.bok"
	COPY /-Y "%DataFolder%\save2.bok" "%SaveFolder%\%TimeStamp%\save2.bok"
	ECHO ------------------------------------------------------------------------

	ECHO Saving... "%DataFolder%\save3.bok" 
	ECHO as "%SaveFolder%\%TimeStamp%\save3.bok"
	COPY /-Y "%DataFolder%\save3.bok" "%SaveFolder%\%TimeStamp%\save3.bok"
	ECHO ------------------------------------------------------------------------

	ECHO Saving... "%DataFolder%\save4.bok" 
	ECHO as "%SaveFolder%\%TimeStamp%\save4.bok"
	COPY /-Y "%DataFolder%\save4.bok" "%SaveFolder%\%TimeStamp%\save4.bok"	
	ECHO ------------------------------------------------------------------------
	
	ECHO Snapshot saved at "%SaveFolder%\%TimeStamp%"
	IF %IsInitialSnapshot%==true GOTO StartGameInitial
	GOTO RequestCommand

:: =================================================
::     LOAD PROCEDURES
:: =================================================

:: TODO catch errors
:ProcessLoad
	ECHO ========================================================================
  ECHO Processing the command: LOAD %ChosenCommand:~5%
	ECHO ------------------------------------------------------------------------
  CALL load.bat %ChosenCommand:~5%
  GOTO RequestCommand

:: =================================================
::     HELP PROCEDURES  TODO
:: =================================================

:: Ask the user which command to provide help for
:ProcessHelp
	ECHO ========================================================================
	ECHO ^>^> What do you need help with? [START^|SAVE^|LOAD^|QUIT]
	ECHO   (or type BACK to return to the menu)
	SET /P ChosenCommand=^>^>^>^>  
	IF /I "%ChosenCommand%"=="START" GOTO HelpStart
	IF /I "%ChosenCommand%"=="SAVE" GOTO HelpSave
	IF /I "%ChosenCommand%"=="LOAD" GOTO HelpLoad
	IF /I "%ChosenCommand%"=="QUIT" GOTO HelpQuit
	IF /I "%ChosenCommand%"=="BACK" GOTO RequestCommand
	GOTO ProcessHelp


:HelpStart
	ECHO ========================================================================
	ECHO ^>^> About the START command...
	ECHO Description: Opens Kura5.exe if it is not already running.
	ECHO Usage: START
	ECHO ------------------------------------------------------------------------
	GOTO RequestCommand


:HelpSave
	ECHO ========================================================================
	ECHO ^>^> About the SAVE command...
	ECHO Description: Make a copy of your save file, and give it a descriptive name.
	ECHO ------------------------------------------------------------------------
	ECHO Example 1: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 2: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 3: 
	ECHO ------------------------------------------------------------------------
	GOTO RequestCommand

:: TODO does Kura5 need to be closed if we delete all the saves?
:HelpLoad
	ECHO ========================================================================
	ECHO ^>^> About the LOAD command...
	ECHO Description: Load a file into one of the four save slots.
	ECHO Usage: LOAD [slot number] [file path]
	ECHO ------------------------------------------------------------------------
	ECHO Example 1: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 2: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 3: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 4: Load all files from a snapshot
	ECHO Command: LOAD "C:\Users\USERNAME\Games\Kura5_x86_ver05\Kura5_x86\Save_Files\YYYY-MM-DD-hh-mm-ss.ms"
	ECHO Result: Saves a snapshot. Replaces the save files with those in the YYYY-MM-DD-hh-mm-ss.ms folder.
	ECHO Note: Any extra files will be deleted.
	ECHO Note: You can drag-and-drop a folder into the command window instead of typing the path.
	ECHO ------------------------------------------------------------------------
	GOTO RequestCommand


:HelpQuit
	ECHO ========================================================================
	ECHO ^>^> About the QUIT command...
	ECHO Description: Close this program. Optionally, close Kura5 if it is open.
	ECHO Usage: QUIT
	ECHO ------------------------------------------------------------------------
	GOTO RequestCommand
	

:: =================================================
::     QUIT PROCEDURES
:: =================================================

:: Check if Kura5 is running, and if so, prompt user to ask if we can close it
:ProcessQuit
	:: Check if Kura5 is still running
	TASKLIST /FI "imagename eq Kura5.exe" |find "Kura5.exe" > nul && (
		:: Kura5 is currently running...
		GOTO RequestQuit
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		:: Kura5 is not running... safe to exit!
		GOTO QuitSelf
	)


:: Ask user to confirm QUIT of Kura5
:RequestQuit
	ECHO ========================================================================
	ECHO ^>^> Do you wish to stop Kura5 as well? [Y^|N]
	SET /P ShouldQuit=^>^>^>^> 
	IF /I "%ShouldQuit%"=="Y" GOTO QuitKura5
	IF /I "%ShouldQuit%"=="N" GOTO QuitSelf
	GOTO RequestQuit


:: Close Kura5 and stop prompting
:QuitKura5
	ECHO Closing Kura5...
	TASKKILL /F /IM "Kura5.exe" && (
		:: Kura5 quit successfully!
		ECHO Kura5 has been closed. Good-bye.
		GOTO :EOF
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		:: Kura5 could not be quit...
		ECHO Unable to quit Kura5.exe
		ECHO Did you already close Kura5 manually?
		GOTO :EOF
	)

:: Say Good-bye
:QuitSelf
	ECHO Good-bye.
	GOTO :EOF