; ============================================================
; 逆战未来 - 夜影之逝 鼠标宏
; 操作序列：鼠标左键 → 鼠标右键 → Q切刀 → Q切回
; ============================================================
; 使用说明：
;   1. 安装 AutoHotkey v1.1+ (https://www.autohotkey.com/)
;   2. 右键本文件 → 以管理员身份运行（游戏需要管理员权限）
;   3. 进入游戏后，按【触发键】执行一次夜影之逝连招
;   4. 按 F8 暂停/恢复脚本，按 F9 退出脚本
; ============================================================

#SingleInstance Force
#Persistent
#NoEnv
SendMode Input
SetWorkingDir %A_ScriptDir%

; ============================================================
; 配置区（可根据自己手感调整）
; ============================================================

; 触发键：默认鼠标侧键1（XButton1），可改为 F1/F2/` 等
TriggerKey := "XButton1"

; 各步骤延迟（毫秒），根据游戏响应和网络延迟微调
Delay_AfterLeftClick  := 60    ; 左键后延迟
Delay_AfterRightClick := 60    ; 右键后延迟
Delay_AfterQSwap      := 120   ; 切刀后延迟（等待切刀动画）
Delay_AfterQBack      := 120   ; 切回后延迟

; 是否循环执行（按住触发键时循环）
LoopWhileHold := false

; ============================================================
; 脚本主体
; ============================================================

global ScriptPaused := false

; 状态栏提示
Menu, Tray, Tip, 逆战未来 - 夜影之逝宏`n按%TriggerKey%执行连招`nF8暂停 / F9退出

; 触发键绑定
Hotkey, %TriggerKey%, ExecuteCombo

; F8 暂停/恢复
F8::
    ScriptPaused := !ScriptPaused
    if (ScriptPaused) {
        ToolTip, 脚本已暂停
    } else {
        ToolTip, 脚本已恢复
    }
    SetTimer, ToolTip, -1500
return

; F9 退出
F9::ExitApp

; ============================================================
; 连招执行函数
; ============================================================
ExecuteCombo:
    if (ScriptPaused)
        return

    if (LoopWhileHold) {
        ; 循环模式：按住时反复执行
        while (GetKeyState(TriggerKey, "P")) {
            RunCombo()
        }
    } else {
        ; 单次模式：按一次执行一次
        RunCombo()
    }
return

RunCombo() {
    global Delay_AfterLeftClick, Delay_AfterRightClick
    global Delay_AfterQSwap, Delay_AfterQBack

    ; 第一步：鼠标左键点击
    Click, Left
    Sleep, % Delay_AfterLeftClick

    ; 第二步：鼠标右键点击
    Click, Right
    Sleep, % Delay_AfterRightClick

    ; 第三步：Q 切刀
    Send, q
    Sleep, % Delay_AfterQSwap

    ; 第四步：Q 切回主武器
    Send, q
    Sleep, % Delay_AfterQBack
}

; ============================================================
; 注意事项：
;   - 本脚本仅供学习交流使用，请遵守游戏用户协议
;   - 使用前建议在训练场测试延迟参数
;   - 若游戏中无效，请确认以管理员身份运行
;   - 部分游戏反作弊可能检测模拟输入，使用风险自负
; ============================================================
