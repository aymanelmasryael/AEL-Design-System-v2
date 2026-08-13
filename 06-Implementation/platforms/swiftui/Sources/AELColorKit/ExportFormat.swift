import Foundation

/// Deterministic numeric formatting that never depends on the system locale
/// (decimal separators must not vary between machines for exported code).
public enum AELNumber {
    public static func string(_ value: Double, places: Int, trimZeros: Bool = false) -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.numberStyle = .decimal
        formatter.usesGroupingSeparator = false
        formatter.maximumFractionDigits = places
        formatter.minimumFractionDigits = trimZeros ? 0 : places
        return formatter.string(from: NSNumber(value: value)) ?? String(value)
    }

    public static func int(_ value: Double) -> String {
        String(Int(value.rounded()))
    }
}

/// Export formats supported by the picker. Each maps an `AELColor` to a
/// concrete, copy-paste-ready string.
public enum AELExportFormat: String, CaseIterable, Identifiable, Sendable {
    case hex
    case hexAlpha
    case rgb
    case hsl
    case hsv
    case cmyk
    case oklch
    case lab
    case cssRGBA
    case swiftUIColor
    case nsColorDisplayP3
    case aelSwift

    public var id: String { rawValue }

    public var displayName: String {
        switch self {
        case .hex: return "HEX"
        case .hexAlpha: return "HEX (Alpha)"
        case .rgb: return "RGB"
        case .hsl: return "HSL"
        case .hsv: return "HSV"
        case .cmyk: return "CMYK"
        case .oklch: return "OKLCH"
        case .lab: return "CIELAB"
        case .cssRGBA: return "CSS"
        case .swiftUIColor: return "SwiftUI"
        case .nsColorDisplayP3: return "NSColor (P3)"
        case .aelSwift: return "AEL Swift"
        }
    }

    public func string(for color: AELColor) -> String {
        switch self {
        case .hex:
            return color.hexString
        case .hexAlpha:
            return color.hexStringWithAlpha
        case .rgb:
            return "rgb(\(color.r8), \(color.g8), \(color.b8))"
        case .hsl:
            let h = color.hsla
            return "hsl(\(AELNumber.int(h.h)), \(AELNumber.int(h.s * 100))%, \(AELNumber.int(h.l * 100))%)"
        case .hsv:
            let h = color.hsva
            return "hsv(\(AELNumber.int(h.h)), \(AELNumber.int(h.s * 100))%, \(AELNumber.int(h.v * 100))%)"
        case .cmyk:
            let c = color.cmyka
            return "cmyk(\(AELNumber.int(c.c * 100))%, \(AELNumber.int(c.m * 100))%, \(AELNumber.int(c.y * 100))%, \(AELNumber.int(c.k * 100))%)"
        case .oklch:
            let v = color.okLCh
            return "oklch(\(AELNumber.string(v.L, places: 3)) \(AELNumber.string(v.C, places: 3)) \(AELNumber.string(v.h, places: 3)))"
        case .lab:
            let v = color.cielab
            return "lab(\(AELNumber.string(v.L, places: 2)) \(AELNumber.string(v.a, places: 2)) \(AELNumber.string(v.b, places: 2)))"
        case .cssRGBA:
            return "rgba(\(color.r8), \(color.g8), \(color.b8), \(AELNumber.string(color.alpha, places: 2, trimZeros: true)))"
        case .swiftUIColor:
            return "Color(red: \(AELNumber.string(color.red, places: 3, trimZeros: true)), green: \(AELNumber.string(color.green, places: 3, trimZeros: true)), blue: \(AELNumber.string(color.blue, places: 3, trimZeros: true)))"
        case .nsColorDisplayP3:
            return "NSColor(displayP3Red: \(AELNumber.string(color.red, places: 3, trimZeros: true)), green: \(AELNumber.string(color.green, places: 3, trimZeros: true)), blue: \(AELNumber.string(color.blue, places: 3, trimZeros: true)), alpha: \(AELNumber.string(color.alpha, places: 3, trimZeros: true)))"
        case .aelSwift:
            return "Color(hex: \"\(color.hexString)\")"
        }
    }
}
