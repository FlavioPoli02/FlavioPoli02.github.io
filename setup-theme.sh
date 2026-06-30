#!/bin/bash
# ============================================================
# Theme Toggle Setup — Flavio Poli Portfolio
# Esegui da: ~/Documents/Progetti/Portfolio/portfolio
# Comando: bash setup-theme.sh
# ============================================================

echo "🎨 Aggiunta tema chiaro/scuro..."

# ============================================================
# 1. STYLES.CSS — aggiunge variabili tema chiaro + transizioni
# ============================================================
cat > src/styles.css << 'ENDOFFILE'
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600&family=JetBrains+Mono:wght@400;500&display=swap');

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  /* Tema scuro (default) */
  --bg:          #0A0A0F;
  --surface:     #111118;
  --surface-2:   #18181F;
  --accent:      #4F7EFF;
  --accent-glow: rgba(79, 126, 255, 0.12);
  --hero-glow:   rgba(79, 126, 255, 0.14);
  --text-1:      #EEEEF5;
  --text-2:      #8A8AA8;
  --text-3:      #4A4A62;
  --border:      rgba(255, 255, 255, 0.07);
  --font-display: 'Space Grotesk', sans-serif;
  --font-body:    'Inter', sans-serif;
  --font-mono:    'JetBrains Mono', monospace;
  --max-w:       1100px;
  --section-pad: 6rem 1.5rem;
}

[data-theme="light"] {
  --bg:          #F4F4F8;
  --surface:     #FFFFFF;
  --surface-2:   #EAEAF0;
  --accent:      #3060E0;
  --accent-glow: rgba(48, 96, 224, 0.1);
  --hero-glow:   rgba(48, 96, 224, 0.09);
  --text-1:      #0A0A14;
  --text-2:      #4A4A6A;
  --text-3:      #9090AA;
  --border:      rgba(0, 0, 0, 0.08);
}

/* Transizione fluida solo durante il cambio tema */
.theme-switching *,
.theme-switching *::before,
.theme-switching *::after {
  transition:
    background-color 0.35s ease,
    color            0.35s ease,
    border-color     0.35s ease !important;
}

html { scroll-behavior: smooth; }

body {
  background: var(--bg);
  color: var(--text-1);
  font-family: var(--font-body);
  font-size: 1rem;
  line-height: 1.6;
  -webkit-font-smoothing: antialiased;
}

::selection { background: var(--accent); color: white; }

::-webkit-scrollbar { width: 5px; }
::-webkit-scrollbar-track { background: var(--bg); }
::-webkit-scrollbar-thumb { background: var(--text-3); border-radius: 3px; }
ENDOFFILE

# ============================================================
# 2. THEME SERVICE — nuovo file
# ============================================================
cat > src/app/theme.service.ts << 'ENDOFFILE'
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
ENDOFFILE

# ============================================================
# 3. NAVBAR.TS — inietta ThemeService
# ============================================================
cat > src/app/components/navbar/navbar.ts << 'ENDOFFILE'
import { Component, HostListener } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ThemeService } from '../../theme.service';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.css'
})
export class Navbar {
  scrolled = false;

  constructor(public theme: ThemeService) {}

  @HostListener('window:scroll')
  onScroll() {
    this.scrolled = window.scrollY > 60;
  }

  scrollTo(id: string) {
    document.getElementById(id)?.scrollIntoView({ behavior: 'smooth' });
  }
}
ENDOFFILE

# ============================================================
# 4. NAVBAR.HTML — aggiunge il toggle
# ============================================================
cat > src/app/components/navbar/navbar.html << 'ENDOFFILE'
<nav [class.scrolled]="scrolled">
  <div class="nav-inner">
    <span class="logo" (click)="scrollTo('home')">FP</span>
    <div class="nav-right">
      <ul class="nav-links">
        <li><button (click)="scrollTo('about')">About</button></li>
        <li><button (click)="scrollTo('skills')">Skills</button></li>
        <li><button (click)="scrollTo('experience')">Esperienza</button></li>
        <li><button (click)="scrollTo('contact')" class="cta-nav">Contattami</button></li>
      </ul>
      <button
        class="theme-toggle"
        (click)="theme.toggle()"
        [title]="theme.isDark() ? 'Passa al tema chiaro' : 'Passa al tema scuro'"
        [attr.aria-label]="theme.isDark() ? 'Attiva tema chiaro' : 'Attiva tema scuro'"
      >
        <span class="icon-sun">☀</span>
        <span class="icon-moon">☾</span>
        <span class="toggle-thumb" [class.light]="!theme.isDark()"></span>
      </button>
    </div>
  </div>
</nav>
ENDOFFILE

# ============================================================
# 5. NAVBAR.CSS — stile toggle + nav-right
# ============================================================
cat > src/app/components/navbar/navbar.css << 'ENDOFFILE'
nav {
  position: fixed;
  top: 0; left: 0; right: 0;
  z-index: 100;
  padding: 1.25rem 1.5rem;
  transition: background 0.3s ease, border-bottom 0.3s ease, padding 0.3s ease;
}

nav.scrolled {
  background: rgba(10, 10, 15, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border);
  padding: 0.875rem 1.5rem;
}

[data-theme="light"] nav.scrolled {
  background: rgba(244, 244, 248, 0.88);
}

.nav-inner {
  max-width: var(--max-w);
  margin: 0 auto;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.logo {
  font-family: var(--font-display);
  font-size: 1.25rem;
  font-weight: 700;
  color: var(--accent);
  cursor: pointer;
  letter-spacing: -0.02em;
  user-select: none;
}

.nav-right {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

.nav-links {
  display: flex;
  align-items: center;
  gap: 0.25rem;
  list-style: none;
}

.nav-links button {
  background: none;
  border: none;
  color: var(--text-2);
  font-family: var(--font-body);
  font-size: 0.9rem;
  font-weight: 500;
  cursor: pointer;
  padding: 0.5rem 0.875rem;
  border-radius: 6px;
  transition: color 0.2s, background 0.2s;
}

.nav-links button:hover {
  color: var(--text-1);
  background: var(--surface-2);
}

.cta-nav {
  border: 1px solid var(--accent) !important;
  color: var(--accent) !important;
}

.cta-nav:hover {
  background: var(--accent-glow) !important;
}

/* ---- Theme Toggle ---- */
.theme-toggle {
  position: relative;
  width: 52px;
  height: 28px;
  border-radius: 14px;
  background: var(--surface-2);
  border: 1px solid var(--border);
  cursor: pointer;
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 6px;
  flex-shrink: 0;
  transition: background 0.25s, border-color 0.25s;
}

.theme-toggle:hover {
  border-color: var(--text-3);
}

.icon-sun,
.icon-moon {
  font-size: 0.7rem;
  line-height: 1;
  color: var(--text-3);
  z-index: 1;
  pointer-events: none;
  transition: color 0.25s;
}

.icon-sun  { color: var(--text-3); }
.icon-moon { color: var(--accent); }

[data-theme="light"] .icon-sun  { color: var(--accent); }
[data-theme="light"] .icon-moon { color: var(--text-3); }

.toggle-thumb {
  position: absolute;
  top: 3px;
  left: 3px;
  width: 20px;
  height: 20px;
  border-radius: 50%;
  background: var(--accent);
  transition: transform 0.28s cubic-bezier(0.34, 1.56, 0.64, 1);
  pointer-events: none;
}

.toggle-thumb.light {
  transform: translateX(24px);
}

@media (max-width: 600px) {
  .nav-links button { padding: 0.4rem 0.6rem; font-size: 0.82rem; }
  .theme-toggle { width: 46px; height: 26px; }
  .toggle-thumb.light { transform: translateX(20px); }
}
ENDOFFILE

# ============================================================
# 6. HERO.CSS — usa --hero-glow (variabile tema)
# ============================================================
cat > src/app/components/hero/hero.css << 'ENDOFFILE'
section {
  min-height: 100vh;
  display: flex;
  align-items: center;
  position: relative;
  padding: 7rem 1.5rem 4rem;
  overflow: hidden;
  opacity: 0;
  transform: translateY(24px);
  transition: opacity 0.9s ease, transform 0.9s ease;
}

section.visible {
  opacity: 1;
  transform: translateY(0);
}

.hero-bg {
  position: absolute;
  inset: 0;
  background: radial-gradient(ellipse 80% 55% at 50% -5%, var(--hero-glow) 0%, transparent 70%);
  pointer-events: none;
}

.hero-inner {
  max-width: var(--max-w);
  margin: 0 auto;
  position: relative;
  z-index: 1;
}

.eyebrow {
  font-family: var(--font-mono);
  font-size: 0.88rem;
  color: var(--accent);
  letter-spacing: 0.1em;
  display: block;
  margin-bottom: 1rem;
}

.name {
  font-family: var(--font-display);
  font-size: clamp(3.2rem, 9vw, 7rem);
  font-weight: 700;
  line-height: 0.92;
  letter-spacing: -0.03em;
  color: var(--text-1);
  margin-bottom: 1.25rem;
}

.role {
  display: flex;
  align-items: center;
  gap: 2px;
  font-size: clamp(1.05rem, 2.5vw, 1.4rem);
  color: var(--text-2);
  margin-bottom: 1.75rem;
}

.mono { font-family: var(--font-mono); }

.cursor {
  color: var(--accent);
  font-family: var(--font-mono);
  animation: blink 1.1s step-end infinite;
}

@keyframes blink {
  0%, 100% { opacity: 1; }
  50%       { opacity: 0; }
}

.desc {
  font-size: 1.05rem;
  color: var(--text-2);
  line-height: 1.75;
  max-width: 500px;
  margin-bottom: 2.75rem;
}

.desc strong {
  color: var(--text-1);
  font-weight: 500;
}

.hero-ctas {
  display: flex;
  gap: 1rem;
  flex-wrap: wrap;
}

.btn-primary {
  display: inline-block;
  padding: 0.9rem 1.8rem;
  background: var(--accent);
  color: #fff;
  text-decoration: none;
  border-radius: 8px;
  font-weight: 600;
  font-size: 0.95rem;
  transition: opacity 0.2s, transform 0.2s;
}

.btn-primary:hover {
  opacity: 0.85;
  transform: translateY(-2px);
}

.btn-secondary {
  display: inline-block;
  padding: 0.9rem 1.8rem;
  background: transparent;
  color: var(--text-1);
  text-decoration: none;
  border-radius: 8px;
  font-weight: 500;
  font-size: 0.95rem;
  border: 1px solid var(--border);
  transition: border-color 0.2s, background 0.2s, transform 0.2s;
}

.btn-secondary:hover {
  border-color: var(--text-3);
  background: var(--surface-2);
  transform: translateY(-2px);
}
ENDOFFILE

echo ""
echo "✅ Tema chiaro/scuro aggiunto!"
echo ""
echo "📌 Il toggle è nella navbar (in alto a destra)"
echo "💾 La preferenza viene salvata automaticamente"
echo "   (localStorage key: 'portfolio-theme')"
echo ""
echo "▶  Esegui: ng serve"
echo ""
