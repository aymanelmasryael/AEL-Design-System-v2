/* AEL Runtime — Bootstrap */

import { Modal } from './behaviors/modal.js';
import { Drawer } from './behaviors/drawer.js';
import { Tabs } from './behaviors/tabs.js';
import { Accordion } from './behaviors/accordion.js';
import { Menu } from './behaviors/menu.js';
import { Toast } from './behaviors/toast.js';
import { Tooltip } from './behaviors/tooltip.js';

const registry = new Map();

export function register(name, ComponentClass) {
  registry.set(name, ComponentClass);
}

export function initAll() {
  const instances = [];

  document.querySelectorAll('.ael-modal').forEach(el => instances.push(new Modal(el)));
  document.querySelectorAll('.ael-drawer').forEach(el => instances.push(new Drawer(el)));
  document.querySelectorAll('.ael-tabs').forEach(el => instances.push(new Tabs(el)));
  document.querySelectorAll('.ael-accordion').forEach(el => instances.push(new Accordion(el)));
  document.querySelectorAll('.ael-menu[data-ael-menu-trigger]').forEach(el => instances.push(new Menu(el)));
  document.querySelectorAll('.ael-toast').forEach(el => instances.push(new Toast(el)));
  document.querySelectorAll('.ael-tooltip').forEach(el => instances.push(new Tooltip(el)));

  return instances;
}

if (document.readyState === 'loading') {
  document.addEventListener('DOMContentLoaded', initAll);
} else {
  initAll();
}
