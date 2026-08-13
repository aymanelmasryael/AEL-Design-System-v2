import SwiftUI
import AppKit
import AELColorKit

// MARK: - SwiftUI Color <-> AELColor

extension Color {
    /// Parses `#RRGGBB` / `#RRGGBBAA` (also without `#`). Falls back to black.
    init(hex: String) {
        let value = AELColor(hex: hex) ?? AELColor(red: 0, green: 0, blue: 0)
        self.init(red: value.red, green: value.green, blue: value.blue, opacity: value.alpha)
    }

    init(ael color: AELColor) {
        self.init(red: color.red, green: color.green, blue: color.blue, opacity: color.alpha)
    }
}

extension AELColor {
    var swiftUIColor: Color { Color(ael: self) }

    init(_ color: Color) {
        let resolved = NSColor(color)
            .usingColorSpace(.sRGB) ?? NSColor(color)
        self.init(
            red: Double(resolved.redComponent),
            green: Double(resolved.greenComponent),
            blue: Double(resolved.blueComponent),
            alpha: Double(resolved.alphaComponent)
        )
    }
}
