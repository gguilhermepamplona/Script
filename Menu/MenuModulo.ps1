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

function OpcoesMenu([array]$opcoes, [switch]$Multiselect) {
	if ($Multiselect) {
		$result = Menu -menuItems ($opcoes.o) -Multiselect
	} else {
		$result = Menu -menuItems ($opcoes.o)
	}
    if ($null -ne $result) {
        $acao = ($opcoes | Where-Object {$_.o -eq $result}).a
        if ($acao) {
            & $acao
        }
    } else {
        Write-Host "Operação cancelada pelo usuário." -ForegroundColor Yellow
    }
}

function Menu1 {
	Cabecalho -submenu "Menu"
		$global:Menu1Sistema = "Sistema *"
		$global:Menu1InformacoesPC = "Informações do computador *"
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
			$global:MenuSistemaConfigSistema = "Configurações do sistema *"
			$global:MenuSistemaCorrecoes = "Verificações e correções"
			$global:MenuSistemaDesinProg = "Desinstalação de Programas *"
			$global:MenuSistemaInstProg = "Configuracoes (temporario - apagar em breve)"
			$global:MenuSistemaWindowsUpdate = "Windows Update"
			$global:MenuSistemaCTT = "CTT"
			$global:MenuSistemaVoltar = "Voltar"
		$OpcoesMenu = @(
			@{o = $global:MenuSistemaConfigSistema ; a = {MenuConfigSistema}},
			@{o = $global:MenuSistemaCorrecoes ; a = {MenuCorrec ; MenuSistema}},
			@{o = $global:MenuSistemaDesinProg ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Desinstalação de programas inúteis do Windows.`nNão é possível selecionar programas específicos, por enquanto. Funcionalidade em desenvolvimento.`nPara desinstalação mais completa (registro do SO), utilize o Revo Uninstaller." -cabecalho "Menu > Sistema > " -submenu "Desinstalação de Programas" -voltar MenuSistema -acao DesinstalacaoApps ; MenuSistema}}
			@{o = $global:MenuSistemaInstProg ; a = {configuracoes ; MenuSistema}},
			@{o = $global:MenuSistemaWindowsUpdate ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Atualização do Windows através do Powershell." -cabecalho "Menu > Sistema > " -submenu "Windows Update" -voltar MenuSistema -acao WindowsUpdateCLI ; MenuSistema}},
			@{o = $global:MenuSistemaCTT ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "CTT (Chris Titus Tech) é um programa desenvolvido em Powershell com uma vasta quantidade de otimizações para o Windows.`nÉ recomendada a sua utilização pois nem todas opções estão contidas neste script, por enquanto." -cabecalho "Menu > Sistema > " -submenu "CTT" -voltar MenuSistema -acao {Invoke-WebRequest -UseBasicParsing https://christitus.com/win | Invoke-Expression} ; MenuSistema}},
			@{o = $global:MenuSistemaVoltar ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}
		function MenuConfigSistema {
			Cabecalho -menu "Menu > Sistema > " -submenu "Configurações do sistema"
			Write-Host "Em desenvolvimento`n" -ForegroundColor Yellow
			Write-Host "Selecione as configurações desejadas em 'Configurações do Windows' ou 'Configurações de Rede'," -ForegroundColor Yellow
			Write-Host "ou execute as configurações recomendadas.`n" -ForegroundColor Yellow
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
				Write-Host "Em desenvolvimento`n" -ForegroundColor Yellow
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
				Write-Host "Em desenvolvimento`n" -ForegroundColor Yellow
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
			@{o = $global:MenuCorrecDefrag ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Será realizada desfragmentacao em HDs e otimização em SSDs." -cabecalho "Menu > Sistema > Verificações e Correções > " -submenu "Desfragmentação / Otimização"-voltar MenuCorrec -acao DesfragmentacaoOtimizacao ; MenuCorrec}},
			@{o = $global:MenuCorrecSFCDISM ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Será executado ""Repair-WindowsImage"", no qual é equivalente ao sfc e dism." -cabecalho "Menu > Sistema > Verificações e Correções > " -submenu "Verificação e reparação do sistema de arquivos do Windows" -voltar MenuCorrec -acao SFCDISM ; MenuCorrec}},
			@{o = $global:MenuCorrecCHKDSKOn ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Será executado ""Repair-Volume"" online (dentro do sistema), no qual é equivalente ao chkdsk." -cabecalho "Menu > Sistema > Verificações e Correções > " -submenu "Verificação e reparação do disco online" -voltar MenuCorrec -acao CHKDSKOnline ; MenuCorrec}},
			@{o = $global:MenuCorrecCHKDSKOff ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Será executado ""Repair-Volume"" offline (fora do sistema), no qual é equivalente ao chkdsk." -cabecalho "Menu > Sistema > Verificações e Correções > " -submenu "Verificação e reparação do disco offline" -voltar MenuCorrec -acao CHKDSKOffline ; MenuCorrec}},
			@{o = $global:MenuCorrecRestauracaoStore ; a = {MenuRestauracaoStore}},
			@{o = $global:MenuCorrecIDERAIDparaAHCI ; a = {MenuIDERAIDparaAHCI}},
			@{o = $global:MenuCorrecMBRparaGPT ; a = {MenuConfirmacao -confirmacaodescricao 1 -descricao "Altera de MBR para GPT sem a necessidade de formatação.`nPara realizar essa configuração, siga os passos:`n1: execute ""Executar""`n2: reinicie e altere na BIOS de Legacy para UEFI`n3: reinicie" -cabecalho "Menu > Sistema > Verificações e Correções > " -submenu "MBR para GPT" -voltar MenuCorrec -acao MBRparaGPT ; MenuCorrec}},
			@{o = $global:MenuCorrecVoltar ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		$retorno = OpcoesMenu -opcoes $OpcoesArray
		if ($retorno -eq "backspace") {
		MenuSistema
		return
		}
		}
			function MenuRestauracaoStore{
					Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "Restauração da Microsoft Store"
					Write-Host "É recomendado utilizar o primeiro método. Caso não resolva, tente o segundo método." -ForegroundColor Yellow
					Write-Host "OBS: A ação será executada imediatamente.`n" -ForegroundColor Red
					$global:MenuRestauracaoStoreWSReset = "Método 1: wsreset"
					$global:MenuRestauracaoStoreAppx = "Método 2: Get-AppxPackage"
					$global:MenuRestauracaoStoreVoltar = "Voltar"
					$OpcoesMenu = @(
						@{o = $global:MenuRestauracaoStoreWSReset ; a = {MenuConfirmacao -cabecalho "Menu > Sistema > Verificações e Correções > Restauração da Microsoft Store > " -submenu "Método 1: wsreset" -voltar MenuRestauracaoStore -acao WSReset.exe ; MenuRestauracaoStore}},
						@{o = $global:MenuRestauracaoStoreAppx ; a = {MenuConfirmacao -cabecalho "Menu > Sistema > Verificações e Correções > Restauração da Microsoft Store > " -submenu "Método 2: Get-AppxPackage" -voltar MenuRestauracaoStore -acao StoreAppx ; MenuRestauracaoStore}},
						@{o = $global:MenuRestauracaoStoreVoltar ; a = {MenuCorrec}}
					) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
					OpcoesMenu -opcoes $OpcoesArray
			}
			function MenuIDERAIDparaAHCI{
					Cabecalho -menu "Menu > Sistema > Verificações e Correções > " -submenu "IDE/RAID para AHCI"
					Write-Host "Altera de IDE ou RAID para AHCI sem a necessidade de formatação." -ForegroundColor Yellow
					Write-Host "Para realizar essa configuração, siga os passos:" -ForegroundColor Yellow
					Write-Host "1: execute ""Executar pré-reinicialização""" -ForegroundColor Yellow
					Write-Host "2: reinicie e altere na BIOS de IDE ou RAID para AHCI" -ForegroundColor Yellow
					Write-Host "3: execute ""Executar pós-reinicialização""" -ForegroundColor Yellow
					Write-Host "4: reinicie`n" -ForegroundColor Yellow
					$global:MenuIDERAIDparaAHCIPre = "Executar pré-reinicialização"
					$global:MenuIDERAIDparaAHCIPos = "Executar pós-reinicialização"
					$global:MenuIDERAIDparaAHCIVoltar = "Voltar"
					$OpcoesMenu = @(
						@{o = $global:MenuIDERAIDparaAHCIPre ; a = {MenuConfirmacao -cabecalho "Menu > Sistema > Verificações e Correções > IDE/RAID para AHCI > " -submenu "Executar pré-reinicialização" -voltar MenuIDERAIDparaAHCI -acao IDERAIDparaAHCIpre ; if($global:v -eq 1){MenuReiniciar -cabecalho "Menu > Sistema > Verificações e Correções > IDE/RAID para AHCI > Executar pré-reinicialização > " -submenu "Reiniciar" -voltar MenuIDERAIDparaAHCI}}},
						@{o = $global:MenuIDERAIDparaAHCIPos ; a = {MenuConfirmacao -cabecalho "Menu > Sistema > Verificações e Correções > IDE/RAID para AHCI > " -submenu "Executar pós-reinicialização" -voltar MenuIDERAIDparaAHCI -acao IDERAIDparaAHCIpos ; MenuIDERAIDparaAHCI}},
						@{o = $global:MenuIDERAIDparaAHCIVoltar ; a = {MenuCorrec}}
					) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
					OpcoesMenu -opcoes $OpcoesArray
			}
	function MenuInformacoesPC {
		Cabecalho -menu "Menu > " -submenu "Informações do computador"
		Write-Host "Gera um relatório com todas as informações do computador.`n" -ForegroundColor Yellow
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
			@{o = $global:MenuAtivacoesWindows ; a = {MenuConfirmacao -cabecalho "Menu > Ativações > " -submenu "Windows" -voltar MenuAtivacoes -acao AtivacaoWindows ; MenuAtivacoes}},
			@{o = $global:MenuAtivacoesOffice ; a = {MenuConfirmacao -cabecalho "Menu > Ativações > " -submenu "Office" -voltar MenuAtivacoes -acao AtivacaoOffice ; MenuAtivacoes}},
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
	function MenuConfirmacao{
		param($confirmacaodescricao, $descricao, $cabecalho, $submenu, $voltar, $acao)
		Cabecalho -menu $cabecalho -submenu $submenu
		if ($confirmacaodescricao -eq 1){
			Write-Host $descricao`n -ForegroundColor Yellow
		} else {
			Write-Host "Você tem certeza que deseja executar a ação selecionada?`n" -ForegroundColor Yellow
		}
		$global:MenuConfimacaoExecutar = "Executar"
		$global:MenuConfirmacaoCancelar = "Cancelar"
		$OpcoesMenu = @(
			@{o = $global:MenuConfimacaoExecutar ; a = {$global:v = 1 ; & $acao}},
			@{o = $global:MenuConfirmacaoCancelar ; a = {$global:v = 0 ; & $voltar}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}
	function MenuReiniciar{
		param($cabecalho, $submenu, $voltar)
		Cabecalho -menu $cabecalho -submenu $submenu
		Write-Host "Você deseja reiniciar o computador agora?" -ForegroundColor Yellow
		Write-Host "OBS: o computador será reiniciado imediatamente.`n" -ForegroundColor Red
		$global:MenuReiniciarSim = "Reiniciar Agora"
		$global:MenuReiniciarNao = "Reiniciar Depois"
		$OpcoesMenu = @(
			@{o = $global:MenuReiniciarSim ; a = {Restart-Computer}},
			@{o = $global:MenuReiniciarNao ; a = {& $voltar}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}

Menu1
