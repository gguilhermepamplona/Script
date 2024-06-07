# Desativa Teredo
netsh interface teredo set state disabled > Out-Null

# ---------------------------------------- TCPOPTIMIZER ----------------------------------------
# Auto TuningLevelLocal | Padrão: normal
Set-NetTCPSetting -SettingName internet -AutoTuningLevelLocal normal

# ScalingHeuristics | Padrão: default
Set-NetTCPSetting -SettingName internet -ScalingHeuristics disabled

# CongestionProvider | Padrão: CUBIC
netsh int tcp set supplemental internet congestionprovider=CUBIC > Out-Null

# ReceiveSegmentCoalescing | Padrão: enabled
Set-NetOffloadGlobalSetting -ReceiveSegmentCoalescing disabled

# ReceiveSideScaling | Padrão: enabled
Set-NetOffloadGlobalSetting -ReceiveSideScaling Enabled

# Large Send Offload | Padrão: enabled
Disable-NetAdapterLso -Name *

# Checksum Offload | Padrão: enabled
Enable-NetAdapterChecksumOffload -Name *

# MaxConnectionsPer1_0Server | Padrão: 4
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "explorer.exe" -Value 10 -Type DWord
# MaxConnectionsPer1_0Server | Padrão: n/a
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPER1_0SERVER" -Name "iexplore.exe" -Value 10 -Type DWord

# MaxConnectionsPerServer | Padrão: 2
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "explorer.exe" -Value 10 -Type DWord
# MaxConnectionsPerServer | Padrão: n/a
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Internet Explorer\Main\FeatureControl\FEATURE_MAXCONNECTIONSPERSERVER" -Name "iexplore.exe" -Value 10 -Type DWord

# LocalPriority | Padrão: 499
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "LocalPriority" -Value 4 -Type DWord

# HostsPriority | Padrão: 500
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "HostsPriority" -Value 5 -Type DWord

# DnsPriority | Padrão: 2000
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "DnsPriority" -Value 6 -Type DWord

# NetbtPriority | Padrão: 2001
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider" -Name "NetbtPriority" -Value 7 -Type DWord

# NonBestEffortLimit | Padrão: n/a
if (-not (Test-Path -path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched")){
    New-Item -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Force
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Psched" -Name "NonBestEffortLimit" -Value 0 -Type DWord

# Do not use NLA | Padrão: n/a
if (-not (Test-Path -path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS")){
    New-Item -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Force
}
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\QoS" -Name "Do not use NLA" -Value 1 -Type String

# Network ThrottlingIndex | Padrão: 10
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 4294967295 -Type DWord

# SystemResponsiveness | Padrão: 20
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 10 -Type DWord

# Size | Padrão: 1
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters" -Name "Size" -Value 3 -Type DWord

# LargeSystemCache | Padrão: 0
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management\" -Name "LargeSystemCache" -Value 1 -Type DWord

# MaxUserPort | Padrão: n/a
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "MaxUserPort" -Value 65534 -Type DWord

# TcpTimedWaitDelay | Padrão: n/a
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "TcpTimedWaitDelay" -Value 30 -Type DWord

# TCPNoDelay | Padrão: n/a
if (-not (Test-Path -path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters")){
    New-Item -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Force
}
Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\MSMQ\Parameters" -Name "TCPNoDelay" -Value 1 -Type DWord

# DefaultTTL | Padrão: n/a
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "DefaultTTL" -Value 64 -Type DWord

# ECNCapability | Padrão: default
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EcnCapability" -Value 0 -Type DWord

# Chimney | Padrão: disabled
Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "EnableTCPChimney" -Value 0 -Type DWord

# Timestamps | Padrão: default
Set-NetTCPSetting -SettingName internet -Timestamps disabled

# MaxSynRetransmissions | Padrão: 2
Set-NetTCPSetting -SettingName internet -MaxSynRetransmissions 2

# NonSackRTTResiliency | Padrão: default
Set-NetTCPSetting -SettingName internet -NonSackRttResiliency disabled

# InitialRto | Padrão: 3000
Set-NetTCPSetting -SettingName internet -InitialRto 2000

# MinRto | Padrão: 300
Set-NetTCPSetting -SettingName internet -MinRto 300

# MTU | Padrão: 1500
netsh interface ipv4 set subinterface "Wifi" mtu=1500 store=persistent > Out-Null
netsh interface ipv6 set subinterface "Wifi" mtu=1500 store=persistent > Out-Null
netsh interface ipv4 set subinterface "Ethernet" mtu=1500 store=persistent > Out-Null
netsh interface ipv6 set subinterface "Ethernet" mtu=1500 store=persistent > Out-Null

# TcpAckFrequency | Padrão: n/a
# TcpDelAck Ticks | Padrão: n/a
# TCPNoDelay | Padrão: n/a
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

# Definir DNS da CloudFlare
$DNSIPV4 = "1.1.1.1", "1.0.0.1"
$DNSIPV6 = "2606:4700:4700::1111", "2606:4700:4700::1001"

Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $DNSIPV4
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses $DNSIPv6 -AddressFamily IPv6