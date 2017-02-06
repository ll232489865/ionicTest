import { Component } from '@angular/core';

import { NavController, App } from 'ionic-angular';

import { ActivityPage } from './activity/activity';
import { QueryPage } from './query/query';
import { ScoreAdd } from './score/score-add';

@Component({
    selector: 'page-update',
    templateUrl: 'update.html'
})
export class UpdatePage {

    constructor(public navCtrl: NavController,
        public app: App) {

    }

    onScoreDetail() {
        this.app.getRootNav().push(QueryPage);
    }

    onActivity() {
        this.app.getRootNav().push(ActivityPage);
    }

    onScoreAdd() {
        this.app.getRootNav().push(ScoreAdd);
    }

    onSelfAssessing() {

    }
}
