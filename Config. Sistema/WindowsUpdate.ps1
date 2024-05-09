# TODO:  Para fazer um input do usuário automaticamente no comando 'Add-WUServiceManager -MicrosoftUpdate', é necessário utilizar DLL.

function WindowsUpdate {
Install-Module PSWindowsUpdate -Force -AllowClobber
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
Import-Module PSWindowsUpdate
Add-WUServiceManager -MicrosoftUpdate
Install-WindowsUpdate -MicrosoftUpdate -AcceptAll
}