# SP-Switch — Switch Specification

**Component ID:** CMP-switch
**Name:** Switch
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Toggle control for binary on/off states. Immediate effect — no form submission required.

## 2. Anatomy

| Part | Required | Type |
|------|----------|------|
| Container | Yes | Root `<label>` |
| Input | Yes | Hidden `<input type="checkbox">` |
| Track | Yes | Background track |
| Thumb | Yes | Sliding circle |
| Label | No | Text slot |

## 3. States

| State | Token Binding |
|-------|---------------|
| Default Off | `TK-color-gray-200` track |
| Default On | `TK-color-primary` track |
| Hover | `TK-opacity-hover` overlay |
| Focus | `TK-color-border-focus` ring |
| Disabled | `TK-opacity-disabled` |

## 4. Design Tokens

| Property | Token |
|----------|-------|
| Track — Off | `TK-color-gray-200` |
| Track — On | `TK-color-primary` |
| Thumb | `TK-color-white` |
| Focus Ring | `TK-color-border-focus` |
| Text | `TK-color-text-primary` |
| Font | `TK-typography-font-primary`, `TK-typography-size-body` |
| Track Width | `TK-spacing-2xl` |
| Track Height | `TK-spacing-lg` |
| Gap | `TK-spacing-sm` |
| Transition | `TK-motion-duration-fast` |
| Disabled Opacity | `TK-opacity-disabled` |
| Hover Overlay | `TK-opacity-hover` |

## 5. Platform

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Switch/switch.css` |

## 6. Version History

| Version | Date |
|---------|------|
| 1.0 | 2026-07-31 |
