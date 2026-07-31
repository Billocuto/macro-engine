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
echo                         MACRO ENGINE LAUNCHER
echo.
echo                              VERSION %VERSION%
echo.
echo ================================================================================
echo.
echo.

timeout /t 2 /nobreak >nul



:: ==========================================================
:: AVISO
:: ==========================================================

color 0E

echo.
echo ================================================================================
echo                         AVISO IMPORTANTE
echo ================================================================================
echo.
echo  Este launcher ira verificar e instalar todas as dependencias.
echo.
echo  Dependencias:
echo.
echo       - requests
echo       - keyboard
echo       - pyautogui
echo       - pillow
echo       - mouseinfo
echo       - colorama
echo.
echo ================================================================================

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
    echo ==========================================================
    echo [ERRO] Pasta do projeto nao encontrada.
    echo ==========================================================

    echo [%date% %time%] Pasta inexistente >> "%LOG%"

    pause
    exit /b

)



:: ==========================================================
:: VERIFICA SCRIPT
:: ==========================================================


if not exist "%SCRIPT%" (

    color 0C

    echo.
    echo ==========================================================
    echo [ERRO] Macro.py nao encontrado.
    echo ==========================================================

    echo [%date% %time%] Macro.py ausente >> "%LOG%"

    pause
    exit /b

)



echo.
echo [INFO] Procurando Python instalado...



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
echo [ERRO] Nenhuma instalacao valida do Python encontrada.
echo ==========================================================
echo.
echo Baixe Python em:
echo https://www.python.org/downloads/
echo.
echo Durante a instalacao marque:
echo.
echo        [X] Add Python to PATH
echo.


echo [%date% %time%] Python nao encontrado >> "%LOG%"


pause
exit /b




:pythonFound


color 0A

echo.
echo [OK] Python localizado.
echo [INFO] Executavel:
echo %PYTHON%


echo [OK] Python encontrado >> "%LOG%"
echo [INFO] Executavel: %PYTHON% >> "%LOG%"




:: ==========================================================
:: VERIFICA E INSTALA DEPENDÊNCIAS
:: ==========================================================


echo.
echo ==========================================================
echo        VERIFICANDO DEPENDENCIAS
echo ==========================================================
echo.



:: COLORAMA ADICIONADO

set PACKAGES=requests keyboard pyautogui pillow mouseinfo colorama



for %%P in (%PACKAGES%) do (

    echo.
    echo [INFO] Verificando %%P...


    "%PYTHON%" -m pip show %%P >nul 2>&1



    if errorlevel 1 (

        color 0E

        echo.
        echo [AVISO] %%P nao encontrado.
        echo [INFO] Instalando %%P...


        "%PYTHON%" -m pip install %%P



        if errorlevel 1 (

            color 0C

            echo.
            echo ==================================================
            echo [ERRO] Falha ao instalar %%P
            echo ==================================================

            echo [%date% %time%] Erro instalando %%P >> "%LOG%"

            pause
            exit /b

        )


        color 0A

        echo.
        echo [OK] %%P instalado com sucesso.


    ) else (

        color 0B

        echo.
        echo [OK] %%P ja instalado.


    )


)




echo.
echo ==========================================================
echo [SUCESSO] Todas dependencias verificadas.
echo ==========================================================

echo.




:: ==========================================================
:: INICIAR MACRO
:: ==========================================================


echo.
echo ==========================================================
echo             INICIANDO MACRO ENGINE
echo ==========================================================
echo.


timeout /t 2 /nobreak >nul




echo [%date% %time%] Iniciando Macro.py >> "%LOG%"




:: ==========================================================
:: ABRIR PYTHON OCULTO
:: ==========================================================


powershell -WindowStyle Hidden -Command ^
"Start-Process '%PYTHON%' -ArgumentList '\"%SCRIPT%\"' -WindowStyle Hidden"



set EXITCODE=%ERRORLEVEL%



echo [%date% %time%] Codigo: %EXITCODE% >> "%LOG%"



:: ==========================================================
:: FINAL
:: ==========================================================


color 0A


echo.
echo ==========================================================
echo.
echo          MACRO ENGINE EXECUTADO COM SUCESSO
echo.
echo ==========================================================


timeout /t 3 /nobreak >nul


endlocal
exit
