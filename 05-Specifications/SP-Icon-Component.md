# SP-Icon — Icon Component Specification

**Component ID:** CMP-icon
**Name:** Icon
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3 · S-Icon

---

## 1. Purpose

Renders an SVG icon from the AEL Asset System. Wraps canonical icon assets with size, color, and accessibility bindings.

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| SvgElement | Yes | Root element | `<svg>` element from asset |

## 3. Design Tokens

| Property | Token |
|----------|-------|
| Default Size | `TK-icon-size-md` |
| Color | `currentColor` inherited from parent |
| Stroke Width | `TK-icon-stroke-width-md` |

## 4. Sizes

| Size | Token |
|------|-------|
| SM | `TK-icon-size-sm` |
| MD | `TK-icon-size-md` |
| LG | `TK-icon-size-lg` |
| XL | `TK-icon-size-xl` |

## 5. Platform Mapping

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Icon/icon.css` |

## 6. Dependencies

| Type | ID | Required |
|------|-----|----------|
| Token | `TK-icon-size-md` | Yes |
| Token | `TK-icon-size-sm` | Yes |
| Token | `TK-icon-size-lg` | Yes |
| Token | `TK-icon-size-xl` | Yes |
| Asset | `AS-icon-*` | Context-dependent |

## 7. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial specification. |
