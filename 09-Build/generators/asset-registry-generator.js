const fs = require('fs');
const path = require('path');

const ASSETS_DIR = path.join(__dirname, '..', '..', '06-Implementation', 'assets');
const OUTPUT_FILE = path.join(__dirname, '..', '..', '07-Registry', 'asset-registry.json');

const ASSET_CATEGORIES = ['icons', 'logos', 'illustrations', 'images', 'patterns'];

module.exports = function() {
  const registry = {
    registry: 'AEL Asset Registry',
    version: '0.2',
    status: 'Draft',
    owner: 'AEL Digital Studio',
    generated: true,
    generatedBy: '09-Build/generators/asset-registry-generator.js',
    source: '06-Implementation/assets/',
    generatedAt: new Date().toISOString(),
    description: 'Generated catalog — DO NOT EDIT. Produced from 06-Implementation/assets/ manifest files. See PROP-2026-001.',
    governedBy: ['S-Icon', 'S-Illustration', 'S-Image'],
    assets: {},
    meta: { totalAssets: 0, categories: {} }
  };

  for (const category of ASSET_CATEGORIES) {
    const catDir = path.join(ASSETS_DIR, category);
    if (!fs.existsSync(catDir)) continue;

    const manifests = fs.readdirSync(catDir).filter(f => f.endsWith('.manifest.json'));
    if (manifests.length === 0) continue;

    registry.assets[category] = [];
    registry.meta.categories[category] = manifests.length;

    for (const mf of manifests) {
      const manifest = JSON.parse(fs.readFileSync(path.join(catDir, mf), 'utf8'));

      const sourceFile = manifest.source ? manifest.source.replace(/^.*[\\/]/, '') : null;
      const sourceExists = sourceFile ? fs.existsSync(path.join(catDir, sourceFile)) : false;

      const entry = {
        id: manifest.id,
        name: manifest.name,
        version: manifest.version,
        status: manifest.status,
        category: manifest.category,
        governedBy: manifest.governedBy,
        specifiedBy: manifest.specifiedBy,
        description: manifest.description || null,
        source: manifest.source,
        sourceAvailable: sourceExists,
        variants: manifest.variants || {},
        platforms: manifest.platforms || [],
        tags: manifest.tags || [],
        relatedTokens: manifest.relatedTokens || [],
        replacedBy: manifest.replacedBy || null
      };

      if (!sourceExists && sourceFile) {
        entry.warning = `Source file "${sourceFile}" referenced in manifest but not found in ${category}/`;
      }

      registry.assets[category].push(entry);
      registry.meta.totalAssets++;
    }
  }

  const output = JSON.stringify(registry, null, 2) + '\n';
  fs.writeFileSync(OUTPUT_FILE, output);

  return output;
};
