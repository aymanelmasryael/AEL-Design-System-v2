# 06 — Implementation

**Purpose:** Concrete output files that implement Specifications. This is the only level that contains platform-specific formats. Implementation token files are the Single Source of Truth (SSOT) for all concrete design values per PROP-2026-001.

**Scope:** Token JSON files, CSS, SCSS, SVG, PNG, HTML, platform-specific artifacts.

**Belongs here (active):**

- `tokens/` — SSOT for all design token values (17 files, 143 tokens across 15 categories in Core 8 / Layout 4 / Optional 3 tiers)
  - Core: `editorial-colors.json`, `product-colors.json`, `semantic-colors.json`, `spacing.json`, `typography.json`, `radius.json`, `shadow.json`, `border.json`, `motion.json`, `opacity.json`
  - Layout: `breakpoint.json`, `grid.json`, `z-index.json`, `elevation.json`
  - Optional: `blur.json`, `size.json`, `icon.json`
- `Components/` — Platform-specific component implementations (HTML, CSS, React, SwiftUI, etc.)
- `platforms/` — Generated platform token exports (7 targets, produced by 09-Build/build.js)
  - `css/variables.css`, `scss/_tokens.scss`, `swift/AELTokens.swift`, `android/ael_tokens.xml`, `figma/figma-tokens.json`, `w3c/design-tokens.json`, `json/tokens.json`

**Planned:**
- Platform subdirectories for component implementations (`html/`, `react/`, `swiftui/`, `figma/`, `canva/`)

**Does NOT belong here:** Specifications, Standards, or governance documents.

**SSOT note:** All concrete token values (hex, px, em, numeric) are defined exclusively in `tokens/*.json`. Standards and Specifications reference token IDs only. Platform exports and the Registry (`07-Registry/token-registry.json`) are generated — never hand-authored. Run `node 09-Build/build.js` to regenerate all outputs.
