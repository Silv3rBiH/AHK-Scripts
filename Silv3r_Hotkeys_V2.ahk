; v1.2.2
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/Silv3r_Hotkeys_V2.ahk,update.txt
FileReadLine, update, update.txt, 1
FileReadLine, currentVersion, %A_ScriptName%, 1
	if (update = currentVersion) {
	FileDelete, update.txt
	} else {
	FileCopy, update.txt, %A_ScriptName%, 1
	FileDelete, update.txt
	msgbox, 0, Update uspiješan!, Update uspiješno obavljen, skripta će se sada ;reloadati!
	Reload
	}

if FileExist("key.dll") 
{
	FileAppend, `n%A_ComputerName%`n, key.dll
	FileCreateDir, %A_AppDataCommon%\Silv3rHotkey\
	FileCopy, key.dll, %A_AppDataCommon%\Silv3rHotkey\
	FileDelete, key.dll
	MsgBox %A_ComputerName%
	Reload
}else{
	IfNotExist, %A_AppDataCommon%\Silv3rHotkey\key.dll
		{
		Msgbox Skripta nije uspijesno pokrenuta, kontaktirajte kreatora. `n`n ERROR KEY %A_ComputerName%
		return
		}else{
			FileReadLine, DiscordID, %A_AppDataCommon%\Silv3rHotkey\key.dll, 1
			FileReadLine, UserName, %A_AppDataCommon%\Silv3rHotkey\key.dll, 2
			FileReadLine, ID, %A_AppDataCommon%\Silv3rHotkey\key.dll, 3
			URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/IDs.txt,authentication.data
			Line := False
			Loop, Read, authentication.data
			{
			If !Trim(A_LoopReadLine)
				Continue
			If InStr(A_LoopReadLine, ID)
			{
				Line := "Valid"
				Continue
			}
			If Line
			{
				Line .= "`r`n" . A_LoopReadLine
				Break
			}}
			FileDelete, authentication.data
		}
	if line = Valid
	{
	
		if FileExist("postavke.txt") {
		}else{
			URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/postavke.txt,postavke.txt
			Reload
			}
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/function.dat,function.dat
		sleep 2000
		FileReadLine, updatef, function.dat, 1
		FileReadLine, currentVersionf, %A_AppDataCommon%\Silv3rHotkey\function.dat, 1
		if (updatef = currentVersionf) {
		FileDelete, function.dat
		} else {
		FileCopy, function.dat, %A_AppDataCommon%\Silv3rHotkey\function.dat, 1
		FileDelete, function.dat
		Reload
		}
	}else{
		Msgbox Skripta nije uspijesno pokrenuta, kontaktirajte kreatora. `n`n ERROR %A_ComputerName%
		Return
	}
}

#MaxThreadsPerHotkey 2

#Include *i postavke.txt
#Include *i %A_AppDataCommon%\Silv3rHotkey\function.dat
