# S-Icon — Icon Standard

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1 · Operational Laws v0.1
**Classification:** Standard — Level 3

---

## 1. Purpose

This standard defines the principles and rules governing icon assets within the AEL Design System. It establishes the requirements for icon design, format, style, sizing, color binding, naming, and accessibility across all platforms.

All icon specifications and implementations within the AEL ecosystem must conform to this standard.

---

## 2. Scope

### 2.1 In Scope

- All icons used in AEL interfaces, editorial content, and product experiences.
- Icon design methodology (grid, stroke, fill).
- Supported canonical and derivative formats.
- Color binding to design tokens.
- Naming conventions for icon assets.
- Accessibility requirements for informative and decorative icons.

### 2.2 Out of Scope

- Illustration assets (governed by S-Illustration).
- Logo and wordmark assets (governed by S-Image).
- Platform-specific rendering code or component wrappers.
- Icon animation or motion design (governed by future motion standard).

---

## 3. Icon Principles

Every icon in the AEL Design System shall be:

1. **Recognizable** — The meaning of the icon shall be unambiguous at its rendered size.
2. **Consistent** — All icons shall share a unified visual language: stroke weight, corner treatment, and proportion.
3. **Scalable** — Icons shall render clearly at all defined grid sizes without loss of fidelity.
4. **Pixel-Aligned** — Paths shall align to the pixel grid at canonical sizes to prevent sub-pixel rendering artifacts.
5. **Token-Bound** — Icon color shall be derived from design tokens. Hardcoded color values are prohibited except for approved brand assets.

---

## 4. Format Rules

| # | Rule |
|---|---|
| I01 | SVG is the canonical source format for all icons |
| I02 | PNG is a permitted derivative format for platforms that do not support SVG |
| I03 | WebP is a permitted derivative format for web-optimized delivery |
| I04 | All canonical SVG files shall be optimized (no unnecessary metadata, comments, or editor-specific markup) |

---

## 5. Grid and Sizing Rules

| # | Rule |
|---|---|
| I05 | Icons shall be designed on standardized square grids |
| I06 | Supported grid sizes: 16×16, 20×20, 24×24, 32×32, 48×48 |
| I07 | An icon designed for one grid size shall not be scaled to a different grid size — a separate asset shall be produced |
| I08 | Live area within each grid shall maintain consistent optical padding across all icons |

---

## 6. Style Rules

### 6.1 Stroke Style

| # | Rule |
|---|---|
| I09 | Stroke width shall be consistent across all icons within a set |
| I10 | Stroke joins shall use rounded caps unless the shape demands a miter join |
| I11 | All paths shall be closed and free of unnecessary anchor points |

### 6.2 Fill Style

| # | Rule |
|---|---|
| I12 | Supported fill styles: Outline, Filled, Duotone |
| I13 | An icon set shall use exactly one fill style consistently per context |
| I14 | Duotone icons shall use exactly two color values, both derived from design tokens |

---

## 7. Color Rules

| # | Rule |
|---|---|
| I15 | Icon color shall reference design tokens — the canonical source is S-Color |
| I16 | Hardcoded hex, RGB, or named color values are prohibited in icon source files except for approved brand identity assets |
| I17 | Icons shall support at minimum: default color, hover state color, and disabled state color per context |
| I18 | Icons shall not use opacity to simulate color variants |

---

## 8. Naming Rules

| # | Rule |
|---|---|
| I19 | Icon file names shall use kebab-case (e.g., `arrow-right.svg`, `user-circle.svg`) |
| I20 | Icon identifiers shall follow the pattern `AS-icon-{name}` as defined in the Naming Convention Law |
| I21 | Icon names shall be descriptive nouns or noun phrases — avoid abbreviations |
| I22 | Directional variants shall append the direction: `arrow-right`, `chevron-down`, `arrow-left` |

---

## 9. Accessibility Rules

| # | Rule |
|---|---|
| I23 | Every icon conveying meaning shall include an accessible text label |
| I24 | Purely decorative icons shall be marked as presentational (hidden from assistive technology) |
| I25 | Icons used as interactive controls shall expose an accessible name to assistive technology |
| I26 | Icons shall maintain minimum contrast ratio of 3:1 against their background per WCAG 2.1 AA |

---

## 10. Related Specifications

- SP-Icon

## 11. Asset Architecture

All icon assets are managed through the AEL Asset System:

- **Implementation:** `06-Implementation/assets/icons/` — canonical SVG files with manifests
- **Registry:** `07-Registry/asset-registry.json` — generated catalog of all assets
- **Manifest Schema:** `06-Implementation/assets/metadata/asset-manifest.schema.json`
- **Build:** `09-Build/generators/asset-registry-generator.js` — generates registry from manifests

Each icon asset has an ID (`AS-icon-{name}`), a source SVG, and a JSON manifest per the schema. See PROP-2026-001 for the architectural model.

---

## 12. Compliance

### 11.1 Verification

- Icon grid alignment shall be verified against the canonical grid templates.
- Color binding to design tokens shall be verified by automated scanning of SVG source files.
- Naming convention compliance shall be verified against the Naming Convention Law.
- Accessibility labeling shall be verified during component review.

### 11.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | Hardcoded color value in canonical SVG | Must be resolved before release |
| Major | Icon not aligned to standardized grid | Must be resolved before merge |
| Minor | Non-compliant file name | Should be corrected; logged for review |

---

## 12. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-31 | Initial draft |

---

*End of S-Icon v0.1.*
