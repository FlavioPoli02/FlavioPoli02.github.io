#!/bin/bash
# ============================================================
# Fix Script — Hero invisibile + Linea navbar in scroll
# Esegui da: ~/Documents/Progetti/Portfolio/portfolio
# Comando: bash setup-fixes.sh
# ============================================================

echo "🔧 Applico i fix..."

# ============================================================
# 1. HERO.TS — rimuove la dipendenza da setTimeout/visible
# ============================================================
cat > src/app/components/hero/hero.ts << 'ENDOFFILE'
import { Component } from '@angular/core';

@Component({
  selector: 'app-hero',
  standalone: true,
  templateUrl: './hero.html',
  styleUrl: './hero.css'
})
export class Hero {}
ENDOFFILE

# ============================================================
# 2. HERO.HTML — rimuove [class.visible], aggiunge hero-grid
# ============================================================
cat > src/app/components/hero/hero.html << 'ENDOFFILE'
<section id="home">
  <div class="hero-bg"></div>
  <div class="hero-grid"></div>
  <div class="hero-inner">
    <span class="eyebrow">Ciao, sono</span>
    <h1 class="name">Flavio Poli</h1>
    <p class="role">
      <span class="mono">Full Stack Developer</span>
      <span class="cursor">_</span>
    </p>
    <p class="desc">
      Specializzato in <strong>Angular</strong> e <strong>ASP.NET</strong> con C#.<br />
      Appassionato di architetture web pulite e codice ben strutturato.
    </p>
    <div class="hero-ctas">
      <a href="#experience" class="btn-primary">Vedi i miei progetti</a>
      <a href="#contact" class="btn-secondary">Contattami</a>
    </div>
  </div>
</section>
ENDOFFILE

# ============================================================
# 3. HERO.CSS — animazione 100% CSS + dot-grid + doppio glow
# ============================================================
cat > src/app/components/hero/hero.css << 'ENDOFFILE'
section {
  min-height: 100vh;
  display: flex;
  align-items: center;
  position: relative;
  padding: 7rem 1.5rem 4rem;
  overflow: hidden;
}

.hero-bg {
  position: absolute;
  inset: 0;
  background:
    radial-gradient(ellipse 60% 50% at 20% 15%, var(--hero-glow) 0%, transparent 60%),
    radial-gradient(ellipse 55% 45% at 88% 85%, var(--accent-glow) 0%, transparent 60%);
  pointer-events: none;
}

.hero-grid {
  position: absolute;
  inset: 0;
  background-image: radial-gradient(circle, var(--text-3) 1.2px, transparent 1.2px);
  background-size: 30px 30px;
  opacity: 0.35;
  mask-image: radial-gradient(ellipse 65% 55% at 50% 20%, black 20%, transparent 75%);
  -webkit-mask-image: radial-gradient(ellipse 65% 55% at 50% 20%, black 20%, transparent 75%);
  pointer-events: none;
}

.hero-inner {
  max-width: var(--max-w);
  margin: 0 auto;
  position: relative;
  z-index: 1;
  animation: heroIn 0.9s ease both;
}

@keyframes heroIn {
  from { opacity: 0; transform: translateY(24px); }
  to   { opacity: 1; transform: translateY(0); }
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

# ============================================================
# 4. NAVBAR.CSS — fix cucitura backdrop-filter sul bordo
# ============================================================
cat > src/app/components/navbar/navbar.css << 'ENDOFFILE'
nav {
  position: fixed;
  top: -2px; left: 0; right: 0;
  z-index: 100;
  padding: calc(1.25rem + 2px) 1.5rem 1.25rem;
  transition: background 0.3s ease, border-bottom 0.3s ease, padding 0.3s ease;
  transform: translateZ(0);
}

nav.scrolled {
  background: rgba(10, 10, 15, 0.85);
  backdrop-filter: blur(20px);
  -webkit-backdrop-filter: blur(20px);
  border-bottom: 1px solid var(--border);
  padding: calc(0.875rem + 2px) 1.5rem 0.875rem;
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

echo ""
echo "✅ Fix applicati!"
echo ""
echo "   1. Hero: animazione ora 100% CSS, sempre visibile"
echo "   2. Hero: aggiunta dot-grid + doppio glow di sfondo"
echo "   3. Navbar: risolta la cucitura/linea durante lo scroll"
echo ""
echo "▶  Esegui: ng serve"
echo ""
echo "📌 Controlla sia in tema scuro che chiaro col toggle"
echo ""
