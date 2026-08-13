module.exports = function() {
  const tokens = JSON.parse(process.env.AEL_TOKENS);

  const api = {
    name: 'AEL Design System — JSON API',
    version: '0.2',
    generatedBy: '09-Build/generators/json-generator.js',
    source: '06-Implementation/tokens/',
    description: 'Flat JSON API of all design tokens for programmatic consumption.',
    tokens: {}
  };

  for (const tok of Object.values(tokens).sort((a, b) => a.id.localeCompare(b.id))) {
    api.tokens[tok.id] = {
      value: tok.value,
      type: tok.type,
      category: tok.category,
      role: tok.role
    };
  }

  return api;
};
