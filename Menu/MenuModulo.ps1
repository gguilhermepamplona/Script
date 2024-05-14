# https://abre.ai/psscr
if(-not(Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)){
	Write-Host "Instalando NuGet..."
	Install-PackageProvider -Name NuGet -Force
}
$host.UI.RawUI.WindowTitle = "PS-Script"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
# Ativação do Windows
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Ativa%C3%A7%C3%A3o%20Windows.ps1" | Invoke-Expression
# Cursor
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Cursor.ps1" | Invoke-Expression
# Wallpaper
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Wallpaper.ps1" | Invoke-Expression
# Terminal
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Terminal.ps1" | Invoke-Expression
# Configurações do Sistema
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Configura%C3%A7%C3%B5es%20sistema.ps1" | Invoke-Expression
# Desinstalação de Apps
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Desinstala%C3%A7%C3%A3o%20apps.ps1" | Invoke-Expression
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Menu/configuracoes.ps1" | Invoke-Expression
# Windows Update
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/WindowsUpdate.ps1" | Invoke-Expression

if (-not (Get-Module -Name ps-menu -ListAvailable)) {
    Install-Module -Name ps-menu -Scope CurrentUser -Force
}
Import-Module -Name ps-menu -Force

function Cabecalho($menu, $submenu) {
	Clear-Host
	Write-Host "==========----------==========" 
	Write-Host ""
	Write-Host "  ┏┓ ┏┓    ┏┓ ┏┓ ┳┓ ┳ ┏┓ ┏┳┓ " -ForegroundColor DarkMagenta
	Write-Host "  ┃┃ ┗┓ ━━ ┗┓ ┃  ┣┫ ┃ ┃┃  ┃  " -ForegroundColor DarkMagenta
	Write-Host "  ┣┛ ┗┛    ┗┛ ┗┛ ┛┗ ┻ ┣┛  ┻  " -ForegroundColor DarkMagenta
	Write-Host ""
	Write-Host "==========----------==========" 
	Write-Host ""
	Write-Host "↑ = Subir seleção"
	Write-Host "↓ = Baixar seleção"
	Write-Host "↵ = Selecionar"
	Write-Host "← = Fechar script"
	Write-Host ""
	Write-Host -NoNewline $menu
	Write-Host $submenu -ForegroundColor Red
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
			$global:MenuSistemaCorrecoes = "Verificações e correções"
			$global:MenuSistemaWindowsUpdate = "Windows Update"
			$global:MenuSistemaDesinProg = "Desinstalação de Programas"
			$global:MenuSistemaInstProg = "Configuracoes (temporario)"
			$global:MenuSistemaCTT = "CTT"
			$global:MenuSistemaVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuSistemaConfigSistema ; a = {MenuConfigSistema}},
			@{o = $global:MenuSistemaCorrecoes ; a = {MenuCorrec ; MenuSistema}},
			@{o = $global:MenuSistemaWindowsUpdate ; a = {WindowsUpdate ; MenuSistema}},
			@{o = $global:MenuSistemaDesinProg ; a = {DesinstalacaoApps ; MenuSistema}}
			@{o = $global:MenuSistemaInstProg ; a = {configuracoes ; MenuSistema}},
			@{o = $global:MenuSistemaCTT ; a = {Invoke-WebRequest -UseBasicParsing https://christitus.com/win | Invoke-Expression ; MenuSistema}},
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
		function MenuCorrec {
		Cabecalho -menu "Menu > Sistema > " -submenu "Verificações e Correções"
		$global:MenuCorrecSFCDISM = "[sfc e dism] Verif. e Repar. do sistema de arquivos do Windows"
		$global:MenuCorrecCHKDSKOn = "[chkdsk online] Verif. e Repar. do disco"
		$global:MenuCorrecCHKDSKOff = "[chkdsk offline] Verif. e Repar. do disco"
		$global:MenuCorrecDefrag = "Desfragmentação / Otimização"
		$global:MenuCorrecVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuCorrecSFCDISM ; a = {MenuSFCDISM}},
			@{o = $global:MenuCorrecCHKDSKOn ; a = {MenuCHKDSKOnline}},
			@{o = $global:MenuCorrecCHKDSKOff ; a = {MenuCHKDSKOffline}},
			@{o = $global:MenuCorrecDefrag ; a = {MenuDesfragmentacaoOtimizacao}},
			@{o = $global:MenuCorrecVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
		}
			function MenuSFCDISM {
				Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "Verificação e reparação do sistema de arquivos do Windows"
				Write-Host "Será executado ""Repair-WindowsImage"", no qual é equivalente ao sfc e dism." -ForegroundColor Yellow
				Write-Host ""
				$global:MenuSFCDISMIniciar = "Iniciar"
				$global:MenuSFCDISMVoltar = "Voltar"
				$OpcoesMenu = @(
				@{o = $global:MenuSFCDISMIniciar ; a = {SFCDISM ; MenuSFCDISM}},
				@{o = $global:MenuSFCDISMVoltar ; a = {MenuCorrec}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuCHKDSKOnline {
				Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "Verificação e reparação do disco online"
				Write-Host "Será executado ""Repair-Volume"" online (dentro do sistema), no qual é equivalente ao chkdsk." -ForegroundColor Yellow
				Write-Host ""
				$global:MenuCHKDSKIniciar = "Iniciar"
				$global:MenuCHKDSKVoltar = "Voltar"
				$OpcoesMenu = @(
				@{o = $global:MenuCHKDSKIniciar ; a = {CHKDSKOnline ; MenuCHKDSKOnline}},
				@{o = $global:MenuCHKDSKVoltar ; a = {MenuCorrec}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuCHKDSKOffline {
				Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "Verificação e reparação do disco offline"
				Write-Host "Será executado ""Repair-Volume"" offline (fora do sistema), no qual é equivalente ao chkdsk." -ForegroundColor Yellow
				Write-Host "OBS: será agendado um chkdsk antes da inicialização do sistema para a próxima reinicialização." -ForegroundColor Yellow
				Write-Host ""
				$global:MenuCHKDSKIniciar = "Iniciar"
				$global:MenuCHKDSKVoltar = "Voltar"
				$OpcoesMenu = @(
				@{o = $global:MenuCHKDSKIniciar ; a = {CHKDSKOffline ; MenuCHKDSKOffline}},
				@{o = $global:MenuCHKDSKVoltar ; a = {MenuCorrec}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuDesfragmentacaoOtimizacao {
				Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "Desfragmentação / Otimização"
				Write-Host "Será realizada desfragmentacao em HDs e otimização em SSDs." -ForegroundColor Yellow
				Write-Host ""
				$global:MenuDesfragmentacaoOtimizacaoIniciar = "Iniciar"
				$global:MenuDesfragmentacaoOtimizacaoVoltar = "Voltar"
				$OpcoesMenu = @(
				@{o = $global:MenuDesfragmentacaoOtimizacaoIniciar ; a = {DesfragmentacaoOtimizacao ; MenuCorrec}},
				@{o = $global:MenuDesfragmentacaoOtimizacaoVoltar ; a = {MenuCorrec}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
		function CTT {
			Cabecalho -menu "Menu > Sistema > " -submenu "CTT"
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
