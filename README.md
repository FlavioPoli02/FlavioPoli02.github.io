# Flavio Poli — Portfolio

Sito personale di Flavio Poli, studente magistrale in Informatica all'Università di Udine.
Presenta chi sono, i progetti in evidenza, le competenze, il percorso di studi e lavoro e i contatti.

**Sito online:** https://flaviopoli02.github.io/

## Caratteristiche

- **Single page** con sezioni: hero, chi sono, progetti, competenze, percorso, contatti.
- **Hero con identità propria**: nome a corpo enorme e un grafo pesato con il cammino minimo che si disegna in loop, un richiamo agli Algoritmi Avanzati di cui mi occupo.
- **Progetti in evidenza** come case study, con l'«anatomia» di ogni progetto (livelli e tecnologie).
- **Tema chiaro di default**, indipendente dalle impostazioni del sistema. Il tema scuro si attiva con lo switch nella navbar e la scelta viene ricordata, senza flash al caricamento.
- **Responsive**: pensato per mobile, tablet e desktop.
- **Accessibile**: link di navigazione reali, skip-link, focus visibile, contrasto verificato in entrambi i temi, area cliccabile minima di 44px e rispetto di `prefers-reduced-motion`.
- **Animazioni sobrie**: comparsa allo scroll, barra di avanzamento e micro-interazioni, tutte disattivate per chi preferisce meno movimento.

## Stack

| | |
|---|---|
| Framework | [Angular](https://angular.dev) 22, componenti standalone |
| Linguaggio | TypeScript |
| Stile | CSS puro con variabili (design token), nessuna libreria UI |
| Font | [Geist](https://vercel.com/font) e Geist Mono, da Google Fonts |
| Test | Vitest (tramite `ng test`) |
| Deploy | GitHub Pages con [angular-cli-ghpages](https://github.com/angular-schule/angular-cli-ghpages) |

## Struttura del progetto

```
src/
├── index.html              # meta tag, font, script anti-flash del tema
├── styles.css              # design token (chiaro/scuro) e stili condivisi
└── app/
    ├── app.ts / app.html   # composizione delle sezioni
    ├── theme.service.ts    # tema chiaro/scuro, salvato in localStorage
    ├── data/
    │   └── portfolio.ts    # TUTTI i contenuti: profilo, progetti, competenze, esperienze
    ├── directives/
    │   └── reveal.ts       # animazione di comparsa allo scroll
    └── components/
        ├── navbar/         # pillola di navigazione, switch del tema, barra di avanzamento
        ├── hero/
        ├── about/
        ├── projects/
        ├── skills/
        ├── experience/
        └── contact/
public/                     # favicon e foto
DESIGN.md                   # linee guida di design (palette, tipografia, componenti)
```

## Sviluppo in locale

Servono Node.js (una versione supportata da Angular 22) e npm.

```bash
npm install
npm start
```

Poi apri http://localhost:4200. La pagina si aggiorna a ogni modifica ai sorgenti.

Altri comandi:

```bash
npm test                     # avvia i test
npx ng test --watch=false    # test una sola volta
npm run build                # build di produzione in dist/portfolio
```

## Modificare i contenuti

Quasi tutti i contenuti vivono in un unico file: [`src/app/data/portfolio.ts`](src/app/data/portfolio.ts).

- `PROFILE`: nome, ruolo, città, disponibilità, email e link social.
- `PROJECTS`: progetti in evidenza. Ogni progetto ha periodo, ruolo, descrizione e i livelli (`layers`) mostrati nell'anatomia. Si possono aggiungere `outcome` (risultato) e `link` (demo o repository).
- `SKILL_GROUPS`: competenze per categoria, con livello da 1 a 3.
- `EXPERIENCES` e `EDUCATION`: esperienza e formazione.

I testi più lunghi delle sezioni «Chi sono» e «Hero» si trovano nei rispettivi template, in `src/app/components/about/about.html` e `src/app/components/hero/hero.html`.

## Tema

Il sito parte sempre in tema chiaro. Il tema scuro è una scelta esplicita del visitatore, salvata in `localStorage` (chiave `portfolio-theme`). I colori sono variabili CSS in `src/styles.css`: quelle di default descrivono il tema chiaro, `[data-theme="dark"]` le ridefinisce per lo scuro.

## Design

Direzione stilistica, palette, tipografia e componenti sono descritti in [`DESIGN.md`](DESIGN.md). Conviene aggiornarlo quando si cambia qualcosa di strutturale nel design.

## Deploy

Il sito è un *user site* di GitHub Pages (`FlavioPoli02.github.io`) e viene servito dal branch `gh-pages`. Per pubblicare una nuova versione:

```bash
npx ng deploy
```

Il comando fa la build di produzione e aggiorna `gh-pages`. Un `git push` su `main` salva il codice sorgente ma **non** aggiorna il sito: serve il deploy. La nuova versione è di solito visibile dopo uno o due minuti.

## Contatti

- GitHub: [FlavioPoli02](https://github.com/FlavioPoli02)
- LinkedIn: [Flavio Poli](https://linkedin.com/in/flavio-poli-09b67023b/)
