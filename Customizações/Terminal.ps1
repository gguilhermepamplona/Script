function Terminal {
$DiretorioConfig = "C:\Users\$env:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$ArquivoConfig = Join-Path $DiretorioConfig "settings.json"
$LinkConfig = "https://drive.google.com/uc?export=download&id=1YBH7WhIe30oopzYIdeDFar0opst_3--U"

Invoke-WebRequest -Uri $LinkConfig -OutFile $ArquivoConfig
}
