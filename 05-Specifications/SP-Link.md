# SP-Link — Link Specification

**Component ID:** CMP-link
**Name:** Link
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Navigational or action hyperlink. For inline text links, standalone CTAs, and navigation items.

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| LinkElement | Yes | Root element | `<a>` element |
| LeadingIcon | No | Icon slot | Icon before text |
| TrailingIcon | No | Icon slot | Icon after text |

## 3. Variants

| Variant | Category | Token Binding |
|---------|----------|---------------|
| Default | Style | `TK-color-primary` for text |
| Subtle | Style | `TK-color-text-secondary` for text |
| Button | Style | Matches Button secondary tokens |

## 4. States

| State | Token Binding |
|-------|---------------|
| Default | `TK-color-primary` |
| Hover | `TK-color-primary-hover` + underline |
| Visited | `TK-color-secondary` |
| Focus | `TK-color-border-focus` outline |

## 5. Design Tokens

| Property | Token |
|----------|-------|
| Text Color | `TK-color-primary` |
| Text Hover | `TK-color-primary-hover` |
| Text Visited | `TK-color-secondary` |
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-body` |
| Font Weight | `TK-typography-weight-medium` |
| Focus Ring | `TK-color-border-focus` |
| Transition | `TK-motion-duration-fast` |

## 6. Platform Mapping

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Link/link.css` |

## 7. Dependencies

| Type | ID | Required |
|------|-----|----------|
| Token | `TK-color-primary` | Yes |
| Token | `TK-color-primary-hover` | Yes |
| Token | `TK-color-secondary` | Yes |
| Token | `TK-typography-font-primary` | Yes |
| Token | `TK-typography-size-body` | Yes |
| Token | `TK-typography-weight-medium` | Yes |
| Token | `TK-color-border-focus` | Yes |
| Token | `TK-motion-duration-fast` | Yes |

## 8. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial specification. |
