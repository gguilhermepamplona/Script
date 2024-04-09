# AutoTuningLevelLocal
Set-NetTCPSetting -SettingName internet -AutoTuningLevelLocal normal

# ScalingHeuristics
Set-NetTCPSetting -SettingName internet -ScalingHeuristics disabled

#CongestionProvider
Set-NetTCPSetting -SettingName InternetCustom -CongestionProvider CUBIC

# ReceiveSegmentCoalescing
Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing disabled

# ReceiveSideScaling
Set-NetOffloadGlobalSetting -ReceiveSideScaling enabled

# Large Send Offload
Disable-NetAdapterLso -Name *

# Checksum Offload
Enable-NetAdapterChecksumOffload -Name *

# MaxConnectionsPer1_0Server
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "explorer.exe" -Value 10 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "iexplore.exe" -Value 10 -Type DWord

# MaxConnectionsPerServer
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "explorer.exe" -Value 10 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "iexplore.exe" -Value 10 -Type DWord

# LocalPriority
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "LocalPriority" -Value 4 -Type DWord

# HostsPriority
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "HostsPriority" -Value 5 -Type DWord

# DnsPriority
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "DnsPriority" -Value 6 -Type DWord

# NetbtPriority
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "NetbtPriority" -Value 7 -Type DWord

# NonBestEffortLimit
if (-not (Test-Path -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched")){
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Force
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Name "NonBestEffortLimit" -Value 0 -Type DWord

# Do not use NLA
if (-not (Test-Path -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS")){
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Force
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Name "Do not use NLA" -Value 0 -Type 
