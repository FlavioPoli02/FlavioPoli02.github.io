import { Component, OnDestroy, OnInit, signal } from '@angular/core';
import { PROFILE } from '../../data/portfolio';

@Component({
  selector: 'app-hero',
  templateUrl: './hero.html',
  styleUrl: './hero.css'
})
export class Hero implements OnInit, OnDestroy {
  protected p = PROFILE;
  protected time = signal(this.now());
  protected strip = [
    'Algoritmi avanzati', 'Ragionamento automatico', 'Complessità computazionale',
    'Angular', 'TypeScript', 'C#', 'ASP.NET',
  ];
  private timer?: ReturnType<typeof setInterval>;

  ngOnInit() { this.timer = setInterval(() => this.time.set(this.now()), 15000); }
  ngOnDestroy() { clearInterval(this.timer); }

  /** Ora locale di Udine. */
  private now() {
    return new Intl.DateTimeFormat('it-IT', { hour: '2-digit', minute: '2-digit', timeZone: 'Europe/Rome' }).format(new Date());
  }
}
