import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

import { LoginService } from '../../../providers/login.service/login.service';

import { TabsPage } from '../../tabs/tabs'

import {MyInfoPage} from '../myinfoF/myinfo'


@Component({
    selector: 'my-component',
    templateUrl: 'mysetting.html'
})
export class MySettingPage {
    constructor(
        public loginService: LoginService,
        public navCtrl: NavController
    ) {

    }


    _enterInfo(){
      this.navCtrl.push(MyInfoPage);
    }




    _quitApp() {
        this.loginService.logout();

        // this.navCtrl.pop();
        this.navCtrl.setRoot(TabsPage, { userParams: 3 });

    }
}