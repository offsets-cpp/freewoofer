@echo off
echo ========================================================================================================== > Serials.txt
echo 1. SMBIOS >> Serials.txt
echo ========================================================================================================== >> Serials.txt
echo. >> Serials.txt
for /f "skip=1" %%i in ('wmic csproduct get uuid') do (
    echo UUID: %%i >> Serials.txt
    goto :1
)
:1
for /f "skip=1" %%i in ('wmic bios get serialnumber') do (
    echo BIOS: %%i >> Serials.txt
    goto :2
)
:2
for /f "skip=1" %%i in ('wmic systemenclosure get serialnumber') do (
    echo Chassis: %%i >> Serials.txt
    goto :3
)
:3
for /f "skip=1" %%i in ('wmic baseboard get serialnumber') do (
    echo Baseboard: %%i >> Serials.txt
    goto :4
)
:4
echo. >> Serials.txt
echo ========================================================================================================== >> Serials.txt
echo 2. Drive Volumes >> Serials.txt
echo ========================================================================================================== >> Serials.txt
echo. >> Serials.txt
setlocal enabledelayedexpansion

echo Caption, VolumeSerialNumber >> Serials.txt
for /f "tokens=1,2 delims= " %%a in ('wmic logicaldisk get caption^, volumeserialnumber ^| findstr /R /C:"[A-Z]:"') do (
    if not "%%a"=="" (
        echo %%a, %%b >> Serials.txt
    )
)

endlocal
echo. >> Serials.txt
echo ========================================================================================================== >> Serials.txt
echo 3. Mac Address >> Serials.txt
echo ========================================================================================================== >> Serials.txt
echo. >> Serials.txt
for /f "skip=1 delims=" %%a in ('wmic nicconfig where "IPEnabled=true" get MACAddress^,IPAddress /format:list ^| findstr /r /v "^$"') do (
    echo %%a >> Serials.txt
    goto :5
)
:5
echo ========================================================================================================== >> Serials.txt
echo Serials saved to Serials.txt
pause