import AppKit
import Combine
import AELColorKit

/// Menu bar status item. The status icon is a live swatch of the current
/// color. Left click picks a color; right click opens the app menu.
final class MenuBarController: NSObject {

    private let statusItem: NSStatusItem
    private let appState: AppState
    private let onPick: () -> Void
    private let onShowWindow: () -> Void
    private var cancellables = Set<AnyCancellable>()

    init(appState: AppState, onPick: @escaping () -> Void, onShowWindow: @escaping () -> Void) {
        self.appState = appState
        self.onPick = onPick
        self.onShowWindow = onShowWindow
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        super.init()

        if let button = statusItem.button {
            button.image = Self.statusImage(color: appState.currentColor)
            button.imagePosition = .imageOnly
            button.target = self
            button.action = #selector(buttonClicked)
            button.sendAction(on: [.leftMouseUp, .rightMouseUp])
        }

        appState.$currentColor
            .dropFirst()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] color in
                self?.statusItem.button?.image = Self.statusImage(color: color)
            }
            .store(in: &cancellables)
    }

    @objc private func buttonClicked(_ sender: Any?) {
        if let event = NSApp.currentEvent, event.type == .rightMouseUp {
            let menu = buildMenu()
            if let button = statusItem.button {
                NSMenu.popUpContextMenu(menu, with: event, for: button)
            }
        } else {
            onPick()
        }
    }

    // MARK: - Menu

    private func buildMenu() -> NSMenu {
        let menu = NSMenu()

        let pick = NSMenuItem(title: "Pick Color from Screen", action: #selector(pickAction), keyEquivalent: "P")
        pick.keyEquivalentModifierMask = [.command, .shift]
        pick.target = self
        menu.addItem(pick)

        let show = NSMenuItem(title: "Show Main Window", action: #selector(showAction), keyEquivalent: "0")
        show.target = self
        menu.addItem(show)

        menu.addItem(.separator())

        let recentHeader = NSMenuItem(title: "Recent Colors", action: nil, keyEquivalent: "")
        recentHeader.isEnabled = false
        menu.addItem(recentHeader)

        if appState.history.isEmpty {
            let none = NSMenuItem(title: "None yet", action: nil, keyEquivalent: "")
            none.isEnabled = false
            menu.addItem(none)
        } else {
            for entry in appState.history.prefix(8) {
                let item = NSMenuItem(
                    title: "\(entry.color.hexString)  ·  \(entry.color.nearestAELTokenName() ?? "—")",
                    action: #selector(copyRecentColor(_:)),
                    keyEquivalent: ""
                )
                item.target = self
                item.representedObject = entry.color
                item.image = Self.swatchImage(color: entry.color)
                menu.addItem(item)
            }
        }

        menu.addItem(.separator())

        let quit = NSMenuItem(title: "Quit AEL Color Picker", action: #selector(quitAction), keyEquivalent: "q")
        quit.target = self
        menu.addItem(quit)

        return menu
    }

    @objc private func pickAction() { onPick() }
    @objc private func showAction() { onShowWindow() }

    @objc private func copyRecentColor(_ sender: NSMenuItem) {
        guard let color = sender.representedObject as? AELColor else { return }
        appState.currentColor = color
        appState.copy(color.hexString, color: color)
    }

    @objc private func quitAction() { NSApp.terminate(nil) }

    // MARK: - Images

    static func statusImage(color: AELColor) -> NSImage {
        let size = NSSize(width: 20, height: 20)
        let image = NSImage(size: size)
        image.lockFocus()

        let inset: CGFloat = 4
        let rect = NSRect(x: inset, y: inset, width: size.width - inset * 2, height: size.height - inset * 2)

        NSColor(srgbRed: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1).setFill()
        NSBezierPath(ovalIn: rect).fill()

        NSColor(white: 0.55, alpha: 0.75).setStroke()
        let border = NSBezierPath(ovalIn: rect.insetBy(dx: 0.5, dy: 0.5))
        border.lineWidth = 1
        border.stroke()

        image.unlockFocus()
        image.isTemplate = false
        return image
    }

    static func swatchImage(color: AELColor) -> NSImage {
        let size = NSSize(width: 16, height: 16)
        let image = NSImage(size: size)
        image.lockFocus()
        let rect = NSRect(x: 1, y: 1, width: 14, height: 14)
        NSColor(srgbRed: CGFloat(color.red), green: CGFloat(color.green), blue: CGFloat(color.blue), alpha: 1).setFill()
        NSBezierPath(roundedRect: rect, xRadius: 3, yRadius: 3).fill()
        NSColor(white: 0.5, alpha: 0.5).setStroke()
        NSBezierPath(roundedRect: rect.insetBy(dx: 0.5, dy: 0.5), xRadius: 3, yRadius: 3).stroke()
        image.unlockFocus()
        image.isTemplate = false
        return image
    }
}
