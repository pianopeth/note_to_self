@echo off 
REM transition 3-4 mp közt, default ground&sky módra váltáshoz
REM 1.mp4 kezdő és 2.mp4 befejező videó
ffmpeg -ss 00:00:03 -i 2.mp4 -c:v hevc_nvenc -preset lossless -y 2_cut.mp4
ffmpeg -i 1.mp4 -i 2_cut.mp4 -filter_complex [0:v][1:v]xfade=transition=fade:duration=1:offset=3,format=yuv420p -c:v hevc_nvenc -preset lossless -y out.mp4
del 2_cut.mp4
