@echo off

:: cria VBS temporário
set "vbs=%temp%\run_hidden.vbs"

echo Set WshShell = CreateObject("WScript.Shell") > "%vbs%"
echo WshShell.Run ""cmd /c launcher_core.bat"", 0, False >> "%vbs%"

:: executa invisível
cscript //nologo "%vbs%"

:: limpa
del "%vbs%"

exit
