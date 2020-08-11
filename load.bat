::@ECHO OFF
SETLOCAL
:: directory for Kura5 data files
SET DataFolder=%cd%\..\Kura5_Data
:: directory for storing save files
SET SaveFolder=%cd%\Save_Files
:: prompt user to specify a save file
SET /p file= Enter Name of a Save File: 

:: parse the filepath
FOR /f "delims=" %%i IN ("%file%") DO (
	SET FileName=%%~ni
)
:: create the data folder in case it doesn't exist yet
MKDIR "%DataFolder%"
:: copy save file to data folder
COPY "%SaveFolder%\%FileName%.bok" "%DataFolder%\save.bok"