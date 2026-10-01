export interface NavItem { id: string; label: string; }

export interface Skill { name: string; level: 1 | 2 | 3; levelLabel: string; }
export interface SkillGroup { category: string; skills: Skill[]; }

export interface Project {
  title: string;
  role: string;
  context: string;
  period: string;
  description: string;
  /** Anatomia del progetto: livelli e tecnologie, ricavati dalla descrizione. */
  layers: { label: string; items: string[] }[];
  /** TODO: aggiungere un risultato misurabile o un link (demo/repo) reali. */
  outcome?: string;
  link?: { href: string; label: string };
}

export interface Experience {
  period: string;
  kind: string;
  role: string;
  org: string;
  description: string;
}

export interface Education { period: string; title: string; org: string; }

export const PROFILE = {
  name: 'Flavio Poli',
  role: 'Studente magistrale in Informatica',
  location: 'Udine, Italia',
  availability: 'Aperto a opportunità',
  // TODO: nel sito c'erano due email diverse (flaviop.fli@gmail.com e flaviopoli952@gmail.com).
  // Qui è usata quella del link di contatto originale: verifica che sia quella giusta.
  email: 'flaviopoli952@gmail.com',
  github: { href: 'https://github.com/FlavioPoli02', handle: 'FlavioPoli02' },
  linkedin: { href: 'https://linkedin.com/in/flavio-poli-09b67023b/', handle: 'Flavio Poli' },
};

export const NAV: NavItem[] = [
  { id: 'about', label: 'Chi sono' },
  { id: 'projects', label: 'Progetti' },
  { id: 'skills', label: 'Competenze' },
  { id: 'experience', label: 'Percorso' },
];

export const SKILL_GROUPS: SkillGroup[] = [
  { category: 'Frontend', skills: [
    { name: 'Angular', level: 2, levelLabel: 'Intermedio' },
    { name: 'TypeScript', level: 2, levelLabel: 'Intermedio' },
    { name: 'HTML / CSS', level: 3, levelLabel: 'Buono' },
  ]},
  { category: 'Backend', skills: [
    { name: 'C#', level: 2, levelLabel: 'Intermedio' },
    { name: 'ASP.NET', level: 2, levelLabel: 'Intermedio' },
    { name: 'Web API REST', level: 2, levelLabel: 'Intermedio' },
  ]},
  { category: 'Database', skills: [
    { name: 'SQL', level: 1, levelLabel: 'Base' },
  ]},
  { category: 'Strumenti', skills: [
    { name: 'Git', level: 3, levelLabel: 'Buono' },
    { name: 'VS Code', level: 3, levelLabel: 'Buono' },
    { name: 'Visual Studio', level: 3, levelLabel: 'Buono' },
  ]},
];

// I progetti sono ricavati dalle esperienze già presenti nel sito.
// TODO: aggiungere eventuali progetti personali/universitari reali con repo e screenshot.
export const PROJECTS: Project[] = [
  {
    title: 'Piattaforma per eventi, candidati e aziende',
    role: 'Full Stack Developer (tirocinio)',
    context: 'Innov@ctors — Udine',
    period: '2024',
    description:
      'Sviluppo di una piattaforma per la gestione di eventi, candidati e aziende. Back-end realizzato con Web API in C# e ASP.NET, front-end in Angular con TypeScript.',
    layers: [
      { label: 'Front-end', items: ['Angular', 'TypeScript'] },
      { label: 'Back-end', items: ['Web API REST', 'C#', 'ASP.NET'] },
      { label: 'Dominio', items: ['Eventi', 'Candidati', 'Aziende'] },
    ],
  },
  {
    title: 'Sito web istituzionale JEUD',
    role: 'IT Manager & Web Developer',
    context: 'JEUD — Udine',
    period: '2022',
    description:
      'Coordinamento e sviluppo del sito istituzionale (WordPress con modifiche custom in Bootstrap) e amministrazione dell\'infrastruttura informatica di supporto: servizi cloud, email aziendali e hosting.',
    layers: [
      { label: 'Sito', items: ['WordPress', 'Bootstrap custom', 'HTML/CSS'] },
      { label: 'Infrastruttura', items: ['Servizi cloud', 'Email aziendali', 'Hosting'] },
    ],
  },
];

export const EXPERIENCES: Experience[] = [
  {
    period: '2024', kind: 'Tirocinio', role: 'Full Stack Developer', org: 'Innov@ctors — Udine',
    description: 'Piattaforma per la gestione di eventi, candidati e aziende (Angular, C#, ASP.NET).',
  },
  {
    period: '2022', kind: 'Esperienza', role: 'IT Manager & Web Developer', org: 'JEUD — Udine',
    description: 'Ecosistema digitale di una piccola organizzazione: sito web, cloud, email e hosting.',
  },
];

export const EDUCATION: Education[] = [
  { period: '2025/26 – oggi', title: 'Laurea magistrale in Informatica', org: 'Università degli studi di Udine' },
  { period: '2020/21 – 2023/24', title: 'Laurea triennale in Informatica', org: 'Università degli studi di Udine' },
];
