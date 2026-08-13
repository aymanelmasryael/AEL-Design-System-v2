# SP-Input — Text Input Specification

**Component ID:** CMP-text-input
**Name:** Text Input
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3 · Operational Laws v0.2

---

## 1. Purpose

The Text Input component provides a standardized text entry control for single-line and multi-line user input. It supports labels, placeholder text, helper text, validation states, and icon adornments across all AEL platforms.

---

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | Wrapping element for label + input grouping |
| Label | No | Text slot | Descriptive label above or beside the input |
| InputField | Yes | Root element | The `<input>` or `<textarea>` element |
| LeadingIcon | No | Icon slot | Decorative or semantic icon before text |
| TrailingIcon | No | Icon slot | Action icon (clear, show password, search) |
| HelperText | No | Text slot | Supporting text below the input |
| ErrorText | No | Text slot | Validation error message |

---

## 3. Slots

| Slot Name | Type | Required | Accepted Content | Default Content |
|-----------|------|----------|-----------------|-----------------|
| Label | Text Slot | No | String | None |
| LeadingIcon | Icon Slot | No | Any `AS-icon-*` | None |
| TrailingIcon | Icon Slot | No | Any `AS-icon-*` | None |
| HelperText | Text Slot | No | String | None |
| ErrorText | Text Slot | No | String | None |

---

## 4. Variants

| Variant | Category | Token Binding | Description |
|---------|----------|---------------|-------------|
| Default | Style | `TK-color-border` for border, `TK-color-background` for fill | Standard bordered input |
| Filled | Style | `TK-color-gray-50` for background, bottom border only | Material-style filled input |
| Ghost | Style | No border, transparent background | Minimal inline input |

---

## 5. States

| State | Visual Change | Token Binding | Interaction Blocked? |
|-------|---------------|---------------|---------------------|
| Default | Base appearance | `TK-color-border`, `TK-color-text-primary` | No |
| Hover | Border darken | `TK-color-gray-400` for border | No |
| Focus | Focus ring, border highlight | `TK-color-border-focus`, `TK-border-width-md` | No |
| Disabled | Reduced opacity, gray bg | `TK-opacity-disabled`, `TK-color-gray-100` (bg), `TK-color-text-disabled` | Yes |
| Read-only | No border highlight, cursor default | `TK-color-gray-50` (bg) | Partial — selectable, not editable |
| Error | Red border, error text visible | `TK-color-error` for border | No |
| Success | Green border | `TK-color-success` for border | No |

---

## 6. Behaviors

| Event | Trigger | Handler | Platform Notes |
|-------|---------|---------|---------------|
| onChange | Value changed by user input | User-provided callback | Debounce recommended for search |
| onFocus | Input receives focus | Focus styling applied | |
| onBlur | Input loses focus | Validation may trigger | |
| onKeyDown | Key pressed | Enter may submit form | Escape may clear or blur |

---

## 7. Accessibility

- **Role:** `textbox` (single-line) or `<textarea>` (multi-line)
- **Accessible Name:** Derived from associated Label or `aria-label` prop. Label must use `<label for="id">` association.
- **Keyboard:** Tab to reach, type to input. Escape to clear or blur.
- **Screen Reader:** Announces label, current value, character count. Announces error state and error message via `aria-describedby` linking to ErrorText.
- **Contrast:** Text meets WCAG 2.1 AA. Placeholder text meets 4.5:1 minimum.

---

## 8. Design Tokens

| Property | Token |
|----------|-------|
| Text Color | `TK-color-text-primary` |
| Text Color — Disabled | `TK-color-text-disabled` |
| Placeholder Color | `TK-color-gray-400` |
| Background | `TK-color-background` |
| Background — Filled | `TK-color-gray-50` |
| Background — Disabled | `TK-color-gray-100` |
| Border Color | `TK-color-border` |
| Border Color — Hover | `TK-color-gray-400` |
| Border Color — Focus | `TK-color-border-focus` |
| Border Color — Error | `TK-color-error` |
| Border Color — Success | `TK-color-success` |
| Border Width | `TK-border-width-sm` |
| Border Width — Focus | `TK-border-width-md` |
| Border Radius | `TK-radius-md` |
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-body` |
| Font Weight | `TK-typography-weight-regular` |
| Label Font Size | `TK-typography-size-small` |
| Label Color | `TK-color-text-secondary` |
| Helper Text Font Size | `TK-typography-size-caption` |
| Helper Text Color | `TK-color-text-secondary` |
| Error Text Color | `TK-color-error` |
| Padding X | `TK-spacing-md` |
| Padding Y | `TK-spacing-sm` |
| Icon Size | `TK-icon-size-md` |
| Icon Color | `TK-color-gray-600` |
| Height | `TK-size-button-md` |
| Transition Duration | `TK-motion-duration-fast` |
| Transition Easing | `TK-motion-easing-default` |
| Disabled Opacity | `TK-opacity-disabled` |

All values are SSOT in `06-Implementation/tokens/`. Per PROP-2026-001.

---

## 9. Assets

| Slot / Usage | Asset ID | Asset Source | Fallback |
|-------------|----------|-------------|----------|
| LeadingIcon | Any `AS-icon-*` | `icons/{name}.svg` | No icon |
| TrailingIcon | Any `AS-icon-*` | `icons/{name}.svg` | No icon |

---

## 10. Size Scale

The Input component uses a single height token matching the Button MD size for visual consistency in forms. Multi-line (Textarea) height is determined by a `rows` property, not a size token.

---

## 11. Platform Mapping

| Platform | Status | Implementation Path |
|----------|--------|--------------------|
| HTML + CSS | Supported | `Components/Input/input.css` |
| React | Planned | `Components/Input/Input.tsx` |
| Vue | Planned | `Components/Input/Input.vue` |
| SwiftUI | Planned | `Components/Input/Input.swift` |
| Flutter | Planned | `Components/Input/input.dart` |
| Android | Planned | `Components/Input/Input.kt` |
| Figma | Planned | `platforms/figma/` |
| Canva | Planned | `platforms/canva/` |

---

## 12. Dependencies

| Dependency Type | ID | Required |
|----------------|-----|----------|
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
| Token | `TK-color-success` | Conditional |
| Token | `TK-border-width-sm` | Yes |
| Token | `TK-border-width-md` | Yes |
| Token | `TK-radius-md` | Yes |
| Token | `TK-typography-font-primary` | Yes |
| Token | `TK-typography-size-body` | Yes |
| Token | `TK-typography-size-small` | Yes |
| Token | `TK-typography-size-caption` | Yes |
| Token | `TK-typography-weight-regular` | Yes |
| Token | `TK-spacing-md` | Yes |
| Token | `TK-spacing-sm` | Yes |
| Token | `TK-icon-size-md` | Conditional |
| Token | `TK-color-gray-600` | Conditional |
| Token | `TK-size-button-md` | Yes |
| Token | `TK-motion-duration-fast` | Yes |
| Token | `TK-motion-easing-default` | Yes |
| Token | `TK-opacity-disabled` | Yes |

---

## 13. Usage Guidelines

- **When to use:** For free-form text entry — names, emails, passwords, search queries, descriptions.
- **When NOT to use:** For selecting from predefined options (use Select). For toggling boolean values (use Checkbox or Switch). For numeric constrained input (use Number Input).
- **Best practices:**
  1. Always provide a visible Label. Placeholder is not a replacement for a label.
  2. Use HelperText for format guidance (e.g., "Must be at least 8 characters").
  3. ErrorText must describe how to fix the error, not just that an error occurred.
  4. Match input width to expected content length.

---

## 14. Examples

### HTML + CSS

```html
<div class="ael-input">
  <label class="ael-input__label" for="email">Email</label>
  <div class="ael-input__wrapper">
    <svg class="ael-input__icon ael-input__icon--leading">...</svg>
    <input class="ael-input__field" id="email" type="email" placeholder="you@example.com">
  </div>
  <span class="ael-input__helper">We will never share your email.</span>
</div>
```

### React

```jsx
<Input label="Email" type="email" placeholder="you@example.com"
  leadingIcon="mail" helperText="We will never share your email." />
```

### SwiftUI

```swift
AELInput(label: "Email", placeholder: "you@example.com",
  leadingIcon: .mail, helperText: "We will never share your email.")
```

---

## 15. Validation Rules

| # | Rule | Validator |
|---|------|-----------|
| V01 | All token references resolve | Token Validator |
| V02 | Label is associated with input via `for`/`id` | Accessibility Audit |
| V03 | Error state links to ErrorText via `aria-describedby` | Accessibility Audit |
| V04 | No hardcoded values in implementation | SSOT Validator |
| V05 | Component ID follows naming convention | Token Validator |

---

## 16. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial Input specification per SP-Component v1.2. |

---

*End of SP-Input v1.0.*
