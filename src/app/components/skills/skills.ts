import { Component } from '@angular/core';
import { SKILL_GROUPS } from '../../data/portfolio';
import { Reveal } from '../../directives/reveal';

@Component({
  selector: 'app-skills',
  imports: [Reveal],
  templateUrl: './skills.html',
  styleUrl: './skills.css'
})
export class Skills {
  protected groups = SKILL_GROUPS;
  protected dots = [1, 2, 3];
}
