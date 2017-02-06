import { Component } from '@angular/core';
import { NavController, App, NavParams } from 'ionic-angular';
import { Camera } from 'ionic-native';

import { ActivityType } from './type/activity-type';
import { CustomItem } from './custom/custom-item';

@Component({
    selector: 'page-activity',
    templateUrl: 'activity.html'
})
export class ActivityPage {

    activityImage: Array<{ title: string, image: string }>;
    callback: any;
    _params: any;
    constructor(
        public navCtrl: NavController,
        public app: App,
        public params: NavParams
    ) {
        this._params = "科技竞赛";
        this.callback = (_params) => {
            return new Promise((resolve, reject) => {
                console.log('-----callback------' + JSON.stringify(_params));
                this._params = _params.title;
                resolve();
            })
        }

        this.activityImage = [
            { title: 'first', image: "assets/img/avatar-ts-jessie.png" },
            { title: 'second', image: "assets/img/avatar-ts-potatohead.png" },
            { title: 'third', image: "assets/img/avatar-ts-rex.png" }
        ];
    }

    onSubmit() {
        console.log('-=>submit');
        this.navCtrl.pop();

    }

    onActivityType() {
        this.app.getRootNav().push(ActivityType, {
            callback: this.callback
        });
    }

    onCustomItem() {
        this.app.getRootNav().push(CustomItem);
    }

    onImageClick(item) {

        if (item.title == 'third') {
            console.log('---third---');
            this.openCamera();

        } else {
            let i, j;
            for (i = 0; i < this.activityImage.length; i++) {
                console.log('----i---:' + i);
                if (item === this.activityImage[i]) {
                    console.log('----->' + this.activityImage);
                    j = i;
                }
            }
            console.log('----activity:' + this.activityImage.splice(j, 1));
        }
    }

    openCamera() {

        Camera.getPicture({ targetWidth: 100, targetHeight: 100 }).then((imageData) => {
            // imageData is either a base64 encoded string or a file URI
            //I/chromium: [INFO:CONSOLE(52678)] "-----base64Image:data:image/jpeg;base64,file:///storage/emulated/0/Android/data/com.ionicframework.liuyi847727/cache/1483519418815.jpg", source: http://192.168.1.119:8100/build/main.js (52678)
            // If it's base64:
            let base64Image = 'data:image/jpeg;base64,' + imageData;
            console.log('-----base64Image:' + base64Image);

        }, (err) => {
            // Handle error
            console.log('something error');

        });
    }

}
