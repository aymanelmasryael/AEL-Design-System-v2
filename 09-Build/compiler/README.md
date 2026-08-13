# AEL Compiler Core v1.0

**Status:** Stable
**Contract:** IR v1.0

## Architecture

```
Canonical HTML + Manifest
        │
        ▼
   loader.js             File I/O — reads source files
        │
        ▼
   ir.js                 Pipeline orchestrator
        │
   ┌────┴────┐
   ▼         ▼
parser   semantic   ir-builder
              │
         concept-registry.js  ← concept-map.json
              │
              ▼
         IR (v1.0)
              │
     ┌────────┼────────┐
     ▼        ▼        ▼
  react    vue     (swiftui)
 renderer renderer  renderer
```

## Stages

| Stage | Input | Output | Module |
|-------|-------|--------|--------|
| Parse | HTML string | Syntax AST | `parser.js` |
| Semantic Build | Syntax AST | Semantic Tree | `semantic-builder.js` |
| Collect Meta | Semantic Tree | Meta (slots, overlay flag) | `semantic-builder.js` |
| Build IR | Semantic Tree + Meta + Target | IR | `ir-builder.js` |
| Concept Lookup | CSS class | Concept `{type, props}` | `concept-registry.js` |

## IR Contract v1.0

```typescript
interface IR {
  version: "1.0";
  component: { id: string; name: string };
  meta: {
    isOverlay: boolean;
    slots: { name: string; propName: string }[];
    events: { name: string; trigger: string }[];
  };
  tree: IRNode;
  target: "react" | "vue" | "swiftui";
}

interface IRNode {
  type: string;
  props: Record<string, any>;
  children?: IRNode[];
}
```

## Renderer Contract

Every renderer receives IR and returns a string. Renderers dispatch on `node.type` — they never see HTML, CSS classes, or the concept map.

```js
function render(ir: IR): string
```

## Adding a Renderer

1. Create `09-Build/compiler/{platform}-renderer.js`
2. Map node types to platform elements
3. Create `09-Build/generators/{platform}-generator.js` (thin wrapper)
4. Add to `09-Build/build.js` GENERATORS array

## Adding a Concept

Edit `06-Implementation/assets/metadata/concept-map.json`:

```json
"ael-new-component": { "type": "conceptType", "props": {} }
```

No code changes required. The concept registry loads this file at compile time.
