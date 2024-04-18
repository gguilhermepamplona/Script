# Desativa Teredo
netsh interface teredo set state disabled > Out-Null

# ---------------------------------------- TCPOPTIMIZER ----------------------------------------
# Auto TuningLevelLocal | Padrão: 
Set-NetTCPSetting -Setting Name internet -Auto TuningLevelLocal nomal

# ScalingHeuristics | Padrão: default
Set-NetTCPSetting -SettingName internet -ScalingHeuristics disabled

# CongestionProvider
netsh int tcp set supplemental internet congestionprovider=CUBIC

# ReceiveSegmentCoalescing | Padrão: enabled
Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing disabled

# ReceiveSideScaling | Padrão: 
Set-NetOffloadGlobalSetting -ReceiveSideScaling Enabled

# Large Send Offload | Padrão: 
Disable-NetAdapterLso -Name *

# Checksum Offload | Padrão: 
Enable-NetAdapterChecksumOffload -Name *

# MaxConnectionsPer1_0Server | Padrão: 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "explorer.exe" -Value 10 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "iexplore.exe" -Value 10 -Type DWord

# MaxConnectionsPerServer | Padrão: 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "explorer.exe" -Value 10 -Type DWord
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "iexplore.exe" -Value 10 -Type DWord

# LocalPriority | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "LocalPriority" -Value 4 -Type DWord

# HostsPriority | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "HostsPriority" -Value 5 -Type DWord

# DnsPriority | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "DnsPriority" -Value 6 -Type DWord

# NetbtPriority | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "NetbtPriority" -Value 7 -Type DWord

# NonBestEffortLimit | Padrão: 
if (-not (Test-Path -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched")){
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Force
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Name "NonBestEffortLimit" -Value 0 -Type DWord

# Do not use NLA | Padrão: 
if (-not (Test-Path -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS")){
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Force
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Name "Do not use NLA" -Value 1 -Type String

# Network ThrottlingIndex | Padrão: 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -Type DWord

# SystemResponsiveness | Padrão: 
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 10 -Type DWord

# Size | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "Size" -Value 3 -Type DWord

# LargeSystemCache | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\" -Name "LargeSystemCache" -Value 1 -Type DWord

# MaxUserPort
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxUserPort" -Value 65534 -Type DWord

# TcpTimedWaitDelay | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpTimedWaitDelay" -Value 30 -Type DWord

# DefaultTTL | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DefaultTTL" -Value 64 -Type DWord

# ECNCapability | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EcnCapability" -Value 0 -Type DWord

# Chimney | Padrão: 
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnableTCPChimney" -Value 0 -Type DWord

# Timestamps | Padrão: 
Set-NetTCPSetting -SettingName internet -Timestamps disabled

# MaxSynRetransmissions | Padrão: 
Set-NetTCPSetting -SettingName internet -MaxSynRetransmissions 2

# NonSackRTTResiliency | Padrão: 
Set-NetTCPSetting -SettingName internet -NonSackRttResiliency disabled

# InitialRto
Set-NetTCPSetting -SettingName internet -InitialRto 2000

# MinRto
Set-NetTCPSetting -SettingName internet -MinRto 300

# MTU
netsh interface ipv4 set subinterface "Wifi" mtu=1500 store=persistent
netsh interface ipv6 set subinterface "Wifi" mtu=1500 store=persistent
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent
netsh interface ipv6 set subinterface "Ethernet" mtu=1500 store=persistent

# TcpAckFrequency
# TcpDelAck Ticks
# TCPNoDelay | Padrão: 
if (-not (Test-Path -path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters")){
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Force
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Name "TCPNoDelay" -Value 1 -Type DWord