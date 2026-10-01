import { Component, HostListener, OnDestroy, OnInit, inject } from '@angular/core';
import { ThemeService } from '../../theme.service';
import { NAV, PROFILE } from '../../data/portfolio';

@Component({
  selector: 'app-navbar',
  templateUrl: './navbar.html',
  styleUrl: './navbar.css'
})
export class Navbar implements OnInit, OnDestroy {
  protected theme = inject(ThemeService);
  protected nav = NAV;
  protected name = PROFILE.name;
  protected scrolled = false;
  protected menuOpen = false;
  protected active = '';
  private io?: IntersectionObserver;

  ngOnInit() {
    if (!('IntersectionObserver' in window)) return;
    this.io = new IntersectionObserver(
      entries => entries.forEach(e => { if (e.isIntersecting) this.active = e.target.id; }),
      { rootMargin: '-40% 0px -55% 0px' }
    );
    [...NAV.map(n => n.id), 'contact'].forEach(id => {
      const el = document.getElementById(id);
      if (el) this.io!.observe(el);
    });
  }

  ngOnDestroy() { this.io?.disconnect(); }

  @HostListener('window:scroll')
  onScroll() { this.scrolled = window.scrollY > 8; }

  @HostListener('document:keydown.escape')
  closeMenu() { this.menuOpen = false; }

  toggleMenu() { this.menuOpen = !this.menuOpen; }
}
