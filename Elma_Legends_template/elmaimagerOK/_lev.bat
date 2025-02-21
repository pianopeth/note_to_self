for %%f in (lev\*.lev) do (
elma-imager-win.exe -l %%f -o png\%%~nf.png -w 2560 -h 1440 -g elmamap.lgr -Z
)
