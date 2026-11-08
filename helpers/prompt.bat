@echo off
rem Render de plantillas (equivalente a helpers/prompt.sh)

if /i "%~1"=="render" goto :render
if /i "%~1"=="emit_prompt" goto :emit_prompt
echo Uso: prompt.bat render^|emit_prompt ... 1>&2
exit /b 1

:render
rem %2 template, %3 hwfile, %4 destino
setlocal enabledelayedexpansion
set "TEMPLATE=%~2"
set "HWFILE=%~3"
set "DEST=%~4"
if not exist "%TEMPLATE%" exit /b 1
if exist "%DEST%" del /q "%DEST%" >nul 2>&1

for /f "usebackq delims=" %%L in (`findstr /n "^" "%TEMPLATE%"`) do (
    set "line=%%L"
    set "line=!line:*:=!"
    if "!line!"=="$hw_sw_info" (
        if defined HWFILE if exist "!HWFILE!" type "!HWFILE!" >> "%DEST%"
    ) else (
        set "line=!line:$internet_upload_speed=%internet_upload_speed%!"
        set "line=!line:$internet_download_speed=%internet_download_speed%!"
        set "line=!line:$internet_upload=%internet_upload%!"
        set "line=!line:$internet_download=%internet_download%!"
        set "line=!line:$internet_receptor=%internet_receptor%!"
        set "line=!line:$resolution=%resolution%!"
        set "line=!line:$fps=%fps%!"
        set "line=!line:$multimedia_servicies=%multimedia_servicies%!"
        set "line=!line:$stream_type=%stream_type%!"
        set "line=!line:$audio_indications=%audio_indications%!"
        echo(!line!>>"%DEST%"
    )
)
endlocal
exit /b 0

:emit_prompt
rem %2 template, %3 hwfile, %4 output opcional
setlocal enabledelayedexpansion
set "TEMPLATE=%~2"
set "HWFILE=%~3"
set "OUTPUT=%~4"
set "TMPR=%TEMP%\obs_render_%RANDOM%%RANDOM%.md"

call "%~f0" render "%TEMPLATE%" "%HWFILE%" "%TMPR%"
if errorlevel 1 (
    endlocal
    exit /b 1
)
if not exist "%TMPR%" (
    endlocal
    exit /b 1
)

type "%TMPR%"

if defined OUTPUT (
    echo.
    echo -----------------
    echo.
    echo Escribiendo prompt...
    copy /y "%TMPR%" "%OUTPUT%" >nul
    echo Prompt escrito.
)

del /q "%TMPR%" >nul 2>&1
endlocal
exit /b 0
