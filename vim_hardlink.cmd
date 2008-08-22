@echo off
if "%1"=="" goto usage
if not exist "%1\vim.exe" goto novim
if not exist "%1\gvim.exe" goto novim
if exist "%SCRIPTS%\bin\lnk.exe" goto hardlink

:filecopy
copy "%1\vim.exe" "%1\v.exe"
copy "%1\gvim.exe" "%1\g.exe"
goto end

:hardlink
"%SCRIPTS%\bin\lnk.exe" "%1\vim.exe" "%1\v.exe"
"%SCRIPTS%\bin\lnk.exe" "%1\gvim.exe" "%1\g.exe"
"%SCRIPTS%\bin\lnk.exe" "%1\gvim.exe" "%1\vi.exe"
goto end

:novim
echo vim��������܂���.
goto end

:usage
echo %0 [vim_path]
:end
