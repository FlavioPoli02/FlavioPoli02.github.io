import { Injectable } from '@angular/core';

type Theme = 'dark' | 'light';
const KEY = 'portfolio-theme';

@Injectable({ providedIn: 'root' })
export class ThemeService {
  private current: Theme = 'dark';

  constructor() {
    this.current = this.read() ?? (typeof matchMedia === 'function' && matchMedia('(prefers-color-scheme: light)').matches ? 'light' : 'dark');
    this.apply();
  }

  toggle() {
    this.current = this.current === 'dark' ? 'light' : 'dark';
    this.apply();
    try { localStorage.setItem(KEY, this.current); } catch { /* storage non disponibile */ }
  }

  isDark(): boolean {
    return this.current === 'dark';
  }

  private read(): Theme | null {
    try {
      const v = localStorage.getItem(KEY);
      return v === 'dark' || v === 'light' ? v : null;
    } catch {
      return null;
    }
  }

  private apply() {
    const root = document.documentElement;
    root.setAttribute('data-theme', this.current);
    root.style.colorScheme = this.current;
  }
}
