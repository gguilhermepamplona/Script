$LinkCursor = "https://drive.google.com/uc?export=download&id=1vtIVylHIiemYzkhRa6rYSvfUXbzV7ySj"

if(-not(Test-Path -Path "C:\Windows\Web\Cursor")){
    New-Item "C:\Windows\Web\Cursor" -ItemType Directory
}
$CaminhoArquivo = "C:\Windows\Web\Cursor\MacOS Cursor Dark"

Invoke-WebRequest -Uri $LinkCursor -OutFile $CaminhoArquivo