# https://abre.ai/psscr
# https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Menu/MenuModulo.ps1
# if(-not(Get-PackageProvider -Name NuGet -ErrorAction SilentlyContinue)){
# 	Write-Host "Instalando NuGet..."
# 	Install-PackageProvider -Name NuGet -Force
# }
$host.UI.RawUI.WindowTitle = "PS-Script"
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
# Ativação do Windows
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Sistema/Ativa%C3%A7%C3%A3o%20Windows.ps1" | Invoke-Expression
# Cursor
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Cursor.ps1" | Invoke-Expression
# Wallpaper
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Wallpaper.ps1" | Invoke-Expression
# Terminal
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Terminal.ps1" | Invoke-Expression
# Configurações do Sistema
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Sistema/Configura%C3%A7%C3%B5es%20sistema.ps1" | Invoke-Expression
# Desinstalação de Apps
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Sistema/Desinstala%C3%A7%C3%A3o%20apps.ps1" | Invoke-Expression
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Menu/configuracoes.ps1" | Invoke-Expression
# Windows Update
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Sistema/WindowsUpdate.ps1" | Invoke-Expression
# Correções
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Sistema/Corre%C3%A7%C3%A3o.ps1" | Invoke-Expression
# ps-menu
Invoke-WebRequest -UseBasicParsing "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Menu/ps-menu.ps1" | Invoke-Expression


# if (-not (Get-Module -Name ps-menu -ListAvailable)) {
#     Install-Module -Name ps-menu -Scope CurrentUser -Force
# }
# Import-Module -Name ps-menu -Force

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
		$global:Menu1InformacoesPC = "Informações do computador"
        $global:Menu1Ativacoes = "Ativações"
        $global:Menu1Customizacoes = "Customizações"
	$OpcoesMenu = @(
		@{o = $global:Menu1Sistema ; a = {MenuSistema}},
		@{o = $global:Menu1InformacoesPC ; a = {MenuInformacoesPC}},
		@{o = $global:Menu1Ativacoes ; a = {MenuAtivacoes}},
		@{o = $global:Menu1Customizacoes ; a = {MenuCustomizacoes}}
	) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
	OpcoesMenu -opcoes $OpcoesArray
}
	function MenuSistema {
		Cabecalho -menu "Menu > " -submenu "Sistema"
			$global:MenuSistemaConfigSistema = "Configurações do sistema"
			$global:MenuSistemaCorrecoes = "Verificações e correções"
			$global:MenuSistemaDesinProg = "Desinstalação de Programas"
			$global:MenuSistemaInstProg = "Configuracoes (temporario)"
			$global:MenuSistemaWindowsUpdate = "Windows Update"
			$global:MenuSistemaCTT = "CTT"
			$global:MenuSistemaVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuSistemaConfigSistema ; a = {MenuConfigSistema}},
			@{o = $global:MenuSistemaCorrecoes ; a = {MenuCorrec ; MenuSistema}},
			@{o = $global:MenuSistemaDesinProg ; a = {MenuDesinProg ; MenuSistema}}
			@{o = $global:MenuSistemaInstProg ; a = {configuracoes ; MenuSistema}},
			@{o = $global:MenuSistemaWindowsUpdate ; a = {MenuWindowsUpdate ; MenuSistema}},
			@{o = $global:MenuSistemaCTT ; a = {MenuCTT ; MenuSistema}},
			@{o = $global:MenuSistemaVoltar ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}
		function MenuConfigSistema {
			Cabecalho -menu "Menu > Sistema > " -submenu "Configurações do sistema"
			Write-Host "Em desenvolvimento" -ForegroundColor Yellow
			Write-Host ""
			Write-Host "Selecione as configurações desejadas em 'Configurações do Windows' ou 'Configurações de Rede'," -ForegroundColor Yellow
			Write-Host "ou execute as configurações recomendadas." -ForegroundColor Yellow
			Write-Host ""
			$global:MenuConfigSistemaConfigWindows = "Configurações do Windows"
			$global:MenuConfigSistemaConfigRede = "Configurações de Rede"
			$global:MenuConfigSistemaConfigSelecionada = "Executar configurações selecionadas"
			$global:MenuConfigSistemaConfigRecomendada = "Executar configurações recomendadas"
			$global:MenuConfigSistemaVoltar = "Voltar"
			$OpcoesMenu = @(
				@{o = $global:MenuConfigSistemaConfigWindows ; a = {MenuSelecConfigWindows}},
				@{o = $global:MenuConfigSistemaConfigRede ; a = {MenuSelecConfigRede}},
				@{o = $global:MenuConfigSistemaConfigSelecionada ; a = {MenuConfigSistema}},
				@{o = $global:MenuConfigSistemaConfigRecomendada ; a = {MenuConfigSistema}},
				@{o = $global:MenuConfigSistemaVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuSelecConfigWindows {
				Cabecalho -menu "Menu > Sistema > Configurações do sistema > " -submenu "Configurações do Windows"
				Write-Host "Em desenvolvimento" -ForegroundColor Yellow
				Write-Host ""
				if (-not $MenuSelecConfigSistema){
					$global:MenuSelecConfigSistemaIniciar = ""
					$global:MenuSelecConfigSistemaSelecOpcoes = ""
					$global:MenuSelecConfigSistemaVoltar = "Voltar"
					$MenuSelecConfigSistema = $true
				}
				$OpcoesMenu = @(
					@{o = $global:MenuSelecConfigSistemaIniciar ; a = {}},
					@{o = $global:MenuSelecConfigSistemaSelecOpcoes ; a = {}},
					@{o = $global:MenuSelecConfigSistemaVoltar ; a = {MenuConfigSistema}}
				) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a ; ms = $_.ms ; sa = $_.sa}}
				OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuSelecConfigRede {
				Cabecalho -menu "Menu > Sistema > Configurações do sistema > " -submenu "Configurações de Rede"
				Write-Host "Em desenvolvimento" -ForegroundColor Yellow
				Write-Host ""
				$global:MenuSelecConfigSistemaIniciar = ""
				$global:MenuSelecConfigSistemaSelecOpcoes = ""
				$global:MenuSelecConfigSistemaVoltar = "Voltar"
				$OpcoesMenu = @(
					@{o = $global:MenuSelecConfigSistemaIniciar ; a = {}},
					@{o = $global:MenuSelecConfigSistemaSelecOpcoes ; a = {}},
					@{o = $global:MenuSelecConfigSistemaVoltar ; a = {MenuConfigSistema}}
				) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a ; ms = $_.ms ; sa = $_.sa}}
				OpcoesMenu -opcoes $OpcoesArray
			}
		function MenuCorrec {
		Cabecalho -menu "Menu > Sistema > " -submenu "Verificações e Correções"
		$global:MenuCorrecDefrag = "Desfragmentação / Otimização"
		$global:MenuCorrecSFCDISM = "[sfc e dism] Verif. e Repar. do sistema de arquivos do Windows"
		$global:MenuCorrecCHKDSKOn = "[chkdsk online] Verif. e Repar. do disco"
		$global:MenuCorrecCHKDSKOff = "[chkdsk offline] Verif. e Repar. do disco"
		$global:MenuCorrecRestauracaoStore = "Restauração da Microsoft Store"
		$global:MenuCorrecIDERAIDparaAHCI = "IDE/RAID para AHCI"
		$global:MenuCorrecMBRparaGPT = "MBR para GPT"
		$global:MenuCorrecVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuCorrecDefrag ; a = {MenuDesfragmentacaoOtimizacao}},
			@{o = $global:MenuCorrecSFCDISM ; a = {MenuSFCDISM}},
			@{o = $global:MenuCorrecCHKDSKOn ; a = {MenuCHKDSKOnline}},
			@{o = $global:MenuCorrecCHKDSKOff ; a = {MenuCHKDSKOffline}},
			@{o = $global:MenuCorrecRestauracaoStore ; a = {MenuRestauracaoStore}},
			@{o = $global:MenuCorrecIDERAIDparaAHCI ; a = {MenuIDERAIDparaAHCI}},
			@{o = $global:MenuCorrecMBRparaGPT ; a = {MenuMBRparaGPT}},
			@{o = $global:MenuCorrecVoltar ; a = {MenuSistema}}
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
			function MenuRestauracaoStore{
					Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "Restauração da Microsoft Store"
					Write-Host "É recomendado utilizar o primeiro método. Caso não resolva, tente o segundo método." -ForegroundColor Yellow
					Write-Host "OBS: A ação será executada imediatamente." -ForegroundColor Red
					Write-Host ""
					$global:MenuRestauracaoStoreWSReset = "Método 1: wsreset"
					$global:MenuRestauracaoStoreAppx = "Método 2: Get-AppxPackage"
					$global:MenuRestauracaoStoreVoltar = "Voltar"
					$OpcoesMenu = @(
						@{o = $global:MenuRestauracaoStoreWSReset ; a = {WSReset.exe ; MenuRestauracaoStore}},
						@{o = $global:MenuRestauracaoStoreAppx ; a = {StoreAppx ; MenuRestauracaoStore}},
						@{o = $global:MenuRestauracaoStoreVoltar ; a = {MenuCorrec}}
					) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
					OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuIDERAIDparaAHCI{
					Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "IDE/RAID para AHCI"
					Write-Host "Altera de IDE ou RAID para AHCI sem a necessidade de formatação." -ForegroundColor Yellow
					Write-Host "Para realizar essa configuração, siga os passos:" -ForegroundColor Yellow
					Write-Host "1: execute ""Executar (pré-reinicialização)""" -ForegroundColor Yellow
					Write-Host "2: reinicie e altere na BIOS de IDE ou RAID para AHCI" -ForegroundColor Yellow
					Write-Host "3: execute ""Executar (pós-reinicialização)""" -ForegroundColor Yellow
					Write-Host "4: reinicie" -ForegroundColor Yellow
					Write-Host ""
					$global:MenuIDERAIDparaAHCIPre = "Executar (pré-reinicialização)"
					$global:MenuIDERAIDparaAHCIPos = "Executar (pós-reinicialização)"
					$global:MenuIDERAIDparaAHCIVoltar = "Voltar"
					$OpcoesMenu = @(
						@{o = $global:MenuIDERAIDparaAHCIPre ; a = {IDERAIDparaAHCIpre ; MenuReiniciar -cabecalho "Menu > Sistema > Verificações e Correções > IDE/RAID para AHCI > " -voltar MenuIDERAIDparaAHCI}},
						@{o = $global:MenuIDERAIDparaAHCIPos ; a = {IDERAIDparaAHCIpos ; MenuIDERAIDparaAHCI}},
						@{o = $global:MenuIDERAIDparaAHCIVoltar ; a = {MenuCorrec}}
					) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
					OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuMBRparaGPT{
					Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "MBR para GPT"
					Write-Host "Altera de MBR para GPT sem a necessidade de formatação." -ForegroundColor Yellow
					Write-Host "Para realizar essa configuração, siga os passos:" -ForegroundColor Yellow
					Write-Host "1: execute ""Executar""" -ForegroundColor Yellow
					Write-Host "2: reinicie e altere na BIOS de Legacy para UEFI" -ForegroundColor Yellow
					Write-Host "3: reinicie" -ForegroundColor Yellow
					Write-Host ""
					$global:MenuMBRparaGPTExecutar = "Executar"
					$global:MenuMBRparaGPTvoltar = "Voltar"
					$OpcoesMenu = @(
						@{o = $global:MenuMBRparaGPTExecutar ; a = {MBRparaGPT ; MenuReiniciar -cabecalho "Menu > Sistema > Verificações e Correções > MBR para GPT > " -voltar MenuMBRparaGPT}},
						@{o = $global:MenuMBRparaGPTvoltar ; a = {MenuCorrec}}
					) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
					OpcoesMenu -opcoes $OpcoesArray
			}
		function MenuDesinProg {
			Cabecalho -menu "Menu > Sistema > " -submenu "Desinstalação de Programas"
			Write-Host "Desinstalação de programas inúteis do Windows." -ForegroundColor Yellow
			Write-Host "Não é possível selecionar programas específicos, por enquanto. Funcionalidade em desenvolvimento." -ForegroundColor Yellow
			Write-Host ""
			$global:MenuDesinProgIniciar = "Iniciar"
			$global:MenuDesinProgVoltar = "Voltar"
			$OpcoesMenu = @(
				@{o = $global:MenuDesinProgIniciar ; a = {DesinstalacaoApps ; MenuDesinstalacaoApps}},
				@{o = $global:MenuDesinProgVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
		}
		function MenuWindowsUpdate {
			Cabecalho -menu "Menu > Sistema > " -submenu "Windows Update"
			Write-Host "Atualização do Windows através do Powershell." -ForegroundColor Yellow
			Write-Host ""
			$global:WindowsUpdateIniciar = "Iniciar"
			$global:WindowsUpdateVoltar = "Voltar"
			$OpcoesMenu = @(
				@{o = $global:WindowsUpdateIniciar ; a = {WindowsUpdateCLI ; MenuSistema}},
				@{o = $global:WindowsUpdateVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
		}
		function MenuCTT {
			Cabecalho -menu "Menu > Sistema > " -submenu "CTT"
			Write-Host "CTT (Chris Titus Tech) é um programa desenvolvido em Powershell com uma vasta quantidade de otimizações para o Windows." -ForegroundColor Yellow
			Write-Host "É recomendada a sua utilização pois nem todas opções estão contidas neste script, por enquanto." -ForegroundColor Yellow
			Write-Host ""
			$global:CTTIniciar = "Iniciar"
			$global:CTTVoltar = "Voltar"
			$OpcoesMenu = @(
				@{o = $global:CTTIniciar ; a = {Invoke-WebRequest -UseBasicParsing https://christitus.com/win | Invoke-Expression ; MenuSistema}},
				@{o = $global:CTTVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
		}
	function MenuInformacoesPC {
		Cabecalho -menu "Menu > " -submenu "Informações do computador"
		$global:MenuInformacoesPCExibInfo = "Exibir informações"
		$global:MenuInformacoesPCVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuInformacoesPCExibInfo ; a = {InformacoesPC ; MenuInformacoesPC}},
			@{o = $global:MenuInformacoesPCVoltar ; a = {Menu1}}
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
	function MenuReiniciar{
		param($cabecalho, $voltar)
		Cabecalho -menu $cabecalho -submenu "Reiniciar"
		Write-Host "Você deseja reiniciar o computador agora?" -ForegroundColor Yellow
		Write-Host "OBS: o computador será reiniciado imediatamente." -ForegroundColor Red
		Write-Host ""
		$global:MenuReiniciarSim = "Reiniciar Agora"
		$global:MenuReiniciarNao = "Reiniciar Depois"
		$OpcoesMenu = @(
			@{o = $global:MenuReiniciarSim ; a = {Restart-Computer}},
			@{o = $global:MenuReiniciarNao ; a = {$voltar}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}
	function MenuConfirmacao{
		param($cabecalho, $voltar, $acao)
		Cabecalho -menu $cabecalho -submenu "Confirmação"
		Write-Host "Você tem certeza que deseja executar a ação selecionada?" -ForegroundColor Yellow
		Write-Host ""
		$global:MenuConfimacaoExecutar = "Executar"
		$global:MenuConfirmacaoCancelar = "Cancelar"
		$OpcoesMenu = @(
			@{o = $global:MenuConfimacaoExecutar ; a = {}},
			@{o = $global:MenuConfirmacaoCancelar ; a = {$voltar}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}

Menu1
