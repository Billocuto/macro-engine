@echo off
chcp 65001 >nul

:: ================= EXEC =================
set "BASE=%USERPROFILE%\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\Documentos\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documents\MacroEngine"
if not exist "%BASE%" set "BASE=%USERPROFILE%\OneDrive\Documentos\MacroEngine"

cd /d "%BASE%"

:: verifica arquivos
if not exist Macro.py exit

:: executa invisível
start "" /B pythonw Macro.py 2>nul || start "" /B pyw Macro.py

timeout /t 1 >nul
exit
