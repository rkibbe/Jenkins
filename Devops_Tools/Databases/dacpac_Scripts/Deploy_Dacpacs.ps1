

$Logfile = "c:\temp\my.log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

LogWrite "test"

$user = "Rkibbe"
$pwd = "Katie123"
$server = "$env:computername"
$dbName = "master"
 

 
#$server = $OctopusParameters['DbServerName']
 
Write-Host DbName: $dbName
Write-Host User: $user
Write-Host Server: $server

#Copy-Item -Path .\ERR_1095A.dacpac -Destination c:\ERR_1095A.dacpac
 
# & 'C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe' /Action:Script /OutputPath:Upgrade.sql /SourceFile:c:\temp\dacpacs\ERR_1095A.dacpac /TargetServerName:WIN-3V7Q9J6CKF9\LOCALHOST1 /TargetDatabaseName:master /TargetUser:Rkibbe /TargetPassword:Katie123  /p:IncludeCompositeObjects=true 

 # & 'C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe' /Action:Publish  /SourceFile:c:\temp\dacpacs\crm.dacpac /TargetServerName:WIN-HC7AUALNU8C /TargetDatabaseName:crm /Profile:c:\temp\dacpacs\crm.standard.publish.xml 

 & 'C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe' /Action:Publish  /SourceFile:c:\temp\dacpacs\crm.dacpac /TargetServerName:$server /TargetDatabaseName:crm /Profile:c:\temp\dacpacs\crm.standard.publish.xml /TargetUser:Cognos /TargetPassword:Cognos123 


# & 'C:\Program Files (x86)\Microsoft SQL Server\130\DAC\bin\SqlPackage.exe' /Action:Publish  /SourceFile:master.dacpac /TargetServerName:$server /TargetDatabaseName:$dbName /TargetUser:$user /TargetPassword:$pwd   
