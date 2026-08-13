import SwiftUI
import AELColorKit

struct ColorPanelView: View {
    @EnvironmentObject var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: AELTokens.Spacing.lg) {
                header
                swatchSection
                formatsSection
                contrastSection
                historySection
            }
            .padding(AELTokens.Spacing.lg)
        }
        .background(AELTokens.Color.background)
        .frame(minWidth: 400, minHeight: 600)
    }

    // MARK: - Header

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("AEL Color Picker")
                    .font(.headline)
                    .foregroundStyle(AELTokens.Color.textPrimary)
                Text("AEL Design System · macOS")
                    .font(.caption)
                    .foregroundStyle(AELTokens.Color.textSecondary)
            }
            Spacer()
            precisionToggle
        }
    }

    private var precisionToggle: some View {
        Toggle(isOn: $appState.precisionMode) {
            Text("Precision")
                .font(.caption)
                .foregroundStyle(AELTokens.Color.textSecondary)
        }
        .toggleStyle(.switch)
        .controlSize(.mini)
        .help("Pixel-grid magnifier vs. smooth interpolation")
    }

    // MARK: - Swatch

    private var swatchSection: some View {
        VStack(alignment: .leading, spacing: AELTokens.Spacing.md) {
            ZStack {
                RoundedRectangle(cornerRadius: AELTokens.Radius.xl, style: .continuous)
                    .fill(appState.currentColor.swiftUIColor)
                    .overlay(
                        RoundedRectangle(cornerRadius: AELTokens.Radius.xl, style: .continuous)
                            .stroke(AELTokens.Color.border, lineWidth: 1)
                    )
                VStack(spacing: AELTokens.Spacing.xs) {
                    Text(appState.currentColor.hexString)
                        .font(.system(.largeTitle, design: .monospaced).weight(.bold))
                        .foregroundStyle(adaptiveText)
                        .shadow(color: .black.opacity(0.3), radius: 3, y: 1)
                    if let token = appState.currentColor.nearestAELTokenName() {
                        Text("Closest AEL token: \(token)")
                            .font(.caption.weight(.medium))
                            .foregroundStyle(adaptiveText.opacity(0.9))
                    }
                }
                .padding()
            }
            .frame(height: 160)

            HStack(spacing: AELTokens.Spacing.md) {
                Button(action: { appState.beginPicking() }) {
                    Label("Pick from Screen", systemImage: "eyedropper")
                        .frame(maxWidth: .infinity)
                }
                .keyboardShortcut("p", modifiers: [.command, .shift])
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .tint(AELTokens.Color.primary)

                Button(action: {
                    appState.copyCurrent(.hex)
                }) {
                    Label("Copy HEX", systemImage: "doc.on.doc")
                        .frame(maxWidth: .infinity)
                }
                .controlSize(.large)
            }
        }
    }

    private var adaptiveText: Color {
        ContrastEngine.wcagContrast(text: .init(hex: "#FFFFFF")!, background: appState.currentColor) >= 4.5
            ? .white
            : AELTokens.Color.textPrimary
    }

    // MARK: - Formats

    private var formatsSection: some View {
        VStack(alignment: .leading, spacing: AELTokens.Spacing.sm) {
            SectionLabel("Color Values")

            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: AELTokens.Spacing.sm) {
                ForEach(AELExportFormat.allCases) { format in
                    FormatRow(format: format)
                }
            }
        }
    }

    // MARK: - Contrast

    private var contrastSection: some View {
        VStack(alignment: .leading, spacing: AELTokens.Spacing.sm) {
            SectionLabel("Contrast")

            HStack(spacing: AELTokens.Spacing.md) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Text").font(.caption).foregroundStyle(AELTokens.Color.textSecondary)
                    ColorPicker("", selection: contrastTextBinding, supportsOpacity: false)
                        .labelsHidden()
                }
                Spacer()
                VStack(alignment: .leading, spacing: 2) {
                    Text("Background").font(.caption).foregroundStyle(AELTokens.Color.textSecondary)
                    ColorPicker("", selection: contrastBackgroundBinding, supportsOpacity: false)
                        .labelsHidden()
                }
            }

            contrastResult
        }
    }

    private var contrastResult: some View {
        VStack(spacing: AELTokens.Spacing.xs) {
            let wcag = ContrastEngine.wcagContrast(
                text: appState.contrastTextColor,
                background: appState.contrastBackgroundColor
            )
            let apca = ContrastEngine.apcaLc(
                text: appState.contrastTextColor,
                background: appState.contrastBackgroundColor
            )

            HStack {
                Text("WCAG 2.x")
                    .font(.caption)
                    .foregroundStyle(AELTokens.Color.textSecondary)
                Spacer()
                Text(String(format: "%.2f : 1", wcag))
                    .font(.system(.body, design: .monospaced).weight(.semibold))
                    .foregroundStyle(AELTokens.Color.textPrimary)
                if let level = ContrastEngine.wcagLevel(ratio: wcag, largeText: false) {
                    LevelBadge(text: level.rawValue, tint: level == .aaa ? AELTokens.Color.success : AELTokens.Color.info)
                }
            }
            .padding(AELTokens.Spacing.sm)
            .background(AELTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: AELTokens.Radius.md))

            HStack {
                Text("APCA")
                    .font(.caption)
                    .foregroundStyle(AELTokens.Color.textSecondary)
                Spacer()
                Text("Lc \(AELNumber.string(apca, places: 1))")
                    .font(.system(.body, design: .monospaced).weight(.semibold))
                    .foregroundStyle(AELTokens.Color.textPrimary)
                if let level = ContrastEngine.apcaLevel(lc: apca, largeText: false) {
                    LevelBadge(text: level.rawValue, tint: AELTokens.Color.brandPrimary)
                }
            }
            .padding(AELTokens.Spacing.sm)
            .background(AELTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: AELTokens.Radius.md))

            Text("Sample")
                .font(.body.weight(.medium))
                .foregroundStyle(appState.contrastTextColor.swiftUIColor)
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.vertical, AELTokens.Spacing.md)
                .background(appState.contrastBackgroundColor.swiftUIColor)
                .clipShape(RoundedRectangle(cornerRadius: AELTokens.Radius.md))
                .overlay(
                    RoundedRectangle(cornerRadius: AELTokens.Radius.md)
                        .stroke(AELTokens.Color.border, lineWidth: 1)
                )
        }
    }

    private var contrastTextBinding: Binding<Color> {
        Binding(
            get: { appState.contrastTextColor.swiftUIColor },
            set: { appState.contrastTextColor = AELColor($0) }
        )
    }

    private var contrastBackgroundBinding: Binding<Color> {
        Binding(
            get: { appState.contrastBackgroundColor.swiftUIColor },
            set: { appState.contrastBackgroundColor = AELColor($0) }
        )
    }

    // MARK: - History

    private var historySection: some View {
        VStack(alignment: .leading, spacing: AELTokens.Spacing.sm) {
            HStack {
                SectionLabel("History")
                Spacer()
                if !appState.history.isEmpty {
                    Button("Clear") { appState.clearHistory() }
                        .buttonStyle(.plain)
                        .font(.caption)
                        .foregroundStyle(AELTokens.Color.error)
                }
            }

            if appState.history.isEmpty {
                Text("Colors you pick will appear here.")
                    .font(.caption)
                    .foregroundStyle(AELTokens.Color.textDisabled)
                    .padding(.vertical, AELTokens.Spacing.xs)
            } else {
                LazyVGrid(
                    columns: [GridItem(.adaptive(minimum: 44), spacing: AELTokens.Spacing.sm)],
                    spacing: AELTokens.Spacing.sm
                ) {
                    ForEach(appState.history) { entry in
                        Button {
                            appState.copy(entry.color.hexString, color: entry.color)
                            appState.currentColor = entry.color
                        } label: {
                            RoundedRectangle(cornerRadius: AELTokens.Radius.sm, style: .continuous)
                                .fill(entry.color.swiftUIColor)
                                .frame(height: 36)
                                .overlay(
                                    RoundedRectangle(cornerRadius: AELTokens.Radius.sm, style: .continuous)
                                        .stroke(AELTokens.Color.border, lineWidth: 1)
                                )
                                .contextMenu {
                                    Button("Copy HEX") { appState.copy(entry.color.hexString, color: entry.color) }
                                    Button("Remove") { appState.removeFromHistory(entry) }
                                }
                        }
                        .buttonStyle(.plain)
                        .help(entry.color.hexString)
                    }
                }
            }
        }
    }
}

// MARK: - Components

private struct SectionLabel: View {
    private let text: String

    init(_ text: String) {
        self.text = text
    }

    var body: some View {
        Text(text.uppercased())
            .font(.caption2.weight(.semibold))
            .kerning(0.8)
            .foregroundStyle(AELTokens.Color.textSecondary)
    }
}

private struct FormatRow: View {
    @EnvironmentObject var appState: AppState
    let format: AELExportFormat

    @State private var justCopied = false

    var body: some View {
        Button {
            appState.copyCurrent(format)
            withAnimation(.easeOut(duration: 0.15)) { justCopied = true }
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.2) {
                withAnimation(.easeIn(duration: 0.15)) { justCopied = false }
            }
        } label: {
            HStack {
                Text(format.displayName)
                    .font(.caption)
                    .foregroundStyle(AELTokens.Color.textSecondary)
                    .frame(width: 86, alignment: .leading)
                Spacer(minLength: 4)
                Text(value)
                    .font(.system(.caption, design: .monospaced))
                    .foregroundStyle(AELTokens.Color.textPrimary)
                    .lineLimit(1)
                    .truncationMode(.middle)
                Image(systemName: justCopied ? "checkmark" : "doc.on.doc")
                    .font(.caption2)
                    .foregroundStyle(justCopied ? AELTokens.Color.success : AELTokens.Color.textDisabled)
                    .frame(width: 14)
            }
            .padding(.horizontal, AELTokens.Spacing.sm)
            .padding(.vertical, 10)
            .background(AELTokens.Color.surface)
            .clipShape(RoundedRectangle(cornerRadius: AELTokens.Radius.md))
            .overlay(
                RoundedRectangle(cornerRadius: AELTokens.Radius.md)
                    .stroke(AELTokens.Color.border, lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
        .help("Copy \(format.displayName) to clipboard")
    }

    private var value: String {
        format.string(for: appState.currentColor)
    }
}

private struct LevelBadge: View {
    let text: String
    let tint: Color

    var body: some View {
        Text(text)
            .font(.caption2.weight(.bold))
            .foregroundStyle(tint)
            .padding(.horizontal, 6)
            .padding(.vertical, 2)
            .background(tint.opacity(0.12))
            .clipShape(Capsule())
    }
}
