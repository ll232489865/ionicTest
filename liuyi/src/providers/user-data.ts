import { Injectable } from '@angular/core';

import { Storage } from '@ionic/storage';

@Injectable()
export class UserData {

    HAS_SEEN_TUTORIAL = "hasSeenTutorial";

    constructor(
        public storage: Storage
    ) { }

    checkHasSeenTutorial() {
        return this.storage.get(this.HAS_SEEN_TUTORIAL).then(value => {
            return value;
        })
    }
}