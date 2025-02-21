@echo off
if "%2"=="" goto hiba
echo Vagas 00:00-00:%2 mp kozott:
recedit %1 -e 00:%2:00 -o %1_.rec>nul
echo OK
goto end
:hiba
echo Ket parameter kell
echo 1. filenev
echo 2. rec hossza masodpercben (vagas 00:00-00:%2 mp kozott)
:end
pause
