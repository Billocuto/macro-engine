@echo off
chcp 65001 >nul
title Macro Engine Launcher

:: ================= CORES =================
set "GREEN=[32m"
set "RED=[31m"
set "YELLOW=[33m"
set "BLUE=[34m"
set "RESET=[0m"

echo.
echo ==============================
echo   MACRO ENGINE STARTER
echo ==============================
echo.

:: ================= CAMINHO =================
set "BASE=%USERPROFILE%\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\Documentos\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documentos\MacroEngine"

echo [INFO] Verificando instalacao...
echo.

if not exist "%BASE%" (
    echo [ERRO] Pasta MacroEngine nao encontrada
    echo [INFO] Reinstale o sistema
    pause
    exit
)

cd /d "%BASE%"

:: ================= ARQUIVOS =================
echo [INFO] Verificando arquivos...
echo.

if exist Macro.py (
    echo [OK] Macro.py encontrado
) else (
    echo [ERRO] Macro.py nao encontrado
    pause
    exit
)

if exist engine.txt (
    echo [OK] engine.txt encontrado
) else (
    echo [WARN] engine.txt nao encontrado
)

echo.
echo ==============================
echo [INFO] Iniciando Macro Engine...
echo ==============================
echo.

:: ================= EXEC =================
python Macro.py 2>nul || py Macro.py

echo.
echo ==============================
echo [OK] Processo finalizado
echo ==============================
pause
