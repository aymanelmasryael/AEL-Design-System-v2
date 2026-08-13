/* AEL Compiler — Golden Tests */

const assert = require('assert');
const { compile } = require('../ir');
const { validateIR } = require('../diagnostics');
const { renderReact } = require('../react-renderer');
const { renderVue } = require('../vue-renderer');

let passed = 0, failed = 0;

function test(name, fn) {
  try { fn(); console.log(`  ✓ ${name}`); passed++; }
  catch (e) { console.error(`  ✗ ${name}: ${e.message}`); failed++; }
}

console.log('\n═══ AEL Compiler Golden Tests ═══\n');

// ── Helpers ──

const manifest = (id, name) => ({ id, name });
const assertIR = (ir, type, isOverlay, slotCount) => {
  assert(ir, `${type}: IR should not be null`);
  assert.strictEqual(ir.version, '1.0');
  assert.strictEqual(ir.tree.type, type);
  assert.strictEqual(ir.meta.isOverlay, isOverlay);
  if (slotCount !== undefined) assert.strictEqual(ir.meta.slots.length, slotCount);
};
const assertReact = (ir, ...patterns) => {
  const jsx = renderReact(ir);
  patterns.forEach(p => assert(jsx.includes(p), `React: missing "${p}"`));
};
const assertVue = (ir, ...patterns) => {
  const vue = renderVue(ir);
  patterns.forEach(p => assert(vue.includes(p), `Vue: missing "${p}"`));
};
const compileAndAssert = (html, m, type, overlay, slots, react, vue) => {
  const ir = compile(html, m, 'react');
  assertIR(ir, type, overlay, slots);
  if (react) assertReact(ir, ...react);
  if (vue) assertVue(compile(html, m, 'vue'), ...vue);
};

// ── Modal ──

test('modal: IR structure', () => {
  compileAndAssert(
    '<div class="ael-modal" hidden><div class="ael-modal__backdrop"><div class="ael-modal__dialog" role="dialog" aria-modal="true"><div class="ael-modal__header"><!-- Slot: header --><button class="ael-modal__close" aria-label="Close">&times;</button></div><div class="ael-modal__body"><!-- Slot: body --></div><div class="ael-modal__footer"><!-- Slot: footer --></div></div></div></div>',
    manifest('CMP-modal', 'modal'), 'overlay', true, 3,
    ['export function Modal', 'open, onClose', 'header', 'body', 'footer', 'useEffect', 'useRef', 'Escape', 'onClose', 'ael-modal'],
    ['defineProps', 'defineEmits', 'v-if', '{{ header }}', '{{ body }}', '{{ footer }}']
  );
});

// ── Drawer ──

test('drawer: IR structure', () => {
  compileAndAssert(
    '<div class="ael-drawer ael-drawer--right" hidden><div class="ael-drawer__backdrop"></div><div class="ael-drawer__panel" role="dialog" aria-modal="true"><h2>Title</h2></div></div>',
    manifest('CMP-drawer', 'drawer'), 'overlay', true, 0,
    ['export function Drawer', 'open, onClose', 'ael-drawer'],
    ['v-if', 'defineEmits']
  );
});

// ── Input ──

test('input: IR structure', () => {
  compileAndAssert(
    '<div class="ael-input"><label class="ael-input__label"><!-- Slot: label --></label><div class="ael-input__wrapper"><input class="ael-input__field" type="email"></div><span class="ael-input__helper"><!-- Slot: helper --></span></div>',
    manifest('CMP-text-input', 'text-input'), 'formField', false, 2,
    ['export function TextInput', 'label', 'helper', 'ael-input'],
    ['{{ label }}', '{{ helper }}']
  );
});

// ── Textarea ──

test('textarea: IR structure', () => {
  compileAndAssert(
    '<div class="ael-textarea"><label class="ael-textarea__label"><!-- Slot: label --></label><textarea class="ael-textarea__field" rows="4"></textarea></div>',
    manifest('CMP-textarea', 'textarea'), 'formField', false, 1,
    ['export function Textarea', 'label', 'ael-textarea'],
    ['{{ label }}']
  );
});

// ── Select ──

test('select: IR structure', () => {
  compileAndAssert(
    '<div class="ael-select"><label class="ael-select__label"><!-- Slot: label --></label><div class="ael-select__wrapper"><select class="ael-select__field"><option value="">Select</option></select></div></div>',
    manifest('CMP-select', 'select'), 'formField', false, 1,
    ['export function Select', 'label'],
    ['{{ label }}']
  );
});

// ── Button ──

test('button: IR structure', () => {
  compileAndAssert(
    '<button class="ael-button ael-button--primary ael-button--md"><!-- Slot: label --></button>',
    manifest('CMP-button', 'button'), 'button', false, 1,
    ['export function Button', 'label', 'ael-button'],
    ['{{ label }}']
  );
});

// ── Checkbox ──

test('checkbox: IR structure', () => {
  const ir = compile('<label class="ael-checkbox"><input class="ael-checkbox__input" type="checkbox"><span class="ael-checkbox__mark"></span><span class="ael-checkbox__label"><!-- Slot: label --></span></label>',
    manifest('CMP-checkbox', 'checkbox'), 'react');
  assertIR(ir, 'toggle', false, 1);
  assert.strictEqual(ir.tree.props.kind, 'checkbox');
});

// ── Tabs ──

test('tabs: IR structure', () => {
  compileAndAssert(
    '<div class="ael-tabs" role="tablist"><button class="ael-tabs__tab ael-tabs__tab--active" role="tab">Tab 1</button><button class="ael-tabs__tab" role="tab">Tab 2</button></div>',
    manifest('CMP-tabs', 'tabs'), 'tabList', false, 0,
    ['export function Tabs', 'ael-tabs'],
    ['ael-tabs']
  );
});

// ── Accordion ──

test('accordion: IR structure', () => {
  compileAndAssert(
    '<div class="ael-accordion"><div class="ael-accordion__item"><button class="ael-accordion__trigger"><span>Title</span><svg class="ael-accordion__icon" viewBox="0 0 24 24"><polyline points="6 9 12 15 18 9"/></svg></button><div class="ael-accordion__content"><!-- Slot: content --></div></div></div>',
    manifest('CMP-accordion', 'accordion'), 'accordion', false, 1,
    ['export function Accordion', 'ael-accordion'],
    ['ael-accordion']
  );
});

// ── Menu ──

test('menu: IR structure', () => {
  compileAndAssert(
    '<div class="ael-menu" data-ael-menu-trigger="t" role="menu" hidden><button class="ael-menu__item" role="menuitem">Edit</button><div class="ael-menu__divider" role="separator"></div><button class="ael-menu__item" role="menuitem">Delete</button></div>',
    manifest('CMP-menu', 'menu'), 'menu', false, 0,
    ['export function Menu', 'ael-menu'],
    ['ael-menu']
  );
});

// ── Toast ──

test('toast: IR structure', () => {
  compileAndAssert(
    '<div class="ael-toast" data-ael-auto data-ael-duration="3000" role="status" hidden><span><!-- Slot: message --></span></div>',
    manifest('CMP-toast', 'toast'), 'notification', false, 1,
    ['export function Toast', 'ael-toast'],
    ['ael-toast']
  );
});

// ── Tooltip ──

test('tooltip: IR structure', () => {
  compileAndAssert(
    '<div class="ael-tooltip" role="tooltip" hidden><!-- Slot: text --></div>',
    manifest('CMP-tooltip', 'tooltip'), 'tooltip', false, 1,
    ['export function Tooltip', 'ael-tooltip'],
    ['ael-tooltip']
  );
});

// ── Card ──

test('card: IR structure', () => {
  compileAndAssert(
    '<div class="ael-card"><div class="ael-card__header"><!-- Slot: header --></div><div class="ael-card__body"><!-- Slot: body --></div><div class="ael-card__footer"><!-- Slot: footer --></div></div>',
    manifest('CMP-card', 'card'), 'container', false, 3,
    ['export function Card', 'header', 'body', 'footer'],
    ['{{ header }}', '{{ body }}', '{{ footer }}']
  );
});

// ── Badge ──

test('badge: IR structure', () => {
  compileAndAssert(
    '<span class="ael-badge"><!-- Slot: text --></span>',
    manifest('CMP-badge', 'badge'), 'badge', false, 1,
    ['export function Badge', 'ael-badge'],
    ['ael-badge']
  );
});

// ── Table ──

test('table: IR structure', () => {
  const ir = compile('<table class="ael-table"><thead><tr><th>Name</th></tr></thead><tbody><tr><td>Value</td></tr></tbody></table>',
    manifest('CMP-data-table', 'data-table'), 'react');
  assertIR(ir, 'dataTable', false);
  assert(ir.tree.children.length > 0);
});

// ── Diagnostics ──

test('diagnostics: validates IR', () => {
  const ir = compile('<div class="ael-modal" hidden><div class="ael-modal__backdrop"><div class="ael-modal__dialog" role="dialog"><div class="ael-modal__body"><!-- Slot: body --></div></div></div></div>',
    manifest('CMP-modal', 'modal'), 'react');
  const diag = validateIR(ir);
  assert.strictEqual(diag.hasErrors(), false);
  assert(diag.warnings.length >= 0);
});

test('diagnostics: suggests close event for overlay', () => {
  const ir = compile('<div class="ael-modal" hidden><div class="ael-modal__backdrop"><div class="ael-modal__dialog" role="dialog"></div></div></div>',
    manifest('CMP-modal', 'modal'), 'react');
  const diag = validateIR(ir);
  assert(diag.suggestions.length > 0);
  assert(diag.suggestions.some(s => s.message.includes('close')));
});

test('diagnostics: reports errors', () => {
  const { CompilerDiagnostics } = require('../diagnostics');
  const d = new CompilerDiagnostics();
  d.error('test error', 'parser');
  assert(d.hasErrors());
  assert(d.report().includes('test error'));
});

// ── Snapshot: IR consistency across targets ──

test('snapshot: same IR structure for react and vue', () => {
  const html = '<div class="ael-modal" hidden><div class="ael-modal__backdrop"><div class="ael-modal__dialog" role="dialog"><div class="ael-modal__header"><!-- Slot: header --></div><div class="ael-modal__body"><!-- Slot: body --></div></div></div></div>';
  const irReact = compile(html, manifest('CMP-modal', 'modal'), 'react');
  const irVue = compile(html, manifest('CMP-modal', 'modal'), 'vue');
  assert.strictEqual(irReact.meta.slots.length, irVue.meta.slots.length);
  assert.strictEqual(irReact.meta.isOverlay, irVue.meta.isOverlay);
  assert.strictEqual(irReact.tree.type, irVue.tree.type);
});

// ── Regression: parser handles mixed content ──

test('regression: inline comments with HTML', () => {
  const ir = compile('<!-- Component: Modal --><div class="ael-modal" hidden><div class="ael-modal__backdrop"><div class="ael-modal__dialog"><!-- Slot: body --></div></div></div>',
    manifest('CMP-modal', 'modal'), 'react');
  assertIR(ir, 'overlay', true, 1);
});

test('regression: self-closing div elements', () => {
  const ir = compile('<div class="ael-modal" hidden><div class="ael-modal__backdrop"/></div>',
    manifest('CMP-modal', 'modal'), 'react');
  assert(ir);
  assert.strictEqual(ir.tree.type, 'overlay');
});

test('regression: deep nesting', () => {
  const html = '<div class="ael-modal" hidden><div class="ael-modal__backdrop"><div class="ael-modal__dialog" role="dialog"><div class="ael-modal__header"><span><!-- Slot: title --></span></div><div class="ael-modal__body"><div><!-- Slot: content --></div></div><div class="ael-modal__footer"><button class="ael-button"><!-- Slot: action --></button></div></div></div></div>';
  const ir = compile(html, manifest('CMP-modal', 'modal'), 'react');
  assertIR(ir, 'overlay', true, 3);
  const slots = ir.meta.slots.map(s => s.name);
  assert(slots.includes('title'));
  assert(slots.includes('content'));
  assert(slots.includes('action'));
});

// ── Results ──

console.log(`\n═══ Results: ${passed} passed, ${failed} failed ═══\n`);
process.exit(failed ? 1 : 0);
