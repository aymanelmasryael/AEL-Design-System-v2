# S-Image — Image Standard

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.1 · Operational Laws v0.1
**Classification:** Standard — Level 3

---

## 1. Purpose

This standard defines the principles and rules governing image assets within the AEL Design System. It establishes the requirements for image format, resolution, optimization, responsive behavior, naming, and accessibility across all platforms.

All image specifications and implementations within the AEL ecosystem must conform to this standard.

---

## 2. Scope

### 2.1 In Scope

- All photographic and raster images used in AEL interfaces, editorial content, marketing materials, and product experiences.
- Brand identity assets (logos, wordmarks, brand marks).
- Image format and resolution requirements.
- Optimization and compression rules.
- Responsive image delivery rules.
- Naming conventions for image assets.
- Accessibility requirements (alternative text, decorative images).

### 2.2 Out of Scope

- Icon assets (governed by S-Icon).
- Illustration assets (governed by S-Illustration).
- Video or animated content (governed by future motion standard).
- Image content strategy, photography art direction, or image selection guidelines.
- Platform-specific rendering code or lazy-loading implementation.

---

## 3. Image Principles

Every image in the AEL Design System shall be:

1. **Fit for Purpose** — Resolution, format, and compression shall be appropriate for the image's role and display context.
2. **Optimized** — Images shall be compressed and delivered at the minimum viable file size without perceptible quality loss.
3. **Responsive** — Images shall adapt to viewport size and device pixel ratio without distortion.
4. **Accessible** — Every informative image shall provide a text alternative. Decorative images shall be hidden from assistive technology.
5. **Consistently Named** — All image files shall follow a unified naming convention for discoverability and automation.

---

## 4. Format Rules

| # | Rule |
|---|---|
| IM01 | WebP is the preferred delivery format for all web-based raster images |
| IM02 | SVG is the required canonical format for all vector-based brand assets (logos, wordmarks, brand marks) |
| IM03 | PNG is the required format for images requiring transparency when WebP is not supported |
| IM04 | JPEG is permitted for photographic images where file size is prioritized over transparency |
| IM05 | The canonical source file (e.g., `.ai`, `.psd`, `.fig`) shall be preserved alongside exported assets in the source archive |

---

## 5. Resolution Rules

| # | Rule |
|---|---|
| IM06 | Images shall be provided at minimum 1x, 2x, and 3x resolutions for raster assets |
| IM07 | The 2x variant shall be the design canonical — the source file shall be authored at 2x resolution |
| IM08 | Images shall not be upscaled — the largest resolution variant shall define the upper bound |

---

## 6. Optimization Rules

| # | Rule |
|---|---|
| IM09 | All images shall be compressed before inclusion in the system |
| IM10 | Compression shall achieve the smallest file size that preserves visual fidelity — no visible compression artifacts at intended display size |
| IM11 | Image metadata (EXIF, geolocation, camera profile) shall be stripped from all published assets unless specifically required |
| IM12 | Images shall be served using appropriate caching headers in production |

---

## 7. Responsive Rules

| # | Rule |
|---|---|
| IM13 | Images shall scale proportionally — the aspect ratio shall be preserved |
| IM14 | Images shall not distort, crop unexpectedly, or overflow their container at any supported viewport size |
| IM15 | Images shall use responsive delivery (srcset, picture element, or platform equivalent) to serve the appropriate resolution variant |

---

## 8. Naming Rules

| # | Rule |
|---|---|
| IM16 | Image file names shall use kebab-case (e.g., `hero-home.webp`, `logo-primary.svg`) |
| IM17 | Image identifiers shall follow the pattern `AS-{type}-{name}` as defined in the Naming Convention Law |
| IM18 | Resolution variants shall append the multiplier: `logo-primary@2x.png`, `logo-primary@3x.png` |
| IM19 | Brand identity assets shall use the `logo` type prefix: `AS-logo-primary`, `AS-logo-primary--dark` |

---

## 9. Accessibility Rules

| # | Rule |
|---|---|
| IM20 | Every informative image shall include descriptive alternative text |
| IM21 | Purely decorative images shall be marked as presentational (empty alt attribute or platform equivalent) |
| IM22 | Images containing text shall have that text reproduced verbatim in the alternative text |
| IM23 | Complex images (charts, diagrams, infographics) shall provide a long description in addition to brief alternative text |

---

## 10. Related Specifications

- SP-Image

## 11. Asset Architecture

All image and logo assets are managed through the AEL Asset System:

- **Implementation:** `06-Implementation/assets/logos/`, `images/` — canonical files with manifests
- **Registry:** `07-Registry/asset-registry.json` — generated catalog
- **Manifest Schema:** `06-Implementation/assets/metadata/asset-manifest.schema.json`
- **Build:** `09-Build/generators/asset-registry-generator.js`

Each asset has an ID (`AS-logo-{name}`, `AS-image-{name}`), a source file, and a JSON manifest. See PROP-2026-001.

---

## 12. Compliance

### 11.1 Verification

- Format compliance shall be verified by checking source and published file extensions against the format table.
- Resolution compliance shall be verified by inspecting image dimensions.
- Compression quality shall be verified by visual review and file size benchmarks.
- Accessibility shall be verified by reviewing alternative text for all informative images.

### 11.2 Violations

| Severity | Definition | Action |
|---|---|---|
| Critical | Missing alternative text for informative image | Must be resolved before release |
| Major | Upscaled image in published assets | Must be resolved before merge |
| Minor | Missing resolution variant (e.g., no @3x) | Should be corrected; logged for review |

---

## 12. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 0.1 | 2026-07-31 | Initial draft |

---

*End of S-Image v0.1.*
