# AEL SwiftUI Platform — AEL Color Picker

**Status:** Complete — Reference macOS Application
**Token Source:** `06-Implementation/platforms/swift/AELTokens.swift`
**Module:** `AELColorKit` (library) + `AELColorPicker` (executable)

A production-style macOS screen color picker for designers and developers,
built on the AEL Design System tokens. Captures the pixel under the cursor,
renders a live magnifier, exports to 12 formats, and measures WCAG 2.x + APCA
contrast — all driven by the AEL token SSOT.

---

## Features

| Capability | Detail |
|------------|--------|
| Screen capture | `CGWindowListCreateImage` region snapshots, throttled to 60 fps |
| Multi-display | Correct coordinates via the global top-left-origin display space |
| Magnifier | Precision mode (nearest-neighbor + pixel grid) and smooth mode |
| Color engine | HEX, RGB, HSL, HSV, CMYK, OKLCH, CIELAB — Double-precision sRGB |
| Contrast | WCAG 2.x ratio/levels **and** APCA `0.0.98G-4g` (bit-for-bit reference) |
| Export | 12 formats incl. SwiftUI, `NSColor(displayP3Red:)`, and AEL Swift |
| Tokens | Nearest AEL semantic token detection for any picked color |
| History | JSON persistence (`~/Library/Application Support/AELColorPicker/`) |
| Menu bar | Live color swatch status item; left-click picks, right-click opens menu |
| Hotkey | ⌘⇧P starts a pick (Carbon global hotkey) |

---

## Layout

```
Sources/AELColorKit/          Pure color mathematics (no UI, fully testable)
  AELColor.swift              Core value object, hex/linear/XYZ, transfer funcs
  ColorConversions.swift      HSL · HSV · CMYK · OKLab · CIELAB
  Contrast.swift              WCAG 2.x + APCA (0.0.98G-4g W3)
  ExportFormat.swift          Deterministic locale-safe formatting
  AELTokenMatch.swift         Nearest AEL semantic token (OKLab distance)
Sources/AELColorPicker/       macOS application (SwiftUI + AppKit)
  AELColorPickerApp.swift     @main entry point (WindowGroup)
  AppDelegate.swift           Picker flow, overlay window, permission handling
  ScreenCaptureEngine.swift   Window-server capture + global event monitors
  MagnifierView.swift         Pixel magnifier (precision grid / smooth)
  MagnifierPanel.swift        Floating overlay content
  ColorPanelView.swift        Main window: swatch, formats, contrast, history
  MenuBarController.swift     NSStatusItem with live swatch icon
  HotKeyManager.swift         Carbon ⌘⇧P global hotkey
  HistoryStore.swift          JSON persistence
  AELTokens.swift             Generated token constants (see below)
Tests/AELColorKitTests/       24 unit tests (incl. APCA reference-verified)
scripts/build-app.sh          Builds a signed-on-demand .app bundle
```

`Sources/AELColorPicker/AELTokens.swift` is copied from the generated
`platforms/swift/AELTokens.swift`. Regenerate after any token change:

```bash
node 09-Build/build.js
cp 06-Implementation/platforms/swift/AELTokens.swift \
   06-Implementation/platforms/swiftui/Sources/AELColorPicker/AELTokens.swift
```

---

## Build & Run

```bash
# Development (run from terminal)
swift run

# Tests (24 unit tests — color conversions, OKLab/CIELAB references, APCA)
swift test

# Double-clickable .app bundle
./scripts/build-app.sh   # → dist/AELColorPicker.app
```

### First launch (Screen Recording permission)

macOS requires Screen Recording access before any pixel can be read.

1. Launch the app, press ⌘⇧P (or click **Pick from Screen**).
2. Grant permission in the system prompt, or open
   **System Settings → Privacy & Security → Screen Recording** and enable the
   app (or your terminal, when running via `swift run`).
3. Re-launch if the first capture returns a blank region.

---

## Usage

- **⌘⇧P** (or menu-bar icon left click) → move the cursor, click to capture.
  **Esc** cancels.
- Menu-bar icon shows the current color; **right click** opens the app menu.
- Each format row copies to the clipboard on click.
- The contrast section evaluates the picked color against any text/background
  pair using both WCAG 2.x and APCA, with WCAG 3 draft level badges
  (Bronze / Silver / Gold).

---

## Design notes

- **Pixel reading** goes through the window server (`CGWindowListCreateImage`),
  not the framebuffer. The result is drawn through a color-managed sRGB
  context so HEX values are consistent across displays.
- **APCA** is implemented 1:1 from the canonical `apca-w3` reference
  (`0.0.98G-4g`, W3 license) and unit-tested against ground-truth outputs —
  e.g. `#767676` on `#FFFFFF` ⇒ Lc 71.57, black-on-white ⇒ 106.04, and the
  polarity asymmetry white-on-black ⇒ −107.88.
- **Precision mode** upscales with exact integer nearest-neighbor so pixels
  stay crisp; smooth mode leaves interpolation to the compositor.

---

## License

Copyright © 2026 Ayman Elmasry. All rights reserved.
Owner: Ayman Elmasry · Organization: AEL Digital Studio™ · See `LICENSE`.
