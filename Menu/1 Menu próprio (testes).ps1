$ItensMenu = @("Opcao 1", "Opcao 2", "Opcao 3")

function menu([int]$pos){
    $Posicao1 = [System.Console]::CursorTop
    for ($i = 0; $i -lt $ItensMenu.Length; $i ++){
        $item = $ItensMenu[$i]
        if($i -ne $null){
        [System.Console]::SetCursorPosition(0, $Posicao1)
        if($i -eq $pos){
            Write-Host $item -ForegroundColor Red
        }else{
            Write-Host $item
        }
        
        }
    }
}
$tecla = $host.ui.rawui.ReadKey("IncludeKeyDown, NoEcho").VirtualKeyCode
if($tecla -eq 40){
    if($pos -eq $ItensMenuQuant -1){
        menu -pos $ItensMenuQuant
    }else{
        menu -pos ($pos + 1)
    }
}

menu

[System.Console]::SetCursorPosition(0, 10)

$Posicao2 = [System.Console]::CursorTop

Write-Host $Posicao1
Write-Host $Posicao2

# $posinicial = [System.Console]::CursorTop
$pos = 0

Write-Host



function teclas{
    $tecla = $host.ui.rawui.ReadKey("IncludeKeyDown, NoEcho").VirtualKeyCode
    if($tecla -eq 27){
        Break
    }
Write-Host $tecla
teclas
}