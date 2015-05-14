# Powershell 2.0


# Stop and fail script when a command fails.
$errorActionPreference = "Stop"

# load library functions
$rsLibDstDirPath = "$env:rs_sandbox_home\RightScript\lib"
. "$rsLibDstDirPath\tools\ResolveError.ps1"
. "$rsLibDstDirPath\win\Version.ps1"


# On Rackspace SQL Server 2012 client tools are installed on image level
if ($env:RS_CLOUD_PROVIDER -eq 'rackspace')
{
    Write-Host "Rackpsace RightImages have SQL Server client tools installed."
    exit 0
}

write-host "Install sqlncli..."
$parameters = "/qn /i " + $env:RS_ATTACH_DIR + "\sqlncli.msi IACCEPTSQLNCLILICENSETERMS=YES"
$installStatement = [System.Diagnostics.Process]::Start( "msiexec", $parameters )
write-host "Installation complete"
$installStatement.WaitForExit()


write-host "Install SQLSysClrTypes..."
$parameters = "/qn /i " + $env:RS_ATTACH_DIR + "\SQLSysClrTypes.msi"
$installStatement = [System.Diagnostics.Process]::Start( "msiexec", $parameters )
write-host "Installation complete"
$installStatement.WaitForExit()


write-host "Install SharedManagementObjects..."
$parameters = "/qn /i " + $env:RS_ATTACH_DIR + "\SharedManagementObjects.msi"
$installStatement = [System.Diagnostics.Process]::Start( "msiexec", $parameters )
write-host "Installation complete"
$installStatement.WaitForExit()
