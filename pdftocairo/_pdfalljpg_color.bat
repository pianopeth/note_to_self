@echo off
setlocal enableextensions enabledelayedexpansion
set digits=3
	for %%g in (*.pdf) do (
	md "_%%~ng\"
		pdftocairo -jpeg -jpegopt quality=100 -r 300 "%%g"
	move "%%~ng"*.jpg "_%%~ng\">nul
	cd "_%%~ng\"
	set count=1
		for %%f in (*.jpg) do (
			set FileName=!count!
			set FileName=000!FileName!
			set FileName=!FileName:~-%digits%!
			set FileName=!FileName!%%~xf
			rename "%%f" "!FileName!"
			echo "%%f" done.
		set /A count=!count!+1
		)
	cd..
	echo.
	)

