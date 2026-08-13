/* AEL Compiler — Semantic Builder
 * Syntax AST → Semantic Tree.
 * Uses concept registry to classify HTML nodes into architectural concepts.
 * Pure transformation. No target knowledge. No file I/O.
 */

const { classify } = require('./concept-registry');

function build(syntaxNode) {
  if (!syntaxNode) return null;

  if (syntaxNode.tag === 'slot') {
    const propName = syntaxNode.name.replace(/-./g, m => m[1].toUpperCase());
    return { type: 'slot', props: { name: syntaxNode.name, propName } };
  }

  if (syntaxNode.tag === 'text') {
    return { type: 'text', props: { value: syntaxNode.value.replace(/&times;/, '×') } };
  }

  const concept = classify(syntaxNode.attrs?.class);

  let node;
  if (concept) {
    node = { type: concept.type, props: { ...concept.props } };
  } else {
    node = { type: 'element', props: { tag: syntaxNode.tag, class: syntaxNode.attrs?.class } };
  }

  if (!node) return null;

  if (syntaxNode.attrs?.class) node.props.class = syntaxNode.attrs.class;
  if (syntaxNode.attrs?.role) node.props.role = syntaxNode.attrs.role;
  if (syntaxNode.attrs?.hidden) node.props.hidden = true;
  for (const [k, v] of Object.entries(syntaxNode.attrs || {})) {
    if (k.startsWith('aria-')) node.props[k] = v;
  }

  for (const child of (syntaxNode.children || [])) {
    const c = build(child);
    if (c) {
      if (!node.children) node.children = [];
      node.children.push(c);
    }
  }

  return node;
}

function collectMeta(tree) {
  const meta = { slots: [], isOverlay: false };
  function walk(n) {
    if (!n) return;
    if (n.type === 'slot') meta.slots.push({ name: n.props.name, propName: n.props.propName });
    if (n.type === 'overlay') meta.isOverlay = true;
    if (n.children) n.children.forEach(walk);
  }
  walk(tree);
  return meta;
}

module.exports = { build, collectMeta };
