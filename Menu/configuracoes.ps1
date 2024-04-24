function configuracoes {
    Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseSpeed -Value 0
    Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold1 -Value 0
    Set-ItemProperty -Path 'HKCU:\Control Panel\Mouse' -Name MouseThreshold2 -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\PrecisionTouchPad' -Name AAPThreshold -Value 0
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name LongPathsEnabled -Value 1
    Set-ItemProperty -Path 'HKCU:\Control Panel\Keyboard' -Name PrintScreenKeyForSnippingEnabled -Value 0
    Set-WinDefaultInputMethodOverride -InputTip '0416:00010416' -ErrorAction Ignore
    Remove-ItemProperty -Path 'HKCU:\Control Panel\International\User Profile\pt-BR' -Name 0416:00000416 -ErrorAction Ignore
    Remove-ItemProperty -Path 'HKCU:\Keyboard Layout\Preload' -Name 2 -ErrorAction Ignore
    Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\StickyKeys' -Name Flags -Value 26 -ErrorAction Ignore
    Set-ItemProperty -Path 'HKCU:\Control Panel\Accessibility\Keyboard Response' -Name Flags -Value 26 -ErrorAction Ignore
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
    $SO = (Get-CimInstance Win32_OperatingSystem).Caption
    if ($SO -like "*Windows 11*"){
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Start" -Name 'VisiblePlaces' -Value ([byte[]](0x86,0x08,0x73,0x52,0xaa,0x51,0x43,0x42,0x9f,0x7b,0x27,0x76,0x58,0x46,0x59,0xd4,0xbc,0x24,0x8a,0x14,0x0c,0xd6,0x89,0x42,0xa0,0x80,0x6e,0xd9,0xbb,0xa2,0x48,0x82))
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name 'ShowCopilotButton' -Value 0 -force
    }
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name ShowTaskViewButton -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarMn -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name TaskbarDa -Value 0
    $SO = (Get-CimInstance Win32_OperatingSystem).Caption
    if($SO -like "*Windows 10*"){
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR' -Name AppCaptureEnabled -Value 0 -ErrorAction Ignore
    }
    New-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name AutoGameModeEnabled -PropertyType DWORD -Value 0 -ErrorAction Ignore
    Remove-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name UseNexusForGameBarEnabled -ErrorAction Ignore
    New-ItemProperty -Path 'HKCU:\Software\Microsoft\GameBar' -Name UseNexusForGameBarEnabled -PropertyType DWORD -Value 0 -ErrorAction Ignore
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name AllowAutoWindowsUpdateDownloadOverMeteredNetwork -Value 1
    Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\WindowsUpdate\UX\Settings' -Name AllowMUUpdateService -Value 1
    (New-Object -com "Microsoft.Update.ServiceManager").AddService2("7971f918-a847-4430-9279-4a52d1efe18d",7,"")
    powercfg /change disk-timeout-ac 0
    powercfg /change disk-timeout-dc 0
    powercfg /change standby-timeout-ac 0
    powercfg /change standby-timeout-dc 0
    powercfg /change monitor-timeout-ac 0
    powercfg /change monitor-timeout-dc 30
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name ShowCloudFilesInQuickAccess -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer' -Name ShowFrequent -Value 0
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name LaunchTo -Value 1
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name UseCompactMode -Value 1
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
    Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced' -Name MultiTaskingAltTabFilter -Value 3
    $memoria = Get-CimInstance -ClassName Win32_PhysicalMemory
    $memoriatotal = 0 
    foreach ($modulo in $memoria){
        $memoriatotal += [math]::Round($modulo.Capacity / 1GB, 2)
    }
    $memoriatotalmb = (1024*$memoriatotal)
    $taminimb = ($memoriatotalmb*1.5)
    $tammaxmb = ($memoriatotalmb*3)
    Set-ItemProperty -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management' -Name 'PagingFiles' -Value "C:\pagefile.sys $taminimb $tammaxmb"
    if($SO -like "*Windows 11*"){
        Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Start' -Name ShowRecentList -Value 0
    }
    Stop-Service -name WSearch -force
    Set-Service -name WSearch -startupType disabled
    Stop-Service -name DusmSvc -force
    Set-Service -name DusmSvc -startupType disabled
    Set-NetTCPSetting -SettingName internet -AutoTuningLevelLocal normal
    Set-NetTCPSetting -SettingName internet -ScalingHeuristics disabled
    netsh int tcp set supplemental internet congestionprovider=CUBIC > Out-Null
    Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing disabled
    Set-NetOffloadGlobalSetting -ReceiveSideScaling Enabled
    Disable-NetAdapterLso -Name *
    Enable-NetAdapterChecksumOffload -Name *
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "explorer.exe" -Value 10 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "iexplore.exe" -Value 10 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "explorer.exe" -Value 10 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "iexplore.exe" -Value 10 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "LocalPriority" -Value 4 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "HostsPriority" -Value 5 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "DnsPriority" -Value 6 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "NetbtPriority" -Value 7 -Type DWord
    if (-not (Test-Path -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched")){
        New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Force
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Name "NonBestEffortLimit" -Value 0 -Type DWord
    if (-not (Test-Path -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS")){
        New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Force
    }
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Name "Do not use NLA" -Value 1 -Type String
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 10 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "Size" -Value 3 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\" -Name "LargeSystemCache" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxUserPort" -Value 65534 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpTimedWaitDelay" -Value 30 -Type DWord
    if (-not (Test-Path -path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters")){
        New-Item -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Force
    }
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Name "TCPNoDelay" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DefaultTTL" -Value 64 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EcnCapability" -Value 0 -Type DWord
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnableTCPChimney" -Value 0 -Type DWord
    Set-NetTCPSetting -SettingName internet -Timestamps disabled
    Set-NetTCPSetting -SettingName internet -MaxSynRetransmissions 2
    Set-NetTCPSetting -SettingName internet -NonSackRttResiliency disabled
    Set-NetTCPSetting -SettingName internet -InitialRto 2000
    Set-NetTCPSetting -SettingName internet -MinRto 300
    netsh interface ipv4 set subinterface "Wifi" mtu=1500 store=persistent > Out-Null
    netsh interface ipv6 set subinterface "Wifi" mtu=1500 store=persistent > Out-Null
    netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent > Out-Null
    netsh interface ipv6 set subinterface "Ethernet" mtu=1500 store=persistent > Out-Null
    $EthGuid = (Get-NetAdapter | Where-Object {$_.Name -like "*Ethernet*"}).InterfaceGuid
    $WifiGuid = (Get-NetAdapter | Where-Object {$_.Name -like "*Wifi*" -or $_.Name -like "*Wi-Fi*"}).InterfaceGuid
    foreach ($_ in $EthGuid) {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$_" -Name "TcpAckFrequency" -Value 4 -Type DWord
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$_" -Name "TcpDelAckTicks" -Value 0 -Type DWord
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$_" -Name "TCPNoDelay" -Value 0 -Type DWord
    }
    foreach ($_ in $WifiGuid) {
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$_" -Name "TcpAckFrequency" -Value 4 -Type DWord
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$_" -Name "TcpDelAckTicks" -Value 0 -Type DWord
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$_" -Name "TCPNoDelay" -Value 0 -Type DWord
    }
    Winget upgrade --all
    Invoke-WebRequest -UseBasicParsing "https://christitus.com/win" | Invoke-Expression
}