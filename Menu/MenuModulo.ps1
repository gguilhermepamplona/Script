# https://abre.ai/psscr
if(-not(Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)){
	Write-Host "Instalando NuGet..."
	Install-PackageProvider -Name NuGet -Force
}
$host.UI.RawUI.WindowTitle = "PS-Script"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
# Ativação do Windows
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Ativa%C3%A7%C3%A3o%20Windows.ps1" | Invoke-Expression
# Cursor
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Cursor.ps1" | Invoke-Expression
# Wallpaper
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Wallpaper.ps1" | Invoke-Expression
# Terminal
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Terminal.ps1" | Invoke-Expression
# Configurações do Sistema
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Configura%C3%A7%C3%B5es%20sistema.ps1" | Invoke-Expression
# Desinstalação de Apps
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Desinstala%C3%A7%C3%A3o%20apps.ps1" | Invoke-Expression
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Menu/configuracoes.ps1" | Invoke-Expression

if (-not (Get-Module -Name ps-menu -ListAvailable)) {
    Install-Module -Name ps-menu -Scope CurrentUser -Force
}
Import-Module -Name ps-menu -Force

function Cabecalho($menu, $submenu) {
	Clear-Host
	Write-Host "==========----------=========="
	Write-Host ""
	Write-Host "  ┏┓ ┏┓    ┏┓ ┏┓ ┳┓ ┳ ┏┓ ┏┳┓ "
	Write-Host "  ┃┃ ┗┓ ━━ ┗┓ ┃  ┣┫ ┃ ┃┃  ┃  "
	Write-Host "  ┣┛ ┗┛    ┗┛ ┗┛ ┛┗ ┻ ┣┛  ┻  "
	Write-Host ""
	Write-Host "==========----------=========="
	Write-Host ""
	Write-Host "↑ = Subir seleção"
	Write-Host "↓ = Baixar seleção"
	Write-Host "↵ = Selecionar"
	Write-Host "← = Fechar script"
	Write-Host ""
	Write-Host -NoNewline $menu
	Write-Host $submenu -ForegroundColor Blue
	Write-Host ""
}

# function OpcoesMenu([array]$opcoes) {
# 	$result = Menu -menuItems ($opcoes.o)
# 	& ($opcoes | Where-Object {$_.o -eq $result}).a
# }


function OpcoesMenu([array]$opcoes) {
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
	Cabecalho -submenu "Menu"
		$global:Menu1Sistema = "Sistema"
        $global:Menu1Ativacoes = "Ativações"
        $global:Menu1Customizacoes = "Customizações"
	$OpcoesMenu = @(
		@{o = $global:Menu1Sistema ; a = {MenuSistema}},
		@{o = $global:Menu1Ativacoes ; a = {MenuAtivacoes}},
		@{o = $global:Menu1Customizacoes ; a = {MenuCustomizacoes}}
	) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
	OpcoesMenu -opcoes $OpcoesArray
}
	function MenuSistema {
		Cabecalho -menu "Menu > " -submenu "Sistema"
			$global:MenuSistemaConfigSistema = "Configurações do sistema"
			$global:MenuSistemaDesinProg = "Desinstalação de Programas"
			$global:MenuSistemaInstProg = "Configuracoes (temporario)"
			$global:MenuSistemaDefrag = "Desfragmentação / Otimização"
			$global:MenuSistemaCTT = "CTT"
			$global:MenuSistemaVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuSistemaConfigSistema ; a = {MenuConfigSistema}},
			@{o = $global:MenuSistemaDesinProg ; a = {DesinstalacaoApps ; MenuSistema}}
			@{o = $global:MenuSistemaInstProg ; a = {configuracoes ; MenuSistema}},
			@{o = $global:MenuSistemaDefrag ; a = {DesfragmentacaoOtimizacao}},
			@{o = $global:MenuSistemaCTT ; a = {CTT}},
			@{o = $global:MenuSistemaVoltar ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}
		function MenuConfigSistema {
			Cabecalho -menu "Menu > Sistema > " -submenu "Configurações do sistema"
			$global:MenuConfigSistemaIniciarConfig = "Iniciar configuração"
			$global:MenuConfigSistemaAlterHost = "Alterar Hostname"
			$global:MenuConfigSistemaSelecOpcoes = "Selecionar Opcoes"
			$global:MenuConfigSistemaVoltar = "Voltar"
			$OpcoesMenu = @(
				@{o = $global:MenuConfigSistemaIniciarConfig ; a = {Configs ; MenuConfigSistema}},
				@{o = $global:MenuConfigSistemaAlterHost ; a = {AlterarHostname ; MenuConfigSistema}},
				@{o = $global:MenuConfigSistemaSelecOpcoes ; a = {MenuSelecConfigSistema}},
				@{o = $global:MenuConfigSistemaVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
		}
			function MenuSelecConfigSistema {
				Cabecalho -menu "Menu > Sistema > Configurações do sistema > " -submenu "Selecionar"
				if (-not $MenuSelecConfigSistema){
					$global:MenuSelecConfigSistemaIniciar = "Iniciar"
					$global:MenuSelecConfigSistemaSelecOpcoes = "Selecionar opções"
					$global:MenuSelecConfigSistemaVoltar = "Voltar"
					$MenuSelecConfigSistema = $true
				}
				$OpcoesMenu = @(
				@{o = $global:MenuSelecConfigSistemaIniciar ; a = {Configs ; MenuConfigSistema}},
				@{o = $global:MenuSelecConfigSistemaSelecOpcoes ; a = {MenuSelecConfigSistema}},
				@{o = $global:MenuSelecConfigSistemaVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a ; ms = $_.ms ; sa = $_.sa}}
			OpcoesMenu -opcoes $OpcoesArray
			}
			function DesfragmentacaoOtimizacao {
				Cabecalho -menu "Menu > Sistema > Configurações do sistema > " -submenu "Desfragmentação / Otimização"
				Write-Host "Será realizada desfragmentacao em HDs e otimizacao em SSDs." -ForegroundColor Yellow
				Write-Host ""
				$global:DesfragmentacaoOtimizacaoIniciar = "Iniciar"
				$global:DesfragmentacaoOtimizacaoVoltar = "Voltar"
				$OpcoesMenu = @(
				@{o = $global:DesfragmentacaoOtimizacaoIniciar ; a = {Get-Volume | Where-Object DriveLetter | Where-Object DriveType -eq Fixed | Optimize-Volume ; Start-Sleep -Seconds 2 ; MenuSistema}},
				@{o = $global:DesfragmentacaoOtimizacaoVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
			function CTT {
				Cabecalho -menu "Menu > Sistema > Configurações do sistema > " -submenu "CTT"
				$global:CTTIniciar = "Iniciar"
				$global:CTTVoltar = "Voltar"
				$OpcoesMenu = @(
				@{o = $global:CTTIniciar ; a = {Invoke-WebRequest -UseBasicParsing https://christitus.com/win | Invoke-Expression ; MenuSistema}},
				@{o = $global:CTTVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
	function MenuAtivacoes {
		Cabecalho -menu "Menu > " -submenu "Ativações"
		$global:MenuAtivacoesWindows = "Windows"
		$global:MenuAtivacoesOffice = "Office"
		$global:MenuAtivacoesVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuAtivacoesWindows ; a = {AtivacaoWindows ; MenuAtivacoes}},
			@{o = $global:MenuAtivacoesOffice ; a = {MenuAtivacoes}},
			@{o = $global:MenuAtivacoesVoltar ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
		}

	function MenuCustomizacoes {
		Cabecalho -menu "Menu > " -submenu "Customizações"
		$global:MenuCustomizacoesCursor = "Cursor"
		$global:MenuCustomizacoesWallpaper = "Wallpaper"
		$global:MenuCustomizacoesTerminal = "Terminal"
		$global:MenuCustomizacoesVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuCustomizacoesCursor ; a = {Cursor ; MenuCustomizacoes}},
			@{o = $global:MenuCustomizacoesWallpaper ; a = {Wallpaper ; MenuCustomizacoes}},
			@{o = $global:MenuCustomizacoesTerminal ; a = {Terminal ; MenuCustomizacoes}}
			@{o = $global:MenuCustomizacoesVoltar ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}

Menu1
