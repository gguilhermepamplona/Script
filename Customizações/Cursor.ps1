function Cursor {
$LinkCursor = "https://drive.google.com/uc?export=download&id=1bwRha4AnjOWcm1PHhVMHnx69KknQIGsl"
$DirTemp = Join-Path -Path $env:USERPROFILE -ChildPath "AppData\Local\Temp\Cursor\"

if(-not(Test-Path -Path $DirTemp)){
    New-Item $DirTemp -ItemType Directory
}
$CaminhoArquivo = Join-Path -Path $DirTemp "\MacOS Cursor Dark.zip"

Invoke-WebRequest -Uri $LinkCursor -OutFile $CaminhoArquivo
Expand-Archive -Path $CaminhoArquivo -DestinationPath (Split-Path $CaminhoArquivo) -Force

$CaminhoInstall = Join-Path -Path $DirTemp "Install.inf"
if (Test-Path $CaminhoInstall) {
$ComandoInstall = "rundll32.exe"
$arg = "setupapi.dll,InstallHinfSection DefaultInstall 132 $($CaminhoInstall -replace '\\', '\\')"
Start-Process -FilePath $ComandoInstall -ArgumentList $arg -Wait -Verb RunAs
} else {
    Write-Host "O arquivo .inf não foi encontrado."
}

Set-Item -Path 'HKCU:\Control Panel\Cursors' -Value 'macOS' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name AppStarting -Value 'C:\Windows\Cursors\macOS\Working In Background.ani' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Arrow -Value 'C:\Windows\Cursors\macOS\Normal Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Crosshair -Value 'C:\Users\Guilherme\Downloads\Dark\Base\precision.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Hand -Value 'C:\Windows\Cursors\macOS\Link Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Help -Value 'C:\Windows\Cursors\macOS\Help Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name IBeam -Value 'C:\Windows\Cursors\macOS\Text Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name No -Value 'C:\Windows\Cursors\macOS\Unavailable.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name NWPen -Value 'C:\Windows\Cursors\macOS\Handwriting.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Person -Value 'C:\Windows\Cursors\macOS\Location Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Pin -Value 'C:\Windows\Cursors\macOS\Person Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name precisionhair -Value 'C:\Users\Guilherme\Downloads\Dark\Base\precision.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name 'Scheme Source' -Value 1 > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name SizeAll -Value 'C:\Windows\Cursors\macOS\Move.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name SizeNESW -Value 'C:\Windows\Cursors\macOS\Diagonal Resize 2.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name SizeNS -Value 'C:\Windows\Cursors\macOS\Vertical Resize.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name SizeNWSE -Value 'C:\Windows\Cursors\macOS\Diagonal Resize 1.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name SizeWE -Value 'C:\Windows\Cursors\macOS\Horizontal Resize.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name UpArrow -Value 'C:\Windows\Cursors\macOS\Alternate Select.cur' > $null
Set-ItemProperty -Path 'HKCU:\Control Panel\Cursors' -Name Wait -Value 'C:\Windows\Cursors\macOS\Busy.ani' > $null

Remove-Item -Path $DirTemp -Recurse -Force
}
