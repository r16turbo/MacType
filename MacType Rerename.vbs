Option Explicit
ElevatePermission

Dim SH, FS
Set SH = WScript.CreateObject("WScript.Shell")
Set FS = WScript.CreateObject("Scripting.FileSystemObject")

SH.CurrentDirectory = SH.SpecialFolders("AllUsersPrograms") & "\MacType"
ren "MacType Tray.lnk", "MacType Tray.lnk"
ren "MacType ウィザード.lnk", "MacType 用户向导.lnk"
ren "MacType セットアップウィザード.lnk", "MacType 配置程序.lnk"
ren "MacType のアンインストール.lnk", "卸载 MacType.lnk"
ren "MacType のアップデート.lnk", "更新 MacType.lnk"

SH.CurrentDirectory = SH.SpecialFolders("AllUsersDesktop")
ren "MacType ウィザード.lnk", "MacType 用户向导.lnk"
ren "MacType セットアップウィザード.lnk", "MacType 配置程序.lnk"

Sub ren(source, destination)
	If (FS.FileExists(source)) Then
		FS.MoveFile source, destination
	End If
End Sub


Sub ElevatePermission
    Dim Shell
    ' No arguments
    If WScript.Arguments.Count = 0 Then
    	' Run this script as admin
    	Set Shell = CreateObject("Shell.Application")
    	Shell.ShellExecute "wscript.exe", """" & WScript.ScriptFullName & """ uac", "", "runas"
    	WScript.Quit
    End If
End Sub
