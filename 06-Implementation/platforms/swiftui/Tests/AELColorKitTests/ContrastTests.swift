import XCTest
@testable import AELColorKit

final class ContrastTests: XCTestCase {

    // MARK: - WCAG

    func testWcagBlackOnWhite() {
        let ratio = ContrastEngine.wcagContrast(
            text: .init(hex: "#000000")!,
            background: .init(hex: "#FFFFFF")!
        )
        XCTAssertEqual(ratio, 21.0, accuracy: 0.01)
    }

    func testWcagSameColorIsOne() {
        let ratio = ContrastEngine.wcagContrast(
            text: .init(hex: "#0074FF")!,
            background: .init(hex: "#0074FF")!
        )
        XCTAssertEqual(ratio, 1.0, accuracy: 0.0001)
    }

    func testWcagRedOnWhite() {
        // Relative luminance of pure red = 0.2126 → (1.05)/(0.2626) ≈ 3.998
        let ratio = ContrastEngine.wcagContrast(
            text: .init(hex: "#FF0000")!,
            background: .init(hex: "#FFFFFF")!
        )
        XCTAssertEqual(ratio, 4.0, accuracy: 0.01)
    }

    func testWcagLevels() {
        XCTAssertEqual(ContrastEngine.wcagLevel(ratio: 4.5, largeText: false), .aa)
        XCTAssertEqual(ContrastEngine.wcagLevel(ratio: 4.6, largeText: false), .aa)
        XCTAssertEqual(ContrastEngine.wcagLevel(ratio: 7.0, largeText: false), .aaa)
        XCTAssertNil(ContrastEngine.wcagLevel(ratio: 4.4, largeText: false))
        // Large text AA is 3:1
        XCTAssertEqual(ContrastEngine.wcagLevel(ratio: 3.0, largeText: true), .aa)
        XCTAssertNil(ContrastEngine.wcagLevel(ratio: 2.9, largeText: true))
    }

    // MARK: - APCA

    func testApcaBlackOnWhite() {
        // Canonical: Lc ≈ 106 for pure black on white.
        let lc = ContrastEngine.apcaLc(
            text: .init(hex: "#000000")!,
            background: .init(hex: "#FFFFFF")!
        )
        XCTAssertEqual(lc, 106.0, accuracy: 0.5)
        XCTAssertGreaterThan(lc, 0)
    }

    func testApcaPolarity() {
        // Light text on dark background must be negative.
        // APCA is polarity-asymmetric: white-on-black is ≈ -108 (rev exponents
        // differ from the normal-polarity ones), black-on-white ≈ 106.
        let lc = ContrastEngine.apcaLc(
            text: .init(hex: "#FFFFFF")!,
            background: .init(hex: "#000000")!
        )
        XCTAssertLessThan(lc, 0)
        XCTAssertEqual(lc, -107.9, accuracy: 0.5)
    }

    func testApcaSameColorIsZero() {
        let lc = ContrastEngine.apcaLc(
            text: .init(hex: "#34C759")!,
            background: .init(hex: "#34C759")!
        )
        XCTAssertEqual(lc, 0, accuracy: 0.001)
    }

    func testApcaKnownPairs() {
        // Ground-truth values produced by the canonical `apca-w3` reference
        // implementation (0.1.9, 0.0.98G-4g constants) — verified bit-for-bit.
        let pairs: [(text: String, bg: String, expected: Double)] = [
            ("#767676", "#FFFFFF", 71.57239122246546),
            ("#111111", "#FFFFFF", 105.36353357996198),
            ("#34C759", "#FFFFFF", 43.21193227469141),
            ("#000000", "#FFFFFF", 106.04067321268862)
        ]
        for pair in pairs {
            let lc = ContrastEngine.apcaLc(
                text: .init(hex: pair.text)!,
                background: .init(hex: pair.bg)!
            )
            XCTAssertEqual(lc, pair.expected, accuracy: 0.0001)
        }
    }

    func testApcaLevels() {
        XCTAssertEqual(ContrastEngine.apcaLevel(lc: 106, largeText: false), .gold)
        XCTAssertEqual(ContrastEngine.apcaLevel(lc: 90, largeText: false), .silver)
        XCTAssertEqual(ContrastEngine.apcaLevel(lc: 60, largeText: false), .bronze)
        XCTAssertNil(ContrastEngine.apcaLevel(lc: 59, largeText: false))
        XCTAssertEqual(ContrastEngine.apcaLevel(lc: 45, largeText: true), .bronze)
    }

    func testApcaMonotonic() {
        // Increasing the luminance of the background must never decrease
        // contrast for a fixed dark text.
        let text = AELColor(hex: "#222222")!
        var previous = 0.0
        for step in stride(from: 50, through: 255, by: 5) {
            let bg = AELColor(red8: UInt8(step), green8: UInt8(step), blue8: UInt8(step))
            let lc = ContrastEngine.apcaLc(text: text, background: bg)
            XCTAssertGreaterThanOrEqual(lc, previous)
            previous = lc
        }
    }
}
