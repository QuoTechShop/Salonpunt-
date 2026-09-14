@echo off
chcp 65001 >nul
cd /d "%~dp0"

if not exist ".git" (
  echo Deze map is nog geen repository.
  echo Open GitHub Desktop, File ^> Add local repository, en kies deze map.
  pause
  exit /b 1
)

echo Wijzigingen opsturen...
echo.
git add -A
git diff --cached --quiet
if %errorlevel%==0 (
  echo Er is niets veranderd sinds de vorige keer.
  timeout /t 4 ^>nul
  exit /b 0
)

git --no-pager diff --cached --stat
echo.
git commit -m "Site bijgewerkt %date% %time%"
if errorlevel 1 goto fout
git push
if errorlevel 1 goto fout

echo.
echo ================================================
echo  Verstuurd. Plesk zet het binnen enkele seconden
echo  live op salonpunt.cloudpage.nl
echo ================================================
timeout /t 6 ^>nul
exit /b 0

:fout
echo.
echo Er ging iets mis - lees de melding hierboven.
echo Staat er iets over "Authentication failed"? Dan is je
echo GitHub-toegang verlopen; open een keer GitHub Desktop
echo en push daar, dan zit het weer goed.
pause
