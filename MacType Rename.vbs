Option Explicit
ElevatePermission

Dim SH, FS
Set SH = WScript.CreateObject("WScript.Shell")
Set FS = WScript.CreateObject("Scripting.FileSystemObject")

SH.CurrentDirectory = SH.SpecialFolders("AllUsersPrograms") & "\MacType"
ren "MacType Tray.lnk", "MacType Tray.lnk"
ren "MacType 用户向导.lnk", "MacType ウィザード.lnk"
ren "MacType 配置程序.lnk", "MacType セットアップウィザード.lnk"
ren "卸载 MacType.lnk", "MacType のアンインストール.lnk"
ren "更新 MacType.lnk", "MacType のアップデート.lnk"

SH.CurrentDirectory = SH.SpecialFolders("AllUsersDesktop")
ren "MacType 用户向导.lnk", "MacType ウィザード.lnk"
ren "MacType 配置程序.lnk", "MacType セットアップウィザード.lnk"
hidden "MacType ウィザード.lnk"
hidden "MacType セットアップウィザード.lnk"

Sub ren(source, destination)
	If (FS.FileExists(source)) Then
		FS.MoveFile source, destination
	End If

	If (FS.FileExists(destination)) Then
		With SH.CreateShortcut(destination)
			.Description = ""
			.Save
		End With
	End If
End Sub

Sub hidden(filespec)
	Dim file
	If (FS.FileExists(filespec)) Then
		Set file = FS.GetFile(filespec)
		file.Attributes = (file.Attributes Or 2)
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
