import { Component } from '@angular/core';

import { NavController, ViewController } from 'ionic-angular';

import { Storage } from '@ionic/storage'

//model
import { model_loginResult } from '../../../providers/login.service/login.model'

import { LoginService } from '../../../providers/login.service/login.service';

import { TabsPage } from '../../tabs/tabs'


@Component({
    selector: 'page-login',
    templateUrl: 'login.html'
})

export class LoginPage {
    constructor(
        public loginService: LoginService,
        public navCtrl: NavController,
        public storage: Storage
    ) { }

    _login(account, password) {
        this.loginService.login(account, password, callBack)

        let _self = this;
        function callBack(result) {

            _self.storage.set("SESSION", result);

            if (_self.loginService.isLoggedIn) {
                // _self.navCtrl.pop();
                _self.navCtrl.setRoot(TabsPage, {userParams:3});
                //   _self.viewCtrl.dismiss();
            }
        }

    }
}