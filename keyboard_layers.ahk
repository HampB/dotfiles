#Requires AutoHotkey v2.0
#Warn

SendMode "Event"

Komorebic(cmd) {
    RunWait(format("komorebic {}", cmd), , "Hide")
}

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

    Hotkey "*å", (*) => Komorebic("minimize")
    Hotkey "*q", (*) => Send("{Blind}{Esc}")

    Hotkey "*n", (*) => Send("{Blind}{Tab}")
    Hotkey "*m", (*) => Send("{Blind}{LButton}")
    Hotkey "*,", (*) => Send("{Blind}{F6}")
    Hotkey "*.", (*) => MoveMouseToCenterOfScreen()

    Hotkey "*a", (*) => Send("{Blind}{WheelDown}")
    Hotkey "*w", (*) => Send("{Blind}{WheelUp}")

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

    Hotkey "*ö", (*) => SendText("``")
    Hotkey "*k", (*) => SendText("/")
    Hotkey "*l", (*) => SendText("\")
}

HotIf (*) => !IsKeyboardNavigationLayer && !IsKeyboardSymbolsLayer
{
    Hotkey "!q", (*) => Komorebic("close")
    Hotkey "!m", (*) => Komorebic("minimize")

    ; Focus windows
    Hotkey "!j", (*) => Komorebic("focus left")
    Hotkey "!k", (*) => Komorebic("focus down")
    Hotkey "!i", (*) => Komorebic("focus up")
    Hotkey "!l", (*) => Komorebic("focus right")

    ; !+[::Komorebic("cycle-focus previous")
    ; !+]::Komorebic("cycle-focus next")

    ; ; Move windows
    Hotkey "!+j", (*) => Komorebic("move left")
    Hotkey "!+k", (*) => Komorebic("move down")
    Hotkey "!+i", (*) => Komorebic("move up")
    Hotkey "!+l", (*) => Komorebic("move right")

    ; Stack windows
    Hotkey "!^j", (*) => Komorebic("stack left")
    Hotkey "!^k", (*) => Komorebic("stack down")
    Hotkey "!^i", (*) => Komorebic("stack up")
    Hotkey "!^l", (*) => Komorebic("stack right")
    Hotkey "!p", (*) => Komorebic("unstack")
    Hotkey "!^p", (*) => Komorebic("unstack")

    Hotkey "!^o", (*) => Komorebic("cycle-stack next")
    Hotkey "!^u", (*) => Komorebic("cycle-stack previous")

    ; Hotkey "!u", (*) => Komorebic("cycle-monitor next")
    ; Hotkey "!o", (*) => Komorebic("cycle-monitor previous")

    Hotkey "!+^o", (*) => Komorebic("cycle-layout next")
    Hotkey "!+^u", (*) => Komorebic("cycle-layout previous")

    ; workspaces
    Hotkey "!o", (*) => Komorebic("cycle-workspace next")
    Hotkey "!u", (*) => Komorebic("cycle-workspace previous")
    Hotkey "!+u", (*) => Komorebic("close-workspace")
    Hotkey "!+o", (*) => Komorebic("new-workspace")
    Hotkey "!+1", (*) => Komorebic("move-to-workspace 0")
    Hotkey "!+2", (*) => Komorebic("move-to-workspace 1")
    Hotkey "!+3", (*) => Komorebic("move-to-workspace 2")
    Hotkey "!+4", (*) => Komorebic("move-to-workspace 3")
    Hotkey "!+5", (*) => Komorebic("move-to-workspace 4")
    Hotkey "!+6", (*) => Komorebic("move-to-workspace 5")



    ; Resize
    Hotkey "!SC00C", (*) => Komorebic("resize-axis horizontal increase")
    Hotkey "!-", (*) => Komorebic("resize-axis horizontal decrease")
    Hotkey "!+SC00C", (*) => Komorebic("resize-axis vertical increase")
    Hotkey "!+_", (*) => Komorebic("resize-axis vertical decrease")

    ; ; Manipulate windows
    Hotkey "!t", (*) => Komorebic("toggle-float")
    Hotkey "!f", (*) => Komorebic("toggle-monocle")
    Hotkey "!Space", (*) => Komorebic("promote")

    ; ; Window manager options
    Hotkey "!+r", (*) => Komorebic("retile")
    ; Hotkey "!p", (*) => Komorebic("toggle-pause")

    ; ; Layouts
    ; !x::Komorebic("flip-layout horizontal")
    ; !y::Komorebic("flip-layout vertical")
}