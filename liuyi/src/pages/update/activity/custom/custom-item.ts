import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

@Component({
    selector: 'page-custom',
    templateUrl: 'custom-item.html'
})
export class CustomItem {

    constructor(public navCtrl: NavController) {

    }

    onSubmit() {
        this.navCtrl.pop();
    }

}
