import { Component } from '@angular/core';
import { PROFILE } from '../../data/portfolio';

@Component({
  selector: 'app-hero',
  templateUrl: './hero.html',
  styleUrl: './hero.css'
})
export class Hero {
  protected p = PROFILE;
}
