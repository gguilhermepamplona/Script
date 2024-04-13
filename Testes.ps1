Import-Module -Name ps-menu -Force

function OpcoesMenu([array]$opcoes) {
    Clear-Host
    [string]$result = Menu -menuItems ($opcoes.o)
    $VariavelAtual = $opcoes | Where-Object {$_.o -eq $result}
    $NomeVariavelAtual = (Get-Variable -Scope Global | Where-Object { $_.Value -eq "$result" -and $_.Value -isnot [bool]}).Name
    function OpcoesSelecionadas($sel, $var, $var2) {
        [string]$AlteraVar = $var.Value
        $a = $AlteraVar.ToCharArray() ; $a[1] = "$sel" ; $a = -join $a ; Set-Variable -Name $var2 -Value $a -Scope Global
    }
    if ($result -like "[x]*") {
        $result = $result.Replace("[x]", "[ ]")
    }
    if ($VariavelAtual.ms) {
        if ($VariavelAtual.sa){
            if ($VariavelAtual.o.Substring(1,1) -eq " "){
                $b = ($OpcoesMenu | Where-Object {$_.ms -eq $true}).o
                foreach ($j in $b) {
                    $k = (Get-Variable -Scope Global | Where-Object { $_.Value -eq "$j" -and $_.Value -isnot [bool]})
                    OpcoesSelecionadas -sel "x" -var $k -var2 $k.Name
                }
            } else {
                $b = ($OpcoesMenu | Where-Object {$_.ms -eq $true}).o
                foreach ($j in $b) {
                    $k = (Get-Variable -Scope Global | Where-Object { $_.Value -eq "$j" -and $_.Value -isnot [bool]})
                    OpcoesSelecionadas -sel " " -var $k -var2 $k.Name
                }
            }
        } else {
            if ($result.Substring(1,1) -ne "x") {
                OpcoesSelecionadas -sel "x" -var $(Get-Variable -Name $NomeVariavelAtual) -var2 $NomeVariavelAtual
            } else {
                OpcoesSelecionadas -sel " " -var $(Get-Variable -Name $NomeVariavelAtual) -var2 $NomeVariavelAtual
            }
        }
    }
    & ($opcoes | Where-Object {$_.o -eq $result}).a
}

function Menu1 {
    if (-not $Menu1) {
        $global:Menu1TodasOpcoes = "[ ] Selecionar tudo"
        $global:Menu1Sistema = "[ ] Sistema"
        $global:Menu1Ativacoes = "[ ] Ativações"
        $global:Menu1Customizacoes = "[ ] Customizações"
        $global:Menu1Sair = "Sair"
        $Menu1 = $True
    }
    $global:OpcoesMenu = @(
        @{o = $global:Menu1TodasOpcoes ; a = {Clear-Host ; Menu1} ; ms = $true ; sa = $true},
        @{o = $global:Menu1Sistema ; a = {Clear-Host ; Menu1} ; ms = $true},
		@{o = $global:Menu1Ativacoes ; a = {Clear-Host ; Menu1} ; ms = $true},
		@{o = $global:Menu1Customizacoes ; a = {Clear-Host ; Menu1} ; ms = $true},
		@{o = $global:Menu1Sair ; a = {Clear-Host ; Menu1}}
        ) ; $OpcoesArray = $OpcoesMenu | ForEach-Object {@{o = $_.o ; a = $_.a ; ms = $_.ms ; sa = $_.sa}}
        OpcoesMenu -opcoes $OpcoesArray
}

    Menu1
