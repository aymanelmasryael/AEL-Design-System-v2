# Modal

**Component:** CMP-modal
**Category:** Overlay
**Specification:** SP-Modal v1.0

## Anatomy

| Part | Required | Description |
|------|----------|-------------|
| Backdrop | Yes | Semi-transparent overlay behind the dialog |
| Dialog | Yes | The modal panel |
| Header | No | Title + close button |
| Body | Yes | Primary content |
| Footer | No | Action buttons |
| Close Button | No | X button in header |

## States

Default, Open

## Events

| Event | Detail | Description |
|-------|--------|-------------|
| `ael:modal:open` | — | Fired when modal opens |
| `ael:modal:close` | — | Fired when modal closes |

## Keyboard

- `Escape` — closes the modal
- `Tab` / `Shift+Tab` — trapped within the modal

## Accessibility

- Role: `dialog`
- `aria-modal="true"` when open
- Focus trapped within the modal
- Focus returns to trigger element on close

## Usage

```html
<button data-ael-trigger="demo-modal">Open</button>

<div class="ael-modal" id="demo-modal" data-ael-modal="demo-modal" hidden>
  <div class="ael-modal__backdrop">
    <div class="ael-modal__dialog">...</div>
  </div>
</div>
```
