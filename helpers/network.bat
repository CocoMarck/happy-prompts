@echo off
rem Medicion de red (equivalente a helpers/network.sh)
rem Dependencias: curl.exe, powershell.exe

if /i "%~1"=="measure_download" goto :measure_download
if /i "%~1"=="measure_upload" goto :measure_upload
if /i "%~1"=="bytes_to_mbps" goto :bytes_to_mbps
echo Uso: network.bat measure_download^|measure_upload^|bytes_to_mbps 1>&2
exit /b 1

:measure_download
curl.exe -o NUL -sS -w "%%{speed_download}" --max-time 120 --retry 2 "https://speed.cloudflare.com/__down?bytes=30000000"
set "RC=%ERRORLEVEL%"
echo(
exit /b %RC%

:measure_upload
setlocal
set "UPFILE=%TEMP%\obs_up_%RANDOM%%RANDOM%.bin"
powershell -NoProfile -Command "[IO.File]::WriteAllBytes('%UPFILE%', (New-Object byte[] 40000000))"
curl.exe -o NUL -sS -w "%%{speed_upload}" --max-time 120 -X POST --data-binary "@%UPFILE%" "https://speed.cloudflare.com/__up"
set "RC=%ERRORLEVEL%"
echo(
del /q "%UPFILE%" >nul 2>&1
endlocal & exit /b %RC%

:bytes_to_mbps
powershell -NoProfile -Command "[System.Threading.Thread]::CurrentThread.CurrentCulture = [cultureinfo]::InvariantCulture; $v = 0.0; if ('%~1' -ne '' -and [double]::TryParse('%~1', [Globalization.NumberStyles]::Float, [cultureinfo]::InvariantCulture, [ref]$v)) { $m = $v * 8 / 1e6; if ($m -gt 0) { [math]::Round($m, 2).ToString([cultureinfo]::InvariantCulture) } else { '0' } } else { 'No se' }"
exit /b 0
