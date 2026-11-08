#Requires AutoHotkey v2.0
#Warn

SendMode "Event"

Komorebic(cmd) {
    RunWait(format("komorebic {}", cmd), , "Hide")
}
Glazewm(cmd, cmd2 := "") {
    RunWait(format("glazewm.exe command {}", cmd), , "Hide")
    if (cmd2 != "") {
        RunWait(format("glazewm command {}", cmd2), , "Hide")
    }
}
LaunchPowerShell() {
    Run("powershell.exe", EnvGet("USERPROFILE"))
}
LaunchDebian() {
    Run("wsl.exe ~", )
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

    Hotkey "*å", (*) => Glazewm("minimize")
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

    Hotkey "!Enter", (*) => LaunchDebian()
    Hotkey "!+Enter", (*) => LaunchPowerShell()

    ; Focus windows
    Hotkey "!j", (*) => Glazewm("focus --direction left")
    Hotkey "!k", (*) => Glazewm("focus --direction down")
    Hotkey "!i", (*) => Glazewm("focus --direction up")
    Hotkey "!l", (*) => Glazewm("focus --direction right")

    ; !+[::Komorebic("cycle-focus previous")
    ; !+]::Komorebic("cycle-focus next")

    ; Move windows
    Hotkey "!+j", (*) => Glazewm("move --direction left")
    Hotkey "!+k", (*) => Glazewm("move --direction down")
    Hotkey "!+i", (*) => Glazewm("move --direction up")
    Hotkey "!+l", (*) => Glazewm("move --direction right")

    ; Resize windows
    Hotkey "!+^k", (*) => Glazewm("resize --height -2%")
    Hotkey "!+^i", (*) => Glazewm("resize --height +2%")
    Hotkey "!+^l", (*) => Glazewm("resize --width +2%")
    Hotkey "!+^j", (*) => Glazewm("resize --width -2%")
    ; ; Stack windows
    ; Hotkey "!^j", (*) => Komorebic("stack left")
    ; Hotkey "!^k", (*) => Komorebic("stack down")
    ; Hotkey "!^i", (*) => Komorebic("stack up")
    ; Hotkey "!^l", (*) => Komorebic("stack right")
    ; Hotkey "!p", (*) => Komorebic("unstack")
    ; Hotkey "!^p", (*) => Komorebic("unstack")

    ; Hotkey "!^o", (*) => Komorebic("cycle-stack next")
    ; Hotkey "!^u", (*) => Komorebic("cycle-stack previous")

    ; Hotkey "!u", (*) => Komorebic("cycle-monitor next")
    ; Hotkey "!o", (*) => Komorebic("cycle-monitor previous")

    ; Hotkey "!+^o", (*) => Komorebic("cycle-layout next")
    ; Hotkey "!+^u", (*) => Komorebic("cycle-layout previous")

    ; workspaces
    Hotkey "!o", (*) => Glazewm("focus --next-active-workspace-on-monitor")
    Hotkey "!u", (*) => Glazewm("focus --prev-active-workspace-on-monitor")
    ; Hotkey "!+u", (*) => Komorebic("close-workspace")
    ; Hotkey "!+o", (*) => Komorebic("new-workspace")
    Hotkey "!+1", (*) => Glazewm("move --workspace 1", "focus --workspace 1")
    Hotkey "!+2", (*) => Glazewm("move --workspace 2", "focus --workspace 2")
    Hotkey "!+3", (*) => Glazewm("move --workspace 3", "focus --workspace 3")
    Hotkey "!+4", (*) => Glazewm("move --workspace 4", "focus --workspace 4")
    Hotkey "!+5", (*) => Glazewm("move --workspace 5", "focus --workspace 5")
    Hotkey "!+6", (*) => Glazewm("move --workspace 6", "focus --workspace 6")
    Hotkey "!+7", (*) => Glazewm("move --workspace 7", "focus --workspace 7")
    Hotkey "!+8", (*) => Glazewm("move --workspace 8", "focus --workspace 8")
    Hotkey "!+9", (*) => Glazewm("move --workspace 9", "focus --workspace 9")

    Hotkey "!1", (*) => Glazewm("focus --workspace 1")
    Hotkey "!2", (*) => Glazewm("focus --workspace 2")
    Hotkey "!3", (*) => Glazewm("focus --workspace 3")
    Hotkey "!4", (*) => Glazewm("focus --workspace 4")
    Hotkey "!5", (*) => Glazewm("focus --workspace 5")
    Hotkey "!6", (*) => Glazewm("focus --workspace 6")
    Hotkey "!7", (*) => Glazewm("focus --workspace 7")
    Hotkey "!8", (*) => Glazewm("focus --workspace 8")
    Hotkey "!9", (*) => Glazewm("focus --workspace 9")

    HotKey "!+u", (*) => Glazewm("move-workspace --direction left")
    HotKey "!+o", (*) => Glazewm("move-workspace --direction right")

    ; Resize
    ; Hotkey "!SC00C", (*) => Komorebic("resize-axis horizontal increase")
    ; Hotkey "!-", (*) => Komorebic("resize-axis horizontal decrease")
    ; Hotkey "!+SC00C", (*) => Komorebic("resize-axis vertical increase")
    ; Hotkey "!+_", (*) => Komorebic("resize-axis vertical decrease")

    ; ; Manipulate windows
    Hotkey "!q", (*) => Glazewm("close")
    Hotkey "!m", (*) => Glazewm("toggle-minimized")

    Hotkey "!t", (*) => Glazewm("toggle-tiling")
    Hotkey "!f", (*) => Glazewm("toggle-fullscreen")
    Hotkey "!v", (*) => Glazewm("toggle-tiling-direction")
    Hotkey "!+Space", (*) => Glazewm("toggle-floating")
    Hotkey "!+e", (*) => Glazewm("wm-exit")
    Hotkey "!+r", (*) => Glazewm("wm-reload-config")
    Hotkey "!+w", (*) => Glazewm("wm-redraw")
    Hotkey "!Space", (*) => Glazewm("wm-cycle-focus")


    ; Hotkey "!Space", (*) => Komorebic("promote")

    ; ; Window manager options
    ; Hotkey "!+r", (*) => Komorebic("retile")
    ; Hotkey "!p", (*) => Komorebic("toggle-pause")

    ; ; Layouts
    ; !x::Komorebic("flip-layout horizontal")
    ; !y::Komorebic("flip-layout vertical")
}
