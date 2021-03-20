@ECHO OFF
SETLOCAL
:: filepath for output log
Set LogFolder=C:\Users\USERNAME\AppData\LocalLow\Kura5 Devs\Kura5
:: directory for Kura5 data files
SET DataFolder=%cd%\Kura5_Data
:: directory for storing save files
SET SaveFolder=%cd%\..\Save_Files\VERSION
:: IF a file was not passed to this script
IF [%1]==[] (
	:: prompt user to specify a save file
	SET /p file= Enter Name for Save File: 
) ELSE (
	:: use the file that was provided to this script
	SET file=%1
)
:: parse the filepath
FOR /f "delims=" %%i IN ("%file%") DO (
	SET FileName=%%~ni
)
:: create the save folder in case it doesn't exist yet
MKDIR "%SaveFolder%"
:: copy data file to save folder
COPY /-Y "%DataFolder%\save.bok" "%SaveFolder%\%FileName%.bok"
:: copy output log file to save folder
COPY /-Y "%LogFolder%\output_log.txt" "%SaveFolder%\log-%FileName%.txt"
