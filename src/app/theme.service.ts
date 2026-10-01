import { Injectable } from '@angular/core';

type Theme = 'dark' | 'light';
const KEY = 'portfolio-theme';
const META_COLOR: Record<Theme, string> = { light: '#f6f5f1', dark: '#0a0a0a' };

/** Tema chiaro di default; il tema scuro è una scelta esplicita del visitatore, ricordata in localStorage. */
@Injectable({ providedIn: 'root' })
export class ThemeService {
  private current: Theme = this.read();

  constructor() {
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

  private read(): Theme {
    try {
      return localStorage.getItem(KEY) === 'dark' ? 'dark' : 'light';
    } catch {
      return 'light';
    }
  }

  private apply() {
    const root = document.documentElement;
    root.setAttribute('data-theme', this.current);
    root.style.colorScheme = this.current;
    document.querySelector('meta[name="theme-color"]')?.setAttribute('content', META_COLOR[this.current]);
  }
}
