# AEL Reference Implementation

**Status:** Stable — v0.2
**Contract:** Binding for all platform libraries (v0.3+)

---

## Definition

The Reference Implementation is the single authoritative source for every component's structure, style, and behavior. It is written in vanilla web technologies (HTML5, CSS3, JavaScript) with zero framework dependencies.

Every platform library (React, Vue, Angular, Svelte, SwiftUI, Flutter, Jetpack Compose) must translate this reference — not redesign it.

## Layers

| Layer | Technology | Count |
|-------|-----------|-------|
| Structure | HTML5 | 37 components |
| Presentation | CSS3 | Zero hardcoded values — all `var(--ael-*)` |
| Behavior | Vanilla JavaScript | 8 interactive classes |

## Component API Contract

Every component exposes a consistent public API:

| Mechanism | Example | Purpose |
|-----------|---------|---------|
| CSS Classes | `.ael-button`, `.ael-button--primary`, `.ael-button--md` | Variant, size, state |
| Data Attributes | `data-ael-modal`, `data-ael-tab`, `data-ael-auto` | Configuration |
| Custom Events | `ael:modal:open`, `ael:select:change`, `ael:toast:dismiss` | Lifecycle notifications |
| Hidden Attribute | `hidden` | Initial visibility state |

## Platform Library Requirements

Every platform implementation (React, Vue, SwiftUI, etc.) must:

| # | Requirement |
|---|------------|
| R01 | Preserve the same component API surface (variants, sizes, states) |
| R02 | Implement the same behavior as defined in the reference JS classes |
| R03 | Emit the same custom events with the same names and payloads |
| R04 | Consume the same SSOT tokens via the platform's build-generated export |
| R05 | Never hardcode values that exist as tokens |
| R06 | Never alter the UX or interaction model without an architectural decision (PROP) |

## Interactive Components (with Behavior)

| Component | JS Class | Events | Config |
|-----------|----------|--------|--------|
| Modal | `AELModal` | `ael:modal:open`, `ael:modal:close` | `data-ael-modal` on trigger |
| Drawer | `AELDrawer` | — | `data-ael-drawer` on trigger |
| Tabs | `AELTabs` | — | `data-ael-tab` on tab |
| Accordion | `AELAccordion` | `ael:accordion:toggle` | — |
| Menu | `AELMenu` | — | `data-ael-menu-trigger` |
| Toast | `AELToast` | `ael:toast:dismiss` | `data-ael-auto`, `data-ael-duration` |
| Tooltip | `AELTooltip` | — | `data-ael-tooltip` |
| Select | `AELSelect` | `ael:select:change` | — |

## Static Components (Structure + Style Only)

Button, Input, Textarea, Label, Link, Icon, Checkbox, Radio, Switch, Card, Collapse, Panel, Popover, Alert, Snackbar, Progress, Skeleton, Table, List, Tree, Timeline, Statistic, Badge, Avatar, Tag, Pagination, Stepper, Breadcrumb, Container, Grid, Stack, Navbar, Sidebar.

## Token Binding

All CSS properties reference SSOT tokens via `var(--ael-*)`. No component CSS file contains hardcoded px, hex, em, or numeric values. This invariant is verified by the SSOT validator at every build.

Platform libraries bind to the same tokens through their build-generated export format (CSS variables for React/Vue, Swift enum for SwiftUI, XML resources for Android, etc.).

## Versioning

The Reference Implementation version tracks with the system version (currently v0.2). A breaking change to a component's API, anatomy, or behavior requires a major version increment.

## Extending

To add a new component to the Reference Implementation:

1. Write HTML structure + CSS (zero hardcoded values)
2. Write JS behavior class if interactive
3. Write specification per SP-Component v1.2
4. Write manifest per component manifest schema
5. Run `node 09-Build/build.js`
6. All platform libraries inherit the new component contract

## Identity Assets

The Reference Implementation includes the official AEL identity assets. Canonical logo: `ael-logo.svg` (`06-Implementation/assets/logos/`). These assets are referenced through the Asset Registry and are shared by every platform implementation. Platform libraries must not replace or modify the official logo unless explicitly permitted by the project owner. See [BRAND.md](./BRAND.md).

---

**AEL Design System Platform — Reference Implementation v0.2**

Copyright © 2026 Ayman Elmasry. All rights reserved.

Owner: Ayman Elmasry · Organization: AEL Digital Studio™ · Official Logo: `ael-logo.svg`
