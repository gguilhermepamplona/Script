Import-Module -Name ps-menu -Force

$global:opcaoselec = @{}

function OpcoesMenu([array]$opcoes) {
    [string]$result = Menu -menuItems ($opcoes.o)
    $resultnome = $opcoes | Where-Object {$_.o -eq $result}
    $teste = $resultnome.o
    $OpcaoAtual = Get-Variable -Scope Global | Where-Object { $_.Value -eq "$result" -and $_.Value -isnot [bool]}
    if ($result -like "x *") {
        $result = $result.Replace("x ", "")
    }
    if ($resultnome.ms) {
        if ($global:opcaoselec[$result] -ne "1") {
            ${global:$OpcaoAtual.Name} = "x " + $OpcaoAtual.Name
            $global:opcaoselec["$result"] = "1"
        } elseif ($global:opcaoselec[$result] -eq "1") {
            $OpcaoAtual.Name = $result ; $z = $opcoes | Where-Object {$_.o -eq "$teste"} ; $z.o = $result
            $global:opcaoselec["$result"] = "0"
        }
    }
    & ($opcoes | Where-Object {$_.o -eq $result}).a
}

function testemenu {
    $global:testemenuSistema = "Sistema"
    $global:testemenuAtivacoes = "Ativações"
    $global:OpcoesMenu = @(
		@{o = $global:testemenuSistema ; a = {Clear-Host ; testemenu} ; ms = $true},
		@{o = $global:testemenuAtivacoes ; a = {Clear-Host ; testemenu} ; ms = $true},
		@{o = "Customizações" ; a = {MenuCustomizacoes}},
		@{o = "Sair" ; a = {Sair}}
	) ; $OpcoesArray = $OpcoesMenu | ForEach-Object {@{o = $_.o ; a = $_.a ; ms = $_.ms}}
	OpcoesMenu -opcoes $OpcoesArray
}

testemenu