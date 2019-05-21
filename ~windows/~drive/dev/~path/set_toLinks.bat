@echo off
cd /d %~dp0

set CURL_HOME=%CD%\curl
set GIT_HOME=%CD%\git
set MINGW_HOME=%CD%\MinGW
set ANSICON_HOME=%CD%\ansicon

set GLSL_HOME=%CD%\glsl
set GO_HOME=%CD%\go
set JAVA_HOME=%CD%\java
set KOTLIN_HOME=%CD%\kotlinc
set KUIN_HOME=%CD%\kuin
set PYTHON_HOME=%CD%\python


set PATH=%PATH%;%CURL_HOME%\AMD64
set PATH=%PATH%;%GIT_HOME%\bin
set PATH=%PATH%;%MINGW_HOME%\bin
set PATH=%PATH%;%ANSICON_HOME%\x64

set PATH=%PATH%;%GLSL_HOME%
set PATH=%PATH%;%GO_HOME%\bin
set PATH=%PATH%;%JAVA_HOME%\bin
set PATH=%PATH%;%KOTLIN_HOME%\bin
set PATH=%PATH%;%KUIN_HOME%
set PATH=%PATH%;%PYTHON_HOME%

cd ..\~home

start /min "" "cmd /c "call %1""