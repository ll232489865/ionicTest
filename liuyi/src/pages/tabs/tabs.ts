import { Component ,ViewChild} from '@angular/core';

import { NewsPage } from '../news/news';
import { UpdatePage } from '../update/update';
import { ShowPage } from '../show/show';
import { MinePage } from '../mine/mine';

import { NavParams, Tabs } from 'ionic-angular'

@Component({
  templateUrl: 'tabs.html'
})
export class TabsPage {
  // this tells the tabs component which Pages
  // should be each tab's root Page

  newsRoot: any = NewsPage;
  updateRoot: any = UpdatePage;
  showRoot: any = ShowPage;
  mineRoot: any = MinePage;

tabCurrent: any = 999;

  @ViewChild(Tabs) tabs: Tabs;
  constructor(public params: NavParams) {

    console.log('-----tabsPage-----' + this.params.get('userParams'));

    if (this.params.get('userParams')) {
      this.tabCurrent = this.params.get('userParams');
    }
  }

  ionViewDidEnter() {
    console.log('-----didEnter' + this.tabCurrent);
    if (this.tabCurrent != 999) {
      this.tabs.select(this.tabCurrent);
      this.tabCurrent=999;
    }
  }
}
