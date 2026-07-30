# SP-Spacing — Spacing Specification

**Version:** 1.0
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Spacing
**Classification:** Specification — Level 4

---

# 1. Purpose

This specification defines the official spacing tokens, scale, and implementation rules for the AEL Design System.

---

# 2. Base Unit

The base spacing unit is:

```
8px
```

Half Unit:

```
4px
```

---

# 3. Spacing Tokens

| Token | Value |
|--------|------:|
| XS | 4px |
| SM | 8px |
| MD | 16px |
| LG | 24px |
| XL | 32px |
| 2XL | 40px |
| 3XL | 48px |
| 4XL | 56px |
| 5XL | 64px |
| 6XL | 80px |
| 7XL | 96px |
| 8XL | 128px |

---

# 4. Margin Rules

Margins shall use spacing tokens only.

Arbitrary values are prohibited unless explicitly approved.

---

# 5. Padding Rules

Padding shall use spacing tokens only.

Nested components shall maintain consistent internal spacing.

---

# 6. Gap Rules

Layout gaps shall follow the approved spacing scale.

---

# 7. Responsive Scaling

Spacing tokens remain semantically identical across all breakpoints.

Only layout composition may change.

---

# 8. Platform Mapping

| Platform | Status |
|----------|----------|
| CSS | Supported |
| SwiftUI | Supported |
| Android | Planned |
| Figma | Supported |

---

# 9. Version History

| Version | Date | Description |
|----------|------------|------------------------------|
| 1.0 | 2026-07-30 | Initial spacing specification |

_End of SP-Spacing v1.0._
