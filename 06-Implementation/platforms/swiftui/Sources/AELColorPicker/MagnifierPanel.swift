import SwiftUI
import AELColorKit

/// Content of the floating picker overlay: magnified pixels, live color readout,
/// and the action hint. This view follows the cursor while a pick is in flight.
struct MagnifierPanel: View {
    @ObservedObject var appState: AppState

    private let zoom: CGFloat = 8

    var body: some View {
        VStack(spacing: AELTokens.Spacing.sm) {
            MagnifierView(
                image: appState.captureEngine.capturedRegion,
                precision: appState.precisionMode,
                zoom: zoom
            )
            .frame(width: 120, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: AELTokens.Radius.md, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AELTokens.Radius.md, style: .continuous)
                    .stroke(AELTokens.Color.border, lineWidth: 1)
            )

            VStack(spacing: 2) {
                Text(appState.currentColor.hexString)
                    .font(.system(.title3, design: .monospaced).weight(.semibold))
                    .foregroundStyle(AELTokens.Color.textPrimary)

                Text(appState.currentColor.nearestAELTokenName() ?? "—")
                    .font(.caption)
                    .foregroundStyle(AELTokens.Color.textSecondary)

                Text("Click to copy · Esc to cancel")
                    .font(.system(size: 10))
                    .foregroundStyle(AELTokens.Color.textDisabled)
            }
        }
        .padding(AELTokens.Spacing.sm)
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: AELTokens.Radius.lg, style: .continuous))
        .shadow(color: .black.opacity(0.35), radius: 12, y: 4)
    }
}
