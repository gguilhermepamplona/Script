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

Start-Process "control.exe" -ArgumentList "main.cpl"

Remove-Item -Path $DirTemp -Recurse -Force