@echo off 
setlocal EnableDelayedExpansion
REM transition 1-2 mp közt, lastframe->results váltáshoz
REM 12db 1_xx.mp4 kezdő és 2_xx.mp4 befejező videó

for %%f in (01, 02, 03, 04, 05, 06, 07, 08, 09, 10, 11, 12) do (
ffmpeg -ss 00:00:01 -i 2_%%f.mp4 -c:v hevc_nvenc -preset lossless -y 2_%%f_cut.mp4
ffmpeg -i 1_%%f.mp4 -i 2_%%f_cut.mp4 -filter_complex [0:v][1:v]xfade=transition=fade:duration=1:offset=1,format=yuv420p -c:v hevc_nvenc -preset lossless -y %%f_out.mp4
del 2_%%f_cut.mp4
)
pause
