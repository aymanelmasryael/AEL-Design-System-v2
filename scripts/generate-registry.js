#!/usr/bin/env node

const fs = require('fs');
const path = require('path');

const TOKENS_DIR = path.join(__dirname, '..', '06-Implementation', 'tokens');
const OUTPUT_FILE = path.join(__dirname, '..', '07-Registry', 'token-registry.json');

const tokenFiles = fs.readdirSync(TOKENS_DIR).filter(f => f.endsWith('.json'));

const registry = {
  registry: 'AEL Design Token Registry',
  version: '0.2',
  status: 'Draft',
  owner: 'AEL Digital Studio',
  generated: true,
  source: '06-Implementation/tokens/',
  generatedAt: new Date().toISOString(),
  description: 'Generated catalog — DO NOT EDIT. This file is produced from 06-Implementation/tokens/ by generate-registry.js. All token values are SSOT in their respective Implementation files. See PROP-2026-001.',
  governedBy: [
    'AEL-Constitution v0.2',
    'Naming-Convention-Law v0.2',
    'S-Color v0.2',
    'S-Typography',
    'S-Spacing v0.2',
    'S-Grid',
    'S-Component',
    'S-Icon'
  ],
  tokens: {},
  dependencyGraph: {
    specifications: {},
    standards: {}
  },
  compliance: {
    namingConvention: 'Naming-Convention-Law v0.2 §4.3',
    tokenPattern: 'TK-{category}-{property}-{variant}',
    tiers: {
      core: ['color', 'typography', 'spacing', 'radius', 'shadow', 'border', 'motion', 'opacity'],
      layout: ['breakpoint', 'grid', 'zindex', 'elevation'],
      optional: ['blur', 'size', 'icon']
    },
    maxIdLength: 64,
    reservedCharacters: './#%&+'
  }
};

let totalTokens = 0;
const uniqueCategories = new Set();

for (const file of tokenFiles) {
  const filePath = path.join(TOKENS_DIR, file);
  const data = JSON.parse(fs.readFileSync(filePath, 'utf8'));
  const category = data.category;
  const domain = data.domain || null;
  const count = Object.keys(data.tokens).length;

  uniqueCategories.add(category);

  const tokenEntries = Object.entries(data.tokens).map(([id, token]) => {
    const entry = {
      id,
      value: token.value,
      type: token.type,
      role: token.role,
      tier: data.tier || 'core'
    };
    if (domain) entry.domain = domain;
    return entry;
  });

  if (registry.tokens[category]) {
    registry.tokens[category] = registry.tokens[category].concat(tokenEntries);
  } else {
    registry.tokens[category] = tokenEntries;
  }

  const spec = data.specifiedBy || null;
  const standard = data.governedBy || null;

  if (spec) {
    if (!registry.dependencyGraph.specifications[spec]) {
      registry.dependencyGraph.specifications[spec] = [];
    }
    if (!registry.dependencyGraph.specifications[spec].includes(category)) {
      registry.dependencyGraph.specifications[spec].push(category);
    }
  }

  if (standard) {
    const stdName = standard.split(' ')[0];
    if (!registry.dependencyGraph.standards[stdName]) {
      registry.dependencyGraph.standards[stdName] = [];
    }
    if (!registry.dependencyGraph.standards[stdName].includes(category)) {
      registry.dependencyGraph.standards[stdName].push(category);
    }
  }

  totalTokens += count;
}

registry.meta = {
  created: '2026-07-31',
  generated: new Date().toISOString(),
  totalTokens,
  files: tokenFiles.length,
  categories: uniqueCategories.size,
  tiers: {
    core: tokenFiles.filter(f => {
      const d = JSON.parse(fs.readFileSync(path.join(TOKENS_DIR, f), 'utf8'));
      return d.tier === 'core';
    }).length,
    layout: tokenFiles.filter(f => {
      const d = JSON.parse(fs.readFileSync(path.join(TOKENS_DIR, f), 'utf8'));
      return d.tier === 'layout';
    }).length,
    optional: tokenFiles.filter(f => {
      const d = JSON.parse(fs.readFileSync(path.join(TOKENS_DIR, f), 'utf8'));
      return d.tier === 'optional';
    }).length
  },
  nextReview: 'v0.3'
};

fs.writeFileSync(OUTPUT_FILE, JSON.stringify(registry, null, 2) + '\n');

console.log(`Registry generated: ${OUTPUT_FILE}`);
console.log(`  Files: ${tokenFiles.length} | Categories: ${uniqueCategories.size}`);
console.log(`  Total tokens: ${totalTokens}`);
console.log(`  Tiers: Core (${registry.meta.tiers.core}) | Layout (${registry.meta.tiers.layout}) | Optional (${registry.meta.tiers.optional})`);
