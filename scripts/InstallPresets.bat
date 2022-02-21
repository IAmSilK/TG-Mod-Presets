@echo off

:START

title TacticalGaming.net Arma 3 Mod Preset Installer

echo ------------------------------------------------------------
echo TacticalGaming.net Arma 3 Mod Preset Installer
echo.
echo This script will automatically download and add the mod
echo presets of the Tactical Gaming unit to your Arma 3 Launcher.
echo ------------------------------------------------------------
echo.
echo Running this script may overwrite your existing TG presets.
echo This will not overwrite non-TG presets.
echo.
echo If you'd like to continue running this script, you can press
echo any key to continue; otherwise, close this window.

pause >nul

echo ------------------------------------------------------------

:CHECK_DIRECTORY

set PRESETS_DIRECTORY=%localappdata%\Arma 3 Launcher\Presets

if not exist "%PRESETS_DIRECTORY%\" (
	echo Could not find the presets directory. This script did not install the presets.
	echo Contact your CoC for support.
	goto END
)

:CLOSE_LAUNCHER

set LAUNCHER_PROCESS=arma3launcher.exe

echo Closing Arma 3 Launcher if it is open.
echo.

taskkill /T /IM %LAUNCHER_PROCESS% >nul 2>nul

:DOWNLOAD_PRESETS

echo ------------------------------------------------------------
echo Downloading mod presets list

set REMOTE_GITHUB_REPO_URL=https://raw.githubusercontent.com/TacticalGaming-net/ARMA-Mod-Presets/main

set REMOTE_PRESETS_LIST_URL=%REMOTE_GITHUB_REPO_URL%/enabled_presets.txt
set REMOTE_PRESETS_URL=%REMOTE_GITHUB_REPO_URL%/presets

set PRESETS_LIST_FILE=%TEMP%\tg_presets_list.txt

powershell -Command "Invoke-WebRequest \"%REMOTE_PRESETS_LIST_URL%\" -OutFile \"%PRESETS_LIST_FILE%\""

for /F "usebackq tokens=*" %%a in ("%PRESETS_LIST_FILE%") do (
	echo Downloading preset %%~a
	
	powershell -Command "Invoke-WebRequest \"%REMOTE_PRESETS_URL%/%%~a\" -OutFile \"%PRESETS_DIRECTORY%\%%~a\""
)

del "%PRESETS_LIST_FILE%" >nul 2>nul

:SUBSCRIBE_MODS

echo ------------------------------------------------------------
echo Opening Steam Workshop collection page.
echo.
echo Click 'Subscribe to all' on the Steam page that is opening.

start steam://url/CommunityFilePage/2733485006

:SUCCESS

echo ------------------------------------------------------------
echo Successfully downloaded mod presets.
echo.
echo You can select a mod preset by launching the Arma 3 Launcher
echo and going into the Mods tab. From the Mods tab, you can
echo choose a preset in the top-right corner where it says PRESET.
echo Click the PRESET drop-down and select a mod preset. From
echo there, you can launch the game and join a server.

:END

echo.
echo This script will exit now.
pause