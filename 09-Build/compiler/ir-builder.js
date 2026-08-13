/* AEL Compiler — IR Builder
 * Semantic Tree → Intermediate Representation.
 * Normalizes for target platform. Produces the stable IR contract.
 * Pure transformation. No file I/O. No concept map.
 */

function normalizeForTarget(node, target) {
  if (!node) return null;
  const n = { type: node.type, props: { ...node.props } };

  if (target === 'react') {
    if (n.props.class) { n.props.className = n.props.class; delete n.props.class; }
    if (n.props.hidden) { n.props.conditional = true; delete n.props.hidden; }
  } else if (target === 'vue') {
    if (n.props.hidden) { n.props.conditional = 'v-if'; delete n.props.hidden; }
  } else if (target === 'swiftui') {
    if (n.props.hidden) { n.props.conditional = true; delete n.props.hidden; }
  }

  if (node.children) {
    n.children = node.children.map(c => normalizeForTarget(c, target)).filter(Boolean);
  }

  return n;
}

function build(semanticTree, meta, manifest, target = 'react') {
  const ir = {
    version: '1.0',
    source: 'AEL Compiler IR',
    component: {
      id: manifest.id,
      name: manifest.name || manifest.id,
    },
    meta: {
      isOverlay: meta.isOverlay,
      slots: meta.slots,
      events: [],
      roles: {}
    },
    tree: normalizeForTarget(semanticTree, target),
    target
  };

  if (meta.isOverlay) {
    ir.meta.events.push({ name: 'close', trigger: 'escape' });
  }
  if (JSON.stringify(semanticTree).includes('closeButton')) {
    ir.meta.events.push({ name: 'close', trigger: 'button' });
  }

  return ir;
}

module.exports = { build };
