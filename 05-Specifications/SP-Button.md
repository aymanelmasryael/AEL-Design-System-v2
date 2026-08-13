# SP-Button — Button Specification

**Component ID:** CMP-button
**Name:** Button
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3 · S-Button · Operational Laws v0.2

---

## 1. Purpose

The Button component provides a standardized interactive control for triggering user actions. It is the primary mechanism for submitting forms, navigating, and initiating operations across all AEL platforms.

---

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | Clickable/tappable surface — `<button>`, `Button`, etc. |
| Label | Yes | Text slot | The button's visible text or accessible name |
| LeadingIcon | No | Icon slot | Icon displayed before the label |
| TrailingIcon | No | Icon slot | Icon displayed after the label |
| LoadingIndicator | No | Indicator slot | Spinner or progress indicator shown during loading state |

---

## 3. Slots

| Slot Name | Type | Required | Accepted Content | Default Content |
|-----------|------|----------|-----------------|-----------------|
| Label | Text Slot | Yes | Plain text string, or accessible label if icon-only | — |
| LeadingIcon | Icon Slot | No | Any `AS-icon-*` asset reference | None |
| TrailingIcon | Icon Slot | No | Any `AS-icon-*` asset reference | None |
| LoadingIndicator | Indicator Slot | No | Platform-native loading indicator | Spinner |

---

## 4. Variants

| Variant | Category | Token Binding | Description |
|---------|----------|---------------|-------------|
| Primary | Role | `TK-color-primary` (bg), `TK-color-text-inverse` (text) | Default call-to-action. Highest emphasis. One per context. |
| Secondary | Role | `TK-color-secondary` (bg), `TK-color-text-inverse` (text) | Supporting action. Lower emphasis than primary. |
| Outline | Style | `TK-color-border` (border), transparent background, `TK-color-text-primary` (text) | Medium emphasis. Borders with no fill. |
| Ghost | Style | Transparent background, `TK-color-text-primary` (text) | Low emphasis. No border, no background until hover. |
| Text | Style | Transparent, `TK-color-primary` (text), no padding (inline) | Minimal emphasis. Inline with text content. |
| Danger | Role | `TK-color-error` (bg), `TK-color-text-inverse` (text) | Destructive action. Delete, remove, irreversible. |
| Success | Role | `TK-color-success` (bg), `TK-color-text-inverse` (text) | Confirmation action. Save, confirm, approve. |

---

## 5. States

| State | Visual Change | Token Binding | Interaction Blocked? |
|-------|---------------|---------------|---------------------|
| Default | Base appearance per variant | Variant tokens | No |
| Hover | Overlay darken | `TK-opacity-hover` on background | No |
| Focus | Visible focus ring | `TK-color-border-focus`, `TK-border-width-md` | No |
| Active / Pressed | Overlay darken (deeper) | `TK-opacity-pressed` on background | No |
| Disabled | Reduced opacity, gray background | `TK-opacity-disabled`, `TK-color-gray-200` (bg), `TK-color-gray-500` (text) | Yes |
| Loading | LoadingIndicator visible, label hidden, interaction blocked | `TK-motion-duration-fast` for spinner animation | Yes |

State transitions use `TK-motion-duration-fast` and `TK-motion-easing-default`.

---

## 6. Behaviors

| Event | Trigger | Handler | Platform Notes |
|-------|---------|---------|---------------|
| onClick | Mouse click, tap, Enter/Space key | User-provided `onClick` callback | Prevented during disabled and loading states |
| onFocus | Tab focus, click focus | Browser / platform focus | Visible focus ring |
| onBlur | Focus leaves element | Browser / platform blur | Remove focus ring |
| onKeyDown | Keyboard interaction | Enter or Space to activate | Standard button keyboard behavior |
| onSubmit | Form submission (if type="submit") | Browser form submit | Prevent duplicate submission during loading |

---

## 7. Accessibility

- **Role:** `button`
- **Accessible Name:** Derived from Label slot text. If icon-only button, use `aria-label` prop.
- **Keyboard:** Tab to reach, Enter or Space to activate. Disabled and loading states remove from tab order via `tabindex="-1"` or `disabled` attribute.
- **Screen Reader:** Announces label. Announces "loading" during loading state via `aria-busy="true"`. Announces disabled state via `aria-disabled`.
- **Contrast:** All variant text colors meet WCAG 2.1 AA (4.5:1 normal, 3:1 large). Focus ring visible against all backgrounds.

---

## 8. Design Tokens

| Property | Token | Notes |
|----------|-------|-------|
| Background — Primary | `TK-color-primary` | |
| Background — Secondary | `TK-color-secondary` | |
| Background — Danger | `TK-color-error` | |
| Background — Success | `TK-color-success` | |
| Text — filled variants | `TK-color-text-inverse` | |
| Text — outline/ghost/text | `TK-color-text-primary` | |
| Text — disabled | `TK-color-text-disabled` | |
| Font Family | `TK-typography-font-primary` | |
| Font Size | `TK-typography-size-body` | |
| Font Weight | `TK-typography-weight-medium` | |
| Border Radius | `TK-radius-md` | |
| Border — outline variant | `TK-color-border` | |
| Focus Ring Color | `TK-color-border-focus` | |
| Focus Ring Width | `TK-border-width-md` | |
| Padding X | `TK-spacing-lg` | |
| Padding Y | `TK-spacing-sm` | |
| Icon Size | `TK-icon-size-md` | |
| Icon–Label Gap | `TK-spacing-xs` | |
| Hover Overlay | `TK-opacity-hover` | |
| Pressed Overlay | `TK-opacity-pressed` | |
| Disabled Opacity | `TK-opacity-disabled` | |
| Transition Duration | `TK-motion-duration-fast` | |
| Transition Easing | `TK-motion-easing-default` | |
| Shadow — Default | `TK-shadow-sm` | Subtle elevation |
| Shadow — Hover | `TK-shadow-md` | |

All values are SSOT in `06-Implementation/tokens/`. This table declares token bindings only. Concrete values appear exclusively in generated platform outputs. Per PROP-2026-001 (DD06).

---

## 9. Assets

| Slot / Usage | Asset ID | Asset Source | Fallback |
|-------------|----------|-------------|----------|
| LeadingIcon | Any `AS-icon-*` | `icons/{name}.svg` | Text-only button (no icon) |
| TrailingIcon | Any `AS-icon-*` | `icons/{name}.svg` | Text-only button (no icon) |
| LoadingIndicator | Platform-native | Spinner component | CSS animation |

---

## 10. Size Scale

| Size | Token | Usage |
|------|-------|-------|
| XS | `TK-size-button-xs` | Inline actions, table rows |
| SM | `TK-size-button-sm` | Compact forms, card footers |
| MD | `TK-size-button-md` | Default. Primary page actions. |
| LG | `TK-size-button-lg` | Hero CTAs, prominent actions |
| XL | `TK-size-button-xl` | Landing pages, marketing |

All sizes use `TK-radius-md` for border radius and `TK-typography-weight-medium` for font weight. Height, padding, and font size values are defined in Implementation token files and resolved at build time.

---

## 11. Platform Mapping

| Platform | Status | Implementation Path | Notes |
|----------|--------|--------------------|-------|
| HTML + CSS | Supported | `Components/Button/button.html` + `button.css` | First implementation |
| React | Planned | `Components/Button/Button.tsx` | |
| Vue | Planned | `Components/Button/Button.vue` | |
| Angular | Planned | `Components/Button/button.component.ts` | |
| SwiftUI | Planned | `Components/Button/Button.swift` | |
| Flutter | Planned | `Components/Button/button.dart` | |
| Android | Planned | `Components/Button/Button.kt` | |
| Figma | Planned | `platforms/figma/figma-tokens.json` | Via token export |
| Canva | Planned | `platforms/canva/` | |

---

## 12. Dependencies

| Dependency Type | ID | Required | Notes |
|----------------|-----|----------|-------|
| Token | `TK-color-primary` | Yes | Primary variant background |
| Token | `TK-color-primary-hover` | Yes | Darkened hover variant |
| Token | `TK-color-primary-active` | Yes | Darkened active variant |
| Token | `TK-color-secondary` | Conditional | Secondary variant |
| Token | `TK-color-error` | Conditional | Danger variant |
| Token | `TK-color-success` | Conditional | Success variant |
| Token | `TK-color-text-inverse` | Yes | Text on filled backgrounds |
| Token | `TK-color-text-primary` | Yes | Text on light backgrounds |
| Token | `TK-color-text-disabled` | Yes | Disabled text |
| Token | `TK-color-border` | Conditional | Outline variant |
| Token | `TK-color-border-focus` | Yes | Focus ring |
| Token | `TK-border-width-md` | Yes | Focus ring width |
| Token | `TK-radius-md` | Yes | Border radius |
| Token | `TK-typography-font-primary` | Yes | Font family |
| Token | `TK-typography-size-body` | Yes | Default font size |
| Token | `TK-typography-weight-medium` | Yes | Font weight |
| Token | `TK-spacing-lg` | Yes | Horizontal padding |
| Token | `TK-spacing-sm` | Yes | Vertical padding |
| Token | `TK-spacing-xs` | Yes | Icon–label gap |
| Token | `TK-icon-size-md` | Conditional | When icon present |
| Token | `TK-size-button-md` | Yes | Default height |
| Token | `TK-shadow-sm` | Yes | Default elevation |
| Token | `TK-shadow-md` | Yes | Hover elevation |
| Token | `TK-opacity-hover` | Yes | Hover state |
| Token | `TK-opacity-pressed` | Yes | Active state |
| Token | `TK-opacity-disabled` | Yes | Disabled state |
| Token | `TK-motion-duration-fast` | Yes | Transition speed |
| Token | `TK-motion-easing-default` | Yes | Transition curve |

---

## 13. Usage Guidelines

- **When to use:** For triggering a single action — form submission, navigation, dialog confirmation, CRUD operations.
- **When NOT to use:** For navigation between pages (use Link). For toggling state (use Switch or Checkbox). For selecting from a list (use Select). For file uploads (use Input type=file).
- **Best practices:**
  1. Use exactly one Primary button per view/context.
  2. Label text must be a verb or verb phrase (Save, Delete, Send Message).
  3. Icon-only buttons must have an accessible label via `aria-label`.
  4. Never disable a button without showing why (use tooltip or helper text).

---

## 14. Examples

### HTML + CSS

```html
<!-- Primary Button, Medium size -->
<button class="ael-button ael-button--primary ael-button--md">
  Save Changes
</button>

<!-- Outline Button with Leading Icon, Small size -->
<button class="ael-button ael-button--outline ael-button--sm">
  <svg class="ael-button__icon ael-button__icon--leading" aria-hidden="true">
    <use href="#icon-plus"></use>
  </svg>
  Add Item
</button>

<!-- Icon-only Ghost Button, Medium size -->
<button class="ael-button ael-button--ghost ael-button--md ael-button--icon-only" aria-label="Search">
  <svg class="ael-button__icon" aria-hidden="true">
    <use href="#icon-search"></use>
  </svg>
</button>

<!-- Disabled Button -->
<button class="ael-button ael-button--primary ael-button--md" disabled>
  Submit
</button>

<!-- Loading Button -->
<button class="ael-button ael-button--primary ael-button--md ael-button--loading" aria-busy="true" disabled>
  <span class="ael-button__spinner"></span>
  <span class="ael-button__label">Saving...</span>
</button>
```

### React

```jsx
<Button variant="primary" size="md" onClick={handleSave}>
  Save Changes
</Button>

<Button variant="outline" size="sm" leadingIcon="plus" onClick={handleAdd}>
  Add Item
</Button>

<Button variant="ghost" size="md" icon="search" aria-label="Search" />

<Button variant="primary" size="md" disabled>
  Submit
</Button>

<Button variant="primary" size="md" loading loadingText="Saving..." />
```

### SwiftUI

```swift
AELButton("Save Changes", variant: .primary, size: .md) {
    handleSave()
}

AELButton("Add Item", variant: .outline, size: .sm, leadingIcon: .plus) {
    handleAdd()
}

AELButton(variant: .ghost, size: .md, icon: .search, label: "Search")

AELButton("Submit", variant: .primary, size: .md)
    .disabled(true)

AELButton(variant: .primary, size: .md, isLoading: true, loadingText: "Saving...")
```

---

## 15. Validation Rules

| # | Rule | Validator |
|---|------|-----------|
| V01 | All 28 token references resolve to existing tokens in the SSOT | Token Validator |
| V02 | All variant color combinations meet WCAG 2.1 AA contrast (4.5:1) | Accessibility Audit |
| V03 | Component ID `CMP-button` follows naming convention | Token Validator |
| V04 | Focus ring visible on all variant backgrounds | Manual Review |
| V05 | Loading state blocks interaction and is announced to screen readers | Accessibility Audit |
| V06 | Icon-only buttons have accessible labels | Accessibility Audit |
| V07 | No hardcoded hex, px, or color values in any implementation file | SSOT Validator |

---

## 16. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | 2026-07-31 | Initial Button specification per SP-Component v1.2 framework. 28 token dependencies. 7 variants. 6 states. 5 sizes. |

---

*End of SP-Button v1.0.*
