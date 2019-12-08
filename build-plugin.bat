:: path to your installation
setlocal
SET PBCharacterMovementPath=%~dp0%

SET PluginFile=PBCharacterMovement.uplugin
SET TempDir=Build
SET PluginPath="%PBCharacterMovementPath%%PluginFile%"
SET PackagePath="%PBCharacterMovementPath%%TempDir%"

:: copy the plugin source and uplugin into a temp directory
if not exist "./Build" mkdir "./Build"
if not exist "./Build/Source" mkdir "./Build/Source"
robocopy "./Source" "./Build/Source" /s /e

:: build the plugin into a temp directory
cd /D C:\Program Files\Epic Games\UE_4.23\Engine\Build\BatchFiles\
call RunUAT.bat BuildPlugin -Plugin="%PluginPath%" -Package="%PackagePath%" -targetplatforms=Win64
:: comment this line out if you aren't running on differen drives
cd /D %~dp0%
echo %cd%

:: replace existing binary with the built plugin
robocopy "./Build/Binaries" "./Binaries" /s /e

:: delete the temp directory
rd /s /q "./Build"