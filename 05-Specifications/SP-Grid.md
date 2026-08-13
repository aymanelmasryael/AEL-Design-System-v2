# SP-Grid — Grid System Specification

**Version:** 1.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Grid
**Classification:** Specification — Level 4

---

## 1. Purpose

This specification defines the structure, token references, and implementation requirements for the grid system within the AEL Design System.

Concrete grid values are the Single Source of Truth in `06-Implementation/tokens/grid.json` and `06-Implementation/tokens/breakpoint.json`. This specification references token IDs only and does not duplicate values. See PROP-2026-001.

---

## 2. Grid Structure

Default grid uses 12 columns.

Supported alternative layouts:
- 2 Columns
- 4 Columns
- 6 Columns
- 8 Columns
- 12 Columns

Column count is defined by `TK-grid-columns`.

---

## 3. Column Rules

Columns shall:
- Scale proportionally
- Maintain equal widths
- Align to the layout grid

---

## 4. Gutters

| Device | Token |
|--------|-------|
| Mobile | `TK-spacing-md` |
| Tablet | `TK-spacing-lg` |
| Desktop | `TK-spacing-xl` |

---

## 5. Margins

| Device | Token |
|--------|-------|
| Mobile | `TK-spacing-md` |
| Tablet | `TK-spacing-xl` |
| Desktop | `TK-spacing-5xl` |

---

## 6. Responsive Breakpoints

| Device | Token | Usage |
|--------|-------|-------|
| Mobile | — | Default (0 and above) |
| Tablet | `TK-breakpoint-tablet` | 768 and above |
| Laptop | `TK-breakpoint-laptop` | 1024 and above |
| Desktop | `TK-breakpoint-desktop` | 1440 and above |

---

## 7. Alignment Rules

Layouts shall maintain:
- Horizontal alignment
- Vertical rhythm
- Consistent spacing
- Predictable composition

---

## 8. Platform Mapping

| Platform | Status |
|----------|--------|
| CSS Grid | Supported |
| Flexbox | Supported |
| SwiftUI | Supported |
| Figma | Supported |

---

## 9. Version History

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-30 | Initial grid specification |
| 1.1 | 2026-07-31 | Removed concrete px values (migrated to Implementation SSOT per PROP-2026-001). Gutter/margin mapped to spacing tokens. Breakpoints reference breakpoint tokens. |

---

*End of SP-Grid v1.1.*
