import Foundation
import AELColorKit

struct HistoryEntry: Identifiable, Codable, Equatable {
    let id: UUID
    var color: AELColor
    let date: Date

    init(color: AELColor, date: Date = Date()) {
        self.id = UUID()
        self.color = color
        self.date = date
    }
}

/// JSON persistence for the picker history.
/// Location: `~/Library/Application Support/AELColorPicker/history.json`
final class HistoryStore {
    static let maxEntries = 48

    private let fileURL: URL
    private let encoder: JSONEncoder
    private let decoder: JSONDecoder

    init() {
        let base = FileManager.default
            .urls(for: .applicationSupportDirectory, in: .userDomainMask)
            .first!
            .appendingPathComponent("AELColorPicker", isDirectory: true)
        try? FileManager.default.createDirectory(at: base, withIntermediateDirectories: true)
        self.fileURL = base.appendingPathComponent("history.json")

        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        self.encoder = encoder

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        self.decoder = decoder
    }

    func load() -> [HistoryEntry] {
        guard let data = try? Data(contentsOf: fileURL) else { return [] }
        return (try? decoder.decode([HistoryEntry].self, from: data)) ?? []
    }

    func save(_ entries: [HistoryEntry]) {
        guard let data = try? encoder.encode(Array(entries.prefix(Self.maxEntries))) else { return }
        try? data.write(to: fileURL, options: .atomic)
    }

    func clear() {
        try? FileManager.default.removeItem(at: fileURL)
    }
}
