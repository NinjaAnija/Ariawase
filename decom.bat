@echo off
setlocal enabledelayedexpansion
cd %~dp0

for /f "usebackq delims=" %%x in (`git remote -v ^| findstr ^^origin ^| findstr ^(fetch^)`) do set test=%%x
set test=P:\54_BPR\31_Snapshot\%test:~44,-8%

cscript //nologo vbac.wsf decombine

set /a backup=3

if exist "%test%\%backup%\" (
  rmdir /s /q "%test%\%backup%"
)

for /l %%i in (%backup%, -1, 1) do (
  set /a x=%%i-1
  if exist "%test%\!x!\" (
    move "%test%\!x!" "%test%\%%i"
  )
)

xcopy /E /C /I . "%test%\0"
set bakdate=%date%
set baktime=%time: =0%
type nul > "%test%\0\.at_%bakdate:~0,4%_%bakdate:~5,2%_%bakdate:~8,2%_%baktime:~0,2%_%baktime:~3,2%_%baktime:~6,2%_by_%username%"
