import { Component } from '@angular/core';
import { NavController, App } from 'ionic-angular';

import { ActivityQuery } from '../query/activity/activity-query';
import { ScorePage } from '../query/score/score';

@Component({
    selector: 'page-query',
    templateUrl: 'query.html'
})
export class QueryPage {

    queryItem: Array<{ title: string, item: string }>;
    constructor(public navCtrl: NavController,
        public app: App) {
        this.queryItem = [
            { title: "1", item: "所有活动" },
            { title: "2", item: "所有成绩" }
        ]
    }

    onItemClick(item) {
        if (item.title === "1") {
            // this.app.getRootNav().push(QueryPage);
            this.navCtrl.push(ActivityQuery);
        } else {
            this.navCtrl.push(ScorePage);
        }
    }

}
