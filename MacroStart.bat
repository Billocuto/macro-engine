@echo off
title Macro Engine
color 0A

:: ================= ASCII =================
echo.
echo  ███╗   ███╗ █████╗  ██████╗██████╗  ██████╗ 
echo  ████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔═══██╗
echo  ██╔████╔██║███████║██║     ██████╔╝██║   ██║
echo  ██║╚██╔╝██║██╔══██║██║     ██╔══██╗██║   ██║
echo  ██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║╚██████╔╝
echo  ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝ 
echo           MACRO ENGINE LOADER
echo ============================================
echo.

:: ================= CAMINHO =================
echo [*] Verificando caminho...
set "BASE=%USERPROFILE%\Documents\MacroEngine"

if not exist "%BASE%" (
    set "BASE=%USERPROFILE%\Documentos\MacroEngine"
)

if not exist "%BASE%" (
    color 0C
    echo [X] Pasta MacroEngine nao encontrada!
    echo Verifique a instalacao.
    pause
    exit
)

echo [OK] Pasta encontrada:
echo %BASE%
echo.

:: ================= ARQUIVOS =================
echo [*] Verificando arquivos...

cd /d "%BASE%"

if exist Macro.py (
    echo [OK] Macro.py encontrado
) else (
    color 0C
    echo [X] Macro.py nao encontrado!
    pause
    exit
)

if exist engine.txt (
    echo [OK] engine.txt encontrado
) else (
    echo [!] engine.txt nao encontrado
)

echo.
echo ============================================
echo [*] Iniciando Macro Engine...
echo ============================================
echo.

:: ================= EXEC =================
python Macro.py 2>nul || py Macro.py

echo.
echo ============================================
echo [*] Finalizado
echo ============================================
pause
