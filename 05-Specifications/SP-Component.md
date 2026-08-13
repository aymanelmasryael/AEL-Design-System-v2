# SP-Component — Component Specification Framework

**Version:** 1.2
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** S-Component v0.3
**Classification:** Specification Framework — Level 4

---

## 1. Purpose

This specification defines the uniform structure for every component specification in the AEL Design System. Every SP-{component}.md document must follow this framework. No component may be implemented without a specification conforming to this document.

This specification defines STRUCTURE and TEMPLATE. It does not define values, styles, or platform-specific rendering.

---

## 2. Specification Sections

Every component specification shall contain the following sections, in this order:

| # | Section | Required | Purpose |
|---|---------|----------|---------|
| 1 | Identity | Yes | Component ID, name, version, status, governing documents |
| 2 | Purpose | Yes | What the component does. One paragraph. |
| 3 | Anatomy | Yes | Named structural parts with required/optional declaration |
| 4 | Slots | Conditional | Content injection points. Required if component has slots. |
| 5 | Variants | Yes | Visual/functional alternatives with token bindings |
| 6 | States | Yes | Interactive states with token bindings |
| 7 | Behaviors | Conditional | Event model. Required if interactive. |
| 8 | Accessibility | Yes | Roles, keyboard, screen reader, contrast |
| 9 | Design Tokens | Yes | Complete token reference table |
| 10 | Assets | Conditional | Asset references. Required if component uses assets. |
| 11 | Size Scale | Conditional | Dimension table. Required if component has sizes. |
| 12 | Platform Mapping | Yes | Platform support matrix |
| 13 | Dependencies | Conditional | Component, token, and asset dependencies. Required if any exist. |
| 14 | Usage Guidelines | Yes | When to use, when not to use |
| 15 | Examples | Recommended | Usage examples across platforms |
| 16 | Validation Rules | Yes | Automated checks for this component |
| 17 | Version History | Yes | Change log |

---

## 3. Section Specifications

### 3.1 Identity

```markdown
**Component ID:** CMP-{name}
**Name:** {Human-readable name}
**Version:** {MAJOR.MINOR}
**Status:** Draft | Active | Deprecated | Archived
**Governed By:** S-Component v0.3 · S-{domain} · Operational Laws v0.2
```

### 3.2 Purpose

One paragraph. States what the component does, its primary use case, and its place in the system. Must not describe visual appearance — only function.

### 3.3 Anatomy

Table with columns: Part, Required (Yes/No), Type (Root/Text Slot/Icon Slot/Content Slot/Indicator Slot/Action Slot), Description.

Every component must declare at minimum a Container part.

### 3.4 Slots

Required only if the component has slots beyond the root container. Table with columns: Slot Name, Type, Required, Accepted Content, Default Content.

### 3.5 Variants

Table with columns: Variant, Category (Role/Style/Size), Token Binding, Description.

Every variant must bind to a token. No raw values permitted.

**Example:**

| Variant | Category | Token Binding | Description |
|---------|----------|---------------|-------------|
| Primary | Role | `TK-color-primary` for background | Default call-to-action |
| Secondary | Role | `TK-color-secondary` for background | Supporting action |
| Outline | Style | `TK-color-border` for border, transparent background | Low-emphasis action |

### 3.6 States

Table with columns: State, Visual Change, Token Binding, Interaction Blocked?

Every state must bind to tokens. State transitions must reference motion tokens.

**Example:**

| State | Visual Change | Token Binding | Interaction Blocked? |
|-------|---------------|---------------|---------------------|
| Default | Base appearance | `TK-color-primary` (bg), `TK-color-text-inverse` (text) | No |
| Hover | 8% darken overlay | `TK-opacity-hover` + background color | No |
| Disabled | 40% opacity, gray bg | `TK-opacity-disabled`, `TK-color-gray-200` (bg), `TK-color-gray-500` (text) | Yes |

### 3.7 Behaviors

Required only for interactive components. Table with columns: Event, Trigger, Handler, Platform Notes.

### 3.8 Accessibility

Must include: role, accessible name derivation, keyboard interaction model, screen reader announcements, contrast requirements. Follow the annotation format from S-Component §8.2.

### 3.9 Design Tokens

Complete table of every token consumed by this component.

**Format:**

| Property | Token | Token Value (from SSOT) | Notes |
|----------|-------|------------------------|-------|

Token values are READ-ONLY — they are included for reference convenience but their source of truth is the Implementation SSOT directory. Per PROP-2026-001 (DD06), this is a permitted token ID namespace reference. If the SSOT changes, this table is documentation only and must not diverge.

### 3.10 Assets

Required if the component references any asset.

**Format:**

| Slot / Usage | Asset ID | Asset Source | Fallback |
|-------------|----------|-------------|----------|

### 3.11 Size Scale

Required if the component has size variants. Table with columns: Size, Token, Dimensions, Usage.

### 3.12 Platform Mapping

Table with columns: Platform, Status (Supported / Planned / N/A), Implementation Path, Notes.

### 3.13 Dependencies

Declare all component, token, and asset dependencies.

**Format:**

| Dependency Type | ID | Required | Notes |
|----------------|-----|----------|-------|

### 3.14 Usage Guidelines

- **When to use:** Scenarios where this component is appropriate.
- **When NOT to use:** Scenarios where a different component should be used instead.
- **Best practices:** 2-4 key guidelines.

### 3.15 Examples

Platform-specific code examples showing the component in its default state. At minimum: HTML + CSS, React JSX, SwiftUI.

### 3.16 Validation Rules

List of automated checks the build system must verify for this component:

| # | Rule | Validator |
|---|------|-----------|
| V01 | All token references resolve to existing tokens | Token validator |
| V02 | All asset references resolve to existing assets | Asset validator |
| V03 | No hardcoded values (hex, px) in implementation | SSOT validator |
| V04 | Component ID follows naming convention | Token validator |
| V05 | All required anatomy parts are implemented | Component validator |

### 3.17 Version History

| Version | Date | Description |
|---------|------|-------------|

---

## 4. Component Specification Template

```markdown
# SP-{Component-Name} — {Component Name} Specification

**Component ID:** CMP-{name}
**Name:** {Human-readable name}
**Version:** 1.0
**Status:** Draft
**Governed By:** S-Component v0.3 · S-{domain} · Operational Laws v0.2

---

## 1. Purpose

{One paragraph. What it does. Primary use case.}

---

## 2. Anatomy

| Part | Required | Type | Description |
|------|----------|------|-------------|
| Container | Yes | Root element | {description} |
| ... | ... | ... | ... |

---

## 3. Slots

| Slot Name | Type | Required | Accepted Content | Default Content |
|-----------|------|----------|-----------------|-----------------|
| ... | ... | ... | ... | ... |

---

## 4. Variants

| Variant | Category | Token Binding | Description |
|---------|----------|---------------|-------------|
| Default | Role | {token} | {description} |
| ... | ... | ... | ... |

---

## 5. States

| State | Visual Change | Token Binding | Interaction Blocked? |
|-------|---------------|---------------|---------------------|
| Default | ... | ... | No |
| ... | ... | ... | ... |

---

## 6. Behaviors

| Event | Trigger | Handler | Platform Notes |
|-------|---------|---------|---------------|
| ... | ... | ... | ... |

---

## 7. Accessibility

- **Role:** {ARIA role or platform equivalent}
- **Accessible Name:** Derived from {source}
- **Keyboard:** {Tab to reach, Enter to activate, etc.}
- **Screen Reader:** {announcements}
- **Contrast:** {requirements}

---

## 8. Design Tokens

| Property | Token | Token Value (from SSOT) | Notes |
|----------|-------|------------------------|-------|
| ... | ... | ... | ... |

---

## 9. Assets

| Slot / Usage | Asset ID | Asset Source | Fallback |
|-------------|----------|-------------|----------|
| ... | ... | ... | ... |

---

## 10. Size Scale

| Size | Token | Dimensions | Usage |
|------|-------|-----------|-------|
| ... | ... | ... | ... |

---

## 11. Platform Mapping

| Platform | Status | Implementation Path | Notes |
|----------|--------|--------------------|-------|
| HTML + CSS | Supported | `Components/{name}/{name}.html` | |
| React | Supported | `Components/{name}/{name}.tsx` | |
| SwiftUI | Planned | `Components/{name}/{name}.swift` | |
| Figma | Supported | `platforms/figma/figma-tokens.json` | |
| ... | ... | ... | ... |

---

## 12. Dependencies

| Dependency Type | ID | Required | Notes |
|----------------|-----|----------|-------|
| ... | ... | ... | ... |

---

## 13. Usage Guidelines

- **When to use:** ...
- **When NOT to use:** ...
- **Best practices:** 1. ... 2. ... 3. ...

---

## 14. Examples

### HTML + CSS

{code example}

### React

{code example}

### SwiftUI

{code example}

---

## 15. Validation Rules

| # | Rule |
|---|------|
| V01 | ... |
| V02 | ... |

---

## 16. Version History

| Version | Date | Description |
|---------|------|-------------|
| 1.0 | YYYY-MM-DD | Initial specification |

---

*End of SP-{Component-Name} v1.0.*
```

---

## 5. Versioning

This specification framework follows semantic versioning as defined in the Constitution (Section 6).

| Version | Date | Description |
|---|---|---|
| 1.0 | 2026-07-30 | Initial component specification (lightweight template) |
| 1.2 | 2026-07-31 | Complete rewrite — formal specification framework with 17 required sections, template, and validation rules. Per Master Roadmap Phase 2.2. |

---

*End of SP-Component v1.2 — Component Specification Framework.*
