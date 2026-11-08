@echo off
rem Rutas base del proyecto (equivalente a helpers/paths.sh)
set "HELPERS_DIR=%~dp0"
for %%I in ("%~dp0..") do set "ROOT_DIR=%%~fI"
set "SCRIPTS_DIR=%ROOT_DIR%\scripts"
set "TEMPLATES_DIR=%ROOT_DIR%\templates"
set "PROMPTS_DIR=%ROOT_DIR%\prompts"
exit /b 0
