# S-Spacing — Spacing Standard

**Version:** 0.2
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.2 · Operational Laws v0.2
**Classification:** Standard — Level 3

---

## 1. Purpose

This standard defines the spacing philosophy and rules for the AEL Design System.

It establishes a unified spacing methodology that ensures consistency, scalability, readability, and predictable layouts across all digital and print products.

This standard governs rules and methodology only. It does not carry concrete px values. All concrete values are defined in `06-Implementation/tokens/spacing.json` (the Single Source of Truth per PROP-2026-001).

---

## 2. Objectives

- Create a consistent visual rhythm.
- Improve readability.
- Standardize spacing across products.
- Support responsive interfaces.
- Enable reusable components.

---

## 3. Core Principles

- Consistency First
- Visual Rhythm
- Modular Scaling
- Responsive by Design
- Accessibility by Default

---

## 4. Spacing Model

The AEL Design System adopts an 8-point spacing methodology.

**Base Unit:** Defined by `TK-spacing-sm`.

**Half Unit:** Defined by `TK-spacing-xs`.

All spacing shall be derived from this base unit. Arbitrary spacing values are prohibited unless explicitly approved.

---

## 5. Approved Scale

| Token | Description |
|---|---|
| `TK-spacing-xs` | Extra small — icon padding, tight inline spacing |
| `TK-spacing-sm` | Small — component inner padding, compact layouts |
| `TK-spacing-md` | Medium — default component padding, card insets |
| `TK-spacing-lg` | Large — section padding, component separation |
| `TK-spacing-xl` | Extra large — layout gaps, major section spacing |
| `TK-spacing-2xl` | 2XL — page margins, large container padding |
| `TK-spacing-3xl` | 3XL — hero section padding, major layout blocks |
| `TK-spacing-4xl` | 4XL — page-level spacing |
| `TK-spacing-5xl` | 5XL — large section separation |
| `TK-spacing-6xl` | 6XL — major layout spacing |
| `TK-spacing-7xl` | 7XL — maximum layout spacing |
| `TK-spacing-8xl` | 8XL — ultra large separation |

---

## 6. Usage

Spacing shall be used consistently for:

- Margins
- Padding
- Grid Gutters
- Section Spacing
- Component Spacing
- Icon Spacing
- Form Layouts
- Card Layouts

---

## 7. Responsive Rules

Spacing may scale proportionally across:

- Mobile
- Tablet
- Desktop
- Large Displays

The spacing hierarchy shall remain consistent across all breakpoints.

---

## 8. Accessibility

Spacing shall improve readability, touch interaction, and visual clarity while reducing cognitive load.

---

## 9. Cross-Platform Compatibility

Applicable to:

- CSS
- HTML
- SwiftUI
- Android
- Figma
- Canva

---

## 10. Related Specifications

- SP-Spacing

---

## 11. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-30 | Initial spacing standard |
| 0.2 | 2026-07-31 | Removed concrete px values (migrated to Implementation SSOT per PROP-2026-001). Replaced with token ID references. |

---

*End of S-Spacing v0.2.*
