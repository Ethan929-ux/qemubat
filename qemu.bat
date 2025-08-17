@echo off
setlocal enabledelayedexpansion

set QEMU_PATH="C:\Program Files\qemu"
cd %QEMU_PATH%

set VM_DIR=%~dp0VMs
if not exist "%VM_DIR%" mkdir "%VM_DIR%"

:menu
cls
echo ==============================
echo       QEMU VM Launcher
echo ==============================
echo [1] Create New VM
echo [2] Launch Existing VM
echo [3] Exit
echo.
set /p choice="Select an option: "

if "%choice%"=="1" goto create
if "%choice%"=="2" goto launch
if "%choice%"=="3" exit
goto menu

:create
echo.
set /p vmname="Enter VM name (no spaces): "
set VM_CFG=%VM_DIR%\%vmname%.cfg
if exist "%VM_CFG%" (
    echo [!] VM with that name already exists.
    pause
    goto menu
)

echo.
set /p diskpath="Enter path for disk image (or leave blank for default on Desktop): "
if "%diskpath%"=="" set diskpath=%USERPROFILE%\Desktop\%vmname%-disk.qcow2
set /p disksize="Enter disk size (e.g. 40G): "
set /p isopath="Enter ISO path (leave blank if none): "
set /p ram="Enter RAM in MB (e.g. 4096): "
set /p cpus="Enter number of CPUs (e.g. 2): "

echo DISK=%diskpath%> "%VM_CFG%"
echo DISKSIZE=%disksize%>> "%VM_CFG%"
echo ISO=%isopath%>> "%VM_CFG%"
echo RAM=%ram%>> "%VM_CFG%"
echo CPUS=%cpus%>> "%VM_CFG%"

if not exist "%diskpath%" (
    echo [*] Creating disk image...
    qemu-img.exe create -f qcow2 "%diskpath%" %disksize%
)

echo [*] VM "%vmname%" created.
pause
goto menu

:launch
echo.
echo Available VMs:
for %%f in (%VM_DIR%\*.cfg) do (
    set name=%%~nf
    echo - %%~nf
)
echo.
set /p vmname="Enter VM name to launch: "
set VM_CFG=%VM_DIR%\%vmname%.cfg
if not exist "%VM_CFG%" (
    echo [!] VM not found.
    pause
    goto menu
)

for /f "tokens=1,2 delims==" %%a in (%VM_CFG%) do (
    set %%a=%%b
)

echo.
echo Launch options:
echo [1] Boot from ISO (installer)
echo [2] Boot from Disk
set /p bootchoice="Choose option: "

if "%bootchoice%"=="1" (
    qemu-system-x86_64.exe -m %RAM% -smp %CPUS% -hda "%DISK%" -cdrom "%ISO%" -boot d -vga virtio -display sdl
) else (
    qemu-system-x86_64.exe -m %RAM% -smp %CPUS% -hda "%DISK%" -vga virtio -display sdl
)

pause
goto menu
