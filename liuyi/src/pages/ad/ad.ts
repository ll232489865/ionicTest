import { Component } from '@angular/core';
import { NavController, App, ViewController } from 'ionic-angular';

import { TabsPage } from '../tabs/tabs';

@Component({
    selector: 'page-ad',
    templateUrl: 'ad.html'
})
export class AdPage {

    constructor(public navCtrl: NavController,
        public viewCtrl: ViewController,
        public app: App) {

    }

    startApp() {
        this.app.getRootNav().push(TabsPage);
        this.navCtrl.removeView(this.viewCtrl);

        // this.navCtrl.setRoot(TabsPage);
    }

}
