@echo off
title Teen's Club Registration Server
color 0A
echo.
echo  ======================================================
echo    Teen's Club Registration System - Starting Server
echo  ======================================================
echo.

:: ─── OPTIONAL: Set a custom Google Drive backup path ─────────────────────────
:: If the auto-detection doesn't find your Google Drive folder, uncomment the
:: line below (remove the leading ":: ") and set the correct path.
::
:: set GDRIVE_BACKUP_PATH=C:\Users\YourName\My Drive
::
:: Common paths:
::   Google Drive for Desktop (new):  C:\Users\YourName\My Drive
::   Old Google Drive app:            C:\Users\YourName\Google Drive
::   OneDrive:                        C:\Users\YourName\OneDrive
:: If left blank, backups go to:      C:\TeensClubApp_v2\backend\data\backups\
:: ─────────────────────────────────────────────────────────────────────────────

cd /d "%~dp0backend"

:: Always verify express is available, not just whether node_modules folder exists
echo  [CHECK] Verifying backend packages...
node -e "require('express')" >nul 2>&1
if errorlevel 1 (
    echo  [SETUP] Packages missing or incomplete. Installing backend packages...
    echo  This may take 2-3 minutes. Please wait...
    echo.
    call npm install
    if errorlevel 1 (
        echo.
        echo  ERROR: npm install failed. Make sure Node.js is installed.
        echo  Download from: https://nodejs.org
        pause
        exit /b 1
    )
    echo.
    echo  [SETUP] Backend packages installed successfully!
    echo.
) else (
    echo  [CHECK] Backend packages OK.
    echo.
)

:: Build backend if dist is missing
if not exist "dist\server.js" (
    echo  [SETUP] Compiling backend TypeScript...
    call npm run build
    if errorlevel 1 (
        echo.
        echo  ERROR: Backend build failed. Check TypeScript errors above.
        pause
        exit /b 1
    )
    echo  [SETUP] Backend compiled successfully!
    echo.
)

:: Build frontend if dist is missing
if not exist "%~dp0frontend\dist\" (
    echo  [SETUP] First-time setup: building the UI...
    cd /d "%~dp0frontend"
    if not exist "node_modules\" (
        echo  Installing frontend packages...
        call npm install
    )
    call npm run build
    if errorlevel 1 (
        echo  ERROR: Frontend build failed.
        pause
        exit /b 1
    )
    echo  [SETUP] UI built successfully!
    echo.
    cd /d "%~dp0backend"
)

echo  Starting server on port 3001...
echo  Open your browser and go to: http://localhost:3001
echo.

:: Get the real Wi-Fi IP (ignores VMware, Hotspot, Loopback adapters)
for /f "delims=" %%a in ('powershell -NoProfile -Command "Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -like '*Wi-Fi*' -and $_.IPAddress -notlike '169.*' } | Select-Object -First 1 -ExpandProperty IPAddress"') do set WIFI_IP=%%a

:: Fallback: grab any non-virtual IPv4 if Wi-Fi name is different
if not defined WIFI_IP (
    for /f "delims=" %%a in ('powershell -NoProfile -Command "Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -notlike '*Loopback*' -and $_.InterfaceAlias -notlike '*VMware*' -and $_.InterfaceAlias -notlike '*vEthernet*' -and $_.InterfaceAlias -notlike '*Local Area Connection* 2*' -and $_.IPAddress -notlike '169.*' } | Sort-Object -Property { ($_.IPAddress -split '\.')[0] -as [int] } | Select-Object -Last 1 -ExpandProperty IPAddress"') do set WIFI_IP=%%a
)

echo  Network: http://%WIFI_IP%:3001  ^<- Share this with other PCs on LAN
echo.
echo  Keep this window open while using the app.
echo  ======================================================
echo.

node dist\server.js

echo.
echo  Server stopped. Press any key to exit.
pause
