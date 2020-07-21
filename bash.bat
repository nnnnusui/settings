@echo off
set pwd=%~dp0
cd /d %pwd%
call init.bat


start %GIT_HOME%\git-bash

exit /B