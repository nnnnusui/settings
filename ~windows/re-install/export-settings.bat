set temp=.\temp\
mkdir temp
REM スタートメニュー
xcopy /S "%APPDATA%\Microsoft\Windows\Start Menu\" "%temp%StartMenu\"
Export-StartLayout -Path %temp%StartMenu.xml

REM 既定のアプリ
Dism /Online /Export-DefaultAppAssociations:%temp%AppAssociations.txt
