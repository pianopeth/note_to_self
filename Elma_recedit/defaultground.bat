@echo off
setlocal EnableDelayedExpansion
echo Első 5mp megtartása default ground-sky módra váltáshoz (ffmpeg_crossfade.bat)
for %%f in (*.rec) do (
recedit %%f -e 00:05:00 -o %%~nf_.rec>nul
echo %%f to rec\%%~nf_.rec done
)
pause