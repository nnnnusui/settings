function Add-Environment {
param(
    [string]$key,
    [string]$value,
    [string]$scope = "User"
    )
    $values = [System.Environment]::GetEnvironmentVariable($key, $scope)
    $values += ";"+ $value
    [System.Environment]::SetEnvironmentVariable($key, $values, $scope)
}

# スクリプトのあるディレクトリに移動
$scriptPath = $MyInvocation.MyCommand.Path
$dir = Split-Path -Parent $scriptPath
Set-Location $dir

# 環境変数を登録
Import-Csv ./env.csv -Encoding UTF8 | % {
    $key = $_.key
    $value = $dir +"\"+ $_.relativeValue
    Add-Environment -key $key -value $value
}
