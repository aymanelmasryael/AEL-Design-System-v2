const fs = require('fs');
const path = require('path');

const COMPONENTS_DIR = path.join(__dirname, '..', '..', '06-Implementation', 'Components');
const OUTPUT_FILE = path.join(__dirname, '..', '..', '07-Registry', 'component-registry.json');

module.exports = function() {
  const registry = {
    registry: 'AEL Component Registry',
    version: '0.2',
    status: 'Draft',
    owner: 'AEL Digital Studio',
    generated: true,
    generatedBy: '09-Build/generators/component-registry-generator.js',
    source: '06-Implementation/Components/',
    generatedAt: new Date().toISOString(),
    description: 'Generated catalog — DO NOT EDIT. Produced from 06-Implementation/Components/ manifest files. See PROP-2026-001.',
    governedBy: ['S-Component v0.3', 'SP-Component v1.2'],
    components: {},
    meta: { totalComponents: 0, categories: {} }
  };

  if (!fs.existsSync(COMPONENTS_DIR)) {
    registry.warning = 'No Components directory found. Create component manifests in 06-Implementation/Components/{name}/.';
  } else {
    const entries = fs.readdirSync(COMPONENTS_DIR, { withFileTypes: true });

    for (const entry of entries) {
      if (!entry.isDirectory()) continue;
      if (entry.name.startsWith('.')) continue;

      const compDir = path.join(COMPONENTS_DIR, entry.name);
      const manifests = fs.readdirSync(compDir).filter(f => f.endsWith('.manifest.json'));

      for (const mf of manifests) {
        const manifest = JSON.parse(fs.readFileSync(path.join(compDir, mf), 'utf8'));
        const category = manifest.category || 'uncategorized';

        const compEntry = {
          id: manifest.id,
          name: manifest.name,
          version: manifest.version,
          status: manifest.status,
          category,
          governedBy: manifest.governedBy || null,
          specifiedBy: manifest.specifiedBy || null,
          description: manifest.description || null,
          lifecycleStage: manifest.lifecycleStage || 'Proposal',
          anatomy: manifest.anatomy || [],
          variants: manifest.variants || [],
          states: manifest.states || [],
          tokenDependencies: manifest.tokenDependencies || [],
          assetDependencies: manifest.assetDependencies || [],
          componentDependencies: manifest.componentDependencies || [],
          platforms: manifest.platforms || [],
          accessibility: manifest.accessibility || null,
          replacedBy: manifest.replacedBy || null,
          tags: manifest.tags || [],
          meta: {
            documentation: manifest.documentation || null,
            playground: manifest.playground || null,
            examples: manifest.examples || null,
            coverage: manifest.coverage || null,
            wcag: manifest.wcag || 'AA',
            weight: manifest.weight || 1,
            complexity: manifest.complexity || 'medium',
            estimatedEffort: manifest.estimatedEffort || 'M'
          }
        };

        if (!registry.components[category]) {
          registry.components[category] = [];
        }
        registry.components[category].push(compEntry);
        registry.meta.totalComponents++;

        if (!registry.meta.categories[category]) {
          registry.meta.categories[category] = 0;
        }
        registry.meta.categories[category]++;
      }
    }
  }

  const output = JSON.stringify(registry, null, 2) + '\n';
  fs.writeFileSync(OUTPUT_FILE, output);

  return output;
};
