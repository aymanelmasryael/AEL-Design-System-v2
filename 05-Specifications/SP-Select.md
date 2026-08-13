# SP-Select — Select Specification

**Component ID:** CMP-select
**Name:** Select
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Dropdown selection from a predefined list. Used for single-value selection among multiple options.

## 2. Anatomy

| Part | Required | Type |
|------|----------|------|
| Container | Yes | Root |
| Label | No | Text slot |
| SelectField | Yes | `<select>` element |
| ChevronIcon | Yes | Icon slot — dropdown arrow |
| HelperText | No | Text slot |
| ErrorText | No | Text slot |

## 3. States

| State | Token Binding |
|-------|---------------|
| Default | `TK-color-border` |
| Hover | `TK-color-gray-400` |
| Focus | `TK-color-border-focus` |
| Disabled | `TK-opacity-disabled` |
| Error | `TK-color-error` |

## 4. Design Tokens

| Property | Token |
|----------|-------|
| Border | `TK-color-border` |
| Focus | `TK-color-border-focus` |
| Error | `TK-color-error` |
| Text | `TK-color-text-primary` |
| Text — Disabled | `TK-color-text-disabled` |
| Background | `TK-color-background` |
| Font | `TK-typography-font-primary`, `TK-typography-size-body` |
| Height | `TK-size-button-md` |
| Padding | `TK-spacing-md` |
| Radius | `TK-radius-md` |
| Chevron | `TK-icon-size-md`, `TK-color-gray-600` |
| Transition | `TK-motion-duration-fast` |
| Disabled | `TK-opacity-disabled`, `TK-color-gray-100` |

## 5. Platform

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Select/select.css` |

## 6. Version History

| Version | Date |
|---------|------|
| 1.0 | 2026-07-31 |
