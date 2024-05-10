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