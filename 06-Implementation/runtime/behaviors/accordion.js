/* AEL Runtime — Accordion Behavior */

import { Component } from '../core/component.js';

export class Accordion extends Component {
  constructor(element) {
    super(element);
    this.on('click', '.ael-accordion__trigger', (e, trigger) => {
      const item = trigger.closest('.ael-accordion__item');
      const isOpen = item.classList.contains('ael-accordion__item--open');
      item.classList.toggle('ael-accordion__item--open', !isOpen);
      this.emit('accordion:toggle', { open: !isOpen });
    });
  }
}
