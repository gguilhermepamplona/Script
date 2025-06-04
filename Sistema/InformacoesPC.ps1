# Impressoras
# Softwares instalados
# Bateria e Energia
function InformacoesPC {
$DirArquivo = "$env:TEMP\infopcpsscr.txt"
Remove-Item -Path $DirArquivo -ErrorAction SilentlyContinue
function InfoPC {
    $PCInfo = Get-CimInstance -ClassName Win32_ComputerSystemProduct
    $Saida = @()
    if ($PCInfo) {
        $PCFabricante = if ($PCInfo.Vendor) { $PCInfo.Vendor } else { "N/A" }
        $PCModelo = if ($PCInfo.Name) { $PCInfo.Name } else { "N/A" }
        $PCSN = if ($PCInfo.IdentifyingNumber) { $PCInfo.IdentifyingNumber } else { "N/A" }
        $Saida += "Informações do Computador:"
        $Saida += "  Fabricante: $PCFabricante"
        $Saida += "  Modelo: $PCModelo"
        $Saida += "  Serial: $PCSN"
        $Saida += ""
        $Saida += "-----------------------------"
    } else { $Saida += "Não foi possível obter informações sobre o computador." }
    return $Saida
}
function InfoPCSistema {
    $PCSO = Get-CimInstance -ClassName Win32_OperatingSystem
    $Saida = @()
    if ($PCSO) {
        $PCHostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
        $PCSONome = if ($PCSO.Caption) { $PCSO.Caption } else { "N/A" }
        $PCSOArquitetura = if ($PCSO.OSArchitecture) { $PCSO.OSArchitecture } else { "N/A" }
        $PCSOVersao = if ($PCSO.Version) { $PCSO.Version } else { "N/A" }
        $PCSOInstalacao = if (![string]::IsNullOrWhiteSpace($PCSO.InstallDate) -and $PCSO.InstallDate -match '^\d{14}\.\d{6}\+\d{3}$') { [Management.ManagementDateTimeConverter]::ToDateTime($PCSO.InstallDate) } else { "N/A" }
        $PCSOUltimaInicializacao = if (![string]::IsNullOrWhiteSpace($PCSO.LastBootUpTime) -and $PCSO.LastBootUpTime -match '^\d{14}\.\d{6}\+\d{3}$') { [Management.ManagementDateTimeConverter]::ToDateTime($PCSO.LastBootUpTime) } else { "N/A" }
        $PCSOSN = if ($PCSO.SerialNumber) { $PCSO.SerialNumber } else { "N/A" }
        $Saida += "Informações do Sistema Operacional:"
        $Saida += "  Hostname: $PCHostname"
        $Saida += "  Sistema Operacional: $PCSONome"
        $Saida += "  Arquitetura: $PCSOArquitetura"
        $Saida += "  Versão: $PCSOVersao"
        $Saida += "  Data de Instalação: $PCSOInstalacao"
        $Saida += "  Última Inicialização: $PCSOUltimaInicializacao"
        $Saida += "  Serial do SO: $PCSOSN"
        $Saida += ""
        $Saida += "-----------------------------"
    } else { $Saida += "Não foi possível obter informações sobre o sistema." }
    return $Saida
}
function InfoPCMobo {
    $PCMobo = Get-CimInstance -ClassName Win32_baseboard
    $PCBIOS = Get-CimInstance -ClassName Win32_BIOS
    $Saida = @()
    # Informações da Placa-mãe
    if ($PCMobo) {
        $PCMoboFabricante = if ($PCMobo.Manufacturer) { $PCMobo.Manufacturer } else { "N/A" }
        $PCMoboModelo = if ($PCMobo.Product) { $PCMobo.Product } else { "N/A" }
        $PCMoboVersao = if ($PCMobo.Version) { $PCMobo.Version } else { "N/A" }
        $PCMoboSN = if ($PCMobo.SerialNumber) { $PCMobo.SerialNumber } else { "N/A" }
        $Saida += "Placa-mãe:"
        $Saida += "  Fabricante: $PCMoboFabricante"
        $Saida += "  Modelo: $PCMoboModelo"
        $Saida += "  Versão: $PCMoboVersao"
        $Saida += "  Serial: $PCMoboSN"
    } else { $Saida += "Não foi possível obter informações sobre a placa-mãe." }
    # Informações da BIOS
    if ($PCBIOS) {
        $PCBIOSFabricante = if ($PCBIOS.Manufacturer) { $PCBIOS.Manufacturer } else { "N/A" }
        $PCBIOSVersao = if ($PCBIOS.SMBIOSBIOSVersion) { $PCBIOS.SMBIOSBIOSVersion } else { "N/A" }
        $PCBIOSData = if ($PCBIOS.ReleaseDate) { $PCBIOS.ReleaseDate } else { "N/A" }
        $Saida += "BIOS:"
        $Saida += "  Fabricante: $PCBIOSFabricante"
        $Saida += "  Versão: $PCBIOSVersao"
        $Saida += "  Data de Lançamento: $PCBIOSData"
        $Saida += ""
        $Saida += "-----------------------------"
    } else { $Saida += "Não foi possível obter informações sobre a BIOS." }
    return $Saida
}
function InfoPCCPU {
    $PCCPU = Get-CimInstance -ClassName Win32_Processor
    $Saida = @()
    if ($PCCPU -and $PCCPU.Count -gt 0) {
        foreach ($cpu in $PCCPU) {
            $PCCPUNome = if ($cpu.Name) { $cpu.Name } else { "N/A" }
            $PCCPUClock = if ($cpu.MaxClockSpeed) { $cpu.MaxClockSpeed } else { "N/A" }
            $PCCPUCores = if ($cpu.NumberOfCores) { $cpu.NumberOfCores } else { "N/A" }
            $PCCPUThreads = if ($cpu.NumberOfLogicalProcessors) { $cpu.NumberOfLogicalProcessors } else { "N/A" }
            $PCCPUSocket = if ($cpu.SocketDesignation) { $cpu.SocketDesignation } else { "N/A" }
            $PCCPUVersao = if ($cpu.Version) { $cpu.Version } else { "N/A" }
            $PCCPURevisao = if ($cpu.Revision) { $cpu.Revision } else { "N/A" }
            $PCCPUID = if ($cpu.ProcessorId) { $cpu.ProcessorId } else { "N/A" }
            $PCCPUStatus = if ($cpu.Status) { $cpu.Status } else { "N/A" }
            Write-Host "Nome: $PCCPUNome"
            $Saida += "Informações da CPU:"
            $Saida += "  Clock Máximo: $PCCPUClock MHz"
            $Saida += "  Cores: $PCCPUCores"
            $Saida += "  Threads: $PCCPUThreads"
            $Saida += "  Socket: $PCCPUSocket"
            $Saida += "  Versão: $PCCPUVersao"
            $Saida += "  Revisão: $PCCPURevisao"
            $Saida += "  ID: $PCCPUID"
            $Saida += "  Status: $PCCPUStatus"
            $Saida += ""
            $Saida += "-----------------------------"
        }
    } else { $Saida += "Não foi possível obter informações sobre a CPU." }
    return $Saida
}
function InfoPCRAM {
    $PCRAM = Get-CimInstance -ClassName Win32_PhysicalMemory
    $modulos = $PCRAM.Count
    $Saida = @()
    if ($modulos -gt 0) {
        $capacidadePorModuloGB = if ($PCRAM[0].Capacity) { [math]::Round($PCRAM[0].Capacity / 1GB, 2) } else { "N/A" }
        $totalRAM = [math]::Round((($PCRAM | Measure-Object -Property Capacity -Sum).Sum) / 1GB, 2)
        $Saida += "Informações da Memória RAM:"
        $Saida += "  Total de RAM: $($totalRAM -ne 0 ? $totalRAM : 'N/A') GB"
        $Saida += "  Quantidade de módulos: ${modulos}x${capacidadePorModuloGB}GB"
        $Saida += ""
    } else { $Saida += "Não foi possível obter informações sobre a memória RAM." }
    foreach ($modulo in $PCRAM) {
        $bank = if ($modulo.BankLabel) { $modulo.BankLabel } else { "N/A" }
        $fabricante = if ($modulo.Manufacturer) { $modulo.Manufacturer } else { "N/A" }
        $serial = if ($modulo.SerialNumber) { $modulo.SerialNumber } else { "N/A" }
        $modelo = if ($modulo.PartNumber) { $modulo.PartNumber } else { "N/A" }
        $capacidade = if ($modulo.Capacity) { [math]::Round($modulo.Capacity / 1GB, 2) } else { "N/A" }
        $clock = if ($modulo.Speed) { $modulo.Speed } else { "N/A" }
        $tipo = if ($modulo.MemoryType) { $modulo.MemoryType } else { "N/A" }
        $formato = if ($modulo.FormFactor) { $modulo.FormFactor } else { "N/A" }
        $tensaoConfig = if ($modulo.ConfiguredVoltage) { $modulo.ConfiguredVoltage } else { "N/A" }
        $tensaoMax = if ($modulo.MaxVoltage) { $modulo.MaxVoltage } else { "N/A" }
        $tensaoMin = if ($modulo.MinVoltage) { $modulo.MinVoltage } else { "N/A" }
        $Saida += "  Banco: $bank"
        $Saida += "  Fabricante: $fabricante"
        $Saida += "  Serial: $serial"
        $Saida += "  Modelo: $modelo"
        $Saida += "  Capacidade: $capacidade GB"
        $Saida += "  Clock: $clock MHz"
        $Saida += "  Tipo: $tipo"
        $Saida += "  Formato: $formato"
        $Saida += ("  Tensão Configurada: " + ($tensaoConfig -ne "N/A" ? "$tensaoConfig mV" : "N/A"))
        $Saida += ("  Tensão Máxima: " + ($tensaoMax -ne "N/A" ? "$tensaoMax mV" : "N/A"))
        $Saida += ("  Tensão Mínima: " + ($tensaoMin -ne "N/A" ? "$tensaoMin mV" : "N/A"))
        $Saida += ""
    }
    $Saida += "-----------------------------"
    return $Saida
}
function InfoPCGPU {
    $PCGPU = Get-CimInstance -ClassName Win32_VideoController
    $Saida = @()
    if ($PCGPU -and $PCGPU.Count -gt 0) {
        foreach ($gpu in $PCGPU) {
            $PCGPUNome = if ($gpu.Name) { $gpu.Name } else { "N/A" }
            $PCGPUFabricante = if ($gpu.AdapterCompatibility) { $gpu.AdapterCompatibility } else { "N/A" }
            $PCGPUDriverVersao = if ($gpu.DriverVersion) { $gpu.DriverVersion } else { "N/A" }
            $PCGPUDriverData = if ($gpu.DriverDate) { $gpu.DriverDate } else { "N/A" }
            $PCGPUMemoria = if ($gpu.AdapterRAM) { [math]::Round($gpu.AdapterRAM / 1MB, 2) } else { "N/A" }
            $PCGPUTaxaAtualizacao = if ($gpu.CurrentRefreshRate) { $gpu.CurrentRefreshRate } else { "N/A" }
            $PCGPUResolucaoHorizontal = if ($gpu.CurrentHorizontalResolution) { $gpu.CurrentHorizontalResolution } else { "N/A" }
            $PCGPUResolucaoVertical = if ($gpu.CurrentVerticalResolution) { $gpu.CurrentVerticalResolution } else { "N/A" }
            $PCGPUResolucaoCores = if ($gpu.VideoModeDescription) { $gpu.VideoModeDescription } else { "N/A" }
            $PCGPUBPP = if ($gpu.CurrentBitsPerPixel) { $gpu.CurrentBitsPerPixel } else { "N/A" }
            $Saida += "Informações da GPU:"
            $Saida += "  Nome: $PCGPUNome"
            $Saida += "  Fabricante: $PCGPUFabricante"
            $Saida += "  Versão do Driver: $PCGPUDriverVersao"
            $Saida += "  Data do Driver: $PCGPUDriverData"
            $Saida += "  Memória: $PCGPUMemoria MB"
            $Saida += "  Taxa de Atualização: $PCGPUTaxaAtualizacao Hz"
            $Saida += "  Resolução: $PCGPUResolucaoHorizontal x $PCGPUResolucaoVertical"
            $Saida += "  Descrição do Modo de Vídeo: $PCGPUResolucaoCores"
            $Saida += "  Bits por Pixel: $PCGPUBPP"
            $Saida += ""
            $Saida += "-----------------------------"
        }
    } else { $Saida += "Não foi possível obter informações sobre a GPU." }
    return $Saida
}
function InfoPCArmazenamento {
    $PCDiscos = Get-CimInstance -ClassName Win32_DiskDrive
    $Saida = @()
    if ($PCDiscos -and $PCDiscos.Count -gt 0) {
        foreach ($disco in $PCDiscos) {
            $modelo = if ($disco.Model) { $disco.Model } else { "N/A" }
            $tamanho = if ($disco.Size) { [math]::Round($disco.Size / 1GB, 2) } else { "N/A" }
            $interface = if ($disco.InterfaceType) { $disco.InterfaceType } else { "N/A" }
            $serial = if ($disco.SerialNumber) { $disco.SerialNumber } else { "N/A" }
            $tipo = if ($disco.MediaType) { $disco.MediaType } else { "N/A" }
            $Saida += "Informações do Disco:"
            $Saida += "  Modelo: $modelo"
            $Saida += "  Tamanho: $tamanho GB"
            $Saida += "  Interface: $interface"
            $Saida += "  Serial: $serial"
            $Saida += "  Tipo: $tipo"
            $Saida += ""
            # Partições relacionadas ao disco
            $particoes = Get-CimInstance -ClassName Win32_DiskPartition | Where-Object { $_.DiskIndex -eq $disco.Index }
            if ($particoes -and $particoes.Count -gt 0) {
                foreach ($particao in $particoes) {
                    $numPart = if ($null -ne $particao.Index) { $particao.Index } else { "N/A" }
                    $tamPart = if ($particao.Size) { [math]::Round($particao.Size / 1GB, 2) } else { "N/A" }
                    $tipoPart = if ($particao.Type) { $particao.Type } else { "N/A" }
                    $primaria = if ($particao.PrimaryPartition -eq $true) { "Sim" } elseif ($particao.PrimaryPartition -eq $false) { "Não" } else { "N/A" }
                    $Saida += "Partição: $numPart"
                    $Saida += "  Tamanho: $tamPart GB"
                    $Saida += "  Tipo: $tipoPart"
                    $Saida += "  Primária: $primaria"
                    $Saida += ""
                }
            } else { $Saida += "Não foi possível obter informações sobre as partições deste disco." }
        }
    } else { $Saida += "Não foi possível obter informações sobre o dispositivo de armazenamento." }
    $Saida += "-----------------------------"
    return $Saida
}
function InfoPCRede {
    $PCRede = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration | Where-Object { $_.IPEnabled -eq $true }
    $PCRedeAdaptador = Get-NetAdapter
    $Saida = @()
    if ($PCRede -and $PCRede.Count -gt 0) {
        foreach ($adaptador in $PCRede) {
            $descricao = if ($adaptador.Description) { $adaptador.Description } else { "N/A" }
            $mac = if ($adaptador.MACAddress) { $adaptador.MACAddress } else { "N/A" }
            $dhcp = if ($null -ne $adaptador.DHCPEnabled) { if ($adaptador.DHCPEnabled) { "Sim" } else { "Não" } } else { "N/A" }
            # IPs (IPv4 e IPv6 separados)
            $ipv4 = @()
            $ipv6 = @()
            if ($adaptador.IPAddress) {
                foreach ($ip in $adaptador.IPAddress) {
                    if ($ip -match "^\d{1,3}(\.\d{1,3}){3}$") {
                        $ipv4 += $ip
                    } elseif ($ip -match ":") {
                        $ipv6 += $ip
                    }
                }
            }
            $ipv4Str = if ($ipv4.Count -gt 0) { $ipv4 -join ", " } else { "N/A" }
            $ipv6Str = if ($ipv6.Count -gt 0) { $ipv6 -join ", " } else { "N/A" }
            # Máscaras
            $mascaras = @()
            if ($adaptador.IPSubnet) {
                foreach ($msk in $adaptador.IPSubnet) {
                    $mascaras += $msk
                }
            }
            $mascarasStr = if ($mascaras.Count -gt 0) { $mascaras -join ", " } else { "N/A" }
            # Gateways
            $gateways = @()
            if ($adaptador.DefaultIPGateway) {
                foreach ($gw in $adaptador.DefaultIPGateway) {
                    $gateways += $gw
                }
            }
            $gatewaysStr = if ($gateways.Count -gt 0) { $gateways -join ", " } else { "N/A" }
            # DNS
            $dns = @()
            if ($adaptador.DNSServerSearchOrder) {
                foreach ($dnsip in $adaptador.DNSServerSearchOrder) {
                    $dns += $dnsip
                }
            }
            $dnsStr = if ($dns.Count -gt 0) { $dns -join ", " } else { "N/A" }
            # Sufixos DNS
            $dnsSuffix = @()
            if ($adaptador.DNSDomainSuffixSearchOrder) {
                foreach ($suf in $adaptador.DNSDomainSuffixSearchOrder) {
                    $dnsSuffix += $suf
                }
            }
            $dnsSuffixStr = if ($dnsSuffix.Count -gt 0) { $dnsSuffix -join ", " } else { "N/A" }
            # Velocidade
            $velocidade = "N/A"
            $netAdapter = $PCRedeAdaptador | Where-Object { $_.MacAddress -replace '-', ':' -eq $mac }
            if ($netAdapter) {
                $velocidade = if ($netAdapter.LinkSpeed) { $netAdapter.LinkSpeed } else { "N/A" }
            }
            $Saida += "Informações de Rede:"
            $Saida += "  Descrição: $descricao"
            $Saida += "  MAC Address: $mac"
            $Saida += "  DHCP: $dhcp"
            $Saida += "  IPv4(s): $ipv4Str"
            $Saida += "  IPv6(s): $ipv6Str"
            $Saida += "  Máscara(s): $mascarasStr"
            $Saida += "  Gateway(s): $gatewaysStr"
            $Saida += "  DNS(s): $dnsStr"
            $Saida += "  Sufixo(s) DNS: $dnsSuffixStr"
            $Saida += "  Velocidade: $velocidade"
            $Saida += ""
            $Saida += "-----------------------------"
        }
    } else { $Saida += "Não foi possível obter informações sobre o dispositivo de rede." }
    return $Saida
}
$InfoFuncoes = @()
$InfoFuncoes += InfoPC
$InfoFuncoes += InfoPCSistema
$InfoFuncoes += InfoPCMobo
$InfoFuncoes += InfoPCCPU
$InfoFuncoes += InfoPCRAM
$InfoFuncoes += InfoPCGPU
$InfoFuncoes += InfoPCArmazenamento
$InfoFuncoes += InfoPCRede
Add-Content -Path $DirArquivo -Value $InfoFuncoes
Start-Process notepad.exe "$DirArquivo"
}