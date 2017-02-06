import { Component } from '@angular/core';

import { NavController } from 'ionic-angular';

@Component({
    selector: 'page-score-add',
    templateUrl: 'score-add.html'
})
export class ScoreAdd {

    subjectItem: Array<{ subject: string, score: number }>;
    constructor(public navCtrl: NavController) {
        this.subjectItem = [
            { subject: "数学", score: 123 },
            { subject: "艺术", score: 111 },
            { subject: "英语", score: 122 },
            { subject: "国学", score: 131 },
            { subject: "经济", score: 121 },
            { subject: "生物", score: 111 },
            { subject: "中文小说阅读", score: 112 }
        ]
    }

    onSubmit() {
        console.log('-----item' + JSON.stringify(this.subjectItem));
        this.navCtrl.pop();
    }

    ngAfterContentChecked() {
        
    }

}
