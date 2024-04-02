Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process -Force
# Ativação do Windows
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Config.%20Sistema/Ativa%C3%A7%C3%A3o%20Windows.ps1" | Invoke-Expression
# Cursor
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Cursor.ps1" | Invoke-Expression
# Wallpaper
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Wallpaper.ps1" | Invoke-Expression
# Terminal
Invoke-WebRequest "https://raw.githubusercontent.com/gguilhermepamplona/Script/main/Customiza%C3%A7%C3%B5es/Terminal.ps1" | Invoke-Expression

if (-not (Get-Module -Name ps-menu -ListAvailable)) {
    Install-Module -Name ps-menu -Scope CurrentUser -Force
}
Import-Module -Name ps-menu -Force

function MenuSistema {
	$MenuSistema = @(
		"Padronização Inicial",
		"Instalação de Programas",
		"Desinstalação de Programas",
		"Voltar"
		)
		Clear-Host
		$Result = Menu -menuItems $MenuSistema
		switch ($Result) {
			"Padronização Inicial" {
				Write-Host "Padronização Inicial"
				Menu1
			}
			"Instalação de Programas" {
				Write-Host "Instalação de Programas"
				Menu1
			}
			"Desinstalação de Programas" {
				Write-Host "Desinstalação de Programas"
				Menu1
			}
			"Voltar" {
				Menu1
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
			}
			"Office" {
				Write-Host "Ativador Office"
				Menu1
			}
			"Voltar" {
				Menu1
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
			MenuCustomizacoe
		}
		"Wallpaper" {
			Wallpaper
			MenuCustomizacoe
		}
		"Terminal" {
			Terminal
			MenuCustomizacoe
		}
		"Voltar" {
			Menu1
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
	}
}

Menu1
