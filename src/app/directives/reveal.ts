import { Directive, ElementRef, OnDestroy, OnInit, inject } from '@angular/core';

/** Fade/slide-in alla prima comparsa nel viewport. Senza JS o con reduced-motion il contenuto resta visibile. */
@Directive({ selector: '[appReveal]', standalone: true })
export class Reveal implements OnInit, OnDestroy {
  private el = inject<ElementRef<HTMLElement>>(ElementRef).nativeElement;
  private io?: IntersectionObserver;

  ngOnInit() {
    if (typeof matchMedia !== 'function' || matchMedia('(prefers-reduced-motion: reduce)').matches || !('IntersectionObserver' in window)) return;
    this.el.classList.add('reveal');
    this.io = new IntersectionObserver(([e]) => {
      if (e.isIntersecting) {
        this.el.classList.add('reveal-in');
        this.io?.disconnect();
      }
    }, { threshold: 0.12 });
    this.io.observe(this.el);
  }

  ngOnDestroy() { this.io?.disconnect(); }
}
