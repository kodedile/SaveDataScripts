:: Author: Kodedile
:: Created: March 25, 2022
:: Updated: March 25, 2022
:: Usage: k5
:: Double-click on k5.bat  OR  run k5 in a command prompt
:: Makes a snapshot of the output log and saves before starting the game.
:: Put this file next to "Kura5.exe" 
:: TimeStamp code from https://stackoverflow.com/a/1064648

@ECHO OFF 
SETLOCAL EnableDelayedExpansion

:: directory for data files
SET DataFolder=C:\Users\%USERNAME%\AppData\LocalLow\Kura5\Kura5BOTU

:: directory for storing save files
SET SaveFolder=%cd%\Save_Files

:: get timestamp for the save
ECHO %TIME%
SET hours=%TIME:~0,2%
SET minutes=%TIME:~2,3%
SET seconds=%TIME:~6%
SET hours=%hours::=%
SET minutes=%minutes::=%
ECHO %hours% %minutes% %seconds%
SET TimeStamp=%DATE:~-4%-%DATE:~4,2%-%DATE:~7,2%-%hours%-%minutes%-%seconds%

:: create the save folder in case it doesn't exist yet
MKDIR "%SaveFolder%\%TimeStamp%"

:: copy log file to save folder
ECHO Saving "%DataFolder%\output_log.txt" as "%SaveFolder%\%TimeStamp%\output_log.txt"
COPY /-Y "%DataFolder%\output_log.txt" "%SaveFolder%\%TimeStamp%\output_log.txt"

:: copy save file to save folder
ECHO Saving... "%DataFolder%\save.bok" as "%SaveFolder%\%TimeStamp%\save.bok"
COPY /-Y "%DataFolder%\save.bok" "%SaveFolder%\%TimeStamp%\save.bok"

ECHO Saving... "%DataFolder%\save2.bok" as "%SaveFolder%\%TimeStamp%\save2.bok"
COPY /-Y "%DataFolder%\save2.bok" "%SaveFolder%\%TimeStamp%\save2.bok"

ECHO Saving... "%DataFolder%\save3.bok" as "%SaveFolder%\%TimeStamp%\save3.bok"
COPY /-Y "%DataFolder%\save3.bok" "%SaveFolder%\%TimeStamp%\save3.bok"

ECHO Saving... "%DataFolder%\save4.bok" as "%SaveFolder%\%TimeStamp%\save4.bok"
COPY /-Y "%DataFolder%\save4.bok" "%SaveFolder%\%TimeStamp%\save4.bok"

:: start the game
ECHO Starting up Kura5...
START "" "Kura5.exe"

PAUSE