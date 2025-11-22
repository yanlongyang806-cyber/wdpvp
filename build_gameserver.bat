@echo off
REM Build script for GameServer.exe
REM This script builds GameServer.exe with the modified pvp_common.c

echo ========================================
echo Building GameServer.exe
echo ========================================
echo.

REM Change to project root
cd /d I:\gp5

REM Check if MSBuild is available
where msbuild >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: MSBuild not found in PATH
    echo Please use Visual Studio Developer Command Prompt
    echo Or add MSBuild to your PATH
    pause
    exit /b 1
)

echo Step 1: Building GameServerLib (contains modified pvp_common.c)...
msbuild CrossRoads\GameServerLib\GameServerLib.vcxproj /t:Rebuild /p:Configuration=Debug /p:Platform=Win32 /v:minimal
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to build GameServerLib
    pause
    exit /b 1
)

echo.
echo Step 2: Building GameServer.exe...
msbuild GameServer\NNOGameServer.vcxproj /t:Rebuild /p:Configuration=Debug /p:Platform=Win32 /v:minimal
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to build GameServer
    pause
    exit /b 1
)

echo.
echo ========================================
echo Build completed successfully!
echo ========================================
echo.
echo GameServer.exe should be located at:
echo I:\gp5\bin\GameServer.exe
echo.

if exist "I:\gp5\bin\GameServer.exe" (
    echo [SUCCESS] GameServer.exe found!
    dir "I:\gp5\bin\GameServer.exe"
) else (
    echo [WARNING] GameServer.exe not found in expected location
    echo Please check the build output for errors
)

pause

