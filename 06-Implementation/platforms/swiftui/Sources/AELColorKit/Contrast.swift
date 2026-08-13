import Foundation

/// Contrast measurement engine.
///
/// Implements two models:
///  - **WCAG 2.x**: BT.709 relative luminance + `(L1 + 0.05) / (L2 + 0.05)`.
///  - **APCA** (Advanced Perceptual Contrast Algorithm) — W3 licensed
///    `0.0.98G-4g`, transcribed 1:1 from the canonical `apca-w3` reference.
///    Polarity sensitive: negative Lc means light text on dark background.
public enum ContrastEngine {

    // MARK: - WCAG 2.x

    public static func wcagContrast(text: AELColor, background: AELColor) -> Double {
        let l1 = text.wcagLuminance
        let l2 = background.wcagLuminance
        return wcagContrast(l1: l1, l2: l2)
    }

    public static func wcagContrast(l1: Double, l2: Double) -> Double {
        let lighter = max(l1, l2)
        let darker = min(l1, l2)
        return (lighter + 0.05) / (darker + 0.05)
    }

    public enum WCAGLevel: String, Sendable {
        case aa = "AA"
        case aaa = "AAA"
    }

    /// Returns the highest WCAG 2.1 level satisfied for the given ratio.
    /// `largeText` follows the WCAG definition: 18pt regular or 14pt bold.
    public static func wcagLevel(ratio: Double, largeText: Bool) -> WCAGLevel? {
        let aa = largeText ? 3.0 : 4.5
        let aaa = largeText ? 4.5 : 7.0
        if ratio >= aaa { return .aaa }
        if ratio >= aa { return .aa }
        return nil
    }

    // MARK: - APCA (0.0.98G-4g)

    public enum APCALevel: String, Sendable {
        case bronze = "Bronze"
        case silver = "Silver"
        case gold = "Gold"
    }

    /// Returns the highest APCA (WCAG 3 draft) level for the given |Lc|.
    public static func apcaLevel(lc: Double, largeText: Bool) -> APCALevel? {
        let v = abs(lc)
        let (gold, silver, bronze) = largeText ? (90.0, 75.0, 45.0) : (105.0, 90.0, 60.0)
        if v >= gold { return .gold }
        if v >= silver { return .silver }
        if v >= bronze { return .bronze }
        return nil
    }

    public static func apcaLc(text: AELColor, background: AELColor) -> Double {
        apcaLc(textY: text.apcaLuminance, backgroundY: background.apcaLuminance)
    }

    /// Canonical APCA contrast function.
    ///
    /// Constants (G-4g):
    ///   mainTRC 2.4 · normBG 0.56 · normTXT 0.57 · revTXT 0.62 · revBG 0.65
    ///   scale 1.14 · offset 0.027 · blkThrs 0.022 · blkClmp 1.414
    ///   loClip 0.1 · deltaYmin 0.0005
    public static func apcaLc(textY: Double, backgroundY: Double) -> Double {
        let blkThrs = 0.022
        let blkClmp = 1.414
        let normBG = 0.56
        let normTXT = 0.57
        let revTXT = 0.62
        let revBG = 0.65
        let scaleBoW = 1.14
        let scaleWoB = 1.14
        let loBoWoffset = 0.027
        let loWoBoffset = 0.027
        let loClip = 0.1
        let deltaYmin = 0.0005

        guard textY.isFinite, backgroundY.isFinite else { return 0 }

        func softClamp(_ y: Double) -> Double {
            y > blkThrs ? y : y + pow(blkThrs - y, blkClmp)
        }

        var txtY = softClamp(textY)
        var bgY = softClamp(backgroundY)

        guard abs(bgY - txtY) >= deltaYmin else { return 0 }

        var output: Double
        if bgY > txtY {
            let sapc = (pow(bgY, normBG) - pow(txtY, normTXT)) * scaleBoW
            output = sapc < loClip ? 0 : sapc - loBoWoffset
        } else {
            let sapc = (pow(bgY, revBG) - pow(txtY, revTXT)) * scaleWoB
            output = sapc > -loClip ? 0 : sapc + loWoBoffset
        }
        return output * 100.0
    }
}
