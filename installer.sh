iris session $ISC_PACKAGE_INSTANCENAME -U %SYS << END
do \$SYSTEM.OBJ.Load("/ISC/utiles/Installer.cls", "ck") \
do ##class(BackupChecker.Installer).restoreAll("$IRIS_backupFileName") \
halt
END

