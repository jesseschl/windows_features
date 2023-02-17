## README
Structure for install should be in c:\temp\

* ├── install.bat 
* ├── uninstall.bat
* ├── scripts
  * ├── install.ps1
  * └── uninstall.ps1

# Windows features to enable/disable
1. IIS-ManagementConsole
2. IIS-ASPNET 
3. IIS-ASPNET45
4. IIS-ISAPIFilter
5. IIS-ISAPIExtensions
6. IIS-NetFxExtensibility
7. IIS-NetFxExtensibility45

# install.bat
installs/enables windows features

# uninstall.bat
uninstalls/disables windows features

## Scripts

# install.ps1
Assigned features to array var

Enable features using Enable-WindowsOptionalFeature shell command

# uninstall.ps1
Assigned features to array var

Disable features using Disable-WindowsOptionalFeature shell command
