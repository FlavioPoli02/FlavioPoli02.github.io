import { Component } from '@angular/core';
import { PROFILE } from '../../data/portfolio';
import { Reveal } from '../../directives/reveal';

@Component({
  selector: 'app-about',
  imports: [Reveal],
  templateUrl: './about.html',
  styleUrl: './about.css'
})
export class About {
  protected p = PROFILE;
}
