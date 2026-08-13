# Contributing to AEL Design System

## Architecture Immutability

The 7-layer architecture, SSOT model, governance hierarchy, and operational laws are frozen. Contributions must not:
- Add new layers or reorganize existing ones
- Change the SSOT location or introduce second sources of truth
- Modify operational laws without a PROP (Architectural Decision Record)
- Rename canonical files or directories

## Adding a Component

1. Write the specification following `SP-Component v1.2` (17-section template) in `05-Specifications/`
2. Create a manifest (`*.manifest.json`) in `06-Implementation/Components/{name}/`
3. Write the CSS implementation — zero hardcoded values, all properties bound to `var(--ael-*)`
4. Run `node 09-Build/build.js` — all validators must pass
5. Component is auto-registered in `07-Registry/component-registry.json`

## Adding a Token

1. Proposal: Is the value expressible with existing tokens?
2. If no: add to the appropriate SSOT file in `06-Implementation/tokens/{category}.json`
3. Run `node 09-Build/build.js` — token validator must pass
4. Token is auto-registered and exported to all 7 platform formats

## Modifying a Token Value

1. Change the value in `06-Implementation/tokens/{category}.json` ONLY
2. Run `node 09-Build/build.js`
3. All platform exports, component CSS (via var() references), and registries update automatically
4. Never change the same value in Standards, Specifications, or Registry — they do not carry values

## Code Style

- CSS: All visual properties use `var(--ael-{token})`. No hardcoded px, hex, em, or numeric values.
- Markdown: English only. Follow existing document structure.
- JSON: 2-space indentation. Schema-compliant manifests only.
- JavaScript: Node.js CommonJS modules for generators and validators.

## Commit Convention

```
{layer}: {description}

G:  Governance       — laws, standards, specifications
I:  Infrastructure   — validators, generators, build
F:  Foundations      — tokens, assets, component model
C:  Components       — component specs, manifests, CSS
P:  Composition      — layouts, navigation, templates
D:  Distribution     — platform targets
K:  Knowledge        — documentation
```

## Before Submitting

- `node 09-Build/build.js` passes all 10 stages
- No hex/px values in Standards or Specifications
- All token references resolve to existing SSOT tokens
- Component ID follows `CMP-{name}` convention
