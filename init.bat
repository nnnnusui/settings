@echo off
set pwd=%~dp0
cd /d %pwd%
set home=%pwd%home\
set tool=%pwd%~tool\
call ~env\set-path.bat
set PATH=%PATH%;%pwd%~start

set USERPROFILE=%home%
set GRADLE_USER_HOME=%home%.gradle
cd %home%
