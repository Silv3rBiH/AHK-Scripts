; v1.3.14
if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}
#SingleInstance Force
URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/Silv3r_Hotkeys_V2.ahk,update.txt
FileReadLine, update, update.txt, 1
FileReadLine, currentVersion, %A_ScriptName%, 1
Sleep 1000
	if (update = currentVersion) {
	FileDelete, update.txt
	} else {
	FileCopy, update.txt, %A_ScriptName%, 1
	Sleep 500
	FileDelete, update.txt
	msgbox, 0, Update uspijesan!, Update uspijesno obavljen, skripta ce se sada reloadati!
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
			Sleep 1000
			Line := False
			Loop, Read, authentication.data
			{
			If !Trim(A_LoopReadLine)
				Continue
			If InStr(A_LoopReadLine, ID)
			{
				Line := "Valid"
				Auth := "True"
				Continue
			}
			If Line
			{
				Line .= "`r`n" . A_LoopReadLine
				Break
			}}
			FileDelete, authentication.data
		}
	if Auth = True
	{
	
	if FileExist("postavke.txt") {
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/postavke.txt,postavke1.txt
		FileReadLine, updatep, postavke1.txt, 1
		FileReadLine, currentVersionp, postavke.txt, 1
		sleep 500
		if (updatef = currentVersionf) {
			FileDelete, postavke1.txt
		}else{
			FileCopy, postavke1.txt, postavke.txt, 1
			Sleep 500
			FileDelete, postavke1.txt
			Reload
			}
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/postavke.txt,postavke.txt
		Reload
		}
	if FileExist("fish1.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/fish1.jpg,fish1.jpg
		Sleep 200
		}
	if FileExist("fish2.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/fish2.jpg,fish2.jpg
		Sleep 200
		}
	if FileExist("fish3.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/fish3.jpg,fish3.jpg
		Sleep 200
		}
	if FileExist("fish4.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/fish4.jpg,fish4.jpg
		Sleep 200
		}
	if FileExist("stolica.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/stolica.jpg,stolica.jpg
		Sleep 200
		}
	if FileExist("sendvic.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/sendvic.jpg,sendvic.jpg
		Sleep 200
		}
	if FileExist("voda.jpg") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/voda.jpg,voda.jpg
		Sleep 200
		}
	if FileExist("dot.png") {
		}else{
		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/dot.png,dot.png
		Sleep 200
		}

		URLDownloadToFile,https://raw.githubusercontent.com/Silv3rBiH/AHK-Scripts/main/function.dat,function.dat
		FileReadLine, updatef, function.dat, 1
		FileReadLine, currentVersionf, %A_AppDataCommon%\Silv3rHotkey\function.dat, 1
		sleep 1500
		if (updatef = currentVersionf) {
		FileDelete, function.dat
		} else {
		FileCopy, function.dat, %A_AppDataCommon%\Silv3rHotkey\function.dat, 1
		sleep 500
		FileDelete, function.dat
		Reload
		}
	}else{
		Msgbox Skripta nije uspijesno pokrenuta, kontaktirajte kreatora. `n`n ERROR %A_ComputerName%
		Return
	}
}

#MaxThreadsPerHotkey 2
dislink1 := "https://discord.com/api/webhooks/"
dislink2 := "857482777036062720/5kIl4yYt-5IebLjX6goDB-HunKFjzircuG69Zu-IOdswDFvXe63hDpo9UbDHXtyDQtvi"
dislink = %dislink1%%dislink2%

#Include *i postavke.txt
#Include *i %A_AppDataCommon%\Silv3rHotkey\function.dat
