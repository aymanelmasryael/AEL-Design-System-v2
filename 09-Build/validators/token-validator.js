const ALLOWED_CATEGORIES = [
  'color', 'typography', 'spacing', 'radius', 'shadow', 'border', 'motion', 'opacity',
  'breakpoint', 'grid', 'zindex', 'elevation',
  'blur', 'size', 'icon'
];
const RESERVED_CHARS = /[.\/#%&+]/;

const tokens = JSON.parse(process.env.AEL_TOKENS);
const values = Object.values(tokens);
const errors = [];

for (const tok of values) {
  const id = tok.id;

  if (!id.startsWith('TK-')) {
    errors.push(`Missing TK- prefix: ${id}`);
    continue;
  }

  if (id.length > 64) {
    errors.push(`ID too long (${id.length} chars): ${id}`);
  }

  if (RESERVED_CHARS.test(id)) {
    errors.push(`Reserved character in ID: ${id}`);
  }

  const parts = id.split('-');
  if (parts.length < 3) {
    errors.push(`Too few segments (${parts.length}): ${id}`);
  }
  if (parts.length > 5) {
    errors.push(`Too many segments (${parts.length}): ${id}`);
  }

  const remainder = id.substring(3);
  if (remainder !== remainder.toLowerCase()) {
    errors.push(`Segments not lowercase after TK- prefix: ${id}`);
  }

  const category = parts[1];
  if (!ALLOWED_CATEGORIES.includes(category)) {
    errors.push(`Category '${category}' not in allowed list: ${id}`);
  }

  if (tok.tier && !['core', 'layout', 'optional'].includes(tok.tier)) {
    errors.push(`Invalid tier '${tok.tier}': ${id}`);
  }
}

if (errors.length > 0) {
  throw new Error(`Token validation failed:\n  - ${errors.join('\n  - ')}`);
}
