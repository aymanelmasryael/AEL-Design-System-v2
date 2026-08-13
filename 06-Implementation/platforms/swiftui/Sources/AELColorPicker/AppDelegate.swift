import AppKit
import SwiftUI
import Combine
import AELColorKit

/// Borderless, always-on-top window that hosts the magnifier while picking.
/// Subclassed so it can become key (needed for the local Escape handler).
private final class OverlayWindow: NSWindow {
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { false }
}

final class AppDelegate: NSObject, NSApplicationDelegate {

    let appState = AppState()

    private var menuBar: MenuBarController?
    private var hotKey: HotKeyManager?
    private var overlayWindow: OverlayWindow?
    private var overlayHosting: NSHostingController<MagnifierPanel>?
    private var cursorSubscription: AnyCancellable?
    private weak var mainWindow: NSWindow?

    // MARK: - Lifecycle

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSApp.setActivationPolicy(.regular)

        appState.requestPick = { [weak self] in self?.beginPicking() }
        appState.onPickingEnded = { [weak self] in self?.endPicking() }

        appState.captureEngine.onPick = { [weak self] color in
            self?.appState.commit(color)
        }
        appState.captureEngine.onCancel = { [weak self] in
            self?.endPicking()
        }

        menuBar = MenuBarController(
            appState: appState,
            onPick: { [weak self] in self?.beginPicking() },
            onShowWindow: { [weak self] in self?.showMainWindow() }
        )

        hotKey = HotKeyManager()
        hotKey?.register { [weak self] in
            guard let self else { return }
            self.appState.isPicking ? self.endPicking() : self.beginPicking()
        }

        showMainWindow()
    }

    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        false
    }

    // MARK: - Picking flow

    func beginPicking() {
        guard !appState.isPicking else { return }

        if !appState.captureEngine.hasScreenRecordingPermission() {
            if !appState.captureEngine.requestScreenRecordingPermission() {
                presentPermissionAlert()
                return
            }
        }

        appState.isPicking = true
        mainWindow = NSApp.mainWindow ?? NSApp.keyWindow ?? NSApp.windows.first
        mainWindow?.orderOut(nil)

        appState.captureEngine.startMonitoring()
        presentOverlay()

        cursorSubscription = appState.captureEngine.$cursorScreenPoint
            .receive(on: DispatchQueue.main)
            .sink { [weak self] point in
                self?.positionOverlay(at: point)
            }
    }

    func endPicking() {
        cursorSubscription?.cancel()
        cursorSubscription = nil
        appState.captureEngine.stopMonitoring()
        overlayWindow?.orderOut(nil)
        overlayWindow = nil
        overlayHosting = nil
        appState.isPicking = false
        restoreMainWindow()
    }

    func restoreMainWindow() {
        NSApp.activate(ignoringOtherApps: true)
        showMainWindow()
    }

    func showMainWindow() {
        NSApp.activate(ignoringOtherApps: true)
        if let mainWindow {
            mainWindow.makeKeyAndOrderFront(nil)
        } else if let first = NSApp.windows.first(where: { !($0 is NSPanel) }) {
            first.makeKeyAndOrderFront(nil)
        }
    }

    // MARK: - Overlay

    private func presentOverlay() {
        let hosting = NSHostingController(rootView: MagnifierPanel(appState: appState))
        let window = OverlayWindow(contentViewController: hosting)
        window.styleMask = [.borderless]
        window.level = .screenSaver
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary, .stationary]
        window.isOpaque = false
        window.backgroundColor = .clear
        window.hasShadow = true
        window.isReleasedWhenClosed = false

        overlayHosting = hosting
        overlayWindow = window
        positionOverlay(at: NSEvent.mouseLocation)
        window.orderFrontRegardless()
        window.makeKey()
    }

    private func positionOverlay(at screenPoint: NSPoint) {
        guard let window = overlayWindow else { return }
        guard let screen = NSScreen.screens.first(where: {
            NSMouseInRect(screenPoint, $0.visibleFrame, false)
        }) else { return }

        let visible = screen.visibleFrame
        let offset: CGFloat = 20
        var origin = NSPoint(x: screenPoint.x + offset, y: screenPoint.y + offset)
        let size = window.frame.size

        if origin.x + size.width > visible.maxX { origin.x = screenPoint.x - size.width - offset }
        if origin.y + size.height > visible.maxY { origin.y = screenPoint.y - size.height - offset }

        origin.x = max(visible.minX, min(origin.x, visible.maxX - size.width))
        origin.y = max(visible.minY, min(origin.y, visible.maxY - size.height))
        window.setFrameOrigin(origin)
    }

    // MARK: - Permissions

    private func presentPermissionAlert() {
        let alert = NSAlert()
        alert.messageText = "Screen Recording Permission Required"
        alert.informativeText = "AEL Color Picker needs Screen Recording access to read the pixel color under your cursor.\n\nEnable it in System Settings → Privacy & Security → Screen Recording, then press ⌘⇧P again."
        alert.alertStyle = .warning
        alert.addButton(withTitle: "Open Settings")
        alert.addButton(withTitle: "Cancel")
        if alert.runModal() == .alertFirstButtonReturn,
           let url = URL(string: "x-apple.systempreferences:com.apple.preference.security?Privacy_ScreenRecording") {
            NSWorkspace.shared.open(url)
        }
    }
}
