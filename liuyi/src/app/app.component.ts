import { Component } from '@angular/core';
import { Platform } from 'ionic-angular';
import { StatusBar, Splashscreen } from 'ionic-native';

import { UserData } from '../providers/user-data';
import { TutorialPage } from '../pages/tutorial/tutorial';
import { AdPage } from '../pages/ad/ad';


@Component({
  templateUrl: 'app.html'
})
export class MyApp {
  rootPage: any;

  constructor(
    platform: Platform,
    public userData: UserData
  ) {
    platform.ready().then(() => {
      // Okay, so the platform is ready and our plugins are available.
      // Here you can do any higher level native things you might need.
      StatusBar.styleDefault();
      Splashscreen.hide();
    });

    //Check if the user has already seen the tutorial
    this.userData.checkHasSeenTutorial().then(hasSeenTutorial => {
      if (hasSeenTutorial === null) {
        this.rootPage = TutorialPage;
      } else {
        this.rootPage = AdPage;
      }
    })
  }
}
