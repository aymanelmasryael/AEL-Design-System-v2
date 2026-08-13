module.exports = function() {
  const tokens = JSON.parse(process.env.AEL_TOKENS);

  const w3c = {
    $schema: 'https://tr.designtokens.org/format.json',
    name: 'AEL Design System',
    version: '0.2',
    generatedBy: '09-Build/generators/w3c-generator.js',
    source: '06-Implementation/tokens/'
  };

  const categorized = {};
  for (const tok of Object.values(tokens)) {
    const parts = tok.id.replace('TK-', '').split('-');
    const group = parts[0];
    if (!categorized[group]) categorized[group] = {};
    const subKey = parts.slice(1).join('-');
    categorized[group][subKey] = tok;
  }

  for (const [group, groupTokens] of Object.entries(categorized)) {
    w3c[group] = {};
    for (const [key, tok] of Object.entries(groupTokens).sort((a, b) => a[0].localeCompare(b[0]))) {
      w3c[group][key] = {
        $value: tok.value,
        $type: tok.type,
        $description: tok.role
      };
    }
  }

  return w3c;
};
