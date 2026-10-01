# DESIGN.md — Portfolio di Flavio Poli

Direzione: **minimalismo monocromatico, spinto** (riferimento di stile: Vercel, adattato — non una copia del brand).
Tipografia gigante, griglia visibile, un solo accento blu, interazioni misurate. Tema **chiaro di default**.

## Principi
1. Un solo accento (blu) per link, focus, stati attivi e il cammino evidenziato nel grafo. Tutto il resto è scala di grigi.
2. La hero è il biglietto da visita: nome a corpo enorme + un grafo pesato con cammino minimo (richiama Algoritmi Avanzati). È l'elemento riconoscibile del sito.
3. Layout asimmetrico: hero a 12 colonne, foto sticky a sinistra in "Chi sono", progetti in bento (card larga + card + tile), contatti come banda a pieno schermo invertita.
4. I progetti sono protagonisti: numero gigante in contorno, anatomia del progetto (livelli e tecnologie) al posto di uno screenshot che non c'è.
5. Movimento medio: reveal allo scroll sfalsato (700ms), titolo hero con mask-reveal, barra di progresso, hover con spostamenti ≤ 6px. Tutto disattivato con `prefers-reduced-motion`.
6. Accessibilità: contrasto ≥ 4.5:1 in entrambi i temi, focus visibile, skip-link, target ≥ 44px, switch del tema con `role="switch"`.

## Tema
- **Chiaro = default**, indipendente dal sistema operativo. Lo scuro è una scelta esplicita via switch visibile nella navbar, salvata in `localStorage` (`portfolio-theme`).
- Anti-flash: `index.html` ha `data-theme="light"` e uno script inline che applica `dark` prima del primo paint solo se salvato.
- Il tema chiaro è progettato in origine: carta calda, superfici bianche con ombre morbide a due livelli. Il tema scuro non usa ombre: solo bordi.

| Token | Chiaro | Scuro |
|---|---|---|
| `--bg` | `#F6F5F1` | `#0A0A0A` |
| `--surface` | `#FFFFFF` | `#111111` |
| `--surface-2` | `#EDECE6` | `#181818` |
| `--border` | `#DCDBD4` | `#262626` |
| `--text-1` | `#0C0C0D` | `#EDEDED` |
| `--text-2` | `#4E4E55` | `#A1A1A1` |
| `--text-3` | `#66666D` | `#8F8F8F` |
| `--accent` | `#1F4FFF` | `#6AA6FF` |
| `--ok` | `#13794A` | `#3DD68C` |
| `--band-bg/fg` (banda contatti, tile GitHub) | `#0C0C0D / #F6F5F1` | `#EDEDED / #0A0A0A` |

## Tipografia
- **Geist** (sans) + **Geist Mono** (etichette, periodi, tag). Due famiglie, pochi pesi.
- Hero H1 `clamp(4.5rem, 14.5vw, 11.5rem)`, tracking `-0.065em`; H2 `clamp(2.5rem, 7vw, 5rem)`; contatti H2 fino a 12rem.
- Numeri e anni giganti in contorno (`-webkit-text-stroke`) come elemento grafico.

## Spaziatura e layout
- Ritmo a 8px (`--s-1`…`--s-8`). Sezioni con padding verticale `clamp(5rem, 11vw, 9rem)`. Container 1160px.
- Raggi: 14px (elementi), 22px (card progetto), 999px (pill, tag, pulsanti).
- Breakpoint: 640 / 820 (navbar) / 900 (griglie a una colonna).

## Componenti
- **Navbar**: pill flottante con monogramma, link, switch tema, menu mobile; barra di progresso scroll in alto.
- **Pulsanti**: pill; primario pieno (ink su carta) che vira all'accento in hover; freccia che scorre.
- **Card progetto**: bordo + ombra (chiaro), lift in hover, "anatomia" a binario con nodi che si accendono.
- **Skill**: pill con livello a tre punti + etichetta testuale.
- **Banda contatti**: fondo invertito, email gigante con sottolineatura animata e pulsante "Copia".
