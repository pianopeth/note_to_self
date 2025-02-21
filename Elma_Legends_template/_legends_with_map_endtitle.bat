@echo off
setlocal EnableDelayedExpansion
echo    Elasto Mania Legends - video making script by iCS 2022-09-05
echo.
echo 	FOR CORRECT OPERATION, PLEASE PUT:
echo 	recplay videos in MP4 folder (MP4 files, 60fps)
echo 	footers in FOOTERS folder (PNG files)
echo 	maps in MAPS folder (PNG files)
echo 	title in TITLE folder (PNG file)
echo.
echo 	ALL IN 2560X1440 RESOLUTION!
echo    ----------------------------
echo.

CD mp4
	echo.
	echo Renaming mp4 videos
	echo -------------------
	set w=0
	set q=1
	for %%f in (*.mp4) do (
	set w=000000!q!
	set w=!w:~-2!
	echo %%f to !w!.mp4
	ren %%f "!w!.mp4"
	set /a q+=1
	)
CD ..

CD footers
	echo.
	echo Renaming footer pngs
	echo --------------------
	set q=1
	for %%f in (*.png) do (
	set w=000000!q!
	set w=!w:~-2!
	echo %%f to !w!.png
	ren "%%f" "!w!.png"
	set /a q+=1
	)
CD ..

CD mp4
	echo.
	echo Adding png footer overlays to mp4 videos
	echo ----------------------------------------

	set numf=0
	for %%f in (*.mp4) do (
	ffmpeg -loglevel warning -i %%f -i ..\footers\%%~nf.png -filter_complex 'overlay' -c:v hevc_nvenc -preset lossless ..\overlays\%%~nf_overlay.mp4
	set /a numf+=1
	echo Added footer to %%f
	)
CD..

CD mapsfoot
	echo.
	echo Renaming map footer pngs
	echo --------------------
	set q=1
	for %%f in (*.png) do (
	set w=000000!q!
	set w=!w:~-2!
	echo %%f to !w!.png
	ren "%%f" "!w!.png"
	set /a q+=1
	)
CD ..

CD maps
	echo.
	echo Converting map pngs to mp4 videos
	echo ---------------------------------
	for %%g in ("*.png") do (
	ffmpeg -loglevel error -r 1/7 -i %%g -c:v hevc_nvenc -preset lossless -vf fps=60 %%~ng.mp4
	)
	echo Renaming map mp4 videos
	echo ------------------------
	set w=0
	set q=1
	for %%f in (*.mp4) do (
	set w=000000!q!
	set w=!w:~-2!
	echo %%f to !w!.mp4
	ren %%f "!w!.mp4"
	set /a q+=1
	)
	echo.
	echo Adding footer overlays to map mp4 videos
	echo ----------------------------------------
	set numf=0
	for %%f in (*.mp4) do (
	ffmpeg -loglevel warning -i %%f -i ..\mapsfoot\%%~nf.png -filter_complex 'overlay' -c:v hevc_nvenc -preset lossless ..\overlays\%%~nf_map.mp4
	set /a numf+=1
	echo Added footer to %%f
	)
CD..

echo.
echo Creating title.mp4 video from title.png
echo ---------------------------------------
ffmpeg -loglevel error -r 1/7 -i title\title.png -c:v hevc_nvenc -preset lossless -vf fps=60 temp\00_title.mp4
echo.
echo Adding title fade-in
echo --------------------
ffmpeg -loglevel warning -i temp\00_title.mp4 -filter:v "fade=in:0:90" -c:v hevc_nvenc -preset lossless overlays\00_title.mp4

echo.
echo Creating endtitle.mp4 video from endtitle.png
echo ---------------------------------------
ffmpeg -loglevel error -r 1/7 -i title\endtitle.png -c:v hevc_nvenc -preset lossless -vf fps=60 temp\endtitle.mp4
echo.
echo Adding endtitle fade-out
echo --------------------
ffmpeg -loglevel warning -i temp\endtitle.mp4 -filter:v "fade=out:st=5.5:d=1.5" -c:v hevc_nvenc -preset lossless overlays\endtitle.mp4
echo.
echo Adding end logo
echo ---------------
copy iCS_logo\iCS_logo.mp4 overlays\ >nul

CD overlays
	echo.
	echo Joining videos
	echo --------------
	for %%f in (*.mp4) do (
		echo file %%f >> list.txt
		echo %%f
	)
	echo.
	echo Creating final video LEGENDS.mp4
	ffmpeg -loglevel warning -f concat -safe 0 -i list.txt -c copy ..\LEGENDS.mp4
	echo DONE
	echo.
	del list.txt

CD..

if exist temp\*.mp4 del temp\*.mp4
rem if exist overlays\*.mp4 del overlays\*.mp4
if exist maps\*.mp4 del maps\*.mp4

echo.
pause
