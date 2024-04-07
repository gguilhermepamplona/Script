Import-Module -Name ps-menu -Force

$global:opcaoselec = @{}

function OpcoesMenu([array]$opcoes) {
    [string]$result = Menu -menuItems ($opcoes.o)
    $resultnome = $opcoes | Where-Object {$_.o -eq $result}
    $OpcaoAtual = (Get-Variable -Scope Global | Where-Object { $_.Value -eq "$result" -and $_.Value -isnot [bool]}).Name
    if ($result -like "x *") {
        $result = $result.Replace("x ", "")
    }
    if ($resultnome.ms) {
        if ($resultnome.st){
            
        } 
        if ($global:opcaoselec[$result] -ne "1") {
            Set-Variable -Name $OpcaoAtual -Value "x $result" -Scope Global
            $global:opcaoselec["$result"] = "1"
        } elseif ($global:opcaoselec[$result] -eq "1") {
            Set-Variable -Name $OpcaoAtual -Value "$result" -Scope Global
            $global:opcaoselec["$result"] = "0"
        }
    }
    & ($opcoes | Where-Object {$_.o -like $resultnome.o}).a
}

function testemenu {
    $global:OpcoesMenu = @(
        @{o = $global:testemenuTodasOpcoes ; a = {Clear-Host ; testemenu} ; ms = $true ; st = $true},
        @{o = $global:testemenuSistema ; a = {Clear-Host ; testemenu} ; ms = $true},
		@{o = $global:testemenuAtivacoes ; a = {Clear-Host ; testemenu} ; ms = $true},
		@{o = $global:testemenuCustomizacoes ; a = {Clear-Host ; testemenu} ; ms = $true},
		@{o = $global:testemenuSair ; a = {Clear-Host ; testemenu}}
        ) ; $OpcoesArray = $OpcoesMenu | ForEach-Object {@{o = $_.o ; a = $_.a ; ms = $_.ms}}
        OpcoesMenu -opcoes $OpcoesArray
    }

function primeiro {
    $global:testemenuTodasOpcoes = "Selecionar tudo"
    $global:testemenuSistema = "Sistema"
    $global:testemenuAtivacoes = "Ativações"
    $global:testemenuCustomizacoes = "Customizações"
    $global:testemenuSair = "Sair"
    testemenu
}

primeiro
