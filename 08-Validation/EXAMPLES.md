# AEL Examples

## Button

```html
<button class="ael-button ael-button--primary ael-button--md">Save Changes</button>
<button class="ael-button ael-button--outline ael-button--sm">
  <svg class="ael-button__icon">...</svg> Add Item
</button>
<button class="ael-button ael-button--primary ael-button--md" disabled>Submit</button>
```

## Form

```html
<div class="ael-input">
  <label class="ael-input__label" for="email">Email</label>
  <input class="ael-input__field" id="email" type="email">
  <span class="ael-input__helper">We will never share your email.</span>
</div>
```

## Card + Grid

```html
<div class="ael-grid ael-grid--3">
  <div class="ael-card">
    <div class="ael-card__header">Title</div>
    <div class="ael-card__body">Content</div>
  </div>
</div>
```

## Page Shell

```html
<div class="ael-page">
  <aside class="ael-sidebar ael-page__sidebar">...</aside>
  <main class="ael-page__main">
    <nav class="ael-navbar">...</nav>
    <div class="ael-page__content">...</div>
  </main>
</div>
```
