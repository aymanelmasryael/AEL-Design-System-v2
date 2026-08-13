/* AEL Runtime — Drawer Behavior */

import { Component } from '../core/component.js';

export class Drawer extends Component {
  constructor(element) {
    super(element);
    const backdrop = this.find('.ael-drawer__backdrop');
    const triggerAttr = element.getAttribute('data-ael-drawer');
    if (triggerAttr) {
      document.querySelectorAll(`[data-ael-trigger="${triggerAttr}"]`).forEach(t => {
        t.addEventListener('click', () => this.open());
      });
    }
    if (backdrop) backdrop.addEventListener('click', (e) => {
      if (e.target === backdrop) this.close();
    });
  }

  open() { this.show(); this.trapFocus(); }
  close() { this.hide(); this.releaseFocus(); }
}
