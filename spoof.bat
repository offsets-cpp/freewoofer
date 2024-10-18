@echo off
pushd %~dp0
setlocal EnableDelayedExpansion
set "charset=ABCDEF0123456789"
set "result="
for /l %%i in (1,1,7) do (
    set /a index=!random! %% 16
    for %%j in (!index!) do (
        set "result=!result!!charset:~%%j,1!"
    )
)
set "result=!result!_"
for /l %%i in (1,1,10) do (
    set /a index=!random! %% 16
    for %%j in (!index!) do (
        set "result=!result!!charset:~%%j,1!"
    )
)
AsDeviceCheck /BS !result!
AsDeviceCheck /SS "Default string"
AsDeviceCheck /SU auto
AsDeviceCheck /SK "To Be Filled By O.E.M."
AsDeviceCheck /PSN "To Be Filled By O.E.M."
AsDeviceCheck /BM "Micro-Star International Co., Ltd."
AsDeviceCheck /SM "Micro-Star International Co., Ltd."
AsDeviceCheck /BV "American Megatrends International, LLC. A.BO, 10/01/2023"
AsDeviceCheck /BP "B450M MORTAR MAX (MS-7B89)"
AsDeviceCheck /SP "B450M MORTAR MAX (MS-7B89)"
AsDeviceCheck /SV "American Megatrends International, LLC. A.BO, 10/01/2023"
AsDeviceCheck /IVN "American Megatrends International, LLC."
AsDeviceCheck /IV "10/01/2023"
AsDeviceCheck /ID "10/01/2023"

for %%A in (A B C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist "%%A:\" (
        set newID=
        :generateID
        set /a digit1=!random! %% 10000
        set part1=0000!digit1!
        set part1=!part1:~-4!
        set /a digit2=!random! %% 10000
        set part2=0000!digit2!
        set part2=!part2:~-4!
        set newID=!part1!-!part2!
        VolumeID %%A: !newID! -nobanner /accepteula
    )
)
echo
echo Refreshing Serials, Please Wait.
net stop winmgmt /y >nul 2>&1
net1  stop winmgmt /y >nul 2>&1
timeout /t 2 /nobreak >nul 2>&1
net start winmgmt /y >nul 2>&1
net1  start winmgmt /y >nul 2>&1
echo.
echo.
echo.
echo.
echo.
echo.
echo Permanent Spoof Complete. Restart your PC.
pause
