# DESIGN.md — Portfolio di Flavio Poli

Direzione: **minimalismo monocromatico** (riferimento di stile: Vercel, adattato — non una copia del brand).
Il contenuto è il protagonista: tipografia nitida, griglia ordinata, un solo accento.

## Principi
1. Un solo accento (blu) usato per link, focus e stati attivi. Tutto il resto è scala di grigi.
2. Bordi da 1px al posto delle ombre; niente gradienti decorativi, niente glow.
3. Gerarchia: chi sono → cosa faccio → progetti in evidenza → percorso → contatti.
4. Movimento sobrio: fade/slide di 8px allo scroll, 150–250ms, disattivato con `prefers-reduced-motion`.
5. Accessibilità: contrasto ≥ 4.5:1 per tutto il testo, focus visibile, navigazione da tastiera, skip-link.

## Colori
| Token | Scuro | Chiaro |
|---|---|---|
| `--bg` | `#000000` | `#FFFFFF` |
| `--surface` | `#0A0A0A` | `#FAFAFA` |
| `--border` | `#262626` | `#EAEAEA` |
| `--text-1` | `#EDEDED` | `#0A0A0A` |
| `--text-2` | `#A1A1A1` | `#525252` |
| `--text-3` | `#8F8F8F` | `#6B6B6B` |
| `--accent` | `#52A8FF` | `#0070F3` |
| `--ok` | `#3DD68C` | `#1A7F4B` |

Il tema segue le preferenze di sistema; il toggle salva la scelta.

## Tipografia
- **Geist** (sans) per titoli e testo, **Geist Mono** per etichette, periodi e tag.
- Titoli: peso 600, tracking negativo (`-0.03em`), `text-wrap: balance`.
- Scala fluida con `clamp()`: H1 2.5→4.5rem, H2 1.75→2.5rem, corpo 1rem/1.65.
- Etichette mono: 0.8125rem, mai sotto 13px.

## Spaziatura e layout
- Ritmo a 8px (`--s-1` = 0.5rem … `--s-8` = 4rem). Sezioni con padding verticale `clamp(4rem, 9vw, 7rem)`.
- Container 1080px, gutter 24px (16px su mobile). Breakpoint: 640px, 960px.
- Raggio 8px (card) / 999px (pill e tag).

## Componenti
- **Card progetto**: bordo 1px, hover = bordo più chiaro + leggero spostamento. Contenuto: periodo, ruolo, descrizione, tecnologie, risultato (TODO se mancante).
- **Pulsanti**: primario pieno (testo/sfondo invertiti), secondario con bordo. Altezza minima 44px.
- **Tag**: pill mono con bordo, non cliccabili.
