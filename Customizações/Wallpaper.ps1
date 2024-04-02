function Wallpaper {
$LinkWallpaper = "https://drive.google.com/uc?export=download&id=1rqt07IDCJeU6jjuv2tE5lHvQlwL3wEkC"
# $NomeArquivo = [System.IO.Path]::GetFileName((New-Object System.Uri($LinkWallpaper)).LocalPath)

if(-not(Test-Path -Path "C:\Windows\Web\Wallpaper\Script")){
    New-Item "C:\Windows\Web\Wallpaper\Script" -ItemType Directory
}
$CaminhoArquivo = "C:\Windows\Web\Wallpaper\Script\wallpaper.jpg"

Invoke-WebRequest -Uri $LinkWallpaper -OutFile $CaminhoArquivo
Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
[Wallpaper]::SystemParametersInfo(0x0014, 0, $CaminhoArquivo, 0x01)

$regPath = "HKCU:\Control Panel\Desktop"
$regName = "WallPaper" 
Set-ItemProperty -Path $regPath -Name $regName -Value $CaminhoArquivo
}
