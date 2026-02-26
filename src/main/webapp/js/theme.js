(() => {
  const STORAGE_KEY = 'acebank-theme'; // 'light' | 'dark'

  const getPreferredTheme = () => {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved === 'light' || saved === 'dark') return saved;

    const prefersDark = window.matchMedia?.('(prefers-color-scheme: dark)')?.matches;
    return prefersDark ? 'dark' : 'light';
  };

  const applyTheme = (theme) => {
    const body = document.body;
    if (!body) return;

    const isDark = theme === 'dark';
    body.classList.toggle('dark-theme', isDark);
    body.dataset.theme = isDark ? 'dark' : 'light';

    document.querySelectorAll('[data-theme-toggle]').forEach((btn) => {
      btn.setAttribute('aria-pressed', String(isDark));
      btn.setAttribute('data-theme-state', isDark ? 'dark' : 'light');
    });
  };

  const setTheme = (theme) => {
    localStorage.setItem(STORAGE_KEY, theme);
    applyTheme(theme);
  };

  const toggleTheme = () => {
    const isDark = document.body?.classList.contains('dark-theme');
    setTheme(isDark ? 'light' : 'dark');
  };

  const initTheme = () => {
    applyTheme(getPreferredTheme());

    document.querySelectorAll('[data-theme-toggle]').forEach((btn) => {
      btn.addEventListener('click', toggleTheme);
    });
  };

  window.toggleTheme = toggleTheme;
  window.setTheme = setTheme;

  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initTheme);
  } else {
    initTheme();
  }
})();
