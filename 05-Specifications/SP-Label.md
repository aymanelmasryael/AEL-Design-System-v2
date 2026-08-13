# SP-Label — Label Specification

**Component ID:** CMP-label
**Name:** Label
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Associates descriptive text with form controls. Used with Input, Textarea, Select, Checkbox, Radio, and Switch components.

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| LabelElement | Yes | Root element | `<label>` element with `for` attribute |

## 3. Design Tokens

| Property | Token |
|----------|-------|
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-small` |
| Font Weight | `TK-typography-weight-medium` |
| Color | `TK-color-text-secondary` |

## 4. Platform Mapping

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Label/label.css` |

## 5. Dependencies

| Type | ID | Required |
|------|-----|----------|
| Token | `TK-typography-font-primary` | Yes |
| Token | `TK-typography-size-small` | Yes |
| Token | `TK-typography-weight-medium` | Yes |
| Token | `TK-color-text-secondary` | Yes |

## 6. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial specification. |
