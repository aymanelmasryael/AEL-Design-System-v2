/* AEL Runtime — Base Component */

import { emit } from './event-bus.js';
import { $ } from './dom.js';

export class Component {
  constructor(element) {
    if (!element) throw new Error('AEL Component requires a DOM element');
    this.el = element;
    this._handlers = [];
    this._untrapFocus = null;
  }

  on(evt, selector, handler) {
    const fn = (e) => {
      const target = selector ? e.target.closest(selector) : null;
      if (selector && !target) return;
      handler.call(this, e, target || e.target);
    };
    this.el.addEventListener(evt, fn);
    this._handlers.push({ evt, fn });
    return this;
  }

  emit(name, detail = {}) {
    this.el.dispatchEvent(new CustomEvent(`ael:${name}`, { bubbles: true, detail }));
    emit(`ael:${name}`, detail);
  }

  show() { this.el.hidden = false; this.emit('open'); }
  hide() { this.el.hidden = true; this.emit('close'); }
  toggle() { this.el.hidden ? this.show() : this.hide(); }

  find(selector) { return $(selector, this.el); }
  findAll(selector) { return [...this.el.querySelectorAll(selector)]; }

  trapFocus() {
    const focusable = this.findAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])')
      .filter(e => !e.disabled && !e.hidden && e.offsetParent !== null);
    const first = focusable[0];
    const last = focusable[focusable.length - 1];
    if (!first) return;

    const handler = (e) => {
      if (e.key !== 'Tab') return;
      if (e.shiftKey && document.activeElement === first) { e.preventDefault(); last.focus(); }
      else if (!e.shiftKey && document.activeElement === last) { e.preventDefault(); first.focus(); }
    };

    this.el.addEventListener('keydown', handler);
    first.focus();
    this._untrapFocus = () => this.el.removeEventListener('keydown', handler);
  }

  releaseFocus() {
    if (this._untrapFocus) { this._untrapFocus(); this._untrapFocus = null; }
  }

  destroy() {
    this._handlers.forEach(({ evt, fn }) => this.el.removeEventListener(evt, fn));
    this._handlers = [];
    this.releaseFocus();
  }
}
