/* AEL Compiler — Diagnostics
 * Error, warning, and suggestion collection during compilation.
 */

class CompilerDiagnostics {
  constructor() {
    this.errors = [];
    this.warnings = [];
    this.suggestions = [];
  }

  error(message, stage, detail = null) {
    this.errors.push({ stage, message, detail });
  }

  warn(message, stage, detail = null) {
    this.warnings.push({ stage, message, detail });
  }

  suggest(message, stage, detail = null) {
    this.suggestions.push({ stage, message, detail });
  }

  hasErrors() { return this.errors.length > 0; }

  report() {
    const lines = [];
    if (this.errors.length) {
      lines.push(`Errors (${this.errors.length}):`);
      this.errors.forEach(e => lines.push(`  [${e.stage}] ${e.message}${e.detail ? ': ' + JSON.stringify(e.detail) : ''}`));
    }
    if (this.warnings.length) {
      lines.push(`Warnings (${this.warnings.length}):`);
      this.warnings.forEach(w => lines.push(`  [${w.stage}] ${w.message}`));
    }
    if (this.suggestions.length) {
      lines.push(`Suggestions (${this.suggestions.length}):`);
      this.suggestions.forEach(s => lines.push(`  [${s.stage}] ${s.message}`));
    }
    return lines.join('\n');
  }
}

function validateIR(ir, diagnostics) {
  const diag = diagnostics || new CompilerDiagnostics();

  if (!ir) { diag.error('IR is null', 'ir-builder'); return diag; }
  if (ir.version !== '1.0') diag.warn(`IR version ${ir.version}, expected 1.0`, 'ir-builder');
  if (!ir.component?.id) diag.error('Missing component.id', 'ir-builder');
  if (!ir.tree) diag.error('Missing IR tree', 'ir-builder');

  if (ir.meta?.isOverlay && !ir.meta.events?.find(e => e.trigger === 'button')) {
    diag.suggest('Overlay has no close button. Consider adding one for accessibility.', 'ir-builder', { component: ir.component?.id });
  }

  const slots = ir.meta?.slots || [];
  if (slots.length === 0 && ir.component?.id) {
    diag.warn('Component has no slots. Consider adding at least one.', 'semantic-builder', { component: ir.component.id });
  }

  return diag;
}

module.exports = { CompilerDiagnostics, validateIR };
