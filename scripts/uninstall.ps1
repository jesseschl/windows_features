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
 
 # Loop through array of features to disable
foreach ($feature in $features){
    if (Disable-WindowsOptionalFeature -Online -FeatureName $feature -Remove) {
        Write-Host 'Disabled:' $feature}
    else {
        Write-Host 'Failed:' $feature}
}

Write-Host ''
Write-Host 'Disable complete'

# Uninstall website
Remove-IISSite -Name "Sea Sharp"

# Remove IIS folders and files
Remove-Item -LiteralPath "C:\ironpub" -Force -Recurse

# Close opened port
Remove-NetFirewallRule -DisplayName "SeaSharp"

# Reboot
Restart-Computer -Force

# If running in the console, wait for input before closing.
if ($Host.Name -eq "ConsoleHost")
{
    Write-Host "Press any key to continue..."
    $Host.UI.RawUI.FlushInputBuffer()   # Make sure buffered input doesn't "press a key" and skip the ReadKey().
    $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyUp") > $null
}