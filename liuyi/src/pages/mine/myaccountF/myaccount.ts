import { Component} from '@angular/core';

import { NavController } from 'ionic-angular';


@Component({
    selector: 'my-component',
    templateUrl: 'myaccount.html'
})
export class MyAccountPage {
    constructor(

     public NavController:NavController
     ){
        // this.ac="首页";
    }
    // ac:any;


}
