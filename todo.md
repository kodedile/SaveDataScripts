## Next on the list:

- load an entire snapshot into the game
- name the snapshot (instead of just a timestamp)
- prompt for save/load arguments if none are provided
  - [x] load.bat default slot parameter is 1
  - [x] save.bat default filename is current timestamp

## Maybe on the list:

- show the current slot info at the end of a command
- watch files and prompt for save if anything changes
- [x] prompt for path to Kura5.exe if failed to find on start up
- make the prompt less scary (disable error dialogue)

## Misc:

- [x] more feedback about currently running version
- [x] put snapshots in subdirectory
- [x] separate folder for logs and backups
- [x] backup slot files before loading an overwrite
- [x] log actions to text file for streaming updates
- [x] read version for Kura5Folder from Save_Files/Kura5Version.txt if available
- use a config.txt file to set paths for Data, Save, and Kura5
- check if folders in save.bat/load.bat were already set by k5.bat