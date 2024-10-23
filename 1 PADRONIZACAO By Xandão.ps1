# 
#FUNCOES CONFIGURACAO INICIAL
# 
function AlterarHostname {
	if($LblHostnameInfo.Text -ne $Hostname){
		Rename-Computer -NewName $LblHostnameInfo.Text
	}else{
		$wshell = New-Object -ComObject Wscript.Shell
		$Confirmacao = $wshell.Popup("Deseja alterar o Hostname?",0,"Aviso",32+4) 
		if($Confirmacao -eq 6){
			nomehostname
		}else{
			Write-Host 'O Hostname nao sera alterado!' -ForegroundColor Red
		}
	}
}

function nomehostname{
	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing

	$frmAlterarHostname = New-Object System.Windows.Forms.Form
	$frmAlterarHostname.Text = 'Alterar Hostname'
	$frmAlterarHostname.Size = New-Object System.Drawing.Size(300,150)
	$frmAlterarHostname.StartPosition = 'CenterScreen'
	$frmAlterarHostname.MaximizeBox = $false
	$frmAlterarHostname.MinimizeBox = $false
	$frmAlterarHostname.ControlBox = $false
	$frmAlterarHostname.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedDialog

	$lblHostname = New-Object System.Windows.Forms.Label
	$lblHostname.Font = New-Object System.Drawing.Font("Tahoma", 8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point, 0)
	$lblHostname.Location = New-Object System.Drawing.Point(10,20)
	$lblHostname.Size = New-Object System.Drawing.Size(280,20)
	$lblHostname.Text = 'Digite abaixo o novo Hostname:'

	$txtbHostname = New-Object System.Windows.Forms.TextBox
	$txtbHostname.Location = New-Object System.Drawing.Point(10,40)
	$txtbHostname.Font = New-Object System.Drawing.Font("Tahoma", 12,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point, 0)
	$txtbHostname.Size = New-Object System.Drawing.Size(260,60)
	$txtbHostname.CharacterCasing = 'Upper'
	$txtbHostname.Add_KeyDown({
		if ($_.KeyCode -eq [System.Windows.Forms.Keys]::Enter){
			$btnContinuar.Focus()
		}
	})

	function ClickBtnContinuar {
		if($txtbHostname.Text -eq ''){
			Write-Host Digite um Hostname
		}else{
			$Hostname = $txtbHostname.Text
			Rename-Computer -NewName $Hostname
			$frmAlterarHostname.Close()
		}
	}
	
	$btnContinuar = New-Object System.Windows.Forms.Button
	$btnContinuar.Location = New-Object System.Drawing.Point(10,75)
	$btnContinuar.Size = New-Object System.Drawing.Size(95,23)
	$btnContinuar.Font = New-Object System.Drawing.Font("Tahoma", 8.25,[System.Drawing.FontStyle]::Bold,[System.Drawing.GraphicsUnit]::Point, 0)
	$btnContinuar.Text = 'Continuar'
	$btnContinuar.Add_Click( { ClickBtnContinuar } )
	

	$frmAlterarHostname.Topmost = $true
	$frmAlterarHostname.Controls.AddRange(@($btnContinuar, $lblHostname, $txtbHostname))
	$frmAlterarHostname.ShowDialog()
}
function OOShutup {
    Write-Host 'Configurando Privacidade' -ForegroundColor Blue
    $ooshutup = Import-Module BitsTransfer
    if ($Windows -eq 10){
        $ooshutup = Start-BitsTransfer -Source "https://alexandreacosta.com.br/ACTech/Script/Config/ConfigWin10.cfg" -Destination ooshutup10.cfg
    }elseif($Windows -eq 11){
        $ooshutup = Start-BitsTransfer -Source "https://alexandreacosta.com.br/ACTech/Script/Config/ConfigWin11.cfg" -Destination ooshutup10.cfg
    }
    $ooshutup = Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
    $ooshutup = ./OOSU10.exe ooshutup10.cfg /quiet
}
function ConfigMouse {
    Write-Host 'Configurando Mouse' -ForegroundColor Blue
    $ConfigMouseUm = Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name WheelScrollLines -Value 5
    $ConfigMouseUm = Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseSpeed -Value 0
    $ConfigMouseUm = Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold1 -Value 0
    $ConfigMouseUm = Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold2 -Value 0
}
function ConfigControleContaUser {
    Write-Host 'Configurando Controle de Conta de Usuario' -ForegroundColor Blue
    $ConfigControleContaUser = Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name EnableLUA -Value 0
}
function ConfigTouchpad {
    Write-Host 'Configurando Touchpad' -ForegroundColor Blue
    $ConfigTouchPad = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad' -Name AAPThreshold -Value 0
}
function ConfigLimiteCaracteres {
    Write-Host 'Configurando o limite de caracteres' -ForegroundColor Blue
    $ConfigLimiteCaracteres = Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name LongPathsEnabled -Value 1
}
function ConfigPrintScreen {
    Write-Host 'Configurando o Atalho do PrintScreen' -ForegroundColor Blue
    $ConfigPrintScreen = Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name PrintScreenKeyForSnippingEnabled -Value 0
}
function ConfigTeclado {
    Write-Host 'Configurando Teclado' -ForegroundColor Blue
    $ConfigTeclado = Set-WinDefaultInputMethodOverride -InputTip '0416:00010416' -ErrorAction Ignore
    $ConfigTeclado = Remove-ItemProperty -Path 'HKCU:\Control Panel\International\User Profile\pt-BR' -Name 0416:00000416 -ErrorAction Ignore
    $ConfigTeclado = Remove-ItemProperty -Path 'HKCU:\Keyboard Layout\Preload' -Name 2 -ErrorAction Ignore
    $ConfigTeclado = Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name Flags -Value 26 -ErrorAction Ignore
    $ConfigTeclado = Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name Flags -Value 26 -ErrorAction Ignore
}
function ConfigDigitacao {
    Write-Host 'Configurando Digitacao' -ForegroundColor Blue
    if ($Windows -eq 10){
        If (!(Test-Path 'HKCU:\Software\Microsoft\input\Settings')) {
            $ConfigDigitacao =  New-Item -Path 'HKCU:\Software\Microsoft\input\Settings' -Force -ErrorAction Stop | Out-Null
            $ConfigDigitacao =  New-ItemProperty -Path 'HKCU:\Software\Microsoft\input\Settings' -Name InsightsEnabled -PropertyType DWORD -Value 0
        }else{
            $ConfigDigitacao =  Set-ItemProperty -Path 'HKCU:\Software\Microsoft\input\Settings' -Name InsightsEnabled -Value 0
        }
    }elseif($Windows -eq 11){
        $ConfigDigitacao =  Set-ItemProperty -Path 'HKCU:\Software\Microsoft\input\Settings' -Name InsightsEnabled -Value 0
    }
    If (!(Test-Path 'HKCU:\Software\Policies\Microsoft\Control Panel')) {
        $ConfigDigitacao =  New-Item -Path 'HKCU:\Software\Policies\Microsoft\Control Panel' -Force -ErrorAction Stop | Out-Null
        $ConfigDigitacao =  New-Item -Path 'HKCU:\Software\Policies\Microsoft\Control Panel\International' -Force -ErrorAction Stop | Out-Null
        $ConfigDigitacao =  New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Control Panel\International' -Name TurnOffAutocorrectMisspelledWords -PropertyType DWORD -Value 1
        $ConfigDigitacao =  New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Control Panel\International' -Name TurnOffHighlightMisspelledWords -PropertyType DWORD -Value 1
    }
}
function ConfigTaskBar {
    Write-Host 'Configurando Barra de Tarefas' -ForegroundColor Blue
    $ConfigBarraTarefasUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowTaskViewButton -Value 0
    $ConfigBarraTarefasUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarMn -Value 0
    $ConfigBarraTarefasUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarDa -Value 0
}
function ConfigTaskBarW11 {
    $ConfigBarraTarefasUm = Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name 'VisiblePlaces' -Value ([byte[]](0x86,0x08,0x73,0x52,0xaa,0x51,0x43,0x42,0x9f,0x7b,0x27,0x76,0x58,0x46,0x59,0xd4,0xbc,0x24,0x8a,0x14,0x0c,0xd6,0x89,0x42,0xa0,0x80,0x6e,0xd9,0xbb,0xa2,0x48,0x82))
    $ConfigBarraTarefasUm = Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowCopilotButton' -Value 0 -force
}
function ConfigGameMode {
    Write-Host 'Configurando Game Mode' -ForegroundColor Blue
    if($Windows -eq 10){
        $ConfigGameModeUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' -Name AppCaptureEnabled -Value 0 -ErrorAction Ignore
    }
    $ConfigGameModeUm = New-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name AutoGameModeEnabled -PropertyType DWORD -Value 0 -ErrorAction Ignore
    $ConfigGameModeUm = Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name UseNexusForGameBarEnabled -ErrorAction Ignore
    $ConfigGameModeUm = New-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name UseNexusForGameBarEnabled -PropertyType DWORD -Value 0 -ErrorAction Ignore
}
function ConfigOpcoesAvancadasWU{
    Write-Host 'Configurando Opcoes Avancadas Windows Update' -ForegroundColor Blue
	$OpcoesAvancadasWU = Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name AllowAutoWindowsUpdateDownloadOverMeteredNetwork -Value 1
	$OpcoesAvancadasWU = Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name AllowMUUpdateService -Value 1
	$OpcoesAvancadasWU = (New-Object -com "Microsoft.Update.ServiceManager").AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
}
function ConfigEnergia{
    Write-Host 'Configurando Energia' -ForegroundColor Blue
    $ConfigEnergiaUm = Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name HiberbootEnabled -Value 0
    $ConfigEnergiaUm = powercfg /change disk-timeout-ac 0
    $ConfigEnergiaUm = powercfg /change disk-timeout-dc 0
    $ConfigEnergiaUm = powercfg /change standby-timeout-ac 0
    $ConfigEnergiaUm = powercfg /change standby-timeout-dc 0
    $ConfigEnergiaUm = powercfg /change monitor-timeout-ac 0
    $ConfigEnergiaUm = powercfg /change monitor-timeout-dc 30
}
function ConfigExplorer{
    Write-Host 'Configurando Explorador de Arquivos' -ForegroundColor Blue
    $ConfigExplorerUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name ShowCloudFilesInQuickAccess -Value 0
    $ConfigExplorerUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name ShowFrequent -Value 0
    $ConfigExplorerUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name LaunchTo -Value 1
    $ConfigExplorerUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowEncryptCompressedColor -Value 1
    $ConfigExplorerUm = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name UseCompactMode -Value 1
}
function ConfigDarkMode {
    Write-Host 'Configurando Dark Mode' -ForegroundColor Blue
    if($Windows -eq 11){
        $WallpaperDarkMode = Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value 'C:\Windows\Web\Wallpaper\Windows\img19.jpg'
    }
    $appdarkmodeon = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize').AppsUseLightTheme
    $systemdarkmodeon = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize').SystemUsesLightTheme
    if($appdarkmodeon -eq 0 -and $systemdarkmodeon -eq 0){
        $ConfigDarkModeUm = Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0
    }else{
        $ConfigDarkModeUm = Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
        $ConfigDarkModeUm = Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0
        $ConfigDarkModeUm = Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0
    }
}
function ConfigStorageSense{
    Write-Host 'Configurando Storage Sense' -ForegroundColor Blue
    If (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense')) {
        $ConfigStorageSense = New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense -Force -ErrorAction Stop | Out-Null
    }
    If (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters')) {
        $ConfigStorageSense = New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters -Force -ErrorAction Stop | Out-Null
    }
    If (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy')) {
        $ConfigStorageSense = New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Force -ErrorAction Stop | Out-Null
        $ConfigStorageSense = New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 2048 -PropertyType DWORD -Value 1
        $ConfigStorageSense = New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 256 -PropertyType DWORD -Value 0
    }else{
        $ConfigStorageSense = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 2048 -Value 1
        $ConfigStorageSense = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 256 -Value 0
    }
    if($Windows -eq 10){
        $ConfigStorageSense = Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 01 -Value 1
    }
}
function ConfigMultitarefas {
    Write-Host 'Configurando Multitarefas' -ForegroundColor Blue
    $ConfigMultitask = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MultiTaskingAltTabFilter -Value 3
}
function ConfigMemoriaVirtual {
    Write-Host 'Configurando Memoria Virtual' -ForegroundColor Blue
    $memoria = Get-CimInstance -ClassName Win32_PhysicalMemory
    $memoriatotal = 0 
    foreach ($modulo in $memoria){
        $memoriatotal += [math]::Round($modulo.Capacity / 1GB, 2)
    }
    # Write-Host $memoriatotal 'GB de memoria' -ForegroundColor Blue
    $memoriatotalmb = (1024*$memoriatotal)
    $taminimb = ($memoriatotalmb*1.5)
    $tammaxmb = ($memoriatotalmb*3)
    $MemoriaVirtual = Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value "C:\pagefile.sys $taminimb $tammaxmb"
}
function ConfigMenuIniciar {
    Write-Host 'Configurando Menu Iniciar' -ForegroundColor Blue
        $ConfigMenuIniciar = Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name ShowRecentList -Value 0
}
function ConfigServicos {
    Write-Host 'Desabilitando Servicos' -ForegroundColor Blue
    if ($Windows -eq 11){
        $DesabServ = Stop-Service -name WSearch -force
        $DesabServ = Set-Service -name WSearch -startupType disabled
    }
    $DesabServ = Stop-Service -name DusmSvc -force
    $DesabServ = Set-Service -name DusmSvc -startupType disabled
}

function Reiniciar {
    Write-Host 'O WINDOWS IRA REINICIAR EM 5 SEGUNDOS!' -ForegroundColor Green
    Start-Sleep -Seconds 5
    Restart-Computer
}

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

function DesinstalarAppsConfigInicial{
    Write-Host 'Desinstalando Apps' -ForegroundColor Blue
    if ($Windows -eq 10){
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
    }elseif($Windows -eq 11){
        Get-AppxPackage *OneDriveSync* | Remove-AppxPackage
        Get-AppxPackage Microsoft.XboxSpeechToTextOverlay | Remove-AppxPackage
        Get-AppxPackage Microsoft.ZuneMusic | Remove-AppxPackage
		Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage
		Get-AppxPackage MicrosoftCorporationII.MicrosoftFamily | Remove-AppxPackage
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
}

function ConfigInicialWindows{
	if ($SO -like "*Windows 10*"){
		$Windows = 10
		$ProgressoWindowsPadronizacao.Visible = $true
		$LblProgressoWindowsPadronizacao.Visible = $true
		AlterarHostname
		$ProgressoWindowsPadronizacao.Value = 5
		$LblProgressoWindowsPadronizacao.Text = "Configurando Privacidade"
		OOShutup
		$ProgressoWindowsPadronizacao.Value = 10
		$LblProgressoWindowsPadronizacao.Text = "Configurando Mouse"
		ConfigMouse
		$ProgressoWindowsPadronizacao.Value = 15
		$LblProgressoWindowsPadronizacao.Text = "Configurando Touchpad"
		ConfigTouchpad
		$ProgressoWindowsPadronizacao.Value = 20
		$LblProgressoWindowsPadronizacao.Text = "Configurando Limite de Caracteres"
		ConfigLimiteCaracteres
		$ProgressoWindowsPadronizacao.Value = 25
		$LblProgressoWindowsPadronizacao.Text = "Configurando Teclado"
		ConfigTeclado
		$ProgressoWindowsPadronizacao.Value = 30
		$LblProgressoWindowsPadronizacao.Text = "Configurando PrintScreen"
		ConfigPrintScreen
		$ProgressoWindowsPadronizacao.Value = 35
		$LblProgressoWindowsPadronizacao.Text = "Configurando Barra de Tarefas"
		ConfigTaskBar
		$ProgressoWindowsPadronizacao.Value = 40
		$LblProgressoWindowsPadronizacao.Text = "Configurando Game Mode"
		ConfigGameMode
		$ProgressoWindowsPadronizacao.Value = 45
		$LblProgressoWindowsPadronizacao.Text = "Configurando Dark Mode"
		ConfigDarkMode
		$ProgressoWindowsPadronizacao.Value = 50
		$LblProgressoWindowsPadronizacao.Text = "Configurando Energia"
		ConfigEnergia
		$ProgressoWindowsPadronizacao.Value = 55
		$LblProgressoWindowsPadronizacao.Text = "Configurando Explorer"
		ConfigExplorer
		$ProgressoWindowsPadronizacao.Value = 60
		$LblProgressoWindowsPadronizacao.Text = "Configurando Storage Sense"
		ConfigStorageSense
		$ProgressoWindowsPadronizacao.Value = 65
		$LblProgressoWindowsPadronizacao.Text = "Configurando Opcoes Avancadas"
		ConfigOpcoesAvancadasWU
		$ProgressoWindowsPadronizacao.Value = 70
		$LblProgressoWindowsPadronizacao.Text = "Configurando Digitacao"
		ConfigDigitacao
		$ProgressoWindowsPadronizacao.Value = 75
		$LblProgressoWindowsPadronizacao.Text = "Configurando Multitarefas"
		ConfigMultitarefas
		$ProgressoWindowsPadronizacao.Value = 80
		$LblProgressoWindowsPadronizacao.Text = "Configurando Memória Virtual"
		ConfigMemoriaVirtual
		$ProgressoWindowsPadronizacao.Value = 85
		$LblProgressoWindowsPadronizacao.Text = "Configurando Servicos"
		ConfigServicos
		$ProgressoWindowsPadronizacao.Value = 90
		$LblProgressoWindowsPadronizacao.Text = "Desinstalando Programas"
		DesinstalarAppsConfigInicial
		DesinstalarOnedriveConfigIni
		$ProgressoWindowsPadronizacao.Value = 100
		$LblProgressoWindowsPadronizacao.Text = "O Windows ira reiniciar em 5 segundos"
		Reiniciar
	}elseif($SO -like "*Windows 11*"){
		$Windows = 11
		$ProgressoWindowsPadronizacao.Visible = $true
		$LblProgressoWindowsPadronizacao.Visible = $true
		AlterarHostname
		$ProgressoWindowsPadronizacao.Value = 5
		$LblProgressoWindowsPadronizacao.Text = "Configurando Privacidade"
		OOShutup
		$ProgressoWindowsPadronizacao.Value = 10
		$LblProgressoWindowsPadronizacao.Text = "Configurando Mouse"
		ConfigMouse
		$ProgressoWindowsPadronizacao.Value = 15
		$LblProgressoWindowsPadronizacao.Text = "Configurando Touchpad"
		ConfigTouchpad
		$ProgressoWindowsPadronizacao.Value = 20
		$LblProgressoWindowsPadronizacao.Text = "Configurando Limite de Caracteres"
		ConfigLimiteCaracteres
		$ProgressoWindowsPadronizacao.Value = 25
		$LblProgressoWindowsPadronizacao.Text = "Configurando Teclado"
		ConfigTeclado
		$ProgressoWindowsPadronizacao.Value = 30
		$LblProgressoWindowsPadronizacao.Text = "Configurando PrintScreen"
		ConfigPrintScreen
		$ProgressoWindowsPadronizacao.Value = 35
		$LblProgressoWindowsPadronizacao.Text = "Configurando Barra de Tarefas"
		ConfigTaskBar
		ConfigTaskBarW11
		$ProgressoWindowsPadronizacao.Value = 40
		$LblProgressoWindowsPadronizacao.Text = "Configurando Game Mode"
		ConfigGameMode
		$ProgressoWindowsPadronizacao.Value = 45
		$LblProgressoWindowsPadronizacao.Text = "Configurando Dark Mode"
		ConfigDarkMode
		$ProgressoWindowsPadronizacao.Value = 50
		$LblProgressoWindowsPadronizacao.Text = "Configurando Energia"
		ConfigEnergia
		$ProgressoWindowsPadronizacao.Value = 55
		$LblProgressoWindowsPadronizacao.Text = "Configurando Explorer"
		ConfigExplorer
		$ProgressoWindowsPadronizacao.Value = 60
		$LblProgressoWindowsPadronizacao.Text = "Configurando Storage Sense"
		ConfigStorageSense
		$ProgressoWindowsPadronizacao.Value = 65
		$LblProgressoWindowsPadronizacao.Text = "Configurando Opcoes Avancadas"
		ConfigOpcoesAvancadasWU
		$ProgressoWindowsPadronizacao.Value = 70
		$LblProgressoWindowsPadronizacao.Text = "Configurando Digitacao"
		ConfigDigitacao
		$ProgressoWindowsPadronizacao.Value = 75
		$LblProgressoWindowsPadronizacao.Text = "Configurando Multitarefas"
		ConfigMultitarefas
		$ProgressoWindowsPadronizacao.Value = 80
		$LblProgressoWindowsPadronizacao.Text = "Configurando Memória Virtual"
		ConfigMemoriaVirtual
		$ProgressoWindowsPadronizacao.Value = 85
		$LblProgressoWindowsPadronizacao.Text = "Configurando Servicos"
		ConfigServicos
		$ProgressoWindowsPadronizacao.Value = 90
		$LblProgressoWindowsPadronizacao.Text = "Configurando Menu Iniciar"
		ConfigMenuIniciar
		$ProgressoWindowsPadronizacao.Value = 95
		$LblProgressoWindowsPadronizacao.Text = "Desinstalando Programas"
		DesinstalarAppsConfigInicial
		DesinstalarOnedriveConfigIni
		$ProgressoWindowsPadronizacao.Value = 100
		$LblProgressoWindowsPadronizacao.Text = "O Windows ira reiniciar em 5 segundos"
		Reiniciar
	}else{
		Write-Host "Sistema Operacional nao identificado"
	}
}

function ConfigInicialWindowsAvulso{
	if ($SO -like "*Windows 10*"){
		$Windows = 10
		$ProgressoWindowsPadronizacao.Visible = $true
		$LblProgressoWindowsPadronizacao.Visible = $true
		AlterarHostname
		$ProgressoWindowsPadronizacao.Value = 5
		$LblProgressoWindowsPadronizacao.Text = "Configurando Privacidade"
		OOShutup
		$ProgressoWindowsPadronizacao.Value = 10
		$LblProgressoWindowsPadronizacao.Text = "Configurando Mouse"
		ConfigMouse
		$ProgressoWindowsPadronizacao.Value = 15
		$LblProgressoWindowsPadronizacao.Text = "Configurando Touchpad"
		ConfigTouchpad
		$ProgressoWindowsPadronizacao.Value = 20
		$LblProgressoWindowsPadronizacao.Text = "Configurando Limite de Caracteres"
		ConfigLimiteCaracteres
		$ProgressoWindowsPadronizacao.Value = 25
		$LblProgressoWindowsPadronizacao.Text = "Configurando Teclado"
		ConfigTeclado
		$ProgressoWindowsPadronizacao.Value = 30
		$LblProgressoWindowsPadronizacao.Text = "Configurando PrintScreen"
		ConfigPrintScreen
		$ProgressoWindowsPadronizacao.Value = 35
		$LblProgressoWindowsPadronizacao.Text = "Configurando Barra de Tarefas"
		ConfigTaskBar
		$ProgressoWindowsPadronizacao.Value = 40
		$LblProgressoWindowsPadronizacao.Text = "Configurando Game Mode"
		ConfigGameMode
		$ProgressoWindowsPadronizacao.Value = 45
		$LblProgressoWindowsPadronizacao.Text = "Configurando Dark Mode"
		ConfigDarkMode
		$ProgressoWindowsPadronizacao.Value = 50
		$LblProgressoWindowsPadronizacao.Text = "Configurando Energia"
		ConfigEnergia
		$ProgressoWindowsPadronizacao.Value = 55
		$LblProgressoWindowsPadronizacao.Text = "Configurando Explorer"
		ConfigExplorer
		$ProgressoWindowsPadronizacao.Value = 60
		$LblProgressoWindowsPadronizacao.Text = "Configurando Storage Sense"
		ConfigStorageSense
		$ProgressoWindowsPadronizacao.Value = 65
		$LblProgressoWindowsPadronizacao.Text = "Configurando Opcoes Avancadas"
		ConfigOpcoesAvancadasWU
		$ProgressoWindowsPadronizacao.Value = 70
		$LblProgressoWindowsPadronizacao.Text = "Configurando Digitacao"
		ConfigDigitacao
		$ProgressoWindowsPadronizacao.Value = 75
		$LblProgressoWindowsPadronizacao.Text = "Configurando Multitarefas"
		ConfigMultitarefas
		$ProgressoWindowsPadronizacao.Value = 80
		$LblProgressoWindowsPadronizacao.Text = "Configurando Memória Virtual"
		ConfigMemoriaVirtual
		$ProgressoWindowsPadronizacao.Value = 90
		$LblProgressoWindowsPadronizacao.Text = "Configurando Servicos"
		ConfigServicos
		$ProgressoWindowsPadronizacao.Value = 100
		$LblProgressoWindowsPadronizacao.Text = "O Windows ira reiniciar em 5 segundos"
		Reiniciar
	}elseif($SO -like "*Windows 11*"){
		$Windows = 11
		$ProgressoWindowsPadronizacao.Visible = $true
		$LblProgressoWindowsPadronizacao.Visible = $true
		AlterarHostname
		$ProgressoWindowsPadronizacao.Value = 5
		$LblProgressoWindowsPadronizacao.Text = "Configurando Privacidade"
		OOShutup
		$ProgressoWindowsPadronizacao.Value = 10
		$LblProgressoWindowsPadronizacao.Text = "Configurando Mouse"
		ConfigMouse
		$ProgressoWindowsPadronizacao.Value = 15
		$LblProgressoWindowsPadronizacao.Text = "Configurando Touchpad"
		ConfigTouchpad
		$ProgressoWindowsPadronizacao.Value = 20
		$LblProgressoWindowsPadronizacao.Text = "Configurando Limite de Caracteres"
		ConfigLimiteCaracteres
		$ProgressoWindowsPadronizacao.Value = 25
		$LblProgressoWindowsPadronizacao.Text = "Configurando Teclado"
		ConfigTeclado
		$ProgressoWindowsPadronizacao.Value = 30
		$LblProgressoWindowsPadronizacao.Text = "Configurando PrintScreen"
		ConfigPrintScreen
		$ProgressoWindowsPadronizacao.Value = 35
		$LblProgressoWindowsPadronizacao.Text = "Configurando Barra de Tarefas"
		ConfigTaskBar
		ConfigTaskBarW11
		$ProgressoWindowsPadronizacao.Value = 40
		$LblProgressoWindowsPadronizacao.Text = "Configurando Game Mode"
		ConfigGameMode
		$ProgressoWindowsPadronizacao.Value = 45
		$LblProgressoWindowsPadronizacao.Text = "Configurando Dark Mode"
		ConfigDarkMode
		$ProgressoWindowsPadronizacao.Value = 50
		$LblProgressoWindowsPadronizacao.Text = "Configurando Energia"
		ConfigEnergia
		$ProgressoWindowsPadronizacao.Value = 55
		$LblProgressoWindowsPadronizacao.Text = "Configurando Explorer"
		ConfigExplorer
		$ProgressoWindowsPadronizacao.Value = 60
		$LblProgressoWindowsPadronizacao.Text = "Configurando Storage Sense"
		ConfigStorageSense
		$ProgressoWindowsPadronizacao.Value = 65
		$LblProgressoWindowsPadronizacao.Text = "Configurando Opcoes Avancadas"
		ConfigOpcoesAvancadasWU
		$ProgressoWindowsPadronizacao.Value = 70
		$LblProgressoWindowsPadronizacao.Text = "Configurando Digitacao"
		ConfigDigitacao
		$ProgressoWindowsPadronizacao.Value = 75
		$LblProgressoWindowsPadronizacao.Text = "Configurando Multitarefas"
		ConfigMultitarefas
		$ProgressoWindowsPadronizacao.Value = 80
		$LblProgressoWindowsPadronizacao.Text = "Configurando Memória Virtual"
		ConfigMemoriaVirtual
		$ProgressoWindowsPadronizacao.Value = 85
		$LblProgressoWindowsPadronizacao.Text = "Configurando Servicos"
		ConfigServicos
		$ProgressoWindowsPadronizacao.Value = 90
		$LblProgressoWindowsPadronizacao.Text = "Configurando Menu Iniciar"
		ConfigMenuIniciar
		$ProgressoWindowsPadronizacao.Value = 100
		$LblProgressoWindowsPadronizacao.Text = "O Windows ira reiniciar em 5 segundos"
		Reiniciar
	}else{
		Write-Host "Sistema Operacional nao identificado"
	}
}


function TerminandoConfigWinDez {
	Write-Host 'Verificando Apps' -ForegroundColor Blue
	$verificandoapps = winget uninstall --id '{1FC1A6C2-576E-489A-9B4A-92D21F542136}' --accept-source-agreements
	$verificandoapps = winget uninstall --id '{7B63012A-4AC6-40C6-B6AF-B24A84359DD5}' --accept-source-agreements
	$verificandoapps = winget uninstall --id 'Microsoft.XboxIdentityProvider_8wekyb3d8bbwe' --accept-source-agreements
	$verificandoapps = winget uninstall --id 'Microsoft.XboxSpeechToTextOverlay_8wekyb3d8bbwe' --accept-source-agreements
	$verificandoapps = winget uninstall --id 'Microsoft.Wallet_8wekyb3d8bbwe' --accept-source-agreements
}
function TerminandoConfigWinOnze {
	Write-Host 'Verificando Apps' -ForegroundColor Blue
	$verificandoapps = winget uninstall --id 'Microsoft.DevHome' --accept-source-agreements
	$verificandoapps = winget uninstall --id 'Microsoft.OutlookForWindows_8wekyb3d8bbwe' --accept-source-agreements
}