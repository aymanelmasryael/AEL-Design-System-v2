# AEL Ontology

**Version:** 0.1
**Status:** Draft
**Owner:** AEL Digital Studio
**Governed By:** AEL Meta-Architecture v0.1
**Classification:** Core Model — defines entities and relationships of the AEL Design System.

---

## 1. Purpose

The AEL Ontology defines the entities that constitute the AEL Design System and the permitted relationships between them. It is the model layer that sits below the Meta-Architecture and above all Standards, Specifications, and Implementation.

---

## 2. Entity Catalog

### E-01 — Document

An official record within the system that carries authority over defined domains.

| Property | Value |
|---|---|
| Identity | Unique Document ID (e.g., C-01, L-03, S-07) |
| Lifecycle | Draft → Active → Deprecated → Archived |
| Referenced By | Other Documents, Standards, Specifications |

**Canonical definition:** AEL Meta-Architecture Layer 2. Any document is a governed container of Standards.

---

### E-02 — Standard

A rule that defines what must exist within a given domain. Standards do not describe technical implementation.

| Property | Value |
|---|---|
| Identity | Unique Standard ID (e.g., S-Foundations, S-Components) |
| Lifecycle | Draft → Active → Superseded → Archived |
| Referenced By | Specifications, Compliance reviews |

**Canonical definition:** A Standard is an entity that governs Specifications. It answers "what" questions, never "how."

---

### E-03 — Specification

A technical description of an entity, precise enough to be implemented without additional design decisions.

| Property | Value |
|---|---|
| Identity | Unique Spec ID (e.g., SP-Button, SP-ColorToken) |
| Lifecycle | Draft → Approved → Active → Superseded |
| Referenced By | Artifacts, Registries, Implementation guides |

**Canonical definition:** A Specification describes one entity. It is governed by exactly one Standard.

---

### E-04 — Component

A reusable unit with defined behavior, structure, and appearance. Components are the building blocks of interfaces.

| Property | Value |
|---|---|
| Identity | Unique Component ID (e.g., CMP-Header, CMP-Card) |
| Lifecycle | Proposed → Active → Deprecated → Removed |
| Referenced By | Templates, Specifications, Registries |

**Canonical definition:** A Component uses Tokens and may reference Assets. It is described by exactly one Specification.

---

### E-05 — Token

A design value used as a single source of truth for a visual property.

| Property | Value |
|---|---|
| Identity | Unique Token ID (e.g., TK-color-primary, TK-spacing-md) |
| Lifecycle | Active → Deprecated → Removed |
| Referenced By | Components, Specifications, Artifacts |

**Canonical definition:** A Token has exactly one value at any given version. It may not reference other entities directly.

---

### E-06 — Asset

A visual or digital resource that exists independently of any component.

| Property | Value |
|---|---|
| Identity | Unique Asset ID (e.g., AS-logo-primary, AS-icon-arrow) |
| Lifecycle | Created → Reviewed → Published → Archived |
| Referenced By | Components, Templates, Artifacts |

**Canonical definition:** An Asset is referenced but not governed by Components. It has its own lifecycle.

---

### E-07 — Template

An organized assembly of Components and Assets, structured for a specific output context.

| Property | Value |
|---|---|
| Identity | Unique Template ID (e.g., TPL-linkedin-post, TPL-presentation) |
| Lifecycle | Draft → Approved → Active → Retired |
| Referenced By | Artifacts, Export workflows |

**Canonical definition:** A Template assembles Components and references Assets. It does not define new visual rules.

---

### E-08 — Artifact

A concrete output file or design that implements one or more Specifications.

| Property | Value |
|---|---|
| Identity | File path + format (e.g., tokens/colors.json) |
| Lifecycle | Generated → Reviewed → Published → Archived |
| Referenced By | Export Standard, Delivery workflows |

**Canonical definition:** An Artifact implements Specifications. It is the only entity that exists in a specific platform format.

---

## 3. Relationship Matrix

| ID | Source | Relationship | Target | Meaning |
|---|---|---|---|---|
| R-01 | Document | **contains** | Standard | A Document defines and governs the Standards within its scope |
| R-02 | Standard | **governs** | Specification | A Standard sets the rules that a Specification must follow |
| R-03 | Specification | **describes** | Component | A Specification provides the technical blueprint for a Component |
| R-04 | Component | **uses** | Token | A Component references Token values for its visual properties |
| R-05 | Component | **references** | Asset | A Component may reference Assets (icons, images) |
| R-06 | Template | **assembles** | Component | A Template is composed of Components arranged for a context |
| R-07 | Artifact | **implements** | Specification | An Artifact is a concrete realization of a Specification |

No other relationships are permitted in v0.1. Any request for a new relationship must be evaluated against the Meta-Architecture Evolution Rules.

---

## 4. What Is Not an Entity

The following are explicitly excluded from the entity catalog in this version:

| Concept | Classification | Reason |
|---|---|---|
| Color, Spacing, Typography | Token specialization | They are subtypes of Token, not independent entities |
| Button, Card, Header | Component specialization | They are instances/roles of Component, not root entities |
| Primary, Secondary, Success | Token instance | They are values within a Token type, not entities |
| JSON, CSS, SVG, Canva | Artifact format | They are output formats, not entities |
| Repository, Folder | Infrastructure | They are storage structures, not conceptual entities |
| Designer, Developer, Reviewer | Role | They are human roles, not system entities |

---

## 5. Entity Authority Flow

```
Document
   contains →
      Standard
         governs →
            Specification
               describes →
                  Component
                     uses → Token
                     references → Asset
                  Template
                     assembles → Component
               Artifact
                  implements → Specification
```

Authority flows top-down. Implementation may not override Specification. Specification may not override Standard. Standard may not override Document.

---

*End of AEL Ontology v0.1.*
