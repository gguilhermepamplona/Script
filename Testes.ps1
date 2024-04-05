Import-Module -Name ps-menu -Force

$global:opcaoselec = @{}
$global:nome = "teste"

function OpcoesMenu([array]$opcoes) {
	$result = Menu -menuItems ($opcoes.o)
    $resultnome = $opcoes | Where-Object {$_.o -eq $result}
    if ($result -like "x ") {
        $result2 = $result.Replace("x ", "")
    }
    if ($resultnome.ms) {
        if ($global:opcaoselec.$result -ne "1" -or $global:opcaoselec.$result2 -ne "1") {
            $global:opcaoselec["$result"] = "1"
            $global:nome = "x " + $global:nome
        } elseif ($global:opcaoselec.$result -eq "1") {
            $global:opcaoselec["$global:nome"] = "0"
            $global:nome.Replace("x ", "")
        }
    }
    & ($opcoes | Where-Object {$_.o -eq $result}).a
}

function testemenu {
    $global:OpcoesMenu = @(
		@{o = $global:nome ; a = {Clear-Host ; testemenu} ; ms = $true},
		@{o = "Ativações" ; a = {MenuAtivacoes}},
		@{o = "Customizações" ; a = {MenuCustomizacoes}},
		@{o = "Sair" ; a = {Sair}}
	) ; $OpcoesArray = $OpcoesMenu | ForEach-Object {@{o = $_.o ; a = $_.a ; ms = $_.ms}}
	OpcoesMenu -opcoes $OpcoesArray
}

function primeiro {
    $global:nome = "Sistema"
    testemenu
}

primeiro
