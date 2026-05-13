import SwiftUI

/// 主界面。
struct ContentView: View {
  /// 根状态。
  @EnvironmentObject private var store: BuiltinShortcutsStore

  var body: some View {
    NavigationSplitView {
      // 左侧动作区。
      ScrollView {
        VStack(alignment: .leading, spacing: 16) {
          // 标题。
          Text("Builtin Shortcuts")
            .font(.largeTitle.bold())
          // 说明。
          Text("这些快捷键都走 SwiftUI 内置能力：Button 的 keyboardShortcut，加 App 的 commands。")
            .foregroundStyle(.secondary)
          // 清日志按钮。
          Button("Clear Log") {
            store.clear()
          }

          ForEach(BuiltinShortcutAction.allCases) { action in
            VStack(alignment: .leading, spacing: 10) {
              // 动作名。
              Text(action.title)
                .font(.headline)
              // 动作说明。
              Text(action.note)
                .foregroundStyle(.secondary)
              HStack {
                // 演示按钮。
                Button("Trigger \(action.title)") {
                  store.trigger(action, source: "Button / Shortcut")
                }
                .keyboardShortcut(action.key, modifiers: action.modifiers)
                Spacer()
                // 展示当前快捷键。
                Text(action.shortcutLabel)
                  .font(.system(.body, design: .monospaced))
                  .foregroundStyle(.secondary)
              }
            }
            .padding(16)
            .background(Color(nsColor: .windowBackgroundColor))
            .overlay(
              RoundedRectangle(cornerRadius: 14)
                .stroke(Color.secondary.opacity(0.15), lineWidth: 1)
            )
            .clipShape(RoundedRectangle(cornerRadius: 14))
          }
        }
        .padding(20)
      }
      .frame(minWidth: 430)
    } detail: {
      // 右侧结果区。
      ScrollView {
        VStack(alignment: .leading, spacing: 18) {
          // 主提示。
          VStack(alignment: .leading, spacing: 10) {
            Text("Latest Event")
              .font(.headline)
            Text(store.latestMessage)
              .font(.title2.weight(.semibold))
            Text("也可以从菜单栏的 Demo Actions 触发同一组动作。")
              .foregroundStyle(.secondary)
          }
          .padding(18)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color.accentColor.opacity(0.08))
          .clipShape(RoundedRectangle(cornerRadius: 18))

          // 事件日志。
          VStack(alignment: .leading, spacing: 12) {
            Text("Event Log")
              .font(.headline)

            if store.eventLog.isEmpty {
              Text("还没有触发记录。")
                .foregroundStyle(.secondary)
            } else {
              ForEach(store.eventLog) { event in
                HStack(alignment: .top, spacing: 12) {
                  Text(store.timeText(for: event.happenedAt))
                    .font(.caption.monospaced())
                    .foregroundStyle(.secondary)
                  VStack(alignment: .leading, spacing: 4) {
                    Text(event.action.title)
                      .font(.body.weight(.semibold))
                    Text(event.source)
                      .font(.caption.monospaced())
                      .foregroundStyle(.secondary)
                  }
                  Spacer()
                }
                .padding(.vertical, 6)
                Divider()
              }
            }
          }
          .padding(18)
          .frame(maxWidth: .infinity, alignment: .leading)
          .background(Color(nsColor: .windowBackgroundColor))
          .overlay(
            RoundedRectangle(cornerRadius: 18)
              .stroke(Color.secondary.opacity(0.15), lineWidth: 1)
          )
          .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .padding(20)
      }
      .frame(minWidth: 540)
    }
    .navigationSplitViewStyle(.balanced)
    .frame(minWidth: 1100, minHeight: 720)
  }
}
