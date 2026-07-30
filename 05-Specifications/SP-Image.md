# SP-Image — Image Specification

**Version:** 1.0  
**Status:** Draft  
**Owner:** AEL Digital Studio  
**Governed By:** S-Image  
**Classification:** Specification — Level 4

---

# 1. Purpose

This specification defines the implementation requirements for image assets within the AEL Design System.

---

# 2. Supported Formats

Canonical formats:

- SVG
- PNG
- WebP
- JPEG

Preferred web format: WebP.

---

# 3. Resolution

Images shall support:

- 1x
- 2x
- 3x

High-density displays shall use responsive assets.

---

# 4. Responsive Behavior

Images shall:

- Scale proportionally
- Preserve aspect ratio
- Prevent distortion
- Support responsive layouts

---

# 5. Optimization

All images shall be:

- Compressed
- Optimized for web delivery
- Free of unnecessary metadata
- Cached when applicable

---

# 6. Accessibility

Images shall include:

- Alternative text
- Decorative flag when appropriate
- Meaningful descriptions for informative images

---

# 7. Naming Convention

Examples:

hero-home.webp

profile-avatar.png

dashboard-preview.jpg

logo-primary.svg

---

# 8. Platform Mapping

Supported for:

- HTML
- CSS
- React
- SwiftUI
- Flutter
- Figma
- Canva

---

# 9. Validation

Every image shall be validated for:

- Resolution
- Aspect ratio
- Compression quality
- Accessibility
- File size

---

# 10. Version History

| Version | Date | Description |
|----------|------------|---------------------------|
| 1.0 | 2026-07-30 | Initial image specification |

_End of SP-Image v1.0._
