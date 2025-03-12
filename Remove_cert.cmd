@REM Script to Remove the Microsoft Testing Root Certificate Authority 2010 from the localmachine root store.
@REM This script removes the certificate IFF InstallMSTRCA2010.cer installed the certificate.
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

@REM IF NOT EXIST .\8a334aa8052dd244a647306a76b8178fa215f344.txt goto :S_TESTBUILD
(certutil.exe -store root 8a334aa8052dd244a647306a76b8178fa215f344 > NUL) && GOTO :REMOVE_CERT

:E_CERTNOTFOUND
echo "Microsoft Testing Root Certificate Authority 2010 not found in root store"
exit /B 1
goto :eof

:REMOVE_CERT
(certutil.exe -delstore root 8a334aa8052dd244a647306a76b8178fa215f344 > NUL) && GOTO :S_CERTREMOVED
goto :eof

:S_TESTBUILD
echo "Certificate not installed by InstallMSTRCA2010.cmd. No action will take place."
exit /B 0
goto :eof

:S_CERTREMOVED
echo "Microsoft Testing Root Certificate Authority 2010 removed successfully"
exit /B 0
goto :eof