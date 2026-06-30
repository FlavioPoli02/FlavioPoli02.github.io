import { Injectable } from '@angular/core';

@Injectable({ providedIn: 'root' })
export class ThemeService {
  private current: 'dark' | 'light' = 'dark';

  constructor() {
    const saved = localStorage.getItem('portfolio-theme') as 'dark' | 'light' | null;
    this.current = saved ?? 'dark';
    this.apply();
  }

  toggle() {
    document.documentElement.classList.add('theme-switching');
    this.current = this.current === 'dark' ? 'light' : 'dark';
    this.apply();
    localStorage.setItem('portfolio-theme', this.current);
    setTimeout(() => document.documentElement.classList.remove('theme-switching'), 400);
  }

  isDark(): boolean {
    return this.current === 'dark';
  }

  private apply() {
    document.documentElement.setAttribute('data-theme', this.current);
  }
}
