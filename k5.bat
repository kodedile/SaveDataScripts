:: Author: Kodedile
:: Created: March 25, 2022
:: Updated: June 14, 2022
:: Usage: k5
:: Put this file next to "Kura5.exe"
:: Double-click on k5.bat  OR  open command prompt and type k5
:: Makes a copy of the last output log and save files before starting the game.
:: TimeStamp code from https://stackoverflow.com/a/1064648
:: Conditional ErrorLevel checks from https://stackoverflow.com/a/17085933

@ECHO OFF 
SETLOCAL EnableDelayedExpansion

TITLE Kura5 Save Utility (unofficial) - by kodedile

:: directory for data files
SET DataFolder=%USERPROFILE%\AppData\LocalLow\Kura5\Kura5BOTU

:: directory for storing save files
SET SaveFolder=%cd%\Save_Files

:: directory for Kura5.exe, for example:  \Kura5_x86_64_ver042\Kura5_x86
SET Kura5Folder=%cd%

:: provide some welcome message before starting up
ECHO ========================================================================
ECHO ^|^|********************************************************************^|^|
ECHO ^|^|--------------------------------------------------------------------^|^|
ECHO ^|^|           Welcome to the (unofficial) Kura5 Save Utility!           ^|^|
ECHO ^|^|    ^If you have questions or comments, please contact ^@Kodedile     ^|^|
ECHO ^|^|--------------------------------------------------------------------^|^|
ECHO ^|^|********************************************************************^|^|

:: LET'S BEGIN!
GOTO ProcessStartGame

:ProcessStartGame
  ECHO ========================================================================
  ECHO Beginning Startup Procedure:  Save Snapshot, Slot Info, Start Kura5
  ECHO ------------------------------------------------------------------------
  ECHO The Kura5 folder is currently set to %Kura5Folder%
  :: Take a snapshot, then show slot info, and finally start the game
  SET CalledForGameStart=true
  GOTO Snapshot

:StartGame
	IF %CalledForGameStart%==true SET CalledForGameStart=false
	:: check if we need to start the game
	ECHO ========================================================================
	TASKLIST /FI "imagename eq Kura5.exe" |find "Kura5.exe" > nul && (
		ECHO Kura5 is already running...
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		ECHO Starting up Kura5...
		START "" "%Kura5Folder%\Kura5.exe" && (
			ECHO Kura5 is now running... TAIYOOOOOU^!
			:: NOP to ensure success "CALL "
			CALL 
		) || (
			ECHO ------------------------------------------------------------------------
			ECHO Unable to start Kura5... 
			ECHO Check that this file is in the same folder as Kura5.exe, or
			ECHO Provide a path to Kura5.exe, like "Kura5_x86_64_ver042\Kura5_x86"
			SET /P Kura5FolderPrompt=^>^>^>^>
			GOTO :StartGameFolderCheck
		)
	)
	GOTO RequestCommand

:: Check user input for Kura5Folder
:StartGameFolderCheck
	::ECHO user provided %Kura5FolderPrompt%
	IF /I "%Kura5FolderPrompt%"=="QUIT" GOTO ProcessQuit
	SET Kura5Folder=%Kura5FolderPrompt%
	ECHO ------------------------------------------------------------------------
	ECHO Attempting to start %Kura5Folder%\Kura5.exe...
	GOTO :StartGame

:: Ask user to SAVE, LOAD, or QUIT
:RequestCommand
	ECHO ========================================================================
	ECHO ^>^> What would you like to do? [START^|SAVE^|LOAD^|INFO^|HELP^|QUIT]
	SET /P ChosenCommand=^>^>^>^>  
	IF /I "%ChosenCommand:~0,5%"=="START" GOTO ProcessStartGame
	IF /I "%ChosenCommand:~0,4%"=="SAVE" GOTO ProcessSave
	IF /I "%ChosenCommand:~0,4%"=="LOAD" GOTO ProcessLoad
	IF /I "%ChosenCommand:~0,4%"=="INFO" GOTO ProcessInfo
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
		ECHO Creating a snapshot at "%SaveFolder%\%TimeStamp%"
		:: NOP to ensure success "CALL "
		CALL 
	) || (
		ECHO Unable to create a folder at "%SaveFolder%\%TimeStamp%"
	)
	
	ECHO ------------------------------------------------------------------------
	
	:: copy log file to save folder
	::ECHO Saving "%DataFolder%\output_log.txt" 
	::ECHO as "%SaveFolder%\%TimeStamp%\output_log.txt"
  ECHO Copying output_log.txt
	COPY /-Y "%DataFolder%\output_log.txt" "%SaveFolder%\%TimeStamp%\output_log.txt"
	::ECHO ------------------------------------------------------------------------
	
	:: copy save file to save folder
	::ECHO Saving... "%DataFolder%\save.bok" 
	::ECHO as "%SaveFolder%\%TimeStamp%\save.bok"
  ECHO Copying save.bok
	COPY /-Y "%DataFolder%\save.bok" "%SaveFolder%\%TimeStamp%\save.bok"
	::ECHO ------------------------------------------------------------------------

	::ECHO Saving... "%DataFolder%\save2.bok" 
	::ECHO as "%SaveFolder%\%TimeStamp%\save2.bok"
  ECHO Copying save2.bok
	COPY /-Y "%DataFolder%\save2.bok" "%SaveFolder%\%TimeStamp%\save2.bok"
	::ECHO ------------------------------------------------------------------------

	::ECHO Saving... "%DataFolder%\save3.bok" 
	::ECHO as "%SaveFolder%\%TimeStamp%\save3.bok"
  ECHO Copying save3.bok
	COPY /-Y "%DataFolder%\save3.bok" "%SaveFolder%\%TimeStamp%\save3.bok"
	::ECHO ------------------------------------------------------------------------

	::ECHO Saving... "%DataFolder%\save4.bok" 
	::ECHO as "%SaveFolder%\%TimeStamp%\save4.bok"
  ECHO Copying save4.bok
	COPY /-Y "%DataFolder%\save4.bok" "%SaveFolder%\%TimeStamp%\save4.bok"	
	ECHO ------------------------------------------------------------------------
	
	::ECHO Snapshot saved at "%SaveFolder%\%TimeStamp%"
  ECHO Successfully saved the current snapshot!
	IF %CalledForGameStart%==true GOTO ProcessInfo
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
  ::     INFO PROCEDURES  TODO
  :: =================================================

:: Tell the user information about the current save slots
:ProcessInfo
  SET SlotDate1="empty"
  SET SlotDate2="empty"
  SET SlotDate3="empty"
  SET SlotDate4="empty"
  IF EXIST "%DataFolder%\save.bok" FOR %%f IN ("%DataFolder%\save.bok") DO SET SlotDate1=%%~tf
  IF EXIST "%DataFolder%\save2.bok" FOR %%f IN ("%DataFolder%\save2.bok") DO SET SlotDate2=%%~tf
  IF EXIST "%DataFolder%\save3.bok" FOR %%f IN ("%DataFolder%\save3.bok") DO SET SlotDate3=%%~tf
  IF EXIST "%DataFolder%\save4.bok" FOR %%f IN ("%DataFolder%\save4.bok") DO SET SlotDate4=%%~tf
	ECHO ========================================================================
  ECHO The current Kura5 save slots were last modified at the following times:
  ECHO ------------------------------------------------------------------------
  ECHO SLOT 1:  %SlotDate1%
  ECHO SLOT 2:  %SlotDate2%
  ECHO SLOT 3:  %SlotDate3%
  ECHO SLOT 4:  %SlotDate4%
  ECHO ------------------------------------------------------------------------
  ECHO The Kura5 folder is currently set to %Kura5Folder%
  IF %CalledForGameStart%==true GOTO StartGame
  GOTO RequestCommand


:: =================================================
::     HELP PROCEDURES  TODO
:: =================================================

:: Ask the user which command to provide help for
:ProcessHelp
	ECHO ========================================================================
	ECHO ^>^> What do you need help with? [START^|SAVE^|LOAD^|INFO^|QUIT]
	ECHO   (or type BACK to return to the menu)
	SET /P ChosenCommand=^>^>^>^>  
	IF /I "%ChosenCommand%"=="START" GOTO HelpStart
	IF /I "%ChosenCommand%"=="SAVE" GOTO HelpSave
	IF /I "%ChosenCommand%"=="LOAD" GOTO HelpLoad
	IF /I "%ChosenCommand%"=="INFO" GOTO HelpInfo
	IF /I "%ChosenCommand%"=="QUIT" GOTO HelpQuit
	IF /I "%ChosenCommand%"=="BACK" GOTO RequestCommand
	GOTO ProcessHelp


:HelpStart
	ECHO ========================================================================
	ECHO ^>^> About the START command...
	ECHO Description: Opens Kura5.exe if it is not already running.
  ECHO Note: Before starting Kura5, it saves a snapshot and shows the slot info.
	ECHO Usage: START
	ECHO ------------------------------------------------------------------------
	GOTO RequestCommand


:HelpSave
	ECHO ========================================================================
	ECHO ^>^> About the SAVE command...
	ECHO Description: Make a copy of your save file, and give it a name.
  ECHO Usage: SAVE [slot number] [file path]
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
  ECHO Note: You can drag-and-drop a file instead of typing the whole path.
	ECHO ------------------------------------------------------------------------
	ECHO Example 1: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 2: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 3: 
	ECHO ------------------------------------------------------------------------
	ECHO Example 4: (WIP) Load all files from a folder (or snapshot)
	ECHO Command: LOAD "C:\Users\USERNAME\Games\Kura5\Save_Files\FOLDERNAME"
	ECHO Result: Deletes all the save files from the AppData folder. Then copies the save.bok, save2.bok, save3.bok, and save4.bok from the provided folder.
	ECHO ------------------------------------------------------------------------
	GOTO RequestCommand

:HelpInfo
  	ECHO ========================================================================
  	ECHO ^>^> About the INFO command...
  	ECHO Description: See when the current save slots were last modified.
  	ECHO Usage: INFO
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