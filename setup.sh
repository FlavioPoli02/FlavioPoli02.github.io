#!/bin/bash
# ============================================================
# Portfolio Setup Script — Flavio Poli
# Esegui da: ~/Documents/Progetti/Portfolio/portfolio
# Comando: bash setup.sh
# ============================================================

echo "⚙️  Creazione struttura componenti..."
mkdir -p src/app/components/navbar
mkdir -p src/app/components/hero
mkdir -p src/app/components/about
mkdir -p src/app/components/skills
mkdir -p src/app/components/experience
mkdir -p src/app/components/contact

# ============================================================
# GLOBAL STYLES
# ============================================================
cat > src/styles.css << 'ENDOFFILE'
@import url('https://fonts.googleapis.com/css2?family=Space+Grotesk:wght@300;400;500;600;700&family=Inter:wght@300;400;500;600&family=JetBrains+Mono:wght@400;500&display=swap');

*, *::before, *::after { box-sizing: border-box; margin: 0; padding: 0; }

:root {
  --bg:         #0A0A0F;
  --surface:    #111118;
  --surface-2:  #18181F;
  --accent:     #4F7EFF;
  --accent-glow: rgba(79, 126, 255, 0.12);
  --text-1:     #EEEEF5;
  --text-2:     #8A8AA8;
  --text-3:     #4A4A62;
  --border:     rgba(255, 255, 255, 0.07);
  --font-display: 'Space Grotesk', sans-serif;
  --font-body:    'Inter', sans-serif;
  --font-mono:    'JetBrains Mono', monospace;
  --max-w:      1100px;
  --section-pad: 6rem 1.5rem;
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
# APP ROOT
# ============================================================
cat > src/app/app.ts << 'ENDOFFILE'
import { Component } from '@angular/core';
import { Navbar } from './components/navbar/navbar';
import { Hero } from './components/hero/hero';
import { About } from './components/about/about';
import { Skills } from './components/skills/skills';
import { Experience } from './components/experience/experience';
import { Contact } from './components/contact/contact';

@Component({
  selector: 'app-root',
  standalone: true,
  imports: [Navbar, Hero, About, Skills, Experience, Contact],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {}
ENDOFFILE

cat > src/app/app.html << 'ENDOFFILE'
<app-navbar />
<main>
  <app-hero />
  <app-about />
  <app-skills />
  <app-experience />
  <app-contact />
</main>
ENDOFFILE

cat > src/app/app.css << 'ENDOFFILE'
main { width: 100%; }
ENDOFFILE

# ============================================================
# NAVBAR
# ============================================================
cat > src/app/components/navbar/navbar.ts << 'ENDOFFILE'
import { Component, HostListener } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-navbar',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './navbar.html',
  styleUrl: './navbar.css'
})
export class Navbar {
  scrolled = false;

  @HostListener('window:scroll')
  onScroll() {
    this.scrolled = window.scrollY > 60;
  }

  scrollTo(id: string) {
    document.getElementById(id)?.scrollIntoView({ behavior: 'smooth' });
  }
}
ENDOFFILE

cat > src/app/components/navbar/navbar.html << 'ENDOFFILE'
<nav [class.scrolled]="scrolled">
  <div class="nav-inner">
    <span class="logo" (click)="scrollTo('home')">FP</span>
    <ul class="nav-links">
      <li><button (click)="scrollTo('about')">About</button></li>
      <li><button (click)="scrollTo('skills')">Skills</button></li>
      <li><button (click)="scrollTo('experience')">Esperienza</button></li>
      <li><button (click)="scrollTo('contact')" class="cta-nav">Contattami</button></li>
    </ul>
  </div>
</nav>
ENDOFFILE

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

@media (max-width: 600px) {
  .nav-links button { padding: 0.4rem 0.6rem; font-size: 0.82rem; }
}
ENDOFFILE

# ============================================================
# HERO
# ============================================================
cat > src/app/components/hero/hero.ts << 'ENDOFFILE'
import { Component, OnInit } from '@angular/core';
import { CommonModule } from '@angular/common';

@Component({
  selector: 'app-hero',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './hero.html',
  styleUrl: './hero.css'
})
export class Hero implements OnInit {
  visible = false;

  ngOnInit() {
    setTimeout(() => (this.visible = true), 80);
  }
}
ENDOFFILE

cat > src/app/components/hero/hero.html << 'ENDOFFILE'
<section id="home" [class.visible]="visible">
  <div class="hero-bg"></div>
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
  background: radial-gradient(ellipse 80% 55% at 50% -5%, rgba(79, 126, 255, 0.14) 0%, transparent 70%);
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

# ============================================================
# ABOUT
# ============================================================
cat > src/app/components/about/about.ts << 'ENDOFFILE'
import { Component } from '@angular/core';

@Component({
  selector: 'app-about',
  standalone: true,
  templateUrl: './about.html',
  styleUrl: './about.css'
})
export class About {}
ENDOFFILE

cat > src/app/components/about/about.html << 'ENDOFFILE'
<section id="about">
  <div class="inner">
    <span class="eyebrow mono accent">/ about</span>
    <div class="grid">
      <div class="text">
        <h2>Chi sono</h2>
        <p>
          Sono un <strong>Full Stack Developer</strong> appassionato di
          tecnologia e sviluppo web. Ho maturato la mia esperienza durante il
          tirocinio, dove ho progettato e sviluppato una piattaforma completa
          per la gestione di eventi.
        </p>
        <p>
          Amo costruire applicazioni strutturate, con attenzione
          all'architettura del codice e all'esperienza utente.
        </p>
        <div class="details">
          <div class="row">
            <span class="label">Posizione</span>
            <span>Milano, Italia</span>
          </div>
          <div class="row">
            <span class="label">Disponibilità</span>
            <span class="open">Aperto a opportunità</span>
          </div>
          <div class="row">
            <span class="label">Email</span>
            <span>tuaemail@email.com</span>
          </div>
        </div>
      </div>
      <div class="photo-wrap">
        <div class="photo">FP</div>
      </div>
    </div>
  </div>
</section>
ENDOFFILE

cat > src/app/components/about/about.css << 'ENDOFFILE'
section { padding: var(--section-pad); }

.inner {
  max-width: var(--max-w);
  margin: 0 auto;
}

.eyebrow {
  display: block;
  margin-bottom: 2.5rem;
}

.mono { font-family: var(--font-mono); font-size: 0.85rem; letter-spacing: 0.05em; }
.accent { color: var(--accent); }

.grid {
  display: grid;
  grid-template-columns: 1fr auto;
  gap: 4rem;
  align-items: start;
}

h2 {
  font-family: var(--font-display);
  font-size: clamp(2rem, 4vw, 2.8rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  margin-bottom: 1.25rem;
  color: var(--text-1);
}

.text p {
  color: var(--text-2);
  line-height: 1.8;
  max-width: 560px;
  margin-bottom: 1rem;
}

.text p strong { color: var(--text-1); font-weight: 500; }

.details {
  margin-top: 2rem;
  border-top: 1px solid var(--border);
  padding-top: 1.5rem;
  display: flex;
  flex-direction: column;
  gap: 0.875rem;
}

.row {
  display: flex;
  gap: 1.5rem;
  font-size: 0.9rem;
  align-items: baseline;
}

.label {
  font-family: var(--font-mono);
  font-size: 0.75rem;
  text-transform: uppercase;
  letter-spacing: 0.07em;
  color: var(--text-3);
  min-width: 100px;
}

.open { color: #4ade80; }

.photo {
  width: 200px;
  height: 200px;
  border-radius: 16px;
  background: var(--surface-2);
  border: 1px solid var(--border);
  display: flex;
  align-items: center;
  justify-content: center;
  font-family: var(--font-display);
  font-size: 2.5rem;
  font-weight: 700;
  color: var(--accent);
}

@media (max-width: 700px) {
  .grid { grid-template-columns: 1fr; gap: 2rem; }
  .photo-wrap { order: -1; }
  .photo { width: 100px; height: 100px; font-size: 1.6rem; border-radius: 12px; }
}
ENDOFFILE

# ============================================================
# SKILLS
# ============================================================
cat > src/app/components/skills/skills.ts << 'ENDOFFILE'
import { Component } from '@angular/core';
import { CommonModule } from '@angular/common';

interface Skill { name: string; level: string; category: string; }

@Component({
  selector: 'app-skills',
  standalone: true,
  imports: [CommonModule],
  templateUrl: './skills.html',
  styleUrl: './skills.css'
})
export class Skills {
  categories = ['Frontend', 'Backend', 'Database', 'Tools'];

  skills: Skill[] = [
    { name: 'Angular',       level: 'Intermedio', category: 'Frontend' },
    { name: 'TypeScript',    level: 'Intermedio', category: 'Frontend' },
    { name: 'HTML / CSS',    level: 'Buono',      category: 'Frontend' },
    { name: 'C#',            level: 'Intermedio', category: 'Backend'  },
    { name: 'ASP.NET',       level: 'Intermedio', category: 'Backend'  },
    { name: 'Web API REST',  level: 'Intermedio', category: 'Backend'  },
    { name: 'SQL',           level: 'Base',       category: 'Database' },
    { name: 'Git',           level: 'Buono',      category: 'Tools'    },
    { name: 'VS Code',       level: 'Buono',      category: 'Tools'    },
    { name: 'Visual Studio', level: 'Buono',      category: 'Tools'    },
  ];

  byCategory(cat: string) {
    return this.skills.filter(s => s.category === cat);
  }
}
ENDOFFILE

cat > src/app/components/skills/skills.html << 'ENDOFFILE'
<section id="skills">
  <div class="inner">
    <span class="eyebrow mono accent">/ skills</span>
    <h2>Tecnologie</h2>
    <div class="grid">
      @for (cat of categories; track cat) {
        <div class="group">
          <span class="cat-label">{{ cat }}</span>
          <div class="list">
            @for (skill of byCategory(cat); track skill.name) {
              <div class="card">
                <span class="skill-name">{{ skill.name }}</span>
                <span class="skill-level">{{ skill.level }}</span>
              </div>
            }
          </div>
        </div>
      }
    </div>
  </div>
</section>
ENDOFFILE

cat > src/app/components/skills/skills.css << 'ENDOFFILE'
section {
  padding: var(--section-pad);
  background: var(--surface);
}

.inner { max-width: var(--max-w); margin: 0 auto; }

.eyebrow { display: block; margin-bottom: 0.75rem; }
.mono { font-family: var(--font-mono); font-size: 0.85rem; letter-spacing: 0.05em; }
.accent { color: var(--accent); }

h2 {
  font-family: var(--font-display);
  font-size: clamp(2rem, 4vw, 2.8rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  margin-bottom: 3rem;
  color: var(--text-1);
}

.grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
  gap: 2rem;
}

.cat-label {
  display: block;
  font-family: var(--font-mono);
  font-size: 0.72rem;
  text-transform: uppercase;
  letter-spacing: 0.1em;
  color: var(--text-3);
  margin-bottom: 0.875rem;
}

.list { display: flex; flex-direction: column; gap: 0.5rem; }

.card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0.75rem 1rem;
  background: var(--surface-2);
  border: 1px solid var(--border);
  border-radius: 8px;
  transition: border-color 0.2s, background 0.2s;
}

.card:hover {
  border-color: rgba(79, 126, 255, 0.3);
  background: rgba(79, 126, 255, 0.04);
}

.skill-name { font-size: 0.9rem; font-weight: 500; color: var(--text-1); }

.skill-level {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  color: var(--text-3);
  background: var(--bg);
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
}
ENDOFFILE

# ============================================================
# EXPERIENCE
# ============================================================
cat > src/app/components/experience/experience.ts << 'ENDOFFILE'
import { Component } from '@angular/core';

@Component({
  selector: 'app-experience',
  standalone: true,
  templateUrl: './experience.html',
  styleUrl: './experience.css'
})
export class Experience {}
ENDOFFILE

cat > src/app/components/experience/experience.html << 'ENDOFFILE'
<section id="experience">
  <div class="inner">
    <span class="eyebrow mono accent">/ esperienza</span>
    <h2>Esperienza</h2>

    <div class="timeline">
      <div class="item">
        <div class="meta">
          <span class="period">2024</span>
          <span class="badge">Tirocinio</span>
        </div>
        <div class="card">
          <h3>Full Stack Developer</h3>
          <p class="company">Nome Azienda — Milano</p>
          <p class="desc">
            Sviluppo di una piattaforma per la gestione di eventi, candidati e
            aziende. Back-end realizzato con Web API in C# e ASP.NET, front-end
            in Angular con TypeScript.
          </p>
          <div class="tags">
            <span>Angular</span>
            <span>TypeScript</span>
            <span>C#</span>
            <span>ASP.NET</span>
            <span>Web API REST</span>
          </div>
        </div>
      </div>
    </div>

    <div class="education">
      <span class="edu-title mono accent">/ istruzione</span>
      <div class="edu-item">
        <span class="period">20XX – 20XX</span>
        <div>
          <h3>Nome Laurea</h3>
          <p class="company">Nome Università</p>
        </div>
      </div>
    </div>
  </div>
</section>
ENDOFFILE

cat > src/app/components/experience/experience.css << 'ENDOFFILE'
section { padding: var(--section-pad); }

.inner { max-width: var(--max-w); margin: 0 auto; }

.eyebrow { display: block; margin-bottom: 0.75rem; }
.mono { font-family: var(--font-mono); font-size: 0.85rem; letter-spacing: 0.05em; }
.accent { color: var(--accent); }

h2 {
  font-family: var(--font-display);
  font-size: clamp(2rem, 4vw, 2.8rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  margin-bottom: 3rem;
  color: var(--text-1);
}

.timeline {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 2rem;
  margin-bottom: 4rem;
}

.timeline::before {
  content: '';
  position: absolute;
  left: 4.5rem;
  top: 0.5rem;
  bottom: 0;
  width: 1px;
  background: var(--border);
}

.item {
  display: grid;
  grid-template-columns: 5rem 1fr;
  gap: 2rem;
  align-items: start;
}

.meta {
  display: flex;
  flex-direction: column;
  align-items: flex-end;
  gap: 0.5rem;
  padding-top: 0.3rem;
}

.period {
  font-family: var(--font-mono);
  font-size: 0.78rem;
  color: var(--text-3);
}

.badge {
  font-family: var(--font-mono);
  font-size: 0.62rem;
  text-transform: uppercase;
  letter-spacing: 0.06em;
  color: var(--accent);
  background: var(--accent-glow);
  padding: 0.2rem 0.5rem;
  border-radius: 4px;
  border: 1px solid rgba(79, 126, 255, 0.2);
  white-space: nowrap;
}

.card {
  background: var(--surface);
  border: 1px solid var(--border);
  border-radius: 12px;
  padding: 1.5rem;
  position: relative;
}

.card::before {
  content: '';
  position: absolute;
  left: -1.05rem;
  top: 1.1rem;
  width: 8px;
  height: 8px;
  border-radius: 50%;
  background: var(--accent);
  box-shadow: 0 0 0 3px var(--bg), 0 0 0 4px var(--accent);
}

h3 {
  font-family: var(--font-display);
  font-size: 1.1rem;
  font-weight: 600;
  color: var(--text-1);
  margin-bottom: 0.2rem;
}

.company {
  font-size: 0.875rem;
  color: var(--accent);
  margin-bottom: 0.875rem;
}

.desc {
  font-size: 0.9rem;
  color: var(--text-2);
  line-height: 1.75;
  margin-bottom: 1.25rem;
}

.tags {
  display: flex;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.tags span {
  font-family: var(--font-mono);
  font-size: 0.7rem;
  color: var(--text-2);
  background: var(--surface-2);
  border: 1px solid var(--border);
  padding: 0.2rem 0.6rem;
  border-radius: 4px;
}

.education {
  border-top: 1px solid var(--border);
  padding-top: 3rem;
}

.edu-title {
  display: block;
  margin-bottom: 1.5rem;
}

.edu-item {
  display: flex;
  gap: 2rem;
  align-items: baseline;
}

.edu-item .period {
  min-width: 5rem;
  text-align: right;
}

@media (max-width: 600px) {
  .timeline::before { display: none; }
  .item { grid-template-columns: 1fr; gap: 0.75rem; }
  .meta { flex-direction: row; align-items: center; }
  .card::before { display: none; }
  .edu-item { flex-direction: column; gap: 0.4rem; }
  .edu-item .period { text-align: left; min-width: auto; }
}
ENDOFFILE

# ============================================================
# CONTACT
# ============================================================
cat > src/app/components/contact/contact.ts << 'ENDOFFILE'
import { Component } from '@angular/core';

@Component({
  selector: 'app-contact',
  standalone: true,
  templateUrl: './contact.html',
  styleUrl: './contact.css'
})
export class Contact {}
ENDOFFILE

cat > src/app/components/contact/contact.html << 'ENDOFFILE'
<section id="contact">
  <div class="inner">
    <span class="eyebrow mono accent">/ contatti</span>
    <h2>Parliamoci</h2>
    <p class="subtitle">
      Sono aperto a nuove opportunità e collaborazioni.<br />
      Non esitare a scrivermi.
    </p>

    <div class="links">
      <a href="mailto:tuaemail@email.com" class="link-card">
        <span class="icon">✉</span>
        <div>
          <span class="lbl">Email</span>
          <span class="val">tuaemail@email.com</span>
        </div>
      </a>
      <a href="https://github.com/FlavioPoli02" target="_blank" rel="noopener" class="link-card">
        <span class="icon mono">gh</span>
        <div>
          <span class="lbl">GitHub</span>
          <span class="val">FlavioPoli02</span>
        </div>
      </a>
      <a href="https://linkedin.com/in/TUOPROFILO" target="_blank" rel="noopener" class="link-card">
        <span class="icon mono">in</span>
        <div>
          <span class="lbl">LinkedIn</span>
          <span class="val">Flavio Poli</span>
        </div>
      </a>
    </div>
  </div>
</section>

<footer>
  <div class="footer-inner">
    <span>Flavio Poli © 2025</span>
    <span class="mono muted">Built with Angular</span>
  </div>
</footer>
ENDOFFILE

cat > src/app/components/contact/contact.css << 'ENDOFFILE'
section {
  padding: var(--section-pad);
  background: var(--surface);
}

.inner { max-width: var(--max-w); margin: 0 auto; }

.eyebrow { display: block; margin-bottom: 0.75rem; }
.mono { font-family: var(--font-mono); font-size: 0.85rem; letter-spacing: 0.05em; }
.accent { color: var(--accent); }

h2 {
  font-family: var(--font-display);
  font-size: clamp(2rem, 4vw, 2.8rem);
  font-weight: 600;
  letter-spacing: -0.02em;
  margin-bottom: 0.875rem;
  color: var(--text-1);
}

.subtitle {
  color: var(--text-2);
  font-size: 1rem;
  line-height: 1.75;
  margin-bottom: 3rem;
}

.links {
  display: flex;
  flex-direction: column;
  gap: 0.875rem;
  max-width: 440px;
}

.link-card {
  display: flex;
  align-items: center;
  gap: 1.25rem;
  padding: 1.125rem 1.375rem;
  background: var(--surface-2);
  border: 1px solid var(--border);
  border-radius: 12px;
  text-decoration: none;
  transition: border-color 0.2s, background 0.2s, transform 0.2s;
}

.link-card:hover {
  border-color: rgba(79, 126, 255, 0.3);
  background: rgba(79, 126, 255, 0.05);
  transform: translateX(5px);
}

.icon {
  width: 40px;
  height: 40px;
  flex-shrink: 0;
  display: flex;
  align-items: center;
  justify-content: center;
  background: var(--accent-glow);
  border-radius: 8px;
  color: var(--accent);
  font-size: 1rem;
  font-family: var(--font-mono);
  font-weight: 600;
}

.lbl {
  display: block;
  font-family: var(--font-mono);
  font-size: 0.7rem;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--text-3);
  margin-bottom: 0.15rem;
}

.val {
  display: block;
  color: var(--text-1);
  font-size: 0.9rem;
  font-weight: 500;
}

footer {
  padding: 2rem 1.5rem;
  border-top: 1px solid var(--border);
}

.footer-inner {
  max-width: var(--max-w);
  margin: 0 auto;
  display: flex;
  justify-content: space-between;
  align-items: center;
  font-size: 0.82rem;
  color: var(--text-3);
}

.muted { color: var(--text-3); }

@media (max-width: 500px) {
  .footer-inner { flex-direction: column; gap: 0.4rem; text-align: center; }
}
ENDOFFILE

echo ""
echo "✅ Setup completato! Ora esegui:"
echo "   ng serve"
echo ""
echo "📝 Ricordati di aggiornare i placeholder in:"
echo "   - about.html     → email, posizione"
echo "   - experience.html → nome azienda, date, laurea"
echo "   - contact.html   → email, LinkedIn URL"
echo ""
