# 管理者権限が無ければ要求して再起動
If (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {   
    $arguments = "& '" + $myinvocation.mycommand.definition + "'"
    Start-Process powershell -Verb runAs -ArgumentList $arguments
    Break
}

# スクリプトのあるディレクトリに移動
$scriptPath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path -Parent $scriptPath
Set-Location $scriptDir

# 日付名フォルダ生成
$now = Get-Date -Format "yyyy-MM-dd_HH-mm_ss"
New-Item "./${now}" -Type Directory
Set-Location "./${now}"

# 「スタートメニューショートカット」のコピー
Copy-Item -LiteralPath "${env:APPDATA}\Microsoft\Windows\Start Menu\Programs\" -Destination "." -Recurse

# 「スタートメニューレイアウト」のExport
Export-StartLayout -Path StartMenu.xml

# 「既定のアプリ」のExport
Dism /Online /Export-DefaultAppAssociations:AppAssociations.txt

pause
