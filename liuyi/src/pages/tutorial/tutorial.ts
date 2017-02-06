import { Component } from '@angular/core';
import { App, ViewController, NavController } from 'ionic-angular';
import { Storage } from '@ionic/storage';
import { TabsPage } from '../tabs/tabs';

export interface Slide {
    title: string;
    description: string;
    image: string;
}

@Component({
    selector: 'page-tutorial',
    templateUrl: 'tutorial.html'
})

export class TutorialPage {
    slides: Slide[];
    showSkip = true;

    constructor(
        public app: App,
        public navCtrl: NavController,
        public viewCtrl: ViewController,
        public storage: Storage) {
        this.slides = [
            {
                title: 'Welcome to <b>ICA</b>',
                description: 'The <b>Ionic Conference App</b> is a practical preview of the Ionic Framework in action, and a demonstration of proper code use.',
                image: 'assets/img/ica-slidebox-img-1.png',
            },
            {
                title: 'What is Ionic?',
                description: '<b>Ionic Framework</b> is an open source SDK that enables developers to build high quality mobile apps with web technologies like HTML, CSS, and JavaScript.',
                image: 'assets/img/ica-slidebox-img-2.png',
            },
            {
                title: 'What is Ionic Platform?',
                description: 'The <b>Ionic Platform</b> is a cloud platform for managing and scaling Ionic apps with integrated services like push notifications, native builds, user auth, and live updating.',
                image: 'assets/img/ica-slidebox-img-3.png',
            }
        ];
    }

    startApp() {
        this.storage.set('hasSeenTutorial', 'true');
        this.navCtrl.setRoot(TabsPage);
    }

    startAppWithoutSave() {
        this.navCtrl.setRoot(TabsPage);
    }
    
    onSlideChangeStart(slider) {
        this.showSkip = !slider.isEnd;
    }
}