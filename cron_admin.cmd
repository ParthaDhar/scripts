@echo off
if "%1"=="cronlog" goto cronlog
if "%1"=="crontab" goto crontab
if "%2"=="" goto usage
if "%1"=="run" goto run
if "%1"=="log" goto log
if "%1"=="kick" goto kick
goto usage

:run
"C:\cron\bin\%2"
goto end

:log
gvim "C:\cron\log\%2.log"
goto end

:kick
echo kick>"C:\cron\kick\%2.kck"
goto end

:cronlog
gvim "C:\cron\crontab.log"
goto end

:crontab
gvim "C:\cron\crontab.ini"
goto end

:usage
echo %0 by id774 <idnanashi@gmail.com>
echo �g�p���@
echo %0 run [jobname] ... Job�����s����
echo %0 log [logname] ... log�t�@�C�����J��
echo %0 kick [jobname]... �g���K�[�t�@�C�����쐬����
echo %0 cronlog       ... cron�̃��O���J��
echo %0 crontab       ... crontab��ҏW����
:end
