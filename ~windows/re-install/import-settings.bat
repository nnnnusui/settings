set temp=.\temp\
mkdir temp
REM スタートメニュー
xcopy /S /D "%temp%Start Menu\" "%APPDATA%\Microsoft\Windows\StartMenu\"
Import-StartLayout -LayoutPath %temp%StartMenu.xml -MountPath "C:\"

REM 既定のアプリ
Dism /Online /Import-DefaultAppAssociations:%temp%AppAssociations.txt
