set FORMATTER_PATH="C:\Users\tn1057\Documents\Projekte\Mobile_3000"
set indir="%FORMATTER_PATH%/Src/RM"
set backup="C:\Users\tn1057\Documents\Projekte\FilesBackup"
set copyfiles=MOVE
set fileext=.unc-backup.md5~

cd %FORMATTER_PATH%


@echo off



@echo off & for /F "tokens=1-4 delims=/ " %%A in ('date/t') do (
set DateDay=%%A
set DateMonth=%%B
set DateYear=%%C
)

@echo off & for /F "tokens=1-4 delims=/ " %%D in ('time/t') do (
set DateTime=%%D
)
SET HOUR=%time:~0,2%
IF "%HOUR:~0,1%" == " " SET HOUR=0%HOUR:~1,1%

set CurrentDate=%DateDay%%DateMonth%%DateYear%_%HOUR%.%time:~3,2%.%time:~6,2%

set outdir=%backup%\%CurrentDate%_backup


echo %CurrentDate%
echo %outdir%
mkdir %outdir%

for /F "tokens=*" %%f in ('dir /S /b %indir%\*.c') do (
        echo "%%f".
		uncrustify -c %FORMATTER_PATH%/ProemionConfig.cfg --replace %%f
)

for /F "tokens=*" %%f in ('dir /S /b C:\Users\tn1057\Documents\Projekte\Mobile_3000\Src\RM\*.h') do (
        echo "%%f".
		uncrustify -c %FORMATTER_PATH%/ProemionConfig.cfg -l c  --replace  %%f
)

::uncrustify -c %FORMATTER_PATH%/ProemionConfig.cfg --replace %FORMATTER_PATH%/Src/RM/gsm.c 

del %outdir%\*unc-backup.md5~
del %outdir%\*unc-backup~
move %indir%\*.unc-backup.md5~ %outdir%
move %indir%\*.unc-backup~ %outdir%
pause

@echo off
pushd "%temp%"
makecab /D RptFileName=~.rpt /D InfFileName=~.inf /f nul >nul
for /f "tokens=3-7" %%a in ('find /i "makecab"^<~.rpt') do (
   set "current-date=%%e-%%b-%%c"
   set "current-time=%%d"
   set "weekday=%%a"
)
del ~.*
popd
echo %weekday% %current-date% %current-time%
pause