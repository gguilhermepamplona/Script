Import-Module -Name ps-menu -Force

$global:OpcoesSelecionadas = @{}

function OpcoesMenu([array]$opcoes) {
    [string]$result = Menu -menuItems ($opcoes.o)
    $VariavelAtual = $opcoes | Where-Object {$_.o -eq $result}
    $NomeVariavelAtual = (Get-Variable -Scope Global | Where-Object { $_.Value -eq "$result" -and $_.Value -isnot [bool]}).Name
    if ($result -like "x *") {
        $result = $result.Replace("x ", "")
    }
    if ($VariavelAtual.ms) {
        if ($VariavelAtual.st){
            
        } else {
            if ($global:OpcoesSelecionadas[$result] -ne "1") {
                Set-Variable -Name $NomeVariavelAtual -Value "x $result" -Scope Global
                $global:OpcoesSelecionadas["$result"] = "1"
            } elseif ($global:OpcoesSelecionadas[$result] -eq "1") {
                Set-Variable -Name $NomeVariavelAtual -Value "$result" -Scope Global
                $global:OpcoesSelecionadas["$result"] = "0"
            }
        }
    }
    & ($opcoes | Where-Object {$_.o -like $VariavelAtual.o}).a
}

function Menu1 {
    if (-not $Menu1) {
        $global:Menu1TodasOpcoes = "Selecionar tudo"
        $global:Menu1Sistema = "Sistema"
        $global:Menu1Ativacoes = "Ativações"
        $global:Menu1Customizacoes = "Customizações"
        $global:Menu1Sair = "Sair"
        $Menu1 = $True
    }
    $global:OpcoesMenu = @(
        @{o = $global:Menu1TodasOpcoes ; a = {Clear-Host ; Menu1} ; ms = $true ; st = $true},
        @{o = $global:Menu1Sistema ; a = {Clear-Host ; Menu1} ; ms = $true},
		@{o = $global:Menu1Ativacoes ; a = {Clear-Host ; Menu1} ; ms = $true},
		@{o = $global:Menu1Customizacoes ; a = {Clear-Host ; Menu1} ; ms = $true},
		@{o = $global:Menu1Sair ; a = {Clear-Host ; Menu1}}
        ) ; $OpcoesArray = $OpcoesMenu | ForEach-Object {@{o = $_.o ; a = $_.a ; ms = $_.ms ; st = $_.st}}
        OpcoesMenu -opcoes $OpcoesArray
}

    Menu1
