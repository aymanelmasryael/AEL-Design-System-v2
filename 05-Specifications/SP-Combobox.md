# SP-Combobox — Combobox Specification

**Component ID:** CMP-combobox
**Name:** Combobox
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3

---

## 1. Purpose

Combines text input with a dropdown selection list. User types to filter options or selects from the list. Supports single and multi-select.

## 2. Anatomy

| Part | Required | Type |
|------|----------|------|
| Container | Yes | Root |
| Label | No | Text slot |
| InputField | Yes | Text input for filter |
| ChevronIcon | Yes | Dropdown toggle icon |
| OptionsList | Yes | Filtered option list |
| OptionItem | Yes | Individual option |
| HelperText | No | Text slot |

## 3. States

| State | Token Binding |
|-------|---------------|
| Default | `TK-color-border` |
| Focus | `TK-color-border-focus` |
| Open | Options list visible, chevron rotated |
| Disabled | `TK-opacity-disabled` |
| Error | `TK-color-error` |
| Highlighted | `TK-color-gray-100` option bg |

## 4. Design Tokens

Shares Input and Select token model. Additional:

| Property | Token |
|----------|-------|
| Option Hover | `TK-color-gray-100` |
| Option Selected | `TK-color-primary` (checkmark) |
| Option Padding | `TK-spacing-sm` `TK-spacing-md` |
| List Shadow | `TK-shadow-lg` |
| List Radius | `TK-radius-md` |
| List Max Height | `TK-spacing-5xl` |
| Chevron Transition | `TK-motion-duration-fast` |

## 5. Platform

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Combobox/combobox.css` |

## 6. Version History

| Version | Date |
|---------|------|
| 1.0 | 2026-07-31 |
