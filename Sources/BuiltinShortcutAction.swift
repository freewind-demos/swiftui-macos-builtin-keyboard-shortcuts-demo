import SwiftUI

/// 内置快捷键动作。
enum BuiltinShortcutAction: String, CaseIterable, Identifiable {
  /// 新建。
  case compose
  /// 保存。
  case saveDraft
  /// 复制。
  case duplicateSelection
  /// 上移。
  case moveUp
  /// 下移。
  case moveDown
  /// 打开帮助。
  case showHelp

  /// `ForEach` 用 id。
  var id: String { rawValue }

  /// 展示标题。
  var title: String {
    switch self {
    case .compose:
      return "Compose"
    case .saveDraft:
      return "Save Draft"
    case .duplicateSelection:
      return "Duplicate Selection"
    case .moveUp:
      return "Move Up"
    case .moveDown:
      return "Move Down"
    case .showHelp:
      return "Show Help"
    }
  }

  /// 动作说明。
  var note: String {
    switch self {
    case .compose:
      return "典型的 app 级新建动作。"
    case .saveDraft:
      return "典型的文档保存动作。"
    case .duplicateSelection:
      return "典型的编辑菜单动作。"
    case .moveUp:
      return "带方向键的窗口内动作。"
    case .moveDown:
      return "带方向键的窗口内动作。"
    case .showHelp:
      return "演示带 Shift 的帮助动作。"
    }
  }

  /// 主键。
  var key: KeyEquivalent {
    switch self {
    case .compose:
      return "n"
    case .saveDraft:
      return "s"
    case .duplicateSelection:
      return "d"
    case .moveUp:
      return .upArrow
    case .moveDown:
      return .downArrow
    case .showHelp:
      return "/"
    }
  }

  /// 修饰键。
  var modifiers: EventModifiers {
    switch self {
    case .compose:
      return [.command]
    case .saveDraft:
      return [.command]
    case .duplicateSelection:
      return [.command]
    case .moveUp:
      return [.command, .option]
    case .moveDown:
      return [.command, .option]
    case .showHelp:
      return [.command, .shift]
    }
  }

  /// 展示文案。
  var shortcutLabel: String {
    switch self {
    case .compose:
      return "⌘N"
    case .saveDraft:
      return "⌘S"
    case .duplicateSelection:
      return "⌘D"
    case .moveUp:
      return "⌘⌥↑"
    case .moveDown:
      return "⌘⌥↓"
    case .showHelp:
      return "⌘⇧/"
    }
  }
}
