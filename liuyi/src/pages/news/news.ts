import { Component } from '@angular/core';

import { NavController,App } from 'ionic-angular';
import { NewsDetail } from './newsDetail';
import { BPages } from './bannerpages';
@Component({
    selector: 'page-news',
    templateUrl: 'news.html',
    styles : [`
      .toolbar-title-ios{text-align:left;}
    `]
})
export class NewsPage {

    constructor(public navCtrl: NavController,
                public app:App) 
                { }
bannerClick(){
  this.app.getRootNav().push(BPages);
}
clickAvatarList(){
        this.app.getRootNav().push(NewsDetail);
    }
slides = [
    {
      image: "assets/img/gate.png",
    },
    {
      image: "assets/img/bigroom.png",
    },
    {
      image: "assets/img/titles.jpg",
    }
  ];
  // arr=[1,2,3,4]
  avatarList = [
    {
      image: "assets/img/avatar-ts-jessie.png",
    },
    {
      image: "assets/img/avatar-ts-potatohead.png",
    },
    {
       image: "assets/img/avatar-ts-rex.png",
    } 
  ];
  titleArr =["中国特色","国际六艺","孔子后裔","文化遗产"];
}
