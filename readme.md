# Backup Checker
Working in support I usually get asked how many days should I keep journals. Should it be 2 days or after 2 backups? more? less?

Unless you have a Mirror environment, the right answer is that you should keep the journals since the last validated Backup. I.e, until you don't check if a Backup is valid (restoring the file and checking with the Integrity utility) you can't be sure there is a valid copy of your data and can't purge safely the journals.

When I explain this, most of the administrators consider this is a complex task, which takes a lot of time and can't be automated, so I decided to build this super simple Backup checker/validator that helps you validate Backups easily and can be improved to send emails, create a report file, etc...

So, this utility is a simple Backup checker/validator for Backups done with InterSystems Iris. It will restore automatically your Backup file (.cbk) and will run an integrity report afterward.

Once the Backup has been restored and the Integrity check run, the docker log (and messages.log) will contain the restore and integrity check results. The databases restored will appear in a Restore folder.

## Requirements
- docker & docker-compose
- Iris backup file (FullDatabases.cbk)
- Enough space to restore the backup!
## How to

Clone/git pull the repo into any local directory

```
git clone https://github.com/mariosanchez23/backupChecker.git
```
Add your Iris online backup file (.cbk) inside the Backup directory. Rename the backup file to "backup.cbk". If you want to use a different name, look at the docker-compose.yml and change the environment variable. 

Start the docker instance and watch the logs: 
```
docker-compose up
```

If you want to repeat the check with another backup, replace the backup file and call the "cleanStart.sh" script 
 ``` 
 ./cleanStart.sh
 ```
This script is a simple script that stops, removes previous restore and data and starts a new backup check. See: 

``` 
docker-compose down
rm -Rf iris
rm -Rf Restore
docker-compose up
``` 

## Notes

- You can't validate Caché/Ensemble backups with this utility as it uses Iris, which does not support restoring backups from Caché/Ensemble. If you want to validate Caché or Ensemble backups, feel free to use the Installer class method and import it in a Caché/Ensemble instance and run it from there.

- You can edit the class Installer.cls to add your own code to email the results, create a file, etc... I wanted to keep the script as simple as possible. 

- You can edit the cleanStart.sh script to automate the copy of your original backup file and start the process.

- Have in mind that restoring a big file will take a lot of time. The Integrity report will run with paralell process to complete faster, but will also take time. So once you run the checker, take a coffee, go for a walk and come back to see the results. The results are in the messages.log and also in the terminal or docker log. 

## Demo

This is a quick video of what you get (short video)
![demoshort](https://user-images.githubusercontent.com/1133750/141358621-5bed5d60-9428-491d-a0dd-ed6487e87dfd.gif)


