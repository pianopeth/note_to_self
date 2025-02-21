ffmpeg -r 1/3 -i iCS_logo.png -c:v hevc_nvenc -preset lossless -vf fps=60 iCS_logo0.mp4
ffmpeg -i iCS_logo0.mp4 -vf "fade=type=in:st=0:d=0.5,fade=type=out:st=1.5:d=0.5" -c:v hevc_nvenc -preset lossless iCS_logo.mp4
del iCS_logo0.mp4
pause
