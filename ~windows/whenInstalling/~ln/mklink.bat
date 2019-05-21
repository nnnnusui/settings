@echo off

REM HINT=http://qiita.com/usagi/items/2623145f22faf54b99e0

cd %~dp0

:checkMandatoryLevel
REM ▼管理者として実行されているか確認 START
for /f "tokens=1 delims=," %%i in ('whoami /groups /FO CSV /NH') do (
    if "%%~i"=="BUILTIN\Administrators" set ADMIN=yes
    if "%%~i"=="Mandatory Label\High Mandatory Level" set ELEVATED=yes
)

if "%ADMIN%" neq "yes" (
    echo このファイルは管理者権限での実行が必要です{Administratorsグループでない}
    goto runas
)
if "%ELEVATED%" neq "yes" (
    echo このファイルは管理者権限での実行が必要です{プロセスが昇格されていない}
    goto runas
)
REM ▲管理者として実行されているか確認 END

:admins
    REM ▼管理者として実行したいコマンド START

@echo on
REM '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

SET DRIVE_AFTER=%~dp0\
SET CSV_file=%~dp0\Data_list.csv
SET /P BEFORE_DRIVE_CHARACTER=リンク元のドライブ名:
SET DRIVE_BEFORE=%BEFORE_DRIVE_CHARACTER%:\
@echo off
pause

@echo off
:SETDelayedExpansionEnable
SETLOCAL enabledelayedexpansion
:SetArrayIndex
SET Array_Index_x=0
SET Array_Index_y=0

:SetArray
FOR /F "delims=" %%I IN (%CSV_file%) DO (
        SET /A Array_Index_x+=1
	For %%i IN (%%I) DO (
	        SET /A Array_Index_y+=1
	        SET Array[!Array_Index_x!][!Array_Index_y!]=%%i
		ECHO !Array_Index_x! !Array_Index_y! %%i
	)
	SET Array[!Array_Index_x!][0]=!Array_Index_y!
	SET Array_Index_y=0
)
SET /p ANSWER=続行しますか？(Y/N):
if /i {%ANSWER%}=={y} (goto :yes)
if /i {%ANSWER%}=={yes} (goto :yes)
EXIT

:yes
:EchoArray
FOR /L %%I IN (1,1,!Array_Index_x!) DO (
	FOR /L %%i IN (2,1,!Array[%%I][0]!) DO (
		SET OUTPUT=!Array[%%I][1]:"=!!Array[%%I][%%i]:"=!
		
REM		if exist "%DRIVE_BEFORE%!OUTPUT!" (
REM			rmdir "%DRIVE_BEFORE%!OUTPUT!"
REM		)
		mkdir "%DRIVE_AFTER%!OUTPUT!"
		mklink /d "%DRIVE_BEFORE%!OUTPUT!" "%DRIVE_AFTER%!OUTPUT!"
		REM call :SuccessOrDie
	)
)

goto end

:SuccessOrDie
if not %errorlevel% == 0 (
    echo [ERROR] :P
    pause
)
exit /b 0

:end
echo [SUCCESS] :)
echo on
pause
exit 0

REM '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

	pause >nul
    REM ▲管理者として実行したいコマンド END
    goto exit1

:runas
    REM ★管理者として再実行
    powershell -Command Start-Process -Verb runas "%0" 

:exit1
