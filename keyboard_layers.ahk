#Requires AutoHotkey v2.0
#SingleInstance Force
#Warn

SendMode "Event"
SetCapsLockState "AlwaysOff"
A_MaxHotkeysPerInterval := 200   ; holding j/k for key-repeat shouldn't trip the warning

; Window-manager bindings (Alt+...) live in GlazeWM's own config.yaml, see glazewm/config.yaml.

; ---------------------------------------------------------------------------
; Helpers
; ---------------------------------------------------------------------------

TAP_TIMEOUT_MS := 200            ; CapsLock released faster than this (and nothing else pressed) = Esc
LAYER_MODS := ["LCtrl", "LShift", "LAlt", "LWin"]

; Release modifiers the layer pressed, but leave any the user is physically holding.
ReleaseMods(mods*) {
    for key in mods {
        if GetKeyState(key) && !GetKeyState(key, "P")
            Send("{Blind}{" key " up}")
    }
}

Glazewm(cmd) {
    Run(Format('glazewm.exe command {}', cmd), , "Hide")
}

LaunchPowerShell() {
    Run("powershell.exe", EnvGet("USERPROFILE"))
}

LaunchDebian() {
    Run("wsl.exe ~")
}

MoveMouseToCenterOfWindow() {
    try {
        WinGetPos(&X, &Y, &W, &H, "A")
        DllCall("SetCursorPos", "int", X + W // 2, "int", Y + H // 2)
    }
}

; Both this script and GlazeWM install low-level keyboard hooks, and the hook
; installed last sees keys first. Re-install ours whenever GlazeWM (re)starts so
; that layer keys (e.g. CapsLock+s+j = Alt+Left) are handled here and never
; reach GlazeWM's Alt+j binding.
GlazewmPid := 0
KeepHookOnTop() {
    global GlazewmPid
    pid := ProcessExist("glazewm.exe")
    if (pid && pid != GlazewmPid) {
        GlazewmPid := pid
        SetTimer(() => InstallKeybdHook(true, true), -2000)
    } else if (!pid) {
        GlazewmPid := 0
    }
}
SetTimer(KeepHookOnTop, 3000)
KeepHookOnTop()

; ---------------------------------------------------------------------------
; NAV LAYER: hold CapsLock (tap = Esc)
; ---------------------------------------------------------------------------

NavLayer := false
NavLayerDownTick := 0

*CapsLock:: {
    global NavLayer, NavLayerDownTick
    if !NavLayer                 ; ignore key-repeat
        NavLayerDownTick := A_TickCount
    NavLayer := true
}

*CapsLock Up:: {
    global NavLayer := false
    ReleaseMods(LAYER_MODS*)
    if (A_PriorKey = "CapsLock" && A_TickCount - NavLayerDownTick < TAP_TIMEOUT_MS)
        Send("{Blind}{Esc}")
}

#HotIf NavLayer
*i::Send("{Blind}{Up}")
*k::Send("{Blind}{Down}")
*j::Send("{Blind}{Left}")
*l::Send("{Blind}{Right}")

*å::Glazewm("toggle-minimized")
*q::Send("{Blind}{Esc}")

*n::Send("{Blind}{Tab}")
*m::Send("{Blind}{LButton}")
*,::Send("{Blind}{F6}")
*.::MoveMouseToCenterOfWindow()

*a::Send("{Blind}{WheelDown}")
*w::Send("{Blind}{WheelUp}")

*u::Send("{Blind}{Home}")
*o::Send("{Blind}{End}")

*y::Send("{Blind}{PgUp}")
*h::Send("{Blind}{PgDn}")

*e::Send("{Blind}{Browser_Back}")
*r::Send("{Blind}{Browser_Forward}")

*b::Send("{Blind}{AppsKey}")

; One-shot modifiers
*f::Send("{Blind}{LCtrl down}")
*f Up::ReleaseMods("LCtrl")

*d::Send("{Blind}{LShift down}")
*d Up::ReleaseMods("LShift")

*s::Send("{Blind}{LAlt down}")
*s Up::ReleaseMods("LAlt")

*g::Send("{Blind}{LWin down}")
*g Up::ReleaseMods("LWin")

*t::Send("{Blind}{LWin down}{LAlt down}{LCtrl down}")
*t Up::ReleaseMods("LWin", "LAlt", "LCtrl")

; Editing
*z::Send("^z")
^z::Send("^y")                   ; CapsLock+f+z = redo
*x::Send("^x")
*c::Send("^c")
*v::Send("^v")

*ö::Send("{Blind}{Backspace}")
*p::Send("{Blind}{Del}")

*Space::Send("{Blind}{Enter}")
#HotIf

; ---------------------------------------------------------------------------
; SYMBOLS LAYER: hold RAlt (AltGr)
; ---------------------------------------------------------------------------

SymLayer := false

*RAlt::global SymLayer := true

*RAlt Up:: {
    global SymLayer := false
    ; AltGr on a Swedish layout also sends a fake LCtrl; clear it unless Ctrl is really held.
    ReleaseMods(LAYER_MODS*)
}

#HotIf SymLayer
*q::Send("{Blind}{Esc}")

*2::SendText("@")
*3::SendText("£")
*4::SendText("$")
*5::SendText("€")
*6::SendText("x")
*7::SendText("{")
*8::SendText("[")
*9::SendText("]")
*0::SendText("}")
*+::SendText("\")

*w::SendText("[")
*e::SendText("]")
*r::SendText("*")
*t::SendText("%")

*a::SendText("{")
*s::SendText("(")
*d::SendText(")")
*f::SendText("}")
*g::SendText("&")

*z::SendText("-")
*x::SendText("+")
*c::SendText("!")
*v::SendText("=")

*<::SendText("|")

*Space::SendText("_")

*ö::SendText("``")
*k::SendText("/")
*l::SendText("\")
#HotIf

; ---------------------------------------------------------------------------
; App launchers (window management itself is in GlazeWM's config.yaml)
; ---------------------------------------------------------------------------

#HotIf !NavLayer && !SymLayer
!Enter::LaunchDebian()
!+Enter::LaunchPowerShell()
#HotIf
