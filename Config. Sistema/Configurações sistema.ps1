function AlterarHostname{
    $HostnameSN = Read-Host "Você deseja alterar o hostname? [S] [N]"
    switch ($HostnameSN) {
            "S" {
                $NovoHostname = Read-Host "Nome do computador"
                Rename-Computer -NewName $NovoHostname
                Write-Host "Hostname alterado para $NovoHostname" -ForegroundColor Blue
            }
            "N" {
                Write-Host "O hostname não será alterado!" -ForegroundColor Blue
            }
            Default {
                Write-Host "Opção inválida" -ForegroundColor Red
            }
        }
    }

    function OOShutup{
        Import-Module BitsTransfer
        Start-BitsTransfer -Source "https://alexandreacosta.com.br/ProgramasPowerShell/OOSU.cfg" -Destination OOSU.cfg
        Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
        ./OOSU10.exe OOSU.cfg /quiet
    }
    
    # Desativa aceleração do mouse
    function ConfigMouse {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseSpeed -Value 0
        Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold1 -Value 0
        Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold2 -Value 0
    }

    # Define a maior sensibilidade do Touchpad
    function ConfigTouchpad {
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad' -Name AAPThreshold -Value 0
    }
    
    # Desativa o UAC. 0 = Desativado e 1 = Ativado
    function ConfigControleContaUsuario {
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System' -Name EnableLUA -Value 0
    }

    # Desativa o limite de caracteres em diretórios
    function ConfigLimiteCaracteres {
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name LongPathsEnabled -Value 1
    }
    
    # Desativa o Snipping Tool da tecla PrintScreen para utilização do LightShot
    function ConfigPrintScreen {
        Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name PrintScreenKeyForSnippingEnabled -Value 0
    }

    # Exclui o layout ABNT e deixa apenas o ABNT2
    function ConfigTeclado {
        Set-WinDefaultInputMethodOverride -InputTip '0416:00010416' -ErrorAction Ignore
        Remove-ItemProperty -Path 'HKCU:\Control Panel\International\User Profile\pt-BR' -Name 0416:00000416 -ErrorAction Ignore
        Remove-ItemProperty -Path 'HKCU:\Keyboard Layout\Preload' -Name 2 -ErrorAction Ignore
        Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name Flags -Value 26 -ErrorAction Ignore
        Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name Flags -Value 26 -ErrorAction Ignore
    }
    
    # Desativa opções de tecla de aderência e de filtro
    # TODO Verificar a diferença de W10/W11 e desativar atalhos do teclado de teclas de aderência, alternância e filtro
    function ConfigDigitacao {
        $SO = (Get-CimInstance Win32_OperatingSystem).Caption
        if ($SO -like "*Windows 10*"){
            If (!(Test-Path 'HKCU:\Software\Microsoft\input\Settings')) {
                New-Item -Path 'HKCU:\Software\Microsoft\input\Settings' -Force -ErrorAction Stop | Out-Null
                New-ItemProperty -Path 'HKCU:\Software\Microsoft\input\Settings' -Name InsightsEnabled -PropertyType DWORD -Value 0
            }else{
                Set-ItemProperty -Path 'HKCU:\Software\Microsoft\input\Settings' -Name InsightsEnabled -Value 0
            }
        }elseif($SO -like "*Windows 11*"){
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\input\Settings' -Name InsightsEnabled -Value 0
        }
        If (!(Test-Path 'HKCU:\Software\Policies\Microsoft\Control Panel')) {
            New-Item -Path 'HKCU:\Software\Policies\Microsoft\Control Panel' -Force -ErrorAction Stop | Out-Null
            New-Item -Path 'HKCU:\Software\Policies\Microsoft\Control Panel\International' -Force -ErrorAction Stop | Out-Null
            New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Control Panel\International' -Name TurnOffAutocorrectMisspelledWords -PropertyType DWORD -Value 1
            New-ItemProperty -Path 'HKCU:\Software\Policies\Microsoft\Control Panel\International' -Name TurnOffHighlightMisspelledWords -PropertyType DWORD -Value 1
        }
    }
    
    # Configura a barra de tarefas
    function ConfigTaskBar {
        $SO = (Get-CimInstance Win32_OperatingSystem).Caption
        if ($SO -like "*Windows 11*"){
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name 'VisiblePlaces' -Value ([byte[]](0x86,0x08,0x73,0x52,0xaa,0x51,0x43,0x42,0x9f,0x7b,0x27,0x76,0x58,0x46,0x59,0xd4,0xbc,0x24,0x8a,0x14,0x0c,0xd6,0x89,0x42,0xa0,0x80,0x6e,0xd9,0xbb,0xa2,0x48,0x82))
            Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowCopilotButton' -Value 0 -force
        }
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowTaskViewButton -Value 0
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarMn -Value 0
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarDa -Value 0
    }

    # Configura modo de jogo
    function ConfigGameMode {
        $SO = (Get-CimInstance Win32_OperatingSystem).Caption
        if($SO -like "*Windows 10*"){
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' -Name AppCaptureEnabled -Value 0 -ErrorAction Ignore
        }
        New-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name AutoGameModeEnabled -PropertyType DWORD -Value 0 -ErrorAction Ignore
        Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name UseNexusForGameBarEnabled -ErrorAction Ignore
        New-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name UseNexusForGameBarEnabled -PropertyType DWORD -Value 0 -ErrorAction Ignore
    }
    
    # Configurações do Windows Update
    # TODO opção: "Obter as atualizações mais recentes assim que elas estiverem disponíveis"
    function ConfigOpcoesAvancadasWU{
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name AllowAutoWindowsUpdateDownloadOverMeteredNetwork -Value 1
        Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name AllowMUUpdateService -Value 1
        (New-Object -com "Microsoft.Update.ServiceManager").AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
    }

    # Configurações de energia
    function ConfigEnergia{
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name HiberbootEnabled -Value 0
        powercfg /change disk-timeout-ac 0
        powercfg /change disk-timeout-dc 0
        powercfg /change standby-timeout-ac 0
        powercfg /change standby-timeout-dc 0
        powercfg /change monitor-timeout-ac 0
        powercfg /change monitor-timeout-dc 30
    }
    
    # Configurações do explorador de arquivos
    function ConfigExplorer{
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name ShowCloudFilesInQuickAccess -Value 0
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name ShowFrequent -Value 0
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name LaunchTo -Value 1
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name UseCompactMode -Value 1
    }
    
    # Deixa o sistema no modo escuro
    # TODO opção para modo claro
    function ConfigDarkMode {
        $SO = (Get-CimInstance Win32_OperatingSystem).Caption
        if($SO -like "*Windows 11*"){
            Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name Wallpaper -Value 'C:\Windows\Web\Wallpaper\Windows\img19.jpg'
        }
        $appdarkmodeon = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize').AppsUseLightTheme
        $systemdarkmodeon = (Get-ItemProperty -path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize').SystemUsesLightTheme
        if($appdarkmodeon -eq 0 -and $systemdarkmodeon -eq 0){
            Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0
        }else{
            Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name AppsUseLightTheme -Value 0
            Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name SystemUsesLightTheme -Value 0
            Set-ItemProperty -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize -Name EnableTransparency -Value 0
        }
    }

    # Configura o sensor de armazenamento
    function ConfigStorageSense{
        If (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense')) {
            New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense -Force -ErrorAction Stop | Out-Null
        }
        If (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters')) {
            New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters -Force -ErrorAction Stop | Out-Null
        }
        If (!(Test-Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy')) {
            New-Item -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Force -ErrorAction Stop | Out-Null
            New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 2048 -PropertyType DWORD -Value 1
            New-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 256 -PropertyType DWORD -Value 0
        }else{
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 2048 -Value 1
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name 256 -Value 0
        }
        $SO = (Get-CimInstance Win32_OperatingSystem).Caption
        if($SO -like "*Windows 10*"){
            Set-ItemProperty -Path HKCU:\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy -Name 01 -Value 1
        }
    }

    # Configura a opção multitarefas
    function ConfigMultitarefas {
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MultiTaskingAltTabFilter -Value 3
    }
    
    # Configura a memória virtual (Memória de Paginação)
    function ConfigMemoriaVirtual {
        $memoria = Get-CimInstance -ClassName Win32_PhysicalMemory
        $memoriatotal = 0 
        foreach ($modulo in $memoria){
            $memoriatotal += [math]::Round($modulo.Capacity / 1GB, 2)
        }
        $memoriatotalmb = (1024*$memoriatotal)
        $taminimb = ($memoriatotalmb*1.5)
        $tammaxmb = ($memoriatotalmb*3)
        Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value "C:\pagefile.sys $taminimb $tammaxmb"
    }
    
    # Configura o Menu Iniciar
    function ConfigMenuIniciar {
        if($SO -like "*Windows 11*"){
            Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name ShowRecentList -Value 0
        }
    }
    
    # Desabilita os serviços WSearch (Windows Search) e DusmSvc (Data Usage/Uso de Dados)
    function ConfigServicos {
        Stop-Service -name WSearch -force
        Set-Service -name WSearch -startupType disabled
        Stop-Service -name DusmSvc -force
        Set-Service -name DusmSvc -startupType disabled
    }

    # Função de reinicialização do sistema
    function Reiniciar {
        Write-Host 'O WINDOWS IRA REINICIAR EM 5 SEGUNDOS!' -ForegroundColor Green
        Start-Sleep -Seconds 5
        Restart-Computer
    }
    
    # Função para rodar as configurações
    function Configs {
        Write-Host "Configurando o sistema..." -ForegroundColor Green
        AlterarHostname
        OOShutup
        ConfigMouse
        ConfigTouchpad
        ConfigControleContaUsuario
        ConfigLimiteCaracteres
        ConfigPrintScreen
        ConfigTeclado
        ConfigDigitacao
        ConfigTaskBar
        ConfigGameMode
        ConfigOpcoesAvancadasWU
        ConfigEnergia
        ConfigExplorer
        ConfigDarkMode
        ConfigStorageSense
        ConfigMultitarefas
        ConfigMemoriaVirtual
        ConfigMenuIniciar
        ConfigServicos
        Reiniciar
    }