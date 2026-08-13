# SP-Radio — Radio Specification

**Component ID:** CMP-radio
**Name:** Radio
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Single-selection control within a group. Only one radio in a named group can be selected at a time.

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root | `<label>` wrapping input + mark + label |
| Input | Yes | Hidden | `<input type="radio">` |
| RadioMark | Yes | Visual | Circular selector |
| Label | No | Text slot | Descriptive text |

## 3. States

| State | Token Binding |
|-------|---------------|
| Default | `TK-color-border` border |
| Hover | `TK-color-gray-100` bg |
| Focus | `TK-color-border-focus` ring |
| Selected | `TK-color-primary` inner dot |
| Disabled | `TK-opacity-disabled` |

## 4. Design Tokens

| Property | Token |
|----------|-------|
| Border | `TK-color-border` |
| Fill — Selected | `TK-color-primary` |
| Focus Ring | `TK-color-border-focus` |
| Hover Bg | `TK-color-gray-100` |
| Text | `TK-color-text-primary` |
| Text — Disabled | `TK-color-text-disabled` |
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-body` |
| Size | `TK-icon-size-md` |
| Gap | `TK-spacing-sm` |
| Transition | `TK-motion-duration-fast` |
| Disabled Opacity | `TK-opacity-disabled` |

## 5. Platform Mapping

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Radio/radio.css` |

## 6. Dependencies

Token: `TK-color-border`, `TK-color-primary`, `TK-color-border-focus`, `TK-color-gray-100`, `TK-color-text-primary`, `TK-color-text-disabled`, `TK-typography-font-primary`, `TK-typography-size-body`, `TK-icon-size-md`, `TK-spacing-sm`, `TK-motion-duration-fast`, `TK-opacity-disabled`.

## 7. Version History

| Version | Date |
|---------|------|
| 1.0 | 2026-07-31 |
