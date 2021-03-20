@ECHO OFF
SETLOCAL
:: location of this script
SET ScriptPath=%~dp0
:: directory for Kura5 data files relative to this script
:: NOTE does not like folders with spaces in the name
SET DataFolder=%ScriptPath:~0,-1%\Kura5_Data
:: IF a file was not opened with this script
IF [%1]==[] (
	:: prompt user to specify a save file
	SET /p file= Enter Name of a Save File: 
) ELSE (
	:: use the file that was opened with (dropped on) this script
	SET file=%1
)
:: parse the filepath
FOR /f "delims=" %%i IN ("%file%") DO (
	SET FileName=%%~ni
)
:: create the data folder in case it doesn't exist yet
MKDIR "%DataFolder%"
:: copy save file to data folder
COPY /-Y "%file%" "%DataFolder%\save.bok"
:: PAUSE
