# AEL Design System — Release Notes

---

## v1.0 — AEL Master Operating Protocol (Active)

**Status:** Active

### Summary

Formalized the AEL Master Operating Protocol as an enforceable governance artifact. Transformed a behavioral prompt into an engineering-executable protocol with normative language, rule identifiers, a lifecycle state machine, and an automated validator.

### Changes

- **Protocol document** — `03-Operational-Laws/AEL-Operating-Protocol.md` v1.0
- **RFC 2119 keywords** — every rule carries `MUST` / `MUST NOT` / `SHOULD` / `SHOULD NOT` / `MAY`
- **Rule IDs** — 142 rule identifiers (DEC, SYS, ENG, FSD, DOC, IMP, VAL, KNO, CON, VIS, COL, LOGO, NAM, VER, MEM, NOD, RES, LANG, SCP, SOT, CHG, RLV, RSH, SEC, STP, OFM, PRS, CMP, FRC, ADR, NAD, NSE, NUA, NED, NOE, NFP, NAC, CWR, NFC, NPN, NQL, NRP, NCL, UIP, EDD, RCR, STM, PRC, CVR)
- **State machine** — PLANNED → IN PROGRESS → IMPLEMENTED → VERIFIED → COMPLETE, with BLOCKED pause and explicit transition table
- **Precedence hierarchy** — 8-tier conflict resolution across all rules
- **Automated validator** — `scripts/validate-operating-protocol.js` enforces ID uniqueness, keyword presence, version consistency, and state machine integrity (zero dependencies, Node stdlib only)

---

## v0.2.2 — Brand Color Alignment (Unreleased)

**Status:** In Progress

### Summary

Reconciled the platform token SSOT with `identity.html` (Design Bible) so the design language is shared across the platform and both consumer websites. Removed scaffolded Apple HIG default values; adopted the curated AEL brand palette.

### Changes

- **Neutral scale** — `TK-color-gray-50..900` migrated from Apple HIG to `identity.html` neutral scale (`#FAFAFA → #111111`)
- **Accent palette added** — 4 new tokens: `TK-color-accent-violet` `#6C47FF`, `accent-teal` `#00D4AA`, `accent-pink` `#FF4D8D`, `accent-amber` `#F59E0B`
- **Semantic colors aligned** — `success #10B981`, `error #EF4444`, `info #3B82F6`, `warning #F59E0B` per Design Bible
- **Primary hover** — `#0062D6` (matches `identity.html` `.btn-primary:hover`)
- **Secondary** — `#6C47FF` (brand violet, replaces Apple `#5856D6`)
- **Tokens** — 143 → 147 (4 new); registries regenerated
- **SP-Color-Palette** — bumped to v1.2, added Accent Palette token references

### Source of Truth

`identity.html` (Design Bible) is authoritative for the AEL visual identity per `AGENTS.md` Product Architecture. The platform token JSONs are the machine-readable SSOT that distributes those values to 7 platform outputs.

---

## v0.2.1 — SwiftUI Reference App (Unreleased)

**Status:** In Progress

### Summary

First production SwiftUI platform deliverable: **AEL Color Picker**, a
ColorSlurp-class macOS screen color picker consuming AEL SSOT tokens.

### Major Achievements

- **SwiftUI platform shipped** — token-bound reference macOS application
- **AELColorKit** — pure, testable color mathematics: HEX/RGB/HSL/HSV/CMYK/
  OKLCH/CIELAB, WCAG 2.x, and a bit-for-bit APCA `0.0.98G-4g` implementation
- **Screen capture engine** — `CGWindowListCreateImage`, multi-display, 60 fps
- **Magnifier** — precision (nearest-neighbor + pixel grid) and smooth modes
- **12 export formats** — incl. SwiftUI, `NSColor(displayP3Red:)`, AEL Swift
- **AEL token matching** — nearest semantic token for any picked color
- **24 unit tests** — reference-verified conversions and APCA ground-truth pairs
- **`.app` bundle** — `scripts/build-app.sh` produces a double-clickable app

---

## v0.2 — Architecture & Reference Implementation

**Released:** 2026-07-31
**Status:** Stable

### Summary

The first complete release of the AEL Design System Platform. Establishes the 7-layer architecture, SSOT token system, 10-stage build pipeline, and a reference implementation of 37 HTML+CSS components.

### Major Achievements

- **7-layer architecture** — Governance → Infrastructure → Foundations → Components → Composition → Distribution → Knowledge
- **SSOT Architecture** — All 143 design token values in a single source of truth (`06-Implementation/tokens/`). Standards define rules only. Specifications declare token IDs only. Zero value duplication across layers. Verified at every build.
- **10-stage Build Pipeline** — Validation (3 checks) → Generation (8 targets) → Export (7 platform formats)
- **37 Components** — Foundations (6), Selection (5), Navigation (5), Containers (4), Overlay (4), Feedback (5), Data (8)
- **3 Generated Registries** — Tokens (143), Assets (18), Components (37)
- **Zero Hardcoded Values** — Every component CSS binds exclusively to `var(--ael-*)` tokens

### Architectural Decisions

See `00-Meta-Architecture/PROP-2026-001.md`:
- Implementation tokens are the Single Source of Truth
- Registry is generated, never hand-authored
- Standards carry no concrete values
- Specifications carry no concrete values — token ID references only
- Naming Convention Law expanded to 15 token categories (tiered: Core / Layout / Optional)
- Component meta model defines anatomy, slots, states, variants, lifecycle for all 37 components

### New in v0.2

| Area | Contents |
|------|----------|
| Architecture | 7-layer model, SSOT, governance hierarchy |
| Infrastructure | Build system, 3 validators, 8 generators |
| Tokens | 143 tokens, 15 categories, 17 SSOT files |
| Assets | 15 SVG icons, 3 logo manifests, manifest schema |
| Components | 37 components, 7 groups, manifest schema, registry |
| Composition | Layout (Container, Grid, Stack), Navigation, Charts, Templates |
| Distribution | 7 generated exports, 11 platform targets |
| Knowledge | 7 documentation files |

### Breaking Changes

None. v0.2 is the baseline release.

### Known Limitations

- Platform production libraries (React, Vue, Angular, Svelte, SwiftUI, Flutter, Jetpack Compose) are scaffolded but not yet implemented. v0.3 will address this.
- Figma and Canva design kits are scaffolded. Token exports exist. Full design kits planned for v0.3.
- Component playground is planned but not yet interactive beyond the HTML preview pages.

### Roadmap to v0.3

**v0.3 — Platform Production Libraries**

| Platform | Deliverable |
|----------|------------|
| React | Component library (JSX/TSX, 37 components) |
| Vue | Component library (SFC, 37 components) |
| Angular | Component library (37 components) |
| Svelte | Component library (37 components) |
| SwiftUI | iOS component library |
| Flutter | Cross-platform component library |
| Android | Jetpack Compose component library |
| Figma | Design kit |
| Canva | Design assets |

All v0.3 implementations consume the same SSOT tokens. No architecture changes required.

### Vision for v1.0

- All 11 platform targets at production quality
- Interactive component playground
- Full design system website
- CI/CD integration
- Package registry publishing
- Operations layer (metrics, analytics, adoption tracking)
