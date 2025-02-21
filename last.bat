@echo off
echo Loading latest %1 battles...
if not "%1"=="" (start "" "https://elma.online/search?q=%1&t=battle") else (start "" "https://elma.online/battles")
exit
