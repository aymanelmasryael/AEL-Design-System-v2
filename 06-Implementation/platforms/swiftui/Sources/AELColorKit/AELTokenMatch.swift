import Foundation

// Nearest AEL token matching.
//
// The palette below mirrors the AEL semantic color tokens whose canonical
// values live in `06-Implementation/tokens/semantic-colors.json` (SSOT).
// Matching happens in OKLab, which is approximately perceptually uniform, so
// the "closest" match correlates with what a designer perceives.
extension AELColor {

    public static func nearestTokenName(for color: AELColor) -> String? {
        guard let nearest = nearestToken(for: color) else { return nil }
        return nearest.name
    }

    public static func nearestToken(for color: AELColor) -> (name: String, color: AELColor)? {
        let target = color.okLab
        var best: (name: String, color: AELColor)? = nil
        var bestDistance = Double.greatestFiniteMagnitude

        for token in Self.aelSemanticTokens {
            let candidate = token.color.okLab
            let dl = candidate.L - target.L
            let da = candidate.a - target.a
            let db = candidate.b - target.b
            let distance = dl * dl + da * da + db * db
            if distance < bestDistance {
                bestDistance = distance
                best = (token.name, token.color)
            }
        }
        return best
    }

    private static let aelSemanticTokens: [(name: String, color: AELColor)] = [
        ("white", AELColor(hex: "#FFFFFF")!),
        ("surface", AELColor(hex: "#F9F9F9")!),
        ("backgroundSecondary", AELColor(hex: "#F2F2F7")!),
        ("border", AELColor(hex: "#E5E5EA")!),
        ("gray300", AELColor(hex: "#D1D1D6")!),
        ("gray400", AELColor(hex: "#C7C7CC")!),
        ("textDisabled", AELColor(hex: "#AEAEB2")!),
        ("gray600", AELColor(hex: "#8E8E93")!),
        ("textSecondary", AELColor(hex: "#636366")!),
        ("gray800", AELColor(hex: "#48484A")!),
        ("textPrimary", AELColor(hex: "#1C1C1E")!),
        ("black", AELColor(hex: "#000000")!),
        ("brandPrimary", AELColor(hex: "#0074FF")!),
        ("primaryHover", AELColor(hex: "#0056CC")!),
        ("primaryActive", AELColor(hex: "#004099")!),
        ("secondary", AELColor(hex: "#5856D6")!),
        ("info", AELColor(hex: "#32ADE6")!),
        ("success", AELColor(hex: "#34C759")!),
        ("warning", AELColor(hex: "#FF9500")!),
        ("error", AELColor(hex: "#FF3B30")!)
    ]
}
