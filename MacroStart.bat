@echo off
setlocal EnableExtensions EnableDelayedExpansion

title Macro Engine Launcher v2.1
mode con: cols=92 lines=30

:: ==========================================================
:: CONFIGURAÇÕES
:: ==========================================================
set "APP_NAME=Macro Engine"
set "VERSION=2.1"

set "PROJECT_DIR=%USERPROFILE%\Documents\MacroEngine"
set "SCRIPT=%PROJECT_DIR%\Macro.py"
set "LOG=%PROJECT_DIR%\launcher.log"

:: ==========================================================
:: TELA INICIAL
:: ==========================================================
color 0B
cls

echo.
echo ================================================================================
echo.
echo                      ███╗   ███╗ █████╗  ██████╗██████╗  ██████╗
echo                      ████╗ ████║██╔══██╗██╔════╝██╔══██╗██╔═══██╗
echo                      ██╔████╔██║███████║██║     ██████╔╝██║   ██║
echo                      ██║╚██╔╝██║██╔══██║██║     ██╔══██╗██║   ██║
echo                      ██║ ╚═╝ ██║██║  ██║╚██████╗██║  ██║╚██████╔╝
echo                      ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝ ╚═════╝
echo.
echo                           ENGINE LAUNCHER v%VERSION%
echo.
echo ================================================================================

:: ==========================================================
:: AVISO
:: ==========================================================
color 0E

echo.
echo ================================================================================
echo                               AVISO IMPORTANTE
echo ================================================================================
echo.
echo  LEMBRE-SE DE TER O PYTHON INSTALADO NO COMPUTADOR.
echo.
echo  Caso contrario o Macro Engine nao podera ser iniciado.
echo.
echo ================================================================================
echo.

timeout /t 3 /nobreak >nul

:: ==========================================================
:: LOG
:: ==========================================================
color 0A

echo ========================================================== > "%LOG%"
echo [%date% %time%] Launcher iniciado >> "%LOG%"

echo.
echo [INFO] Usuario.............: %USERNAME%
echo [INFO] Projeto.............: %PROJECT_DIR%

echo [INFO] Usuario.............: %USERNAME%>>"%LOG%"
echo [INFO] Projeto.............: %PROJECT_DIR%>>"%LOG%"

:: ==========================================================
:: VERIFICA PASTA
:: ==========================================================
if not exist "%PROJECT_DIR%" (
    color 0C
    echo.
    echo [ERRO] Pasta do projeto nao encontrada.
    echo [%date% %time%] Pasta nao encontrada.>>"%LOG%"
    pause
    exit /b
)

:: ==========================================================
:: VERIFICA SCRIPT
:: ==========================================================
if not exist "%SCRIPT%" (
    color 0C
    echo.
    echo [ERRO] Arquivo Macro.py nao encontrado.
    echo [%date% %time%] Macro.py nao encontrado.>>"%LOG%"
    pause
    exit /b
)

echo.
echo [INFO] Procurando instalacao do Python...

:: ==========================================================
:: PROCURA PYTHON
:: ==========================================================
set "PYTHON="

for /f "delims=" %%i in ('where py.exe 2^>nul') do (
    set "PYTHON=%%i"
    goto :pythonFound
)

for /f "delims=" %%i in ('where python.exe 2^>nul') do (
    echo %%i | find /I "WindowsApps" >nul
    if errorlevel 1 (
        set "PYTHON=%%i"
        goto :pythonFound
    )
)

for /d %%d in ("%LocalAppData%\Programs\Python\Python*") do (
    if exist "%%d\python.exe" (
        set "PYTHON=%%d\python.exe"
        goto :pythonFound
    )
)

for /d %%d in ("C:\Program Files\Python*") do (
    if exist "%%d\python.exe" (
        set "PYTHON=%%d\python.exe"
        goto :pythonFound
    )
)

:: ==========================================================
:: PYTHON NÃO ENCONTRADO
:: ==========================================================
color 0C

echo.
echo ==========================================================
echo [ERRO] Nenhuma instalacao valida do Python foi encontrada.
echo ==========================================================
echo.
echo Baixe em:
echo https://www.python.org/downloads/
echo.
echo Durante a instalacao marque:
echo.
echo      [X] Add Python to PATH
echo.

echo [%date% %time%] Python nao encontrado.>>"%LOG%"
pause
exit /b

:pythonFound

echo [OK] Python localizado.
echo [INFO] Executavel.........: %PYTHON%

echo [OK] Python encontrado.>>"%LOG%"
echo [INFO] Executavel.........: %PYTHON%>>"%LOG%"

:: ==========================================================
:: VERIFICA E INSTALA DEPENDÊNCIAS
:: ==========================================================

echo.
echo ==========================================================
echo      Verificando dependencias do Macro Engine...
echo ==========================================================
echo.

set PACKAGES=requests keyboard pyautogui pillow mouseinfo

for %%P in (%PACKAGES%) do (

    echo [INFO] Verificando %%P...

    "%PYTHON%" -m pip show %%P >nul 2>&1

    if errorlevel 1 (

        color 0E
        echo [AVISO] %%P nao encontrado.
        echo [INFO] Instalando %%P...

        "%PYTHON%" -m pip install %%P

        if errorlevel 1 (
            color 0C
            echo.
            echo [ERRO] Falha ao instalar %%P.
            echo Verifique sua conexao com a Internet.
            pause
            exit /b
        )

        color 0A
        echo [OK] %%P instalado com sucesso.

    ) else (

        echo [OK] %%P ja esta instalado.

    )

)

echo.
echo [SUCESSO] Todas as dependencias foram verificadas.
echo.

echo.
echo ==========================================================
echo          Inicializando Macro Engine...
echo ==========================================================
echo.

timeout /t 2 /nobreak >nul

"%PYTHON%" "%SCRIPT%"
set EXITCODE=%ERRORLEVEL%

echo.
if "%EXITCODE%"=="0" (
    color 0A
    echo [SUCESSO] Programa finalizado com sucesso.
) else (
    color 0C
    echo [ERRO] O programa foi encerrado com codigo %EXITCODE%.
)

echo [%date% %time%] Codigo de saida: %EXITCODE%>>"%LOG%"

echo.
echo ==========================================================
echo               Obrigado por utilizar o Macro Engine
echo ==========================================================
echo.

pause
endlocal
