@echo off
chcp 65001 >nul
title Macro Engine Launcher

:: ================= CORES =================
set "GREEN=[92m"
set "RED=[91m"
set "YELLOW=[93m"
set "BLUE=[94m"
set "CYAN=[96m"
set "RESET=[0m"

:: ================= ASCII =================
echo %CYAN%
echo ███╗░░░███╗░█████╗░░█████╗░██████╗░░█████╗░
echo ████╗░████║██╔══██╗██╔══██╗██╔══██╗██╔══██╗
echo ██╔████╔██║███████║██║░░╚═╝██████╔╝██║░░██║
echo ██║╚██╔╝██║██╔══██║██║░░██╗██╔══██╗██║░░██║
echo ██║░╚═╝░██║██║░░██║╚█████╔╝██║░░██║╚█████╔╝
echo ╚═╝░░░░░╚═╝╚═╝░░╚═╝░╚════╝░╚═╝░░╚═╝░╚════╝░
echo %RESET%

echo.
echo %BLUE%==============================%RESET%
echo %GREEN%     MACRO ENGINE STARTER%RESET%
echo %BLUE%==============================%RESET%
echo.

:: ================= LOADING =================
echo %CYAN%[INFO]%RESET% Inicializando...
setlocal enabledelayedexpansion
set "spin=\|/-"

for /l %%i in (1,1,20) do (
    set /a "idx=%%i %% 4"
    for %%a in (!idx!) do set "char=!spin:~%%a,1!"
    <nul set /p=Carregando !char!`r
    timeout /t 0 >nul
)

echo.
echo %GREEN%[OK]%RESET% Sistema iniciado
echo.

:: ================= INTERNET =================
echo %YELLOW%[INFO]%RESET% Verificando internet...
ping google.com -n 1 >nul

if errorlevel 1 (
    echo %RED%[ERRO]%RESET% Sem conexao com a internet
    timeout /t 2 >nul
    exit
) else (
    echo %GREEN%[OK]%RESET% Internet conectada
)

:: ================= GITHUB =================
echo %YELLOW%[INFO]%RESET% Verificando GitHub...

curl -s --head https://github.com/Billocuto/macro-engine | find "200" >nul

if errorlevel 1 (
    echo %RED%[ERRO]%RESET% GitHub offline ou repositorio indisponivel
    timeout /t 2 >nul
    exit
) else (
    echo %GREEN%[OK]%RESET% GitHub online
)

:: ================= CAMINHO =================
set "BASE=%USERPROFILE%\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\Documentos\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documentos\MacroEngine"

echo.
echo %YELLOW%[INFO]%RESET% Verificando instalacao...

if not exist "%BASE%" (
    echo %RED%[ERRO]%RESET% Pasta MacroEngine nao encontrada
    timeout /t 2 >nul
    exit
)

cd /d "%BASE%"

:: ================= ARQUIVOS =================
echo.
echo %YELLOW%[INFO]%RESET% Verificando arquivos...

if exist Macro.py (
    echo %GREEN%[OK]%RESET% Macro.py encontrado
) else (
    echo %RED%[ERRO]%RESET% Macro.py nao encontrado
    timeout /t 2 >nul
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
start "" /B pythonw Macro.py 2>nul || start "" /B pyw Macro.py

:: ================= DELAY PRA FECHAR =================
echo %GREEN%[OK]%RESET% Executado com sucesso
timeout /t 1 >nul
exit
