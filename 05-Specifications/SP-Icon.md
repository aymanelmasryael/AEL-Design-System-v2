# SP-Icon — Icon Specification

**Version:** 1.0  
**Status:** Draft  
**Owner:** AEL Digital Studio  
**Governed By:** S-Icon  
**Classification:** Specification — Level 4

---

# 1. Purpose

This specification defines the implementation requirements for icons within the AEL Design System.

---

# 2. Supported Formats

- SVG
- PNG
- WebP (generated assets)

SVG is the canonical source format.

---

# 3. Grid System

Icons shall be designed on standardized grids:

- 16×16
- 20×20
- 24×24
- 32×32
- 48×48

---

# 4. Stroke Rules

- Consistent stroke width
- Rounded joins where applicable
- Pixel-aligned paths
- No unnecessary anchor points

---

# 5. Fill Rules

Supported styles:

- Outline
- Filled
- Duotone

---

# 6. Color

Icons shall inherit color from design tokens.

Hardcoded colors are prohibited except for brand assets.

---

# 7. Naming Convention

Examples:

home.svg

user.svg

settings.svg

search.svg

arrow-right.svg

---

# 8. Accessibility

Icons conveying meaning shall include:

- Accessible label
- Decorative flag when applicable

---

# 9. Platform Mapping

Supported for:

- HTML
- CSS
- React
- SwiftUI
- Flutter
- Figma
- Canva

---

# 10. Validation

Every icon shall be validated for:

- Pixel alignment
- Visual consistency
- Accessibility
- File optimization

---

# 11. Version History

| Version | Date | Description |
|----------|------------|----------------------------|
| 1.0 | 2026-07-30 | Initial icon specification |

_End of SP-Icon v1.0._
