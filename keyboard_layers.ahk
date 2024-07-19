#Requires AutoHotkey v2.0
#Warn

SendMode "Event"


; NAV LAYER
IsKeyboardNavigationLayer := false

*CapsLock:: global IsKeyboardNavigationLayer := true
*CapsLock Up::
{
    global IsKeyboardNavigationLayer := false
    Send("{AltUp}")
    Send("{LWinUp}")
    Send("{ShiftUp}")
    Send("{CtrlUp}")
}

MoveMouseToCenterOfScreen(){
    WinGetPos &X, &Y, &W, &H, "A"
    DllCall("SetCursorPos", "int", X + (W / 2), "int", Y + (H / 2))
}

HotIf (*) => IsKeyboardNavigationLayer
{
    ;MsgBox("HotIf")
    Hotkey "*i", (*) => Send("{Blind}{Up}")
    Hotkey "*k", (*) => Send("{Blind}{Down}")
    Hotkey "*j", (*) => Send("{Blind}{Left}")
    Hotkey "*l", (*) => Send("{Blind}{Right}")

    Hotkey "*å", (*) => Send("{Blind}{Esc}")
    Hotkey "*q", (*) => Send("{Blind}{Esc}")

    Hotkey "*n", (*) => Send("{Blind}{Tab}")
    Hotkey "*m", (*) => Send("{Blind}{LButton}")
    Hotkey "*,", (*) => Send("{Blind}{F6}")
    Hotkey "*.", (*) => MoveMouseToCenterOfScreen()
    
    Hotkey "*w", (*) => Send("{Blind}{WheelUp}")
    Hotkey "*a", (*) => Send("{Blind}{WheelDown}")

    Hotkey "*u", (*) => Send("{Blind}{Home}")
    Hotkey "*o", (*) => Send("{Blind}{End}")

    Hotkey "*y", (*) => Send("{Blind}{PgUp}")
    Hotkey "*h", (*) => Send("{Blind}{PgDn}")

    Hotkey "*e", (*) => Send("{Blind}{Browser_Back}")
    Hotkey "*r", (*) => Send("{Blind}{Browser_Forward}")

    Hotkey "*b", (*) => Send("{Blind}{AppsKey}")

    Hotkey "*f", (*) => Send("{Blind}{CtrlDown}")
    Hotkey "*f Up", (*) => Send("{Blind}{CtrlUp}")

    Hotkey "*d", (*) => Send("{Blind}{ShiftDown}")
    Hotkey "*d Up", (*) => Send("{Blind}{ShiftUp}")

    Hotkey "*s", (*) => Send("{Blind}{AltDown}")
    Hotkey "*s Up", (*) => Send("{Blind}{AltUp}")

    Hotkey "*z", (*) => Send("{CtrlDown}{z}{CtrlUp}")
    Hotkey "^z", (*) => Send("{CtrlDown}{y}{CtrlUp}")
    Hotkey "*x", (*) => Send("{CtrlDown}{x}{CtrlUp}")
    Hotkey "*c", (*) => Send("{CtrlDown}{c}{CtrlUp}")
    Hotkey "*v", (*) => Send("{CtrlDown}{v}{CtrlUp}")

    Hotkey "*ö", (*) => Send("{Blind}{Backspace}")
    Hotkey "*p", (*) => Send("{Blind}{Del}")

    Hotkey "*Space", (*) => Send("{Blind}{Enter}")

    Hotkey "*t", (*) => Send("{Blind}{LWinDown}{AltDown}{CtrlDown}")
    Hotkey "*t Up", (*) => Send("{Blind}{LWinUp}{AltUp}{CtrlUp}")

    Hotkey "*g", (*) => Send("{Blind}{LWinDown}")
    Hotkey "*g Up", (*) => Send("{Blind}{LWinUp}")

}

; SYMBOLS LAYER
IsKeyboardSymbolsLayer := false

*RAlt:: global IsKeyboardSymbolsLayer := true
*RAlt Up::
{
    global IsKeyboardSymbolsLayer := false
    Send("{AltUp}")
    Send("{LWinUp}")
    Send("{ShiftUp}")
    Send("{CtrlUp}")
}

HotIf (*) => IsKeyboardSymbolsLayer
{
    Hotkey "*q", (*) => Send("{Blind}{Esc}")

    Hotkey "*2", (*) => SendText("@")
    Hotkey "*3", (*) => SendText("£")
    Hotkey "*4", (*) => SendText("$")
    Hotkey "*5", (*) => SendText("€")
    Hotkey "*6", (*) => SendText("x")
    Hotkey "*7", (*) => SendText("{")
    Hotkey "*8", (*) => SendText("[")
    Hotkey "*9", (*) => SendText("]")
    Hotkey "*0", (*) => SendText("}")
    Hotkey "*+", (*) => SendText("\")

    Hotkey "*w", (*) => SendText("[")
    Hotkey "*e", (*) => SendText("]")
    Hotkey "*r", (*) => SendText("*")
    Hotkey "*t", (*) => SendText("%")

    Hotkey "*a", (*) => SendText("{")
    Hotkey "*s", (*) => SendText("(")
    Hotkey "*d", (*) => SendText(")")
    Hotkey "*f", (*) => SendText("}")
    Hotkey "*g", (*) => SendText("&")

    Hotkey "*z", (*) => SendText("-")
    Hotkey "*x", (*) => SendText("+")
    Hotkey "*c", (*) => SendText("!")
    Hotkey "*v", (*) => SendText("=")

    Hotkey "*<", (*) => SendText("|")

    Hotkey "*Space", (*) => SendText("_")

}
