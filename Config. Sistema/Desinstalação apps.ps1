# Desinstala o OneDrive
function DesinstalarOnedriveConfigIni{
	'set x86="%SYSTEMROOT%\System32\OneDriveSetup.exe"
	set x64="%SYSTEMROOT%\SysWOW64\OneDriveSetup.exe"
	
	taskkill /f /im OneDrive.exe > NUL 2>&1
	#ping 127.0.0.1 -n 5 > NUL 2>&1
	
	if exist %x64% (%x64% /uninstall) else (%x86% /uninstall)
	#ping 127.0.0.1 -n 5 > NUL 2>&1
	
	rd "%USERPROFILE%\OneDrive" /Q /S > NUL 2>&1
	rd "C:\OneDriveTemp" /Q /S > NUL 2>&1
	rd "%LOCALAPPDATA%\Microsoft\OneDrive" /Q /S > NUL 2>&1
	rd "%PROGRAMDATA%\Microsoft OneDrive" /Q /S > NUL 2>&1
	
	REG DELETE "HKEY_CLASSES_ROOT\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
	REG DELETE "HKEY_CLASSES_ROOT\Wow6432Node\CLSID\{018D5C66-4533-4307-9B53-224DE2ED1FE6}" /f > NUL 2>&1
	cls' | cmd
}

# Desinstala uma série de aplicativos
# TODO Verificar diferenças entre W10/W11
function DesinstalarAppsConfigInicial{
    if ($SO -like "*Windows 10*"){
        Get-AppxPackage Microsoft.MixedReality.Portal | Remove-AppxPackage
        Get-AppxPackage Microsoft.Print3D | Remove-AppxPackage
        Get-AppxPackage Microsoft.Messaging | Remove-AppxPackage
        Get-AppxPackage Microsoft.XboxApp | Remove-AppxPackage
        Get-AppxPackage Microsoft.MSPaint | Remove-AppxPackage
        Get-AppxPackage Microsoft.Microsoft3DViewer | Remove-AppxPackage
        Get-AppxPackage Microsoft.Office.OneNote | Remove-AppxPackage
        Get-AppxPackage Microsoft.SkypeApp | Remove-AppxPackage
        Get-AppxPackage MicrosoftCorporationII.MicrosoftFamily | Remove-AppxPackage
		Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
		Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
    }elseif($SO -like "*Windows 11*"){
        Get-AppxPackage *OneDriveSync* | Remove-AppxPackage
        Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage
        Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
		Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
		Get-AppxPackage MicrosoftCorporationII.MicrosoftFamily | Remove-AppxPackage
        Get-AppxPackage Microsoft.OutlookForWindows | Remove-AppxPackage
        Get-AppxPackage Microsoft.Windows.DevHome | Remove-AppxPackage
    }
    Get-AppxPackage *ZuneVideo* | Remove-AppxPackage
    Get-AppxPackage *feedback* | Remove-AppxPackage
    Get-AppxPackage *windowscommunicationsapps* | Remove-AppxPackage
    Get-AppxPackage SpotifyAB.SpotifyMusic | Remove-AppxPackage
    Get-AppxPackage Microsoft.Getstarted | Remove-AppxPackage
    Get-AppxPackage Microsoft.ScreenSketch | Remove-AppxPackage
    Get-AppxPackage Microsoft.GetHelp | Remove-AppxPackage
    Get-AppxPackage Microsoft.MicrosoftSolitaireCollection | Remove-AppxPackage
    Get-AppxPackage Microsoft.BingWeather | Remove-AppxPackage
    Get-AppxPackage Microsoft.GamingApp | Remove-AppxPackage
    Get-AppxPackage Microsoft.YourPhone | Remove-AppxPackage
    Get-AppxPackage Microsoft.PowerAutomateDesktop | Remove-AppxPackage
    Get-AppxPackage Clipchamp.Clipchamp | Remove-AppxPackage
    Get-AppxPackage Microsoft.WindowsAlarms | Remove-AppxPackage
    Get-AppxPackage Microsoft.MicrosoftOfficeHub | Remove-AppxPackage
    Get-AppxPackage MicrosoftCorporationII.QuickAssist | Remove-AppxPackage
    Get-AppxPackage Microsoft.WindowsSoundRecorder | Remove-AppxPackage
    Get-AppxPackage Microsoft.Todos | Remove-AppxPackage
    Get-AppxPackage Microsoft.BingNews | Remove-AppxPackage
    Get-AppxPackage Microsoft.WindowsMaps | Remove-AppxPackage
    Get-AppxPackage Microsoft.People | Remove-AppxPackage
    Get-AppxPackage Microsoft.MicrosoftStickyNotes | Remove-AppxPackage
    Get-AppxPackage MicrosoftTeams | Remove-AppxPackage
    Get-AppxPackage Microsoft.Xbox.TCUI | Remove-AppxPackage
    Get-AppxPackage Microsoft.WebpImageExtension | Remove-AppxPackage
    Get-AppxPackage Microsoft.XboxGameOverlay | Remove-AppxPackage
    Get-AppxPackage Microsoft.XboxGamingOverlay | Remove-AppxPackage
	Get-AppxPackage Microsoft.XboxIdentityProvider* | Remove-AppxPackage
}

DesinstalarOnedriveConfigIni
DesinstalarAppsConfigInicial

# Configurações finais do Windows 10 após reinicialização
function TerminandoConfigWinDez {
	Write-Host 'Verificando Apps' -ForegroundColor Blue
	winget uninstall --id '{1FC1A6C2-576E-489A-9B4A-92D21F542136}' --accept-source-agreements
	winget uninstall --id '{7B63012A-4AC6-40C6-B6AF-B24A84359DD5}' --accept-source-agreements
	winget uninstall --id 'Microsoft.XboxIdentityProvider_8wekyb3d8bbwe' --accept-source-agreements
	winget uninstall --id 'Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe' --accept-source-agreements
	winget uninstall --id 'Microsoft.Wallet_8wekyb3d8bbwe' --accept-source-agreements
}

# Configurações finais do Windows 11 após reinicialização
function TerminandoConfigWinOnze {
	Write-Host 'Verificando Apps' -ForegroundColor Blue
	winget uninstall --id 'Microsoft.DevHome' --accept-source-agreements
	winget uninstall --id 'Microsoft.OutlookForWindows_8wekyb3d8bbwe' --accept-source-agreements
}