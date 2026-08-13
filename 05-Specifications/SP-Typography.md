# SP-Typography — Typography Specification

**Version:** 1.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Typography
**Classification:** Specification — Level 4

---

## 1. Purpose

This specification defines the structure, token references, and implementation requirements for typography within the AEL Design System.

Concrete typography values are the Single Source of Truth in `06-Implementation/tokens/typography.json`. This specification references token IDs only and does not duplicate values. See PROP-2026-001.

---

## 2. Font Families

| Role | Token | Font Stack |
|------|-------|------------|
| Primary | `TK-typography-font-primary` | `'Inter', -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif` |
| Secondary | `TK-typography-font-secondary` | `'SF Pro Display', -apple-system, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif` |
| Monospace | `TK-typography-font-mono` | `'JetBrains Mono', 'Fira Code', 'Cascadia Code', 'Consolas', monospace` |

---

## 3. Type Scale

| Role | Token |
|------|-------|
| Display | `TK-typography-size-display` |
| H1 | `TK-typography-size-h1` |
| H2 | `TK-typography-size-h2` |
| H3 | `TK-typography-size-h3` |
| H4 | `TK-typography-size-h4` |
| H5 | `TK-typography-size-h5` |
| H6 | `TK-typography-size-h6` |
| Body | `TK-typography-size-body` |
| Small | `TK-typography-size-small` |
| Caption | `TK-typography-size-caption` |

---

## 4. Font Weights

| Weight | Token |
|--------|-------|
| Light | `TK-typography-weight-light` |
| Regular | `TK-typography-weight-regular` |
| Medium | `TK-typography-weight-medium` |
| SemiBold | `TK-typography-weight-semibold` |
| Bold | `TK-typography-weight-bold` |

---

## 5. Line Heights

| Density | Token |
|---------|-------|
| Tight | `TK-typography-lineheight-tight` |
| Normal | `TK-typography-lineheight-normal` |
| Relaxed | `TK-typography-lineheight-relaxed` |

---

## 6. Letter Spacing

| Density | Token |
|---------|-------|
| Tight | `TK-typography-letterspacing-tight` |
| Normal | `TK-typography-letterspacing-normal` |
| Wide | `TK-typography-letterspacing-wide` |

---

## 7. Accessibility

- Minimum body size: as defined in `TK-typography-size-body`
- Maintain sufficient contrast (verified against S-Color accessibility rules)
- Avoid excessive line lengths

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
| 1.0 | 2026-07-30 | Initial typography specification |
| 1.1 | 2026-07-31 | Added full font stacks. Removed concrete values (migrated to Implementation SSOT per PROP-2026-001). Replaced with token ID references. |

---

*End of SP-Typography v1.1.*
