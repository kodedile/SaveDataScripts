@ECHO OFF
SETLOCAL
:: directory for Kura5 data files is one directory above current
SET DataFolder=%cd%\..\..\Kura5_Data
:: directory for storing save files is current directory
SET SaveFolder=%cd%
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
COPY "%SaveFolder%\%FileName%.bok" "%DataFolder%\save.bok"
:: PAUSE