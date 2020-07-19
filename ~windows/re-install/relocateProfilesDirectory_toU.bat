@echo off
echo "Relocate for U:"
pause
%windir%\System32\sysprep\sysprep.exe /reboot /unattend:%~dp0\relocate_toU.xml