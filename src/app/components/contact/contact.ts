import { Component, signal } from '@angular/core';
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
  protected copied = signal(false);

  async copy() {
    try {
      await navigator.clipboard.writeText(this.p.email);
      this.copied.set(true);
      setTimeout(() => this.copied.set(false), 2200);
    } catch { /* clipboard non disponibile: l'indirizzo resta selezionabile e cliccabile */ }
  }
}
