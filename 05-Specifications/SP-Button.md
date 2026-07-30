# SP-Button — Button Specification

**Version:** 1.0
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Button
**Classification:** Specification — Level 4

---

# 1. Purpose

This specification defines the implementation requirements for the Button component within the AEL Design System.

---

# 2. Anatomy

A Button consists of:

- Container
- Label
- Optional Leading Icon
- Optional Trailing Icon
- Loading Indicator

---

# 3. Variants

Supported variants:

- Primary
- Secondary
- Outline
- Ghost
- Text
- Danger
- Success

---

# 4. Sizes

| Size | Height |
|------|---------|
| XS | 28px |
| SM | 36px |
| MD | 44px |
| LG | 52px |
| XL | 60px |

---

# 5. States

- Default
- Hover
- Focus
- Active
- Disabled
- Loading

---

# 6. Design Tokens

Uses:

- Color Tokens
- Typography Tokens
- Spacing Tokens
- Radius Tokens
- Shadow Tokens
- Motion Tokens

---

# 7. Accessibility

Requirements:

- Keyboard accessible
- Visible focus indicator
- Accessible label
- WCAG 2.1 AA contrast compliance

---

# 8. Platform Mapping

| Platform | Status |
|----------|----------|
| HTML | Supported |
| CSS | Supported |
| React | Planned |
| SwiftUI | Planned |
| Flutter | Planned |
| Figma | Supported |
| Canva | Planned |

---

# 9. Usage Guidelines

Buttons shall:

- Represent a single primary action.
- Use concise labels.
- Avoid multiple primary buttons within the same context.

---

# 10. Version History

| Version | Date | Description |
|----------|------------|------------------------------|
| 1.0 | 2026-07-30 | Initial button specification |

_End of SP-Button v1.0._
