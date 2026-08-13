import SwiftUI
import Combine
import AELColorKit

/// Application state shared across the SwiftUI UI, the menu bar, and the
/// floating picker overlay.
final class AppState: ObservableObject {

    @Published var currentColor: AELColor = AELColor(hex: "#0074FF")!
    @Published var contrastTextColor: AELColor = AELColor(hex: "#1C1C1E")!
    @Published var contrastBackgroundColor: AELColor = AELColor(hex: "#FFFFFF")!
    @Published var history: [HistoryEntry] = []
    @Published var precisionMode = false
    @Published var isPicking = false
    @Published var lastCopiedFormat: AELExportFormat?
    @Published var lastCopiedColor: AELColor?

    let captureEngine = ScreenCaptureEngine()
    private let historyStore = HistoryStore()
    private var cancellables = Set<AnyCancellable>()

    /// Set by the AppDelegate to drive the picker flow from the UI.
    var requestPick: (() -> Void)?
    /// Invoked when a picking session finishes; AppDelegate restores the window.
    var onPickingEnded: (() -> Void)?

    init() {
        history = historyStore.load()
        captureEngine.onMouseMoved = { [weak self] color in
            self?.currentColor = color
        }
    }

    // MARK: - Picking lifecycle

    func beginPicking() {
        requestPick?()
    }

    func commit(_ color: AELColor) {
        guard !history.contains(where: { $0.color == color }) else {
            finishPicking()
            return
        }
        let entry = HistoryEntry(color: color, date: Date())
        history.insert(entry, at: 0)
        history = Array(history.prefix(HistoryStore.maxEntries))
        historyStore.save(history)
        finishPicking()
    }

    func cancelPicking() {
        captureEngine.stopMonitoring()
        isPicking = false
        onPickingEnded?()
    }

    private func finishPicking() {
        captureEngine.stopMonitoring()
        isPicking = false
        onPickingEnded?()
    }

    func clearHistory() {
        history = []
        historyStore.clear()
    }

    func removeFromHistory(_ entry: HistoryEntry) {
        history.removeAll { $0.id == entry.id }
        historyStore.save(history)
    }

    // MARK: - Clipboard

    func copy(_ text: String, color: AELColor? = nil) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)
        if let color { lastCopiedColor = color }
    }

    func copyCurrent(_ format: AELExportFormat) {
        copy(format.string(for: currentColor), color: currentColor)
        lastCopiedFormat = format
    }
}
