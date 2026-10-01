import { Component } from '@angular/core';
import { PROFILE } from '../../data/portfolio';
import { Reveal } from '../../directives/reveal';

@Component({
  selector: 'app-contact',
  imports: [Reveal],
  templateUrl: './contact.html',
  styleUrl: './contact.css'
})
export class Contact {
  protected p = PROFILE;
  protected year = new Date().getFullYear();
}
