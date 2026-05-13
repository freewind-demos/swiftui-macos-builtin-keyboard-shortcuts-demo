import SwiftUI

/// App 入口。
@main
struct SwiftUIBuiltinKeyboardShortcutsDemoApp: App {
  /// 根状态。
  @StateObject private var store = BuiltinShortcutsStore()

  var body: some Scene {
    // 单窗口演示。
    Window("Builtin Keyboard Shortcuts Demo", id: "main") {
      ContentView()
        .environmentObject(store)
    }
    .defaultSize(width: 1200, height: 780)
    .commands {
      // 单独挂一个 demo 菜单。
      CommandMenu("Demo Actions") {
        ForEach(BuiltinShortcutAction.allCases) { action in
          // 菜单命令与按钮共用同一套动作。
          Button(action.title) {
            store.trigger(action, source: "Menu Command")
          }
          .keyboardShortcut(action.key, modifiers: action.modifiers)
        }
      }
    }
  }
}
