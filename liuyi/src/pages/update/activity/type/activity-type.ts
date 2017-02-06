import { Component } from '@angular/core';

import { NavController, NavParams } from 'ionic-angular';

@Component({
    selector: 'page-type',
    templateUrl: 'activity-type.html'
})
export class ActivityType {

    activityType: Array<{ title: string, type: string }> = [];
    callback: any;
    constructor(public navCtrl: NavController,
        public params: NavParams) {
        this.callback = this.params.get("callback");
    }

    ngAfterViewInit() {
        this.activityType.push(
            { title: "科学竞赛", type: "数" },
            { title: "知识竞赛", type: "数" },
            { title: "庆典", type: "礼" },
            { title: "参观", type: "书" },
            { title: "体育竞赛", type: "射" },
            { title: "社会实践", type: "御" },
            { title: "公益", type: "礼" }
        );
    }

    onTypeClick(item) {
        // this.navCtrl.pop(item);
        this.callback(item).then(() => {
            this.navCtrl.pop();
        })
    }
}