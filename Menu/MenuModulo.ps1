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

function OpcoesMenu([array]$opcoes) {
	$result = Menu -menuItems ($opcoes.o)
	& ($opcoes | Where-Object {$_.o -eq $result}).a
}

function Menu1 {
	Cabecalho -submenu "Menu"
	$OpcoesMenu = @(
		@{o = "Sistema" ; a = {MenuSistema}},
		@{o = "Ativações" ; a = {MenuAtivacoes}},
		@{o = "Customizações" ; a = {MenuCustomizacoes}}
		# @{o = "Sair" ; a = {Sair}}
	) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
	OpcoesMenu -opcoes $OpcoesArray
}
	function MenuSistema {
		Cabecalho -menu "Menu > " -submenu "Sistema"
		$OpcoesMenu = @(
			@{o = "Configurações do sistema" ; a = {MenuConfigSistema}},
			@{o = "Desinstalação de Programas" ; a = {DesinstalacaoApps ; MenuSistema}}
			@{o = "Instalação de Programas" ; a = {MenuSistema}},
			@{o = "Desfragmentação" ; a = {Get-Volume | Where-Object DriveLetter | Where-Object DriveType -eq Fixed | Optimize-Volume ; MenuSistema}},
			@{o = "CTT" ; a = {Invoke-WebRequest -UseBasicParsing https://christitus.com/win | Invoke-Expression ; MenuSistema}},
			@{o = "Voltar" ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}
		function MenuConfigSistema {
			Cabecalho -menu "Menu > Sistema > " -submenu "Configurações do sistema"
			$OpcoesMenu = @(
				@{o = "Iniciar configuração" ; a = {Configs ; MenuConfigSistema}},
				@{o = "Alterar Hostname" ; a = {AlterarHostname ; MenuConfigSistema}},
				@{o = "Selecionar" ; a = {MenuSelecConfigSistema}},
				@{o = "Voltar" ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
		}
			function MenuSelecConfigSistema {
				Cabecalho -menu "Menu > Sistema > Configurações do sistema > " -submenu "Selecionar"
				$OpcoesMenu = @(
				@{o = "Iniciar" ; a = {Configs ; MenuConfigSistema}},
				@{o = "Selecionar opções" ; a = {MenuSelecConfigSistema}},
				@{o = "Voltar" ; a = {MenuSistema}}
			) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
			OpcoesMenu -opcoes $OpcoesArray
			}

	function MenuAtivacoes {
		Cabecalho -menu "Menu > " -submenu "Ativações"
		$OpcoesMenu = @(
			@{o = "Windows" ; a = {AtivacaoWindows ; MenuAtivacoes}},
			@{o = "Office" ; a = {MenuAtivacoes}},
			@{o = "Voltar" ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
		}

	function MenuCustomizacoes {
		Cabecalho -menu "Menu > " -submenu "Customizações"
		$OpcoesMenu = @(
			@{o = "Cursor" ; a = {Cursor ; MenuCustomizacoes}},
			@{o = "Wallpaper" ; a = {Wallpaper ; MenuCustomizacoes}},
			@{o = "Terminal" ; a = {Terminal ; MenuCustomizacoes}}
			@{o = "Voltar" ; a = {Menu1}}
		) ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
		OpcoesMenu -opcoes $OpcoesArray
	}

	# function Sair {
	# 	Cabecalho -menu "Menu > " -submenu "Sair"
	# 	Write-Host "Tem certeza que deseja sair?" -ForegroundColor Yellow
	# 	$OpcoesMenu = @(
	# 		@{o = "Sim" ; a = {Clear-Host ; Exit-PSHostProcess}}
	# 		@{o = "Não" ; a = {Menu1}}
	# 	)  ; $OpcoesArray = $OpcoesMenu | ForEach-Object { @{o = $_.o ; a = $_.a}}
	# 	OpcoesMenu -opcoes $OpcoesArray
	# }


Menu1
