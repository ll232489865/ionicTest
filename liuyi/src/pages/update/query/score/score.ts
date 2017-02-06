import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

@Component({
    selector: 'page-score',
    templateUrl: 'score.html'
})
export class ScorePage {

    subjectItem: Array<{ data: string, score: number, type: string, detail: any }>;
    constructor(public navCtrl: NavController) {
        this.subjectItem = [
            { data: "2016/12/24", score: 1367, type: "科学竞赛", detail: [{ subject: "math", score: 1234 }, { subject: "math", score: 123 }] },
            {
                data: "2016/12/26", score: 1234, type: "知识竞赛", detail: [{ subject: "math", score: 3114 }, { subject: "巴拉", score: 3114 }, { subject: 'english', score: 122 }, { subject: 'english', score: 122 },
                { subject: 'english', score: 122 },{ subject: 'english', score: 122 }]
            }
        ]
    }

    onItemClick(item) {

    }

}
