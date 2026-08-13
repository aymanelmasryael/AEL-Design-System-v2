# S-Illustration — Illustration Standard

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1 · Operational Laws v0.1
**Classification:** Standard — Level 3

---

## 1. Purpose

This standard defines the principles and rules governing illustration assets within the AEL Design System. It establishes the requirements for illustration style, format, color binding, responsiveness, naming, and accessibility across all platforms.

All illustration specifications and implementations within the AEL ecosystem must conform to this standard.

---

## 2. Scope

### 2.1 In Scope

- All illustrations used in AEL interfaces, editorial content, marketing materials, and product experiences.
- Illustration style taxonomy and consistency rules.
- Supported canonical and derivative formats.
- Color binding to design tokens.
- Responsive scaling and composition rules.
- Naming conventions for illustration assets.
- Accessibility requirements for informative and decorative illustrations.

### 2.2 Out of Scope

- Icon assets (governed by S-Icon).
- Photographic images (governed by S-Image).
- Logo, wordmark, and brand identity mark assets.
- Animation or motion design of illustrations (governed by future motion standard).
- Platform-specific rendering code.

---

## 3. Illustration Principles

Every illustration in the AEL Design System shall be:

1. **Brand-Aligned** — Illustrations shall reinforce AEL brand identity through consistent use of visual language, proportion, and mood.
2. **Purposeful** — Every illustration shall serve a defined communication goal. Decorative illustration is permitted only when it enhances without distracting.
3. **Consistent** — All illustrations within a project or product surface shall share a unified style.
4. **Scalable** — Illustrations shall render clearly across device sizes and resolutions without loss of meaning or quality.
5. **Token-Bound** — Illustration color shall be derived from design tokens. Hardcoded color values are prohibited except for approved brand assets.
6. **Accessible** — Illustrations shall not be the sole carrier of critical information. All informative illustrations shall provide text alternatives.

---

## 4. Style Taxonomy

### 4.1 Supported Styles

The AEL Design System recognizes the following illustration styles. Exactly one primary style shall be selected per project or product surface.

| Style | Description | Recommended Use |
|---|---|---|
| Outline | Line-based illustration with no fill | Editorial accents, icon-adjacent graphics |
| Flat | Solid filled shapes with no gradient or depth | UI empty states, onboarding |
| Filled | Rich filled illustration with tonal variation | Hero graphics, feature spotlights |
| Isometric | Three-dimensional projection at fixed angle | Technical diagrams, architecture visuals |
| Minimal | Reduced geometric forms | Brand marks, abstract backgrounds |
| Abstract | Non-representational shapes and patterns | Background textures, decorative surfaces |

### 4.2 Style Consistency

| # | Rule |
|---|---|
| IL01 | A single project or product surface shall use no more than one primary illustration style |
| IL02 | When a secondary style is required (e.g., icons within an illustration), the contrast between styles shall be intentional and documented |
| IL03 | Illustration style shall not change mid-surface — a single page, screen, or document shall maintain one style throughout |

---

## 5. Format Rules

| # | Rule |
|---|---|
| IL04 | SVG is the preferred canonical source format for all illustrations |
| IL05 | PNG is a permitted derivative format for raster output |
| IL06 | WebP is a permitted derivative format for web-optimized delivery |
| IL07 | Canonical SVG files shall be optimized — no unnecessary metadata, embedded raster images, or editor-specific markup |

---

## 6. Color Rules

| # | Rule |
|---|---|
| IL08 | All illustration colors shall reference design tokens from S-Color |
| IL09 | Hardcoded hex, RGB, or named color values are prohibited in canonical illustration files except for approved brand identity assets |
| IL10 | Illustrations shall support both light and dark mode variants where applicable — achieved through token binding, not duplicated assets |
| IL11 | When a color does not exist in the token system, a design token shall be proposed and approved before the illustration is finalized |

---

## 7. Responsive Rules

| # | Rule |
|---|---|
| IL12 | Illustrations shall scale proportionally — the aspect ratio shall be preserved |
| IL13 | Illustrations shall not distort, crop unexpectedly, or lose critical visual information at any supported viewport size |
| IL14 | Complex illustrations intended for large viewports shall have a simplified variant for small viewports when detail would be lost |

---

## 8. Naming Rules

| # | Rule |
|---|---|
| IL15 | Illustration file names shall use kebab-case (e.g., `hero-ai.svg`, `empty-state-search.svg`) |
| IL16 | Illustration identifiers shall follow the pattern `AS-illustration-{name}` as a specialization of the Asset entity |
| IL17 | Names shall describe the content, not the context of use — prefer `onboarding-step-01` over `page-three-hero` |
| IL18 | Variants (dark mode, simplified) shall be indicated with a double-hyphen suffix: `hero-ai--dark.svg` |

---

## 9. Accessibility Rules

| # | Rule |
|---|---|
| IL19 | Every illustration conveying information shall include descriptive alternative text |
| IL20 | Purely decorative illustrations shall be marked as presentational (hidden from assistive technology) |
| IL21 | Illustrations shall not be the sole carrier of critical information — text alternatives must be available |
| IL22 | Illustrations shall maintain sufficient contrast for any embedded text or meaningful visual elements |

---

## 10. Related Specifications

- SP-Illustration

## 11. Asset Architecture

All illustration assets are managed through the AEL Asset System:

- **Implementation:** `06-Implementation/assets/illustrations/` — canonical SVG files with manifests
- **Registry:** `07-Registry/asset-registry.json` — generated catalog
- **Manifest Schema:** `06-Implementation/assets/metadata/asset-manifest.schema.json`
- **Build:** `09-Build/generators/asset-registry-generator.js`

Each illustration has an ID (`AS-illustration-{name}`), a source SVG, and a JSON manifest. See PROP-2026-001.

---

## 12. Compliance

### 11.1 Verification

- Style consistency shall be verified by visual review against the project's declared primary style.
- Color binding to design tokens shall be verified by automated scanning of SVG source files.
- Responsive behavior shall be verified by testing at all supported breakpoints.
- Accessibility shall be verified by reviewing alternative text for all informative illustrations.

### 11.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | Hardcoded color value in canonical SVG | Must be resolved before release |
| Major | Mixed illustration styles on the same surface | Must be resolved before merge |
| Minor | Missing alternative text for informative illustration | Should be corrected; logged for review |

---

## 12. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-31 | Initial draft |

---

*End of S-Illustration v0.1.*
