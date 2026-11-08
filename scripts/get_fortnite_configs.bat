@echo off
setlocal enabledelayedexpansion

rem =====================================================================
rem  Prompt Fortnite - Windows (Win >= 10)
rem  Equivalente Windows de get_fortnite_configs.sh
rem  Genera el prompt a partir de templates/template_fortnite_configs.md
rem
rem  Dependencias (ya vienen con Windows 10, NO instala nada):
rem    - powershell.exe  info del hardware y conversion de velocidad
rem    - curl.exe        medicion de red (incluido desde Windows 10 1803)
rem  Si falta alguna, se usa "No se" en lugar de abortar.
rem
rem  Flags al estilo Windows (tambien acepta -flag / --flag):
rem    /o /? /h /help      (ver :usage)
rem =====================================================================

call "%~dp0..\helpers\paths.bat"
set "PROMPT_TEMPLATE=%TEMPLATES_DIR%\template_fortnite_configs.md"

rem ------------------------ valores por defecto ------------------------
set "internet_upload_speed="
set "internet_download_speed="
set "output="
set "HWFILE="
set "HAVE_PS=0"
set "HAVE_CURL=0"

rem ------------------------ argumentos ------------------------
:parse_args
if "%~1"=="" goto :args_done
set "arg=%~1"
if "!arg:~0,2!"=="--" set "arg=/%arg:~2%"
if "!arg:~0,1!"=="-"  set "arg=/%arg:~1%"
if /i "!arg!"=="/o"    (set "output=%~2" & shift & shift & goto :parse_args)
if /i "!arg!"=="/?"    goto :show_help
if /i "!arg!"=="/h"    goto :show_help
if /i "!arg!"=="/help" goto :show_help
echo Opcion desconocida: %~1 1>&2
call :usage 1>&2
exit /b 1

:show_help
call :usage
exit /b 0

:args_done

rem ------------------------ dependencias ------------------------
where powershell.exe >nul 2>&1 && set "HAVE_PS=1"
where curl.exe >nul 2>&1 && set "HAVE_CURL=1"
if "%HAVE_PS%"=="0" echo Aviso: no se encontro powershell.exe. Sin info de hardware. 1>&2

rem ------------------------ info del hardware ------------------------
if not "%HAVE_PS%"=="1" goto :hw_done
set "HWFILE=%TEMP%\fortnite_hw_%RANDOM%%RANDOM%.txt"
call "%HELPERS_DIR%pc_info.bat" > "%HWFILE%"
if not exist "%HWFILE%" set "HWFILE="
if defined HWFILE for %%A in ("%HWFILE%") do if %%~zA==0 set "HWFILE="
:hw_done

rem ------------------------ velocidad de red ------------------------
if not "%HAVE_CURL%"=="1" goto :no_net
if not "%HAVE_PS%"=="1" goto :no_net
echo Midiendo velocidad de red (Cloudflare)... 1>&2

set "BS_DL="
for /f "usebackq delims=" %%A in (`call "%HELPERS_DIR%network.bat" measure_download`) do set "BS_DL=%%A"
if defined BS_DL (
    for /f "usebackq delims=" %%B in (`call "%HELPERS_DIR%network.bat" bytes_to_mbps "!BS_DL!"`) do set "internet_download_speed=%%B"
)

set "BS_UL="
for /f "usebackq delims=" %%A in (`call "%HELPERS_DIR%network.bat" measure_upload`) do set "BS_UL=%%A"
if defined BS_UL (
    for /f "usebackq delims=" %%B in (`call "%HELPERS_DIR%network.bat" bytes_to_mbps "!BS_UL!"`) do set "internet_upload_speed=%%B"
)
goto :speed_done

:no_net
echo Aviso: no pude medir la red. Quedara "No se". 1>&2

:speed_done
if not defined internet_download_speed set "internet_download_speed=No se"
if not defined internet_upload_speed set "internet_upload_speed=No se"

rem ------------------------ archivo de salida ------------------------
if not exist "%PROMPT_TEMPLATE%" (
    echo No existe el template: %PROMPT_TEMPLATE% 1>&2
    call :cleanup
    exit /b 1
)

rem --------------------------------------------------------------------
rem  Render: helpers/prompt.bat sustituye los tokens $var del template
rem  y escribe el contenido de HWFILE en la linea $hw_sw_info.
rem --------------------------------------------------------------------
call "%HELPERS_DIR%prompt.bat" emit_prompt "%PROMPT_TEMPLATE%" "%HWFILE%" "%output%"
if errorlevel 1 (
    echo Error: no se pudo generar el prompt. 1>&2
    call :cleanup
    exit /b 1
)
if defined output if not exist "%output%" (
    echo Error: no se pudo escribir %output% 1>&2
    call :cleanup
    exit /b 1
)

call :cleanup
if defined output echo Prompt escrito en: %output% 1>&2
exit /b 0

rem ------------------------ limpieza ------------------------
:cleanup
if defined HWFILE del /q "%HWFILE%" >nul 2>&1
exit /b 0

rem ------------------------ ayuda ------------------------
:usage
echo.
echo Uso: get_fortnite_configs.bat [opciones]
echo.
echo     /o ARCHIVO  Escribe el archivo (default: solo stdout)
echo     /?          Esta ayuda
echo.
echo Tambien acepta -flag o --flag como alias (ej. -o, --help).
echo.
echo Ejemplos:
echo     get_fortnite_configs.bat
echo     get_fortnite_configs.bat /o ./salida.md
echo.
exit /b 0
