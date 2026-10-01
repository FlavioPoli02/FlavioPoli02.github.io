import { Directive, ElementRef, Input, OnDestroy, OnInit, inject } from '@angular/core';

/** Fade/slide-in alla prima comparsa nel viewport. Senza IntersectionObserver o con reduced-motion il contenuto resta visibile. */
@Directive({ selector: '[appReveal]', standalone: true })
export class Reveal implements OnInit, OnDestroy {
  /** Ritardo in ms, per sfalsare elementi vicini. */
  @Input() revealDelay = 0;

  private el = inject<ElementRef<HTMLElement>>(ElementRef).nativeElement;
  private io?: IntersectionObserver;

  ngOnInit() {
    if (typeof matchMedia !== 'function' || matchMedia('(prefers-reduced-motion: reduce)').matches || !('IntersectionObserver' in window)) return;
    this.el.style.setProperty('--d', `${this.revealDelay}ms`);
    this.el.classList.add('reveal');
    this.io = new IntersectionObserver(([e]) => {
      if (e.isIntersecting) {
        this.el.classList.add('reveal-in');
        this.io?.disconnect();
      }
    }, { threshold: 0.12, rootMargin: '0px 0px -6% 0px' });
    this.io.observe(this.el);
  }

  ngOnDestroy() { this.io?.disconnect(); }
}
