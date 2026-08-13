# SP-Textarea — Textarea Specification

**Component ID:** CMP-textarea
**Name:** Textarea
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3 · Operational Laws v0.2

---

## 1. Purpose

The Textarea component provides a multi-line text entry control for paragraphs, descriptions, messages, and any input requiring more than a single line. It extends the Input component's token model for consistent form appearance.

---

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | Wrapping element for label + textarea group |
| Label | No | Text slot | Descriptive label above the textarea |
| TextareaField | Yes | Root element | The `<textarea>` element |
| HelperText | No | Text slot | Supporting hint text |
| ErrorText | No | Text slot | Validation error message |

---

## 3. Variants

| Variant | Category | Token Binding | Description |
|---------|----------|---------------|-------------|
| Default | Style | `TK-color-border` | Standard bordered textarea |
| Filled | Style | `TK-color-gray-50` | Filled background, bottom border |

---

## 4. States

| State | Visual Change | Token Binding | Interaction Blocked? |
|-------|---------------|---------------|---------------------|
| Default | Base appearance | `TK-color-border`, `TK-color-text-primary` | No |
| Hover | Border darken | `TK-color-gray-400` | No |
| Focus | Focus ring, border highlight | `TK-color-border-focus`, `TK-border-width-md` | No |
| Disabled | Reduced opacity, gray bg | `TK-opacity-disabled`, `TK-color-gray-100`, `TK-color-text-disabled` | Yes |
| Read-only | No border highlight | `TK-color-gray-50` | Partial |
| Error | Red border, error text visible | `TK-color-error` | No |

---

## 5. Behaviors

| Event | Trigger | Handler |
|-------|---------|---------|
| onChange | Value changed | User-provided callback |
| onFocus | Textarea receives focus | Focus styling |
| onBlur | Textarea loses focus | Validation may trigger |

---

## 6. Accessibility

- **Role:** `textbox` (multi-line)
- **Accessible Name:** Associated Label via `<label for="id">`
- **Keyboard:** Tab to reach, type to input. No Enter-to-submit (unlike single-line inputs in forms).
- **Screen Reader:** Announces label, value. Error linked via `aria-describedby`.

---

## 7. Design Tokens

| Property | Token |
|----------|-------|
| Text Color | `TK-color-text-primary` |
| Text Color — Disabled | `TK-color-text-disabled` |
| Placeholder Color | `TK-color-gray-400` |
| Background | `TK-color-background` |
| Background — Filled | `TK-color-gray-50` |
| Background — Disabled | `TK-color-gray-100` |
| Border Color | `TK-color-border` |
| Border Color — Focus | `TK-color-border-focus` |
| Border Color — Error | `TK-color-error` |
| Border Width | `TK-border-width-sm` |
| Border Width — Focus | `TK-border-width-md` |
| Border Radius | `TK-radius-md` |
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-body` |
| Font Weight | `TK-typography-weight-regular` |
| Line Height | `TK-typography-lineheight-normal` |
| Label Font Size | `TK-typography-size-small` |
| Label Color | `TK-color-text-secondary` |
| Helper Font Size | `TK-typography-size-caption` |
| Helper Color | `TK-color-text-secondary` |
| Error Color | `TK-color-error` |
| Padding X | `TK-spacing-md` |
| Padding Y | `TK-spacing-sm` |
| Min Height | `TK-spacing-3xl` |
| Transition Duration | `TK-motion-duration-fast` |
| Transition Easing | `TK-motion-easing-default` |
| Disabled Opacity | `TK-opacity-disabled` |

All values SSOT. Per PROP-2026-001.

---

## 8. Platform Mapping

| Platform | Status | Path |
|----------|--------|------|
| HTML + CSS | Supported | `Components/Textarea/textarea.css` |
| React | Planned | `Components/Textarea/Textarea.tsx` |

---

## 9. Dependencies

| Type | ID | Required |
|------|-----|----------|
| Token | `TK-color-text-primary` | Yes |
| Token | `TK-color-text-disabled` | Yes |
| Token | `TK-color-text-secondary` | Yes |
| Token | `TK-color-gray-400` | Yes |
| Token | `TK-color-gray-50` | Conditional |
| Token | `TK-color-gray-100` | Yes |
| Token | `TK-color-background` | Yes |
| Token | `TK-color-border` | Yes |
| Token | `TK-color-border-focus` | Yes |
| Token | `TK-color-error` | Conditional |
| Token | `TK-border-width-sm` | Yes |
| Token | `TK-border-width-md` | Yes |
| Token | `TK-radius-md` | Yes |
| Token | `TK-typography-font-primary` | Yes |
| Token | `TK-typography-size-body` | Yes |
| Token | `TK-typography-size-small` | Yes |
| Token | `TK-typography-size-caption` | Yes |
| Token | `TK-typography-weight-regular` | Yes |
| Token | `TK-typography-lineheight-normal` | Yes |
| Token | `TK-spacing-md` | Yes |
| Token | `TK-spacing-sm` | Yes |
| Token | `TK-spacing-3xl` | Yes |
| Token | `TK-motion-duration-fast` | Yes |
| Token | `TK-motion-easing-default` | Yes |
| Token | `TK-opacity-disabled` | Yes |

---

## 10. Usage Guidelines

- **When to use:** Multi-line free-form text — descriptions, messages, bios, comments.
- **When NOT to use:** Single-line input (use Text Input). Rich text editing (use Rich Text Editor).
- **Best practices:** Set appropriate `rows` attribute for expected content length. Use `resize: vertical` for user resizing. Max-length counter helps prevent overflow.

---

## 11. Validation Rules

| # | Rule |
|---|------|
| V01 | All token references resolve |
| V02 | Label associated via `for`/`id` |
| V03 | No hardcoded values |
| V04 | Component ID follows convention |

---

## 12. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial specification. |

---

*End of SP-Textarea v1.0.*
