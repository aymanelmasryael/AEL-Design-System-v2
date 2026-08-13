# SP-Spacing — Spacing Specification

**Version:** 1.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Spacing v0.2
**Classification:** Specification — Level 4

---

## 1. Purpose

This specification defines the structure, token references, and implementation rules for spacing within the AEL Design System.

Concrete spacing values are the Single Source of Truth in `06-Implementation/tokens/spacing.json`. This specification references token IDs only and does not duplicate values. See PROP-2026-001.

---

## 2. Base Unit

The base spacing unit is defined in `TK-spacing-sm`.

The half unit is defined in `TK-spacing-xs`.

---

## 3. Spacing Tokens

| Token | Role |
|-------|------|
| `TK-spacing-xs` | Extra small |
| `TK-spacing-sm` | Small — base unit |
| `TK-spacing-md` | Medium — default component padding |
| `TK-spacing-lg` | Large — section padding |
| `TK-spacing-xl` | Extra large — layout gaps |
| `TK-spacing-2xl` | 2XL — page margins |
| `TK-spacing-3xl` | 3XL — hero section padding |
| `TK-spacing-4xl` | 4XL — page-level spacing |
| `TK-spacing-5xl` | 5XL — large section separation |
| `TK-spacing-6xl` | 6XL — major layout spacing |
| `TK-spacing-7xl` | 7XL — maximum layout spacing |
| `TK-spacing-8xl` | 8XL — ultra large separation |

All spacing token values are multiples of the base unit. See `06-Implementation/tokens/spacing.json` for concrete values.

---

## 4. Margin Rules

Margins shall use spacing tokens only.

Arbitrary values are prohibited unless explicitly approved.

---

## 5. Padding Rules

Padding shall use spacing tokens only.

Nested components shall maintain consistent internal spacing.

---

## 6. Gap Rules

Layout gaps shall follow the approved spacing scale.

---

## 7. Responsive Scaling

Spacing tokens remain semantically identical across all breakpoints.

Only layout composition may change.

---

## 8. Platform Mapping

| Platform | Status |
|----------|--------|
| CSS | Supported |
| SwiftUI | Supported |
| Android | Planned |
| Figma | Supported |

---

## 9. Version History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-30 | Initial spacing specification |
| 1.1 | 2026-07-31 | Removed concrete px values (migrated to Implementation SSOT per PROP-2026-001). Replaced with token ID references. |

---

*End of SP-Spacing v1.1.*
