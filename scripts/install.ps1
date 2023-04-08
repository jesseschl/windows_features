# Array of features
$features = @(
'NetFx3',
'IIS-ManagementConsole', 
'IIS-ASPNET', 
'IIS-ASPNET45',
'IIS-ISAPIFilter',
'IIS-ISAPIExtensions',
'IIS-NetFxExtensibility',
'IIS-NetFxExtensibility45')
 
 # Loop through array of features to enable
foreach ($feature in $features){
    if (Enable-WindowsOptionalFeature -Online -FeatureName $feature -All) {
        Write-Host 'Enabled:' $feature}
    else {
        Write-Host 'Failed:' $feature}
}

Write-Host ''
Write-Host 'Enable complete'

# Create and startup Sea Sharp
mkdir C:\ironpub\wwwroot
New-WebAppPool -Name "Sea Sharp"
Set-ItemProperty -Path IIS:\AppPools\"Sea Sharp" managedRuntimeVersion "v4.0"
Start-IISCommitDelay
$seasharp = New-IISSite -Name "Sea Sharp" -BindingInformation "*:28960:" -PhysicalPath "C:\ironpub\wwwroot" -Passthru
$seasharp.Applications["/"].ApplicationPoolName = "Sea Sharp"
Stop-IISCommitDelay

# Copy required files into app directories
Copy-Item C:\temp\data\inetpub-1\* C:\inetpub\wwwroot\
mkdir -Force C:\inetpub\wwwroot\bin
Copy-Item C:\temp\data\inetpub-2\* C:\inetpub\wwwroot\bin
Copy-Item C:\temp\data\ironpub-1\* C:\ironpub\wwwroot\
Copy-Item C:\temp\data\ironpub-2\bin C:\ironpub\wwwroot\ -Recurse

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}