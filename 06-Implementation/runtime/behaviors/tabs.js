/* AEL Runtime — Tabs Behavior */

import { Component } from '../core/component.js';

export class Tabs extends Component {
  constructor(element) {
    super(element);
    const tabs = this.findAll('.ael-tabs__tab');
    tabs.forEach(tab => {
      tab.addEventListener('click', () => {
        tabs.forEach(t => t.classList.remove('ael-tabs__tab--active'));
        tab.classList.add('ael-tabs__tab--active');
        const panelId = tab.getAttribute('data-ael-tab');
        if (panelId) {
          document.querySelectorAll('[data-ael-tab-panel]').forEach(p => p.hidden = true);
          const panel = document.getElementById(panelId);
          if (panel) panel.hidden = false;
        }
        this.emit('tab:change', { tab });
      });
    });
  }
}
