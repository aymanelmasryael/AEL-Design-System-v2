import Foundation

/// Core color value object for the AEL Color System.
///
/// Stores color in sRGB (0...1, Double precision) as the canonical internal
/// representation. All derived color spaces are computed on demand and cached
/// only by the caller. This is the Single Source of Truth for a color value
/// across the whole application; see `06-Implementation/tokens/` for the
/// design-system token pipeline this type is designed to interoperate with.
public struct AELColor: Equatable, Hashable, Codable, Sendable {

    public var red: Double
    public var green: Double
    public var blue: Double
    public var alpha: Double

    public init(red: Double, green: Double, blue: Double, alpha: Double = 1.0) {
        self.red = Self.clamp01(red)
        self.green = Self.clamp01(green)
        self.blue = Self.clamp01(blue)
        self.alpha = Self.clamp01(alpha)
    }

    public init(red8: UInt8, green8: UInt8, blue8: UInt8, alpha8: UInt8 = 255) {
        self.init(
            red: Double(red8) / 255.0,
            green: Double(green8) / 255.0,
            blue: Double(blue8) / 255.0,
            alpha: Double(alpha8) / 255.0
        )
    }

    /// Creates a color from a 24-bit RGB integer (e.g. `0xFF0000`).
    public init(rgb: UInt32) {
        self.init(
            red8: UInt8((rgb >> 16) & 0xFF),
            green8: UInt8((rgb >> 8) & 0xFF),
            blue8: UInt8(rgb & 0xFF)
        )
    }

    /// Creates a color from a hex string.
    ///
    /// Accepts `#RGB`, `#RGBA`, `#RRGGBB`, `#RRGGBBAA` and the same forms
    /// without a leading `#`. Returns `nil` on malformed input.
    public init?(hex: String) {
        var cleaned = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        if cleaned.hasPrefix("#") { cleaned.removeFirst() }
        guard !cleaned.isEmpty else { return nil }

        let nibbles = cleaned.map { Self.nibble($0) }
        guard nibbles.allSatisfy({ $0 != nil }) else { return nil }

        func value(_ i: Int) -> UInt8 {
            if cleaned.count <= 4 {
                let v = nibbles[i]!
                return UInt8(v * 16 + v)
            }
            return UInt8(nibbles[i * 2]! * 16 + nibbles[i * 2 + 1]!)
        }

        let count = cleaned.count
        switch count {
        case 3, 6:
            self.init(red8: value(0), green8: value(1), blue8: value(2), alpha8: 255)
        case 4, 8:
            self.init(red8: value(0), green8: value(1), blue8: value(2), alpha8: value(3))
        default:
            return nil
        }
    }

    private static func nibble(_ c: Character) -> UInt8? {
        guard let ascii = c.asciiValue else { return nil }
        switch ascii {
        case 0x30...0x39: return ascii - 0x30          // 0-9
        case 0x41...0x46: return ascii - 0x41 + 10     // A-F
        case 0x61...0x66: return ascii - 0x61 + 10     // a-f
        default: return nil
        }
    }

    private static func clamp01(_ v: Double) -> Double {
        min(max(v, 0.0), 1.0)
    }

    // MARK: - 8-bit representation

    public var r8: UInt8 { UInt8((red * 255.0).rounded()) }
    public var g8: UInt8 { UInt8((green * 255.0).rounded()) }
    public var b8: UInt8 { UInt8((blue * 255.0).rounded()) }
    public var a8: UInt8 { UInt8((alpha * 255.0).rounded()) }

    // MARK: - Hex

    public var hexString: String {
        String(format: "#%02X%02X%02X", r8, g8, b8)
    }

    public var hexStringWithAlpha: String {
        String(format: "#%02X%02X%02X%02X", r8, g8, b8, a8)
    }

    /// The name a designer would give this color (nearest AEL semantic token).
    /// Returns `nil` when no token is a close match.
    public func nearestAELTokenName() -> String? {
        AELColor.nearestTokenName(for: self)
    }

    // MARK: - Tuples (computed on demand)

    public var linearComponents: (r: Double, g: Double, b: Double) {
        (Self.srgbToLinear(red), Self.srgbToLinear(green), Self.srgbToLinear(blue))
    }

    public var xyzD65: (x: Double, y: Double, z: Double) {
        Self.linearToXYZ(linearComponents)
    }

    public var hsla: (h: Double, s: Double, l: Double, a: Double) {
        Self.rgbToHSL(red: red, green: green, blue: blue, alpha: alpha)
    }

    public var hsva: (h: Double, s: Double, v: Double, a: Double) {
        Self.rgbToHSV(red: red, green: green, blue: blue, alpha: alpha)
    }

    public var cmyka: (c: Double, m: Double, y: Double, k: Double, a: Double) {
        Self.rgbToCMYK(red: red, green: green, blue: blue, alpha: alpha)
    }

    public var okLab: (L: Double, a: Double, b: Double) {
        Self.srgbToOKLab(red: red, green: green, blue: blue)
    }

    public var okLCh: (L: Double, C: Double, h: Double) {
        let lab = okLab
        let chroma = sqrt(lab.a * lab.a + lab.b * lab.b)
        let hue = atan2(lab.b, lab.a) * 180.0 / .pi
        return (lab.L, chroma, hue < 0 ? hue + 360.0 : hue)
    }

    public var cielab: (L: Double, a: Double, b: Double) {
        Self.xyzToCIELAB(xyzD65)
    }

    /// WCAG 2.x relative luminance (sRGB EOTF, BT.709 coefficients).
    public var wcagLuminance: Double {
        let l = linearComponents
        return 0.2126 * l.r + 0.7152 * l.g + 0.0722 * l.b
    }

    /// APCA "Y" — perceptual luminance using the simple ^2.4 monitor exponent
    /// with sRGB coefficients (APCA-W3 0.0.98G-4g).
    public var apcaLuminance: Double {
        let r = pow(red, 2.4)
        let g = pow(green, 2.4)
        let b = pow(blue, 2.4)
        return 0.2126729 * r + 0.7151522 * g + 0.0721750 * b
    }

    // MARK: - Transfer functions

    public static func srgbToLinear(_ c: Double) -> Double {
        c <= 0.04045 ? c / 12.92 : pow((c + 0.055) / 1.055, 2.4)
    }

    public static func linearToSRGB(_ c: Double) -> Double {
        c <= 0.0031308 ? c * 12.92 : 1.055 * pow(c, 1.0 / 2.4) - 0.055
    }

    // MARK: - Matrix transformations

    public static func linearToXYZ(_ rgb: (r: Double, g: Double, b: Double))
        -> (x: Double, y: Double, z: Double) {
        (
            x: 0.4124564 * rgb.r + 0.3575761 * rgb.g + 0.1804375 * rgb.b,
            y: 0.2126729 * rgb.r + 0.7151522 * rgb.g + 0.0721750 * rgb.b,
            z: 0.0193339 * rgb.r + 0.1191920 * rgb.g + 0.9503041 * rgb.b
        )
    }
}
