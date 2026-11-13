(() => {
  const root = document.documentElement;
  const system = matchMedia('(prefers-color-scheme: dark)');
  const valid = value => ['system', 'light', 'dark'].includes(value);
  let preference = 'system';
  try {
    const saved = localStorage.getItem('blog-theme');
    if (valid(saved)) preference = saved;
  } catch {}

  function apply() {
    if (preference === 'system') root.removeAttribute('data-theme');
    else root.dataset.theme = preference;
    const dark = preference === 'dark' || (preference === 'system' && system.matches);
    document.querySelectorAll('meta[name="theme-color"]').forEach(meta => {
      meta.content = dark ? '#0d1320' : '#f7f9fd';
    });
    const toggle = document.querySelector('#theme-toggle');
    if (toggle) {
      const label = `Theme: ${dark ? 'Dark' : 'Light'}. Switch to ${dark ? 'Light' : 'Dark'}.`;
      toggle.firstElementChild.textContent = dark ? '🌙' : '☀️';
      toggle.setAttribute('aria-label', label);
      toggle.title = label;
    }
  }

  apply();
  system.addEventListener('change', apply);
  document.addEventListener('DOMContentLoaded', () => {
    const toggle = document.querySelector('#theme-toggle');
    toggle.addEventListener('click', () => {
      const dark = preference === 'dark' || (preference === 'system' && system.matches);
      preference = dark ? 'light' : 'dark';
      apply();
      try { localStorage.setItem('blog-theme', preference); } catch {}
    });
    apply();
    toggle.hidden = false;
  });
})();
