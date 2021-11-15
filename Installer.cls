Include %occInclude

Class BackupChecker.Installer
{

ClassMethod restoreAll(backupFile) As %Status [ PublicList = (INPDEV, TopDir, RESTYPE, QUIETMODE, ALLOWUPD, JRNOPT) ]
{

  Set INPDEV = "/ISC/utiles/Backup/"_backupFile
  if ##class(%File).Exists(INPDEV){
    Do ..LogToConsole("Starting to restore the Backup... It will take some time, be patient!")
    
    Set TopDir="/ISC/utiles/Restore/"
    Set RESTYPE="ALL"
    Set QUIETMODE=1,ALLOWUPD=0,JRNOPT=4 
    Do BEGIN^DBREST
    
    Do ..LogToConsole("Restored completed!")
    Do ..LogToConsole("Starting the Integrity report")
    
    // Do the integrity Check
    //Do Silent^Integrity("/ISC/utiles/Restore/integrity.log")
    Set sc=$$CheckList^Integrity(,,,,10)
    Do Display^Integrity(,2,1)

    if $system.Status.IsOK(sc) {
      Do ..LogToConsole("Run successfully and found NO errors! Databases are VALIDATED!")  
    }elseif ($system.Status.GetErrorCodes(sc)=$$$ERRORCODE($$$IntegrityCheckErrors)){
      Do ..LogToConsole("Run successfully, but found ERRORS!!!!. Review the log for details!")     
    }else{
      Do ..LogToConsole(" Error executing the Integrity checker. Error: "_$system.Status.GetErrorCodes(sc))        
    }
  }else {
    Do ..LogToConsole("The backup file "_INPDEV_" does not exists. Please make sure there is a backup file in the /Backup directory called "_backupFile)
    
  }

  
  
  quit $$$OK
}

/// Description
ClassMethod LogToConsole(message) As %Status
{
  // Write to the current device
  Write !,message

  // Write to the messages.log
  d ##class(%SYS.System).WriteToConsoleLog("**************************************************************************************************")
  d ##class(%SYS.System).WriteToConsoleLog("*** BackupChecker:"_message_" ***")
  d ##class(%SYS.System).WriteToConsoleLog("***************************************************************************************************")
  Return $$$OK
}

}
