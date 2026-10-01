import { Component } from '@angular/core';
import { EDUCATION, EXPERIENCES } from '../../data/portfolio';
import { Reveal } from '../../directives/reveal';

@Component({
  selector: 'app-experience',
  imports: [Reveal],
  templateUrl: './experience.html',
  styleUrl: './experience.css'
})
export class Experience {
  protected experiences = EXPERIENCES;
  protected education = EDUCATION;
}
