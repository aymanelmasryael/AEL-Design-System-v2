# AEL Meta-Architecture

**Version:** 0.1 (Draft)
**Status:** Draft
**Owner:** AEL Digital Studio
**Classification:** Foundational — precedes all governance and implementation documents.

---

## 1. Purpose

The AEL Meta-Architecture defines the conceptual framework within which all AEL Design System artifacts — models, governance documents, specifications, and implementations — are created, related, and evolved.

It does not describe the system. It describes how the system is described.

This document is the single highest-level reference for all modeling decisions across the AEL ecosystem.

---

## 2. Modeling Principles

Every model, structure, or definition within AEL shall conform to these principles:

**Minimalism**
A concept shall not be introduced unless it cannot be expressed through existing concepts.

**Separation of Concerns**
No document shall conflate two distinct responsibilities (e.g., governance and data, specification and implementation).

**Single Source of Truth**
Every fact about the system shall be stated in exactly one authoritative location.

**Platform Independence**
The conceptual model shall make no assumptions about storage format, deployment platform, or rendering environment.

**Explicit Authority**
Every relationship between entities shall have a defined direction of authority.

**Canonical Representation**
Every entity in the system shall have exactly one canonical definition. No other document may redefine it. Other documents may reference the canonical definition but must not duplicate, override, or diverge from it.

---

## 3. Entity Definition Rules

A concept may be classified as an Entity only if it satisfies all three conditions:

1. **Identity** — It possesses a unique identifier independent of its properties or location.
2. **Lifecycle** — It can be created, referenced, modified, deprecated, and archived through defined processes.
3. **Referenceability** — Other entities within the system can point to it without ambiguity.

A concept that satisfies only one or two of these conditions is not an entity. It is either a property, a role, a specialization, or an artifact of implementation.

Example classifications:

| Concept | Entity? | Reason |
|---|---|---|
| Token | Yes | Has identity, lifecycle, and is referenced by components |
| Color Hex Value | No | It is a property of a Token, not an independent entity |
| Button | No (not at top level) | It is a specialization of Component, not a root entity |
| Primary Button | No | It is an instance of a specialized Component |
| Template | Yes | Has identity, lifecycle, and references components |

---

## 4. Relationship Rules

All relationships between entities are directed and carry a defined semantic.

**Permitted relationship types:**

| Relationship | Direction | Meaning |
|---|---|---|
| governs | Source → Target | Source defines the rules that constrain Target |
| describes | Source → Target | Source provides a technical specification of Target |
| uses | Source → Target | Source depends on Target for its definition or operation |
| implements | Source → Target | Source is a concrete realization of Target |
| references | Source → Target | Source points to Target without governance or dependency |
| assembles | Source → Target | Source is composed of multiple instances of Target |
| constrains | Source → Target | Source limits the valid states or forms of Target |

**Rules:**
- A relationship must have exactly one semantic type.
- A relationship may not be circular across more than two adjacent levels.
- The authority direction must be consistent: if A governs B and B governs C, then A implicitly governs C.

---

## 5. Abstraction Levels

The Meta-Architecture recognizes four abstraction layers:

**Layer 1 — Meta-Model**
The rules for defining models. (This document.)

**Layer 2 — Model (Ontology)**
The entities and relationships specific to AEL.

**Layer 3 — Specification**
The technical description of a specific entity or component.

**Layer 4 — Implementation**
A concrete artifact (file, design, render) that realizes a specification.

No layer may reference a construct from a higher layer as a dependency. Lower layers may reference higher layers only for authority direction.

---

## 6. Evolution Rules

The Meta-Architecture shall evolve under the following constraints:

- **Addition:** A new entity, relationship, or rule may be added only if it cannot be expressed using existing constructs.
- **Deprecation:** A construct may be deprecated but must remain defined for one full version cycle before removal.
- **Modification:** A change to an existing rule must be accompanied by a mapping of how existing instances map to the new rule.
- **Approval:** All changes to this document require the approval of AEL Digital Studio.
- **Frequency:** This document is expected to change no more than once per major version of the Design System.

---

*End of AEL Meta-Architecture.*
