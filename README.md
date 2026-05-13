# SwiftUI macOS Builtin Keyboard Shortcuts Demo

## 简介

这个 Demo 演示 SwiftUI / AppKit 内置快捷键能力：`Button.keyboardShortcut(...)` 和 `commands` 菜单命令。

它只在当前 app 获得焦点时生效，不做全局注册，也不手动拦截底层 `NSEvent`。

## 快速开始

### 环境要求

- macOS 14 及以上
- Xcode 15 及以上
- XcodeGen：`brew install xcodegen`

### 运行

```bash
cd /Volumes/SN550-2T/freewind-demos/swiftui-macos-builtin-keyboard-shortcuts-demo

xcodegen generate

export DEVELOPER_DIR=/System/Volumes/Data/Applications/Xcode.app/Contents/Developer
xcodebuild \
  -project SwiftUIBuiltinKeyboardShortcutsDemo.xcodeproj \
  -scheme SwiftUIBuiltinKeyboardShortcutsDemo \
  -configuration Debug \
  -derivedDataPath .build/DerivedData \
  build

open SwiftUIBuiltinKeyboardShortcutsDemo.xcodeproj
```

也可以直接：

```bash
./dev.sh
```

## 注意事项

- 必须 app 在前台，快捷键才触发。
- 这种做法最适合菜单命令、窗口内按钮、标准 app 动作。
- 不适合“系统任意位置都能按”的全局 hotkey。

## 教程

### 1. 关键概念

1. `keyboardShortcut`
   给 `Button` 或命令绑定系统内置快捷键。
2. `commands`
   把动作挂到 macOS 菜单栏，系统自动显示快捷键。
3. `ObservableObject store`
   所有动作最终统一落到一套日志与状态更新。

### 2. demo 原理

1. 预定义几组固定快捷键。
2. `ContentView` 里每个按钮绑定 `.keyboardShortcut(...)`。
3. `App` 入口额外挂一组 `CommandMenu`。
4. 无论点击按钮还是按快捷键，都统一只显示“刚才激活了什么动作”。

### 3. 关键代码

`Sources/BuiltinShortcutAction.swift`

- 定义动作名、快捷键、修饰键。

`Sources/ContentView.swift`

- 左侧是可点击按钮。
- 每个按钮都带系统内置快捷键。

`Sources/SwiftUIBuiltinKeyboardShortcutsDemoApp.swift`

- 通过 `.commands` 把同一组动作挂到菜单栏。

## 操作

1. 打开 app。
2. 直接按 `⌘N`、`⌘S`、`⌘D`、`⌘⌥↑`、`⌘⌥↓`、`⌘⇧/`。
3. 或从菜单栏 `Demo Actions` 触发同一组命令。
4. 右侧查看统一结果与事件日志。
