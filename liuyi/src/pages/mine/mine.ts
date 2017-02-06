import { Component, OnInit, Compiler, AfterViewInit } from '@angular/core';
import { Storage } from '@ionic/storage';
import { NavController, App, ViewController } from 'ionic-angular';


//自定义插件
import { Istudy } from 'ionic-native'

import { LoginPage } from './login/login';
import {LoginService} from '../../providers/login.service/login.service';

import { MyAccountPage } from './myaccountF/myaccount';
import { MyAboutPage } from './myaboutF/myabout';
import { MyInfoPage } from './myinfoF/myinfo';
import { MySettingPage } from './mysettingF/mysetting';

@Component({
    selector: 'page-mine',
    templateUrl: 'mine.html'
})
export class MinePage implements OnInit, AfterViewInit {
  loginStatus: boolean;

    loginImg :string;
  loginAccount: string;

  deviceId: string;

  infoID:string;

    constructor(public navCtrl: NavController,
        public viewCtrl: ViewController,
        public storage: Storage,
        public app: App,
        public loginService: LoginService,
        ) {

    }

  _enterLogin() {
    if (this.loginService.isLoggedIn) {
      // this.navCtrl.push(MyInfoPage);
      this.app.getRootNav().push(MyInfoPage);
    }else{
      this.app.getRootNav().push(LoginPage);
    }
  }

_enterList(_num){
  if (_num==2) {
          this.app.getRootNav().push(MyAboutPage);
  } else {
          if (this.loginService.isLoggedIn) {
        // code...
        switch (_num) {
          case 1:
            // code...
            this.app.getRootNav().push(MySettingPage);

            break;

        }
      } else {
        this.app.getRootNav().push(LoginPage);
      }
  }
}




  logout() {
    this.loginService.logout();
  }


ngOnInit(): void {

    this.loginImg = "assets/source/img/logo.png";

    Istudy.getDeviceInfo().then(result => {

      this.deviceId = "DEVICE_ID";

      this.storage.set(this.deviceId, result.devId);

    });

  }

  ngAfterViewInit(): void {

    if (this.loginService.isLoggedIn) {
      this.loginService.getAccountInfo(callBack)
    }

    let _self = this;

    function callBack(result) {

      _self.loginStatus = _self.loginService.isLoggedIn;

      _self.loginImg = _self.loginService.isLoggedIn ? result.avatar : "assets/source/img/logo.png";

      _self.loginAccount = result.nicknm;

      _self.infoID="INFO_ID";
      _self.storage.set(_self.infoID,result);
      // 9999999999{"uuid":"a88121420d3d4e3383b65311e21334eb","nicknm":"白菜","gndr":0,"avatar":"http://oaa4szy4p.bkt.clouddn.com/FhyK08sdUwkl71bnBldyNGVN-HnP","rongyunToken":"2xxsm1gRsgvXb7PYgmgXz8O5+C6ckYlUzJczja0eV/fEwT2alkUXQhz6F2TdTcc6ETFdE8o1uaup75AdGRLX13qGCwVyvaEKdnG1bfZBz54VErwbhRmBZrzXWBYiN10MHGCAan28C20="}
    }
  }






    onShowViewStack() {

        console.log('---viewCtrl:' + this.navCtrl.getViews());
        console.log('---view stack:' + this.navCtrl.getViews().length);

        for (var view in this.navCtrl.getViews()) {
            console.log('----view:' + JSON.stringify(view));
        }
    }

    onTestClick() {
        // this.viewCtrl.dismiss();
        // this.app.getRootNav().push(TestPage);
    }

}
