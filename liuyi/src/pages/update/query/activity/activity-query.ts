import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

@Component({
    selector: 'page-activity-query',
    templateUrl: 'activity-query.html'
})
export class ActivityQuery {

    queryItem: Array<{ data: string, score: number, type: string, detail: number }>;
    constructor(public navCtrl: NavController) {
        this.queryItem = [
            { data: "2016/12/24", score: 1367, type: "科学竞赛", detail: 1234 },
            { data: "2016/12/26", score: 1234, type: "知识竞赛", detail: 3114 }
        ]
    }

    onItemClick(item) {

    }

    pressEvent(item) {
        console.log('-----press-----'+ JSON.stringify(item));
        
    }

}
