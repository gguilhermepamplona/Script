$host.UI.RawUI.WindowTitle = "Script"
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

function MenuSistema {
	$MenuSistema = @(
		"Configurações do sistema",
		"Instalação de Programas",
		"Desinstalação de Programas",
		"Desfragmentação",
		"CTT",
		"Voltar"
		)
		Clear-Host
		$Result = Menu -menuItems $MenuSistema
		switch ($Result) {
			"Configurações do sistema" {
				ConfigSistema
				MenuSistema
			}
			"Instalação de Programas" {
				Write-Host "Instalação de Programas em desenvolvimento!"
				MenuSistema
			}
			"Desinstalação de Programas" {
				DesinstalacaoApps
				MenuSistema
			}
			"Desfragmentação" {
				Get-Volume | Where-Object DriveLetter | Where-Object DriveType -eq Fixed | Optimize-Volume
			}
			"CTT" {
				Invoke-WebRequest -UseBasicParsing https://christitus.com/win | Invoke-Expression
			}
			"Voltar" {
				Menu1
			}
			Default {
				Write-Host "Opção inválida" -ForegroundColor Red
			}
	}
}

function MenuAtivacoes {
	$MenuAtivacoes = @(
		"Windows",
		"Office",
		"Voltar"
		)
		Clear-Host
		$Result = Menu -menuItems $MenuAtivacoes

		switch ($Result) {
			"Windows" {
				AtivacaoWindows
				MenuAtivacoes
			}
			"Office" {
				Write-Host "Ativador do Office em desenvolvimento!"
				MenuAtivacoes
			}
			"Voltar" {
				Menu1
			}
			Default {
				Write-Host "Opção inválida" -ForegroundColor Red
			}
		}
	}

function MenuCustomizacoes {
	$MenuCustomizacoes = @(
		"Cursor",
		"Wallpaper",
		"Terminal",
		"Voltar"
	)
	Clear-Host
	$Result = Menu -menuItems $MenuCustomizacoes

	switch ($Result) {
		"Cursor" {
			Cursor
			MenuCustomizacoes
		}
		"Wallpaper" {
			Wallpaper
			MenuCustomizacoes
		}
		"Terminal" {
			Terminal
			MenuCustomizacoes
		}
		"Voltar" {
			Menu1
		}
		Default {
			Write-Host "Opção inválida" -ForegroundColor Red
		}
	}
}

function Menu1 {
	$Menu = @(
		"Sistema",
		"Ativações",
		"Customizações",
		"Sair"
	)
	Clear-Host
	$Result = Menu -menuItems $Menu
	switch ($Result) {
		"Sistema" {
			MenuSistema
		}
		"Ativações" {
			MenuAtivacoes
		}
		"Customizações" {
			MenuCustomizacoes
		}
		"Sair" {
			Exit-PSHostProcess
		}
		Default {
			Write-Host "Opção inválida" -ForegroundColor Red
		}
	}
}

Menu1
