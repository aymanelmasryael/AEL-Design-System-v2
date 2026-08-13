# S-Component — Component Meta Model

**Version:** 0.3
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Constitution v0.2 · Operational Laws v0.2
**Classification:** Standard — Level 3 | Component Model Definition

---

## 1. Purpose

This standard defines the conceptual model for every UI Component in the AEL Design System. It establishes the universal rules for component structure, states, variants, behavior, accessibility, token consumption, lifecycle, and versioning.

Every component entity, specification, and implementation must conform to this model. A violation of this standard is a violation of the Constitution.

This standard governs WHAT a component is and HOW it is structured. It does not define the values, styles, or platform-specific rendering of any specific component.

---

## 2. Component Definition

### 2.1 What Is a Component

A Component is a reusable, self-contained UI unit with:

| Property | Description |
|----------|-------------|
| **Identity** | A unique identifier (`CMP-{name}`) independent of its visual appearance or location |
| **Purpose** | A single, well-defined user-facing function |
| **Boundary** | A defined interface (properties in, events out) that isolates internal behavior |
| **Lifecycle** | It can be created, referenced, modified, versioned, deprecated, and archived |
| **Portability** | It renders correctly across all supported platforms without platform-specific redefinition of its core logic |

### 2.2 What Is NOT a Component

| Concept | Classification | Reason |
|---------|---------------|--------|
| A set of CSS rules without behavior | Style rule | A component encapsulates style AND behavior |
| A single HTML element with a class | Element instance | A component is a composition, not a primitive |
| A page-level layout (header, sidebar) | Layout / Template region | Layouts assemble components; they are not components themselves |
| A recurring content arrangement (product grid) | Pattern | Patterns are compositional; see §2.3 |
| A complete page structure | Template | Templates compose layouts and components; see §2.3 |

### 2.3 Component vs Pattern vs Template

| Entity | Definition | Example | ID Prefix |
|--------|-----------|---------|-----------|
| **Component** | A single reusable UI unit with defined behavior | Button, Input, Modal, Card | `CMP-` |
| **Pattern** | A recurring composition of multiple components solving a common UX scenario | SearchBar (Input + Button), FilterPanel (Checkboxes + Select + Button) | Not in v0.3 scope |
| **Template** | A complete page-level assembly of components and layouts | LoginPage, DashboardLayout, Settings | `TPL-` |

**Rule:** A component must not embed another component's core logic. Composition is achieved through slots (§5), not through inheritance or nesting of component internals.

---

## 3. Component Anatomy

Every component shall define its anatomy — the named structural parts that constitute it. Anatomy is the blueprint of a component's internal structure.

### 3.1 Anatomy Rules

| # | Rule |
|---|------|
| A01 | Every component must declare its anatomy explicitly |
| A02 | Each anatomical part must have a unique name within the component |
| A03 | Each part must declare whether it is required or optional |
| A04 | The root container is always required |

### 3.2 Anatomy Example — Button

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | The clickable/tappable surface |
| Label | Yes | Text slot | The button's text content |
| LeadingIcon | No | Icon slot | Icon before the label |
| TrailingIcon | No | Icon slot | Icon after the label |
| LoadingIndicator | No | Indicator slot | Spinner shown during loading state |

### 3.3 Anatomy Example — Card

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | The card surface |
| Header | No | Slot | Title area |
| Media | No | Slot | Image or illustration |
| Body | Yes | Content slot | Primary card content |
| Footer | No | Slot | Action area |
| CloseButton | No | Button slot | Dismiss control |

---

## 4. Component States

Every component shall define its possible states. A state is a condition that affects the component's visual presentation or interactive behavior.

### 4.1 Universal State Categories

| # | State | Trigger | Visual Effect |
|---|-------|---------|---------------|
| S01 | Default | Initial render | Base appearance |
| S02 | Hover | Pointer enters | `TK-opacity-hover` overlay |
| S03 | Focus | Keyboard or click focus | `TK-color-border-focus` ring |
| S04 | Active / Pressed | Pointer down | `TK-opacity-pressed` overlay |
| S05 | Disabled | `disabled` property true | `TK-opacity-disabled`, non-interactive |
| S06 | Loading | Async operation in progress | LoadingIndicator visible, interaction blocked |
| S07 | Error | Validation or system error | Error styling, error message |
| S08 | Success | Validation or operation success | Success styling |
| S09 | Selected | Selection state true | Selected indicator |
| S10 | Read-only | `readOnly` property true | Non-editable visual treatment |

### 4.2 State Rules

| # | Rule |
|---|------|
| S11 | A component must support at minimum: Default, Hover, Focus, Disabled |
| S12 | Interactive components (buttons, inputs, selects) must support: Default, Hover, Focus, Active, Disabled, Loading |
| S13 | A state transition must use motion tokens (`TK-motion-duration-*`, `TK-motion-easing-*`) |
| S14 | State changes must never cause layout shift |
| S15 | Focus state must have a visible indicator — never `outline: none` without a replacement |

---

## 5. Component Slots

A slot is a placeholder within a component where content, icons, or other elements may be injected.

### 5.1 Slot Types

| Type | Behavior | Example |
|------|----------|---------|
| Content Slot | Accepts arbitrary content (text, HTML, other components) | Card body, Modal content |
| Text Slot | Accepts text only | Button label, Input placeholder |
| Icon Slot | Accepts an icon asset (`AS-icon-*`) | LeadingIcon, TrailingIcon |
| Indicator Slot | Accepts a status indicator | Loading spinner, Badge dot |
| Action Slot | Accepts an interactive element | Card footer actions, Modal close |

### 5.2 Slot Rules

| # | Rule |
|---|------|
| SL01 | Every slot must have a unique name within the component |
| SL02 | A slot must declare whether it is required or optional |
| SL03 | A slot must declare its accepted content type |
| SL04 | An empty optional slot must not render any DOM or consume layout space |
| SL05 | Slot content must never break the component's internal layout |

---

## 6. Component Variants

A variant is a named visual or functional alternative of a component. Variants share the same anatomy and behavior but differ in presentation or role.

### 6.1 Variant Categories

| Category | Example Values | Affects |
|----------|---------------|---------|
| Role | Primary, Secondary, Danger, Success | Color, emphasis |
| Style | Outline, Ghost, Filled, Text | Border, background, elevation |
| Size | XS, SM, MD, LG, XL | Dimensions, padding, font size |

### 6.2 Variant Rules

| # | Rule |
|---|------|
| V01 | Every variant must be traceable to a defined token set |
| V02 | Variants must not alter the component's anatomy — only its visual properties |
| V03 | Size variants must use defined size tokens (`TK-size-{component}-{size}`) |
| V04 | Role variants must use defined semantic color tokens (`TK-color-primary`, `TK-color-error`, etc.) |
| V05 | A component must declare its default variant |

---

## 7. Component Behaviors

### 7.1 Event Model

Every interactive component shall declare its event contract:

| Event Type | Description | Required For |
|-----------|-------------|-------------|
| `onClick` / `onPress` | Primary action triggered | Buttons, links, interactive cards |
| `onChange` | Value changed | Inputs, selects, checkboxes |
| `onFocus` | Element received focus | All interactive |
| `onBlur` | Element lost focus | All interactive |
| `onKeyDown` | Keyboard interaction | All interactive |
| `onSubmit` | Form submission | Form containers |

### 7.2 Behavior Rules

| # | Rule |
|---|------|
| B01 | Every event handler must be optional — components must not assume event wiring |
| B02 | A component must not trigger side effects outside its boundary except through declared events |
| B03 | Double-submit prevention must be built into action components during loading state |
| B04 | Keyboard navigation must follow platform conventions (Tab, Enter, Escape, Arrow keys) |

---

## 8. Accessibility

### 8.1 Mandatory Requirements

| # | Requirement | WCAG |
|---|-------------|------|
| AC01 | Every interactive element must be keyboard accessible | 2.1.1 |
| AC02 | Focus order must be logical and visible | 2.4.3 |
| AC03 | Every component conveying information must expose an accessible name | 4.1.2 |
| AC04 | Color must not be the sole indicator of state or meaning | 1.4.1 |
| AC05 | Text must meet minimum contrast of 4.5:1 (normal) / 3:1 (large) | 1.4.3 |
| AC06 | Interactive targets must be at minimum 24 CSS pixels touch area (WCAG 2.5.5) | 2.5.5 |
| AC07 | Error states must provide text descriptions, not just visual indicators | 3.3.1 |
| AC08 | Loading states must announce progress to assistive technology | 4.1.3 |

### 8.2 Accessibility Annotations

Every component specification must include, for each interactive element:

```
- Role: button | link | checkbox | textbox | etc.
- Accessible Name: derived from {label slot | aria-label prop}
- Keyboard: Enter/Space to activate, Tab to reach, Escape to dismiss
- Screen Reader: announces {state changes}, {error messages}, {loading status}
```

---

## 9. Token Consumption

Components consume tokens. They must never hardcode values.

### 9.1 Binding Rules

| # | Rule |
|---|------|
| TC01 | Every visual property must be bound to a design token |
| TC02 | Components reference tokens by their ID (`TK-color-primary`), not by their value (raw hex) |
| TC03 | Token values are resolved at the platform level from the build system exports |
| TC04 | A component must declare all tokens it consumes in its specification |
| TC05 | A component must not reference a token outside its tier (e.g., a Core component referencing an Optional token) |

### 9.2 Token Binding Example — Button

| Property | Token |
|----------|-------|
| Background (Primary variant) | `TK-color-primary` |
| Background Hover | `TK-color-primary-hover` |
| Background Active | `TK-color-primary-active` |
| Text Color | `TK-color-text-inverse` |
| Font Family | `TK-typography-font-primary` |
| Font Size | `TK-typography-size-body` |
| Font Weight | `TK-typography-weight-medium` |
| Border Radius | `TK-radius-md` |
| Height (MD size) | `TK-size-button-md` |
| Padding X | `TK-spacing-lg` |
| Padding Y | `TK-spacing-sm` |
| Icon Size | `TK-icon-size-md` |
| Icon Spacing | `TK-spacing-xs` |
| Transition Duration | `TK-motion-duration-fast` |
| Transition Easing | `TK-motion-easing-default` |
| Focus Ring Color | `TK-color-border-focus` |
| Focus Ring Width | `TK-border-width-md` |

---

## 10. Asset Consumption

Components may reference assets. They must never embed asset data directly.

### 10.1 Binding Rules

| # | Rule |
|---|------|
| AS01 | Components reference assets by their ID (`AS-icon-search`), not by file path |
| AS02 | Asset resolution is handled by the platform build pipeline |
| AS03 | A component must declare all assets it references in its specification |
| AS04 | Missing assets must not break component rendering — a fallback must be defined |

---

## 11. Component Dependencies

### 11.1 Dependency Declaration

Every component must declare:

| Dependency Type | Description | Example |
|----------------|-------------|---------|
| Token Dependencies | Token IDs consumed by the component | `TK-color-primary`, `TK-spacing-md` |
| Asset Dependencies | Asset IDs referenced by the component | `AS-icon-search`, `AS-logo-primary` |
| Component Dependencies | Other components used within | A Select uses a List component internally |

### 11.2 Dependency Rules

| # | Rule |
|---|------|
| DP01 | A component must not depend on a component that does not exist in the registry |
| DP02 | Circular component dependencies are prohibited |
| DP03 | All dependencies must be declared in the component manifest |

---

## 12. Component Lifecycle

Every component follows a defined lifecycle.

### 12.1 Stages

| # | Stage | Description | Gate |
|---|-------|-------------|------|
| 1 | Proposal | Need identified for a new component | — |
| 2 | Specification | Component specification written per SP-Component framework | Must reference existing tokens and standards |
| 3 | Review | Specification reviewed against S-Component rules | Must pass accessibility, token binding, anatomy checks |
| 4 | Implementation | Platform implementations created for all required platforms | Must consume tokens from build system |
| 5 | Validation | Automated checks: naming, token refs, accessibility, manifest integrity | Build system validators |
| 6 | Registry | Component registered in component-registry.json | Generated by build system |
| 7 | Release | Component available for consumption | CHANGELOG, VERSION updated |

### 12.2 Lifecycle Rules

| # | Rule |
|---|------|
| LC01 | A component must not skip any stage |
| LC02 | Deprecated components remain accessible for one full version cycle |
| LC03 | A component with zero usage for two versions is flagged for archival |

---

## 13. Component Naming

### 13.1 Identifier Pattern

```
CMP-{name}
```

| Segment | Rule | Example |
|---------|------|---------|
| Prefix | `CMP-` always | `CMP-button` |
| Name | Noun. kebab-case. Must not include variant, size, or state. | `CMP-search-input` |

### 13.2 Naming Rules

| # | Rule |
|---|------|
| N01 | Component ID must use the `CMP-` prefix per Naming Convention Law §4.2 |
| N02 | Component name must be a noun |
| N03 | Compound names use a single hyphen |
| N04 | Variant, size, and state must not appear in the component ID — they are properties of the component |

### 13.3 Valid Examples

```
CMP-button
CMP-text-input
CMP-select
CMP-modal
CMP-data-table
CMP-search-input
CMP-toast-notification
```

### 13.4 Invalid Examples

```
CMP-button-primary    ← variant in ID
CMP-lg-button         ← size in ID
CMP-hover-card        ← state in ID
button                ← missing prefix
CMP-btn               ← abbreviation not allowed
```

---

## 14. Platform Support Model

### 14.1 Platform Tiers

| Tier | Platforms | Requirement |
|------|-----------|-------------|
| Web | HTML + CSS, React, Vue, Angular, Svelte | All components must have web implementations |
| Mobile | SwiftUI, Flutter, Jetpack Compose | All components must have mobile implementations |
| Design | Figma, Canva | All components must have design kit assets |

### 14.2 Platform Rules

| # | Rule |
|---|------|
| P01 | A component must not contain platform-specific logic in its specification |
| P02 | Platform implementations consume the same tokens exported by the build system |
| P03 | A platform implementation may add platform-specific behavior if it does not alter the component's defined behavior |
| P04 | A component marked as web-only or mobile-only must declare this constraint explicitly |

---

## 15. Component vs Specification vs Manifest vs Implementation

| Artifact | Purpose | Format | Location |
|----------|---------|--------|----------|
| **Standard (S-Component)** | This document. Defines what a component IS. | Markdown | Standards/ |
| **Specification (SP-{component})** | Defines the blueprint for ONE specific component. Anatomy, states, variants, tokens. | Markdown | Specifications/ |
| **Manifest ({component}.manifest.json)** | Machine-readable metadata for ONE component. ID, version, dependencies, platforms. | JSON | Implementation/Components/{name}/ |
| **Implementation** | Platform-specific code for one component. | HTML, CSS, Swift, Kotlin, etc. | Implementation/Components/{name}/ |
| **Registry (component-registry.json)** | Generated catalog of ALL components. | JSON | Registry/ |

---

## 16. Compliance

### 16.1 Verification

Compliance with this standard is verified through:

- **Build system validators** — automated checks for token binding, asset references, naming
- **Component review** — manual review against this standard during approval
- **Accessibility audit** — automated contrast, keyboard, and ARIA checks

### 16.2 Violations

| Severity | Definition | Action |
|----------|-----------|--------|
| Critical | Hardcoded value instead of token reference | Must be resolved before merge |
| Major | Missing accessibility annotation | Must be resolved before release |
| Minor | Non-compliant component name | Should be corrected; logged for review |

---

## 17. Versioning

This standard follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Change |
|---|---|---|
| 1.0 | 2026-07-30 | Initial component standard (lightweight) |
| 0.3 | 2026-07-31 | Complete rewrite — Component Meta Model. Added anatomy, slots, states, variants, behaviors, accessibility, token consumption model, asset consumption model, lifecycle, naming, platform tiers. Per Master Roadmap Phase 2.1. |

---

*End of S-Component v0.3 — Component Meta Model.*
