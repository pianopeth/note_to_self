@echo off
REM utsó 2mp megtartása
setlocal EnableDelayedExpansion
for %%f in (*.mp4) do (
ffmpeg -sseof -00:00:02 -i %%f -c:v hevc_nvenc -preset lossless %%~nf_last.mp4
)
pause
