module.exports = function() {
  const tokens = JSON.parse(process.env.AEL_TOKENS);

  const figma = {
    name: 'AEL Design System',
    version: '0.2',
    generatedBy: '09-Build/generators/figma-generator.js',
    source: '06-Implementation/tokens/',
    tokens: []
  };

  const tokenList = Object.values(tokens).sort((a, b) => a.id.localeCompare(b.id));

  for (const tok of tokenList) {
    const figmaToken = {
      name: tok.id,
      description: tok.role,
      type: null,
      value: tok.value
    };

    switch (tok.type) {
      case 'color':
        figmaToken.type = 'color';
        break;
      case 'dimension':
        figmaToken.type = 'dimension';
        break;
      case 'number':
        figmaToken.type = 'number';
        break;
      case 'fontFamily':
        figmaToken.type = 'fontFamily';
        figmaToken.value = tok.value.split(',')[0].trim().replace(/'/g, '');
        break;
      case 'duration':
        figmaToken.type = 'number';
        figmaToken.value = parseFloat(tok.value);
        break;
      case 'easing':
        figmaToken.type = 'string';
        break;
      case 'shadow':
        figmaToken.type = 'shadow';
        break;
      default:
        figmaToken.type = 'string';
    }

    figma.tokens.push(figmaToken);
  }

  return figma;
};
