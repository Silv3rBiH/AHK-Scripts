﻿if not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"  ; Requires v1.0.92.01+
   ExitApp
}

Process_Suspend(PID_or_Name){
    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name
    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
    If !h   
        Return -1
    DllCall("ntdll.dll\NtSuspendProcess", "Int", h)
    DllCall("CloseHandle", "Int", h)
}

Process_Resume(PID_or_Name){
    PID := (InStr(PID_or_Name,".")) ? ProcExist(PID_or_Name) : PID_or_Name
    h:=DllCall("OpenProcess", "uInt", 0x1F0FFF, "Int", 0, "Int", pid)
    If !h   
        Return -1
    DllCall("ntdll.dll\NtResumeProcess", "Int", h)
    DllCall("CloseHandle", "Int", h)
}

ProcExist(PID_or_Name=""){
    Process, Exist, % (PID_or_Name="") ? DllCall("GetCurrentProcessID") : PID_or_Name
    Return Errorlevel
}

#MaxThreadsPerHotkey 2

; ===============
; === HOTKEYS ===
; ===============

PrikaziSveKomandeKey          := "!0" ; Prikaz svih komandi unutar ovog programa.

PretresOvjeravanjeKey         := "!1" ; HOTKEY ZA PRETRES I OVJERAVANJE AKO LEZI
PretresLeziKey                := "!2" ; HOTKEY ZA PRETRES AKO LEZI
PretresPredaoKey              := "!3" ; HOTKEY ZA PRETRES AKO JE DIGAO RUKE
OvjeravanjeKey                := "!4" ; HOTKEY ZA OVJERAVANJE
DizanjePovrijedjenogKey       := "!5" ; HOTKEY ZA DIZANJE OSOBE S PODA
OduzimanjeKomunikacijeKey     := "!6" ; HOTKEY ZA ODUZIMANJE KOMUNIKACIJE
PronalazakKey                 := "!7" ; HOTKEY ZA PRONALAZAK
NePronalazakKey               := "!8" ; HOTKEY ZA NE PRONALAZAK

GepekInventoriKey             := "!i" ; HOTKEY ZA GEPEK + INVENTORI
GepekKey                      := "!l" ; HOTKEY ZA GEPEK BRZO
UnequipKey                    := "!q" ; HOTKEY ZA BRZI UNEQUIP ORUZJA

PripremaPecanjeKey            := "F8" ; HOTKEY ZA BRZI UNEQUIP ORUZJA
PecanjeKey                    := "F9" ; HOTKEY ZA BRZI UNEQUIP ORUZJA
KupovinaOpremeKey             := "!o" ; HOTKEY ZA BRZI UNEQUIP ORUZJA
AFKKey                        := "!a" ; HOTKEY ZA BRZI UNEQUIP ORUZJA
RudarenjeKey                  := "!r" ; HOTKEY ZA BRZI UNEQUIP ORUZJA
SadjenjeKey                   := "!s" ; HOTKEY ZA BRZI UNEQUIP ORUZJA
DorucakKey                    := "!j" ; HOTKEY ZA BRZI UNEQUIP ORUZJA

QuickRelogKey                 := "!F12" ; HOTKEY ZA RELOG RAGEMP
ReloadKey                     := "F12" ; HOTKEY ZA RELOAD SKRIPTE

; Sleep time (Obicno ne treba mijenjati ovo, u slucaju nekih problema pokušati s promjenama)
IntLMenuDelay        := 800  ; delay (in ms) after focussing game when AHK-GUI took focus.
IntMMenuDelay        := 1500 ; delay (in ms) after opening interaction menu.
IntF5MenuDelay       := 800 ; delay (in ms) after opening phone menu.
IntChatDelay         := 1000   ; delay (in ms) between scrolls in the phone menu.
IntInventoryDelay    := 2200   ; delay (in ms) delay between send key commands.
IntKeyPressDuration  := 5    ; duration (in ms) each key press is held down.

#NoEnv
SetWorkingDir A_ScripTtDir

; Iskljucuje Hotkeys ako GTA nije aktivan
;#IfWinActive ahk_class grcWindow

; Hotkey/Function mapping
Hotkey, %PrikaziSveKomandeKey%, PrikaziSveKomande
Hotkey, %PretresOvjeravanjeKey%, PretresOvjeravanje
Hotkey, %PretresLeziKey%, PretresLezi
Hotkey, %PretresPredaoKey%, PretresPredao
Hotkey, %OvjeravanjeKey%, Ovjeravanje
Hotkey, %DizanjePovrijedjenogKey%, DizanjePovrijedjenog
Hotkey, %OduzimanjeKomunikacijeKey%, OduzimanjeKomunikacije
Hotkey, %PronalazakKey%, Pronalazak
Hotkey, %NePronalazakKey%, NePronalazak
Hotkey, %GepekInventoriKey%, GepekInventori
Hotkey, %GepekKey%, Gepek
Hotkey, %PripremaPecanjeKey%, PripremaPecanje
Hotkey, %PecanjeKey%, Pecanje
Hotkey, %KupovinaOpremeKey%, KupovinaOpreme
Hotkey, %AFKKey%, AFK
Hotkey, %RudarenjeKey%, Rudarenje
Hotkey, %SadjenjeKey%, Sadjenje
Hotkey, %DorucakKey%, Dorucak
Hotkey, %QuickRelogKey%, QuickRelog
Hotkey, %ReloadKey%, Reload
Return


; ================
; === Funkcije ===
; ================

PrikaziSveKomande:
	SoundBeep 150 , 150
	SplashTextOn, 435, 375 , SVE KOMANDE, `n ALT+1 ILI NUMPAD 1 = PRETRES I OVJERAVANJE AKO OSOBA LEŽI`n ALT+2 ILI NUMPAD 2 = PRETRES AKO OSOBA LEŽI`n ALT+3 ILI NUMPAD 3 = PRETRES AKO JE DIGAO RUKE`n ALT+4 ILI NUMPAD 4 = OVJERAVA OSOBU`n ALT+5 ILI NUMPAD 5 = DIZANJE POVRIJEDJENE OSOBE S PODA`n ALT+6 ILI NUMPAD 6 = ODUZIMANJE KOMUNIKACIJE`n ALT+7 ILI NUMPAD 7 = AKO SI PRONASAO NESTO`n ALT+8 ILI NUMPAD 8 = AKO NISI PRONASAO NISTA`n ALT+Q = BRZI UNEQUIP ORUZJA`n ALT+I = BRZO OTKLJUCAVANJE I OTVARANJE GEPEKA U AUTU`n ALT+L = BRZO OTKLJUCAVANJE/ZAKLJUCAVANJE GEPEKA`n UP = PALI AUTO-VEŽE POJAS-ZAKLJUCAVA AUTO`n`n F11 = AUTOMATSKO RUDARENJE`n F12 = AFK KRETANJE`n`n`n MADE BY SILV3R BIH (Silvio Suljić)
	Sleep, 5000
	SplashTextOff
Return

PretresOvjeravanje:
SoundBeep 150 , 150
SplashTextOn, 250, , Pretres ako osoba lezi!
WinMove, Pretres ako osoba lezi!,, 0 , 0
	Send {t}
	BlockInput On
 	SendInput, /me nisani osobu u glavu i ovjerava lika.
	Send {Enter}
	BlockInput Off
	Sleep 1000
	Send {t}
	BlockInput On
	SendInput, /do Metak bi bio u glavi.
	Send {Enter}
	BlockInput Off
	Sleep 1000
	Send {t}
	BlockInput On
 	SendInput, /me pocinje detaljno pretresati osobu.
	Send {Enter}
	BlockInput off
	Sleep 500
	Send {m}
	Sleep IntMMenuDelay
	Send {5}
	BlockInput Off
Sleep, 500
SplashTextOff
Return

PretresLezi:
SoundBeep 150 , 150
SplashTextOn, 250, , Pretres ako osoba lezi!
WinMove, Pretres ako osoba lezi!,, 0 , 0
	Send {t}
	BlockInput On
 	SendInput, /me pocinje detaljno pretresati osobu.
	Send {Enter}
	BlockInput off
	Sleep 500
	Send {m}
	Sleep IntMMenuDelay
	Send {5}
	BlockInput Off
Sleep, 500
SplashTextOff
Return

PretresPredao:
SoundBeep 150 , 150
SplashTextOn, 250, , Pretres ako je digao ruke!
WinMove, Pretres ako je digao ruke!,, 0 , 0
BlockInput On
	Send {t}
	BlockInput On
 	SendInput, /me drzeci pistolj jednom rukom uperen u osobu,drugom rukom zapocinje detaljan pretres.
	Send {Enter}
	BlockInput off
	Sleep 1500
	Send {t}
	BlockInput On
	SendInput, /do Da li bi se opirao?
	Send {Enter}
	BlockInput off
	Sleep 500
	Send {m}
	Sleep IntMMenuDelay
	Send {5}
	BlockInput off
Sleep, 500
SplashTextOff
Return

Ovjeravanje:
SoundBeep 150 , 150
SplashTextOn, 250, , Ovjeravaš!
WinMove, Ovjeravaš!,, 0 , 0
	Send {t}
	BlockInput On
 	SendInput, /me nisani osobu u glavu i ovjerava lika.
	Send {Enter}
	BlockInput Off
	Sleep 1500
	Send {t}
	BlockInput On
	SendInput, /do Metak bi bio u glavi.
	Send {Enter}
	BlockInput Off
Sleep, 500
SplashTextOff
Return

DizanjePovrijedjenog:
SoundBeep 150 , 150
SplashTextOn, 250, , Podiže osobu sa poda!
WinMove, Podiže osobu sa poda!,, 0 , 0
	send {t}
	BlockInput On
 	SendInput, /me pomaze povrijedjenoj osobi da se skloni
	Send {Enter}
	BlockInput Off
	Sleep 500
	send {m}
	Sleep IntMMenuDelay
	send {6}
Sleep, 500
SplashTextOff
Return

OduzimanjeKomunikacije:
SoundBeep 150 , 150
SplashTextOn, 250, , Oduzimanje komunikacije!
WinMove, Oduzimanje komunikacije!,, 0 , 0
	Send {t}
	BlockInput On
 	SendInput, /me drzeci pistolj jednom rukom uperen u osobu,drugom rukom oduzima komunikaciju.
	Send {Enter}
	BlockInput Off
Sleep, 500
SplashTextOff
Return

Pronalazak:
SoundBeep 150 , 150
SplashTextOn, 250, , Pronasao si nesto!
WinMove, Pronasao si nesto!,, 0 , 0
	Send {t}
	BlockInput On
 	SendInput, /do Pronasao bih stvari koje bi mi bilo u interesu da uzmem,te ih brzo spremio u stek.
	Send {Enter}
	BlockInput Off
Sleep, 500
SplashTextOff
Return

NePronalazak:
SoundBeep 150 , 150
SplashTextOn, 250, , Nisi nista pronasao!
WinMove, Nisi nista pronasao!,, 0 , 0
	Send {t}
	BlockInput On
 	SendInput, /do Ne bih pronasao nista od interesa.
	Send {Enter}
	BlockInput Off
Sleep, 500
SplashTextOff
Return

GepekInventori:
SoundBeep 150 , 150 
SplashTextOn, 250, , Otkljucavas gepek i otvaras inventori!
WinMove, Otkljucavas gepek i otvaras inventori!,, 0 , 0
	Send {l}
	Sleep IntLMenuDelay
	Send {5}
	Sleep 100
	send {i}
Sleep 500
SplashTextOff 
Return

Gepek:
SoundBeep 150 , 150
SplashTextOn, 250, , Otkljucavas/zakljucavas gepek!
WinMove, Otkljucavas/zakljucavas gepek!,, 0 , 0
	Send {l}
	Sleep IntLMenuDelay
	Send {5}
Sleep 500
SplashTextOff
Return

Unequip:
SoundBeep 150 , 150
SplashTextOn, 250, , Unequipaš oruzje!
WinMove, Unequipaš oruzje!,, 0 , 0
	Send {F5}
	Sleep IntF5MenuDelay
	Send {TAB}
	Send {TAB}
	Send {TAB}
	Send {TAB}
	Send {ENTER}
	Send {TAB}
	Send {TAB}	
	Send {TAB}
	Send {TAB}
	Send {TAB}
	Send {ENTER}
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *60 close.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 5
	Click, %foundX%, %foundY%
}
SplashTextOff
Return

Dorucak:
	sendvic1:
	Send {i}
	Sleep IntInventoryDelay
	ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 sendvic.jpg
		If(ErrorLevel == 0){
		foundX := foundX + 8
		foundY := foundY + 8
		Click, %foundX%, %foundY%
		Sleep 500
		Send {TAB}
		Send {ENTER}
		}else{
		Goto, sendvic1
		}
	voda1:
	Send {i}
	Sleep IntInventoryDelay
	ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 voda.jpg
		If(ErrorLevel == 0){
		foundX := foundX + 8
		foundY := foundY + 8
		Click, %foundX%, %foundY%
		Sleep 500
		Send {TAB}
		Send {ENTER}
		}else{
		Goto, voda1
		}
Return

Sadjenje:
Loop 5
{
Send {e down}
Sleep 1500
Send {e up}
Loop 10
{
Send {i}
Sleep IntInventoryDelay
Click, 300, 240
Sleep 500
Send {tab}
Sleep 100
Send {enter}
Send {w down}
Sleep 1500
Send {w up}
}
}
Return

AFK:
SoundBeep 150 , 150
SplashTextOn, 250, , Skripta za AFK uspijesto pokrenuta!
WinMove, Skripta za AFK uspijesto pokrenuta!,, 0 , 0
Sleep, 1000
SplashTextOff
    SetTimer,SendKey1,% (t_state:=!t_state) ? 500:"Off"
    if(!t_state){
        Send, {w}{a}{s}{d}
    }
Return
SendKey1:
    Send, {w}{a}{s}{d}
Return

KupovinaOpreme:
Loop 5000
{
Click, 1850, 450
Sleep 100
Click, 1040, 530
Sleep 20
Click, 1055, 530
Click, 1055, 530
Click, 1055, 530
Click, 1055, 530
Sleep 20
Click, 1150, 600
Sleep 150
}
Return

Rudarenje:
SoundBeep 150 , 150
SplashTextOn, 250, , Skripta za rudarenje uspijesto pokrenuta!
WinMove, Skripta za rudarenje uspijesto pokrenuta!,, 0 , 0
Sleep, 1000
SplashTextOff

    SetTimer,SendKey,% (t_state:=!t_state) ? 500:"Off"
    if(!t_state){
        Send, {e}{e}{e}{e}
    }
Return
SendKey:
    Send, {e}{e}{e}{e}
Return

PripremaPecanje:
Send {i}
	Sleep IntInventoryDelay
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 stolica.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	}
	Send {TAB 2}
	Send {SPACE}
	Send {TAB 2}
	Send {1}
	Send {TAB}
loop 10
{
	Send {SPACE 2}
	Send {TAB 3}
}
	Send {SPACE}
	Send {TAB 2}
	Send {SPACE}

loop 9
{
	Sleep 500
	Send {i}
	Sleep IntInventoryDelay
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *10 stolica.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	}
	Send {TAB}
	Send {SPACE}
}
Goto Dorucak
Return

QuickRelog:
Process_Suspend("gta5.exe")
Sleep, 8000
Process_Resume("gta5.exe")
Return

Reload:
Reload
Return

; ===========================================================================
; === Pecanje ====== Pecanje ====== Pecanje ====== Pecanje ====== Pecanje ===
; ===========================================================================

Pecanje:
mouseclick = 0
mousemove = 0
upecao = 0
jelo = 0
provjera = 0
krug = 0

loop
{
loop
{

pocetak:
send {e}

pronadjiribu:

ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *80 fish1.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	sleep 600
	Click, %foundX%, %foundY%
	sleep 600
	Click, %foundX%, %foundY%
	krug = 0
	jelo := jelo + 1
	upecao := upecao + 1
	SplashTextOn, 40, , %upecao%
	WinMove, %upecao%,, 0 , 0
}else{
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *80 fish2.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	sleep 600
	Click, %foundX%, %foundY%
	sleep 600
	Click, %foundX%, %foundY%
	krug = 0
	jelo := jelo + 1
	upecao := upecao + 1
	SplashTextOn, 40, , %upecao%
	WinMove, %upecao%,, 0 , 0
}else{
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *80 fish3.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	sleep 600
	Click, %foundX%, %foundY%
	sleep 600
	Click, %foundX%, %foundY%
	krug = 0
	jelo := jelo + 1
	upecao := upecao + 1
	SplashTextOn, 40, , %upecao%
	WinMove, %upecao%,, 0 , 0
}else{
	krug := krug + 1

	if jelo = 500
	{
	jelo := 0
	MouseMove, 0, 0
	Goto, jelo
	}

	if krug = 120
	{
	MouseMove, 0, 0
	Goto, pocetak
	}

	if krug = 180
	{
	MouseMove, 0, 0
	Click, %foundX%, %foundY%
	Goto, pocetak
	}

	if krug = 240
	{
	MouseMove, 0, 0
	Click, %foundX%, %foundY%
	Goto, pocetak
	}

	if krug = 300
	{
	MouseMove, 0, 0
	Goto, pocetak
	}


	if krug = 400
	{
	url:="https://discord.com/api/webhooks/823863912587329536/oWzgMkpR4Cv6QJKSuOCEJWAINgXmd9L4jsLu6gK9544QTLUa9bhD8RqDQJykEZK6Y-Vx" ; use the url from Discord webhook bot
	postdata=
	(
	{
	  "content": "<@461927013452742656> Fish bot prestao sa radom - Zakovalo!"
	}
	)
	WebRequest := ComObjCreate("WinHttp.WinHttpRequest.5.1")
	WebRequest.Open("POST", url, false)
	WebRequest.SetRequestHeader("Content-Type", "application/json")
	WebRequest.Send(postdata)
	Process_Suspend("gta5.exe")
	Sleep, 8000
	Process_Resume("gta5.exe")
	}

	Goto, pronadjiribu
}
}
}
}

jelo:
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *80 fish1.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	sleep 700
	Click, %foundX%, %foundY%
	sleep 700
	Click, %foundX%, %foundY%
	krug = 0
	upecao := upecao + 1
	jelo := jelo + 1
	SplashTextOn, 40, , %upecao%
	WinMove, %upecao%,, 0 , 0 ; Move the alert screen away from the center
}else{
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *80 fish2.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	sleep 700
	Click, %foundX%, %foundY%
	sleep 700
	Click, %foundX%, %foundY%
	krug = 0
	upecao := upecao + 1
	jelo := jelo + 1
	SplashTextOn, 40, , %upecao%
	WinMove, %upecao%,, 0 , 0 ; Move the alert screen away from the center
}else{
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *80 fish3.jpg
If(ErrorLevel == 0){
	foundX := foundX + 5
	foundY := foundY + 18
	Click, %foundX%, %foundY%
	sleep 700
	Click, %foundX%, %foundY%
	sleep 700
	Click, %foundX%, %foundY%
	krug = 0
	upecao := upecao + 1
	jelo := jelo + 1
	SplashTextOn, 40, , %upecao%
	WinMove, %upecao%,, 0 , 0 ; Move the alert screen away from the center
}else{
	Goto, jelo
}
}
}
sendvic:
Send {i}
Sleep 1000
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 sendvic.jpg
	If(ErrorLevel == 0){
	foundX := foundX + 8
	foundY := foundY + 8
	Click, %foundX%, %foundY%
	Sleep 500
	Send {TAB}
	Send {ENTER}
	}else{
	Goto, sendvic
	}

voda:
Send {i}
Sleep 1000
ImageSearch, foundX, foundY, 0, 0, %A_ScreenWidth%, %A_ScreenHeight%, *50 voda.jpg
	If(ErrorLevel == 0){
	foundX := foundX + 8
	foundY := foundY + 8
	Click, %foundX%, %foundY%
	Sleep 500
	Send {TAB}
	Send {ENTER}
	}else{
	Goto, voda
	}
}
Return