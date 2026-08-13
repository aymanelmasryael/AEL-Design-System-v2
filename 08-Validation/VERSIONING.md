# AEL Versioning Policy

**Governed By:** AEL Constitution §6

---

## System Versioning

The system version (`VERSION` at root) follows semantic versioning: **MAJOR.MINOR.PATCH**

| Increment | Trigger |
|-----------|---------|
| MAJOR | Breaking change to architecture, governance model, or component API |
| MINOR | New components, new token categories, new platform targets |
| PATCH | Bug fixes, documentation corrections, non-breaking refinements |

## Document Versioning

Individual documents carry independent versions. No synchronization required.

## Token Versioning

Tokens are versioned at the file level. A token value change increments the Implementation file version and triggers a Registry regeneration.

## Component Versioning

Each component manifest carries its own version. Breaking changes to a component's anatomy, variants, or token dependencies require a major version increment for that component only.

## Current

System: **0.2** (Draft)
