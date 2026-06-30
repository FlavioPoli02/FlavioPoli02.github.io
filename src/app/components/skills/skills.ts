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
