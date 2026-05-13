import Foundation

/// 单条日志。
struct BuiltinShortcutEvent: Identifiable {
  /// 唯一 id。
  let id = UUID()
  /// 动作。
  let action: BuiltinShortcutAction
  /// 来源。
  let source: String
  /// 时间。
  let happenedAt: Date
}

/// 页面状态。
@MainActor
final class BuiltinShortcutsStore: ObservableObject {
  /// 最新提示。
  @Published var latestMessage = "当前 app 在前台时，按内置快捷键即可触发。"
  /// 日志。
  @Published var eventLog: [BuiltinShortcutEvent] = []

  /// 统一触发动作。
  func trigger(_ action: BuiltinShortcutAction, source: String) {
    // 更新主提示。
    latestMessage = "刚才激活了 \(action.title)。"
    // 头插日志。
    eventLog.insert(
      .init(action: action, source: source, happenedAt: Date()),
      at: 0
    )
    // 只保留最近 20 条。
    eventLog = Array(eventLog.prefix(20))
  }

  /// 清空日志。
  func clear() {
    // 清空日志。
    eventLog = []
    // 顺带给反馈。
    latestMessage = "日志已清空。"
  }

  /// 时间格式。
  func timeText(for date: Date) -> String {
    // 用短时间。
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .medium
    return formatter.string(from: date)
  }
}
