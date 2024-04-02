Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
$root = Split-Path -Parent $MyInvocation.MyCommand.Definition

function MenuConfigSistema {
    Clear-Host
    Write-Host "----------===----------"
    Write-Host "Menu > Configurações do sistema" -ForegroundColor Blue
    Write-Host ""
    Write-Host "[1] Padronização inicial completa"
    Write-Host "[V] Voltar"
    Write-Host ""
    
    $RespostaConfigSistema = Read-Host "Digite uma opção"

    Switch ($RespostaConfigSistema) {
        1{
            $a = Split-Path $root
            $dir = Join-Path $a "\Config. Sistema\Configurações sistema.ps1"
            & "$dir"
        }
        V{
            Menu
        }
        default {
            Write-Host "Opção inválida!" -ForegroundColor Red
        }
    }
}

function Menu {
    Clear-Host
    Write-Host "----------===----------"
    Write-Host "Menu" -ForegroundColor Blue
    Write-Host ""
    Write-Host "[1] Sistema"
    Write-Host "[2] Ativação do Windows"
    Write-Host "[S] Sair"
    Write-Host ""

    $RespostaMenu = Read-Host "Digite uma opção"
    
    switch ($RespostaMenu) {
        1{
            MenuConfigSistema
        }
        2{

        }
        S{

        }
        default{
            Write-Host "Opção inválida!" -ForegroundColor Red
        }
    }
}

Menu
