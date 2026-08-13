import XCTest
@testable import AELColorKit

final class ColorConversionsTests: XCTestCase {

    func testHexParsing() {
        XCTAssertEqual(AELColor(hex: "#FF0000"), AELColor(red8: 255, green8: 0, blue8: 0))
        XCTAssertEqual(AELColor(hex: "ff0000"), AELColor(red8: 255, green8: 0, blue8: 0))
        XCTAssertEqual(AELColor(hex: "#F00"), AELColor(red8: 255, green8: 0, blue8: 0))
        XCTAssertEqual(AELColor(hex: "#00FF00FF"), AELColor(red8: 0, green8: 255, blue8: 0, alpha8: 255))
        let alphaColor = AELColor(hex: "#FF000080")
        XCTAssertNotNil(alphaColor)
        XCTAssertEqual(alphaColor!.alpha, 128.0 / 255.0, accuracy: 0.001)
        XCTAssertNil(AELColor(hex: "#GG0000"))
        XCTAssertNil(AELColor(hex: "#12345"))
        XCTAssertNil(AELColor(hex: ""))
    }

    func testHexStringRoundTrip() {
        let colors: [String] = ["#000000", "#FFFFFF", "#FF0000", "#00FF00", "#0000FF", "#0074FF", "#AEAEB2"]
        for hex in colors {
            XCTAssertEqual(AELColor(hex: hex)?.hexString, hex)
        }
    }

    func testHexStringUppercases() {
        XCTAssertEqual(AELColor(hex: "#abc123")?.hexString, "#ABC123")
    }

    func testHSLKnownValues() {
        // red
        var hsl = AELColor(hex: "#FF0000")!.hsla
        XCTAssertEqual(hsl.h, 0, accuracy: 0.001)
        XCTAssertEqual(hsl.s, 1.0, accuracy: 0.001)
        XCTAssertEqual(hsl.l, 0.5, accuracy: 0.001)

        // gray (mid)
        let gray = AELColor(red8: 128, green8: 128, blue8: 128)
        hsl = gray.hsla
        XCTAssertEqual(hsl.h, 0, accuracy: 0.001)
        XCTAssertEqual(hsl.s, 0, accuracy: 0.001)
        XCTAssertEqual(hsl.l, 128.0 / 255.0, accuracy: 0.001)

        // cyan
        hsl = AELColor(hex: "#00FFFF")!.hsla
        XCTAssertEqual(hsl.h, 180, accuracy: 0.001)
    }

    func testHSVKnownValues() {
        let hsv = AELColor(hex: "#00FF00")!.hsva
        XCTAssertEqual(hsv.h, 120, accuracy: 0.001)
        XCTAssertEqual(hsv.s, 1.0, accuracy: 0.001)
        XCTAssertEqual(hsv.v, 1.0, accuracy: 0.001)
    }

    func testCMYKKnownValues() {
        let cmyk = AELColor(hex: "#FF0000")!.cmyka
        XCTAssertEqual(cmyk.c, 0, accuracy: 0.001)
        XCTAssertEqual(cmyk.m, 1.0, accuracy: 0.001)
        XCTAssertEqual(cmyk.y, 1.0, accuracy: 0.001)
        XCTAssertEqual(cmyk.k, 0, accuracy: 0.001)
    }

    func testOKLabPublishedReferenceValues() {
        // Reference values from Björn Ottosson's published test table.
        let red = AELColor(hex: "#FF0000")!.okLab
        XCTAssertEqual(red.L, 0.62795536, accuracy: 0.0001)
        XCTAssertEqual(red.a, 0.22486310, accuracy: 0.0001)
        XCTAssertEqual(red.b, 0.12584626, accuracy: 0.0001)

        let green = AELColor(hex: "#00FF00")!.okLab
        XCTAssertEqual(green.L, 0.86643961, accuracy: 0.0001)
        XCTAssertEqual(green.a, -0.23388757, accuracy: 0.0001)
        XCTAssertEqual(green.b, 0.17949830, accuracy: 0.0001)

        let blue = AELColor(hex: "#0000FF")!.okLab
        XCTAssertEqual(blue.L, 0.45201372, accuracy: 0.0001)
        XCTAssertEqual(blue.a, -0.03245696, accuracy: 0.0001)
        XCTAssertEqual(blue.b, -0.31152814, accuracy: 0.0001)
    }

    func testOKLChPolar() {
        let lch = AELColor(hex: "#FF0000")!.okLCh
        XCTAssertEqual(lch.L, 0.62795536, accuracy: 0.0001)
        XCTAssertEqual(lch.C, 0.25768330, accuracy: 0.0001)
        XCTAssertEqual(lch.h, 29.23388519, accuracy: 0.0005)
        XCTAssertGreaterThanOrEqual(lch.h, 0)
        XCTAssertLessThan(lch.h, 360)
    }

    func testCIELABKnownValue() {
        // Pure red in CIELAB: L* ≈ 53.24, a* ≈ 80.09, b* ≈ 67.20
        let lab = AELColor(hex: "#FF0000")!.cielab
        XCTAssertEqual(lab.L, 53.24, accuracy: 0.1)
        XCTAssertEqual(lab.a, 80.09, accuracy: 0.1)
        XCTAssertEqual(lab.b, 67.20, accuracy: 0.1)
    }

    func testWcagLuminanceKnownValues() {
        XCTAssertEqual(AELColor(hex: "#FFFFFF")!.wcagLuminance, 1.0, accuracy: 0.0001)
        XCTAssertEqual(AELColor(hex: "#000000")!.wcagLuminance, 0.0, accuracy: 0.0001)
        XCTAssertEqual(AELColor(hex: "#FF0000")!.wcagLuminance, 0.2126, accuracy: 0.0001)
    }

    func testLinearTransferRoundTrip() {
        let original = 0.7
        let roundTrip = AELColor.linearToSRGB(AELColor.srgbToLinear(original))
        XCTAssertEqual(roundTrip, original, accuracy: 0.0001)
    }

    func testExportFormats() {
        let color = AELColor(hex: "#FF0000")!
        XCTAssertEqual(AELExportFormat.hex.string(for: color), "#FF0000")
        XCTAssertEqual(AELExportFormat.rgb.string(for: color), "rgb(255, 0, 0)")
        XCTAssertEqual(AELExportFormat.hsl.string(for: color), "hsl(0, 100%, 50%)")
        XCTAssertEqual(AELExportFormat.aelSwift.string(for: color), "Color(hex: \"#FF0000\")")
        XCTAssertTrue(AELExportFormat.oklch.string(for: color).hasPrefix("oklch("))
    }

    func testNearestAELToken() {
        XCTAssertEqual(AELColor(hex: "#0074FF")!.nearestAELTokenName(), "brandPrimary")
        XCTAssertEqual(AELColor(hex: "#FF3B30")!.nearestAELTokenName(), "error")
        XCTAssertEqual(AELColor(hex: "#FFFFFF")!.nearestAELTokenName(), "white")
    }

    func testCodable() {
        let color = AELColor(hex: "#34C759")!
        let data = try! JSONEncoder().encode(color)
        let decoded = try! JSONDecoder().decode(AELColor.self, from: data)
        XCTAssertEqual(decoded, color)
    }
}
