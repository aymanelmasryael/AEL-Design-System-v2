# SP-Color-Palette — Color Palette Specification

**Version:** 1.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Color v0.2
**Classification:** Specification — Level 4

---

## 1. Purpose

This specification defines the structure, token references, and implementation requirements for the color palette of the AEL Design System.

Concrete color values are the Single Source of Truth in `06-Implementation/tokens/` (editorial-colors.json, product-colors.json, semantic-colors.json). This specification references token IDs only and does not duplicate values. See PROP-2026-001.

---

## 2. Editorial Palette

| Role | Token |
|------|-------|
| Brand Primary | `TK-color-brand-primary` |
| Black | `TK-color-black` |
| White | `TK-color-white` |

---

## 3. Neutral Palette (Gray Scale)

| Role | Token |
|------|-------|
| Gray 50 | `TK-color-gray-50` |
| Gray 100 | `TK-color-gray-100` |
| Gray 200 | `TK-color-gray-200` |
| Gray 300 | `TK-color-gray-300` |
| Gray 400 | `TK-color-gray-400` |
| Gray 500 | `TK-color-gray-500` |
| Gray 600 | `TK-color-gray-600` |
| Gray 700 | `TK-color-gray-700` |
| Gray 800 | `TK-color-gray-800` |
| Gray 900 | `TK-color-gray-900` |

---

## 4. Product Palette

| Role | Token |
|------|-------|
| Primary | `TK-color-primary` |
| Primary Hover | `TK-color-primary-hover` |
| Primary Active | `TK-color-primary-active` |
| Secondary | `TK-color-secondary` |
| Success | `TK-color-success` |
| Warning | `TK-color-warning` |
| Error | `TK-color-error` |
| Info | `TK-color-info` |
| Surface | `TK-color-surface` |
| Background | `TK-color-background` |
| Border | `TK-color-border` |
| Border Focus | `TK-color-border-focus` |

### 4.1. Accent Palette (Brand Colors)

| Role | Token |
|------|-------|
| Violet | `TK-color-accent-violet` |
| Teal | `TK-color-accent-teal` |
| Pink | `TK-color-accent-pink` |
| Amber | `TK-color-accent-amber` |

Sourced from `identity.html` (Design Bible). Used for tags, highlights, charts, and decorative brand accents.

---

## 5. Semantic Tokens

| Role | Token |
|------|-------|
| Text Primary | `TK-color-text-primary` |
| Text Secondary | `TK-color-text-secondary` |
| Text Disabled | `TK-color-text-disabled` |
| Text Inverse | `TK-color-text-inverse` |
| Background Secondary | `TK-color-background-secondary` |
| Surface Secondary | `TK-color-surface-secondary` |

---

## 6. State Mapping

| State | Token |
|-------|-------|
| Default | `TK-color-primary` |
| Hover | `TK-color-primary-hover` |
| Active | `TK-color-primary-active` |
| Disabled | `TK-color-gray-200` (background) + `TK-color-gray-500` (foreground) |
| Error | `TK-color-error` |
| Success | `TK-color-success` |
| Warning | `TK-color-warning` |

---

## 7. Accessibility

- All tokens must meet WCAG 2.1 AA contrast requirements
- WCAG 2.1 AAA where applicable
- Color must never be the only indicator of meaning
- Contrast verification is performed at the Implementation level against token values

---

## 8. Platform Mapping

| Platform | Status |
|----------|--------|
| CSS | Supported |
| SwiftUI | Supported |
| Android | Planned |
| Figma | Supported |
| Canva | Planned |

---

## 9. Version History

| Version | Date | Description |
|---|---|---|
| 1.2 | 2026-08-06 | Added Accent Palette (violet/teal/pink/amber) per identity.html Design Bible. |
| 1.1 | 2026-07-31 | Removed SSOT claim. Replaced concrete hex values with token ID references. SSOT delegated to Implementation per PROP-2026-001. |
| 1.0 | 2026-07-30 | Initial enterprise specification |

---

*End of SP-Color-Palette v1.1.*
