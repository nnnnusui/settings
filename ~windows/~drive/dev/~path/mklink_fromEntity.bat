@echo off
cd /d %~dp0

mklink /D curl  ~entity\curl-7.59.0
mklink /D MinGW ~entity\MinGW
mklink /D git   ~entity\PortableGit
mklink /D ansicon ~entity\ansicon

mklink /D glsl    ~entity\glsl
mklink /D go      ~entity\go
mklink /D java    ~entity\java\jdk-11.0.2
mklink /D kotlinc ~entity\kotlinc\1.3.21
mklink /D kuin    ~entity\kuin_2017_09_17
mklink /D Python  ~entity\Python\36_5
pause