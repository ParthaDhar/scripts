@echo off
if "%1"=="" goto usage
if "%2"=="" goto usage
if not exist "C:\Program Files\%1" goto err1
if not exist "C:\Program Files\%1\DefaultUser" goto err2
md "C:\Program Files\%1\%2"
cacls "C:\Program Files\%1\%2" /C /T /E /P "%2:C"
xcopy "C:\Program Files\%1\DefaultUser" "C:\Program Files\%1\%2" /S /E /V /R /H /Y
goto end
:err1
echo �f�B���N�g�� %1 �����݂��܂���B
goto end
:err2
echo %1 �ɃT�u�f�B���N�g�� DefaultUser �����݂��܂���B
goto end
:usage
echo �A�v���P�[�V�������ƂɃ��[�U�[�A�N�Z�X���䃊�X�g��ݒ肵�܂��B
echo.
echo usage: setacl [�t�H���_��] [���[�U�[��]
:end
