# SP-Checkbox — Checkbox Specification

**Component ID:** CMP-checkbox
**Name:** Checkbox
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Binary selection control. Used for multi-select lists, agreement confirmations, and toggling independent options.

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | `<label>` wrapping input + mark + label |
| Input | Yes | Hidden input | `<input type="checkbox">` — visually hidden |
| CheckMark | Yes | Visual indicator | Checkmark box (border, fill, check icon) |
| Label | No | Text slot | Descriptive text |

## 3. States

| State | Token Binding |
|-------|---------------|
| Default | `TK-color-border` border, transparent fill |
| Hover | `TK-color-gray-100` background |
| Focus | `TK-color-border-focus` ring |
| Checked | `TK-color-primary` fill, check icon white |
| Disabled | `TK-opacity-disabled`, `TK-color-gray-200` |
| Error | `TK-color-error` border |

## 4. Design Tokens

| Property | Token |
|----------|-------|
| Border | `TK-color-border` |
| Fill — Checked | `TK-color-primary` |
| Focus Ring | `TK-color-border-focus` |
| Error | `TK-color-error` |
| Hover Bg | `TK-color-gray-100` |
| Text | `TK-color-text-primary` |
| Text — Disabled | `TK-color-text-disabled` |
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-body` |
| Size | `TK-icon-size-md` |
| Border Radius | `TK-radius-sm` |
| Gap | `TK-spacing-sm` |
| Transition | `TK-motion-duration-fast` |
| Disabled Opacity | `TK-opacity-disabled` |

## 5. Platform Mapping

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Checkbox/checkbox.css` |

## 6. Dependencies

Token: `TK-color-border`, `TK-color-primary`, `TK-color-border-focus`, `TK-color-error`, `TK-color-gray-100`, `TK-color-text-primary`, `TK-color-text-disabled`, `TK-typography-font-primary`, `TK-typography-size-body`, `TK-icon-size-md`, `TK-radius-sm`, `TK-spacing-sm`, `TK-motion-duration-fast`, `TK-opacity-disabled`.

## 7. Version History

| Version | Date |
|---------|------|
| 1.0 | 2026-07-31 |
