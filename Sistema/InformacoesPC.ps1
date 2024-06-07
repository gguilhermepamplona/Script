# Impressoras
# Softwares instalados
# Bateria e Energia

function InfoPC {
    $PCInfo = Get-CimInstance -ClassName Win32_ComputerSystemProduct
    $PCFabricante = $PCInfo.Vendor
    $PCModelo = $PCInfo.Name
    $PCSN = $PCInfo.IdentifyingNumber
}

function InfoPCBIOS {
    $PCBIOS = Get-CimInstance -ClassName Win32_BIOS
    $PCBIOS = $PCBIOS.Manufacturer
    $PCBIOSVersao = $PCBIOS.SMBIOSBIOSVersion
    $PCBIOSData = $PCBIOS.ReleaseDate
}

function InfoPCSistema {
    $PCHostname = (Get-CimInstance -ClassName Win32_ComputerSystem).Name
    $PCSO = Get-CimInstance -ClassName Win32_OperatingSystem
    $PCSONome = $PCSO.Caption
    $PCSOArquitetura = $PCSO.OSArchitecture
    $PCSOVersao = $PCSO.Version
    $PCSOInstalacao = ([Management.ManagementDateTimeConverter]::ToDateTime($PCSO.InstallDate))
    $PCSOUltimaInicializacao = $PCSO.LastBootUpTime
    $PCSOSN = $PCSO.SerialNumber
}

function InfoPCMobo {
    $PCMobo = Get-CimInstance -ClassName Win32_baseboard
    $PCMoboFabricante = $PCMobo.Manufacturer
    $PCMoboModelo = $PCMobo.Product
    $PCMoboVersao = $PCMobo.Version
    $PCMoboSN = $PCMobo.SerialNumber
}

function InfoPCCPU {
    $PCCPU = Get-CimInstance -ClassName Win32_Processor
    $PCCPUNome = $PCCPU.Name
    $PCCPUClock = $PCCPU.MaxClockSpeed
    $PCCPUCores = $PCCPU.NumberOfCores
    $PCCPUThreads = $PCCPU.NumberOfLogicalProcessors
    $PCCPUSocket = $PCCPU.SocketDesignation
    $PCCPUVersao = $PCCPU.Version
    $PCCPURevisao = $PCCPU.Revision
    $PCCPUID = $PCCPU.ProcessorId
    $PCCPUStatus = $PCCPU.Status
}

function InfoPCRAM { # Precisa de foreach
    $PCRAM = Get-CimInstance -ClassName Win32_PhysicalMemory
    $PCRAMGB = [math]::Round((($PCRAM | Measure-Object -Property Capacity -Sum).Sum) / 1GB, 2)
    $PCRAMModulos = $PCRAM.count
    $PCRAMBank = $PCRAM.BankLabel
    $PCRAMFabricante = $PCRAM.Manufacturer
    $PCRAMSN = $PCRAM.SerialNumber
    $PCRAMModelo = $PCRAM.PartNumber
    $PCRAMClock = $PCRAM.Speed
    $PCRAMTipo = $PCRAM.MemoryType
    $PCRAMFormato = $PCRAM.FormFactor
    $PCRAMTensaoConfig = $PCRAM.ConfiguredVoltage
    $PCRAMTensaoMax = $PCRAM.MaxVoltage
    $PCRAMTensaoMin = $PCRAM.MinVoltage
}

function InfoPCGPU { # Precisa de foreach
    $PCGPU = Get-CimInstance -ClassName Win32_VideoController
    $PCGPUNome = $PCGPU.Name
    $PCGPUFabricante = $PCGPU.AdapterCompatibility
    $PCGPUDriverVersao = $PCGPU.DriverVersion
    $PCGPUDriverData = $PCGPU.DriverDate
    $PCGPUMemoria = [math]::Round($PCGPU.AdapterRAM / 1MB, 2) # Precisa de foreach
    $PCGPUTaxaAtualizacao = $PCGPU.CurrentRefreshRate
    $PCGPUResolucaoHorizontal = $PCGPU.CurrentHorizontalResolution
    $PCGPUResolucaoVertical = $PCGPU.CurrentVerticalResolution
    $PCGPUResolucaoCores = $PCGPU.VideoModeDescription
    $PCGPUBPP = $PCGPU.CurrentBitsPerPixel
}

function InfoPCArmazenamento { # Precisa de foreach
    $PCDisco = Get-CimInstance -ClassName Win32_DiskDrive
    $PCParticao = Get-CimInstance -ClassName Win32_DiskPartition
    $PCDiscoModelo = $PCDisco.Model
    $PCDiscoTamanho = [math]::Round($PCDisco.Size / 1GB, 2)
    $PCDiscoInterface = $PCDisco.InterfaceType
    $PCDiscoSN = $PCDisco.SerialNumber
    $PCDiscoTipo = $PCDisco.MediaType
    $PCParticaoNumeroDisco = $PCParticao.DiskIndex
    $PCParticaoNumero = $PCParticao.Index
    $PCParticaoTamanho = [math]::Round($PCParticao.Size / 1GB, 2)
    $PCParticaoTipo = $PCParticao.Type
    $PCParticaoPrimaria = $PCParticao.PrimaryPartition
}

function InfoPCRede { # Precisa de foreach
    $PCRede = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration
    $PCRedeAdaptador = Get-NetAdapter
    $PCRedeDescricao = $PCRede.Description
    $PCRedeMAC = $PCRede.MACAddress
    $PCRedeDHCP = $PCRede.DHCPEnabled
    $PCRedeIPv4 = $PCRede.IPAddress # Retorna ipv4 e ipv6, precisa de foreach
    $PCRedeMascara = $PCRede.IPSubnet # Retorna a mascara ipv4 e ipv6, precisa de foreach
    $PCRedeGateway = $PCRede.DefaultIPGateway
    $PCRedeDNS = $PCRede.DNSDomainSuffixSearchOrder # Precisa de foreach
    $PCRedeVelocidade = $PCRedeAdaptador.LinkSpeed
} # Tem mais opções no Get-NetAdapter

if ([string]::IsNullOrWhiteSpace($var)) {
}