@echo off
chcp 65001 >nul
title Macro Engine Launcher

:: ================= CORES ANSI =================
set "GREEN=[92m"
set "RED=[91m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "CYAN=[96m"
set "RESET=[0m"

:: ================= ASCII ART =================
echo %CYAN%
echo ███╗░░░███╗░█████╗░░█████╗░██████╗░░█████╗░  ███████╗███╗░░██╗░██████╗░██╗███╗░░██╗███████╗
echo ████╗░████║██╔══██╗██╔══██╗██╔══██╗██╔══██╗  ██╔════╝████╗░██║██╔════╝░██║████╗░██║██╔════╝
echo ██╔████╔██║███████║██║░░╚═╝██████╔╝██║░░██║  █████╗░░██╔██╗██║██║░░██╗░██║██╔██╗██║█████╗░░
echo ██║╚██╔╝██║██╔══██║██║░░██╗██╔══██╗██║░░██║  ██╔══╝░░██║╚████║██║░░╚██╗██║██║╚████║██╔══╝░░
echo ██║░╚═╝░██║██║░░██║╚█████╔╝██║░░██║╚█████╔╝  ███████╗██║░╚███║╚██████╔╝██║██║░╚███║███████╗
echo ╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░  ╚══════╝╚═╝░░╚══╝░╚═════╝░╚═╝╚═╝░░╚══╝╚══════╝
echo %RESET%

echo.
echo %BLUE%==============================%RESET%
echo %GREEN%     MACRO ENGINE STARTER%RESET%
echo %BLUE%==============================%RESET%
echo.

:: ================= CAMINHO =================
set "BASE=%USERPROFILE%\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\Documentos\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documentos\MacroEngine"

echo %YELLOW%[INFO]%RESET% Verificando instalacao...
echo.

if not exist "%BASE%" (
    echo %RED%[ERRO]%RESET% Pasta MacroEngine nao encontrada
    echo %YELLOW%[INFO]%RESET% Reinstale o sistema
    pause
    exit
)

cd /d "%BASE%"

:: ================= ARQUIVOS =================
echo %YELLOW%[INFO]%RESET% Verificando arquivos...
echo.

if exist Macro.py (
    echo %GREEN%[OK]%RESET% Macro.py encontrado
) else (
    echo %RED%[ERRO]%RESET% Macro.py nao encontrado
    pause
    exit
)

if exist engine.txt (
    echo %GREEN%[OK]%RESET% engine.txt encontrado
) else (
    echo %YELLOW%[WARN]%RESET% engine.txt nao encontrado
)

echo.
echo %BLUE%==============================%RESET%
echo %CYAN%[INFO] Iniciando Macro Engine...%RESET%
echo %BLUE%==============================%RESET%
echo.

:: ================= EXEC OCULTO =================
:: Isso executa o python escondido (sem aparecer CMD)
start "" /B pythonw Macro.py 2>nul || start "" /B pyw Macro.py

:: Fecha o launcher automaticamente
exit
