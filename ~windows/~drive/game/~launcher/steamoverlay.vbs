
Sub PutInClipboardText(ByVal str)
  Dim cmd
  cmd = "cmd /c ""echo " & str & "| clip"""
  CreateObject("WScript.Shell").Run cmd, 0
End Sub


Set objShell = Wscript.CreateObject("WScript.shell")
  driveG = "G:\games\"
  driveO = "O:\games\"
Dim pass
Set oParam = WScript.Arguments

Select Case oParam(0)
  ' Battle.net
  Case "Hearthstone"
    RunDir = driveO & oParam(0) & "\"
    ClientName = oParam(0) & ".exe"
    Client = RunDir & ClientName
    Launcher = RunDir & oParam(0) & " Beta Launcher.exe"
  Case "Overwatch"
    RunDir = driveO & oParam(0) & "\"
    ClientName = oParam(0) & ".exe"
    Client = RunDir & ClientName
    Launcher = RunDir & oParam(0) & " Launcher.exe"

  ' Origin
  Case "bf4"
    RunDir = driveG & "Origin Games\Battlefield 4\"
    ClientName = oParam(0) & ".exe"
    Client = RunDir & ClientName
    Launcher = RunDir & "BFLauncher.exe"

    ' SEGA
      'リンク先: "...\games\SEGA\PHANTASYSTARONLINE2\pso2_bin\pso2.exe" +0x33aca2b9
      '環境変数設定: -pso2 / +0x01e3f1e9

  ' Pmang
  Case "BlackDesert"
    RunDir = driveG & "GameOn\BlackDesert_live\bin64" & "\"
    ClientName = oParam(0) & "64.exe"
    Client = RunDir & ClientName
    Launcher = "http://blackdesert.pmang.jp/"

  ' mhf
  Case "mhf"
    RunDir = driveO & "Monster Hunter Frontier Online" & "\"
    ClientName = oParam(0) & ".exe"
    Client = RunDir & ClientName
    Launcher = Client
    ' PutInClipboardText("")

  Case "Minecraft"
    RunDir = driveG & oParam(0) & "\"
    ClientName = "javaw.exe"
    Client = RunDir & "runtime\jre-x64\1.8.0_25\bin\" & ClientName
    Launcher = RunDir & oParam(0) & "Launcher.exe"
  Case "Twitch"
    RunDir = "C:\Program Files\Java\jdk1.8.0_151\bin\"
    ClientName = "javaw.exe"
    Client = RunDir & ClientName
    Launcher = "O:\Program Launchers\Twitch\Bin\" & oParam(0) & ".exe"
  Case ""
    RunDir = driveO & oParam(0) & "\"
    ClientName = oParam(0) & ".exe"
    Client = RunDir & ClientName
    Launcher = RunDir & oParam(0) & " Launcher.exe"
End Select

' if nothing was passed in, we are starting from scratch, so start the launcher
Set objArgs = WScript.Arguments
For I = 0 to objArgs.Count - 1
   WScript.Echo objArgs(I)
Next
If WScript.Arguments.length <= 1 Then
  Home = WScript.ScriptFullName
  Home = Left(Home, InStr(Home, WScript.ScriptName)-1)
WScript.Echo Home
  'run the launcher
  Set objShell = WScript.CreateObject("Shell.Application")
  objShell.ShellExecute Launcher, "", Home

  ' create the file that the elevated script will copy executables's path and commandline to
  set fso = CreateObject("Scripting.FileSystemObject")
  set tempfolder = fso.GetSpecialFolder(2)
  tempname = tempfolder & "\" & "steam.tmp"
  set tempfile = fso.CreateTextFile(tempname)
  tempfile.close()

  'run this script but signal that it needs to elevate by giving it the tempfile name as an argument
  Set objShell = CreateObject("Shell.Application")
  objShell.ShellExecute "cscript.exe", Chr(34) & WScript.ScriptFullName & Chr(34) & " " & oParam(0) & " " & tempname , "", "runas", 2
  WScript.Echo Chr(34) & WScript.ScriptFullName & Chr(34) & " " & oParam(0) & " " & tempname

  WScript.Echo "Waiting for other script to finish..."
  ' check every second if the temporary file has been updated with the commandline info
  Do While True
    'check the filesize of the tempfile
    set tempfile = fso.GetFile(tempname)
      If tempfile.Size > 0 Then Exit Do
        WScript.Sleep 1000
      Loop

    ExecutablePath = Home
    set tempfile = fso.OpenTextFile(tempname)
    CommandLine = tempfile.ReadLine
    tempfile.close()

    Set objShell = CreateObject("Shell.Application")
    objShell.ShellExecute Client, CommandLine, RunDir
    WScript.Echo Client & " " & CommandLine & " " & RunDir

    fso.DeleteFile tempname
  WScript.Quit
Else
  ' we are elevated now
  WScript.Echo "Waiting for launcher to start client..."

  'Get Windows Manager object
  Set objWMIService = GetObject("winmgmts:" & "{impersonationLevel=impersonate}!\\.\root\cimv2")

  ' check every second for client that was launched by launcher
  While True

    'Get info on processes named Client
    Set InstanceList = objWMIService.ExecQuery _
    ("Select * from Win32_Process Where Name = '" & ClientName & "'")
    WScript.Echo Client

    for Each Instance in InstanceList
      cmdline = Instance.CommandLine

      'we found the client we care about
      Instance.Terminate()

      'remove the exe path and name from the cmdline
      position = InStr(1, cmdline, """ ") + 1
      cleanCmdLine = Right(cmdline, Len(cmdline) - position)

      tempname = WScript.Arguments(1)
      set fso = CreateObject("Scripting.FileSystemObject")
      set tempfile = fso.OpenTextFile(tempname, 2)
      tempfile.WriteLine(cleanCmdLine)
      tempfile.close()

      WScript.Quit
    Next

    WScript.Sleep 1000
  Wend
End If
