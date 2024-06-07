function SFCDISM {
# Verificação e reparação do sistema de arquivos do Windows - Equiavalente ao 'sfc' e 'dism'
Repair-WindowsImage -RestoreHealth -Online
# TODO: Precisa adicionar uma forma de selecionar um disco pelo menu. Precisa apontar exatamente o arquivo 'install.wim'.
# TODO: Repair-WindowsImage -RestoreHealth -Source D:\sources\install.wim -LimitAccess -Online
}

function CHKDSKOnline {
# Verificação e reparação do disco em que o Windows se encontra instalado - Equivalente ao 'chkdsk'
Repair-Volume -DriveLetter C -Scan # Verificação online (dentro do sistema)
}

function CHKDSKOffline{
    # Verificação e reparação do disco em que o Windows se encontra instalado - Equivalente ao 'chkdsk'
    Repair-Volume -DriveLetter C -OfflineScanAndFix # Verificação offline (antes do sistema iniciar)
}

function DesfragmentacaoOtimizacao {
    Get-Volume | Where-Object DriveLetter | Where-Object DriveType -eq Fixed | Optimize-Volume ; Start-Sleep -Seconds 2
}

function IDERAIDparaAHCIpre {
    Start-Process -FilePath "cmd.exe" -ArgumentList "bcdedit /set {current} safeboot minimal" -Verb RunAs
}

function IDERAIDparaAHCIpos {
    Start-Process -FilePath "cmd.exe" -ArgumentList "bcdedit /deletevalue {current} safeboot" -Verb RunAs
}

function MBRparaGPT {
    Start-Process -FilePath "cmd.exe" -ArgumentList "mbr2gpt.exe /convert /allowfullOS" -Verb RunAs
}

function StoreAppx {
    Get-AppXPackage -AllUsers | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
    Start-Sleep 1
    Get-appxpackage -all *shellexperience* -packagetype bundle | ForEach-Object {add-appxpackage -register -disabledevelopmentmode ($_.installlocation + "C:\Program Files\WindowsApps\Microsoft.Windows.ShellExperienceHost_1.0.0.2_neutral_ShellExperienceHost.laac0539cc_8wekyb3d8bbwe\AppxManifest.xml")}
}