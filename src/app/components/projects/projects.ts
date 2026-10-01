import { Component } from '@angular/core';
import { PROJECTS } from '../../data/portfolio';
import { Reveal } from '../../directives/reveal';

@Component({
  selector: 'app-projects',
  imports: [Reveal],
  templateUrl: './projects.html',
  styleUrl: './projects.css'
})
export class Projects {
  protected projects = PROJECTS;
}
