

$Logfile = "c:\temp\my1.log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

LogWrite "test"



$Logfile = "c:\temp\ispac.log"

Function LogWrite
{
   Param ([string]$logstring)

   Add-content $Logfile -value $logstring
}

LogWrite "test"

$user = "octopussql"
$pwd = "9F3m#y37Wi"
#$server = "10.81.88.237"
 

 

$ProjectFilePath = "C:\temp\ispacs\1095A_SqlServer.ispac"
$ProjectName = "1095A_SqlServer"
$FolderName = "1095A_SqlServer"
$EnvironmentName = "1095A_SqlServer"
 
# Load the IntegrationServices Assembly
[System.Reflection.Assembly]::LoadWithPartialName("Microsoft.SqlServer.Management.IntegrationServices") | Out-Null;
 
# Store the IntegrationServices Assembly namespace to avoid typing it every time
$ISNamespace = "Microsoft.SqlServer.Management.IntegrationServices"
 
Write-Host "Connecting to server ..."
 LogWrite  "Connecting to server ..."

# Create a connection to the server
$sqlConnectionString = "Data Source=WIN-ATGO5HINKLO;Initial Catalog=master;Integrated Security=SSPI;"
$sqlConnection = New-Object System.Data.SqlClient.SqlConnection $sqlConnectionString
 
# Create the Integration Services object
$integrationServices = New-Object $ISNamespace".IntegrationServices" $sqlConnection
 
Write-Host "Removing previous catalog ..."
 LogWrite "Removing previous catalog ..."

# Drop the existing catalog if it exists
if ($integrationServices.Catalogs.Count -gt 0) { $integrationServices.Catalogs["SSISDB"].Drop() }
 
Write-Host "Creating new SSISDB Catalog ..."
 LogWrite "Creating new SSISDB Catalog ..."

# Provision a new SSIS Catalog
$catalog = New-Object $ISNamespace".Catalog" ($integrationServices, "SSISDB", "SUPER#secret1")
$catalog.Create()
 
Write-Host "Creating Folder " $FolderName " ..."
 LogWrite "Creating Folder " $FolderName " ..."

# Create a new folder
$folder = New-Object $ISNamespace".CatalogFolder" ($catalog, $FolderName, "Folder description")
$folder.Create()
 
Write-Host "Deploying " $ProjectName " project ..."
 LogWrite "Deploying " $ProjectName " project ..."

# Read the project file, and deploy it to the folder
[byte[]] $projectFile = [System.IO.File]::ReadAllBytes($ProjectFilePath)
$folder.DeployProject($ProjectName, $projectFile)
 
Write-Host "Creating environment ..."
 LogWrite
$environment = New-Object $ISNamespace".EnvironmentInfo" ($folder, $EnvironmentName, "Description")
$environment.Create()
 
Write-Host "Adding server variables ..."
 LogWrite  "Adding server variables ..."

# Adding variable to our environment
# Constructor args: variable name, type, default value, sensitivity, description
$environment.Variables.Add(“CustomerID”, [System.TypeCode]::String, "C111", "false", "Customer ID")
$environment.Variables.Add(“FtpUser”, [System.TypeCode]::String, $EnvironmentName, "false", "FTP user")
$environment.Variables.Add(“FtpPassword”, [System.TypeCode]::String, "SECRET1234!", "true", "FTP password")
$environment.Alter()
 
Write-Host "Adding environment reference to project ..."
LogWrite  "Adding environment reference to project ..."

# making project refer to this environment
$project = $folder.Projects[$ProjectName]
$project.References.Add($EnvironmentName, $folder.Name)
$project.Alter()
 
Write-Host "All done."
LogWrite "All done."
 
 
 
