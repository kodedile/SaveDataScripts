@ECHO OFF
SETLOCAL
:: directory for Kura5 data files
SET DataFolder=%cd%\..\Kura5_Data
:: directory for storing save files
SET SaveFolder=%cd%\Save_Files
:: prompt user to name the save file
SET /p FileName= Enter Name for Save File: 
:: create the save folder in case it doesn't exist yet
MKDIR "%SaveFolder%"
:: copy data file to save folder
COPY "%DataFolder%\save.bok" "%SaveFolder%\%FileName%.bok"