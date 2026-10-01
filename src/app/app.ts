import { Component } from '@angular/core';
import { Navbar } from './components/navbar/navbar';
import { Hero } from './components/hero/hero';
import { About } from './components/about/about';
import { Projects } from './components/projects/projects';
import { Skills } from './components/skills/skills';
import { Experience } from './components/experience/experience';
import { Contact } from './components/contact/contact';

@Component({
  selector: 'app-root',
  imports: [Navbar, Hero, About, Projects, Skills, Experience, Contact],
  templateUrl: './app.html',
  styleUrl: './app.css'
})
export class App {}
