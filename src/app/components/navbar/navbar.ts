import { Component, ElementRef, HostListener, OnDestroy, OnInit, inject } from '@angular/core';
import { ThemeService } from '../../theme.service';
import { NAV, PROFILE } from '../../data/portfolio';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.html',
  styleUrl: './navbar.css'
})
export class Navbar implements OnInit, OnDestroy {
  protected theme = inject(ThemeService);
  private host = inject<ElementRef<HTMLElement>>(ElementRef);
  protected nav = NAV;
  protected name = PROFILE.name;
  protected scrolled = false;
  protected menuOpen = false;
  protected active = '';
  protected progress = 0;
  private io?: IntersectionObserver;

  ngOnInit() {
    if (!('IntersectionObserver' in window)) return;
    this.io = new IntersectionObserver(
      entries => entries.forEach(e => { if (e.isIntersecting) this.active = e.target.id === 'home' ? '' : e.target.id; }),
      { rootMargin: '-40% 0px -55% 0px' }
    );
    ['home', ...NAV.map(n => n.id), 'contact'].forEach(id => {
      const el = document.getElementById(id);
      if (el) this.io!.observe(el);
    });
  }

  ngOnDestroy() { this.io?.disconnect(); }

  @HostListener('window:scroll')
  onScroll() {
    this.scrolled = window.scrollY > 8;
    const max = document.documentElement.scrollHeight - window.innerHeight;
    this.progress = max > 0 ? Math.min(1, window.scrollY / max) : 0;
  }

  @HostListener('document:keydown.escape')
  closeMenu() { this.menuOpen = false; }

  /** Un tocco fuori dalla navbar chiude il menu mobile. */
  @HostListener('document:click', ['$event'])
  onDocumentClick(e: MouseEvent) {
    if (this.menuOpen && !this.host.nativeElement.querySelector('.pill')?.contains(e.target as Node)) this.menuOpen = false;
  }

  toggleMenu() { this.menuOpen = !this.menuOpen; }
}
