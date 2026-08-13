# AEL Accessibility Guide

**Component:** All
**Governed By:** S-Component v0.3 §8
**Standard:** WCAG 2.1 AA minimum

---

## Requirements

Every AEL component meets these requirements:

| Requirement | WCAG | Verification |
|-------------|------|-------------|
| Keyboard accessible | 2.1.1 | All interactive elements reachable via Tab |
| Visible focus indicator | 2.4.7 | `TK-color-border-focus` ring on all components |
| Accessible name | 4.1.2 | Label association, aria-label, or aria-labelledby |
| Color not sole indicator | 1.4.1 | Icons, text, or patterns accompany color states |
| Contrast 4.5:1 (normal) / 3:1 (large) | 1.4.3 | Verified against token values in SSOT |
| Touch target ≥ 24 CSS pixels | 2.5.5 | All interactive elements meet minimum |
| Error identification | 3.3.1 | Text descriptions alongside visual indicators |
| Status announcements | 4.1.3 | Loading, error, and success states announced |

## Implementation

All values are bound to SSOT tokens. Color contrast is guaranteed at the token level — no component-level contrast testing needed for token-bound colors.
