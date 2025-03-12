@REM Script to install Microsoft Testing Root Certificate Authority 2010 to localmachine root store.
@REM Patrick O'Brien
@REM Microsoft Confidential
@REM (C) Microsoft Corporation

@echo off
@setlocal

:: Check privileges
net file 1>NUL 2>NUL
if not '%errorlevel%' == '0' (
    powershell Start-Process -FilePath "%0" -verb runas
    exit /b
)

IF NOT EXIST %SYSTEMROOT%\System32\certutil.exe GOTO :E_NOCERTUTIL
(certutil.exe -store root 8a334aa8052dd244a647306a76b8178fa215f344 > NUL) && GOTO :S_CERTEXISTS

IF NOT EXIST %~dp0MSTRCA2010.cer GOTO :E_NOCERTFILE
certutil.exe -addstore root %~dp0MSTRCA2010.cer
(certutil.exe -store root 8a334aa8052dd244a647306a76b8178fa215f344 > NUL) && GOTO :S_CERTINSTALLED

echo "Test Root still not installed. Failing task to stop job execution."
exit /B 3
goto :eof

:E_NOCERTUTIL
echo "Cannot find certutil.exe"
exit /B 1
goto :eof

:E_NOCERTFILE
echo "Cannot find MSTRCA2010.cer"
exit /B 2
goto :eof

:S_CERTEXISTS
echo "Microsoft Testing Root Certificate Authority 2010 already installed."
exit /B 0
goto :eof

:S_CERTINSTALLED
echo "Microsoft Testing Root Certificate Authority 2010 installed successfully"
@REM echo. > 8a334aa8052dd244a647306a76b8178fa215f344.txt
exit /B 0
goto :eof